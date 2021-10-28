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
<title>Kết quả tìm kiếm</title>
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
<link rel="stylesheet" href="${base}/css/user/search/style.css" />
<link rel="stylesheet" href="${base}/css/user/search/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer
	src="${base}/js/user/search/main.js"></script>

</head>
<body>
	<div id="app">
		<input type="hidden" name="base" value="${base }" />
		<input type="hidden" name="page" value="1" />
		<!-- Header -->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>

		<main class="filters-and-products main container row">
			<!-- breadcrumb -->
			<nav aria-label="breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${base}/"><i
							class="fas fa-home"></i></a></li>
					<li class="breadcrumb-item active" aria-current="page">Tìm
						kiếm</li>
				</ol>
			</nav>

			<!-- heading -->
			<div class="form-header search-header">Kết quả tìm kiếm cho
				"${searchModel.keyword }"</div>
			<!-- search box -->
			<div class="search-box">
				<form:form id="searchForm" method="GET" action="${base }/search" modelAttribute="searchModel">
					<form:input path="keyword" placeholder="Nhập tên một đôi giày ..." />
					<form:button class="btn-search" type="submit">
						<i class="fas fa-search"></i> Search
					</form:button>
				</form:form>
			</div>

			<!-- item list -->
			<div class="products col-lg-12">
				<div class="product-row row">

					<c:forEach items="${products}" var="p">

						<div class="col-12 col-sm-6 col-md-4 col-xl-3 mb-4">
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