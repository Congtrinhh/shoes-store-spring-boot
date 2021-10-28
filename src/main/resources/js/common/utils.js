function updateFooterContent() {
	if (window.innerWidth >= 576) {
		$('.footer__sub-content').addClass('show');
	} else {
		$('.footer__sub-content').removeClass('show');
	}
}
updateFooterContent();

/* set cart */
function setCartItemPreview(baseUrl, cart) {
	if (cart != null && typeof cart == 'object') {
		const { cartItems, totalPrice, cartItemCount } = cart;
		const cartItemListEl = document.querySelector('.header .preview .cart-item-list');
		const checkoutEl = document.querySelector('.header .preview .checkout');

		// set tổng giá
		checkoutEl.querySelector('.money').textContent = formatToMoney( totalPrice );
		// set đếm sản phẩm
		$('.header .number-indicator').html(cartItemCount);

		// hiển thị từng item trong list preview
		let html = '';
		cartItems.forEach((c, idx) => {
			html += `
				<li class="cart-item">
					<div class="img-parent">
						<img
							src="${baseUrl}/images/disk/${c.avatarPath}"
							alt=""
						/>
					</div>
					<div class="info">
						<h3 class="name">${c.name}</h3>
						<p class="size">${c.sizeNo}</p>
						<p class="quantity">${c.quantity}</p>
						<p class="price">${formatToMoney(c.price)}</p>
					</div>
				</li>`
		})
		cartItemListEl.innerHTML = html;

	} else {
		console.log('cart này không phải object')
	}
}

/* nut reset cho the input - trang admin */
$(window).on('load', function() {
	const resetBtns = document.querySelectorAll('.content form#searchModel .form-text .btn-reset');
	
	resetBtns.forEach(btn => {
		btn.onclick = function(e) {
			e.target.parentElement.querySelector('input').value = '';
		}
	})
})


/* format money -price
*/
function formatToMoney(value) {
	if (typeof value === "number") {
		return Intl.NumberFormat("vi-vn", {
			style: "currency",
			currency: "vnd",
			currencySign: "standard",
		}).format(value);
	}
}
/* convert money format to number - to be able to calculate */
function getNumberFromMoney(value) {
	return Number(value.replace(/[^0-9]+/g, ""));
}

/* enable current link header */
$('.header > .bottom > .center nav ul a').each(function(){
	let regexUrl =/https?:\/\/.+\/([\w-]+)\??.*$/;
	
	// href="/new-arrivals" --> new-arrivals 
	const tabUrl = $(this).attr('href').replace('/', '');
	
	const fullUrl = window.location.href;
	
	const match = fullUrl.match(regexUrl);
	
	const currentServletPath = match?match[1]:'';
	
	if (tabUrl == currentServletPath) {
		$(this).addClass('on');
	}
})