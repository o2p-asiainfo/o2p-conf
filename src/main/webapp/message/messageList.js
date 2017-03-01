var messageInfo = function() {    
	//验证
	 var handleForm = function() {

        $('#form-add').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                msgTitle: {
                    required: true,
                    minlength: 4
                },
                msgWay:{
                    required:true,
                },
                msgRecType:{
                    required:true,
                },
                msgHandleAddress:{
                    required:true,
                },
                formatBeginDate:{
                    required:true,
                },
                formatEndDate:{
                    required:true,
                },
                msgContent:{
                    required:true,
                },   
               
            },
            messages: {
            	msgTitle: {
                    required:getLang('message_list_add_validate_msgTitle'),
                    minlength:getLang('message_list_add_validate_msgTitle_min4'),
                },
                msgWay:{
                    required:getLang('message_list_add_validate_msgWay'),
                },
                msgRecType:{
                    required:getLang('message_list_add_validate_msgRecType'),
                },
                msgHandleAddress:{
                    required:getLang('message_list_add_validate_msgHandleAddress'),
                },
                formatBeginDate:{
                    required:getLang('message_list_add_validate_formatBeginDate'),
                },
                formatEndDate:{
                    required:getLang('message_list_add_validate_formatEndDate'),
                },
                msgContent:{
                    required:getLang('message_list_add_validate_msgContent'),
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
                if (element.parents('.input-group').size() > 0) {
                    error.appendTo(element.closest('.input-group').attr("data-error-container"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },
            submitHandler: function(form) {
            	$("#msgRecRelRoleId").val($("#msgRecRelRoleIdArr").val().join(","));
                form.submit(); // form validation success, call ajax form submit
            }
        });
    }

	//时间
		var handleDatePickers = function(model) {
        var options = {};
        if (model == 'daily') {
            options = {
                autoclose: true,
                minViewMode: 'year',
                format: 'yyyy/mm/dd'
            }
        } else if (model == 'monthly') {
            options = {
                autoclose: true,
                minViewMode: 'months',
                format: 'yyyy/mm'
            }
        } else {
            options = {
                autoclose: true,
                minViewMode: 'year',
                format: 'yyyy/mm/dd'
            }
        }
        if (jQuery().datepicker) {
            $('.date-picker').datepicker(options);
        }
    }

    var handleDataTable = function() {
        //初始化表格数据
        var oTable = $('#messageDT').dataTable({
            "processing": true,
            "serverSide": true,
            "scrollX": true,
            "autoWidth": false,
            "searching": false,
            //"lengthMenu": [5, 10, 15, "All"],
            "ajax": "../message/dataGridOfMsgList.shtml",
            columns: [
                {"data": "index"},
                {"data": "msgId"},
                {"data": "msgTitle"},
                {"data": "msgSubtitle"},
                {"data": "msgTypeText"},
                {"data": "msgType"},
                {"data": "msgRecTypeText"},
                {"data": "msgRecType"},
                {"data": "msgWayText"},
                {"data": "msgWay"},
                {"data": "formatBeginDate"},
                {"data": "msgHandleAddress"},
                {"data": "statusCdText"},
                {"data": "statusCd"}
            ],
            "order": [],
            "columnDefs": [{
                "orderable": false,
                "width": "30px",
                "targets": [0,1,2,3,4,5,6,7,8,9,10,11,12,13]
            },
            {
            "visible": false,
            "targets": [1,3,5,7,9,13]
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
			handleDatePickers();
			$('#msgRecType').select2().val('1').trigger("change");
            $('.modal-title').html('MessageAdd');
            $('#btn-addMsg').show();
        });
        
        //点击修改
        $("#btn-detail").click(function() {
            resetFrom();
            $('.modal-title').html('Edit Message ')
            $('#btn-addMsg').hide();
            //判断是否有选择
            var oSelected = $("#messageDT tbody input[type='checkbox']:checked");
            if (oSelected.size() > 1) {
                toastr.error(getLang('message_list_only_one'));
            } else if (oSelected.size() == 1) {
                _editFun();
                $('#messageModal').modal('show');
            } else {
                toastr.error(getLang('message_list_no_choose'));
            }
        });

        $('#btn-del').bind('click', _deleteList);
        //add弹窗，确定提交按钮
        $('#btn-addMsg').click(function() {
            handleForm();
        });
        $("#btn-cancle").click(function(){
        	$("#messageModal").modal("hide");
            resetFrom();
        });
        

        /**
         * 编辑数据带出值
         */
        function _editFun() {
            var selected = oTable.fnGetData(oTable.$('tr.active').get(0));
             $.ajax({
                url: "../message/getMsgById.shtml",
                data: {
                    "message.msgId": selected.msgId
                },
                type: "get",
                cache: true,
                dataType:'json',
                success: function(backdata) {
                    if (backdata) {
                    	$('#msgId').val(backdata.message.msgId);
                        $('#msgTitle').val(backdata.message.msgTitle);
			            $('#msgSubtitle').val(backdata.message.msgSubtitle);
			            $('#msgWay').select2().val(backdata.message.msgWay).trigger("change");
			            $('#msgRecType').select2().val(backdata.message.msgRecType).trigger("change");
			            if("1"==backdata.message.msgRecType){
			            	var recId = [];
			            	var data = backdata.message.recId.split(",");
			            	$("#msgRecRelRoleId").val(backdata.message.recId);
			            	for(var id in data){
			            		recId.push(data[id]);
			            	}
			            	$('#msgRecRelRoleIdArr').select2().val(recId).trigger("change");
			            }else if("2"==backdata.message.msgRecType){
			            	$('#msgRecRelPersonalId').val(backdata.message.recId);
			            	$('#personRecName').val(backdata.message.recName);
			            }
			                             
			            $("#msgHandleAddress").val(backdata.message.msgHandleAddress);
			            $("#formatBeginDate").val(backdata.message.formatBeginDate);
			            $('#formatEndDate').val(backdata.message.formatEndDate);
			            $('#msgContent').val(backdata.message.msgContent);
                    } 
                },
                error: function(error) {
                    console.log(error);
                }
            });
        }
		
        /**
         * 添加数据
         * @private
         */
        function _addFun() {
        	
            var str = $('form').serialize();
            $.ajax({
                url: "../message/addOrUpdate.shtml",
                data: str,
                type: "post",
                success: function(backdata) {
                    if (backdata.result == 1) {
                        $("#messageModal").modal("hide");
                        resetFrom();
                        oTable.api().ajax.load();
                        $('#dt_processing').hide();
                        toastr.success(getLang(message_operation_success));
                    } else if (backdata.result == 0) {
                        toastr.error(getLang('message_operation_fail'));
                    }
                },
                error: function(error) {
                    toastr.error(error);
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
                    url: '../message/addOrUpdate.shtml',
                    data: str,
                    success: function(backdata) {
                        if (backdata == 1) {
                            $("#messageModal").modal("hide");
                            resetFrom();
                            oTable.api().ajax.load();
                            $('#dt_processing').hide();
                             toastr.success(getLang());
                        } else if (backdata == 0) {
                            toastr.error(getLang('message_operation_fail'));
                        }
                    },
                    error: function(error) {
                        toastr.error(error);
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
                url: "../message/delMessage.shtml",
                data: {
                    "msgIds": IDS
                },
                type: "get",
                cache: true,
                success: function(backdata) {
                    if (backdata) {
                        oTable.api().ajax.reload();
                        $('#dt_processing').hide();
                    } else {
                        alert(getLang('message_operation_fail'));
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
            
            $("#messageDT tbody input[type='checkbox']:checked").each(function(i, o) {
                str += $(this).val();
                str += ",";
            });
            if (str.length > 0) {
                var IDS = str.substr(0, str.length - 1);
                bootbox.confirm(getLang('message_list_del') + IDS, function(result) {
                    _deleteFun(IDS)
                })
            } else {
                toastr.error(getLang('message_list_lt_one'));
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
            handleDataTable();
            handleForm();
        },
    }

}()


     //查询后的数据表单
       var handleDataTable_listDt = function() {
           //初始化表格数据
           var oTable = $('#listDt').dataTable({
               "processing": true,
               "serverSide": true,
               //"searching": false,
               //"lengthMenu": [5, 10, 15, "All"],
               "ajax": "../message/getOrgList.shtml",
               columns: [
                {"data": "index"},
                {"data": "ORGID"},
                {"data": "NAME"},
                {"data": "ORGCODE"},
                {"data": "USERNAME"},
                {"data": "PHONE"},
                {"data": "EMAIL"},
                {"data": "DESCRIPTOR"}
            ],
               "order": [],
               "autoWidth": false,
               "columnDefs": [{
                   "orderable": false,
                   "width": "36px",
                   "targets": 0
               }],
               "initComplete": function() {
                   App.initUniform();
                   $("#isReady").val('1');
               }
           });
           jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
           jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
    }



function receiveTypeChange(rtValue){
    if(rtValue=="2"){
        $('#IndividualsReceivingDiv').show();
        $('#objectDiv').hide();
        $('#timeDiv').hide();
    }else if(rtValue=="1"){
        $('#IndividualsReceivingDiv').hide();
        $('#objectDiv').show();
        $('#timeDiv').show();
    }else{

    }
}

function filterColumn ( i ) {
    $('#messageDT').DataTable().column( 1 ).search(
        $('#msgTitleSearch').val(),
        true,
        true
    ).draw();
}

$(document).ready(function() {
    $("#orgSearchBtn").click(function(){
    	if("0"==$("#isReady").val()){
    		handleDataTable_listDt();
    	}else{
    		
    	}
    });
    
    /**
     * 表格查询操作
     */
    $('#bntMsgSearch').unbind().click(function(e){
    	var msgTitle = $('#msgTitleSearch').val();
    	var msgType = $('#msgTypeSearch').val();
    	var msgRecType = $('#msgRecTypeSearch').val();
    	var msgWay = $('#msgWaySearch').val();
    	var statusCd = $('#statusCdSearch').val();
    	
    	var url = '../message/dataGridOfMsgList.shtml?msgTitle='+msgTitle
    	        + '&msgType='+msgType
    	        + '&msgRecType='+msgRecType
    	        + '&msgWay='+msgWay
    	        + '&statusCd='+statusCd;
    	$('#messageDT').dataTable().api().ajax.url(url).load();
    	
    	e.stopPropagation();
    });
    
   //取消页面
   $('#btn-org-cancle').click(function() {
       $("#SeachModal").modal("hide");
    }); 
    $('#btn-org-add').click(function() {
       var str = '';
            
            $("#listDt tbody input[type='checkbox']:checked").each(function(i, o) {
                str += $(this).val();
                str += ",";
            });
            if (str.length > 0) {
                var IDS = str.substr(0, str.length - 1);
                var oTable = $('#listDt').dataTable();
                var aTrs = oTable.fnGetNodes();
                var aReturn = new Array();
                    for (var i = 0; i < aTrs.length; i++) {
                      if ($(aTrs[i]).hasClass('active')) {
                         aReturn.push(oTable.fnGetData(aTrs[i]).USERNAME);
                       }
                   }
                $("#msgRecRelPersonalId").val(IDS);
                $("#personRecName").val(aReturn.join(","));
                $("#SeachModal").modal("hide");
            } else {
                toastr.error(getLang('message_list_lt_one'));
            }
    });
         
} );



