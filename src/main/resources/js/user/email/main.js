const btn = document.querySelector('.btn-submit');
btn.onclick= function(){
	const formData = {
		email: $('[name="email"]').val(),
	}
	$.ajax({
		url: "/ajax/email",
		type: "POST",
		data: JSON.stringify(formData),
		contentType: "application/json",
		success: function(response){
			if (typeof response=='string') {
				response = JSON.parse(response);
				console.log("response: " + response);
				alert("Bạn đã đăng ký thành công với email: " + response.email);
			}
			else if (typeof response=='object') {
				console.log("response: " + response);
				alert("Bạn đã đăng ký thành công với email: " + response.email);
			}
		}
	})
}