const baseUrl = $('input[name="base"]').val();

$(window).on('load', function(){
	$('.loader-item').hide();
});
$(window).on('scroll', loadMoreItems);

function loadMoreItems() {
	if ($(window).scrollTop() >= $(document).height() - $(window).height()-200) {

		if ($('input[name="page"]').prop("disabled") == true) {
			console.log('ở trang cuối');
			return;
		}
		
		// tránh lắng nghe nhiều
		$(window).off('scroll', loadMoreItems);
		
		// bật loading animation
		$('.loader-item').show();

		let pageIndex = $('input[name="page"]').attr('value');
		pageIndex = Number(pageIndex) + 1;		

		const jsonData = {
			keyword: $('[name="keyword"]').val(),
			page: pageIndex,
		}

		$.ajax({
			type: 'POST',
			url: baseUrl + '/ajax/search',
			data: JSON.stringify(jsonData),
			contentType: "application/json",
			success: function(items) {
				
				// bật lại event
				$(window).on('scroll', loadMoreItems);
				
				// tat loading animation
				$('.loader-item').hide();
				
				console.log(items);
				if (items != null && Array.isArray(items)) {
					$('input[name="page"]').attr('value', pageIndex);
					appendItems(items);
				} else if (!items){
					// không có item, có nghĩa trang hiện tại đã là trang cuối
					$('input[name="page"]').prop("disabled", true);
				}
			},
			error: function(request, status, error) {
				// tat loading animation
				$('.loader-item').hide();
			}
		})
	}
}

function appendItems(itemList) {
	let html = itemList.map(item => (`<div class="col-12 col-sm-6 col-md-4 col-xl-3 mb-4">
											<a href="${baseUrl}/product-detail/${item.seo}" class="product">
												<div class="img-parent">
													<img src="${baseUrl}/images/disk/${item.avatar}"
														alt="a pair of shoes" />
												</div>
												<div class="info">
													<h2 class="name">${item.name}</h2>
													<p class="price">
														${formatToMoney(item.price)}
													</p>
													<span class="badge">${item.gender==true?"Nữ":"Nam"}</span>
												</div>
											</a>
										</div>`)).join('');
	document.querySelector('.product-row').innerHTML += html;
}