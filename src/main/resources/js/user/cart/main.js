const baseUrl = $('input[name="base-url"]').attr('value');

setDeliveryPrice(0)
setDiscountPrice(0)
$('.btn-continue').on('click', function(event) {
	event.preventDefault();

	if (hasItem()) {

		$.ajax({
			url: baseUrl + "/ajax/cart/next",
			type: 'post',
			data: null,
			success: function(response) {
				if (response!=null && typeof response == 'string' && response.length>0) {
					$('.continue-checkout .error-message').addClass('on');
					$('.continue-checkout .error-message').html(response);					
				}else {
					$('.continue-checkout .error-message').removeClass('on');
					$('.continue-checkout .error-message').html('');
					location.assign(baseUrl + "/checkout");
				}
			}
		});
	}
	else {
		$('.error-message').text('Không có sản phẩm, hãy mua sắm nào');
		$('.error-message').addClass('on');
	}
})

function hasItem() {
	return $('.cart__products .tbody .tr').length > 0 ? true : false;
}

toggleEmptyCartImage();
function toggleEmptyCartImage() {
	if (hasItem()) {
		$('.empty-cart').removeClass('on');
		$('.btn-continue').attr('disabled', 'disabled');
	}
	else {
		$('.empty-cart').addClass('on');
	}
}


setTotalPriceForEachProducts();
setTotalPriceOfAllProducts();

$('.btn-decrease').on('click', function() {
	changeProductQuantity($(this), 'decrease'); // có ajax
})

$('.btn-increase').on('click', function() {
	changeProductQuantity($(this), 'increase'); // có ajax
})

function checkQuantityAjax(target, type, baseUrl, productId, quantity, sizeNo) {
	target.off('click'); // tắt event listener của nút tăng / giảm

	let formData = new FormData();
	formData.append("productId", productId);
	formData.append("quantity", quantity);
	formData.append("sizeNo", sizeNo);

	$.ajax({
		url: baseUrl + "/ajax/cart/check",
		type: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function(response) {
			if (response != null) {

				target.on('click', function() {
					changeProductQuantity(target, type); // bật lại event listener cho nút
				})

				const { cart, isEnough, inStockQuantity, productId, sizeNo } = response;
				if (isEnough == true) {
					setCartItemPreview(baseUrl, cart);
					
					const errorEls = document.querySelectorAll('.tr .error-message');
					errorEls.forEach( el =>{
						el.textContent = ''
						el.classList.remove('on')
					});
				} else {
					const productRowEls = document.querySelectorAll('.tr');
					
					productRowEls.forEach( row => {
						const productIdEl = row.querySelector('input[name="hidden-product-id"]');
						const sizeNoEl = row.querySelector('input[name="hidden-size-no"]');
						if ( productIdEl.value == productId && sizeNoEl.value==sizeNo ) {
							row.querySelector('.error-message').textContent = 'sản phẩm này chỉ còn ' + inStockQuantity;
							row.querySelector('.error-message').classList.add('on');
						}else {
							row.querySelector('.error-message').textContent = '';
							row.querySelector('.error-message').classList.remove('on');	
						}
					})
			
				}
			}
		}
	})
}

removeProduct();
function removeProduct() {
	$('.btn-remove').on('click', function() {
		// cập nhật giá trong bill, nếu không còn sp nào -> reset delivery và discount price thành 0
		let initialPrice = Number($(this).closest('.tr').find('.initial-price').text());
		let quantity = Number($(this).closest('.tr').find('input[name="product-quantity"]').val());
		let total = initialPrice * quantity;

		const subtitlePriceEl = $('.card__total-price .subtotal-price');
		let currentSubtitlePrice = Number(subtitlePriceEl.text());
		subtitlePriceEl.html(currentSubtitlePrice - total);

		if (!hasItem()) {
			setDeliveryPrice(0);
			setDiscountPrice(0);
		}

		updateBill();

		// xóa trường sp khỏi dom
		$(this).closest('.tr').remove();

		// có thể ta vừa xóa item cuối cùng, vì vậy cần hiện image empty card và disable nút checkout
		toggleEmptyCartImage();

		// ajax xóa trong session bên server
		const productId = $(this).parents('.tr').find('input[name="hidden-product-id"]').attr('value');
		const sizeNo = $(this).parents('.tr').find('input[name="hidden-size-no"]').attr('value');
		removeItemAjax(baseUrl, productId, sizeNo);
	})
}

