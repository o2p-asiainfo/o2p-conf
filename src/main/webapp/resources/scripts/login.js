var Login = function() {

    var handleForm = function() {

        $('.login-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                username: {
                    required: true,
                },
                password: {
                    required: true,
                },
                verification: {
                    required: true,
                }
            },
            messages: {
                username: {
                    required: $.i18n.prop('eaap.op2.portal.message.userNameIsReq')
                },
                password: {
                    required: $.i18n.prop('eaap.op2.portal.message.pwdIsReq')

                },
                verification: {
                    required: $.i18n.prop('eaap.op2.portal.message.verifyCodeReq')
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit   
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
            	doLogin();
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
