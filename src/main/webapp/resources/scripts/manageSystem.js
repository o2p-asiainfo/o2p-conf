var showTopTable;
var showTable;
var $modaloffer;
var offerSysTable;
var offerAddCap;
var $modal;
var ManageSystem = function() {
    var hanldeEditable = function() {
        $('a[data-name="name"]').editable({
            url: "../provider/updateComponentContent.shtml?componentId="+$('#hidComponentId').val(), //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            submitBy:'change',
            name: 'name',
            title: sysNameShow,
            inputclass: 'form-control input-medium',
            params: function(params) {
                params.sysName = params.value;
                return params;
            },
            success: function(response, newValue) {
            },
            error: function(response, newValue) {
                if(response.status === 500) {
                    return 'Service Unavailable. Please Try Later.';
                }
            }
        });
        $('a[data-name="systemDetail"]').editable({
            url: "../provider/updateComponentContent.shtml?componentId="+$('#hidComponentId').val(), //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'textarea',
            pk: 1,
            name: 'SystemDetail',
            title: '',
            inputclass: 'form-control input-medium',
            params: function(params) {
                    params.sysDetail = params.value;
                    return params;
            },
            success: function(response, newValue) {
            },
            error: function(response, newValue) {
                 if(response.status === 500) {
                     return 'Service Unavailable. Please Try Later.';
                 }
            }	
        });
    };
    showTopTable = $('#showTopTable').dataTable({
		'ordering':false,
		"ajax": "../provider/showAbility.shtml?componentId="+$('#hidComponentId').val(),
		"paging":false,
		"info":false,
		"searching": false
		});
    var handleGeneralModal = function($modal) {

            //弹窗显示后 加载表格          

                    $('#ok').hide();
                    $('#back').hide();
                    $('.step2').hide();
                    showTable = $('#dt').dataTable({
                        "processing": true,
                        "serverSide": true,
                        "ajax": "../provider/queryGeneralRecords.shtml?componentId="+$('#hidComponentId').val(),
                        "autoWidth": false,
                        "ordering": false,
                        "info":false,
                        "paging":false,
                        "searching": false,
                        "columnDefs": [{
                            "orderable": false,
                            "width": "36px",
                            "targets": 0
                        }, {
                            "orderable": false,
                            "targets": 2
                        }],
                        "initComplete": function() {
                            App.ajaxInit();
                        }
                    });
                    jQuery('#dt_wrapper .dataTables_length').closest('.row').remove(); // modify table per page dropdown 
                    //
                    $(document).on('click', '#next', function() {     
                    	var num = 0;
                	    $('#serviceAttrAdd>.col-md-6').each(function(){
                	    	num++;
                	    });
                	    if(num < 1){
                	       toastr.error(oneRecords);
                	    }else{
                	    	$('.step2').show();
                            $('.step1').hide();
                            $modal.modal('layout');
                	    }
                        });
                        //
                    $(document).on('click', '#back', function() {
                        $('.step2').hide();                        
                        $('.step1').show();
                        $modal.modal('layout');
                    });
                    $(document).on('click', '#ok', function() {
                    	generalSubmit();
                        $modal.modal('hide');
                        $('#serviceAttrAdd').empty();//清空
                        var url="../provider/showAbility.shtml?componentId="+$('#hidComponentId').val();
                        showTopTable.api().ajax.url(url).load();
                    });
                    $(document).on('change', '#dt input[type="checkbox"]', function() {
                        var trId = $(this).attr('trId');
                        var trName = $(this).attr('trName');
                        var serviceId  = $(this).val();
                        if($(this).is(":checked")){
                        	$('#'+trId).remove();
                        	var htmlValue = '<div class="col-md-6" id='+trId+'><div class="form-group"><label class="control-label">'
                        	+trName+':</label>'
                        	+'<input type="hidden" name="generalServiceId" value='+serviceId+'>'
                        	+'<input type="text" name="attrspecValue" class="form-control" placeholder="Service Address"  maxlength="200">'
                        	+'</div></div>';
                            $('#serviceAttrAdd').append(htmlValue);
                         }else{
                            $('#'+trId).remove();
                          }
                        
                    });
        };
        /**
         * ------begin--------SysOfferModal---------mjf----------------------------------------------
         */
        //----begin----handleSysOfferModal----------------
   	 var handleSysOfferModal = function() {
   		 
   			var productCurrIndex = 0;
   			offerSysTable = $('#offerSysDt').dataTable({
                "processing": true,
                "serverSide": true,
                "paging":false,
                "ajax":  APP_PATH+"/provider/provPackage.shtml?componentId="+$('#hidComponentId').val(),
            "searching": false,
                "ordering": false,
                "autoWidth": false,
                "columnDefs": [{
                    "width": "36px",
                    "targets": 0
                }],
                "initComplete": function() {
                    App.ajaxInit();
                }
            });
   	       //offer：添加capability时，加载弹窗内的table数据
   			//$modaloffer= $('#offerSysModal');
   			$('#btn-offerSys-Ok').on('click',function(){ 
   				 
   			 var $this = $('#'+offerAddCap); 
	             bootbox.confirm("Are you sure to package these Capabilitys("+$("#capabilityCheckName").val()+") to a Offer?", function(result) {
	            	if(result){
	            		//保存 offerName 和 Capabilitys
	            		//将放回的
	            	   //获取OFFER名称
	   	            	//$('#offerName').val($("#offerNameNew").val());$this
	            		$('#offerName').val($this.closest('tr').children('td').eq(1).html());
	            		
	   	                 var str = $('#offerSysForm').serialize(); 
	            		$.ajax({
	                     url: APP_PATH+"/provider/addOffer.shtml",
	                     data: str,
	                     type: "post",
	                     dataType:"json",
	                     success: function(backdata) { 
	                    	
	                         if (backdata.code == "0000") {
	                        	 //名称回写到页面
	                        	$this.closest('tr')[0].id=backdata.id;
	                        	$('#offerSysModal').modal('hide');
	        	                $this.closest('td').html($('#capabilityCheckName').val());
	        	             
   	        	            $(".checkbox").attr("checked", false);

	                             toastr.success('Success');
	                         } else if (backdata == 0) {
	                             toastr.error('Fail');
	                         }
	                     },
	                     error: function(error) {
	                         toastr.error('Fail');
	                     }
	                 });
	            		
	            	}
	             });
 	              
	            	

	            });
   	        $(document).on('click', '.addCapability', function() {
   	            var $this = $(this);
   	         var url="../provider/provPackage.shtml?componentId="+$('#hidComponentId').val();
   	            offerSysTable.api().ajax.url(url).load();
   	            offerAddCap = $this.closest('td')[0].id;
   	             //清空capabilityCheckName 和id
  	             capabilityCheckId=[];
  	             capabilityCheckName=[];
   	            $('#offerSysModal').modal('show');
   	         
   	            
   	            
   	         jQuery('#offerSysDt_wrapper .dataTables_length').closest('.row').find('.col-md-6').remove(); // modify table per page dropdown 
   	            
   	        })
   	        var num = 0;//判断是否第一次加载addTabMenu方法，如果已经加载就不再加载。
   	         //offer：添加price plan是，加载弹窗内的form 
            $(document).on('click','.addPricePlan',function(){
            	    if($(this).closest('tr')[0].id==""){
            	    	//toastr.error('您还未添加能力，请先添加能力。');
            	    	toastr.error('Please add Capabilitys before create a PricePlan.');
            	    	return;
            	    }
            	    $("#hidProdOfferId").val($(this).closest('tr')[0].id);
            	   // alert($(this).closest('tr').children('td').eq(1).html());
            	    $("#hidProdOfferName").val($(this).closest('tr').children('td').eq(1).html());
            	    
            	    var nameStr = $(this).closest('tr').children('td').eq(1).html();
            	    
                    $modal = $('#modal4');
                    $('#modal4').load(APP_PATH+'/provider/toPricePlan.shtml?&prodOfferId='+$(this).closest('tr')[0].id+'&componentId='+$('#hidComponentId').val(), '', function() {
                        $('#modal4 ul[data-set="addTarget"]').find('a').each(function(index) {
                        	 
                            $(this).attr('data-target', '#modal4_' + index);
                            $(this).addClass('form-horizontal');
                        });
                        
                        $('#pricingName').val(nameStr+"Price_Plan_"+1);
                        App.ajaxInit(); 
                        PricePlanAdd.init('#modal4',num);
                        num++;
                        $('#modal4').modal('layout');
                        handleJstree('#jstreemjf');
 
                    	$('.dropdown-toggle2').dropdownHover();
                    });
                    $modal.modal('show');
            });
                   //offer：编辑price plan是，加载弹窗内的form 
            $(document).on('click','.editPricePlan',function(){
                    $modal = $('#modal4');
                    $("#hidProdOfferId").val($(this).closest('tr')[0].id);
             	   // alert($(this).closest('tr').children('td').eq(1).html());
             	    $("#hidProdOfferName").val($(this).closest('tr').children('td').eq(1).html());
                    var priceId=$(this).closest('a')[0].id;
                    var tagId =$(this).closest('a')[0].name;
                    $('#modal4').load(APP_PATH+'/provider/toPricePlan.shtml?actionType=update&pricingInfoId='+priceId+'&pricingTargetId='+tagId+'&prodOfferId='+$(this).closest('tr')[0].id+'&state='+$('#state').val()+'&componentId='+$('#hidComponentId').val(), '', function() {
                    
                       $('#modal4 ul[data-set="addTarget"]').find('a').each(function(index) {
                            $(this).attr('data-target', '#modal4_' + index);
                        });

                        App.ajaxInit();
                        PricePlanAdd.init('#modal4',num);
                        num++;
                        $('#modal4').modal('layout');
 
                        $('.dropdown-toggle2').dropdownHover();
                        
                        //编辑页面初始化显示第一页：
                    	var tab2Chils = $('#modal4').find(".tab2Chil_TabUL").find("a");
                    	if(tab2Chils.length>0){
                    		tab2Chils[0].click();
                    	}
                    });
                    $modal.modal('show');
            });
            
            $(document).on('click','.delPricePlan',function(){
            	//$("#hidProdOfferId").val($(this).closest('tr')[0].id);
                var offerID = $(this).closest('tr')[0].id;
                 var id = $(this).closest('a')[0].id;
                 var tag= $(this).closest('a')[0].name;
                 var priceId=id.replace("0minus0","");
                 var tagId =tag.replace("0minus0","");
                 var liid = $(this).closest('li')[0].id;
                 bootbox.confirm("Are you sure to delete this Price plan ?", function(result) {
    	            	if(result){
    	            		 
    	            		$.ajax({
    	                		type: "POST",
    	                		async:true,
    	                	    url: APP_PATH+'/provider/delete.shtml?actionType=update&priceInfoId='+priceId+'&pricingTargetId='+tagId+'&prodOfferId='+offerID+'&componentId='+$('#hidComponentId').val(),
    	                	    dataType:'json',
    	                	   // data:thisForm.serialize(),
    	                	    success:function(msg){
    	                	    	//{"priceId":"100000010","code":"0000","desc":"Success"}
    	                	    	if(msg.code!=null && msg.code=="0000" ){
    	                		    	 //删除
    	                	    		 $('#'+liid).remove();
    	                	    	}else{
    	                				toastr.error('Save Fail.');
    	                	    	}
    	                	    }
    	                	});
    	            	}
    	            	
                 });
 
            });
            /**
             * ------------------addSettle------------------------------------
             */
           // var num = 0;//判断是否第一次加载addTabMenu方法，如果已经加载就不再加载。
  	         //offer：添加price plan是，加载弹窗内的form 
           $(document).on('click','.addSettle',function(){
        	 //  alert(1);
           	    if($(this).closest('tr')[0].id==""){
           	    	//toastr.error('您还未添加能力，请先添加能力。');
           	    	toastr.error('Please add Capabilitys before create a Settle.');
           	    	return;
           	    } 
           	    $("#hidProdOfferId").val($(this).closest('tr')[0].id);
           	   // alert($(this).closest('tr').children('td').eq(1).html());
           	    $("#hidProdOfferName").val($(this).closest('tr').children('td').eq(1).html());
           	    
           	    var nameStr = $(this).closest('tr').children('td').eq(1).html();
           	    
                   $modal = $('#modal6');
                   $('#modal6').load(APP_PATH+'/provider/toSettle.shtml?&prodOfferId='+$(this).closest('tr')[0].id+'&actionType=add'+'&componentId='+$('#hidComponentId').val(), '', function() {
                       $('#modal6 ul[data-set="addTarget"]').find('a').each(function(index) {
                       	 
                           $(this).attr('data-target', '#modal6_' + index);
                           $(this).addClass('form-horizontal');
                       });
                       
                       $('#ruleName').val(nameStr+"_Settle_"+1);
                       App.ajaxInit(); 
                    //   PricePlanAdd.init('#modal5',num);
                       $('#modal6').modal('layout');
                      // handleJstree('#jstreemjf');

                   	$('.dropdown-toggle2').dropdownHover();
                   });
                   $modal.modal('show');
           });
           /**
            * ---------end---------addSettle------------------------------------
            */
           /**
            * ------------------editSettle------------------------------------
            */
                  //offer：编辑price plan是，加载弹窗内的form 
           $(document).on('click','.editSettle',function(){
        	    
                   $modal = $('#modal6');
                   $("#hidProdOfferId").val($(this).closest('tr')[0].id);
            	   // alert($(this).closest('tr').children('td').eq(1).html());
            	    $("#hidProdOfferName").val($(this).closest('tr').children('td').eq(1).html());
                   var ruleId=$(this).closest('a')[0].id;
                   var tagId =$(this).closest('a')[0].name;
                   $('#modal6').load(APP_PATH+'/provider/toSettle.shtml?&prodOfferId='+$(this).closest('tr')[0].id+'&actionType=update&ruleId='+ruleId+'&componentId='+$('#hidComponentId').val(), '', function() {
                   
                      $('#modal6 ul[data-set="addTarget"]').find('a').each(function(index) {
                           $(this).attr('data-target', '#modal6_' + index);
                       });
                      
                       App.ajaxInit();
                      // PricePlanAdd.init('#modal5',num);
                      // num++;
                       $('#modal6').modal('layout');

                       $('.dropdown-toggle2').dropdownHover();
                   });
                   $modal.modal('show');
           });
           
           /**
            * ---------end---------editSettle------------------------------------
            */
           
           
         //--------------流程模板----------------------------------
         //  alert(1);
           //general添加弹窗
           $(document).on('click', '.add-process', function() { 
               //var openURL = "http://10.1.234.62:8080/conf/serviceManager/showMainInfo.shtml?pageState=pageState&serInvokeInsId=INVOKE_API&serInvokeInsName=INVOKE_API_NAME";
        	   
        		
        	   var openURL = APP_PATH+'/process/openingProcess.shtml?systemId='+$('#hidComponentId').val()+'&processId='+$('#sysProcessId').val();
        	   
                var curr_window;
                x = (window.screen.width - 1100) / 2;
                y = (window.screen.height - 570) / 2 - 30;
                curr_window = window.open(openURL, 'Choose');
                curr_window.focus();  
        	   
        	   
//        	------------------------------------------------   
//        	   $modal = $('#modal7');
//               $modal.load(APP_PATH+'/process/openingProcess.shtml?systemId='+$('#hidComponentId').val(), '', function() {
//                   $modal.modal('show');
//               })
//        	   var url = APP_PATH + "/process/openingProcess.shtml?systemId="+$('#hidComponentId').val();
//	             
//	             $('#addProcessIframe').attr('src',url);
//	      	     $('#addProcess').modal('show');
	      	     $('#processName').val("processName");
	             $('#processId').val($('#sysProcessId').val());
               });
           
           /**
            * ------------------editProcess------------------------------------
            */
                  //offer：编辑price plan是，加载弹窗内的form 
           $(document).on('click','.editProcess',function(){
        	   var openURL = APP_PATH+'/process/openingProcess.shtml?systemId='+$('#hidComponentId').val()+'&processId='+$('#sysProcessId').val()+'&optType=edit';
        	   
               var curr_window;
               x = (window.screen.width - 1100) / 2;
               y = (window.screen.height - 570) / 2 - 30;
               curr_window = window.open(openURL, 'Choose');
               curr_window.focus();  
        	   
        	   
        	   
        	   
//        	   $modal = $('#modal7');
//               $modal.load(APP_PATH+'/process/openingProcess.shtml?systemId='+$('#hidComponentId').val()+'&processId='+$('#sysProcessId').val()+'&optType=edit', '', function() {
//            	   $('#processName').val('My Process');
//            	   $modal.modal('show');
//               })
        	   
 
	             $('#processId').val($('#sysProcessId').val());
           });
           
           /**
            * ---------end---------editProcess------------------------------------
            */
           
           /**
            * ------------------delProcess------------------------------------
            */
                  //offer：编辑price plan是，加载弹窗内的form 
           $(document).on('click','.delProcess',function(){
        	   //debugger;
        	   var processIdtr=$(this).closest('tr')[0].id;
        	   var processId=processIdtr.replace('TR','');  
        	   bootbox.confirm("Are you sure to delete this Process ?", function(result) {
  	            	if(result){
  	            		 
  	            		$.ajax({
  	                		type: "POST",
  	                		async:true,
  	                	    url: APP_PATH+'/process/delProcess.shtml?processId='+processId,
  	                	    dataType:'json',
  	                	   // data:thisForm.serialize(),
  	                	    success:function(msg){
  	                	    	//{"priceId":"100000010","code":"0000","desc":"Success"}
  	                	    	if(msg.code!=null && msg.code=="0000" ){
  	                		    	 //删除
  	                	    		$('#'+processIdtr).remove();
  	                	    		 
  	                	    		//$('#addprocessbtn').attr('hidden',false);
  	                	    	}else{
  	                				toastr.error('Save Fail.');
  	                	    	}
  	                	    }
  	                	});
  	            	}
        	   });
           });
           
           /**
            * ---------end---------delProcess------------------------------------
            */
           
           /**
            * ---------begin---------delSettle------------------------------------
            */
           $(document).on('click','.delSettle',function(){ 
           	//$("#hidProdOfferId").val($(this).closest('tr')[0].id);
               var offerID = $(this).closest('tr')[0].id;
                var id = $(this).closest('a')[0].id;
                var ruleId=id.replace("0minus0","");
                bootbox.confirm("Are you sure to delete this Settlement ?", function(result) {
   	            	if(result){
   	            		 
   	            		$.ajax({
   	                		type: "POST",
   	                		async:true,
   	                	    url: APP_PATH+'/provider/delSettleAPI.shtml?ruleId='+ruleId+'&servCode='+offerID,
   	                	    dataType:'json',
   	                	   // data:thisForm.serialize(),
   	                	    success:function(msg){
   	                	    	//{"priceId":"100000010","code":"0000","desc":"Success"}
   	                	    	if(msg.code!=null && msg.code=="0000" ){
   	                		    	 //删除
   	                	    		$('#'+id).remove();
   	        	            		$('#'+ruleId).remove();
   	        	            		var strplus = "<a href='javascript:;' class='addSettle' ><i class='fa fa-plus'></i></a>";
   	        	            		$('#'+offerID).closest('tr').children('td').eq(4).html(strplus);
   	                	    	}else{
   	                				toastr.error('Delete Fail.');
   	                	    	}
   	                	    }
   	                	});
   	            	}
   	            	
                });

           });
           
           /**
            * ---------end---------delSettle------------------------------------
            */
            //offer：删除offer
            $(document).on('click','.delOffer',function(){
            	 //debugger;
            	var trId = $(this).closest('tr')[0].id;
            	var $tbody = $(this).closest('tbody');
           	     var currIndex =  $tbody.find("tr").size();
           	 
            	var $this = $(this);
            	bootbox.confirm("Are you sure to cancel the Order "
                		+$(this).closest('tr').children('td').eq(1).html()+"?", function(result) {
                	if(result){
	            		if(""==trId){
	            			$this.closest('tr').remove();
	            			 $tbody.find('tr>td:first-child').each(function(i) {
	                                $(this).html(i + 1);
	                         });
            				return;
            			} else{
				            	$.ajax({
				            		type: "POST",
				            		async:false,
				            	    url:APP_PATH+ "/provider/delOffer.shtml",
				            	    dataType:'json',
				            	    data:{offerId:trId},
				            		success:function(data){ 
				            			if (data.code == "0000") {
				            				 if(currIndex>0){
				                                  currIndex--;
				                                  $("#"+trId).remove();
				                                  $tbody.find('tr>td:first-child').each(function(i) {
				                                      $(this).html(i + 1);
				                                  });
				                             }  
				            				//ManageSystem.init();
				            				toastr.success('Success');
				            				
				            				
				            			}else if(data.code == "0002"){
				            				toastr.error('Code Is Exits');
				            			}
				                      }
				                  });
                	          }
	            	      }
                		})
            });
            //offer

             //   addTabMenu('#modal4');
   	       
  
   	     var productCurrIndex=$("#APIOfferTable>tbody>tr").size();
   	    $('#btn-add-offer').bind('click',function() {
   	    	 //新建一条记录
   	    	var str ="<a href='javascript:;' class='delOffer btn default btn-sm'>Delete</a>";
   	    	

   	    	productCurrIndex++;
   	    	var offerxx = 'offerNum'+productCurrIndex;
   	  		var tr=[];
   	  		tr.push("<td>"+productCurrIndex+"</td>");
   	  	    tr.push("<td offerName=\'"+$("#offerNameNew").val()+"\'>"+$("#offerNameNew").val()+"</td>");//<td><a href="#" class="addCapability">Add </a></td>
   	  		tr.push("<td id='"+offerxx+"'><a href='#' class='addCapability'>Add </a></td>");
   	  		tr.push("<td><a href='javascript:;' class='addPricePlan' ><i class='fa fa-plus'></i></a></td>");
   	  	    tr.push("<td><a href='javascript:;' class='addSettle' ><i class='fa fa-plus'></i></a></td>");
   	  		tr.push("<td>"+str+"</td>");
   	  		var trStr="<tr id=''  class=\"offerTrClass\">"+tr.join("")+"</tr>";
   			$("#offerSysModalTB").append(trStr);
   	 
   	    });
 
   		 };
   		 
   		 //系统详情页面点击API Offer的触发操作
   		 $('#apiOfferAddBtn').click(function() {
             var capabilityTableRowLength=$("#showTopTable>tbody").find("tr").length;
             var firstRowTdValue=$("#showTopTable>tbody").find("tr:first td").html();
           	      if(capabilityTableRowLength<=1&&firstRowTdValue=="No data available in table"){
              		 toastr.error($.i18n.prop('eaap.op2.portal.message.systemDetail.apiOfferCapabilityIsNotNullTip'));
              		return false;
              	 }
         });
   		 
   		
   	   /////////////////////////////////
         //处理offer 添加price plan 内的功能

     var handleDatePickers = function(selector) {
         var options = {
             autoclose: true,
             minViewMode: 'year',
             format: 'mm/dd/yyyy'
         }
         if (jQuery().datepicker) {
             $(selector).datepicker(options);
         }
     }
/**
 * 下拉树Price Object-Product-------------------------------
 */
     var handleJstree = function(selector) {
    	//alert('mss')
    	 var prodOfferId = $("#hidProdOfferId").val();
		 $.ajax({
				async : false,
				type : "POST",
				url :  APP_PATH+"/pardOffer/getPardOffertProdTree.shtml",
				data :{
					prodIds:prodOfferId,
					idvalue:$("#relIds").val()
				},
				success : function(data) {
					if (data.code == "0000") {
					  
						 $(selector).jstree({
				            'plugins': ["checkbox", "types"],
				            'core': {
				                'data': data.desc
				            },
				            "types": {
				                "default": {
				                    "icon": "fa fa-folder icon-warning icon-lg"
				                },
				                "file": {
				                    "icon": "fa fa-file icon-warning icon-lg"
				                }
				            }
				        }); 
						 $(selector).on('changed.jstree', function (e, data) {
							 var prodOfferId = $("#hidProdOfferId").val();
							 prodOfferId = "A"+prodOfferId;
							 var checkTextAry=[];
							 var checkIdAry=[];
							 for(i = 0, j = data.selected.length; i < j; i++) {
								 if(data.instance.get_node(data.selected[i]).id != prodOfferId){
									 checkTextAry.push(data.instance.get_node(data.selected[i]).text);
									 checkIdAry.push(data.instance.get_node(data.selected[i]).id);
								 }
							 }
							 $("#jstreeTextString").val(checkTextAry.join(","));
							 $("#relIds").val(checkIdAry.join(","));
						  });
					} else {
						alert(data.desc);
					}
				},
				dataType : "json",
	            error: function(xhr, textStatus, errorThrown) {
	            	//called when there is an error
	            }
			});
	        /*$(selector).jstree({
	        	 "plugins": ["themes", "json_data", "ui"],
	        	 'core': {
	        		    'data': {
	        		        'url': APP_PATH+"/pardOffer/getPardChanneTree.shtml",
	        		        'data': function(node) {
	        		            return {
	        		                'id': node.id,
	        		                'text': node.text
	        		            };
	        		        }
	        		    },
	        		}
	        });*/
	    }
/**
 * 下拉树Price Object-Product-------------------------------
 */
     //控制offset tyep 选择为offset时 显示输入框
     var handleOffsetType = function(selector) {
    	 
             var $offsetType = $(selector).find('.offsetType');
             $(selector).on('change', '.offsetType', function() {
            	 
                 if ($offsetType.val() == 1) {
                     $('.offset').show();
                 } else if ($offsetType.val() == 0) {
                     $('.offset').hide();
                 }
             })
             if ($offsetType.val() == 1) {
                 $('.offset').show();
             } else if ($offsetType.val() == 0) {
                 $('.offset').hide();
             }
         }
         //控制 EFFECTIVE TIME 当单位选择为fixed expiry date时 input变为日期控件
     var handleEffectiveTime = function(selector) {
             var $unit = $(selector).find('.unit');
             var $effectiveTime1 = $(selector).find('.effectiveTime1');
             var $effectiveTime2 = $(selector).find('.effectiveTime2');

             $(selector).on('change', '.unit', function() {
                 if ($unit.val() == 10) {
                     $effectiveTime1.hide();
                     $effectiveTime2.show();
                 } else {
                     $effectiveTime1.show();
                     $effectiveTime2.hide();
                 }
             })
             if ($unit.val() == 10) {
                 $effectiveTime1.hide();
                 $effectiveTime2.show();
             } else {
                 $effectiveTime1.show();
                 $effectiveTime2.hide();
             }
         }
         //控制 Charge Information中basic tariff面板内的charge表格的联动效果
     var handleChargeTable = function(selector) {
             $(selector).on('change', '.chargingUnit', function() {
                 var unit = $(this).find('option:selected').text();
                 $(selector + ' .unitArea').html(unit);
             })
             $(selector + ' input[name="chargingUnitValue"]').focusout(function() {
                 var chargingValue = $(this).val();
                 $(selector + ' .numArea').html(chargingValue);
             })
             $(selector).on('click', 'input[name="ChargeType"]', function() {
                 var chargeType = $(this).val();
                 if (chargeType == 1) {
                     $(selector + ' .simple').show();
                     $(selector + ' .ladder').hide();
                 } else if (chargeType == 2) {
                     $(selector + ' .simple').hide();
                     $(selector + ' .ladder').show();
                 }
             })
             $(selector).on('change', '.currency', function() {
                 var currency = $(this).find('option:selected').text();
                 $('.currencyArea').html(currency);
             })

             //初始化
             $(selector + ' .unitArea').html($(selector + ' .chargingUnit').find('option:selected').text());
             $(selector + ' .currencyArea').html($(selector + ' .currency').find('option:selected').text());
             $(selector + ' .numArea').html($(selector + ' input[name="chargingUnitValue"]').val() ? $(selector + ' input[name="chargingUnitValue"]').val() : 1);
             var chargeType = $(selector + ' input[name="ChargeType"]:checked').val();

             if (chargeType == 1) {
                 $(selector + ' .simple').show();
                 $(selector + ' .ladder').hide();
             } else if (chargeType == 2) {
                 $(selector + ' .simple').hide();
                 $(selector + ' .ladder').show();
             }
         }
         /*
         data-addtpl 表示是否添加过模板
         data-draw   表示生成了几个表单
         data-unique 表示是否允许多次添加
        */
 var addTabMenu = function(selector) {
	 
    var tpl = '<ul class="nav nav-tabs fix tabs-content-ajax"></ul> <div class="tab-content"></div>';

    $(selector).on('click', 'a[data-action="addTabMenu"]', function() {
            //防止多次添加模板
     
            var addTpl = $(selector + ' .tabsArea').attr('data-addtpl');
            if (addTpl == 'false') {
                $(selector + ' .tabsArea').html(tpl).attr('data-addtpl', 'true');
            }
            var $this = $(this);
            var target = $this.data('target');
            var type = $this.data('type');
            var draw = $this.attr('data-draw'); //数字表示重复添加的次数，如果是undefined表示不允许重复添加同一个
            var title = $this.text();
            var url = $this.data('url');
            var container = $this.data('container');
            var $container = $(selector + ' ' + container);
            //有设置改属性的，表明只能添加一次
            if ($this.attr('data-unique') == 'true' && draw == '1') {
                toastr.error("This property has already been added.");		///这个属性已经添加过了
                return
            }
            //添加一个tabMenu
            $container.find('.nav li').removeClass('active');
            //创建一个a标签,先判断是否允许重复添加 
            if (draw != undefined) {
                target = target + '_' + draw;
                draw = parseInt(draw) + 1;
                $this.attr({
                    'data-draw': draw
                });
            }
            var a = $('<a data-toggle="tab">').attr({
                'data-url': url,
                'href': target
            }).html(title);
            var li = $('<li class="active">').append(a); //创建一个li标签
            li.append('<input type="checkbox" value="' + target + '" name="select">');
            //根据data-url上的值加载html
            a.one('click', function(event) {
                var $this = $(this);
                var requestURL = $(this).data('url');
                if (!requestURL) {
                    return
                }
                var id = $(this).attr('href');
                $(id).load(requestURL, function() {        
                    if (type == 0) {
                        //针对basic tariff           
                        handlePOJstree(id + ' .poShu', "basicTariffForm");
                        handleChargeTable(id);
                        handleChargeTableAdd(id);
                        handleDatePickers(id + ' .date-picker');
                        handleRatingUnitType(id);
                        basicTariff_InitDefValue(id);
                    }else if(type==8){
                        //针对Rating Discount    
                    	handleSelectTimeRangeModal(id);
                    	ratingDiscount_InitDefValue(id);
                        handlePOJstree(id + ' .poShu',"ratingDiscountForm");
                        handleDatePickers(id + ' .date-picker');
                    }
                    //setDefPriceNameValue(id, selector);
                	$('.dropdown-toggle2').dropdownHover();
                    App.ajaxInit();
                })
            });
            $container.find('.nav').append(li);
            //添加一个tab-content
            $container.find('.tab-pane').removeClass('active');
            var div = $('<div class="tab-pane active">').attr('id', target.substring(1)).html('<img src="'+APP_PATH+'/resources/img/input-spinner.gif" alt="">')
            $container.find('.tab-content').append(div);
            a.click();
        })
        //控制选择按钮
    $(selector).on('click', '.btn-select', function() {
            var $this = $(this);
            $this.closest('.portlet').find('.nav-tabs').toggleClass('select');
        })
        //控制删除按钮
    $(selector).on('click', '.btn-delete', function() {
        var $this = $(this);
        var $selected = $this.closest('.portlet').find('.nav-tabs input[type="checkbox"]:checked');
        var selected = $selected.size();
        var total = $this.closest('.portlet').find('.nav-tabs input').size();

        if (total == selected && selected != 0) {
            $this.closest('.portlet').find('.portlet-body').html('<div class="well">您还未填写Charge Information,请点击右上方的添加按钮</div>');
            $this.closest('.dropdown').find('.dropdown-menu li a').each(function() {
                $(this).attr('data-draw', '0');
            })
            $this.closest('.portlet').children('.portlet-body').attr('data-addtpl', 'false');
        } else if (selected != 0) {
            $selected.each(function() {
                var $$this = $(this);
                var target = $$this.val();
                var length = target.length;
                var index = target.charAt(length - 3);
                var $a = $this.closest('.dropdown').find('.dropdown-menu li').eq(index).children('a');
                $a.attr('data-draw', parseInt($a.attr('data-draw')) - 1);
                $(target).remove();
                $$this.closest('li').remove();
            });
            $this.closest('.portlet').find('.nav-tabs li:first a').click();
        }
    })
};
   		/**
          * -----end--------SysOfferModal---------mjf----------------------------------------------
          */
        /////////////////////////////////
    return {
        init: function(_IS_OP) {
            hanldeEditable(); 
            handleSysOfferModal();
            
            $('ol li').removeClass("active");
            // ('.form-group').removeClass('has-error');
           
           
         	if(_IS_OP=='A'){
         		$('#li1').addClass("active");
         		$('#li2').addClass("active");
         	}
         	if(_IS_OP=='B'){
         		$('#li1').addClass("active");
         		$('#li2').addClass("active");
         		$('#li3').addClass("active");
         	}
         	if(_IS_OP=='C'){
         		$('#li1').addClass("active");
         		$('#li2').addClass("active");
         		$('#li3').addClass("active");
         	}
         	if(_IS_OP=='D'){
         		$('#li1').addClass("active");
         		$('#li2').addClass("active");
         		$('#li3').addClass("active");
         		$('#li4').addClass("active");
         	}
         	if(_IS_OP=='E'){
         		$('#li1').addClass("active");
         		$('#li2').addClass("active"); 
         	}
            //general添加弹窗
            $(document).on('click', '.add-general', function() {                
                    $modal = $('#addModal1');
                    $modal.load('../provider/general.shtml', '', function() {
                        $modal.modal('show');
                        App.ajaxInit();
                        handleGeneralModal($modal);
                    });
                });
                //customized添加弹窗
            $(document).on('click', '.add-customized', function() {
            	    $('#editModal').empty();
            	    $modal = $('#editModal');
                    $modal.load('../provider/customizedForm.shtml', '', function() {
                        $modal.modal('show');
                        App.ajaxInit();
                    });
                });
            $('#reqDelete').live('click',function(){
        		var pageTcpCtrFId = $('#hidTcpCtrFId').val();
        		var pageNodeDescId = $(this).attr('delId');
        		$.ajax({
        			type: "POST",
        			async:false,
        		    url: "../provider/deleteDescNode.shtml",
        		    dataType:'json',
        		    data:{
        		    	pageNodeDescId:pageNodeDescId,
        		    	pageTcpCtrFId:pageTcpCtrFId
        		    	},
        			success:function(data){ 
        				if (data.code == "0000") {
        					$('#pageReqTable>tbody').empty();
        					$('#pageReqTable>tbody').append(data.result);
        					toastr.success(datadeleteSuccess);
        				}else if(data.code == "0002"){
        					toastr.error(data.result);
        				}
        	          }
        	      });
        	});
            $('#rspDelete').live('click',function(){
        		var pageTcpCtrFId = $('#hidRspTcpCtrFId').val();
        		var pageNodeDescId = $(this).attr('delId');
        		$.ajax({
        			type: "POST",
        			async:false,
        		    url: "../provider/deleteRspDescNode.shtml",
        		    dataType:'json',
        		    data:{
        		    	pageNodeDescId:pageNodeDescId,
        		    	pageTcpCtrFId:pageTcpCtrFId
        		    	},
        			success:function(data){ 
        				if (data.code == "0000") {
        					$('#pageRspTable>tbody').empty();
        					$('#pageRspTable>tbody').append(data.result);
        					toastr.success(datadeleteSuccess);
        				}else if(data.code == "0002"){
        					toastr.error(data.result);
        				}
        	          }
        	      });
        	});
            $(document).on('click','#addressOK',function(){
            	var techimpAttId = $('#showAttrId').val();
            	var state = 'X';
            	var operator = 'Update';
            	var attrSpecValue  = $('#showAttrSpecValue').val();
            	$.ajax({
            		type: "POST",
            		async:false,
            	    url: "../provider/operatorApility.shtml",
            	    dataType:'json',
            	    data:{
            	    	operator:operator,
            	    	techimpAttId:techimpAttId,
            	    	attrSpecValue:attrSpecValue,
            	    	state:state
            	    	},
            		success:function(data){
            			var url="../provider/showAbility.shtml?componentId="+$('#hidComponentId').val();
            			showTopTable.api().ajax.url(url).load();
                        toastr.success(data.result);
                      }
                  });
            });
            $(document).on('click','#cabDel',function(){
            	var techimpAttId = $(this).attr('delValue');
            	var state = 'X';
            	$.ajax({
            		type: "POST",
            		async:false,
            	    url: "../provider/operatorApility.shtml",
            	    dataType:'json',
            	    data:{
            	    	operator:'Delete',
            	    	techimpAttId:techimpAttId,
            	    	state:state
            	    	},
            		success:function(data){
            			var url="../provider/showAbility.shtml?componentId="+$('#hidComponentId').val();
            			showTopTable.api().ajax.url(url).load();
                        toastr.success(data.result);
                      }
                  });
            });
            $(document).on('click','#editGeneral',function(){
            	var techimpAttId = $(this).attr('editvalue');
            	var attrSpecValue= $(this).attr('specValue');
            	var cnname = $(this).attr('cnname');
            	$('#showAddressName').html(''+cnname+':');
            	$('#showAttrSpecValue').val(attrSpecValue);
            	$('#showAttrId').val(techimpAttId);
            });
            
            $(document).on('click','#formOK',function(){
            	var pageContractVersionId = $('#hidContractVersionId').val();
            	var pageReqTcpCtrFId = $('#hidTcpCtrFId').val();
            	var pageRspTcpCtrFId = $('#hidRspTcpCtrFId').val();
        		$.ajax({
        			type: "POST",
        			async:false,
        		    url: "../provider/formOKSubmit.shtml?pageContractVersionId="+pageContractVersionId+"&pageReqTcpCtrFId="+pageReqTcpCtrFId+"&pageRspTcpCtrFId="+pageRspTcpCtrFId, 
        		    dataType:'json',
        		    data:$('#reqForm').serialize(),
        			success:function(data){ 
        				//清空记录
        				$('#hidContractId').val('');
        				$('#hidDirSerlistId').val('');
        				$('#hidServiceId').val('');
        				$('#hidTechImpAttId').val('');
        				$('#hidTechimplId').val('');
        				$('#hidContractVersionId').val('');
        				$('#hidTcpCtrFId').val('');
        				$('#hidRspTcpCtrFId').val('');
        				var url="../provider/showAbility.shtml?componentId="+$('#hidComponentId').val();
        				showTopTable.api().ajax.url(url).load();
                        
        	          }
        	      });
        	});
                //customized 编辑弹窗 
            $(document).on('click', '.edit', function() {
            	    $('#editModal').empty();
            	    $modal = $('#editModal');
                    $modal.load('../provider/customizedForm.shtml?editvalue='+$(this).attr('editvalue')+'&state='+$(this).attr('state')+'&value='+Math.random(), '', function() {
                        $modal.modal('show');
                    });
                });
                // customized 添加记录弹窗
//            $(document).on('click', '.insert', function() {
//                    $modal = $('#editModal');
//                    $modal.load('../provider/customizedForm.shtml', '', function() {
//                        $modal.modal('show');
//                    });
//                })   ;
            
          //  handleProductModal();
        //	handleOfferModal();
        //	//handleExclusionOfferModal();
//        	handleDatePickers('#tab1 .date-picker');
//        	handleJstree('#tab1 .jstree');
        }
    };
}();
function generalSubmit(){
	var serviceArray = document.getElementsByName("generalServiceId");	
	var valueArray = document.getElementsByName("attrspecValue");	
	var serviceID = "";
	var attrID = "";
	for(var i=0; i<serviceArray.length; i++)
	{ 
  	  if(serviceID == "")
	  {
	     serviceID=serviceArray[i].value;
	  }
       else
       { 
          serviceID=serviceID + "," + serviceArray[i].value;
       }
	}
	
	for(var i=0; i<valueArray.length; i++)
	{ 
  	  if(attrID == "")
	  {
	     attrID=valueArray[i].value;
	  }
       else
       { 
          attrID=attrID + "," + valueArray[i].value;
       }
	}	
	var componentId = $('#hidComponentId').val();
	$.ajax({
		type: "POST",
		async:false,
	    url: "../provider/provAddAbility.shtml",
	    dataType:'json',
	    data:{componentId:componentId,serviceID:serviceID,attrID:attrID},
		success:function(data){ 
			if (data.code == "0000") {
				toastr.success(success);
			}
          }
      });
}

//选择 能力
/**
 * -----begin-------记录选择的capability--------mjf------
 */
var capabilityCheckId = []; 
var capabilityCheckName = []; 

function capabilityCheck(opi,name){
	if(opi.checked){
		capabilityCheckId.push(opi.id);
		capabilityCheckName.push(name);
	}else{
		capabilityCheckId.pop(opi.id);
		capabilityCheckName.pop(name);
	}
    $("#capabilityCheckId").val(capabilityCheckId);
    $("#capabilityCheckName").val(capabilityCheckName);

}
/**
 * -----begin-------记录选择的capability--------mjf------
 */ 