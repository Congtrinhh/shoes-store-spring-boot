<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Thành công</title>
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
	<h1 style="background-color:var(--tertiary-color); color: #fff;padding: 10px;border-radius: .5rem;">${message}</h1>

	<a class="btn" href="${base }/">Về trang chủ</a>

</body>
</html>