<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Trang chủ</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous" />
<!-- Fontawesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />


<link rel="stylesheet" href="${base}/css/common/utils.css" />
<link rel="stylesheet" href="${base}/css/user/lib/header_footer.css" />
<link rel="stylesheet"
	href="${base}/css/user/lib/header_footer_responsive.css" />
<link rel="stylesheet" href="${base}/css/user/home/style.css" />
<link rel="stylesheet" href="${base}/css/user/home/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer src="${base}/js/user/home/main.js"></script>

</head>
<body>
	<div id="app">
		<!--Header-->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>

		<!-- Slider -->
		<div class="slider" id="main-slider">
			<div class="slides__wrapper">
				<div class="slide"
					style="
							background-image: url('${base}/images/user/cta/cta-1.jpg');
						">
					<div class="slide__info">
						<p class="slide__info__header">New arrivals</p>
						<a href="${base }/new-arrivals" class="btn btn-cta button button-pulse">Go
							shop</a>
					</div>
				</div>
				<div class="slide"
					style="background-image: url('${base}/images/user/cta/cta-2.jpg')">
					<div class="slide__info">
						<p class="slide__info__header">Men's collection</p>
						<a href="${base }/men" class="btn btn-cta button button-pulse">Go
							shop</a>
					</div>
				</div>
				<div class="slide"
					style="
							background-image: url('${base}/images/user/cta/cta-3.jpg');
						">
					<div class="slide__info">
						<p class="slide__info__header">Women's collection</p>
						<a href="${base }/women" class="btn btn-cta button button-pulse">
							Go shop </a>
					</div>
				</div>
			</div>
			<div class="slider__indicator">
				<div class="dot"></div>
				<div class="dot"></div>
				<div class="dot"></div>
			</div>
		</div>

		<div class="slogan container">Hàng chính hãng đến từ các tên
			tuổi lớn trong và ngoài nước</div>

		<div class="collection row">
			<div class="col-12 col-md-6 mb-5 mb-md-0">
				<div class="collection__men collection__img"
					style="background-image:url('${base}/images/user/collection/c-3.jpg')">
					<a href="${base }/men" class="btn">Mua ngay <i class="fas fa-arrow-right"></i></a>
				</div>
				<h3>Bộ sưu tập nam</h3>
				<a href="${base }/men" class="btn">Mua ngay <i class="fas fa-arrow-right"></i></a>
			</div>
			<div class="col-12 col-md-6 mb-5 mb-md-0">
				<div class="collection__women collection__img"
					style="background-image: url('${base}/images/user/collection/c-2.jpeg')">
					<a href="${base }/women" class="btn">Mua ngay <i
						class="fas fa-arrow-right"></i></a>
				</div>
				<h3>Bộ sưu tập nữ</h3>
				<a href="${base }/women" class="btn">Mua ngay <i
					class="fas fa-arrow-right"></i></a>
			</div>
		</div>

		<main class="main">
			<section class="best-sellers container">
				<h2 class="best-sellers__header">BEST SELLERS</h2>
				<div class="best-sellers__list row">
					<c:forEach items="${bestSellers}" var="p">
						<div class="col-9 col-sm-7 col-md-4 col-xl-3">
							<a href="${base }/product-detail/${p.seo}" class="product">
								<div class="img-parent">
									<img src="${base }/images/disk/${p.avatar}"
										alt="a pair of shoes" />
								</div>
								<div class="info">
									<h2 class="name">${p.name}</h2>
									<p class="price"><fmt:setLocale value="vi_VN" scope="session" />
										<fmt:formatNumber value="${p.price }" type="currency" /></p>
									<span class="badge">Bán chạy</span>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</section>

			<section class="new-arrivals container">
				<div class="top">
					<h2>New arrivals</h2>
					<a href="${base }/new-arrivals" class="">Xem tất cả</a>
				</div>
				<div class="product-area">
					<div class="products row">
					<c:forEach items="${ newArrivals}" var="p">
					<div class="wrapper col-9 col-sm-6 col-md-4 col-lg-3 col-xl-2">
						<a href="${base }/product-detail/${p.seo}" class="product">
							<div class="img-parent">
								<img src="${base}/images/disk/${p.avatar}"
									alt="a pair of shoes" />
							</div>
							<div class="info">
								<h2 class="name">${p.name}</h2>
								<p class="price"><fmt:setLocale value="vi_VN" scope="session" />
									<fmt:formatNumber value="${p.price }" type="currency" /></p>
								<span class="badge">Mới</span>
							</div>
						</a>
					</div>
					</c:forEach>
						
					</div>
					<div class="controller-container">
						<div class="left controller">
							<i class="fas fa-caret-left"></i>
						</div>
						<div class="right controller">
							<i class="fas fa-caret-right"></i>
						</div>
					</div>
				</div>
			</section>

			<section class="partners container">
				<p class="partners__header">trusted partners</p>
				<div class="partners__list row">
					<div class="col-6 col-md-4 col-lg-3 mb-4 mb-lg-0">
						<div class="partner"
							style="background-image: url('${base}/images/user/trusted_partner/brand-1.jpg')"></div>
					</div>
					<div class="col-6 col-md-4 col-lg-3 mb-4 mb-lg-0">
						<div class="partner"
							style="background-image: url('${base}/images/user/trusted_partner/brand-3.jpg')"></div>
					</div>
					<div class="col-6 col-md-4 col-lg-3 mb-4 mb-lg-0">
						<div class="partner"
							style="background-image: url('${base}/images/user/trusted_partner/brand-5.jpg')"></div>
					</div>
					<div class="col-6 col-md-4 col-lg-3 mb-4 mb-lg-0">
						<div class="partner"
							style="background-image: url('${base}/images/user/trusted_partner/brand-2.jpg')"></div>
					</div>
				</div>
			</section>
		</main>

		<!-- Footer -->
		<jsp:include page="/WEB-INF/views/user/fragment/footer.jsp"></jsp:include></div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
</body>
</html>