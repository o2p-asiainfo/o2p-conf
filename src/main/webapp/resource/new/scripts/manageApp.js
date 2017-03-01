var ManageApp = function() {

    var handleEditable = function() {
        //global settings 
        $.fn.editable.defaults.inputclass = 's-form-group';

        $('a[data-name="name"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'name',
            title: 'Enter a new name',
            inputclass: 'form-control input-small',
        })
        $('a[data-name="appType"]').editable({
            url: '', // url to server-side script to process submitted value (/post, post.php etc)
            prepend: "Select Type",
            type: 'select',
            pk: 1,
            name: 'appType',
            title: 'Select Type',
            source: [{
                value: 1,
                text: 'Mobile',
            }, {
                value: 2,
                text: 'Website',
            }],
        })
        $('a[data-name="address"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'name',
            title: 'Enter a new address',
            inputclass: 'form-control input-medium',
        })
        $('a[data-name="callback"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'name',
            title: 'Enter a new callback address',
            inputclass: 'form-control input-medium',
        })
    }

    var closeEidtable = function() {
        $('.editable').editable('toggleDisabled');
    }

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
            handleEditable();
            handleBindCapability();
            
        }
    }
}()
