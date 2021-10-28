<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Danh sách Liên hệ</title>

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

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- paging -->
<script defer src="${base}/js/common/jquery.simplePagination.js"></script>
<link rel="stylesheet" href="${base}/js/common/simplePagination.css">

<link rel="stylesheet" href="${base}/css/common/utils.css">
<link rel="stylesheet" href="${base}/css/admin/lib/adminSidebar.css">
<link rel="stylesheet" href="${base}/css/admin/contactList/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/contactList/main.js"></script>

</head>
<body>
	<input type="hidden" name="base" value="${base }" />

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content px-3">
			<h2 class="page-header ">Liên hệ</h2>

			<!-- filter -->
			<div class="search-wrapper">
				<h3 class="filter-header ">Bộ lọc</h3>
				<form:form action="${base }/admin/contact/list" method="get" modelAttribute="searchModel">
				
					<form:input type="hidden" path="page" name="page" />
					
					<div class="select-wrapper">
						<label for="newest">Sắp xếp</label>
						<form:select path="newest" class="form-select">
							<form:option value="true" selected="true">Mới nhất</form:option>
							<form:option value="false">Cũ nhất</form:option>
						</form:select>
					</div>

					<div class="select-wrapper">
						<label for="page">Item/trang</label>
						<form:select path="sop" id="item-per-page-select"
							class="form-select">
							<form:option value="5">5</form:option>
							<form:option value="10">10</form:option>
							<form:option value="20">20</form:option>
							<form:option value="30">30</form:option>
							<form:option value="50">50</form:option>
						</form:select>
					</div>

					<form:button type="submit" id="btnSearch" class="btn">Search</form:button>
				</form:form>
			</div>

			<!-- tổng số item của lần query -->
			<div class="total-item-of-query">
				<span>[${contactsWithPaging.totalItems}</span> <span>bản ghi]</span>
			</div>
			<table id="product" class="">
				<thead>
					<th>email</th>
					<th>message</th>
					<th>created date</th>
					<th>action</th>
				</thead>
				<tbody>
					<c:forEach items="${contactsWithPaging.data}" var="c">
						<tr class="product-row">
							<td>${c.email}</td>
							<td>${c.message}</td>
							<td>${c.createdDate }</td>
							<td>
								<!-- send email if want -->
								<button type="button" class="btn">
									<a href="mailto:${c.email }?subject=Giày99cara - " style="color:#fff;"><i class="fas fa-paper-plane"></i></a>
								</button>
								
								<!-- for delete - button trigger modal -->
								<button type="button" item-id="${c.id}"
									class="btn btn-show-modal" data-bs-toggle="modal"
									data-bs-target="#confirmModal">
									<i class="fas fa-minus-circle"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- paging -->
			<div class="row">
				<div class="col-12 d-flex justify-content-center">
					<div id="paging"></div>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">Xóa ?</h5>
							<button type="button" class="close" data-bs-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">Sau khi xóa, bản ghi sẽ không thể
							khôi phục</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-delete"
								data-bs-dismiss="modal" aria-label="Close">
								<a href="">Confirm</a>
							</button>
							<button type="button" class="btn btn-dismiss"
								data-bs-dismiss="modal">Cancel</button>
						</div>
					</div>
				</div>
			</div>

		</main>
	</div>

	<script type="text/javascript">		
		$( document ).ready(function() {
				$("#paging").pagination({
					currentPage: ${contactsWithPaging.currentPage},
			        items: ${contactsWithPaging.totalItems},
			        itemsOnPage: $('select[name="sop"]').val(),
			        onPageClick: function(pageNumber, event) {
			        	$('input[name="page"]').val(pageNumber); // pageNumber: trang bị click
			        	$('#btnSearch').trigger('click');						
					},
			    });
			});
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>