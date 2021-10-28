package com.trinhquycong.dto;

public class ProductSizeSearchModel extends BaseSearchModel {
	
	private String productName;
	
	private Integer sizeId;

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getSizeId() {
		return sizeId;
	}

	public void setSizeId(Integer sizeId) {
		this.sizeId = sizeId;
	}
}
