package com.trinhquycong.controller.common;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.trinhquycong.component.Constants;
import com.trinhquycong.entity.User;

public abstract class BaseController {

	/**
	 * tất cả các controller mà extends từ đây
	 * thì các action sẽ luôn sẵn loginedUser
	 * @return
	 */
	@ModelAttribute("loginedUser")
	public User getLoginedUser() {
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(loginedUser != null && loginedUser instanceof UserDetails)
			return (User) loginedUser;
		
		return null;
	}
	
		
	private List<String> getAllRoles() {
		List<String> roles = new ArrayList<>();
		User logined = getLoginedUser();
		
		if(logined == null) return roles;
		for(com.trinhquycong.entity.Role r : logined.getRoles()) {
			roles.add(r.getAuthority());
		}
		
		return roles;
	}
		
	//@ModelAttribute("isAdmin")
	public boolean isAdmin() {
		for(String role : getAllRoles()) {
			if(role.equalsIgnoreCase(Constants.ROLE_ADMIN)) return true;
		}
		return false;
	}
	
	@ModelAttribute("isUser")
	public boolean isUser() {
		for(String role : getAllRoles()) {
			if(role.equalsIgnoreCase(Constants.ROLE_CUSTOMER)) return true;
		}
		return false;
	}
	
	//@ModelAttribute("isManager")
	public boolean isManager() {
		for(String role : getAllRoles()) {
			if(role.equalsIgnoreCase(Constants.ROLE_MANAGER)) return true;
		}
		return false;
	}
}
