var Reg = function() {

    var handleForm = function() {
        //country select错误样式控制
        var handleCountryStyle = function() {
        	/**
            var isSelected = ($('#country').attr('value') == '') ? false : true;
            if (!isSelected) {
                $('#country-list').closest('.form-group').addClass('has-error');

            } else {
                $('#country-list').closest('.form-group').removeClass('has-error').find('.help-block').remove();

            }*/
        };
        
        
        /**
        var handleSelect2 = function() {
            function format(state) {
                if (!state.id) return state.text; // optgroup
                return "<img class='flag' src='resources/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
            }

            function format2(state) {
                if (!state.id) return state.text; // optgroup 
                //清除has-error样式 
                handleCountryStyle();
                $('#country').attr('value', state.text);
                return "<img class='flag' src='resources/img/flags/" + state.id.toLowerCase() + ".png'/>&nbsp;&nbsp;" + state.text;
            }


            
            var select2 = $("#country-list").select2({
                placeholder: 'Select a Country',
                allowClear: true,
                templateResult: format,
                templateSelection: format2,
                escapeMarkup: function(m) { //过滤html标签              
                    return m;
                }
            });
            //设置初始值
            select2.val("CN").trigger("change");
            //清除的时候设置隐藏input值为空
            select2.on("select2:unselect", function(e) {
                $('#country').attr('value', '');
            });
        }*/

        var form = $('.login-form');

        /*
         *自定义校验规则
         *parma: method name,function,messages
         *调用方法 放在rules里面，类似required:true( domain:'#username'),#username为对象ID
         */
        // jQuery.validator.addMethod("domain", function(value, element) {
        //     return this.optional(element) || /^http:\/\/mycorporatedomain.com/.test(value);
        // }, "Please specify the correct domain for your documents");
        
        jQuery.validator.addMethod("emailVal", function(value, element) {
            return this.optional(element) || /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/.test(value);
        }, $.i18n.prop('eaap.op2.portal.emailValidate'));
        
        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                username: {
                    required: true,
                    remote: {
                    	type:"POST",
                    	dataType: "json",
                        url: APP_PATH+"/org/verifyUserName.shtml", 
                        data:{
                        	userName : function() {
                                return $("#username").val();   
                            }
                        }
                    },
                    maxlength: 30
                },
                password: {
                    required: true,
                    maxlength: 16
                },
                rePassword: {
                    equalTo: "#password",
                    maxlength: 16
                },
                email: {
                    required: true,
                    //email:true,
                    emailVal:'#email',
                    maxlength: 255
                },
                /*
                country: {
                    required: true,
                },
                */
                address: {
                	 maxlength: 255
                },
                firstname: {
                    required: true,
                    maxlength: 30
                },
                lastname: {
                    required: true,
                    maxlength: 30
                },
                enterprisename: {
                    required: true,
                    maxlength: 60
                },
                card: {
                    required: true,
                    maxlength: 30
                },
                introduction: {
                	maxlength: 500
                },
                phone: {
                    required: true,
                    isMobile: true,
                    maxlength: 20
                },
                verification: {
                    required: true,
                },
                agreement: {
                    required: true,
                }
            },
            messages: {
                username: { 
                    required: $.i18n.prop('eaap.op2.portal.message.userNameIsReq'),
                    remote: $.i18n.prop('eaap.op2.portal.message.userNameAlready')
                },
                password: {
                    required: $.i18n.prop('eaap.op2.portal.message.pwdIsReq')
                },
                rePassword:{
                	equalTo: $.i18n.prop('eaap.op2.portal.message.enterTheSameValue')
                },
                verification: {
                    required: $.i18n.prop('eaap.op2.portal.message.verifyCodeReq')
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
            	saveOrg(); // form validation success, call ajax form submit
            },

        });
        //handleSelect2();
        function switcher(){
           var val = $('input[name="type2"]:checked').val();
            if (val == 'personal') {
                $('#personalType').show();
                $('#enterpriseType').hide();
            } else if (val == 'enterprise') {
                $('#enterpriseType').show();
                $('#personalType').hide();
            }
        }
        $('input[name="type2"]').on('change', switcher);
        switcher();

        //控制回车键
        $('.login-form input').keypress(function(e) {
            if (e.which == 13) {
                if ($('.login-form').validate().form()) {
                    $('.login-form').submit(); //form validation success, call ajax form submit
                }
                return false;
            }
        });
    };
    return {
        //main function to initiate the module
        init: function() {
            handleForm();
        }

    };

}();
