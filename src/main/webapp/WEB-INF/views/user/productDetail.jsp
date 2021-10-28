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
<title>Chi tiết sản phẩm</title>
<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Jquery validation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"
	integrity="sha512-37T7leoNS06R80c8Ulq7cdCDU5MNQBwlYoy1TX/WUsLFC2eYNqtKlV0QjH7r8JpG/S0GUMZwebnVFLPd6SU5yg=="
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
<link rel="stylesheet" href="${base}/css/user/productDetail/style.css" />
<link rel="stylesheet"
	href="${base}/css/user/productDetail/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer
	src="${base}/js/user/productDetail/main.js"></script>

</head>
<body>

	<div id="app">
		<!-- Header -->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>
		
		<!-- Toast -->
			<div class="notification">
				<div class="notification-header">
					<p>Một sản phẩm vừa được thêm vào giỏ hàng</p>
				</div>
				<div class="notification-body">
					<a href="${base }/cart" class="btn">Xem giỏ hàng &gt;&gt;</a>
				</div>
			</div>

		<main class="main container">
			<!-- breadcrumb -->
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${base}/"><i
							class="fas fa-home"></i></a></li>
					<li class="breadcrumb-item active" aria-current="page">Chi tiết sản phẩm</li>
				</ol>
			</nav>

			<!-- Product -->
			<div class="product-container">
				<div class="product__detail row">
					<div class="detail__left col-12 col-md-6">

						<div>
							<div id="product-slider" class="carousel slide carousel-fade"
								data-bs-ride="">
								<ol class="carousel-indicators">
									<c:forEach items="${product.productImages}" var="img"
										varStatus="loop">
										<li data-bs-target="#product-slider"
											data-bs-slide-to="${loop.index}" class=""><img
											src="${base }/images/disk/${img.path}" alt=""></li>
									</c:forEach>
								</ol>

								<div class="carousel-inner">

									<c:forEach items="${product.productImages}" var="img">
										<div class="carousel-item">
											<img src="${base }/images/disk/${img.path}"
												class="d-block w-100" alt="...">
										</div>
									</c:forEach>

								</div>

								<a class="carousel-control-prev" href="#product-slider"
									role="button" data-bs-slide="prev"> <i
									class="fas fa-angle-left"></i> <span class="sr-only">Previous</span>
								</a> <a class="carousel-control-next" href="#product-slider"
									role="button" data-bs-slide="next"> <i
									class="fas fa-angle-right"></i> <span class="sr-only">Next</span>
								</a>
							</div>
						</div>

					</div>

					<div class="detail__right col-12 col-md-6">
						<h1 class="detail__right__header">${product.name}</h1>
						<p class="detail__right__price money">
							<fmt:setLocale value="vi_VN" scope="session" />
							<fmt:formatNumber value="${product.price }" type="currency" />
						</p>
						<p class="detail__right__price__sale money"></p>
						<p class="detail__right__discount_percent badge">10</p>
						<p class="detail__right__short-description">${product.shortDescription}</p>
						<form id='productOption' method="GET" action='${base}/cart'>
							<div class="detail__right__size select-option">
								<p class="detail__right__list-header">size</p>
								<select id="selectSize" name="productSize" form="productOption" required class="form-select" style="width: auto;">
									<option value="">- Vui lòng chọn -</option>
									<c:forEach items="${productDetails}" var="productDetail" varStatus="loop">
									<option value="${productDetail.sizeNo}" <c:if test="${loop.index eq 0}">selected</c:if> >${productDetail.sizeNo}</option> 
									</c:forEach>
								</select>
							</div>
							
							<div class="hidden-product-detail-wrapper">
								<c:forEach items="${productDetails}" var="productDetail">
								<div class="hidden-product-detail-item">
									<input type="hidden" name="product-id" value="${productDetail.productId }" />  
									<input type="hidden" name="size-id" value="${productDetail.sizeId }" />
									<input type="hidden" name="name" value="${productDetail.name }" />
									<input type="hidden" name="price" value="${productDetail.price }" />
									<input type="hidden" name="avatar-path" value="${productDetail.avatarPath }" />
									<input type="hidden" name="size-no" value="${productDetail.sizeNo }" />
									<input type="hidden" name="in-stock-quantity" value="${productDetail.inStockQuantity }" />
									<input type="hidden" name="quantity" value="${productDetail.quantity }" />
									<input type="hidden" name="product-seo" value="${productDetail.productSeo }" />
								</div>	
								</c:forEach>
							</div>
						</form>
						
						<div class="detail__right__quantity">
							<input type="button" value="-" class="btn btn-decrease">
							<input type="text" name="product-quantity" value="1" disabled>
							<input type="button" value="+" class="btn btn-increase">
						</div>
						
						<p class="detail__right__in_stock_quantity"></p>
						
						<div class="error-message" style="color:red;"></div>
						<div class="detail__right__action">
							<button class="btn btn-add-to-cart mb-2 mb-sm-0" type="submit"
								form="productOption" onclick="addToCart('${base}', ${product.id});">
								<i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
							</button>
							<button class="btn btn-buy-now mb-2 mb-sm-0" type="submit"
								form="productOption" onclick="addToCart('${base}', ${product.id});">Mua ngay</button>
						</div>
					</div>
				</div>

				<div class="product__description">
					<a class="btn" data-bs-toggle="collapse"
						href="#productDescriptionContent" role="button"
						aria-expanded="false">Mô tả chi tiết<i
						class="fas fa-angle-down"></i></a>

					<div class="collapse product__description__content"
						id="productDescriptionContent">
						<div class="card">${product.detailDescription }</div>
					</div>
				</div>
			</div>
			
			<a href="${base }/cart" class="go-to-cart-page"></a>

		</main>

		<!-- Footer -->
		<jsp:include page="/WEB-INF/views/user/fragment/footer.jsp"></jsp:include>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>