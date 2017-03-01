var ProductAttribute = function() {

    
	//验证
	 var handleForm = function() {

        $('#form-add').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                title: {
                    required: true,
                    minlength: 4
                },
                subtitles: {
                    required: true,
                },
                remeintheway: {
                    required: true,
                },
                address:{
                    required:true,
                },
                ReceiveType:{
                    required:true,
                },
                object:{
                    required:true,
                },
            },

            messages: {
                title: {
                    required: "Title is required."
                },
                subtitles:{
                    required: "Subtitles is required."
                },
                remeintheway:{
                    required:"Remein the way is required."
                },
                ReceiveType:{
                    required:"is required",
                },
                address:{
                    required:"Address is required."
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

    //显示隐藏

        


	//时间
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

    var handleSwitch = function() {

        $("[name='my-checkbox']").bootstrapSwitch({
            onText: 'Daily',
            offText: 'Monthly',
            offColor: 'primary',
        }).on('switchChange.bootstrapSwitch', function(event, state) {
            if (state) {
                // by day
                $('.input-daterange').find('input').attr({
                    'placeHolder': 'mm/dd/yyyy',
                    'value': ''
                });
                $('.datepicker').datepicker('update', '')
                $('.date-picker').datepicker('remove');
                handleDatePickers('daily');
            } else {
                // by month
                $('.input-daterange').find('input').attr({
                    'placeHolder': 'mm/yyyy',
                    'value': ''
                });
                $('.date-picker').datepicker('remove');
                handleDatePickers('monthly');
            }
        });

    }
    var handleDataTable = function() {
        //初始化表格数据
        var oTable = $('#dt').dataTable({
            "processing": true,
            "serverSide": true,
            //"searching": false,
            //"lengthMenu": [5, 10, 15, "All"],
            "ajax": "dataTable_productAttribute.jsp",
            "order": [],
            "autoWidth": false,
            "columnDefs": [{
                "orderable": false,
                "width": "36px",
                "targets": 0
            }],
            "initComplete": function() {
                App.initUniform();
            }
        });
        jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
        jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
		
        //点击添加
        $("#btn-add").click(function() {
            resetFrom();
            $('#btn-save').hide();
            $('.modal-title').html('MessageAdd');
            $('#btn-add-ok').show();
        });
        //点击修改
        $("#btn-edit").click(function() {
            resetFrom();
            $('#btn-save').show();
            $('.modal-title').html('Edit Product Attribute')
            $('#btn-add-ok').hide();
            //判断是否有选择
            var oSelected = $("tbody input[type='checkbox']:checked");
            if (oSelected.size() > 1) {
                toastr.error("一次只能编辑一条记录");
            } else if (oSelected.size() == 1) {
                _editFun();
                $('#myModal').modal('show');
            } else {
                toastr.error("至少选择一条记录操作");
            }



        });

        $('#btn-del').bind('click', _deleteList);
        //add弹窗，确定提交按钮
        $('#btn-add-ok').click(function() {
            handleForm(_addFun);
        });
        //edit弹窗，确定提交按钮
        $('#btn-save').click(function() {
            handleForm(_editFunAjax);
        });
		
        

        /**
         * 编辑数据带出值
         */
        function _editFun() {
            var selected = oTable.fnGetData(oTable.$('tr.active').get(0));
            $('#code').val(selected[2]);
            $('#name').val(selected[3]);
            //$('#min').val(selected[2]);
            //$('#max').val(selected[2]);                 
            $("#type").val(selected.Satou);
            $("#value").val(selected[4]);
            $("#remarks").val(selected[5]);
            $('#customized').val(selected[6]);
        }

        /**
         * 添加数据
         * @private
         */
        function _addFun() {
            var str = $('form').serialize();
            $.ajax({
                url: "insert.jsp",
                data: str,
                type: "post",
                success: function(backdata) {
                    if (backdata == 1) {
                        $("#myModal").modal("hide");
                        resetFrom();
                        oTable.api().ajax.reload();
                        $('#dt_processing').hide();
                        toastr.success('添加成功');
                    } else if (backdata == 0) {
                        toastr.error('添加失败');
                    }
                },
                error: function(error) {
                    toastr.error('添加失败');
                }
            });
        }

        /**
         * 编辑数据
         * @private
         */
        function _editFunAjax() {                
                var str = $('form').serialize();
                $.ajax({
                    type: 'POST',
                    url: 'edit.jsp',
                    data: str,
                    success: function(backdata) {
                        if (backdata == 1) {
                            $("#myModal").modal("hide");
                            resetFrom();
                            oTable.api().ajax.reload();
                            $('#dt_processing').hide();
                             toastr.success('编辑成功');
                        } else if (backdata == 0) {
                            toastr.error('编辑失败');
                        }
                    },
                    error: function(error) {
                        toastr.error('添加失败');
                    }
                });
            }
			
            /**
             * 删除
             * @param id
             * @private
             */
        function _deleteFun(IDS) {
            $.ajax({
                url: "del.jsp",
                data: {
                    "ids": IDS
                },
                type: "get",
                cache: true,
                success: function(backdata) {
                    if (backdata) {
                        oTable.api().ajax.reload();
                        $('#dt_processing').hide();
                    } else {
                        alert("删除失败");
                    }
                },
                error: function(error) {
                    console.log(error);
                }
            });
        }
		
        /**
         * 批量删除
         * 未做
         * @private
         */
        function _deleteList() {
            var str = '';
            $("tbody input[type='checkbox']:checked").each(function(i, o) {
                str += $(this).val();
                str += ",";
            });
            if (str.length > 0) {
                var IDS = str.substr(0, str.length - 1);
                bootbox.confirm("你要删除的数据集id为" + IDS, function(result) {
                    alert(result);
                    _deleteFun(IDS)
                })
            } else {
                toastr.error("至少选择一条记录操作");
            }
        }

        /**
         * 重置表单
         */
        function resetFrom() {
            $('form').each(function(index) {
                $('form')[index].reset();
                $('form').find('.help-block').remove();
                $('form').find('.form-group').removeClass('has-error');
            });
        }

    }

    return {
        init: function() {
			handleForm();
            handleDataTable();
			handleDatePickers();
        },

    }

}()


function receiveTypeChange(rtValue){
    if(rtValue=="1"){
        $('#IndividualsReceivingDiv').show();
        $('#objectDiv').hide();
        $('#timeDiv').hide();
    }else if(rtValue=="2"){
        $('#IndividualsReceivingDiv').hide();
        $('#objectDiv').show();
        $('#timeDiv').show();
    }else{

    }

}



