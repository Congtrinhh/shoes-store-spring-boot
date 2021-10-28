setDeliveryPrice(0)
setDiscountPrice(0)

/* khi người dùng đã đăng nhập và có sắn thông tin field, lấy luôn thông tin điền vào field và disable field */
$('#orderContactAddress .form-text input').each(function(){
	const value = $(this).attr('value');
	if (value!=null && value.length>0) {
		$(this).prop('readonly', true);
	}
})
$(window).on('load', function(){
	const addressValue = $('input[name="address"]').attr('value');
	if (addressValue !=null && addressValue.length>0) {
		$('.address-container-parent').hide();
	} else {
		$('input[name="address"]').parents('.form-text').hide();
	}
})

/* ajax - khi người dùng chọn tỉnh/tp -> hiện ra quận/huyện tương ứng và xóa all xã/phường  */
$('select[name="province"]').on('change', function() {
	if ($(this).val() === '') {
		return;
	}

	let formData = 'provinceId=' +$(this).val();

	$.ajax({
		url: '/ajax/checkout/district',
		type: 'GET',
		data: formData,
		success: function(response) { // mảng các quận/huyện
			const districtSel = document.querySelector('select[name="district"]');
			districtSel.innerHTML = '<option value="">Quận/huyện</option>'

			response.forEach(district => {
				districtSel.innerHTML += `<option class="option-district" value="${district.id}">${district.name}</option>`
			})

			// xóa tất cả option trong thẻ select xã/phường 
			const wardSel = document.querySelector('select[name="ward"]');
			wardSel.innerHTML = '<option value="">Xã/phường</option>';
		}
	})
})

/* ajax - khi người dùng chọn quận/huyện -> hiện ra xã/phường  */
$('select[name="district"]').on('change', function() {
	if ($(this).val() === '') {
		return;
	}
	let formData = 'districtId=' + $(this).val();

	$.ajax({
		url: '/ajax/checkout/ward',
		type: 'GET',
		data: formData,
		success: function(response) { //mảng các xã/phường
			const wardSel = document.querySelector('select[name="ward"]');
			wardSel.innerHTML = '<option value="">Xã/phường</option>';

			response.forEach(ward => {
				wardSel.innerHTML += `<option class="option-ward" value="${ward.id}">${ward.name}</option>`
			})
		}
	})

})


/* validate contact address form */
$(document).ready(function() {

	$('#orderContactAddress').validate({
		rules: {
			fullName: {
				required: true,
				containOnlyLetter: true,
			},
			email: {
				email: true,
			},
			phone: {
				containOnlyDigit: true,
			},
			'specific-address': {
				containOnlyDigitAndLetter: true,
			},
		},

		messages: {
			fullName: {
				required: 'Vui lòng nhập họ và tên',
			},
			phone: {
				required: 'Vui lòng nhập số điện thoại',
			},
			email: {
				required: 'Vui lòng nhập email',
				email: 'Email chưa đúng định dạng'
			},
			'specific-address': {
				required: 'Vui lòng nhập địa chỉ cụ thể',
			},
			province: {
				required: 'Vui lòng chọn tỉnh/thành phố'
			},
			district: {
				required: 'Vui lòng chọn quận/huyện'
			},
			ward: {
				required: 'Vui lòng chọn xã/phường'
			}
		},
		errorPlacement: function(errorElem, invalidElem) {
			if (invalidElem.prop('tagName') === 'SELECT') {
				errorElem.insertAfter(invalidElem);
			}
			else {
				errorElem.insertAfter(invalidElem.parent());
			}
		}
	});


});

jQuery.validator.addMethod('containOnlyLetter', function(value) {
	const regex = /[^\p{L}\s]/gmu;
	return !regex.test(value.trim());
}, 'Tên không được chứa số và các ký tự đặc biệt')

jQuery.validator.addMethod('containOnlyDigit', function(value) {
	const regex = /^0\d{9}$/;
	return regex.test(value.trim());
}, 'Số điện thoại chưa đúng định dạng')

jQuery.validator.addMethod('containOnlyDigitAndLetter', function(value) {
	const regex = /[^\p{L}\d\s]/gmu;
	return !regex.test(value.trim());
}, 'Địa chỉ không được chứa ký tự đặc biệt')


/* hiển thị giá vv */
setTotalPriceForEachProducts();
setTotalPriceOfAllProducts();

function setTotalPriceForEachProducts() {
	// array of ele contain total price
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

	finalTotalPriceTag.text(formatToMoney(subtitlePrice + deliveryPrice - discountPrice) )
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