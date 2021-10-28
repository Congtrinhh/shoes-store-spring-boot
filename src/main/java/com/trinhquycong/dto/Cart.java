package com.trinhquycong.dto;

import java.math.BigDecimal;
import java.util.List;

public class Cart {
	private List<CartItem> cartItems;
	
	private BigDecimal totalPrice = BigDecimal.ZERO; 
	
	private int cartItemCount;
		

	public int getCartItemCount() {
		return cartItemCount;
	}

	public void setCartItemCount(int cartItemCount) {
		this.cartItemCount = cartItemCount;
	}

	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public int calculateCartItemCount() {
		return cartItems.size();
	}
	
	public BigDecimal calculateTotalPrice() {
		BigDecimal total= BigDecimal.ZERO;
		for (CartItem c : cartItems) {
			total = total.add(c.getPrice().multiply(new BigDecimal(c.getQuantity()))); // total = total + (price*quantity);			
		}
		return total;
	}
}
