package com.trinhquycong.dto;

import java.math.BigDecimal;

public class CartItem {

	private Integer productId;
	
	private Integer sizeId;
	
	private String name;
	
	// giá (khi đã tính % discount)
	private BigDecimal price; 
	
	// để hiển thị ảnh trong trang checkout
	private String avatarPath;
	
	private int sizeNo;
	
	// để so sánh với quantity xem có đủ hàng không
	private int inStockQuantity;
	
	// số lượng mà người dùng đặt
	private int quantity;

	
	// để khi click vào ảnh product trong trang checkout -> chuyển đến trang product detail
	private String productSeo;
	

	public String getProductSeo() {
		return productSeo;
	}

	public void setProductSeo(String productSeo) {
		this.productSeo = productSeo;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public int getSizeNo() {
		return sizeNo;
	}

	public void setSizeNo(int sizeNo) {
		this.sizeNo = sizeNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatarPath() {
		return avatarPath;
	}

	public void setAvatarPath(String avatarPath) {
		this.avatarPath = avatarPath;
	}

	public int getInStockQuantity() {
		return inStockQuantity;
	}

	public void setInStockQuantity(int inStockQuantity) {
		this.inStockQuantity = inStockQuantity;
	}

	public Integer getSizeId() {
		return sizeId;
	}

	public void setSizeId(Integer sizeId) {
		this.sizeId = sizeId;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}	
	
}
