<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>

<header class="header smart-scroll">
	<div class="announcement">
		<p>Giảm giá đến 25% với đơn hàng có giá trị lớn hơn 500000 vnđ</p>
	</div>
	<div class="search-box">
		<form id="searchForm" method="GET" action="${base }/search">
			<input type="text" name="keyword-from-page-header" placeholder="Nhập gì đó ..." />
			<button class="btn-search" type="submit">
				<i class="fas fa-search"></i> Search
			</button>
		</form>
	</div>

	<div class="bottom container">
		<div class="menu-toggle-container" id="menuToggle">
			<i class="fas fa-bars"></i>
		</div>
		<div class="left">
			<h1 class="logo">
				<a href="${base}/">Giày99cara</a>
			</h1>
		</div>
		<div class="center">
			<nav>
				<ul>
					<li><a href="${base}/men">Nam</a></li>
					<li><a href="${base}/women">Nữ</a></li>
					<li><a href="${base}/new-arrivals">Mới về</a></li>
					<li><a href="${base }/about">Giới thiệu</a></li>
					<li><a href="${base }/contact">Liên hệ</a></li>
				</ul>
			</nav>
		</div>
		<div class="right">
			<span class="btn-search" id="searchToggle"><i
				class="fas fa-search"></i></span>
			<div class="account-area">
				<i class="fas fa-user-circle toggle-icon"></i>
				<ul class="login-session" <c:if test="${!isUser}">active</c:if> >
					<li><a href="${base}/login"><i class="fas fa-sign-in-alt"></i>
							Đăng nhập</a></li>
					<li><a href="${base}/register"><i class="fas fa-user-plus"></i>
							Đăng ký</a></li>
				</ul>
				<ul class="info-session" <c:if test="${isUser}">active</c:if> >
					<li><a href="${base}/user/account"><i class="fas fa-user"></i>
							Tài khoản</a></li>
					<li><a href="${base}/logout"><i
							class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
				</ul>
			</div>
			<div
				<c:if test="${cart!=null }">
				  class='cart-wrapper having-item'
				</c:if>
				<c:if test="${cart==null }">
				  class='cart-wrapper'
				</c:if>>
				<i class="fas fa-shopping-cart"></i> <span class="number-indicator">${cart!=null ? cart.cartItemCount : 0}</span>
				<div class="preview">
					<ul class="cart-item-list">
						<!--  -->
						<c:forEach items="${cart.cartItems }" var="item">
							<li class="cart-item">
								<div class="img-parent">
									<img src="${base }/images/disk/${item.avatarPath}" alt="" />
								</div>
								<div class="info">
									<h3 class="name">${item.name}</h3>
									<p class="size">${item.sizeNo}</p>
									<p class="quantity">${item.quantity}</p>
									<p class="price"><fmt:setLocale value="vi_VN" scope="session" />
							<fmt:formatNumber value="${item.price}" type="currency" />
									</p>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="checkout">
						<div class="total">
							<div class="text">Tổng</div>
							<div class="money">
							<fmt:setLocale value="vi_VN" scope="session" />
							<fmt:formatNumber value="${cart.totalPrice}" type="currency" />
							</div>
						</div>
						<a href="${base}/cart" class="btn">Xem chi tiết</a>
					</div>
					<div class="empty-cart">
						<div class="img-parent">
							<img src="${base }/images/user/exception/empty-cart.png"
								alt="giỏ hàng trống" />
						</div>
						<p class="text">Giỏ hàng trống, hãy mua sắm nào!</p>
					</div>
					<span class="btn-escape">&times;</span>
				</div>
			</div>
		</div>
	</div>
</header>

<script>
	$("#searchToggle").on("click", function(e) {
		$(".search-box").toggleClass("on");
		$(".search-box form input").focus();
	});

	$("#menuToggle").on("click", function(e) {
		$(".header > .bottom > .center").toggleClass("on");
		$("body").toggleClass("on");
	});

	// add padding top to show content behind navbar
	$("body").css("padding-top", $(".smart-scroll").outerHeight() + "px");

	// detect scroll top or down
	if ($(".smart-scroll").length > 0) {
		// check if element exists
		var last_scroll_top = 0;
		$(window).on(
				"scroll",
				function() {
					scroll_top = $(this).scrollTop();
					if (scroll_top < last_scroll_top) {
						$(".smart-scroll").removeClass("scrolled-down")
								.addClass("scrolled-up");
					} else {
						$(".smart-scroll").removeClass("scrolled-up").addClass(
								"scrolled-down");
					}
					last_scroll_top = scroll_top;
				});
	}

	$(".toggle-icon").on("click", function() {
		$(this).siblings("[active]").toggleClass("on");
		console.log("toggle");
	});

	/*
	* preview cart ẩn hiện
	*/
	$(".cart-wrapper > i").on("click", function() {
		$(this).siblings(".preview").toggleClass("on");
	});
	
	$('.cart-wrapper .preview .btn-escape').on('click', function() {
		$(this).parent(".preview"). toggleClass("on");
	});
	
</script>
