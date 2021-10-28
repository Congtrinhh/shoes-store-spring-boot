package com.trinhquycong.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "product_image")
public class ProductImage extends BaseEntity {
	
	@Column(name = "name", nullable = false, length = 500)
	private String name;
	
	@Column(name = "path", nullable = false, length = 200)
	private String path;
	

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "product_id", nullable = false)
	private Product product;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ProductImage(Date createdDate, Date updatedDate, Integer createdBy, Integer updatedBy, Boolean status,
			String name, String path) {
		super(createdDate, updatedDate, createdBy, updatedBy, status);
		this.name = name;
		this.path = path;
	}

	public ProductImage() {
		super();
	}
}
