package com.trinhquycong.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trinhquycong.controller.common.BaseController;

@Controller
@RequestMapping("/admin")
public class DashboardController extends BaseController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String getPage() {
		return "admin/dashboard";
	}
	
}
