var Reg = function() {

    var handleForm = function() {

        function format(state) {
            if (!state.id) return state.text; // optgroup
            return "<img class='flag' src='assets/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
        }

        $("#country-list").select2({
            placeholder: 'Select a Country',
            allowClear: true,
            formatResult: format,
            formatSelection: format,
            escapeMarkup: function(m) {
                return m;
            }
        });

        $('.login-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                username: {
                    required: true,
                    remote: "validation.jsp"
                },
                password: {
                    required: true,
                },
                verification: {
                    required: true,
                    remote: "validation.jsp"
                }
            },
            messages: {
                username: {
                    required: "Username is required.",
                    remote: "用户名已经存在",
                },
                password: {
                    required: "Password is required."

                },
                verification: {
                    required: "Correct captcha is required. Click the captcha to generate a new one",
                    remote: "验证码错误",
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   
                // $('.alert-danger', $('.login-form')).show();
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
            },

        });

        $('.login-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.login-form').validate().form()) {
                    $('.login-form').submit(); //form validation success, call ajax form submit
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
