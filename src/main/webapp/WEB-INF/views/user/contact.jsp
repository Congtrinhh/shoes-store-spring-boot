<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Liên hệ</title>
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
<link rel="stylesheet" href="${base}/css/user/contact/style.css" />
<link rel="stylesheet" href="${base}/css/user/contact/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer
	src="${base}/js/user/contact/main.js"></script>

</head>
<body>

	<div id="app">
		<!-- Header -->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>

		<main class="main">
			<!-- breadcrumb -->
			<nav aria-label="breadcrumb" class="container">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="${base}/"><i
							class="fas fa-home"></i></a></li>
					<li class="breadcrumb-item active" aria-current="page">Liên hệ</li>
				</ol>
			</nav>

			<!-- Contact -->
			<div class="main-content">
				<div class="contact-wrapper container">
					<div class="contact">
						<h2 class="contact-header">Liên hệ</h2>
						
						<c:if test="${not empty message}">
							<div class="noti" style="margin-top: 20px;">${message}</div>
						</c:if>
						
						<form:form id="contactForm" method="POST" action="${base}/contact"
							modelAttribute="contact">
							<div class="form-text">
								<label class="form-label" for="email">Email</label>
								<form:input type="email" path="email" placeholder=""
									required="true" />
							</div>
							<div class="form-text">
								<label class="form-label" for="message">Tin nhắn</label>
								<form:textarea path="message" required="true" />
							</div>
							<form:button type="submit" class="btn btn-submit">Gửi</form:button>
						</form:form>
					</div>
				</div>
			</div>

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