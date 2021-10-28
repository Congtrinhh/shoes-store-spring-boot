package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.dto.ProductSizeSearchModel;
import com.trinhquycong.entity.ProductSize;

@Service
public class ProductSizeService extends BaseService<ProductSize> {

	@Override
	protected Class<ProductSize> clazz() {
		// TODO Auto-generated method stub
		return ProductSize.class;
	}

	public PagerData<ProductSize> search(ProductSizeSearchModel searchModel) {
		String sql = "select * from product_size ps join product p on p.id=ps.product_id join size s on s.id=ps.size_id where 1=1";

		if (searchModel != null) {
			
			if (searchModel.getProductName() != null) {
				sql += " and p.name like '%" + searchModel.getProductName() + "%'";
			}
			
			if (searchModel.getSizeId() != null) {
				sql += " and s.id=" + searchModel.getSizeId(); 
			}

			// theo trạng thái (active hay inactive)
			if (searchModel.getStatus() != null) {
				if (searchModel.getStatus() == true) {
					sql += " and ps.status = 1";
				} else {
					sql += " and ps.status = 0";
				}
			}

			// sắp xếp tăng dần/ giảm dần
			if (searchModel.getNewest() != null && searchModel.getNewest().equals(false)) {
				sql += " order by ps.created_date asc";
			} else {
				sql += " order by ps.created_date desc";
			}
		}

		return runTransactQuerySQL(sql, searchModel == null ? 0 : searchModel.getPage(),
				searchModel == null ? null : searchModel.getSop());
	}

	public ProductSize findByIds(Integer productId, Integer sizeId) {
		String sql = "select * from product_size where product_id=? and size_id=?";
		ProductSize rs = (ProductSize) entityManager.createNativeQuery(sql, ProductSize.class)
				.setParameter(1, productId).setParameter(2, sizeId).getSingleResult();
		return rs;
	}
}
