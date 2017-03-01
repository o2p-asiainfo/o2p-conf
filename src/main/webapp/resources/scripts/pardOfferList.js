var PardOfferList = function() {
    var pardOfferListFun = function() {
    	$.ajax({
			async : false,
			type : "POST",
			url :  contextPath+"/pardOffer/list.shtml",
			data : {
				productName : $("#productName").val()
			},
			success : function(data) {
				if (data.code == "0000") {
					$('.mix-grid').html(data.desc).mixItUp({
	                    callbacks: {
	                        onMixEnd: function(state) {
	                            if (state.fail == true) {
	                                $('.s-warning').show();
	                            } else {
	                                $('.s-warning').hide();
	                            }
	                        }
	                    }
	                });
				} else {
					alert(data.desc);
				}
			},
			dataType : "json",
            error: function(xhr, textStatus, errorThrown) {
            	//called when there is an error
            }
		});
    }
    return {
        //main function to initiate the module
        init: function() {
        	pardOfferListFun();
            $(".input-group-btn").click(pardOfferListFun);
        }
    };
}();

var showProdOfferDetail=function(productId){
	$("#prodOfferId").val(productId);
	showPordOfferForm.action=contextPath+"/pardOffer/toDetail.shtml";
	showPordOfferForm.submit();
}
