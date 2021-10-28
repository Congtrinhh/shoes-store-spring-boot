$('#createForm').validate({
	messages: {
		name: {
			required: "Vui lòng nhập tên hãng",
		},
		description: {
			required: "Vui lòng nhập mô tả",
		},
	},
	errorPlacement: function(errorElem, invalidElem) {
	
		errorElem.insertAfter(invalidElem.parent());
	
	},
});
