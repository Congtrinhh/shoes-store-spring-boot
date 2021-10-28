package com.trinhquycong.dto;

public class ProductSearchModel extends BaseSearchModel {
	
	// tìm theo category
	private Integer categoryId;
	
	// tim theo seo
	private String seo;
	
	// tìm sản phẩm hot
	private Boolean isHot;
	
	// gender, price, brand, newest
	private Boolean gender; // 0: nam; 1: nữ
	
	// mới nhất (new arrivals)
	private Boolean newest;
	
	// hãng - brand
	private Integer brandId;
	
	// khoảng giá
	private Integer minPrice;
	
	private Integer maxPrice;

	// sắp xếp theo giá (tăng dần/ giảm dần)
	private  Boolean priceSort; // true: tăng dần ; false: giảm dần
	
	
	@Override
	public boolean equals(Object obj) {
		if (obj instanceof ProductSearchModel) {
			obj = (ProductSearchModel) obj;
			Integer categoryId = ((ProductSearchModel) obj).getCategoryId();
			Integer brandId = ((ProductSearchModel) obj).getBrandId();
			Boolean priceSort = ((ProductSearchModel) obj).getPriceSort();
			Integer minPrice = ((ProductSearchModel) obj).getMinPrice();
			Integer maxPrice = ((ProductSearchModel) obj).getMaxPrice();
//			Boolean newest = ((ProductSearchModel) obj).getCategoryId();
	
			if (this.categoryId==null && categoryId!=null) {
				return false;
			} else if (this.categoryId!=null && !this.categoryId.equals(categoryId)) {
				return false;
			}
			
			if (this.brandId==null && brandId!=null) {
				return false;
			} else if (this.brandId!=null && !this.brandId.equals(brandId)) {
				return false;
			}
			
			if (this.priceSort==null && priceSort!=null) {
				return false;
			} else if (this.priceSort!=null && !this.priceSort.equals(priceSort)) {
				return false;
			}
			
			if (this.minPrice==null && minPrice!=null) {
				return false;
			} else if (this.minPrice!=null && !this.minPrice.equals(minPrice)) {
				return false;
			}
			
			if (this.maxPrice==null && maxPrice!=null) {
				return false;
			} else if (this.maxPrice!=null && !this.maxPrice.equals(maxPrice)) {
				return false;
			}
//			if (!this.newest.equals(newest)) {
//				return false;
//			}
			return true;
		} else {
			return false;			
		}
	}

	public Boolean getPriceSort() {
		return priceSort;
	}

	public void setPriceSort(Boolean priceSort) {
		this.priceSort = priceSort;
	}

	public Boolean getGender() {
		return gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	public Boolean getNewest() {
		return newest;
	}

	public void setNewest(Boolean newest) {
		this.newest = newest;
	}

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}


	public Integer getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(Integer minPrice) {
		this.minPrice = minPrice;
	}

	public Integer getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(Integer maxPrice) {
		this.maxPrice = maxPrice;
	}

	public Boolean getIsHot() {
		return isHot;
	}

	public void setIsHot(Boolean isHot) {
		this.isHot = isHot;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}
}
