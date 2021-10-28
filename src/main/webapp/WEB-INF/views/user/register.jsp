<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Đăng ký tài khoản</title>
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
	
	
<link rel="stylesheet" href="${base}/css/common/utils.css" />
<link rel="stylesheet" href="${base}/css/user/register/style.css" />
	
<script type="text/javascript" defer
	src="${base}/js/user/register/main.js"></script>
	
</head>
<body>
	
	<div id="app" class="container">
			<a href="${base}/" class="to-home-page"><<  Trang chủ</a>
			
            <form:form id='userForm' method='POST' action='${base}/register' modelAttribute="user">
                <h1 class="form-header">Đăng ký</h1>

                <div class='form-text'>
                    <form:input type='text' class="essential-data" path='username'  required="required" />
                    <label for='' class='label-name'>
                        <p class='content-name__placeholder'>Tên tài khoản</p>
                    </label>
                    <span></span>
                </div>

                <div class='form-text'>
                    <form:input type='email' class="essential-data" path='email'  required="required" />
                    <label for='email' class='label-name'>
                        <p class='content-name__placeholder'>Email</p>
                    </label>
                    <span></span>
                </div>

                <div class='form-text'>
                    <form:input type='password' class="essential-data" path='password'  required="required" />
                    <label for='' class='label-name'>
                        <p class='content-name__placeholder'>Mật khẩu</p>
                    </label>
                    <span></span>
                </div>

                <div class='form-text'>
                    <form:input type='password' path='confirmedPassword'  required="required" />
                    <label for='confirmed-password' class='label-name'>
                        <p class='content-name__placeholder'>Xác nhận mật khẩu</p>
                    </label>
                    <span></span>
                </div>

                <div class='form-checkbox'>
                    <input type='checkbox' name='policy-agree' id='policy-agree' value='1' required>
                    <label for='policy-agree'>Đồng ý với điều khoản của trang web này</label>
                </div>

                <form:button class="btn btn-submit" type="submit">Đăng ký</form:button>
            </form:form>
            
            <p class="error-message on">${errorMessage}</p>
			
            <div class="action">
                <a href="${base}/forget-password" class="forget-password">Quên mật khẩu</a>
                <a href="${base}/login" class="">Đăng nhập</a>
            </div>

        </div>
            <!--Loader-->
	<jsp:include page="/WEB-INF/views/user/fragment/loader.jsp"></jsp:include>
        
        <script>
        	// bật loader
        	$(window).on('load', function(){
        		$('.btn-submit').on('click', function(){
    	        	if ($("#userForm").valid()) {
    	        		$('.loader-container-parent').show();
    	        	}
            	})
        	})
        </script>
</body>
</html>