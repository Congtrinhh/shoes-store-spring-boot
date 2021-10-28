package com.trinhquycong.service;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.PersistenceException;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.trinhquycong.component.Utilities;
import com.trinhquycong.dto.UserSearchModel;
import com.trinhquycong.entity.District;
import com.trinhquycong.entity.Province;
import com.trinhquycong.entity.Role;
import com.trinhquycong.entity.User;
import com.trinhquycong.entity.Ward;

@Service
public class UserService extends BaseService<User> {
	
	@Autowired
	private CheckoutService checkoutService;
	
	@Override
	protected Class<User> clazz() {
		return User.class;
	}
	
	/**
	 * dang nhap
	 * @param userName
	 * @return
	 */
	public User loadUserByUsername(String userName) throws UsernameNotFoundException {
		String sql = "select * from user u where u.username = '" + userName + "'";
		List<User> users = this.runTransactQuerySQL(sql, 0, null).getData();
		
		if(users == null || users.size() <= 0) {
			throw new UsernameNotFoundException("Tên tài khoản hoặc mật khẩu không chính xác");
		}
		
		User user = users.get(0);
		
		if (user.getStatus()==false) {
			throw new UsernameNotFoundException("Tài khoản chưa được kích hoạt");
		}
		
		return user;
	}
	
	/**
	 * đăng ký
	 */
	public String getEncodedPassword(String plainPassword) {
		return new BCryptPasswordEncoder(10).encode(plainPassword);
	}
	
	@Transactional
	public User updateUser(User user, HttpServletRequest request) throws PersistenceException  {
		
		User userFromDB = this.getById(user.getId());
		
		// handle address
		if (wantToChangeAddress(request)) {
			String specificAddress = request.getParameter("specific-address");
			Integer wardId = Utilities.parseInteger(request.getParameter("ward"));
			
			Ward ward = checkoutService.getWardById(wardId);
			District district = checkoutService.getDistrictById(ward.getDistrictId());
			Province province= checkoutService.getProvinceById(ward.getProvinceId());
			
			String finalAddress = specificAddress + ", " + ward.getName() + ", " + district.getName() + ", " + province.getName();
			
			user.setAddress(finalAddress);
		}
		else {
			user.setAddress(userFromDB.getAddress());
		}
		 
		// handle password
		if (wantToChangePassword(request)) {
			String currentPassword = request.getParameter("current-password");
			String newPassword = request.getParameter("new-password");
			
			BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder(10);
			String hashedPassword = userFromDB.getPassword();
			// password nhập từ bàn phím có giống trong DB
			boolean match = bcrypt.matches(currentPassword, hashedPassword);
			
			if (match) {
				String newHashedPassword = bcrypt.encode(newPassword);
				user.setPassword(newHashedPassword);
			} else {
				user.setPassword(userFromDB.getPassword());
				request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác");
			}
		}
		else {
			user.setPassword(userFromDB.getPassword());
		}
		
		user.setRoles(userFromDB.getRoles());
		user.setCreatedDate(userFromDB.getCreatedDate());
		user.setUpdatedDate(new Date());
		user.setStatus(userFromDB.getStatus());
		

		return this.saveOrUpdate(user);
		
	}
	
	@Transactional
	public User createUser(User user, Role userRole) throws PersistenceException {
		String hashedPassword = this.getEncodedPassword(user.getPassword());
		
		user.setPassword(hashedPassword);
		user.setCreatedDate(new Date());
		user.addRole(userRole);
		
		return this.saveOrUpdate(user);
	}
		
	@Transactional
	public User updateUserForAdmin(User user, Role role) throws PersistenceException  {
		
		User userFromDB = this.getById(user.getId());
		 
		
		// khởi tạo encoder
		BCryptPasswordEncoder bcrypt = new BCryptPasswordEncoder(10);
	
		// băm password và set
		String newHashedPassword = bcrypt.encode(user.getPassword());
		user.setPassword(newHashedPassword);
	
		
		// vì có khả năng tham số role là null
		if (role!=null) {
			java.util.Set<Role> roles = new HashSet<>();
			roles.add(role);
			user.setRoles(roles);			
		} else {
			user.setRoles(userFromDB.getRoles());
		}
		
		user.setCreatedDate(userFromDB.getCreatedDate());
		user.setUpdatedDate(new Date());
		user.setStatus(userFromDB.getStatus());

		return this.saveOrUpdate(user);
	}
	
	/**
	 * ----------------SEARCH----------------
	 * @param searchModel
	 * @return
	 */
	public PagerData<User> search(UserSearchModel searchModel){
		// vì ta cần lấy cả dữ liệu từ bảng ROLE VÀ USER_ROLE
		String sql = "select * from user u join user_role ur on u.id=ur.user_id join role r on r.id=ur.role_id where 1=1";
		if (searchModel != null) {

			// theo username
			if (searchModel.getUsername()!=null) {
				sql += " and u.username like '%" + searchModel.getUsername() + "%'";
			}
			
			// theo email			
			if (searchModel.getEmail()!=null) {
				sql += " and u.email like '%" + searchModel.getEmail()+ "%'";
			}
			
			// tìm theo role: admin/manager/customer
			if (Utilities.notEmptyString(searchModel.getRoleName())) {
				sql += " and r.name='" + searchModel.getRoleName() + "'";
			}
			
			// theo status
			if (searchModel.getStatus()!=null) {
				if(searchModel.getStatus().equals(true)) {
					sql += " and u.status=true";
				}else {
					sql += " and u.status=false";
				}
			}

		}

		return runTransactQuerySQL(sql, searchModel == null ? 0 : searchModel.getPage(),
				searchModel == null ? null : searchModel.getSop());
	}
	
	public boolean wantToChangeAddress(HttpServletRequest request) {
		String specificAddress = request.getParameter("specific-address");
		String wardIdStr = request.getParameter("ward");
		if ( (wardIdStr!=null && wardIdStr.length()>0) && (specificAddress!=null && specificAddress.length()>0) ) {
			return true;
		}
		
		return false;
	}
	
	public boolean wantToChangePassword(HttpServletRequest request) {
		String currentPassword = request.getParameter("current-password");
		String newPassword = request.getParameter("new-password");
		String newPasswordConfirm = request.getParameter("confirmed-password");
		
		if (currentPassword==null || currentPassword.length()==0) {
			return false;
		}
		if (newPassword==null || newPassword.length()==0) {
			return false;
		}
		if (newPasswordConfirm==null || newPasswordConfirm.length()==0) {
			return false;
		}
		
		return true;
	}

	@Transactional
	public void deactivateById(Integer id) {
		
		User user = super.getById(id);
		
		user.setStatus(false);
		
		super.saveOrUpdate(user);
		
	}
	
	public Role getFirstRole(Set<Role> roles) {
		Role role = null;
		for (Role r : roles) {
			role = r;
			break;
		}
		return role;
	}
	
	/**
	 * CRUD manager
	 */
	
}
