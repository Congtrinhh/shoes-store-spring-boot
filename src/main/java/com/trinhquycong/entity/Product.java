package com.trinhquycong.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "product")
public class Product extends BaseEntity {
	
	@Column(name = "name", nullable = false, length = 1000)
	private String name;

	@Column(name = "price", precision = 13, scale = 2, nullable = false)
	private BigDecimal price;

	@Column(name = "short_description", nullable = false, length = 3000)
	private String shortDescription;

	@Lob // dành cho kiểu dl lớn
	@Column(name = "detail_description", nullable = false)
	private String detailDescription;

	@Column(name = "avatar")
	private String avatar;

	@Column(name = "gender")
	private Boolean gender;

	@Column(name = "seo", nullable = false, unique = true)
	private String seo;

	@Column(name = "is_hot")
	private Boolean isHot;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")
	@JsonIgnore
	private Category category;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "brand_id")
	@JsonIgnore
	private Brand brand;

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "product", orphanRemoval = true)
	@JsonIgnore
	private Set<ProductImage> productImages = new HashSet<>();

	/*-------------*/
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "product")
	@JsonIgnore
	private Set<ProductSize> productSizes = new HashSet<>();

	public void addProductSize(ProductSize productSize) {
		this.productSizes.add(productSize);
		productSize.setProduct(this);
	}

	public void deleteProductSize(ProductSize productSize) {
		this.productSizes.remove(productSize);
		productSize.setProduct(null);
	}
	/*-------------*/

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public Set<ProductSize> getProductSizes() {
		return productSizes;
	}

	public void setProductSizes(Set<ProductSize> productSizes) {
		this.productSizes = productSizes;
	}

	public void addProductImage(ProductImage image) {
		this.productImages.add(image);
		image.setProduct(this);
	}

	public void deleteProductImage(ProductImage image) {
		this.productImages.remove(image);
		image.setProduct(null);
	}

	public Set<ProductImage> getProductImages() {
		return productImages;
	}

	public void setProductImages(Set<ProductImage> productImages) {
		this.productImages = productImages;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getGender() {
		return gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}


	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDetailDescription() {
		return detailDescription;
	}

	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Boolean getIsHot() {
		return isHot;
	}

	public void setIsHot(Boolean isHot) {
		this.isHot = isHot;
	}

	public Category getCategory() {
		return category;
	}

	public Product(Date createdDate, Date updatedDate, Integer createdBy, Integer updatedBy, Boolean status,
			String name, BigDecimal price, String shortDescription, String detailDescription,
			String avatar, Boolean gender, String seo, Boolean isHot, Category category, Brand brand,
			Set<ProductImage> productImages, Set<ProductSize> productSizes) {
		super(createdDate, updatedDate, createdBy, updatedBy, status);
		this.name = name;
		this.price = price;
		this.shortDescription = shortDescription;
		this.detailDescription = detailDescription;
		this.avatar = avatar;
		this.gender = gender;
		this.seo = seo;
		this.isHot = isHot;
		this.category = category;
		this.brand = brand;
		this.productImages = productImages;
		this.productSizes = productSizes;
	}

	public Product() {

	}
}
