package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.dto.BrandSearchModel;
import com.trinhquycong.entity.Brand;

@Service
public class BrandService extends BaseService<Brand> {

	@Override
	protected Class<Brand> clazz() {
		// TODO Auto-generated method stub
		return Brand.class;
	}

	public PagerData<Brand> search(BrandSearchModel searchModel) {
		String sql = "select * from brand where 1=1";
		if (searchModel != null) {
			if (searchModel.getKeyword() != null) {
				sql += " and name like '%" + searchModel.getKeyword() + "%'";
			}

			// theo trạng thái (active hay inactive)
			if (searchModel.getStatus() != null) {
				if (searchModel.getStatus() == true) {
					sql += " and status = 1";
				} else {
					sql += " and status = 0";
				}
			}

			// sắp xếp tăng dần/ giảm dần
			if (searchModel.getNewest() != null && searchModel.getNewest().equals(false)) {
				sql += " order by created_date asc";
			} else {
				sql += " order by created_date desc";
			}

		}
		return runTransactQuerySQL(sql, searchModel != null ? searchModel.getPage() : 1,
				searchModel == null ? null : searchModel.getSop());
	}
}
