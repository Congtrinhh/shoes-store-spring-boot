<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html lang="en"></html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Size - thêm - cập nhật</title>

<!-- Jquery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- Bs 5 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<!-- Jquery validation -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"
	integrity="sha512-37T7leoNS06R80c8Ulq7cdCDU5MNQBwlYoy1TX/WUsLFC2eYNqtKlV0QjH7r8JpG/S0GUMZwebnVFLPd6SU5yg=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- Jquery additional methods -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/additional-methods.min.js"
	integrity="sha512-XZEy8UQ9rngkxQVugAdOuBRDmJ5N4vCuNXCh8KlniZgDKTvf7zl75QBtaVG1lEhMFe2a2DuA22nZYY+qsI2/xA=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!--fontawesome  -->	
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
	

<link rel="stylesheet" href="${base}/css/common/utils.css">
<link rel="stylesheet" href="${base}/css/admin/lib/adminSidebar.css">
<link rel="stylesheet"
	href="${base}/css/admin/sizeCreateOrUpdate/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/sizeCreateOrUpdate/main.js"></script>


</head>
<body>

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content">

			<c:set value="${size.id != null ? 'Sửa size' : 'Thêm size'}" var="headerText" />
			<div class="form-header create-area__header"><c:out value="${headerText }"/></div>

			<form:form id="createForm"
				action="${base }/admin/size/create-or-update" method="post"
				enctype="multipart/form-data" modelAttribute="size">

				<form:hidden path="id" />

				<div class="wrapper-parent">
					<div class="wrapper">
						<!-- name -->
						<div class="form-text">
							<form:input path="sizeNo" required="required"/>
							<label for="" class="label-name">
								<p class="content-name__placeholder">Size</p>
							</label> <span></span>
						</div>
						
						<div class="select-wrapper" style="margin-top: 16px;">
						<label for="status">Trạng thái</label>
						<form:select path="status" class="form-select">
							<form:option value="true">Active</form:option>
							<form:option value="false">Inactive</form:option>
						</form:select>
					</div>

					</div>

				</div>

				<form:button type="submit" class="btn btn-submit">Submit</form:button>

				<p class="error-message"></p>
			</form:form>

		</main>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>