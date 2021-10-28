package com.trinhquycong.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="brand")
public class Brand extends BaseEntity {
	
	@Column(name="name", nullable = false, length=100)
	private String name;
	
	@Column(name="description", nullable = false, length=100)
	private String description;
	
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "brand")
	private Set<Product> products = new HashSet<>();

	public void addProduct(Product product) {
		this.products.add(product);
		product.setBrand(this);
	}
	public void deleteProduct(Product product) {
		this.products.remove(product);
		product.setBrand(null);
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Set<Product> getProducts() {
		return products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}
}
