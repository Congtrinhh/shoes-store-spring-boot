package com.trinhquycong.controller.user;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.ProductSearchModel;
import com.trinhquycong.entity.Product;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.ProductService;

@Controller // controller là một Bean
public class HomeController extends BaseController {
	@Autowired
	ProductService productService;
	
	@RequestMapping(value= {"", "/home"}, method=RequestMethod.GET)
	public String home(Model model) {
		
		System.out.println("Accessed at " + new Date().toString());
		
		ProductSearchModel searchModelNewArrivals = new ProductSearchModel();
		searchModelNewArrivals.setStatus(true);
		searchModelNewArrivals.setNewest(true);
		searchModelNewArrivals.setSop(8);
		searchModelNewArrivals.setIsHot(true); // quy ước: hàng mới về là hàng hot
		
		PagerData<Product> pagerDataNewArrivals = productService.search(searchModelNewArrivals);
		List<Product> newArrivals =null;
		
		if (pagerDataNewArrivals.getData()!=null) {
			newArrivals = productService.getOnlyProductsContainSize(pagerDataNewArrivals.getData());			
		}
		
		
		ProductSearchModel searchModelBestSellers = new ProductSearchModel();
		searchModelBestSellers.setStatus(true);
		searchModelBestSellers.setIsHot(true);
		searchModelBestSellers.setSop(8);
		
		PagerData<Product> pagerDataBestSellers = productService.search(searchModelBestSellers);
		List<Product> bestSellers = null;
		if (pagerDataBestSellers.getData()!=null) {
			bestSellers = productService.getOnlyProductsContainSize(pagerDataBestSellers.getData());
		}
		
		model.addAttribute("bestSellers", bestSellers);
		model.addAttribute("newArrivals", newArrivals);
		
		return "user/home";
	}
}
