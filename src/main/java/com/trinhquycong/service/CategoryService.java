package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.dto.CategorySearchModel;
import com.trinhquycong.entity.Category;

@Service
public class CategoryService extends BaseService<Category> {

	@Override
	protected Class<Category> clazz() {
		// TODO Auto-generated method stub
		return Category.class;
	}

	public PagerData<Category> search(CategorySearchModel searchModel) {

		String sql = "select * from category where 1=1";
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
