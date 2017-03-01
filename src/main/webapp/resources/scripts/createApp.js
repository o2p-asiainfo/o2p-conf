 
var CreateApp = function() {
    
    var handleForm = function() {

        $('#form1').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
            	appName: {
                    required: true,
                    minlength: 4
                },
                appType: {
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
    //----begin----handleAppOfferModal----------------
	 var handleAppOfferModal = function() {
		 
			var productCurrIndex = 0;
	        //弹窗展现前从后台加载表格数据
	        $('#addOfferModal').on('show.bs.modal', function(e) {
	        	var tableOffer = $('#appOfferDt').dataTable({
	                "processing": true,
	                "serverSide": true,
	                "ajax": _APP_PATH+"/mgr/apiOfferList.shtml",
	                "searching":false,
	                "order": [],
	                "autoWidth": false,
	                "columnDefs": [{
	                    "orderable": false,
	                    "targets": 0,
	                    "width": "36px"
	                }/*, {
	                	 "targets": 5,
	                     "bVisible": false
	                }, {
		               	 "targets": 6,
		                 "bVisible": false
		            }, {
		           	 "targets": 7,
		           	 "bSearchable": true,
		           	 "bVisible":true
		            }*/],
	                "initComplete": function() {
	                    App.ajaxInit();
	                    /*$('#productModal tbody').find('input[type="checkbox"]:checked').each(function(i,objCk) {
	                    	$('#productTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					$(this).closest('tr').addClass('active');
	          	  					return;
	          	  				}
	            		  	})
	                    })*/
	                }
	            });
	        	tableOffer.on( 'draw.dt', function () {
	        		App.ajaxInit();
	        		 $('#appOfferDt tr').find('div[class="checker"] span').each(function(i,objCk) {
                    	 $.each(offerIds,function(n,value) {  
                    		 $(objCk).find('input').each(function(i,inp){
                    		 if(inp.id ==value){
                    			 $(objCk).addClass('checked');
                    		 }
                    	   })
                    	 })
                    }) 
	        	} );
	            $('#btn-offer-search').bind('click',function() {
	            	debugger;
	                //var str = $('#apiForm').serialize();
	                var OfferName = $("#OfferName").val();
	                var checkApiIds = $("#checkApiIds").val();
	                var param = "";
	                var i=0;
	                if(""!=OfferName&&OfferName!="undefined"&&null!=OfferName){
	                	
	                	param=param+"OfferName="+OfferName;
	                	i++;
	                }
	                if(""!=checkApiIds&&checkApiIds!="undefined"&&null!=checkApiIds){
	                	
	                	if(i>0){
	                		param=param+"&checkApiIds="+checkApiIds;
	                	}
	                	param=param+"checkApiIds="+checkApiIds;
	                	i++;
	                }
	                 
	                tableOffer.api().ajax.url( _APP_PATH+"/mgr/apiOfferList.shtml?"+param).load();
 
	            });
	            
	            //jQuery('#appOfferDt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
	            //jQuery('#appOfferDt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
	          //  jQuery('#appOfferDt_wrapper .dataTables_length select').closest(".row").remove(); // modify table per page dropdown
	              jQuery('#appOfferDt_wrapper .dataTables_length').closest('.row').find('.col-md-6').remove();
		           
	        });
	        
	      //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
	        $('#btn-offer-Ok').bind('click', function() {
	        	 
	              $("#addOfferModal tbody tr input[type='checkbox']:checked").each(function(i,objCk) {
	            	  	var objTr=$(this).closest('tr');
	        		  	if(productCurrIndex==0){
	      	  				$("#appOfferTB tr").eq(0).remove();
	      	  				addTr(objTr,objCk.id);
	          	  		}else{
	          	  			//查重
	          	  			var _pass=true;
	          	  			$('#appOfferTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					_pass=false;
	          	  					return;
	          	  				}
	            		  	})
	            		  	if(_pass){
	      	  					addTr(objTr,objCk.id);
	      	  				}
	          	  		}
	              });
	              $("#addOfferModal").modal("hide");
	        });
	        var addTr=function(objTr,pId){
	        	productCurrIndex++;
		  		var tr=[];
		  		tr.push("<td>"+productCurrIndex+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(1).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(2).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(3).html()+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(4).html()+"</td>");
		  		tr.push('<td><a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a></td>');
		  		var trStr="<tr id='"+pId+"'>"+tr.join("")+"</tr>";
	    		$("#appOfferTB").append(trStr);
	        }
	        $('#appOfferTB').on('click', 'td .btn-del', function(e) {
	            e.preventDefault();
	            if (productCurrIndex >0) {
	            	productCurrIndex--;
	                $tbody = $(this).closest('tbody');
	                $(this).closest('tr').remove();
	                $tbody.find('tr>td:first-child').each(function(i) {
	                    $(this).html(i + 1);
	                })
	            }
	            if (productCurrIndex ==0) {
	            	$("#appOfferTB").append('<tr> <td colspan="6">None</td> </tr>');
	            }
	        })
		 }
	//----end----handleAppOfferModal----------------
    /** ----------begin  handleAppAPIModal ---------*/
	 var handleAppAPIModal = function() {
			var productCurrIndex = 0;
	        //弹窗展现前从后台加载表格数据
	        $('#apiModal').on('show.bs.modal', function(e) {
	         
	        	var str = $('#apiForm').serialize();
	         var tabeleapi = $('#apiDt').dataTable({
	                "processing": true,
	                "serverSide": true,
	                "ajax": {url:_APP_PATH+"/mgr/selectApiInfoList.shtml",data: str},
	                "searching":false,
	                "order": [],
	                "autoWidth": false,
	                "columnDefs": [{
	                    "orderable": false,
	                    "targets": 0,
	                    "width": "36px"
	                }/*, {
	                	 "targets": 5,
	                     "bVisible": false
	                }, {
		               	 "targets": 6,
		                 "bVisible": false
		            }, {
		           	 "targets": 7,
		           	 "bSearchable": true,
		           	 "bVisible":true
		            }*/],
	                "initComplete": function() {
	                    App.ajaxInit();
	                    /*$('#productModal tbody').find('input[type="checkbox"]:checked').each(function(i,objCk) {
	                    	$('#productTB tr').each(function(j,objPTr) {
	          	  				if(objPTr.id==objCk.id){
	          	  					$(this).closest('tr').addClass('active');
	          	  					return;
	          	  				}
	            		  	})
	                    })*/
	                }
	            });
	            $('#btn-api-search').bind('click',function() {
	            	debugger;
	                var str = $('#apiForm').serialize();
	                var apiName = $("#tmpAipName").val();
	                var dirId = $("#dirId").val();
	                var orgName = $("#Provider").val();
	                var param = "";
	                var i=0;
	                if(""!=apiName&&apiName!="undefined"&&null!=apiName){
	                	param=param+"tmpAipName="+apiName;
	                	i++;
	                }
	                if(""!=dirId&&dirId!="undefined"&&null!=dirId){
	                	if(i>0){
	                		param=param+"&dirId="+dirId;
	                	}else{
	                	    param=param+"dirId="+dirId;
	                	}
	                	i++;
	                }
	                if(""!=orgName&&orgName!="undefined"&&null!=orgName){
	                	debugger;
	                	if(i>0){
	                		param=param+"&orgName="+orgName;
	                	}else{
	                	    param=param+"orgName="+orgName;
	                	}
	                	i++;
	                }
	                 
	                tabeleapi.api().ajax.url( _APP_PATH+"/mgr/selectApiInfoList.shtml?"+param).load();
	                param = "";
	            });
	            tabeleapi.on( 'draw.dt', function () {
	            	
	            	 $('#apiDt input').each(function(i,objCk) { 
	                   	 $.each(apiIds,function(n,value) {  
	                   		if(objCk.id ==value){ 
	                   			 $(objCk).attr('checked',true);
	                   		 }
	                   	 })
	                   }) 
	            })
	            $('#btn-api-Ok').bind('click',function() {
	            	
	            	$("#apiModal").modal("hide");

                 });
	            
//	            jQuery('#apiDt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
//	            jQuery('#apiDt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown
	            jQuery('#apiDt_wrapper .dataTables_length').closest('.row').find('.col-md-6').remove();
		           
	           
	        });
	       
	      
		 }
    
	 /** ----------end  handleAppAPIModal ---------*/
	 
	 
    var handleBindCapability = function() {
        $('#myModal').on('show.bs.modal', function(e) {
            $('#dt').dataTable({
                "processing": true,
                "serverSide": true,                
                //"lengthMenu": [5, 10, 15, "All"],
                "ajax": "dataTable.jsp",
                "order": [],
                "autoWidth": false,
                "columnDefs": [{
                    "orderable": false,
                    "width": "36px",
                    "targets": 0
                }, {
                    "orderable": false,
                    "targets": 3
                }],
                "initComplete": function() {
                    App.initUniform();
                }
            });
            jQuery('#dt_wrapper .dataTables_filter input').addClass("form-control input-small input-inline"); // modify table search input
            jQuery('#dt_wrapper .dataTables_length select').addClass("form-control input-small"); // modify table per page dropdown 
             
        })
        $(".select2").select2();    
        
        var aa= function(){
        }
     }
    
    return {
        init: function() {
            handleForm();
            handleAppOfferModal();
            handleAppAPIModal();
            handleBindCapability();
        }
    }
}()

 function submitAdd() {
		    //验证输入：
		    if ($('#form1').valid() == false) {
		        return false;
		    }
        	var bindID  = []; 
        	$('#appOfferTB tr').each(function(j,objPTr) {
        		bindID.push(objPTr.id);
		  	})
		  	$("#bindOfferIds").val(bindID);
            var str = $('#form1').serialize();
            $.ajax({
                url: _APP_PATH+"/mgr/manageDevMgrSave.shtml",
                data: str,
                type: "post",
                dataType:"json",
                success: function(backdata) { 
                //  	返回
                	
                    if (backdata.code == "0000") {
                    	
                    	appDetail.action=_APP_PATH+"/mgr/manageDevMgr.shtml?appId="+backdata.appId;
                    	appDetail.submit();
                        toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.addsuccess'));
                    } else  {
                        toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.addfailure'));
                    }
                },
                error: function(error) {
                    toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.addfailure'));
                }
            });
        }

