package com.trinhquycong.component;


import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import com.github.slugify.Slugify;
import com.trinhquycong.entity.User;

public class Utilities {
	public static String slugify(String productName) {
		return new Slugify().slugify(productName);
	}
	
	public static Integer parseInteger(String value) {
		try {
			return Integer.parseInt(value);
		}
		catch (Exception e) {
			return null;
		}
	}
	
	public static boolean notEmptyString (String str) {
		return (str!=null && str.length()>0)? true : false;
	}
	
	public static List<String> getExceptionMessageChain(Throwable throwable) {
	    List<String> result = new ArrayList<>();
	    while (throwable != null) {
	        result.add(throwable.getMessage());
	        throwable = throwable.getCause();
	    }
	    return result; //["THIRD EXCEPTION", "SECOND EXCEPTION", "FIRST EXCEPTION"]
	}
	
	public static User getLoginedUser() {
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if(loginedUser != null && loginedUser instanceof UserDetails)
			return (User) loginedUser;
		
		return null;
	}
}
