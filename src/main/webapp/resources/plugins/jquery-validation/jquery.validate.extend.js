$(function(){ 
 
     // 手机号码验证  只需验证是否正整数    
    jQuery.validator.addMethod("isMobile", function(value, element) {       
        return this.optional(element) || /^\d+$/.test(value);       
   }, "Please fill in your correct phone number");  
    
});