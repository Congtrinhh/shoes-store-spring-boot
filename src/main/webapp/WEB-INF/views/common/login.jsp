<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Đăng nhập</title>
<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- jQuery validation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"
	integrity="sha512-37T7leoNS06R80c8Ulq7cdCDU5MNQBwlYoy1TX/WUsLFC2eYNqtKlV0QjH7r8JpG/S0GUMZwebnVFLPd6SU5yg=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="${base}/css/common/utils.css">
<link rel="stylesheet"	href="${base}/css/common/login/style.css">
<!-- Js file - for validation with jquery validation -->
<script defer src="${base}/js/common/login/main.js"></script>
</head>
<body>


	<div id="app" class="container">
		<a href="${base}/" class="to-home-page"><<  Trang chủ</a>
		
		<form id='userForm' method='POST'
			action='${base}/perform-login'>
			<h1 class="form-header">Đăng nhập</h1>
			
			<c:if test="${param.error != null}">
				<p class="error-message on">${not empty errorMessage ? errorMessage : 'Đăng nhập không thành công, có thể do: 1. Tài khoản hoặc mật khẩu không chính xác; 2. Tài khoản chưa được kích hoạt'}</p>
				<br>
				<p class="error-message on" style="color: green; font-weight: bold">${session[SPRING_SECURITY_LAST_EXCEPTION]}</p>
			</c:if>
			
			<c:if test="${not empty registerSuccessfullyMessage}">
				<p class="error-message on" style="color: #fff; padding: 6px 10px;border-radius: 0.5rem;background: var(--tertiary-color);font-weight: bold">${registerSuccessfullyMessage}</p>
			</c:if>
			
			<div class='form-text'>
				<input type='text' name='username'  required>
				<label for='' class='label-name'>
					<p class='content-name__placeholder'>Tên tài khoản</p>
				</label> <span></span>
			</div>

			<div class='form-text'>
				<input type='password' name='password' required>
				<label for='' class='label-name'>
					<p class='content-name__placeholder'>Mật khẩu</p>
				</label> <span></span>
			</div>

			<div class='form-checkbox'>
				<input type='checkbox' name='remember-me' id='remember-me'>
				<label for='remember-me'>Remmeber me</label>
			</div>

			<button class="btn" type="submit">Đăng nhập</button>
		</form>

		<div class="action">
			<a href="${base}/forget-password" class="forget-password">Quên mật khẩu</a> <a href="${base}/register"
				class="">Đăng ký</a>
		</div>

	</div>


</body>
</html>