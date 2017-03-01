var MyApp = function() {
    var handleMixItUp = function() {
        jQuery.ajax({
            url: 'mixItUpData.jsp',
            type: 'POST',
            complete: function(xhr, textStatus) {
                //called when complete
            },
            success: function(data, textStatus, xhr) {
                $('.mix-grid').html(data).mixItUp({
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

            },
            error: function(xhr, textStatus, errorThrown) {
                //called when there is an error
            }
        });


    }

    return {
        //main function to initiate the module
        init: function() {
            handleMixItUp();
        }

    };

}();
