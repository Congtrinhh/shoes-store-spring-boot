
// hiện phần chỉnh sửa khi bấm nút edit
$('.fieldsets .btn-edit').on('click', function(e) {
	e.preventDefault();
    $(this).closest('fieldset').find('select').css('display', 'block');
    
    $(this).closest('fieldset').find('.image-upload-container').css('display', 'block');
    $(this).closest('fieldset').find('.btn-delete-image').css('display', 'block');
})

// validate form
$('#createForm').validate({
    rules: {
        images: {
            extension: 'jpg|png|jpeg',
        },
    },
    messages: {
        images: {
            required: "Vui lòng thêm ảnh",
            extension: 'Định dạng file không hợp lệ',
        },
    },
    errorPlacement: function(errorElem, invalidElem) {
        errorElem.insertAfter(invalidElem.parent());
    },
});


// --------- preview anh ------------
$('[name="images"]').on('change', function(event){
	
	let fileList = event.target.files;
	
	document.querySelector('.image-preview-container').innerHTML = '';
	
	for (let file of fileList){
		let url = URL.createObjectURL(file);
		
		document.querySelector('.image-preview-container').innerHTML +=
			`<div class="">
                <div class="image-parent">
                    <img src="${url}" class="image-on-preview">
                </div>
            </div>`;
		$('.image-on-preview').on('load', function(){
			URL.revokeObjectURL($(this).attr('src'));
		})
		
	}
})



// khi nhấn xóa hình ảnh, remove hình đó khỏi dom
$('.btn-delete-image').on('click', function(event){
	event.preventDefault();
	$(this).closest('.image-parent').parent().remove();
	
	const deleteId = $(this).attr('image-id');
	console.log(deleteId)
	
	$('input[name="delete-queue-id"]').val($('input[name="delete-queue-id"]').val() + ";" + deleteId);
})