package com.trinhquycong.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.ContactSearchModel;
import com.trinhquycong.entity.Contact;
import com.trinhquycong.service.ContactService;
import com.trinhquycong.service.PagerData;

@Controller
public class ContactAdminController extends BaseController {
	@Autowired
	private ContactService contactService;
	
	/** danh sách contact
	 */
	@RequestMapping(value = "/admin/contact/list", method = RequestMethod.GET)
	public String getList(Model model, @ModelAttribute("searchModel") ContactSearchModel searchModel) {
		
		PagerData<Contact> contactsWithPaging = contactService.search(searchModel);
		
		model.addAttribute("contactsWithPaging", contactsWithPaging);
		
		return "admin/contactList";
	}
	
	@Transactional
	@RequestMapping(value = "/admin/contact/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable Integer id){
		
		if (id!=null) {
			contactService.deleteById(id);
		}
		
		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);
		
		return ResponseEntity.ok(rs);
	}
}
