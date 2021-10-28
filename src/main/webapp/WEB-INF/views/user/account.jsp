<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Tài khoản</title>

<!-- jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- validation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"
	integrity="sha512-37T7leoNS06R80c8Ulq7cdCDU5MNQBwlYoy1TX/WUsLFC2eYNqtKlV0QjH7r8JpG/S0GUMZwebnVFLPd6SU5yg=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- bs 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- fontawesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
	integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- css js -->
<link rel="stylesheet" href="${base}/css/common/utils.css" />
<link rel="stylesheet" href="${base}/css/user/lib/header_footer.css" />
<link rel="stylesheet"
	href="${base}/css/user/lib/header_footer_responsive.css" />
<link rel="stylesheet" href="${base}/css/user/account/style.css" />
<link rel="stylesheet" href="${base}/css/user/account/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer
	src="${base}/js/user/account/main.js"></script>
</head>
<body>

	<div id="app">
		<!-- Header -->
		<jsp:include page="/WEB-INF/views/user/fragment/header.jsp"></jsp:include>

		<nav aria-label="breadcrumb" class="container">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="${base}/"><i
						class="fas fa-home"></i></a></li>
				<li class="breadcrumb-item active" aria-current="page">Tài
					khoản</li>
			</ol>
		</nav>

		<div class="main row container  mt-4 mt-md-0">

			<!-- Main content - user info -->
			<main class="col-12 col-md-8 col-lg-8  mt-4 mt-md-0">
				<h1 class="form-header">Thông tin cá nhân</h1>
				<form:form id='userForm' method="post" modelAttribute="user"
					action="">
					<form:hidden path="id" />
					<!-- user name -->
					<div class='form-text'>
						<label class=''>Tên tài khoản (*)</label>
						<form:input type='text' path='username' required="required"
							placeholder="Ví dụ: congtrinhh2001" />
					</div>
					<!-- full name -->
					<div class='form-text'>
						<label class=''>Họ và tên</label>
						<form:input type='text' path="fullName" placeholder="Ví dụ: Trịnh Quý Minh" />
					</div>
					<!-- sdt -->
					<div class='form-text'>
						<label class=''>Số điện thoại</label>
						<form:input path='phone' placeholder="Ví dụ: 0333546124" />
					</div>
					<!-- email -->
					<div class='form-text'>
						<label class=''>Email (*)</label>
						<form:input type='email' path='email' required="required"
							placeholder="Ví dụ: payacc@gmail.com" />
					</div>
					<!-- địa chỉ hiện tại -->
					<div class='form-text'>
						<label class=''>Địa chỉ</label>
						<form:input type='text' path='address' disabled="true" />
						<span class="add-address-icon add"><i
							class="fas fa-times cancel"></i></span>
					</div>

					<div class="update-address-wrapper">
						<!-- tinh tp quan huyen -->
						<fieldset class="select-wrapper">
							<label class=''>Tỉnh thành</label>
							<div class="selects">
								<select name='province' id='province' class='form-select'
									required>
									<option value=''>Tỉnh/thành phố</option>
									<c:forEach items="${provinces}" var="p">
										<option value="${p.id}"
											<c:if test="${p.id==province.id}">selected</c:if>>${p.name}</option>
									</c:forEach>
								</select> <select name='district' id='district' class='form-select'
									required>
									<option value=''>Quận/huyện</option>
									<c:if test="${district!=null}">
										<option value='${district.id}' selected>${district.name}</option>
									</c:if>
								</select> <select name='ward' id='ward' class='form-select' required>
									<option value=''>Xã/phường</option>
									<c:if test="${ward!=null}">
										<option value='${ward.id}' selected>${ward.name}</option>
									</c:if>
								</select>
							</div>
						</fieldset>
						<!-- địa chỉ cụ thể -->
						<div class='form-text'>
							<label class=''>Địa chỉ</label> <input type='text'
								name='specific-address' placeholder="Ví dụ: 30 Ngô Quyền" />
						</div>
					</div>


					<!-- Đổi mk -->
					<button class="btn-show" type="button">Đổi mật khẩu</button>
					<fieldset class="update-password-area">
						<!-- mk cu -->
						<div class='form-text'>
							<label class=''>Mật khẩu hiện tại</label> <input type='password'
								name='current-password' required placeholder="">
						</div>
						<!-- mk moi -->
						<div class='form-text'>
							<label class=''>Mật khẩu mới</label> <input type='password'
								name='new-password' required
								placeholder="Ít nhất 6 ký tự, cả chữ cái và số">
						</div>
						<!-- mk nhap lai -->
						<div class='form-text'>
							<label class=''>Nhập lại</label> <input type='password'
								name='confirmed-password' required
								placeholder="Ít nhất 6 ký tự, cả chữ cái và số">
						</div>
					</fieldset>

					<form:button type="submit" class="btn btn-submit">Cập nhật</form:button>

					<p class="error-message">${errorMessage }</p>
				</form:form>
			</main>

			<!-- User nav -->
			<jsp:include page="/WEB-INF/views/user/fragment/leftNavigation.jsp"></jsp:include>
		</div>

		<!-- Footer -->
		<jsp:include page="/WEB-INF/views/user/fragment/footer.jsp"></jsp:include>

	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>