const baseUrl = $('input[name="base"]').val();

$(window).on('load', function(){
	$('.loader-item').hide();
	
	$(window).on('scroll', loadMoreItems);
});

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
		
		const currentUrl = window.location.href;
		
		let regexUrl =/https?:\/\/.+\/([\w-]+)\??.*$/;
		
		const match = currentUrl.match(regexUrl);
		const servletPath = match[1];
		
		let gender = null;
		if (servletPath=='men') {
			gender = false;
		} else if (servletPath=='women') {
			gender = true;
		} else if (servletPath=='new-arrivals') {
			gender=null;
		}
		

		const jsonData = {
			gender: gender,// nam or nu
			brandId: $('select[name="brandId"]').val(),
			categoryId: $('select[name="categoryId"]').val(),
			priceSort: $('select[name="priceSort"]').val(),
			minPrice: $('[name="minPrice"]').val(),
			maxPrice: $('[name="maxPrice"]').val(),
			page: pageIndex,
		}

		$.ajax({
			type: 'POST',
			url: baseUrl + '/ajax/load-more-items',
			data: JSON.stringify(jsonData),
			contentType: "application/json",
			dataType : 'json',
			success: function(items) {
				
				// bật lại event
				$(window).on('scroll', loadMoreItems);
				
				// tat loading animation
				$('.loader-item').hide();
				
				console.log(items);
				if (items != null && Array.isArray(items)) {
					// không có item, có nghĩa trang hiện tại đã là trang cuối
					if (items.length <= 0) {
						$('input[name="page"]').prop("disabled", true);
					} else {
						$('input[name="page"]').attr('value', pageIndex);
						appendItems(items);
					}
				}
			}
		})
	}
}

function appendItems(itemList) {
	let html = itemList.map(item => (`<div class="col-12 col-md-6 col-xl-4 mb-4">
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