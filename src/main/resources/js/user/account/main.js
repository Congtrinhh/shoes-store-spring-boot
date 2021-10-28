
/**new code */
const iconAddOne = '<i class="fas fa-plus add"></i>'
const iconEditOne = '<i class="fas fa-edit edit"></i>'
$(window).on('load', function() {
	const addressElValue = $('input[name="address"]').attr('value');
	if (addressElValue != null && addressElValue.length > 0) {
		$('.add-address-icon').html($('.add-address-icon').html() + iconEditOne);
	} else {
		$('.add-address-icon').html($('.add-address-icon').html() + iconAddOne);
	}
})
$('.add-address-icon').on('click', function() {
	$('.update-address-wrapper').toggle();
	$(this).toggleClass('on');
})


$('form').on('click', function() {
	$('.error-message').removeClass('on');
})

// ---------------- ajax get ward list khi chọn 1 district nào đó ----------------
$('#district').on('change', getWardList);

// ---------------- ajax get district list khi chọn 1 province nào đó ----------------
$('#province').on('change', getDistrictList);

function getWardList(event) {
	let districtId = Number($(this).val());
	$.ajax({
		url: '/ajax/checkout/ward',
		type: 'GET',
		data: 'districtId=' + districtId,
		success: function(response) {
			if (response != null && Array.isArray(response)) {
				parseWardList(response);
			}
		}
	})
}
function parseWardList(wardList) {
	document.querySelector('#ward').innerHTML = '<option value="">Xã/phường</option>';
	document.querySelector('#ward').innerHTML +=
		wardList.map(ward => {
			return `<option value="${ward.id}">${ward.name}</option>`;
		}).join('');
}

function getDistrictList(event) {
	let provinceId = Number($(this).val());

	$.ajax({
		url: '/ajax/checkout/district',
		type: 'GET',
		data: 'provinceId=' + provinceId,
		success: function(response) {
			if (response != null && Array.isArray(response)) {
				parseDistrictList(response);
			}
		}
	})
}
function parseDistrictList(districtList) {
	document.querySelector('#district').innerHTML = '<option value="">Quận/huyện</option>';
	document.querySelector('#district').innerHTML +=
		districtList.map(district => {
			return `<option value="${district.id}">${district.name}</option>`;
		}).join('');
	// clear all ward list		
	document.querySelector('#ward').innerHTML = '<option value="">Xã/phường</option>';
}

// ---------------- ẩn / hiện nút đổi mk ----------------
$('.btn-show').on('click', function(e) {
	$('.update-password-area').toggleClass('on');
	$(this).toggleClass('on');
	if ($(this).hasClass('on')) {
		$(this).text('Hủy')
		$('[name="current-password"]').val(null);
		$('[name="new-password"]').val(null);
		$('[name="confirmed-password"]').val(null);
	} else {
		$(this).text('Đổi mật khẩu')
	}
})
// ---------------- ẩn thanh user nav khi kích thước màn hình nhỏ xuống  ----------------
$(window).on('load', function() {
	if (window.innerWidth <= 768) {
		$('.collapse').removeClass('show');
	}
})

