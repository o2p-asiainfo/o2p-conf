var Forgot = function() {

    var handleForm = function() {

        $('.forgot-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                email: {
                    required: true,
                    remote: "validation.jsp"
                },
                verification: {
                    required: true,
                    remote: "validation.jsp"
                }
            },
            messages: {
                email: {
                    required: "Username is required.",
                    remote:"邮箱错误",
                },               
                verification: {
                    required:"Correct captcha is required. Click the captcha to generate a new one",
                    remote:"验证码错误",
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   
                // $('.alert-danger', $('.forgot-form')).show();
            },

            highlight: function(element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function(error, element) {
                error.appendTo(element.closest('.form-group'));
            },

            submitHandler: function(form) {
                form.submit(); // form validation success, call ajax form submit
                toastr.success("操作成功");
            }
        });

        $('.forgot-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.forgot-form').validate().form()) {
                    $('.forgot-form').submit(); //form validation success, call ajax form submit
                }
                return false;
            }
        });
    }



    return {
        //main function to initiate the module
        init: function() {

            handleForm();


        }

    };

}();
