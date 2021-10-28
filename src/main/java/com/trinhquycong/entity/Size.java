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
@Table(name = "size")
public class Size extends BaseEntity {
	@Column(name = "size_no", nullable=false, unique = true)
	private int sizeNo;
	
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "size")
	private Set<ProductSize> productSizes = new HashSet<>();

	
	public Set<ProductSize> getProductSizes() {
		return productSizes;
	}

	public void setProductSizes(Set<ProductSize> productSizes) {
		this.productSizes = productSizes;
	}

	public int getSizeNo() {
		return sizeNo;
	}

	public void setSizeNo(int sizeNo) {
		this.sizeNo = sizeNo;
	}
	
	
}
