<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<aside class="nav">
	<h2 class="logo px-4 py-2">Giày99cara</h2>

	<ul class="parent-menu px-4">
	
		<!-- Don hang -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-3" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Đơn hàng</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-3">
				<li><a href="${base}/admin/sale-order/list">Danh sách</a></li>
			</ul>
		</li>
		
		<!-- Lien he -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-4" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Liên hệ</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-4">
				<li><a href="${base}/admin/contact/list">Danh sách</a></li>
			</ul>
		</li>
		
		<!-- Sản phẩm tổng quát -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-1" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Catalog</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-1">
				<li><a href="${base}/admin/product/list">Danh sách</a></li>
				<li><a
					href="${base}/admin/product/create">Thêm</a></li>
			</ul>
		</li>
		
		<!-- Sản phẩm cụ thể -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-2" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Sản phẩm</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-2">
				<li><a href="${base}/admin/product-size/list">Danh sách</a></li>
				<li><a
					href="${base}/admin/product-size/create">Thêm</a></li>
			</ul>
		</li>
		
		<!-- User -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-8" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>User</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-8">
				<li><a href="${base}/admin/user/list">Danh sách</a></li>
				<li><a href="${base}/admin/user/create">Thêm</a></li>
			</ul>
		</li>
				
			
		<!-- Hãng -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-5" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Hãng</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-5">
				<li><a href="${base}/admin/brand/list">Danh sách</a></li>
				<li><a href="${base}/admin/brand/create">Thêm</a></li>
			</ul>
		</li>
		
		<!-- Category -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-6" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Thể loại</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-6">
				<li><a href="${base}/admin/category/list">Danh sách</a></li>
				<li><a href="${base}/admin/category/create">Thêm</a></li>
			</ul>
		</li>
		
		<!-- Size -->
		<li>
			<a data-bs-toggle="collapse" href="#sub-menu-7" role="button"
			aria-expanded="false" aria-controls="collapseExample"> <span>Size</span>
				<span class="child-menu__trigger"><i
					class="fas fa-caret-right"></i></span>
			</a>
			<ul class="child-menu collapse collapse px-3" id="sub-menu-7">
				<li><a href="${base}/admin/size/list">Danh sách</a></li>
				<li><a href="${base}/admin/size/create">Thêm</a></li>
			</ul>
		</li>
		
		<li><a href="${base}/admin" class="">dashboard</a></li>

		<li><a href="${base}/" class="">home
				page</a></li>
	</ul>
</aside>

<main class="content__top">
	<h1 class="page__header"></h1>

	<div id="nav__toggle" class="on">
		<i class="nav__toggle__close fas fa-bars"></i>
		<!-- <i class="nav__toggle__open fas fa-caret-right"></i> -->
	</div>

	<div class="admin-info">
		<p class="admin-name badge">${loginedUser.username }</p>
		<a href="${base }/logout" style="font-size:15px;">Đăng xuất</a>
	</div>
</main>