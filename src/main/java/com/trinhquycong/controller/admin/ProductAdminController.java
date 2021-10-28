package com.trinhquycong.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.ProductSearchModel;
import com.trinhquycong.entity.Product;
import com.trinhquycong.service.BrandService;
import com.trinhquycong.service.CategoryService;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.ProductService;

/* tích hợp summernote
 * gender required
 */

@Controller
@RequestMapping("/admin")
public class ProductAdminController extends BaseController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private BrandService brandService;

	@Autowired
	private ProductService productService;

	@GetMapping("/product/list")
	public String listAll(final Model model, final HttpServletRequest request,
			@ModelAttribute("searchModel") ProductSearchModel searchModel) {
		// get products có paging
		
		PagerData<Product> productsWithPaging = productService.search(searchModel);
		
		model.addAttribute("productsWithPaging", productsWithPaging);
		model.addAttribute("categories", categoryService.findAll()); 
		model.addAttribute("brands", brandService.findAll()); 

		return "admin/productRead";
	}
	
	@GetMapping("/product/create")
	public String getAddOnePage(final Model model, final HttpServletRequest request,
			final HttpServletResponse response) {
		model.addAttribute("product", new Product());
		model.addAttribute("categories", categoryService.findAll());
		model.addAttribute("brands", brandService.findAll());

		model.addAttribute("typeOfPage", "create");

		return "admin/productCreateOrUpdate";
	}
	
	@GetMapping("/product/update/{id}")
	public String toUpdateOnePage(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @PathVariable("id") Integer id) {
		model.addAttribute("product", productService.getById(id));
		
		model.addAttribute("categories", categoryService.findAll());
		model.addAttribute("brands", brandService.findAll());
		
		model.addAttribute("typeOfPage", "update");
		
		return "admin/productCreateOrUpdate";
	}
	

	@PostMapping("/product/create-or-update")
	public String createOrUpdateOne(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @ModelAttribute("product") Product product,
			@RequestParam("productAvatarFile") MultipartFile avatarFile,
			@RequestParam("productImagesFile") MultipartFile[] imagesFile,
			@Value("${imgBasePath}") String imgBasePath) throws IllegalStateException, IOException {

		if (product.getId() == null || product.getId() <= 0) {
			 productService.create(product, avatarFile,imagesFile, imgBasePath );
			
		} else {
			 productService.update(product, avatarFile,imagesFile, imgBasePath );
			
		}
		
		model.addAttribute("product", product);
		model.addAttribute("categories", categoryService.findAll());
		model.addAttribute("brands", brandService.findAll());

		model.addAttribute("typeOfPage", "update");

		return "admin/productCreateOrUpdate";
	}
	
	@GetMapping("/product/delete/{id}")
	public ResponseEntity<Map<String, Object>> deleteOne(final Model model, final HttpServletRequest request,
			final HttpServletResponse response, @PathVariable(name = "id") Integer id) {
		
		Integer statusCode =null;
		
		if (id!=null && id>0) {
			statusCode = productService.deleteWithFileSystem(id);
		}
		
		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);
		rs.put("statusCode", statusCode);

		return ResponseEntity.ok(rs);
	}
}
