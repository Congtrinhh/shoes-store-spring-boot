package com.trinhquycong.dto;

public class BaseSearchModel {

	// tìm theo keyword
	protected String keyword;
	
	// page hiện tại
	protected Integer page = 1;
	
	// size của page 
	protected Integer sop;
	
	// trạng thái
	protected Boolean status;
	
	// có sắp xếp tăng dần không
	protected Boolean newest;

	public Boolean getNewest() {
		return newest;
	}

	public void setNewest(Boolean newest) {
		this.newest = newest;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		if (page==null) {
			this.page=1;
		}else {
			this.page = page;			
		}
	}

	public Integer getSop() {
		return sop;
	}

	public void setSop(Integer sop) {
		this.sop = sop;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
}
