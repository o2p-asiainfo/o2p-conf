var CreateApp = function() {

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
                applicationType: {
                    required: true
                },
            },

            messages: {
                userName: {
                    required: "Username is required."
                },
                password: {
                    required: "Password is required."
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit                       
                App.scrollTop();
            },

            highlight: function(element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },

            errorPlacement: function(error, element) {
                // error.insertAfter(element.closest('.input-icon'));
                if (element.parents('.checkbox-list').size() > 0) {
                    error.appendTo(element.parents('.checkbox-list').attr("data-error-container"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            submitHandler: function(form) {
                form.submit(); // form validation success, call ajax form submit
            }
        });

    
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
    return {
        init: function() {
            handleForm();
            handleBindCapability();
        }
    }
}()
