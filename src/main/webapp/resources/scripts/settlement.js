var Settlement = function() {



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

    
    return {
        init: function() {
            handleDataTable();
        
        }
    }
}()
