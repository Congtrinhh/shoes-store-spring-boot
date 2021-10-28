 $('#userForm').validate({
            rules: {
				email: {
					email: true,
				},
                confirmedPassword: {
                     equalTo: '[name="password"]',
                },
                username: {
                    minlength: 6,
                    isValidUserName: true,
                },
                password: {
                    minlength: 6,
                    isPasswordSecure: true,
                }
            },
            messages: {
                username: {
                    required: "Vui lòng nhập tên đăng nhập",
                    minlength: 'Độ dài tối thiểu 6 ký tự',
                },
                email: {
                    required: "Vui lòng nhập email",
                    email: "Vui lòng nhập đúng định dạng email"
                },
                password: {
                    required: "Vui lòng nhập mật khẩu",
                    minlength: 'Độ dài tối thiểu 6 ký tự',
                    isPasswordSecure: 'Mật khẩu cần có ít nhất 1 chữ cái và 1 chữ số',
                },
                confirmedPassword: {
                    required: "Vui lòng xác nhận mật khẩu",
                    equalTo: "Mật khẩu xác nhận không đúng",
                },
            },
            errorPlacement: function(errorElement, invalidElement) {
                errorElement.insertAfter( invalidElement.parent() );
            },

});

jQuery.validator.addMethod( "isPasswordSecure", function(value) {
    let regex = /^(?=.*[a-zA-Z])(?=.*[0-9])/g;
    return regex.test(value);
}, 'Mật khẩu cần có ít nhất 1 chữ cái và 1 chữ số' )

jQuery.validator.addMethod("isValidUserName", function(value){
    const _1regex = /^[a-zA-Z]*$/g; // chỉ chứa chữ cái
    const _2regex = /^[a-zA-Z]+[a-zA-Z0-9]*$/g; // chỉ chứa chữ cái và số

    return _1regex.test(value) || _2regex.test(value);
}, "Định dạng không hợp lệ. Thử nhập định dạng: congtrinh hoặc congtrinh123")