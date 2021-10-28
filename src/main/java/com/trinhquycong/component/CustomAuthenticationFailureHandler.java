package com.trinhquycong.component;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String message = null;
		
		List<String> detailMessages = Utilities.getExceptionMessageChain(exception);
		message = detailMessages.get(detailMessages.size()-1);
		
		this.setDefaultFailureUrl("/login?error=true");
		
		if (exception.getMessage().equalsIgnoreCase("User is disabled")) {
			message = "Tài khoản chưa được kích hoạt";
		} else if (exception.getMessage().equalsIgnoreCase("User account has expired")) {
			message = "Tài khoản đã hết hạn";
		} else {
			message = "Đăng nhập không thành công, có thể do:\n\t1. Tài khoản hoặc mật khẩu không chính xác\n\t2. Tài khoản chưa được kích hoạt";
		}
		
		request.setAttribute("errorMessage", message);
		
		super.onAuthenticationFailure(request, response, exception);
		
		request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, message);
		
	}
}
