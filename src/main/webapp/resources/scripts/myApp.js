var MyApp = function() {
    var handleMixItUp = function() {
    	$.ajax({
        	async : false,
            url: 'mgr/applicationList.shtml',
            type: 'POST',
            data : {
            	appName : $("#appName").val()
            	
			},
            complete: function(xhr, textStatus) {                
                var online = $('.category_1').size();
                var prending = $('.category_2').size();
                var offline = $('.category_4').size();
                var all = online + prending + offline;   
                
                $("#myApp").html(all); 
                $('#spanAll').remove();
                $('#spanOnline').remove();
                $('#spanPrending').remove();
                $('#spanOffline').remove();
                $('li[data-filter="all"]').append('<sapn id="spanAll">(' + all + ')</span>');
                $('li[data-filter=".category_1"]').append('<sapn id="spanOnline">(' + online + ')</span>');
                $('li[data-filter=".category_2"]').append('<sapn id="spanPrending">(' + prending + ')</span>');
                $('li[data-filter=".category_4"]').append('<sapn id="spanOffline">(' + offline + ')</span>');
               
                 
            },
            success: function(data) {
            
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
            	}else{
            		alert(data.desc);
            	}
            },
            dataType : "json",
            error: function(xhr, textStatus, errorThrown) {
                //called when there is an error
            }
        });

        //查询
    	$('#btn-app-search').bind('click',function() {
    		handleMixItUp();
    	});
    }

    return {
        //main function to initiate the module
        init: function() {
            handleMixItUp();
        }

    };

}();


 function showAppDetail(appId){
	//$("#appId").val(appId);
	showAppForm.action=_APP_PATH+"/mgr/manageDevMgr.shtml?appId="+appId;
	showAppForm.submit();
}
