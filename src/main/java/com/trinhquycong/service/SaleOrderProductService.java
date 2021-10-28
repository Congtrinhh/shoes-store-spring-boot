package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.entity.SaleOrderProduct;

@Service
public class SaleOrderProductService extends BaseService<SaleOrderProduct> {

	@Override
	protected Class<SaleOrderProduct> clazz() {
		// TODO Auto-generated method stub
		return SaleOrderProduct.class;
	}
	
}
