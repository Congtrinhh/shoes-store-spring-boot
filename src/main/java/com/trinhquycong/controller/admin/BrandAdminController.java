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
import com.trinhquycong.dto.BrandSearchModel;
import com.trinhquycong.entity.Brand;
import com.trinhquycong.service.BrandService;
import com.trinhquycong.service.PagerData;

@Controller
public class BrandAdminController extends BaseController {
	@Autowired
	private BrandService brandService;
	
	@RequestMapping(value = "/admin/brand/list", method=RequestMethod.GET)
	public String getList(Model model, @ModelAttribute("searchModel") BrandSearchModel searchModel) {
		
		PagerData<Brand> brandsWithPaging = brandService.search(searchModel);
		
		model.addAttribute("brandsWithPaging", brandsWithPaging);
				
		return "admin/brandList";
	}
	
	/** create page
	 */
	@RequestMapping(value = "/admin/brand/create", method=RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model) {
		
		model.addAttribute("brand", new Brand());
		
		return "admin/brandCreateOrUpdate";
	}
	
	/** update page
	 */
	@RequestMapping(value = "/admin/brand/update/{id}", method=RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model, @PathVariable Integer id) {
		
		if (id!=null) {
			Brand brand = brandService.getById(id);
			model.addAttribute("brand", brand);
		}
	
		return "admin/brandCreateOrUpdate";
	}
	
	
	/** save or update
	 */
	@RequestMapping(value = "/admin/brand/create-or-update", method=RequestMethod.POST)
	public String createOrUpdate(Model model, @ModelAttribute Brand brand) {
		
		if (brand!=null) {
			if (brand.getId()==null || brand.getId()<0) {
				brand.setCreatedDate(new Date());
				brand.setStatus(true);
			} else {
				// vì @ModelAttribute Brand brand, createdDate = null
				Brand brandFromDB = brandService.getById(brand.getId());
				brand.setCreatedDate(brandFromDB.getCreatedDate());
				//brand.setStatus(brandFromDB.getStatus());
				brand.setUpdatedDate(new Date());
			}
		}
		
		brandService.saveOrUpdate(brand);
		
		return "admin/brandCreateOrUpdate";
	}
	
	@Transactional
	@RequestMapping(value = "/admin/brand/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable Integer id){
		
		if (id!=null) {
			Brand brand = brandService.getById(id); 
			brand.setStatus(false);
			brand.setUpdatedDate(new Date());
			
			brandService.saveOrUpdate(brand);
		}
		
		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);
		
		return ResponseEntity.ok(rs);
	}
}
