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
<title>Quên mật khẩu</title>
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
			action='${base}/forget-password'>
			<h1 class="form-header">Quên mật khẩu</h1>
			
			<c:if test="${errorMessage != null}">
				<p class="error-message on">${errorMessage}</p>
			</c:if>
			
			<c:if test="${not empty successfulMessage}">
				<p class="error-message on" style="color: #fff; padding: 6px 10px;border-radius: 0.5rem;background: var(--tertiary-color);font-weight: bold">${successfulMessage}</p>
			</c:if>
			
			<div class='form-text'>
				<input type='email' name='email'  required email>
				<label for='' class='label-name'>
					<p class='content-name__placeholder'>Email</p>
				</label> <span></span>
			</div>

			<button class="btn" type="submit">Tiếp tục</button>
		</form>

		<div class="action">
			<a href="${base}/login">Đăng nhập</a> <a href="${base}/register"
				class="">Đăng ký</a>
		</div>

	</div>
	
	<!--Loader-->
	<jsp:include page="/WEB-INF/views/user/fragment/loader.jsp"></jsp:include>	

	<script>
       	// bật loader
       	$(window).on('load', function(){
       		$('.btn[type="submit"]').on('click', function(){
   	        	if ($("#userForm").valid()) {
   	        		$('.loader-container-parent').show();
   	        	}
           	})
       	})
    </script>
</body>
</html>