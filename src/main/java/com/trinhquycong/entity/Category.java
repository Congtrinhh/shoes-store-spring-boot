package com.trinhquycong.entity;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="category")
public class Category extends BaseEntity {
	
	@Column(name="name", nullable = false, length=100)
	private String name;
	
	@Column(name="description", nullable = false, length=100)
	private String description;
	
	@Column(name="seo")
	private String seo;
	
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "category")
	Set<Product> productList = new HashSet<>();
	
	public void addProduct(Product product) {
		this.productList.add(product);
		product.setCategory(this);
	}
	
	public void deleteProduct(Product product) {
		this.productList.remove(product);
		product.setCategory(null);
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "parent_id")
	private Category parentCategory;
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "parentCategory")
	private Set<Category> childCategories = new HashSet<>();
	
	public void addChildCategory(Category category) {
		this.childCategories.add(category);
		category.setParentCategory(this);
	}
	public  void deleteChildCategory(Category category) {
		this.childCategories.remove(category);
		category.setParentCategory(null);
	}
	
	public Category getParentCategory() {
		return parentCategory;
	}

	public void setParentCategory(Category parentCategory) {
		this.parentCategory = parentCategory;
	}

	public Set<Category> getChildCategories() {
		return childCategories;
	}

	public void setChildCategories(Set<Category> childCategories) {
		this.childCategories = childCategories;
	}

	public Set<Product> getProductList() {
		return productList;
	}

	public void setProductList(Set<Product> productList) {
		this.productList = productList;
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




	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}
}
