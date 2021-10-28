package com.trinhquycong.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.trinhquycong.controller.common.BaseController;
import com.trinhquycong.dto.Cart;
import com.trinhquycong.dto.CartItem;
import com.trinhquycong.entity.Product;
import com.trinhquycong.entity.ProductSize;
import com.trinhquycong.service.CartService;
import com.trinhquycong.service.ProductSizeService;

@Controller
public class CartController extends BaseController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductSizeService productSizeService;
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String getCartPage(HttpServletRequest request) {
		
		return "user/cart";
	}
	
	/** 
	 * kiểm tra trước khi sang trang checkout
	 *   
	 */
	@RequestMapping(value = "/ajax/cart/next", method = RequestMethod.POST)
	public ResponseEntity<Object> checkBeforeCheckout(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		
		String message = null;
		
		// lấy ra cart từ session
		Cart cart = (Cart) session.getAttribute("cart");
		
		if (cart!=null) {
			for (CartItem item : cart.getCartItems()) {
				// lấy ra product size
				ProductSize productSize = productSizeService.findByIds(item.getProductId(), item.getSizeId());
				
				// số lượng trong kho không đủ -> tb lỗi
				if ( productSize.getQuantity() < item.getQuantity()) {
					message = "sản phẩm " + item.getName() + ", size " + item.getSizeNo() + " chỉ còn " + productSize.getQuantity();
					break;
				}
			}
		}
		
		return ResponseEntity.ok(message);
	}
	
	/** 
	 * xóa item  
	 */
	@RequestMapping(value = "/ajax/cart/delete", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteItem(HttpServletRequest request, 
			@RequestParam("productId") Integer productId,
			@RequestParam("sizeNo") Integer sizeNo){
		
		Map<String, Object> results = new HashMap<>();
		
		if (productId!=null) {
			
			HttpSession session = request.getSession();
			Cart cart = (Cart) session.getAttribute("cart");
			
			int index = -1;
			
			for (int i=0; i<cart.getCartItems().size(); i++) {
				if (cart.getCartItems().get(i).getProductId().equals(productId)) {
					if ( cart.getCartItems().get(i).getSizeNo()  == sizeNo) {
						index = i;
						break;						
					}
				}
			}
			cart.getCartItems().remove(index);
			cart.setTotalPrice(cart.calculateTotalPrice());
			cart.setCartItemCount(cart.calculateCartItemCount());
			
			session.setAttribute("cart", cart);
			results.put("cart", cart);
		} else {
			results.put("cart", null);
		}
		
		
		return ResponseEntity.ok(results);
	}
	
	/** 
	 * check số lượng item trong kho có đủ cung cấp khi tăng bấm nút tăng sl item 
	 */
	@RequestMapping(value = "/ajax/cart/check", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> checkQuantity(HttpServletRequest request, 
			@RequestParam("quantity") Integer quantity,
			@RequestParam("productId") Integer productId,
			@RequestParam("sizeNo") Integer sizeNo){
		
		Product product = cartService.getProductById(productId);
		
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		
		Map<String, Object> results = new HashMap<>();
		
		if (product!=null) {
			for (ProductSize ps : product.getProductSizes()) {
				if (ps.getSize().getSizeNo() == sizeNo) {
					if (ps.getQuantity() < quantity) {
						
						results.put("isEnough", false);
						for (CartItem item : cart.getCartItems()) {
							if (item.getSizeNo() == sizeNo) {
								item.setQuantity( quantity );
								item.setInStockQuantity(ps.getQuantity());
								break;
							}
						}
						
					}
					else {
						results.put("isEnough", true);
						
						
						if ( cart!=null) {
							for (CartItem item : cart.getCartItems()) {
								if (item.getSizeNo() == sizeNo) {
									item.setQuantity( quantity );
									item.setInStockQuantity(ps.getQuantity());
									break;
								}
							}
							cart.setTotalPrice(cart.calculateTotalPrice());
							session.setAttribute("cart", cart);
							results.put("cart", cart);
						}
					}
					results.put("productId", productId);
					results.put("sizeNo", sizeNo);
					results.put("inStockQuantity", ps.getQuantity());
					break;
				}
			}
		}
		
		return ResponseEntity.ok(results);
	}
	
	
	@RequestMapping(value = "/ajax/cart/add", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToCart(HttpServletRequest request, @RequestBody CartItem newCartItem) {
		
		Product product = cartService.getProductById(newCartItem.getProductId());
		
		Map<String, Object> results = new HashMap<>();
		
		if (product!=null) {
			
			Cart cart = new Cart();
			
			HttpSession session = request.getSession();
			
			// có thể trong session đã có thông tin giỏ hàng
			if ( (cart = (Cart) session.getAttribute("cart")) != null ) {
				List<CartItem> cartItemList = cart.getCartItems();
				
				// nếu item này đã có trong cart, chỉ tăng số lượng của item đó
				boolean alreadyExist = false;
				for (CartItem item : cartItemList) {
					if (item.getProductId().equals(newCartItem.getProductId()) && item.getSizeId().equals(newCartItem.getSizeId())) {
						alreadyExist = true;
						item.setQuantity(item.getQuantity() + newCartItem.getQuantity());
						break;
					}
				}
				
				if (alreadyExist==false) {
					cartItemList.add(newCartItem);
				}
				
				cart.setCartItems(cartItemList);
				cart.setTotalPrice(cart.calculateTotalPrice());
				cart.setCartItemCount(cart.calculateCartItemCount());
				session.setAttribute("cart", cart);
			} else {
				List<CartItem> cartItemList = new ArrayList<>();
				cartItemList.add(newCartItem);
				
				cart = new Cart();
				cart.setCartItems(cartItemList);
				cart.setTotalPrice(cart.calculateTotalPrice());
				cart.setCartItemCount(cart.calculateCartItemCount());
				session.setAttribute("cart", cart);
			}
			
			
			results.put("cart", cart);
			results.put("cartItemCount", cart.getCartItems().size());
		}
		
		
		return ResponseEntity.ok(results);	//
	}
	
}
