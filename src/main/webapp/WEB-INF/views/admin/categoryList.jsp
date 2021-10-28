<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Danh sách Danh mục (category)</title>
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
<link rel="stylesheet" href="${base}/css/admin/categoryList/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/categoryList/main.js"></script>

</head>
<body>
	<input type="hidden" name="base" value="${base }" />

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content px-3">
			<h2 class="page-header ">Category</h2>
			<div class="new">
				<a href="${base }/admin/category/create" class="btn"><i
					class="far fa-plus-square"></i> create new</a>
			</div>
			<div class="search-wrapper">
				<h3 class="filter-header ">Bộ lọc</h3>
				<form:form action="${base }/admin/category/list" method="get" modelAttribute="searchModel">
					<form:input type="hidden" path="page" name="page" />

					<div class="form-text">
						<label for="keyword">Từ khóa</label>
						<form:input type="text" path="keyword" placeholder="keyword" />
						<span class="btn-reset">&times;</span>
					</div>

					<div class="select-wrapper">
						<label for="status">Trạng thái</label>
						<form:select path="status" class="form-select">
							<form:option value="">All</form:option>
							<form:option value="true">Active</form:option>
							<form:option value="false">Inactive</form:option>
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
				<span>[${categoriesWithPaging.totalItems}</span> <span>bản ghi]</span>
			</div>

			<table id="product" class="">

				<thead>
					<th>name</th>
					<th>description</th>
					<th>status</th>
					<th>created date</th>
					<th>updated date</th>
					<th>action</th>
				</thead>
				<tbody>
					<c:forEach items="${categoriesWithPaging.data}" var="c">
						<tr class="product-row">
							<td>${c.name}</td>
							<td>${c.description}</td>
							<td <c:if test="${c.status==true}">class="status on"</c:if>
								<c:if test="${c.status==false}">class="status"</c:if>></td>
							<td>${c.createdDate }</td>
							<td>${c.updatedDate }</td>
							<td>
								<!-- for update --> <a class="btn btn-update"
								href="${base}/admin/category/update/${c.id}" item-id="${c.id}"><i
									class="fas fa-pen-square"></i></a> <!-- for delete - button trigger modal -->
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
					currentPage: ${categoriesWithPaging.currentPage},
			        items: ${categoriesWithPaging.totalItems},
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