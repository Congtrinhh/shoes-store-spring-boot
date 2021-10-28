package com.trinhquycong.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "saleorder_product")
public class SaleOrderProduct extends BaseEntity {

	@Column(name = "quantity", nullable = false)
	private int quantity;
	
	@Column(name = "size_no", nullable = false)
	private int sizeNo;
		
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "saleorder_id", nullable = false)
	private SaleOrder saleOrder;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_size_id")
	//@JoinColumn(name = "product_size_id", nullable = false)
	private ProductSize productSize;

	

	public int getSizeNo() {
		return sizeNo;
	}

	public void setSizeNo(int sizeNo) {
		this.sizeNo = sizeNo;
	}

	public ProductSize getProductSize() {
		return productSize;
	}

	public void setProductSize(ProductSize productSize) {
		this.productSize = productSize;
	}

	public SaleOrder getSaleOrder() {
		return saleOrder;
	}

	public void setSaleOrder(SaleOrder saleOrder) {
		this.saleOrder = saleOrder;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
