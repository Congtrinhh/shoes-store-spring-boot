package com.trinhquycong.controller.user;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.trinhquycong.component.Constants;
import com.trinhquycong.component.Utilities;
import com.trinhquycong.entity.District;
import com.trinhquycong.entity.Province;
import com.trinhquycong.entity.SaleOrder;
import com.trinhquycong.entity.User;
import com.trinhquycong.entity.Ward;
import com.trinhquycong.service.CheckoutService;
import com.trinhquycong.service.SaleOrderService;

@Controller
public class CheckoutController {
	@Autowired
	private CheckoutService checkoutService;

	@Autowired
	private SaleOrderService saleOrderService;

	@RequestMapping(value = "/checkout", method = RequestMethod.POST)
	public String createSaleOrder(HttpServletRequest request, Model model, @ModelAttribute("user") User user,
			@RequestParam("specific-address") String specificAddress, @RequestParam("ward") Integer wardId) {

		String message = null;

		SaleOrder saleOrder = new SaleOrder();

		try {
			
			Map<String, Object> rs = checkoutService.setUpSaleOrder(request, model, saleOrder, user, message, wardId, specificAddress);
			
			message = (String) rs.get("message");
			
			saleOrderService.saveOrUpdate(saleOrder);
			
			request.getSession().setAttribute("cart", null);
			request.getSession().setAttribute("successfulMessage", "Đặt hàng thành công, chúng tôi sẽ gửi email xác nhận cho bạn trong giây lát");
			
			checkoutService.sendEmail(saleOrder);
			
		} catch (IllegalArgumentException e) {
			// trả về trang checkout kèm tb lỗi để người dùng tiếp tục hoàn thiện form
			message = e.getMessage();
			user.setAddress(null); // để file js hiển thi thêm input nhập địa chỉ mới
			model.addAttribute("errorMessage", message);
			return "user/checkout";
		}
		catch (SQLException e) {
			// trả lại thông báo lỗi: không đủ số lượng
			message=e.getMessage();
		}
		catch (Exception e) {
			// trả lại thông báo lỗi: giỏ hàng trống
			message = e.getMessage();
		}
		request.getSession().setAttribute("message", message);

		return "user/checkout";
	}

	@RequestMapping(value = "/checkout", method = RequestMethod.GET)
	public String toCheckoutPage(Model model, HttpServletRequest request) {
				
		// reset thông báo đặt hàng thành công/thất bại
		request.getSession().setAttribute("successfulMessage", null);
		request.getSession().setAttribute("message", null);
		
		// nếu có người dùng, đẩy thông tin người dùng xuống model
		User user = Utilities.getLoginedUser();
		if (user != null) {

			// nếu đã đăng nhập, thì phải là CUSTOMER,
			// ADMIN, MANAGER,.. ra chỗ khác chơi
			try {
				for (GrantedAuthority auth : user.getAuthorities()) {
					if (Constants.ROLE_CUSTOMER.equals(auth.getAuthority()) == false) {
						throw new Exception("Bạn phải là một khách hàng");
					}
					break;
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
				model.addAttribute("errorMessage", e.getMessage());
				return "common/badUser"; // dùng tạm để báo lỗi
			}

			// thỏa mãn là CUSTOMER, tiếp tục..

		} else {
			user = new User();
		}

		List<Province> provinces = checkoutService.getAllProvince();

		model.addAttribute("provinces", provinces);

		model.addAttribute("user", user);

		// để hiển thị thông báo lỗi/thành công sau khi kích nút confirm mua hàng

		return "user/checkout";
	}

	@RequestMapping(value = "/ajax/checkout/district", method = RequestMethod.GET)
	public ResponseEntity<Object> getDistricts(@RequestParam("provinceId") Integer dId) {

		List<District> districts = checkoutService.getAllDistrict(dId);

		return ResponseEntity.ok(districts);
	}

	@RequestMapping(value = "/ajax/checkout/ward", method = RequestMethod.GET)
	public ResponseEntity<Object> getWards(@RequestParam("districtId") Integer wId) {

		List<Ward> wards = checkoutService.getAllWard(wId);

		return ResponseEntity.ok(wards);
	}

}
