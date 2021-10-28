package com.trinhquycong.controller.common;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MyErrorController implements ErrorController {

	@Override
	public String getErrorPath() {
		// TODO Auto-generated method stub
		return null;
	}

	@RequestMapping("/error")
	public String handleError(HttpServletRequest request) {
		Object status =request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		String errorMsg = null;
		
		if (status!=null) {
			Integer code = Integer.valueOf(status.toString());
			
			switch (code) {
			case 404:
				errorMsg = "404 - Trang không tồn tại";
				break;
			case 400:
				errorMsg = "400 - Bad request";
				break;
			case 403:
				errorMsg = "403 - Access denied";
				break;

			default:
				errorMsg = "Đã có lỗi xảy ra với hệ thống";
				break;
			}
		}
		
		request.setAttribute("errorMessage", errorMsg);
		return "common/error";
	}
	
	/**
	 * Hiển thị tb lỗi khi kích hoạt tk
	 * @param request
	 * @return
	 */
	@RequestMapping("/login-error")
	public ModelAndView getLoginErrorPage(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("common/badUser");
		
		// get attr từ session
		String errorMessage = (String) request.getSession().getAttribute("errorMessage");
		
		// reset attr trong session
		request.getSession().removeAttribute("errorMessage");
		
		
		mav.addObject("errorMessage", errorMessage);
		return mav;
	}

	/**
	 * khi kích hoạt tk thành công
	 * @return
	 */
	@RequestMapping("/activated-account-successfully")
	public String getSuccessfulPage() {
		return "common/activatedSuccessfully";
	}

}
