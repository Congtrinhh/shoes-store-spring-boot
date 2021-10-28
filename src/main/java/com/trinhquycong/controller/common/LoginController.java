package com.trinhquycong.controller.common;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController  { // extend basecon
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String getLoginPage(HttpServletRequest request) {
		
		// nếu người dùng vừa đăng ký thành công, lấy ra thông báo thành công
		String registerSuccessfullyMsg = (String) request.getSession().getAttribute("registerSuccessfullyMessage");
		// xóa đi thông báo này trong session
		request.getSession().setAttribute("registerSuccessfullyMessage", null);
		// add vào request để hiển thị trong trang login.jsp
		request.setAttribute("registerSuccessfullyMessage", registerSuccessfullyMsg);
		
		
		return "common/login";
	}
	
	/**
	 * trả về trang admin hay trang chủ, tùy vào role
	 * @return
	 */
}
