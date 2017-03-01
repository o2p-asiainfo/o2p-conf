var ResetPwd = function() {

    var handleForm = function() {

        $('.reset-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
            	newPassword: {
                    required: true
                },
                repeatPassword: {
                    required: true,
                    equalTo: "#newPassword"
                },
                verification: {
                    required: true,
                }
            },
            messages: {
            	password: {
                    required: "Password is required.",
                },    
                
                verification: {
                    required:"Correct captcha is required. Click the captcha to generate a new one",
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
              //  form.submit(); // form validation success, call ajax form submit
            }
        });

        $('.reset-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.reset-form').validate().form()) {
                    $('.reset-form').submit(); //form validation success, call ajax form submit
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
