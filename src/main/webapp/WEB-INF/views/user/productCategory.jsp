<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>${breadcrumb }</title>
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
	crossorigin="anonymous">
<!-- fontawesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet" href="${base}/css/common/utils.css" />
<link rel="stylesheet" href="${base}/css/user/lib/header_footer.css" />
<link rel="stylesheet"
	href="${base}/css/user/lib/header_footer_responsive.css" />
<link rel="stylesheet" href="${base}/css/user/productCategory/style.css" />
<link rel="stylesheet"
	href="${base}/css/user/productCategory/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer
	src="${base}/js/user/productCategory/main.js"></script>

</head>
<body>
	<div id="app">
		<input type="hidden" name="base" value="${base }" />
		<!-- Header -->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>

		<main class="filters-and-products main container row">
			<!-- breadcrumb -->
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${base}/"><i
							class="fas fa-home"></i></a></li>
					<li class="breadcrumb-item active" aria-current="page">${breadcrumb }</li>
				</ol>
			</nav>

			<!-- filter -->
			<div class="filters col-lg-3">
				<form:form id="filter" method="get" modelAttribute="searchModel"
					action="">
					<input type="hidden" name="page" value="1" />

					<fieldset>
						<h3 class="form-header">hãng</h3>
						<form:select path="brandId" name='brandId' id='brand'
							class='form-select'>
							<option value='' selected>Tất cả</option>
							<form:options items="${brands }" itemLabel="name" itemValue="id" />
						</form:select>
					</fieldset>

					<fieldset>
						<h3 class="form-header">loại</h3>
						<form:select path="categoryId" name='categoryId' id='category'
							class='form-select'>
							<option value='' selected>Tất cả</option>
							<form:options items="${categories }" itemLabel="name"
								itemValue="id" />
						</form:select>
					</fieldset>

					<fieldset>
						<h3 class="form-header">Giá</h3>
						<form:select path="priceSort" class='form-select'>
							<form:option value=''>Mặc định</form:option>
							<form:option value='true'>giá tăng dần</form:option>
							<form:option value='false'>giá giảm dần</form:option>
						</form:select>
					</fieldset>

					<fieldset>
						<h3 class="form-header">khoảng giá</h3>
						<div class='form-price-range'>
							<form:input type='number' path="minPrice" name='from-range'
								id='from-range' placeholder='Từ' />
							<span>-</span>
							<form:input type='number' path="maxPrice" name='to-range'
								id='to-range' placeholder='đến' />
						</div>
					</fieldset>
					<form:button class="btn" id="filterBtn" type="submit">Tìm sản
						phẩm</form:button>
				</form:form>
			</div>

			<!-- item list -->
			<div class="products col-lg-9">
				<div class="product-row row">

					<c:forEach items="${products}" var="p">

						<div class="col-12 col-md-6 col-xl-4 mb-4">
							<a href="${base }/product-detail/${p.seo}" class="product">
								<div class="img-parent">
									<img src="${base }/images/disk/${p.avatar}"
										alt="a pair of shoes" />
								</div>
								<div class="info">
									<h2 class="name">${p.name}</h2>
									<p class="price">
										<fmt:setLocale value="vi_VN" scope="session" />
										<fmt:formatNumber value="${p.price }" type="currency" />
									</p>
									<span class="badge">${p.gender==true?"Nữ":"Nam"}</span>
								</div>
							</a>
						</div>

					</c:forEach>

				</div>

				<div class="pagination">
					<div class="loader-item la-line-scale la-dark">
						<div></div>
						<div></div>
						<div></div>
						<div></div>
					</div>
				</div>
			</div>
		</main>


		<!-- Footer -->
		<jsp:include page="/WEB-INF/views/user/fragment/footer.jsp"></jsp:include>

	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
</body>
</html>