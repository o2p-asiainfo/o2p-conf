var AddPartnerProduct = function() {

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
                systemName: {
                    required: true,
                }
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
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group 
            },

            success: function(label) {             
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },
            errorPlacement: function(error, element) {
                // error.insertAfter(element.closest('.input-icon'));
                if (element.parents('.table').size() > 0) {
                    error.appendTo(element.closest('.table').attr("data-error-container"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            submitHandler: function(form) {
                form.submit(); // form validation success, call ajax form submit
            }
        });
    }

    var handleProductAttributeModal = function() {
        //弹窗展现前从后台加载表格数据
        $('#productAttributeModal').on('show.bs.modal', function(e) {
                $('#dt1').dataTable({
                    "processing": true,
                    "serverSide": true,
                    "ajax": "dataTable.jsp",
                    "order": [],
                    "autoWidth": false,
                    "columnDefs": [{
                        "orderable": false,
                        "targets": 0,
                        "width": "36px"
                    }, {
                        "orderable": false,
                        "targets": 4
                    }],
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

    var handleTableFunction = function() {
        var currIndex = 1;
        var tmpl = ['<div class="input-help">', '<input type="text" class="form-control input-xs" placeholder="" name="" required>', '<a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a>']
            // add tr
        $('.table-function').on('click', 'th .fa-plus', function() {
                currIndex++;
                $(this).closest('table').find('tbody').append('<tr><td>' + currIndex + '</td><td>' + tmpl[1] + '</td><td>' + tmpl[1] + '</td><td>' + tmpl[2] + '</td></tr');

            })
            // remove tr
        $('.table-function').on('click', 'td .btn-del', function(e) {
            e.preventDefault();
            if ($(this).closest('tbody').find('tr').size() > 1) {
                currIndex--;
                $tbody = $(this).closest('tbody');
                $(this).closest('tr').remove();
                $tbody.find('tr>td:first-child').each(function(i) {
                    $(this).html(i + 1);
                })
            }
        })

    }




    return {
        init: function() {
            handleForm();
            handleProductAttributeModal();
            handleTableFunction();

        }
    }
}()
