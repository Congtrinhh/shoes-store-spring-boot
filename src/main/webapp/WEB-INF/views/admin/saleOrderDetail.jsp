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
<title>Chi tiết đơn hàng</title>

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
<link rel="stylesheet" href="${base}/css/admin/saleOrderDetail/style.css">
<script defer src="${base}/js/common/utils.js"></script>
<script defer src="${base}/js/admin/lib/adminSidebar.js"></script>
<script defer src="${base}/js/admin/saleOrderDetail/main.js"></script>

</head>
<body>
	<input type="hidden" name="base" value="${base }" />

	<div id="app">
		<!-- sidebar and logo top -->
		<jsp:include page="/WEB-INF/views/admin/fragment/sidebar.jsp"></jsp:include>

		<main class="content px-3">
			<h2 class="page-header ">Chi tiết đơn hàng</h2>
			<div class="sale-order-info-wrapper" >
			<p>Tên khách hàng: <b>${saleOrder.customerName }</b></p>
			<p>Code: <b>${saleOrder.code }</b></p>
			<p>Emai: <b>${saleOrder.customerEmail }</b></p>
			<p>Số điện thoại: <b>${saleOrder.customerPhone }</b></p>
			<p>Địa chỉ: <b>${saleOrder.customerAddress }</b></p>
			<p>Tổng tiền: <b class="vnd">${saleOrder.total }</b></p></div>
			<table id="product" class="">
				<thead>
					<th>name</th>
					<th>quantity (số lượng)</th>
					<th>size</th>
					<th>avatar</th>
					<th>action</th>
				</thead>
				<tbody>
					<c:forEach items="${saleOrder.saleOrderProducts}" var="sop">
						<tr class="product-row">
							<td>${sop.productSize.product.name }</td>
							<td>${sop.quantity }</td>
							<td>${sop.sizeNo }</td>
							<td> <a href="${base }/product-detail/${sop.productSize.product.seo}"><img alt="Đôi giày" width="100" src="${base }/images/disk/${sop.productSize.product.avatar}"></a> </td>
							<td>
								<!-- for delete - button trigger modal -->
								<button type="button" item-id="${sop.id}"
									class="btn btn-show-modal" data-bs-toggle="modal"
									data-bs-target="#confirmModal">
									<i class="fas fa-minus-circle"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>