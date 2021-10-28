$('#createForm').validate({
	rules: {
		sizeNo: {
			number: true,	
			maxlength: 2,
		}
	},
	messages: {
		sizeNo: {
			required: "Vui lòng nhập size",
			number: 'Vui lòng nhập số',
			maxlength: 'Tối đa 2 chữ số',
		},
	},
	errorPlacement: function(errorElem, invalidElem) {
	
		errorElem.insertAfter(invalidElem.parent());
	
	},
});
