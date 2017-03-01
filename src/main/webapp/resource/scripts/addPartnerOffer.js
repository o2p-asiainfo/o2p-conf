var AddPartnerOffer = function() {

    var handleForm = function() {

        $('#form1').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                applicationName: {
                    required: true,
                    minlength: 4
                },
                productCode: {
                    required: true,
                },                
                from: {
                    required: true,
                },
                to: {
                    required: true,
                },         
            },

            messages: {
                userName: {
                    required: "Username is required."
                },
               
            },

            invalidHandler: function(event, validator) { //display error alert on form submit                       
                App.scrollTop();
            },

            highlight: function(element) { // hightlight error inputs
                $(element) .closest('.form-group').addClass('has-error'); // set error class to the control group 
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },
            errorPlacement: function(error, element) {
                // error.insertAfter(element.closest('.input-icon'));
                if (element.parents('.input-group').size() > 0) {
                    error.appendTo(element.parents('.input-group').attr("data-error-container"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            submitHandler: function(form) {
                form.submit(); // form validation success, call ajax form submit
            }
        });        
    }

    var handleProductModal = function() {
        //弹窗展现前从后台加载表格数据
        $('#productModal').on('show.bs.modal', function(e) {
                $('#dt1').dataTable({
                    "processing": true,
                    "serverSide": true,                   
                    "ajax": "dataTable.jsp",
                    "order": [],
                    "autoWidth":false,
                    "columnDefs": [{ "orderable": false, "targets": 0,"width":"36px" },{ "orderable": false, "targets": 4 }],
                    "initComplete": function() {
                        App.initUniform();
                        $('#productModal tbody').find('input[type="checkbox"]:checked').each(function() {
                            $(this).closest('tr').addClass('active');
                        })
                    }
                });
                jQuery('#dt1_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
                jQuery('#dt1_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
            })
            //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
        $('.ok').bind('click', function() {

        })


    }

    var handleOfferModal = function() {
        //弹窗展现前从后台加载表格数据
        $('#offerModal').on('show.bs.modal', function(e) {
                $('#dt2').dataTable({
                    "processing": true,
                    "serverSide": true,
                    //"lengthMenu": [5, 10, 15, "All"],
                    "ajax": "dataTable.jsp",
                    "order": [],
                    "autoWidth":false,
                    "columnDefs": [{ "orderable": false, "targets": 0,"width":"36px" },{ "orderable": false, "targets": 4 }],
                    "initComplete": function() {
                        App.initUniform();
                        $('#offerModal tbody').find('input[type="checkbox"]:checked').each(function() {
                            $(this).closest('tr').addClass('active');
                        })
                    }
                });
                jQuery('#dt2_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
                jQuery('#dt2_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
            })
            //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
        $('.ok').bind('click', function() {

        })
    }
    var mutualExclusionModal = function() {
        //弹窗展现前从后台加载表格数据
        $('#mutualExclusionModal').on('show.bs.modal', function(e) {
                $('#dt3').dataTable({
                    "processing": true,
                    "serverSide": true,
                    //"lengthMenu": [5, 10, 15, "All"],
                    "ajax": "dataTable.jsp",
                    "order": [],
                    "autoWidth":false,
                    "columnDefs": [{ "orderable": false, "targets": 0,"width":"36px" },{ "orderable": false, "targets": 4 }],
                    "initComplete": function() {
                        App.initUniform();
                        $('#mutualExclusionModal tbody').find('input[type="checkbox"]:checked').each(function() {
                            $(this).closest('tr').addClass('active');
                        })
                    }
                });
                jQuery('#dt3_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
                jQuery('#dt3_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
            })
            //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
        $('.ok').bind('click', function() {

        })
    }

    var handleDatePickers = function(model) {
        var options = {};
        if (model == 'daily') {
            options = {
                autoclose: true,
                minViewMode: 'year',
                format: 'mm/dd/yyyy'
            }
        } else if (model == 'monthly') {
            options = {
                autoclose: true,
                minViewMode: 'months',
                format: 'mm/yyyy'
            }
        } else {
            options = {
                autoclose: true,
                minViewMode: 'year',
                format: 'mm/dd/yyyy'
            }
        }
        if (jQuery().datepicker) {
            $('.date-picker').datepicker(options);
        }
    }


    return {
        init: function() {
            handleForm();
            handleProductModal();
            handleOfferModal();
            mutualExclusionModal();
            handleDatePickers();

        }
    }
}()
