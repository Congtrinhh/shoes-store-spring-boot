<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/variable.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="${base}/images/user/icon/fav1.png"/>
<title>Checkout</title>
<!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    <!-- validation -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"
        integrity="sha512-37T7leoNS06R80c8Ulq7cdCDU5MNQBwlYoy1TX/WUsLFC2eYNqtKlV0QjH7r8JpG/S0GUMZwebnVFLPd6SU5yg=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
        integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

<link rel="stylesheet" href="${base}/css/common/utils.css" />
<link rel="stylesheet" href="${base}/css/user/lib/header_footer.css" />
<link rel="stylesheet"
	href="${base}/css/user/lib/header_footer_responsive.css" />
<link rel="stylesheet" href="${base}/css/user/checkout/style.css" />
<link rel="stylesheet" href="${base}/css/user/checkout/responsive.css" />
<script type="text/javascript" defer src="${base}/js/common/utils.js"></script>
<script type="text/javascript" defer src="${base}/js/user/checkout/main.js"></script>

</head>
<body>
	<div id="app">
		
		<main class="main container">
            <!-- breadcrumb -->
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${base}/"><i
							class="fas fa-home"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">checkout</li>
                </ol>
            </nav>
            
          
            <c:if test="${message!=null}"> <p class="error-message on">${message}</p> </c:if> 
         
            

            <!-- main -->
            <div class="contact-address-and-product-overview row">
                <div class="contact-address col-12 col-lg-5">
		            <c:if test="${not empty successfulMessage}">
		            	<div class="noti" style="margin-bottom: 3px;">${successfulMessage}</div>
		            	<a href="${base }/" class="btn" style="background-color: var(--secondary-color);margin-bottom: 20px;">Trang chủ &gt;&gt;</a>
		            </c:if>
                    <h2 class="form-header">Địa chỉ liên hệ</h2>
                    <form:form id='orderContactAddress' method='POST' action='/checkout' modelAttribute="user">
                    
                    	<form:hidden path="id"/>
                    	
                        <div class='form-text'>
                            <form:input type='text' path='fullName' required="required" />
                            <label class='label-name'>
                                <p class='content-name__placeholder'>Họ và tên</p>
                            </label>
                            <span></span>
                        </div>
                        <div class='form-text'>
                            <form:input type='number' path='phone' required="required" />
                            <label class='label-name'>
                                <p class='content-name__placeholder'>Số điện thoại</p>
                            </label>
                            <span></span>
                        </div>
                        <div class='form-text'>
                            <form:input type='email' path='email' required="required" />
                            <label class='label-name'>
                                <p class='content-name__placeholder'>Email</p>
                            </label>
                            <span></span>
                        </div>
                        
                        <div class='form-text'>
                            <form:input type='text' path='address' required="required" />
                            <label class='label-name'>
                                <p class='content-name__placeholder'>Địa chỉ</p>
                            </label>
                            <span></span>
                        </div> 
                        
                       

                        <div class = "address-container-parent">
                        <div class="address-container">
                            <fieldset>
                                <select name="province" required>
                                    <option value="">Tỉnh/thành phố</option>
                                    <c:forEach items="${provinces}" var="p">
                                    	<option class="option-province" value="${p.id}">${p.name}</option>
                                    </c:forEach>
                                </select>
                            </fieldset>
                            
                            <fieldset>
                                <select name="district" required>
                                    <option value="">Quận/huyện</option>
                                </select>
                            </fieldset>
                            
                            <fieldset>
                                <select name="ward" required>
                                    <option value="">Xã/phường</option>
                                </select>
                            </fieldset>
                        </div>
                        <div class='form-text'>
                            <input type='text' name='specific-address' required />
                            <label class='label-name'>
                                <p class='content-name__placeholder'>Địa chỉ cụ thể</p>
                            </label>
                            <span></span>
                        </div>
                        </div>
                    </form:form>
                </div>

                <div class="product-overview col-12 col-lg-7 mt-5 mt-lg-0">
                    <div class="row">
                        <div class="cart__products__left col-12 col-sm-12">
                            <div class="table">
                                <div class="tbody">
                                    <c:forEach items="${cart.cartItems }" var="item">
                                    <div class="tr product-row row mb-4">
                                        <div class="td col-12 col-sm-12 col-lg-8">
                                            <div class="product__container">
                                                <input type="text" hidden name="hidden-product-id" value="">
                                                <a class="parent-image" href="${base }/product-detail/${item.productSeo}">
                                                    <img src="${base }/images/disk/${item.avatarPath}" alt="">
                                                    <div class="quantity-container">
                                                        <input type="text" name="product-quantity" disabled value="${item.quantity }">
                                                    </div>
                                                </a>
                                                <div class="card__product-info">
                                                    <h2 class="card__product-info__name">${item.name }</h2>
                                                    <p class="card__product-info__size">size ${item.sizeNo }</p>
                                                </div>
                                            </div>
                                        </div>
                        
                                        <div class="td col-6 col-sm-4 col-lg-2 mt-4 mt-lg-0 offset-sm-4 offset-lg-0">
                                            <p class="initial-price money">
                                            	<fmt:setLocale value="vi_VN" scope="session" />
												<fmt:formatNumber value="${item.price }" type="currency" />
                                            </p>
                                        </div>
                        
                                        <div class="td col-6 col-sm-4 col-lg-2 mt-4 mt-lg-0 ">
                                            <p class="total-price money">
                                            	<fmt:setLocale value="vi_VN" scope="session" />
												<fmt:formatNumber value="${item.price * item.quantity }" type="currency" />
                                            </p>
                                        </div>
                                    </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        
                        <div class="cart__products__right col-12 col-sm-12 mt-5 mt-lg-0">
                            <div class="apply-coupon">
                                <input type="text" disabled placeholder="Coupon của bạn...">
                                <button class="btn">apply coupon</button>
                            </div>
                        
                            <div class="card__total-price">
                                <ul>
                                    <li>
                                        <p class="title">Tạm tính</p>
                                        <p class="price money subtotal-price">
                                        	<fmt:setLocale value="vi_VN" scope="session" />
											<fmt:formatNumber value="${cart.totalPrice }" type="currency" />
                                        </p>
                                    </li>
                                    <li>
                                        <p class="title">Vận chuyển</p>
                                        <p class="price money delivery-price"></p>
                                    </li>
                                    <li>
                                        <p class="title">Discount</p>
                                        <p class="price money discount-price"></p>
                                    </li>
                                    <hr>
                                    <li>
                                        <p class="title">Tổng</p>
                                        <p class="price money total-price"></p>
                                    </li>
                                </ul>
                            </div>
                        
                            <p class="error-message"></p>
                            <div class="confirm-checkout">
								<a href="${base}/cart" ><i class="fas fa-angle-double-left"></i> Quay lại giỏ hàng</a>                                
                                <button type="submit" class="btn btn-submit" form="orderContactAddress">Mua hàng</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

	<!--Loader-->
	<jsp:include page="/WEB-INF/views/user/fragment/loader.jsp"></jsp:include>

	</div>
	        <script>
        	// bật loader
        	$(window).on('load', function(){
        		$('.btn-submit').on('click', function(){
    	        	if ($("#orderContactAddress").valid()) {
    	        		$('.loader-container-parent').show();
    	        	}
            	})
        	})
        </script>
</body>
</html>