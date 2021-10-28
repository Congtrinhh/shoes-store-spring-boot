<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Trang hiển thị lỗi</title>
</head>
<link rel="stylesheet" href="${base}/css/common/utils.css" />
<style>
	body {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	min-width: 100vw;
	min-height: 100vh;
	
	}
	h1 {
	margin-bottom: 30px;}
</style>
<body>
	<h1>${errorMessage }</h1>

	<button class="btn" onclick="goBack()">Trở lại trang trước</button>
	
	
	
	<c:if test="${expired == true}">
		<form action="${base }/resendToken" method="get" style="margin-top: 20px;">
			<input type="hidden" name="token" value="${token}" />
			<button class="btn btn-resend" style="background-color: var(--secondary-color);" type="submit">Gửi lại mã xác nhận</button>
		</form>
	</c:if>

	<script>
		function goBack() {
			window.history.back();
		}
	</script>
</body>
</html>