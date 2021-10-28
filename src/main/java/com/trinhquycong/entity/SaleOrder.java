package com.trinhquycong.entity;

import java.math.BigDecimal;
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
@Table(name = "saleorder")
public class SaleOrder extends BaseEntity {
	
	@Column(name = "code", nullable = false, length = 100)
	private String code;
		
	@Column(name = "total", precision=13, scale=2)
	private BigDecimal total;
	
	@Column(name = "customer_name", length = 100)
	private String customerName;
	
	@Column(name = "customer_address", length = 100)
	private String customerAddress;
	
	@Column(name = "seo")
	private String seo;
	
	@Column(name = "customer_phone", length = 100)
	private String customerPhone;
	
	@Column(name = "customer_email", length = 100)
	private String customerEmail;
	
	
	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "saleOrder")
	private Set<SaleOrderProduct> saleOrderProducts= new HashSet<>();
	
	public void addSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		
		this.saleOrderProducts.add(saleOrderProduct);
		saleOrderProduct.setSaleOrder(this);
		
	}
	
	public void deleteSaleOrderProduct(SaleOrderProduct saleOrderProduct) {
		this.saleOrderProducts.remove(saleOrderProduct);
		saleOrderProduct.setSaleOrder(null);
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", nullable = true)
	private User user;
	
	public Set<SaleOrderProduct> getSaleOrderProducts() {
		return saleOrderProducts;
	}

	public void setSaleOrderProducts(Set<SaleOrderProduct> saleOrderProducts) {
		this.saleOrderProducts = saleOrderProducts;
	}
	
	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	public String getCustomerEmail() {
		return customerEmail;
	}

	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	
}
