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
import com.trinhquycong.dto.ProductSizeSearchModel;
import com.trinhquycong.entity.ProductSize;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.ProductService;
import com.trinhquycong.service.ProductSizeService;
import com.trinhquycong.service.SizeService;

@Controller
public class ProductSizeAdminController extends BaseController{
	@Autowired
	private ProductSizeService productSizeService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private SizeService sizeService;
	
	@RequestMapping(value = "/admin/product-size/list", method=RequestMethod.GET)
	public String getList(Model model, @ModelAttribute("searchModel") ProductSizeSearchModel searchModel) {
		
		PagerData<ProductSize> productSizesWithPaging = productSizeService.search(searchModel);
		
		model.addAttribute("sizes", sizeService.findAll());
		model.addAttribute("productSizesWithPaging", productSizesWithPaging);
		
		return "admin/productSizeList";
	}
	
	/** create page
	 */
	@RequestMapping(value = "/admin/product-size/create", method=RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model) {
		
		model.addAttribute("productSize", new ProductSize());
		
		model.addAttribute("products", productService.findAll());
		
		model.addAttribute("sizes", sizeService.findAll());
		
		return "admin/productSizeCreateOrUpdate";
	}
	
	/** update page
	 */
	@RequestMapping(value = "/admin/product-size/update/{id}", method=RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model, @PathVariable Integer id) {
		
		if (id!=null) {
			ProductSize productSize= productSizeService.getById(id);
			model.addAttribute("productSize", productSize);
			
			model.addAttribute("products", productService.findAll());
			
			model.addAttribute("sizes", sizeService.findAll());
		}
	
		return "admin/productSizeCreateOrUpdate";
	}
	
	
	/** save or update
	 */
	@RequestMapping(value = "/admin/product-size/create-or-update", method=RequestMethod.POST)
	public String createOrUpdate(Model model, @ModelAttribute ProductSize productSize) {
		
		if (productSize!=null) {
			if (productSize.getId()==null || productSize.getId()<0) {
				productSize.setCreatedDate(new Date());
				productSize.setStatus(true);
			} else {
				// vì @ModelAttribute Brand productSize, createdDate = null
				ProductSize productSizeFromDB = productSizeService.getById(productSize.getId());
				productSize.setCreatedDate(productSizeFromDB.getCreatedDate());
				productSize.setStatus(productSizeFromDB.getStatus());
				
				productSize.setUpdatedDate(new Date());
			}
		}
		
		try {
			productSizeService.saveOrUpdate(productSize);
		}catch (Exception e) {
			model.addAttribute("errorMessage", "Không thành công, đã có lỗi");
		}
		
		model.addAttribute("productSize", productSize);		
		model.addAttribute("products", productService.findAll());		
		model.addAttribute("sizes", sizeService.findAll());
		
		return "admin/productSizeCreateOrUpdate";
	}
	
	@Transactional
	@RequestMapping(value = "/admin/product-size/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable Integer id){
		
		if (id!=null) {
			ProductSize productSize = productSizeService.getById(id); 
			productSize.setStatus(false);
			productSize.setUpdatedDate(new Date());
			
			productSizeService.saveOrUpdate(productSize);
		}
		
		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);
		
		return ResponseEntity.ok(rs);
	}
}
