package com.trinhquycong.controller.user;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.entity.Contact;
import com.trinhquycong.service.ContactService;

@Controller
public class ContactController extends BaseController {
	@Autowired 
	private ContactService service;
	
	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public ModelAndView getPage() {
		ModelAndView modelAndView = new ModelAndView("user/contact");
		modelAndView.addObject("contact", new Contact());
		return modelAndView;
	}
	
	@RequestMapping(value = "/contact", method = RequestMethod.POST)
	public ModelAndView saveContact(@ModelAttribute Contact contact) {
		ModelAndView modelAndView = new ModelAndView("user/contact");
		if (contact!=null) {
			contact.setCreatedDate(new Date());
			service.saveOrUpdate(contact);
			modelAndView.addObject("message", "Bạn đã gửi thông tin liên hệ thành công");
		} else {
			modelAndView.addObject("message", "Gửi thông tin liên hệ thất bại, vui lòng thử lại");
		}
		
		contact.setMessage(null);
		
		return modelAndView;
	}
}
