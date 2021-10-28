$('#userForm').validate({
          messages: {
               username: "Vui lòng nhập tên tài khoản",
               password: "Vui lòng nhập mật khẩu",
           },
           errorPlacement: function(errorElement, invalidElement) {
               errorElement.insertAfter( invalidElement.parent() );
           }
        });