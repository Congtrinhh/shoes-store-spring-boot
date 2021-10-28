const baseUrl = $('input[name="base"]').attr('value');

$('.btn-show-modal').on('click', function(){
	$('.btn-delete').attr('item-id', $(this).attr('item-id') );

});

$('.btn-delete').on('click', function(){
	
	$.ajax({
		url: baseUrl + "/admin/product/delete/" + $(this).attr('item-id'),
		type: 'get',
		data: null,
		success: function(response){
			if (response!=null){
				const {id, statusCode} = response;
				
				// khi sản phẩm bị xóa hoàn toàn khỏi DB và disk
				if (statusCode==200) {
					$('.btn-show-modal[item-id="' + id + '"]').parents('.product-row').remove();
				}
				// khi sản phẩm chỉ bị ngưng kích hoạt (inactivate)
				else if (statusCode==201) {
					$('.btn-show-modal[item-id="' + id + '"]').parents('.product-row').find('td.status').removeClass('on');				
				}
				
			}
		}
	});
})