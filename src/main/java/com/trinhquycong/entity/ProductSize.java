package com.trinhquycong.entity;

import java.util.HashSet;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "product_size")
public class ProductSize extends BaseEntity {
	
	private int quantity;
	
	private float discountPercent;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id")
	private Product product;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "size_id")
	private Size size;
	
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "productSize")
	private java.util.Set<SaleOrderProduct> saleOrderProducts = new HashSet<>();
		
	public void addSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		this.saleOrderProducts.add(saleOrderProduct);
		saleOrderProduct.setProductSize(this);
	}
	
	public void deleteSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		this.saleOrderProducts.remove(saleOrderProduct);
		saleOrderProduct.setProductSize(null);
	}

	public java.util.Set<SaleOrderProduct> getSaleOrderProducts() {
		return saleOrderProducts;
	}

	public void setSaleOrderProducts(java.util.Set<SaleOrderProduct> saleOrderProducts) {
		this.saleOrderProducts = saleOrderProducts;
	}

	public Size getSize() {
		return size;
	}

	public void setSize(Size size) {
		this.size = size;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public float getDiscountPercent() {
		return discountPercent;
	}

	public void setDiscountPercent(float discountPercent) {
		this.discountPercent = discountPercent;
	}	
}
