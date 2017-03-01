var TransactionRecords = function() {



    var handleDataTable = function() {

        $('#dt').dataTable({
            "processing": true,
            "serverSide": true,
            //"searching": false,
            //"lengthMenu": [5, 10, 15, "All"],
            "ajax": "dataTable_statistics.jsp",

            "aoColumnDefs": [{
                //设置第一列不排序
                "bSortable": false,
                "aTargets": [0]
            }],
            "initComplete": function() {
                App.initUniform();
            }
        });
        jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
        jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown 

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

  

    var handleSelect2 = function() {
        $(".js-example-placeholder-single").select2();
    }
    return {
        init: function() {
            handleDataTable();
            handleDatePickers();     
            handleSelect2();
        }
    }
}()
