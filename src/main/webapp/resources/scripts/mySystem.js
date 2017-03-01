var MyApp = function() {
    var handleMixItUp = function() {
    	$.ajax({
    		type: "POST",
    		async:false,
    	    url: "../provider/mixItUpData.shtml",
    	    dataType:'json',
    	    data:null,
    	    complete: function(xhr, textStatus) {
                var online = $('.category_1').size();
                var prending = $('.category_2').size();
                var offline = $('.category_4').size();
                var all = online + prending + offline;                
                $('li[data-filter="all"]').append('(' + all + ')');
                $('#myApp').html(all);
            },
    		success:function(msg){ 
    			$('.mix-grid').html(msg.data).mixItUp({
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
              }
         });

    };

    return {
        //main function to initiate the module
        init: function() {
            handleMixItUp();
        },
    };

}();
$('#providerSeach').click(function(){
	var componentName = $('#seachValue').val();
	$('.row mix-grid thumbnails').empty();
	$.ajax({
		type: "POST",
		async:false,
	    url: "../provider/mixItUpData.shtml",
	    dataType:'json',
	    data:{componentName:componentName},
	    complete: function(xhr, textStatus) {
            var online = $('.category_1').size();
            $('#all').text();
            $('#all').text('All(' + online + ')');
        },
		success:function(msg){
			$('.mix-grid').html(msg.data).mixItUp({
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
          }
     });
});
