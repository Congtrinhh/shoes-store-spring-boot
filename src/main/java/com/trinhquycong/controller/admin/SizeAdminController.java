package com.trinhquycong.controller.admin;

import java.util.Date;
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
import com.trinhquycong.dto.SizeSearchModel;
import com.trinhquycong.entity.Size;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.SizeService;

@Controller
public class SizeAdminController extends BaseController{
	@Autowired
	private SizeService sizeService;

	@RequestMapping(value = "/admin/size/list", method = RequestMethod.GET)
	public String getList(Model model, @ModelAttribute("searchModel") SizeSearchModel searchModel) {

		PagerData<Size> sizesWithPaging = sizeService.search(searchModel);

		model.addAttribute("sizesWithPaging", sizesWithPaging);
		
		model.addAttribute("searchModel", searchModel);

		return "admin/sizeList";
	}

	/**
	 * create page
	 */
	@RequestMapping(value = "/admin/size/create", method = RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model) {

		model.addAttribute("size", new Size());

		return "admin/sizeCreateOrUpdate";
	}

	/**
	 * update page
	 */
	@RequestMapping(value = "/admin/size/update/{id}", method = RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model, @PathVariable Integer id) {

		if (id != null) {
			Size size= sizeService.getById(id);
			model.addAttribute("size", size);
		}

		return "admin/sizeCreateOrUpdate";
	}

	/**
	 * save or update
	 */
	@RequestMapping(value = "/admin/size/create-or-update", method = RequestMethod.POST)
	public String createOrUpdate(Model model, @ModelAttribute Size size) {

		if (size != null) {
			if (size.getId() == null || size.getId() < 0) {
				size.setCreatedDate(new Date());
				size.setStatus(true);
			} else {
				// vì @ModelAttribute Size size, createdDate = null
				Size sizeFromDB = sizeService.getById(size.getId());
				size.setCreatedDate(sizeFromDB.getCreatedDate());
				size.setStatus(sizeFromDB.getStatus());

				size.setUpdatedDate(new Date());
			}
		}

		sizeService.saveOrUpdate(size);

		return "admin/sizeCreateOrUpdate";
	}

	@Transactional
	@RequestMapping(value = "/admin/size/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable Integer id) {

		if (id != null) {
			Size size = sizeService.getById(id);
			size.setStatus(false);
			size.setUpdatedDate(new Date());

			sizeService.saveOrUpdate(size);
		}

		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);

		return ResponseEntity.ok(rs);
	}
}
