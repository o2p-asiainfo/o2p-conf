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
        $('#myModal').on('show.bs.modal', function(e) {
            $('#dt').dataTable({
                "processing": true,
                "serverSide": true,
                //"lengthMenu": [5, 10, 15, "All"],
                "ajax": "dataTable.jsp",
                "order": [],
                "autoWidth":false,
                "columnDefs": [{ "orderable": false, "width":"36px", "targets": 0 },{ "orderable": false, "targets": 3 }],
                "initComplete": function() {
                    App.initUniform();
                }
            });
            jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
            jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
        })
    }

    var handleBtnOnline = function() {
        $('#online').bind('click', function() {
            bootbox.confirm("Are you sure to take it online?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }

    var handleBtnUpgrade = function() {
        $('#upgrade').bind('click', function() {
            bootbox.confirm("Are you sure to upgrade it?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }

    var handleBtnDelete = function() {
        $('#delete').bind('click', function() {
            bootbox.confirm("Are you sure to delete it?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }

    var handleBtnOffline = function() {
        $('#offline').bind('click', function() {
            bootbox.confirm("Are you sure to take it offline?", function(result) {
                alert("Confirm result: " + result);
            });
        });
    }
    return {
        init: function() {
            handleEditable();
            handleBindCapability();
            handleBtnOffline();
            handleBtnDelete();
            handleBtnUpgrade();
            handleBtnOnline();
        }
    }
}()
