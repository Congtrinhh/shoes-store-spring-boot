package com.trinhquycong.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.PersistenceException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.trinhquycong.component.Constants;
import com.trinhquycong.component.Utilities;
import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.UserSearchModel;
import com.trinhquycong.entity.Role;
import com.trinhquycong.entity.User;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.RoleService;
import com.trinhquycong.service.UserService;

@Controller
public class UserAdminController extends BaseController{

	/**
	 * CRUD user với role MANAGER
	 */
	@Autowired
	private UserService userService;

	@Autowired
	private RoleService roleService;

	/**
	 * liệt kê 3 loại user: admin/manager/customer
	 * 
	 * @param model
	 * @param searchModel
	 * @return
	 */
	@RequestMapping(value = "/admin/user/list", method = RequestMethod.GET)
	public String toGetAllPage(Model model, @ModelAttribute("searchModel") UserSearchModel searchModel) {

		PagerData<User> usersWithPaging = userService.search(searchModel);
		List<Role> roles = roleService.findAll();

		model.addAttribute("usersWithPaging", usersWithPaging);
		model.addAttribute("searchModel", searchModel);
		model.addAttribute("roles", roles);
		model.addAttribute("loginedUser", Utilities.getLoginedUser());

		return "admin/userList";
	}

	/**
	 * Tạo mới: manager/customer
	 */
	@RequestMapping(value = "/admin/user/create", method = RequestMethod.GET)
	public String toCreateOnePage(Model model) {

		User user = new User();
		user.setStatus(true);
		List<Role> roles = roleService.findAll();

		model.addAttribute("user", user);
		model.addAttribute("roles", roles);

		return "admin/userCreateOrUpdate";
	}

	/**
	 * Nếu ông được thêm/cập nhật là admin vì sao biết cần thêm/update admin? -> khi
	 * thêm: dựa vào role-name param -> khi sửa: dựa vào role hiện tại mà user đang
	 * giữ - chứ không phải role-name param 1. cập nhật: -> nếu id ông cần update =
	 * id đang đăng nhập hiện tại thì cho phép cập nhật (update chính bản thân) (id
	 * trong spring form VS id đang login) -> nếu khác id, tb lỗi 2. thêm: -> nếu
	 * trong db có ít hơn sl admin max thì cho phép thêm -> ngược lại, đưa ra tb lỗi
	 * 
	 * @param model
	 * @param user
	 * @param roleName
	 * @return
	 */
	@RequestMapping(value = "/admin/user/create-or-update", method = RequestMethod.POST)
	public String createOrUpdateOne(Model model, @ModelAttribute("user") User user,
			@RequestParam("role-name") String roleName) {
		
		String message = null;

		// thêm
		try {
			
			// lấy ra role từ request
			Role newRole = roleService.findByRoleName(roleName);
			
			if (user.getId() == null || user.getId() <= 0) {


				if (newRole != null) {

					// đối tượng cần thêm có role là ADMIN
					if (newRole.getName().equals(Constants.ROLE_ADMIN)) {
						// nếu sl lơn hơn max -> không cho thêm, ngược lại cho thêm như thường
						if (newRole.getUsers().size() > Constants.MAX_TOTAL_ADMIN) {
							message = "Số admin đã đạt mức tối đa (" + Constants.MAX_TOTAL_ADMIN
									+ "), không thể tạo thêm";

							List<Role> roles = roleService.findAll();
							model.addAttribute("roles", roles);

							return "admin/userCreateOrUpdate";
						}
					}

				}
				userService.createUser(user, newRole);
			}

			// cập nhật
			else {
				
				User userFromDB = userService.getById(user.getId());
				String roleNameFromDB = userService.getFirstRole(userFromDB.getRoles()).getName();
				
				if ( roleNameFromDB.equals(Constants.ROLE_ADMIN)) {
					User loginedUser = Utilities.getLoginedUser();
					
					// chỉ cho phép admin tự sửa thông tin chính mình  
					if (user.getId().equals(loginedUser.getId())) {
						// admin không được đổi role - admin vẫn là adminz
						userService.updateUserForAdmin(user, null);
					}else {
						throw new IllegalStateException("Không thể cập nhật thông tin admin khác, admin chỉ có quyền cập nhật thông tin chính mình");
					}
					
				} else {
					userService.updateUserForAdmin(user, newRole);
				}
				
			}

		} catch (PersistenceException e) {
			// lấy ra tất cả message lỗi trong exception object
			List<String> detailMessages = Utilities.getExceptionMessageChain(e);
			String finalErrorMessage = detailMessages.get(detailMessages.size() - 1); // lấy msg cuối

			if (finalErrorMessage.contains("email")) {
				message = "Email này đã tồn tại";
			} else if (finalErrorMessage.contains("username")) {
				message = "Username này đã tồn tại";
			}

			model.addAttribute("errorMessage", message);

			// reset password trước khi đẩy về view
			user.setPassword(null);
			user.setConfirmedPassword(null);

		}
		catch (IllegalStateException e) {
			message = e.getMessage();
			model.addAttribute("errorMessage", message);
			// reset password trước khi đẩy về view
			user.setPassword(null);
			user.setConfirmedPassword(null);
		}
		catch (Exception e) {
			message = "Đăng ký/cập nhật thất bại, hệ thống gặp lỗi";
			model.addAttribute("errorMessage", message);
			// reset password trước khi đẩy về view
			user.setPassword(null);
			user.setConfirmedPassword(null);
		}


		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		
		return "admin/userCreateOrUpdate";
	}

	@RequestMapping(value = "/admin/user/update/{id}", method = RequestMethod.GET)
	public String getUpdateOnePage(Model model, @PathVariable("id") Integer id) {
		User user = userService.getById(id);
		if (user != null) {
			model.addAttribute("user", user);

			List<Role> roles = roleService.findAll();
			model.addAttribute("roles", roles);
		}

		return "admin/userCreateOrUpdate";
	}
	
	@RequestMapping(value = "/admin/user/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable("id") Integer id) {
		if (!id.equals(null)) {
			userService.deactivateById(id);
		}
		
		Map<String, Object> rs = new HashMap<>();
		
		rs.put("id", id);
		
		return ResponseEntity.ok(rs);
	}
	
}
