<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Product create</title>

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

<link rel="stylesheet" href="${base}/css/common/utils.css">
<link rel="stylesheet" href="${base}/css/admin/lib/adminSidebar.css">
<link rel="stylesheet" href="${base}/css/admin/productUpdate/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/productUpdate/main.js"></script>


</head>
<body>

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content">
			<div class="form-header create-area__header">T???o d??ng s???n ph???m
				m???i</div>
			<form id='createForm' action='${base }/admin/product/${product.id}'
				method='POST' enctype="multipart/form-data">
				<!-- ID -->
				<input type="hidden" name="id" value="${product.id}" />
				
				<!-- name -->
				<div class='form-text'>
					<input type='text' name='name' placeholder='' required="required"
						value="${product.name}" /> <label for='' class='label-name'>
						<p class='content-name__placeholder'>T??n s???n ph???m</p>
					</label> <span></span>
				</div>

				<!-- seo -->
				<div class='form-text'>
					<input type='text' name='seo' placeholder='' required="required"
						value="${product.seo}" /> <label for='' class='label-name'>
						<p class='content-name__placeholder'>Seo</p>
					</label> <span></span>
				</div>

				<!-- price -->
				<div class='form-text'>
					<input type='number' name='price' placeholder=''
						required="required" value="${product.price}" /> <label for=''
						class='label-name'>
						<p class='content-name__placeholder'>Gi??</p>
					</label> <span></span>
				</div>

				<!-- price sale -->
				<div class='form-text'>
					<input type='number' name='price-sale' placeholder=''
						required="required" value="${product.priceSale}" /> <label for=''
						class='label-name'>
						<p class='content-name__placeholder'>Gi?? sale</p>
					</label> <span></span>
				</div>

				<div class="form-checkbox">
					<input type="checkbox" name="is-hot" id="isHot" value="hot" <c:if test="${product.isHot==true }">checked</c:if> /> <label
						for="isHot">L?? s???n ph???m hot</label>
				</div>

				<div class="fieldsets">
					<!-- brand -->
					<fieldset>
						<div class="">
							<div class="form-header">
								<span>H??ng: ${product.brand.name}</span>
								<button class="btn btn-edit">
									<i class="far fa-edit"></i>
								</button>
							</div>
							<select name='brand' class='form-select' required>
								<option value="">- Ch???n brand -</option>
								<c:forEach items="${brands}" var="brand">
									<option value="${brand.id}"
										<c:if test="${brand.name == product.brand.name}">selected</c:if>>${brand.name}</option>
								</c:forEach>
							</select>
						</div>
					</fieldset>

					<!-- Category -->
					<fieldset>
						<div class="">
							<div class="form-header">
								<span>Ph??n lo???i: ${product.category.name}</span>
								<button class="btn btn-edit">
									<i class="far fa-edit"></i>
								</button>
							</div>
							<select name='category' class='form-select' required>
								<option value="">- Ch???n category -</option>
								<c:forEach items="${categories}" var="cate">
									<option value="${cate.id}"
										<c:if test="${cate.name == product.category.name}">selected</c:if>>${cate.name}</option>
								</c:forEach>
							</select>
						</div>
					</fieldset>

					<!-- Image -->
					<fieldset>
						<div class="form-header">
							<span>???nh</span>
							<button class="btn btn-edit">
								<i class="far fa-edit"></i>
							</button>
						</div>

						<div class="image-upload-container">
							<p>
								Th??m ???nh m???i (?????nh d???ng <b>jpg</b>, <b>png</b>, <b>jpeg</b>, t???i
								??a <b>6</b> ???nh)
							</p>
							<div class="image-preview-container product-image-container"></div>
							<input type="file" multiple name="images">
						</div>

						<div class="product-image-container">
							<c:forEach items="${product.productImages}" var="image">
								<div class="">
									<div class="image-parent">
										<img src="${base }/images/local${image.path}" alt="">
										<button image-id="${image.id}" class="btn btn-delete-image">&times;</button>
									</div>
								</div>
							</c:forEach>
						</div>
					</fieldset>

					<!-- Gender -->
					<fieldset>
						<div class="form-radio">
							<input type="radio" name="gender" value="false"
								id="genderMale" <c:if test="${product.gender==false }">checked</c:if> /> <label for="genderMale">Nam</label>
						</div>
						<div class="form-radio">
							<input type="radio" name="gender" value="true" id="genderFemale" <c:if test="${product.gender==true}">checked</c:if> />
							<label for="genderFemale">N???</label>
						</div>
					</fieldset>

					<!-- short description -->
					<fieldset>
						<button class="btn btn-restore">
							<i class="fas fa-redo-alt"></i>
						</button>
						<div class="form-header">M?? t??? ng???n</div>
						<textarea name="short-description" cols="30" rows="4" ><c:out value="${product.shortDescription}" /></textarea>
					</fieldset>

					<!-- detail description -->
					<fieldset>
						<button class="btn btn-restore">
							<i class="fas fa-redo-alt"></i>
						</button>
						<div class="form-header">M?? t??? chi ti???t</div>
						<textarea name="detail-description" cols="30" rows="4" ><c:out value="${product.detailDescription}" /></textarea>
					</fieldset>
				</div>

				<!-- images will be deleted -->
				<div class="delete-queue">
					<input type='hidden' name='delete-queue-id' />
				</div>

				<button type="submit" class="btn btn-submit">Submit</button>

				<p class="error-message"></p>

			</form>
		</main>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>