package com.trinhquycong.dto;

import com.ibm.icu.math.BigDecimal;

public class SaleOrderSearchModel extends BaseSearchModel{
	// keyword, code, create/update time, total
	// code
	private String code;
	
	// tìm trong khoảng tiền
	private BigDecimal minTotal;
	
	private BigDecimal maxTotal;

	private Boolean newest;
	
	public Boolean getNewest() {
		return newest;
	}

	public void setNewest(Boolean newest) {
		this.newest = newest;
	}

	private String customerName;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BigDecimal getMinTotal() {
		return minTotal;
	}

	public void setMinTotal(BigDecimal minTotal) {
		this.minTotal = minTotal;
	}

	public BigDecimal getMaxTotal() {
		return maxTotal;
	}

	public void setMaxTotal(BigDecimal maxTotal) {
		this.maxTotal = maxTotal;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
}
