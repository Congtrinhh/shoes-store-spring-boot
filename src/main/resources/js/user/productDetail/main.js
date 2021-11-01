$(window).on('load', function() {
	
	$('.btn-increase').on('click', function(event) {
		if ($('#productOption').valid()) {
			let currentValue = Number($('[name="product-quantity"]').attr('value'));
			let inStockQuantity;
			$('.hidden-product-detail-wrapper .hidden-product-detail-item [name="size-no"]').each(function(){
				if ($(this).attr('value') == $('select[name="productSize"]').val()) {
					inStockQuantity = 	$(this).parent().find('[name="in-stock-quantity"]').attr('value');
				}
			})
			if (currentValue < inStockQuantity) {
				$('[name="product-quantity"]').attr('value', currentValue + 1);
				$(this).parent().siblings('.error-message').html('');
			} else {
				$(this).parent().siblings('.error-message').html('Chỉ còn ' + inStockQuantity + ' sản phẩm trong kho');
				$(this).parent().siblings('.error-message').addClass('on');
			}

		} else {
			console.log('chon size truoc')
		}
	})

	$('.btn-decrease').on('click', function(event) {
		if ($('#productOption').valid()) {
			let currentValue = Number($('[name="product-quantity"]').attr('value'));
			if (currentValue >= 1) {
				$('[name="product-quantity"]').attr('value', currentValue - 1);
				$(this).parent().siblings('.error-message').html('');
			}
		} else {

		}
	})


	$('.carousel .carousel-indicators > li:first-child').addClass('active');
	$('.carousel .carousel-inner .carousel-item:first-child').addClass('active');
	/*
	Dùng js lấy ra giá trị đã lưu trên browser từ LocalStorage (giá trị ở đây
	là category_slug ở header của trang web, thành phần mà page nào của website
	cũng có) ->
	Gửi lên server qua hidden form với name là 'category_slug_list' gồm tên category
	và slug của nó ->
	Server check, nếu có parameter này, không cần load lại giá trị đó từ DB nữa.
	*/

	$('#productOption').validate({

		submitHandler: function(form, event) {
			event.preventDefault();
		},
		rules: {
			productSize: {
				required: true,
			}
		},
		messages: {
			productSize: {
				required: "Vui lòng chọn size"
			}
		},
		errorPlacement: function(errorElement, invalidElement) {
			errorElement.insertAfter(invalidElement);
		},
	})


	$('.btn-buy-now').on('click', function(event) {
		if ($('#productOption').valid()) {
			document.querySelector('.go-to-cart-page').click(); // go to cart page
		}
	})
	
	changePrice($('select[name="productSize"]').val());

})

// cập nhật giá + số lượng trong kho khi người dùng thay size spham
$('select[name="productSize"]').on('change', function(e){
	changePrice(e.target.value);
})

function changePrice(sizeNo){
	
	if (sizeNo) {
		
		$('.hidden-product-detail-item [name="size-no"]').each(function() {
			if ($(this).attr('value') == sizeNo) {				
				let price = $(this).parent().find('[name="price"]').attr('value');
				let inStockQuantity = $(this).parent().find('[name="in-stock-quantity"]').attr('value');
				
				price = Number(price);
				
				$('.detail__right__price__sale').html(formatToMoney(price));
				$('.detail__right__in_stock_quantity').html(inStockQuantity);
				
				
				
				let originalPrice = $('.detail__right__price').html();
				originalPrice = getNumberFromMoney(originalPrice);
				const discountPercent = Math.ceil( 100*(originalPrice-price)/originalPrice );
				
				$('.detail__right__discount_percent').html(discountPercent + "%");
			}
		})
		
	}
	
}

function addToCart(baseUrl, productId) {
	if ($('#productOption').valid()) {

		let sizeNo, sizeId, name, avatarPath, quantity, price, inStockQuantity, productSeo;
		
		$('.hidden-product-detail-item [name="size-no"]').each(function() {
			if ($(this).attr('value') == $('select[name="productSize"]').val()) {
				sizeId = $(this).parent().find('[name="size-id"]').attr('value');
				sizeNo = $(this).parent().find('[name="size-no"]').attr('value');
				name = $(this).parent().find('[name="name"]').attr('value');
				avatarPath = $(this).parent().find('[name="avatar-path"]').attr('value');
				price = $(this).parent().find('[name="price"]').attr('value');
				inStockQuantity = $(this).parent().find('[name="in-stock-quantity"]').attr('value');
				productSeo = $(this).parent().find('[name="product-seo"]').attr('value');
			}
		})
		
		quantity = $('[name="product-quantity"]').attr('value');
		
		const formData = {
			sizeNo, sizeId, name, avatarPath, quantity, price, inStockQuantity, productSeo, productId,
		} 

		$.ajax({
			url: baseUrl + "/ajax/cart/add",
			type: 'POST',
			data: JSON.stringify(formData),
			contentType: "application/json",
			success: function(response) {
				if (response != null) {
					setCartItemPreview(baseUrl, response.cart); // hàm này utils.js
					// cần class này để hiện list item và ẩn empty cart img
					$('.cart-wrapper').addClass('having-item');
					
					$(".notification").fadeIn(300).delay(4000).fadeOut(300);
				}
			}
		})

	}
}