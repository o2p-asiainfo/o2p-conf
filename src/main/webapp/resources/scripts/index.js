var Index = function() {

    var initRevolutionSlider = function() {
        var api;
        //setTimeout("", 1000);
        //jQuery('#revolutionul').show();
        api = jQuery('.fullwidthabnner').revolution({
            delay: 2000,
            startheight: 380,
            startwidth: 1150,
            hideThumbs: 10,
            thumbWidth: 100, // Thumb With and Height and Amount (only if navigation Tyope set to thumb !)
            thumbHeight: 50,
            thumbAmount: 5,
            navigationType: "bullet", // bullet, thumb, none
            navigationArrows: "solo", // nexttobullets, solo (old name verticalcentered), none
            navigationStyle: "round", // round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom
            navigationHAlign: "center", // Vertical Align top,center,bottom
            navigationVAlign: "bottom", // Horizontal Align left,center,right
            navigationHOffset: 0,
            navigationVOffset: 20,
            soloArrowLeftHalign: "left",
            soloArrowLeftValign: "center",
            soloArrowLeftHOffset: 20,
            soloArrowLeftVOffset: 0,
            soloArrowRightHalign: "right",
            soloArrowRightValign: "center",
            soloArrowRightHOffset: 20,
            soloArrowRightVOffset: 0,
            touchenabled: "on", // Enable Swipe Function : on/off
            onHoverStop: "on", // Stop Banner Timet at Hover on Slide on/off
            stopAtSlide: -1,
            stopAfterLoops: -1,
            hideCaptionAtLimit: 0, // It Defines if a caption should be shown under a Screen Resolution ( Basod on The Width of Browser)
            hideAllCaptionAtLilmit: 0, // Hide all The Captions if Width of Browser is less then this value
            hideSliderAtLimit: 0, // Hide the whole slider, and stop also functions if Width of Browser is less than this value
            shadow: 1, //0 = no Shadow, 1,2,3 = 3 Different Art of Shadows  (No Shadow in Fullwidth Version !)
            fullWidth: "on" // Turns On or Off the Fullwidth Image Centering in FullWidth Modus
        });
    };
    var handleOprCase = function() {
        var curr = 0,
            delay = 2000,
            els = $('.o2p-main-partner-img > div'),
            size = els.size(),
            timer = setInterval(function() {
                els.eq(curr).trigger('click');
                curr == (size - 1) ? curr = 0 : curr++;
            }, delay);
        els.bind('click', function() {
            $(this).addClass('active').siblings().removeClass('active');
            $('#opr-intro').stop().css('opacity', '0.4').html($(this).children('a').data('content')).animate({
                opacity: 1
            }, 500);
        })
        $('.o2p-main-partner-img > div,.o2p-main-partner-tip').bind('mouseover', function() {
            clearInterval(timer);
            $(this).trigger('click')
        });
        $('.o2p-main-partner-img > div,.o2p-main-partner-tip').bind('mouseout', function() {
            var $curr = els.filter('div.active');
            els.index($curr) == (size - 1) ? curr = 0 : curr = els.index($curr) + 1;
            timer = setInterval(function() {
                els.eq(curr).trigger('click');
                curr == (size - 1) ? curr = 0 : curr++;
            }, delay)
        });
    }
    return {
        init: function() {
            initRevolutionSlider();
            handleOprCase();
        },
        //Revolution Slider
    };
}();
