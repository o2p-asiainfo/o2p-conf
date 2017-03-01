var ChangePassword = function() {

    var handleForm = function() {
    
    /*
         *自定义校验规则
         *parma: method name,function,messages
         *调用方法 放在rules里面，类似required:true( domain:'#username'),#username为对象ID
         */
        // jQuery.validator.addMethod("domain", function(value, element) {
        //     return this.optional(element) || /^http:\/\/mycorporatedomain.com/.test(value);
        // }, "Please specify the correct domain for your documents");

        $('#form1').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                oldPassword: {
                    required: true,
                },
                newPassword: {
                    required: true
                },
                repeatPassword: {
                    required: true,
                    equalTo: "#newPassword"
                }
                
            },

            messages: {
            	oldPassword: {
                    required: "Password is required."
                },
                newPassword: {
                    required: "New Password is required."
                },
                repeatPassword: {
                    required: "Repeat Password is required."
                },
            },

            invalidHandler: function(event, validator) { //display error alert on form submit                       
                App.scrollTop();
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
                // error.insertAfter(element.closest('.input-icon'));
                if (element.parents('.checkbox-list').size() > 0) {
                    error.appendTo(element.parents('.checkbox-list').attr("data-error-container"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            submitHandler: function(form) {
            	doChangePwd();
            }
        });

    
    }


    return {
        init: function() {
           handleForm();
        }
    }
}()
