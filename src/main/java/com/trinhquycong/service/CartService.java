package com.trinhquycong.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.trinhquycong.entity.Product;

@Service
public class CartService {

	@Autowired
	private ProductService productService;
	
	public Product getProductById(Integer id) {
		return id == null ? null : productService.getById(id);
	}


}
