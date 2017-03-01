var SaleablePorduct = function() {

    var handleSelect2 = function() {
        $(".js-example-placeholder-single").select2();
    }

    var handleDataTable = function() {

        var oTable = $('#dt').dataTable({
            "processing": true,
            "serverSide": true,
            //"searching": false,
            //"lengthMenu": [5, 10, 15, "All"],
            "ajax": "dataTable_saleableProduct.jsp",
            "columns": [{
                "orderable": false,
                "data": null,
                "defaultContent": '<span class="row-details-btn row-details-close"></span>'
            }, {
                "data": "type"
            }, {
                "data": "provider"
            }, {
                "data": "code"
            }, {
                "data": "name"
            }, {
                "data": "model"
            }, {
                "data": "quantity"
            }, {
                "data": "status"
            }, {
                "data": null,
                "orderable": false,
            }],
            columnDefs: [{
                    targets: 8,
                    render: function(data, type, full, meta) {
                        var html = '<button class="btn btn-xs yellow filter-cancel" onClick="do(\'' + full.code + '\')">Apply</button>';
                        return html;
                    }
                }

            ],
            "order": [
                [1, 'asc']
            ],
            "initComplete": function() {
                App.initUniform();
            }
        });
        jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
        jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown 

        // Add event listener for opening and closing details
        $('#dt tbody').on('click', '.row-details-btn', function() {
            var tr = $(this).closest('tr');
            var row = oTable.api().row(tr);
            if (row.child.isShown()) {
                // This row is already open - close it
                row.child.hide();
                $(this).removeClass('row-details-open').addClass('row-details-close');
            } else {
                // Open this row
                row.child(format(row.data()), 'row-details').show();

                $(this).removeClass('row-details-close').addClass('row-details-open');
            }
        });

        /* Formatting function for row details - modify as you need */
        function format(d) {
            // `d` is the original data object for the row
            return '<table cellpadding="5" cellspacing="0" border="0">' +
                '<tr>' +
                '<td><strong>Description:</strong></td>' +
                '<td>' + d.description + '</td>' +
                '</tr>' +
                '</table>';
        }

    }


    return {
        init: function() {
            handleDataTable();
            handleSelect2();
        }
    }
}()
