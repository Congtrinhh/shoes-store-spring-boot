package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.dto.SizeSearchModel;
import com.trinhquycong.entity.Size;

@Service
public class SizeService extends BaseService<Size> {

	@Override
	protected Class<Size> clazz() {
		// TODO Auto-generated method stub
		return Size.class;
	}

	public PagerData<Size> search(SizeSearchModel searchModel) {
		// TODO Auto-generated method stub
		String sql = "select * from size where 1=1";

		if (searchModel!=null) {
			// theo trạng thái (active hay inactive)
			if (searchModel.getStatus() != null) {
				if (searchModel.getStatus() == true) {
					sql += " and status = 1";
				} else {
					sql += " and status = 0";
				}
			}
		}

		return runTransactQuerySQL(sql, searchModel != null ? searchModel.getPage() : 1,
				searchModel == null ? null : searchModel.getSop());
	}

}
