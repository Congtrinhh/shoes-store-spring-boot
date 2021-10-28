package com.trinhquycong.dto;

public class ContactSearchModel extends BaseSearchModel {
	
	private Boolean newest = Boolean.TRUE; // 1 -> từ mới nhất; 0 -> từ cũ nhất

	public Boolean getNewest() {
		return newest;
	}

	public void setNewest(Boolean newest) {
		this.newest = newest;
	}
	
}
