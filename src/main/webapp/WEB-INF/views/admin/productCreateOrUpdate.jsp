<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="en"></html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png"
	href="${base}/images/user/icon/fav1.png" />
<title>Sản phẩm - thêm - cập nhật</title>

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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- Summernote editor -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<link rel="stylesheet" href="${base}/css/common/utils.css">
<link rel="stylesheet" href="${base}/css/admin/lib/adminSidebar.css">
<link rel="stylesheet"
	href="${base}/css/admin/productCreateOrUpdate/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/productCreateOrUpdate/main.js"></script>


</head>
<body>

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content">



			<c:set
				value="${product.id != null ? 'Sửa sản phẩm' : 'Thêm sản phẩm'}"
				var="headerText" />
			<div class="form-header create-area__header">
				<c:out value="${headerText }" />
				<c:if test="${product.id != null}">
					<!-- nút tạo mới -->
					<div class="new">
						<a href="${base }/admin/product/create" class="btn"><i
							class="far fa-plus-square"></i> create new</a>
					</div>
				</c:if>
			</div>


			<form:form id="createForm"
				action="${base }/admin/product/create-or-update" method="post"
				enctype="multipart/form-data" modelAttribute="product">

				<form:hidden path="id" />

				<div class="select-wrapper" style=" width: 150px;">
					<label for="status">Trạng thái</label>
					<form:select path="status" class="form-select">
						<form:option value="true">Active</form:option>
						<form:option value="false">Inactive</form:option>
					</form:select>
				</div>

				<div class="wrapper-parent">
					<!-- name -->
					<div class="wrapper">
						<div class="form-text">
							<form:input path="name" required="required" />
							<label for="" class="label-name">
								<p class="content-name__placeholder">Tên sản phẩm</p>
							</label> <span></span>
						</div>
					</div>
					<!-- price -->
					<div class="wrapper">
						<div class="form-text">
							<form:input path="price" required="required" name="price" />
							<label for="" class="label-name">
								<p class="content-name__placeholder">Giá</p>
							</label> <span></span>
						</div>
					</div>

				</div>


				<div class="form-checkbox">
					<form:checkbox path="isHot" id="isHot" />
					<label for="isHot">Là sản phẩm hot</label>
				</div>

				<!-- Gender -->
				<fieldset>
					<div class="form-radio">

						<form:radiobutton path="gender" value="false" id="genderMale"
							required="required" />
						<label for="genderMale">Nam</label>
					</div>
					<div class="form-radio">

						<form:radiobutton path="gender" value="true" id="genderFemale"
							required="required" />
						<label for="genderFemale">Nữ</label>
					</div>
				</fieldset>

				<div class="fieldsets">
					<!-- brand -->
					<fieldset>
						<div class="">
							<div class="form-header">Hãng (brand)</div>
							<form:select path="brand.id" required="required">
								<option value="">-- Hãng --</option>
								<form:options items="${brands }" itemValue="id" itemLabel="name" />
							</form:select>
						</div>
					</fieldset>

					<!-- Category -->
					<fieldset>
						<div class="">
							<div class="form-header">Phân loại (category)</div>
							<form:select path="category.id" required="required">
								<option value="">-- Category --</option>
								<form:options items="${categories}" itemValue="id"
									itemLabel="name" />
							</form:select>
						</div>
					</fieldset>


					<!-- avatar -->
					<c:set value="${product.id==null ? 'required' : '' }"
						var="isRequired" />
					<fieldset>
						<div class="">
							<div class="form-header">Avatar</div>
							<input type="file" name="productAvatarFile"
								<c:out value="${isRequired }"/> />
						</div>
						<div class="image-parent">
							<img src="${base }/images/disk/${product.avatar}" alt=""
								width="100" style="margin-top: 15px">
						</div>
					</fieldset>

					<!-- Images -->
					<fieldset>
						<div class="">
							<div class="form-header">Ảnh - jpg | png | jpeg (tối đa 6
								ảnh)</div>
							<input type="file" multiple name="productImagesFile"
								<c:out value="${isRequired }" /> />
						</div>
						<div class="product-image-container">

							<c:forEach items="${product.productImages }" var="img">
								<div class="">
									<div class="image-parent">
										<img src="${base }/images/disk/${img.path}" alt="">
									</div>
								</div>
							</c:forEach>

						</div>
					</fieldset>

					<!-- short description -->
					<fieldset>
						<div class="form-header">Mô tả ngắn</div>
						<form:textarea path="shortDescription" required="required" />
					</fieldset>
					<!-- detail description -->
					<fieldset>
						<div class="form-header">Mô tả chi tiết</div>
						<form:textarea path="detailDescription" id="summernote"
							required="required" />
					</fieldset>


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
	<script>
		$('#summernote').summernote(
				{
					placeholder : 'Hello stand alone ui',
					tabsize : 2,
					height : 120,
					toolbar : [ [ 'style', [ 'style' ] ],
							[ 'font', [ 'bold', 'underline', 'clear' ] ],
							[ 'color', [ 'color' ] ],
							[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
							[ 'table', [ 'table' ] ], [ 'insert', [ 'link' ] ],
							[ 'view', [ 'fullscreen', 'codeview', 'help' ] ] ]
				});
	</script>
</body>