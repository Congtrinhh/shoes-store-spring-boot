<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Kích hoạt tài khoản thành công</title>
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
	<h1>Chúc mừng, bạn đã kích hoạt tài khoản thành công!</h1>

	<a href="${base }/login" class="btn" >Đăng nhập ngay</a>

</body>
</html>