function removeItemAjax(baseUrl, productId, sizeNo) {
	let formData = new FormData();
	formData.append('productId', productId);
	formData.append('sizeNo', sizeNo);

	$.ajax({
		url: baseUrl + "/ajax/cart/delete",
		method: 'POST',
		data: formData,
		processData: false,
		contentType: false,
		success: function(response) {
			if (response != null) {
				console.log('deleted' + response);
				setCartItemPreview(baseUrl, response.cart);
			}
		}
	});
}

function changeProductQuantity(target, type) {
	let quantity = Number(target.parent().find('input[name="product-quantity"]').val());

	if (type == 'increase') {
		target.parent().find('input[name="product-quantity"]').val(quantity + 1);

		let initialPriceTag = target.closest('.tr').find('.initial-price');
		let totalPriceTag = target.closest('.tr').find('.total-price');

		let currentQuantity = quantity + 1;
		let initialPrice = getNumberFromMoney(initialPriceTag.text());
		totalPriceTag.html(formatToMoney(currentQuantity * initialPrice) );

		setTotalPriceOfAllProducts();

		target.parent().find('[name="product-quantity"]').attr('value', currentQuantity);
	}
	else if (type == 'decrease') {
		if (quantity >= 2) {

			// quantity on input tag
			target.parent().find('input[name="product-quantity"]').val(quantity - 1);

			const initialPriceTag = target.closest('.tr').find('.initial-price');
			const totalPriceTag = target.closest('.tr').find('.total-price');

			// total price for each item
			let currentQuantity = quantity - 1;
			let initialPrice = getNumberFromMoney(initialPriceTag.text());
			totalPriceTag.html(formatToMoney((currentQuantity * initialPrice)));

			setTotalPriceOfAllProducts();

			target.parent().find('[name="product-quantity"]').attr('value', currentQuantity);
		}
	}

	// ajax
	const quantity2 = target.siblings('input[name="product-quantity"]').attr('value');
	const productId = target.siblings('input[name="hidden-product-id"]').attr('value');
	const sizeNo = target.siblings('input[name="hidden-size-no"]').attr('value');
	checkQuantityAjax(target, type, baseUrl, productId, quantity2, sizeNo);
}

function setTotalPriceForEachProducts() {
	// array of tags contain total price
	const totalPriceArray = $('.cart__products__left > .table .tr .total-price');

	totalPriceArray.each(function(index) {
		let quantity = Number($(this).closest('.tr').find('input[name="product-quantity"]').val());
		let price = getNumberFromMoney($(this).closest('.tr').find('.initial-price').text());

		$(this).text(formatToMoney(price * quantity))
	})
}

function setTotalPriceOfAllProducts() {
	const totalPriceArray = $('.cart__products__left > .table .tr .total-price');
	let totalPrice = 0;
	totalPriceArray.each(function(index) {
		let quantity = Number($(this).closest('.tr').find('input[name="product-quantity"]').val());
		let price = getNumberFromMoney($(this).closest('.tr').find('.initial-price').text());
		totalPrice += price * quantity;
	})
	$('.card__total-price .subtotal-price').text(formatToMoney(totalPrice ));
	updateBill();
}
function updateBill() {
	const finalTotalPriceTag = $('.card__total-price .total-price');

	let subtitlePrice = getNumberFromMoney($('.card__total-price .subtotal-price').text());
	let deliveryPrice = getNumberFromMoney($('.card__total-price .delivery-price').text());
	let discountPrice = getNumberFromMoney($('.card__total-price .discount-price').text());

	finalTotalPriceTag.text(formatToMoney(subtitlePrice + deliveryPrice - discountPrice))
}
function setDeliveryPrice(newPrice) {
	if (typeof newPrice === 'number') {
		$('.card__total-price .delivery-price').text(formatToMoney(newPrice ));
	}
}
function setDiscountPrice(newPrice) {
	if (typeof newPrice === 'number') {
		$('.card__total-price .discount-price').text(formatToMoney(newPrice ));
	}
}