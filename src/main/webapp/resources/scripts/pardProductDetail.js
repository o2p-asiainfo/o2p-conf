var PardProductDetail = function() {
	var updateInfoFun=function(){
		showProdForm.action=contextPath+"/pardProduct/toUpdate.shtml";
		showProdForm.submit();
	}
	var delInfoFun=function(){
		bootbox.confirm("Are you sure to delete it?", function(result) {
			 if(result==true){
				 alert('del');
			 }
		});
	}
    return {
        //main function to initiate the module
        init: function() {
        	$("#updateInfo").click(updateInfoFun);
        	$("#linkDel").click(delInfoFun);
        	$("#submitToCheck").click(submitToCheckFun);
        }
    };
}();

