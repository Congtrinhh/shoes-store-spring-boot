$('#createForm').validate({
	rules: {
		productAvatarFile: {
			extension: 'jpg|png|jpeg',
		},
		productImagesFile: {
			extension: 'jpg|png|jpeg',
		},
		price: {
			number: true
		},
		priceSale: {
			number: true
		}
	},
	messages: {
		productAvatarFile: {
			required: "Vui lòng thêm ảnh",
			extension: 'Định dạng file không hợp lệ',
		},
		productImagesFile: {
			required: "Vui lòng thêm ảnh",
			extension: 'Định dạng file không hợp lệ',
		},
	},
	errorPlacement: function(errorElem, invalidElem) {
		if (invalidElem.prop("tagName")=='TEXTAREA') {
			errorElem.insertAfter(invalidElem);
		}
		else {
			errorElem.insertAfter(invalidElem.parent());
		}
	},
});



/*function saveProduct(baseUrl){
	//const formData = new FormData( $('#productForm')[0] );

	const productMappingData = {
		id: $('[name="id"]').val(),
		name:$("[name='name']").val(),
		description:$("[name='description']").val(),
		sku:$("[name='sku']").val(),
		price:$("[name='price']").val(),
		category_id:$("[name='category_id']").val(),
		discount_id:$("[name='discount_id']").val(),
	}

	$.ajax({
		url: baseUrl + "/ajax/product",
		type: "post",
		data: JSON.stringify(productMappingData),
		//processData: false,
		contentType: "application/json",
		//type: "json",
		success: function(response){
			if (response){
				alert("response: "+response);
			}
		}
	})
}*/