<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Index</title>
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
	
	
	<link rel="stylesheet" href="${base}/css/user/lib/utils.css" />
	<link rel="stylesheet" href="${base}/css/user/lib/header_footer.css" />
	<link rel="stylesheet" href="${base}/css/user/lib/header_footer_responsive.css" />
	<script type="text/javascript" defer src="${base}/js/user/lib/utils.js"></script>
	
</head>
<body>
	<div id="app">
		<!--Header-->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>
		<section>
			<h1>Receive information about our products</h1>
			<div>
				<input name="email" type="email" required />
				<button class="btn-submit" type="button">Send</button>
			</div>
		</section>

		<!-- Footer -->
		<jsp:include page="/WEB-INF/views/user/fragment/footer.jsp"></jsp:include></div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>
</body>
</html>