//var tabeleapi;
function searchApi(){               
 
    var str = $('#apiForm').serialize();
      
    $.ajax({
    	async : false,
        type: 'POST',
        url:  _APP_PATH+"/mgr/selectApiInfoList.shtml",
        data: str,
        dataType : "json",
        success: function(backdata) {
        	  
            if (backdata.code == "0000") {
                //$("#myModal").modal("hide");
                //resetFrom();
                oTable.api().ajax.reload();
               // $('#dt_processing').hide();
                 toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
            } else {
                toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
            }
        },
        error: function(error) { 
            toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
        }
    });
}

/**
 * -----begin-------记录选择的API--------------
 */
var apiIds = []; 
var apiNames = []; 

function apiCheck(opi,name){
	if(opi.checked){
		apiIds.push(opi.id);
		apiNames.push(name);
		}else{
			apiIds.pop(opi.id);
			apiNames.pop(name);
		}
    $("#CheckApi").val(apiIds);
    $("#CheckName").val(apiNames);
    $("#checkApiNames").val(apiNames);
    $("#checkApiIds").val(apiIds);
}
/**  ----end--------记录选择的API--------------
 */
 
/**
 * -----begin-------记录选择的OFFER--------------
 */
var offerIds = []; 
function offerCheck(opi){
	if(opi.checked){
		offerIds.push(opi.id);
	}else{
		offerIds.pop(opi.id);
	}
	    $("#CheckOffer").val(offerIds);
}
/**  ----end--------记录选择的OFFER--------------
 */
//----begin-------取消-------------------------------
$('#btn_new_app_cancel').bind('click', function() {
	form2.action=APP_PATH+"/mgr/developerCenter.shtml" ;
	form2.submit();
});
//----end-------取消-------------------------------
