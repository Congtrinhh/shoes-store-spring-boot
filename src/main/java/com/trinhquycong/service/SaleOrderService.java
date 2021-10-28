package com.trinhquycong.service;

import org.springframework.stereotype.Service;

import com.trinhquycong.dto.SaleOrderSearchModel;
import com.trinhquycong.entity.SaleOrder;

@Service
public class SaleOrderService extends BaseService<SaleOrder> {

	@Override
	protected Class<SaleOrder> clazz() {
		// TODO Auto-generated method stub
		return SaleOrder.class;
	}

	public PagerData<SaleOrder> search(SaleOrderSearchModel searchModel) {
		String sql = "select * from saleorder s where 1=1";

		if (searchModel != null) {
			// Tìm kiếm theo tên khách hàng
			if (searchModel.getCustomerName() != null) {
				sql += " and customer_name like '%" + searchModel.getCustomerName() + "%'";
			}

			// theo code
			if (searchModel.getCode() != null) {
				sql += " and code like '%" + searchModel.getCode() + "%'";
			}

			// theo khoảng tiền
			if (searchModel.getMinTotal() != null && searchModel.getMaxTotal() != null) {
				sql += " and total between " + searchModel.getMinTotal() + " and " + searchModel.getMaxTotal();
			}

			// theo trạng thái (active hay inactive)
			if (searchModel.getStatus() != null) {
				if (searchModel.getStatus() == true) {
					sql += " and status = 1";
				} else {
					sql += " and status = 0";
				}
			}

			// lấy từ mới nhất đến cũ nhất: đặt làm mặc định
			if (searchModel.getNewest()!=null && searchModel.getNewest().equals(false)) {
				sql += " order by created_date asc";
			} else {
				sql += " order by created_date desc";
			}
		}

		return runTransactQuerySQL(sql, searchModel == null ? 1 : searchModel.getPage(), searchModel == null ? null :searchModel.getSop() );
	}

}
