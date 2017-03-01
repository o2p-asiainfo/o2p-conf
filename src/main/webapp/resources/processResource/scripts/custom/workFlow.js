var WF = function () {
    var handleCanvasSize = function(){
        var viewHeight = $(window).height()
        var toolbarHeight = $('.toolbar').outerHeight(true);
        var height = viewHeight - 21 - toolbarHeight;        
        $('#group1').css('height',height);
    }

    return {
        //main function
        init: function () {
            handleCanvasSize();
            App.addResponsiveHandler(function () {
				handleCanvasSize();            
            });
            

        },
       

    };

}();