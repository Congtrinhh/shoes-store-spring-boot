
/* validate contact address form */
$(document).ready(function() {

	$('#contactForm').validate({
		rules: {
			email: {
				email: true,
			},
		},

		messages: {
			email: {
				required: 'Vui lòng nhập email',
				email: 'Email chưa đúng định dạng'
			},
			message: {
				required: 'Vui lòng nhập tin nhắn',
			}
		},
		errorPlacement: function(errorElem, invalidElem) {
			if (invalidElem.prop('tagName') === 'SELECT') {
				errorElem.insertAfter(invalidElem);
			}
			else {
				errorElem.insertAfter(invalidElem.parent());
			}
		}
	});


});