// -------------- validate form --------------------
$('#userForm').validate({
	rules: {
		'username': {
			minlength: 6,
			isValidUserName: true,
		},
		fullName: {
			containOnlyLetter: true,
		},
 		email: {
			required: true,
			email: true,
		},
		'phone': {
			isPhoneNumber: true,
			/*minlength:10,
			required: false,*/
		},
		'current-password': {

		},
		'new-password': {
			minlength: 6,
			isPasswordSecure: true,
		},
		'confirmed-password': {
			equalTo: '[name="new-password"]',
		},
		'specific-address': {
			containOnlyDigitAndLetter: true,
		},
		
	},
	messages: {
		'username': {
			required: 'Vui lòng nhập tên đăng nhập',
			minlength: 'Hãy nhập ít nhất 6 ký tự'
		},
		fullName: {
			//
		},
		'phone': {
			isPhoneNumber: 'Vui lòng nhập số điện thoại hợp lệ (gồm 10 số)',
		},
		email: {
			required: 'Vui lòng nhập email',
			email: 'Định dạng email không hợp lệ'
		},
		province: {
			required: 'Vui lòng chọn tỉnh/thành phố'
		},
		district: {
			required: 'Vui lòng chọn quận/huyện'
		},
		ward: {
			required: 'Vui lòng chọn xã/phường'
		},
		'current-password': {
			required: 'Vui lòng nhập mật khẩu',
		},
		'new-password': {
			required: 'Vui lòng nhập mật khẩu mới',
			minlength: 'Ít nhất 6 ký tự',
			isPasswordSecure: 'Chưa đủ độ an toàn (cần có cả chữ và số)',
		},
		'confirmed-password': {
			required: 'Vui lòng xác nhận mật khẩu mới',
			equalTo: 'Mật khẩu xác nhận không khớp',
		},
		'specific-address': {
			containOnlyDigitAndLetter: 'Không được chứa ký tự đặc biệt',
		},
	},
	errorPlacement: function(errorElem, invalidElem) {
		if (invalidElem.prop('tagName') == 'SELECT') {
			errorElem.insertAfter(invalidElem.closest('.select-wrapper'));
		}
		else {
			errorElem.insertAfter(invalidElem.parent());
		}
	}
})
jQuery.validator.addMethod("isPasswordSecure", function(value) {
	let regex = /^(?=.*[a-zA-Z])(?=.*[0-9])/g;
	return regex.test(value);
}, 'Mật khẩu cần có ít nhất 1 chữ cái và 1 chữ số')

jQuery.validator.addMethod("isValidUserName", function(value) {
	const _1regex = /^[a-zA-Z]*$/g; // chỉ chứa chữ cái
	const _2regex = /^[a-zA-Z]+[a-zA-Z0-9]*$/g; // chỉ chứa chữ cái và số

	return _1regex.test(value) || _2regex.test(value);
}, "Định dạng không hợp lệ")

jQuery.validator.addMethod("isPhoneNumber", function(value) {
	const regex = /^0[\d]{9}$/gm;
	if (value==null || value=='') {
		return true;
	}
	return regex.test(value.trim());
}, 'Định dạng không hợp lệ')

jQuery.validator.addMethod("isValidName", function(value) {
	const regex = /[^\p{L}\s]/gu;
	return !regex.test(value.trim());
}, 'Định dạng không hợp lệ')

jQuery.validator.addMethod("isValidAddressName", function(value) {
	const regex1 = /[^\p{L}\s\d,.-]/gu; // match string contains characters that are not unicode or number or letter or space,...
	const regex2 = /^[\d]+$/gm; // match string contains only number
	return !regex1.test(value.trim()) && !regex2.test(value.trim());
}, 'Định dạng không hợp lệ')


jQuery.validator.addMethod('containOnlyLetter', function(value) {
	const regex = /[^\p{L}\s]/gmu;
	
	// cho phép không nhập, nhưng nêu nhập sẽ check hợp lệ,
	// tương tự cho các hàm bên dưới
	if (value==null || value=='') {
		return true;
	}
	
	return !regex.test(value.trim());
}, 'Tên không được chứa số và các ký tự đặc biệt')

jQuery.validator.addMethod('containOnlyDigit', function(value) {
	const regex = /0\d{9}/g;
	if (value==null || value=='') {
		return true;
	}
	return regex.test(value.trim());
}, 'Số điện thoại chưa đúng định dạng')

jQuery.validator.addMethod('containOnlyDigitAndLetter', function(value) {
	const regex = /[^\p{L}\d\s]/gmu;
	if (value==null || value=='') {
		return true;
	}
	return !regex.test(value.trim());
}, 'Địa chỉ không được chứa ký tự đặc biệt')