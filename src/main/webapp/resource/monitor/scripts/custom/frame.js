var Frame = function() {

    var setFrameSize = function() {
        if ($(window).width() <= 991) {
            $('#mainFrame').css({
                'width': $(window).width(),
                'height': $(window).height() - $('#header').height(),
            });
        } else {
            $('#mainFrame').css({
                'width': $(window).width() - $('#sidebar').width(),
                'height': $(window).height() - $('#header').height(),
            });
        }
    }

    var resizeChart = function() {
        $("#mainFrame")[0].contentWindow.Main.fnBody();
    }

    var handleSidebarToggle = function() {
        $('.sidebar-toggler').bind('click', function() {
            if ($('body').hasClass("page-sidebar-hover-on")) {  // for page-sidebar-fixed
                $('#mainFrame').css({
                    'width': $(window).width() - 225,
                })
            } else {                
                var width = $('#sidebar').outerWidth() == 225 ? $(window).width() - 35 : $(window).width() - 225;
                $('#mainFrame').css({
                    'width': width,
                })
            }
            resizeChart();
        });
    }

    return {

        //main function to initiate the page 
        init: function() {
            setFrameSize();
            window.onresize = function() {
                setFrameSize();
                resizeChart();
            };
            handleSidebarToggle();
        }

    }

}();
