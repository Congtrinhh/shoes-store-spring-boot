$('.btn-show-modal').on('click', function(){
	$('.btn-delete').attr('item-id', $(this).attr('item-id'));
})
const baseUrl = $('input[name="base"]').attr('value');

$('.btn-delete').on('click', function(e){
	e.preventDefault();
	
	$.ajax({
		url: baseUrl + "/admin/category/delete/" + $(this).attr('item-id'),
		type: 'get',
		data: null,
		success: function(response){
			if (response!=null){
				console.log(response);
				$('.btn-show-modal[item-id="' + response.id + '"]').parents('.product-row').find('td.status').removeClass('on');
			}
		}
	})
})