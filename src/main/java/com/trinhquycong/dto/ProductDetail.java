package com.trinhquycong.dto;

public class ProductDetail {
	
	private Integer productId;
	
	private Integer sizeNo;
	
	private int inStockQuantity;
	
	private Float discountPercent;

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getSizeNo() {
		return sizeNo;
	}

	public void setSizeNo(Integer sizeNo) {
		this.sizeNo = sizeNo;
	}

	public int getInStockQuantity() {
		return inStockQuantity;
	}

	public void setInStockQuantity(int inStockQuantity) {
		this.inStockQuantity = inStockQuantity;
	}

	public Float getDiscountPercent() {
		return discountPercent;
	}

	public void setDiscountPercent(Float discountPercent) {
		this.discountPercent = discountPercent;
	}

	

}
