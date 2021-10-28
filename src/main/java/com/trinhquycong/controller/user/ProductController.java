package com.trinhquycong.controller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.trinhquycong.component.Constants;
import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.CartItem;
import com.trinhquycong.dto.ProductSearchModel;
import com.trinhquycong.entity.Product;
import com.trinhquycong.entity.ProductSize;
import com.trinhquycong.service.BrandService;
import com.trinhquycong.service.CategoryService;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.ProductService;

@Controller
public class ProductController extends BaseController {
	@Autowired
	private ProductService productService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private BrandService brandService;

	/**
	 * Search product
	 */
	@RequestMapping(value = "search", method = RequestMethod.GET)
	public ModelAndView getResultSearchPage(
			@RequestParam(name = "keyword-from-page-header", required = false) String keyword,
			@ModelAttribute("searchModel") ProductSearchModel searchModel) {
		
		ModelAndView mav = new ModelAndView("user/search");

		searchModel.setSop(8);
		searchModel.setStatus(true);
		
		if (keyword != null && keyword.length() > 0) {
			searchModel.setKeyword(keyword);
		}

		PagerData<Product> pagerData = productService.search(searchModel);

		if (pagerData.getData() != null && pagerData.getData().size() > 0) {
			List<Product> products = productService.getOnlyProductsContainSize(pagerData.getData());
			mav.addObject("products", products);
		}

		return mav;
	}

	@RequestMapping(value = "ajax/search", method = RequestMethod.POST)
	public ResponseEntity<Object> loadMoreProductSearch(@RequestBody ProductSearchModel searchModel) {

		searchModel.setSop(8);
		searchModel.setStatus(true);
		
		PagerData<Product> pagerData = productService.search(searchModel);
		List<Product> rs = new ArrayList<>();
		
		if (pagerData.getData() != null && pagerData.getData().size() > 0) {
			List<Product> tmpProducts = pagerData.getData();
			rs = productService.getOnlyProductsContainSize(tmpProducts); 
		} else {
			rs = null;
		}
		
		return ResponseEntity.ok(rs);
	}

	/**
	 * Product detail
	 */
	@GetMapping(value = { "/product-detail/{seo}" })
	public String getProductDetail(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable(name = "seo", required = true) String seo) {

		ProductSearchModel searchModel = new ProductSearchModel();
		searchModel.setSeo(seo);
		searchModel.setPage(1);

		List<com.trinhquycong.entity.Product> list = productService.search(searchModel).getData();

		com.trinhquycong.entity.Product product = list.get(0);
		if (product != null) {

			List<CartItem> productDetails = new ArrayList<>();

			for (ProductSize ps : product.getProductSizes()) {
				CartItem p = new CartItem();
				
				// price - (price*discount)/100)
				java.math.BigDecimal price = ps.getProduct().getPrice().subtract(ps.getProduct().getPrice().multiply(new java.math.BigDecimal(ps.getDiscountPercent())).divide(new java.math.BigDecimal(100))) ; 
				
				p.setProductId(product.getId());
				p.setSizeId(ps.getSize().getId());
				p.setName(product.getName());
				p.setPrice(price);
				p.setAvatarPath(product.getAvatar());
				p.setSizeNo(ps.getSize().getSizeNo());
				p.setInStockQuantity(ps.getQuantity());
				p.setQuantity(0);
				p.setProductSeo(product.getSeo());
				

				productDetails.add(p);
			}

			model.addAttribute("product", product);
			model.addAttribute("productDetails", productDetails);

		}

		return "user/productDetail";

	}

	/**
	 * Men, women, new arrival,..
	 * 
	 */
	@GetMapping(value = { "/men", "/women", "/new-arrivals" }) // , "new-arrivals"
	public String getCategoryPage(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("searchModel") ProductSearchModel searchModel) {

		HttpSession session = request.getSession();

		ProductSearchModel oldSearchModel = (ProductSearchModel) session.getAttribute("oldSearchModel");

		// bộ lọc thay đổi -> reset về trang 1
		if (oldSearchModel != null && !oldSearchModel.equals(searchModel)) {
			searchModel.setPage(1);
		}

		String requestPath = request.getServletPath();

		if (requestPath.equals("/men")) {
			searchModel.setGender(false); // lấy sp nam
			session.setAttribute("breadcrumb", "Nam"); // Tên breadcrumb - chỉ để hiển thị UI
		} else if (requestPath.equals("/women")) {
			searchModel.setGender(true); // lấy sp nữ
			session.setAttribute("breadcrumb", "Nữ");
		} else if (requestPath.equals("/new-arrivals")) {
			searchModel.setGender(null); // lấy sp nữ
			searchModel.setIsHot(true); // quy ước: hàng mới về là hàng hot
			session.setAttribute("breadcrumb", "Hàng mới về");
		}

		searchModel.setSop(Constants.SOP_USER);
		searchModel.setStatus(true);

		PagerData<Product> pagerData = productService.search(searchModel);
		List<Product> tmpProducts = pagerData.getData();

		// trong tmpProducts có cả những product mà không có size nào, không lấy chúng
		List<Product> products = productService.getOnlyProductsContainSize(tmpProducts);

		model.addAttribute("brands", brandService.findAll());
		model.addAttribute("categories", categoryService.findAll());
		model.addAttribute("searchModel", searchModel);
		model.addAttribute("products", products);

		session.setAttribute("oldSearchModel", searchModel);

		return "user/productCategory";
	}

	/**
	 * hàm này xảy ra hiện tượng infinite recursive property (property đệ quy vô
	 * hạn), cần ignore các property đó trong class POJO hoặc entity
	 */
	@RequestMapping(value = { "/ajax/load-more-items" }, method = RequestMethod.POST) // , "new-arrivals"
	public @ResponseBody List<Product> loadMoreItems(ModelMap model, HttpServletRequest request,
			HttpServletResponse response, @RequestBody ProductSearchModel searchModel) {

		searchModel.setSop(Constants.SOP_USER);
		searchModel.setStatus(true);
		
		// nếu là new-arrival
		if (searchModel.getGender() == null) {
			searchModel.setIsHot(true);
		}
		
		PagerData<Product> pagerData = productService.search(searchModel);
		List<Product> tmpProducts = pagerData.getData();

		List<Product> products = productService.getOnlyProductsContainSize(tmpProducts);

		return products;
	}

	/**
	 * tìm kiếm
	 */

}
