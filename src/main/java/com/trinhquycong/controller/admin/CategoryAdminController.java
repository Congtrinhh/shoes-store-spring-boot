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

import com.trinhquycong.component.Utilities;
import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.CategorySearchModel;
import com.trinhquycong.entity.Category;
import com.trinhquycong.service.CategoryService;
import com.trinhquycong.service.PagerData;

@Controller
public class CategoryAdminController extends BaseController {

	@Autowired
	private CategoryService categoryService;

	@RequestMapping(value = "/admin/category/list", method = RequestMethod.GET)
	public String getList(Model model, @ModelAttribute("searchModel") CategorySearchModel searchModel) {

		PagerData<Category> categoriesWithPaging = categoryService.search(searchModel);

		model.addAttribute("categoriesWithPaging", categoriesWithPaging);

		return "admin/categoryList";
	}

	/**
	 * create page
	 */
	@RequestMapping(value = "/admin/category/create", method = RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model) {

		model.addAttribute("category", new Category());

		return "admin/categoryCreateOrUpdate";
	}

	/**
	 * update page
	 */
	@RequestMapping(value = "/admin/category/update/{id}", method = RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model, @PathVariable Integer id) {

		if (id != null) {
			Category category= categoryService.getById(id);
			model.addAttribute("category", category);
		}

		return "admin/categoryCreateOrUpdate";
	}

	/**
	 * save or update
	 */
	@RequestMapping(value = "/admin/category/create-or-update", method = RequestMethod.POST)
	public String createOrUpdate(Model model, @ModelAttribute Category category) {

		if (category != null) {
			if (category.getId() == null || category.getId() < 0) {
				category.setCreatedDate(new Date());
				category.setStatus(true);
			} else {
				// vì @ModelAttribute Category category, createdDate = null
				Category categoryFromDB = categoryService.getById(category.getId());
				category.setCreatedDate(categoryFromDB.getCreatedDate());
				category.setStatus(categoryFromDB.getStatus());

				category.setUpdatedDate(new Date());
			}
			category.setSeo(Utilities.slugify(category.getName()));
		}

		categoryService.saveOrUpdate(category);

		return "admin/categoryCreateOrUpdate";
	}

	@Transactional
	@RequestMapping(value = "/admin/category/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable Integer id) {

		if (id != null) {
			Category category = categoryService.getById(id);
			category.setStatus(false);
			category.setUpdatedDate(new Date());

			categoryService.saveOrUpdate(category);
		}

		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);

		return ResponseEntity.ok(rs);
	}
}