package com.trinhquycong.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.SaleOrderSearchModel;
import com.trinhquycong.entity.SaleOrder;
import com.trinhquycong.service.PagerData;
import com.trinhquycong.service.SaleOrderProductService;
import com.trinhquycong.service.SaleOrderService;

@Controller
public class SaleOrderAdminController extends BaseController {
	@Autowired
	private SaleOrderService saleOrderService;
	
	@Autowired
	private SaleOrderProductService saleOrderProductService;
	
	/**
	 * Chi tiết đơn hàng
	 */
	@RequestMapping(value = "/admin/sale-order/detail/{id}", method=RequestMethod.GET)
	public String getDetail(Model model, @PathVariable("id") Integer saleOrderId) {
		SaleOrder saleOrder = saleOrderService.getById(saleOrderId);
		
		model.addAttribute("saleOrder", saleOrder);
		
		return "admin/saleOrderDetail";
	}

	/**
	 * Danh sách đơn hàng
	 * @param model
	 * @param searchModel
	 * @return
	 */
	@RequestMapping(value = "/admin/sale-order/list", method=RequestMethod.GET)
	public String getList(Model model,@ModelAttribute("searchModel") SaleOrderSearchModel searchModel) {
		
		PagerData<SaleOrder> saleOrdersWithPaging = saleOrderService.search(searchModel);
		
		model.addAttribute("saleOrdersWithPaging", saleOrdersWithPaging);
		model.addAttribute("searchModel", searchModel);
		
		return "admin/saleOrderList";
	}
	
	/** update
	 */
	@RequestMapping(value = "/admin/sale-order/update/{id}", method=RequestMethod.GET)
	public String getcreateOrUpdatePage(Model model, @PathVariable Integer id) {
		
		if (id!=null) {
			SaleOrder saleOrder = saleOrderService.getById(id);
			model.addAttribute("saleOrder", saleOrder);
			
		}
	
		return "admin/saleOrderCreateOrUpdate";
	}
	
	
	/** Xóa cả đơn hàng
	 */
	@Transactional
	@RequestMapping(value = "/admin/sale-order/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOne(@PathVariable Integer id){
		
		if (id!=null) {
			SaleOrder saleOrder= saleOrderService.getById(id); 
			saleOrder.setStatus(false);
			saleOrder.setUpdatedDate(new Date());
			
			saleOrderService.saveOrUpdate(saleOrder);
		}
		
		Map<String, Object> rs = new HashMap<>();
		rs.put("id", id);
		
		return ResponseEntity.ok(rs);
	}
	
	// xóa 1 sản phẩm trong hóa đơn
	@Transactional
	@RequestMapping(value = "/admin/sale-order-product/delete/{id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteOneChild(@PathVariable Integer id){
		
		Map<String, Object> rs = new HashMap<>();
		
		if (id!=null) {
			saleOrderProductService.deleteById(id); 
			rs.put("id", id);
		} else {
			rs.put("id", -1);
		}
		return ResponseEntity.ok(rs);
	}
}
