var CreateApp = function() {

  

    var handleBindCapability = function() {

        $('#myModal').on('shown.bs.modal', function(e) {
            //$(this).closest('.portlet').find('.portlet-body').html('<table class="table table-striped table-bordered table-hover" id="taskListsDataTable"> <thead> <tr> <th>First name</th> <th>Last name</th> <th>Position</th> <th>Office</th> <th>Start date</th> <th>Salary</th> </tr> </thead> </table>');
            if (!jQuery().dataTable) {
                return;
            }
         $('#list').dataTable({
            "processing": true,           
            "serverSide": true,
            //"lengthMenu": [5, 10, 15, "All"],
            "ajax":"dataTable.jsp",           
            "aoColumnDefs": [{
               //设置第一列不排序
               "bSortable": false,
               "aTargets": [0]
           }],
            "initComplete":function(){
                App.initUniform();
            }
        });
            jQuery('#list_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
            jQuery('#list_wrapper .dataTables_length select').addClass("form-control"); // modify table per page dropdown 
        })

    }
    return {
        init: function() {         
            handleBindCapability();        }
    }
}()
