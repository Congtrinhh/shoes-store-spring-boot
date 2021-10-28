package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.dto.ContactSearchModel;
import com.trinhquycong.entity.Contact;

@Service
public class ContactService extends BaseService<Contact> {

	@Override
	protected Class<Contact> clazz() {
		// TODO Auto-generated method stub
		return Contact.class;
	}

	public PagerData<Contact> search(ContactSearchModel searchModel) {
		String sql = "select * from contact where 1=1";

		if (searchModel != null) {

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
