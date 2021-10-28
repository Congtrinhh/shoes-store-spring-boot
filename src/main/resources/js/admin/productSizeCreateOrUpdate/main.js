$('#createForm').validate({
	rules: {
		quantity: {
			number: true,
			notNegative : true
		},
		discountPercent: {
			number: true,
			isPercent: true,
		},
	},
	messages: {
		quantity: {
			required: "Vui lòng nhập số lượng",
		},
		discountPercent: {
			required: "Vui lòng nhập % giảm giá",
		},
	},
	errorPlacement: function(errorElem, invalidElem) {
	
		errorElem.insertAfter(invalidElem.parent());
	
	},
});

jQuery.validator.addMethod("isPercent", function(value) {
    return value>=0 && value<=100;
}, "% giảm giá là số trong khoảng từ 0 đến 100");

jQuery.validator.addMethod("notNegative", function(value, element) {
    return  value>=0;
}, "Số lượng không thể âm");