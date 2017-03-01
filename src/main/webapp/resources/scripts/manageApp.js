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
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#appName").val(value);
                }
            }
        })
        //alert(typeList.lenght);
        var typeList = $("#applistString").val();
        
         
        $('a[data-name="appType"]').editable({
            url: '', // url to server-side script to process submitted value (/post, post.php etc)
            prepend: "Select Type",
            type: 'select',
            pk: 1,
            name: 'appType',
            title: 'Select Type',
            source: typeList,
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#appType").val(value);
                }
            }
        })
        $('a[data-name="address"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'address',
            title: 'Enter a new address',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#appUrl").val(value);
                }
            }
        })
        $('a[data-name="callback"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'text',
            pk: 1,
            name: 'callback',
            title: 'Enter a new callback address',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#appCallbackUrl").val(value);
                }
            }
        })
        
         $('a[data-name="details"]').editable({
            url: '', //url to server-side script to process submitted value (/post, post.php etc)    
            type: 'textarea',
            pk: 1,
            name: 'name',
            title: 'Enter a new callback address',
            inputclass: 'form-control input-medium',
            validate: function(value) {
                if ($.trim(value) == '') {
                    return 'This field is required';
                }else{
                	$("#appDesc").val(value);
                }
            }
        })
    }

    var closeEidtable = function() {
        $('.editable').editable('toggleDisabled');
    }
    
    //----begin------提交---更新-----------------------------
    
    $('#btn_app_update_a').bind('click', function() {
 
        bootbox.confirm($.i18n.prop('eaap.op2.portal.mgr.message.confirmSaveMsg'), function(result) {
             
            if(result){ 
            	 // 确定绑定OFFER ID--------- bindOfferIds
            	var bindID  = []; 
            	var apiInfoListNum=0;
            	 
            	$('#appOfferTB tr').each(function(j,objPTr) {
            		bindID.push(objPTr.id);
            		apiInfoListNum++;
    		  	})
    		  	$("#bindOfferIds").val(bindID);
            	$("#apiInfoListNum").val(apiInfoListNum);
            	 var str = $('#form1').serialize();
            	 
                 if(result){
                     $.ajax({
                         url: _APP_PATH+"/mgr/manageDevMgrUpdate.shtml",
                         data: str,
                         type: "post",
                         dataType:"json",
                         success: function(backdata) {
                             if (backdata.code == '0000') { 
                            	 //location.reload();
                                 toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.saveSuccess'));
                                 
                             } else if (backdata == 0) {
                                 toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                             }else if(backdata.code == '0001'){
                            	 toastr.error(backdata.desc);
                             }
                         },
                         error: function(error) {
                             toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                         }
                     });
                 }
            	 
            }
        });
    });
    
    
    //----end--------提交---更新-----------------------------

    
    //----begin-------取消-------------------------------
    $('#btn_app_cancel').bind('click', function() {
    	form2.action=APP_PATH+"/mgr/developerCenter.shtml" ;
    	form2.submit();
    });
  //----end-------取消-------------------------------
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
    }
 
    var handleBtnOnline = function() {
    	//<a href="javascript:toAppOnline(${appBean.APP_ID},${appBean.APPAPINUM });">
        $('#online').bind('click', function() {
            bootbox.confirm($.i18n.prop('eaap.op2.portal.mgr.message.confirmOnlineMsg'), function(result) {
            	if(result){ 
            		var appapinum =$('#apiInfoListNum').val();
            		 if(appapinum<1)
                     { 
            			 toastr.error($.i18n.prop('eaap.op2.portal.devmgr.verify.pleasedoApi'));
            			 return;
                     }else{   
	                     $("#appstate").val('B') ;
	                     $("#donameid").val('submitonline') ; 
	                     var str = $('#form1').serialize(); 
	                     $.ajax({
	                         url: _APP_PATH+"/mgr/updateAppStateByAppId.shtml",
	                         data: str,
	                         type: "post",
	                         dataType : "json",
	                         success: function(backdata) {
	                        	// debugger;
	                         	//alert(backdata.code);
	                             if (backdata.code == "0000") { 
	                                 location.reload();
	                                 toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
	                             } else  {
	                                 toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
	                             }
	                         },
	                         error: function(error) {
	                             toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
	                         }
	                     });
                     }
            	}
             
            });
        });
    }

    var handleBtnUpgrade = function() {
        $('#upgrade').bind('click', function() {
            bootbox.confirm("Are you sure to upgrade it?", function(result) {
            	if(result){
                    $("#appstate").val('E') ;
                    var str = $('#form1').serialize(); 
                    $.ajax({
                        url: _APP_PATH+"/mgr/updateAppStateByAppId.shtml",
                        data: str,
                        type: "post",
                        dataType : "json",
                        success: function(backdata) {
                       	// debugger;
                        	//alert(backdata.code);
                            if (backdata.code == "0000") {  
                            	location.reload();
                                toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
                                
                            } else  {
                                toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                            }
                        },
                        error: function(error) {
                            toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                        }
                    });
                
            	}
            });
        });
    }
//    function  toDoAppInfo(appid,state)
//    {
//    if(confirm("<s:property value="%{getText('eaap.op2.portal.devmgr.verify.suerToDeleteApp')}" />"))
//    {
//    $("#appappid").val(appid) ;
//    $("#appstate").val(state) ;
//    updateAppState.action="${contextPath}/devMgr/updateAppStateByAppId.shtml" ;
//    updateAppState.submit();
//    }
//    }
    var handleBtnDelete = function() {
        $('#delete').bind('click', function() {
            bootbox.confirm($.i18n.prop('eaap.op2.portal.mgr.message.confirmDelMsg'), function(result) {
            	if(result){
                    $("#appstate").val('X') ;
                    var str = $('#form1').serialize(); 
                    $.ajax({
                        url: _APP_PATH+"/mgr/updateAppStateByAppId.shtml",
                        data: str,
                        type: "post",
                        dataType : "json",
                        success: function(backdata) {
                       	// debugger;
                        	//alert(backdata.code);
                            if (backdata.code == "0000") {  
                            	location.href = _APP_PATH+"/mgr/developerCenter.shtml";
                                toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
                                
                            } else  {
                                toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                            }
                        },
                        error: function(error) {
                            toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                        }
                    });
                
            	}
            });
        });
    }

    var handleBtnOffline = function() {
        $('#offline').bind('click', function() {
            bootbox.confirm($.i18n.prop('eaap.op2.portal.mgr.message.confirmOfflineMsg'), function(result) {
            	if(result){
                    $("#appstate").val('G') ;
                    var str = $('#form1').serialize(); 
                    $.ajax({
                        url: _APP_PATH+"/mgr/updateAppStateByAppId.shtml",
                        data: str,
                        type: "post",
                        dataType : "json",
                        success: function(backdata) {
                       	// debugger;
                        	//alert(backdata.code);
                            if (backdata.code == "0000") { 
                                location.reload();
                                toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
                            } else  {
                                toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                            }
                        },
                        error: function(error) {
                            toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
                        }
                    });
                
            	}
            });
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
	            
	            //jQuery('#appOfferDt_wrapper .dataTables_length select').closest(".row").remove(); // modify table per page dropdown
	            jQuery('#appOfferDt_wrapper .dataTables_length').closest('.row').find('.col-md-6').remove();
	        });
	        
	      //选择确认后，复制选择项到对应位置（modal上th的顺序，需要和目标位置上的TH对应，否则会错乱）
	        $('#btn-offer-Ok').bind('click', function() {
	        	  productCurrIndex=$("#appOfferTB").children("tr").length;
	        	  
	        	  if(productCurrIndex==1){
	        		  $('#appOfferTB tr').each(function(j,objPTr) {
        	  				if(objPTr.id=="none"){
        	  					productCurrIndex=0;
        	  				}
          		  	})
	        	  }
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
		  		tr.push("<td>"+""+"</td>");
		  		tr.push("<td>"+$(objTr).children('td').eq(4).html()+"</td>");
		  		tr.push('<td><a href="#" class="btn default btn-sm black btn-del"> <i class="fa fa-trash-o"></i> Delete </a></td>');
		  		var trStr="<tr id='"+pId+"'>"+tr.join("")+"</tr>";
	    		$("#appOfferTB").append(trStr);
	        }
	        $('#appOfferTB').on('click', 'td .btn-del', function(e) {
	            e.preventDefault();
	            productCurrIndex=$("#appOfferTB").children("tr").length;
	            if (productCurrIndex >0) {
	            	productCurrIndex--;
	                $tbody = $(this).closest('tbody'); 
	                /**
	                 * 暂时屏蔽删除页面的，应为删除不是实时的，是改变有效时间。删除后只是时间改变
	                 */
//	                $(this).closest('tr').remove(); 
	                //获取offerId
//	                $tbody.find('tr>td:first-child').each(function(i) { 
//	                    $(this).html(i + 1);
//	                })
	                //删除
	                var trId = $(this).closest('tr')[0].id;
	                bootbox.confirm($.i18n.prop('eaap.op2.portal.mgr.message.confirmCancelOrderMsg') 
	                		+$(this).closest('tr').children('td').eq(1).html()+"?", function(result) {
	                		//	debugger;
	                			//console.log($(e).closest('tr').text());
		            	if(result){
		            		$('#delOfferId').val(trId);
		            		var str = $('#form1').serialize(); 
		            		$.ajax({
		                        url: _APP_PATH+"/mgr/delOfferofApp.shtml",
		                        data: str,
		                        type: "post",
		                        dataType : "json",
		                        success: function(backdata) {
		                       	  
		                            if (backdata.code == "0000") { 
		                            	location.reload();
		                                toastr.success($.i18n.prop('eaap.op2.portal.mgr.message.success'));
		                                 
		                            } else  {
		                                toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
		                            }
		                        },
		                        error: function(error) {
		                            toastr.error($.i18n.prop('eaap.op2.portal.mgr.message.failure'));
		                        }
		                    });
 
		            	}
	                })
	            }
	            if (productCurrIndex ==0) {
	            	$("#appOfferTB").append('<tr id="none"> <td colspan="6">None</td> </tr>');
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
    return {
        init: function() {
        	
            handleEditable();
            handleBindCapability();
            handleBtnOffline();
            handleBtnDelete();
            handleBtnUpgrade();
            handleBtnOnline();
            handleAppAPIModal();
            handleAppOfferModal();
            //若为上线和销毁状态不可修改,不可修改提交
//            jQuery(this).siblings("a").removeClass("ada");
//    		jQuery(this).addClass("ada");
           // debugger;
            $('ol li').removeClass("active");
           // ('.form-group').removeClass('has-error');
            if(_IS_OP=='D'||_IS_OP=='B'||_IS_OP=='H'){
            	closeEidtable();
            	$('#btn_app_update_a').hide();
            	$('#plus').hide();
            }
        	if(_IS_OP=='A'){
        		$('#li1').addClass("active");
        		$('#li2').addClass("active");
        		//$("#online").disable();
//        		<button class="btn theme-btn btn-block" id="delete">Delete APP</button>
//        	      <button class="btn default btn-block disabled" id="offline">Take APP Offline</button>
        		$("#online").removeClass("default disabled");
        		$("#online").addClass("theme-btn");
        	}
        	if(_IS_OP=='B'){
        		$('#li1').addClass("active");
        		$('#li2').addClass("active");
        		$('#li3').addClass("active");
        		//$("#online").disable();
        		/*
        		$("#online").removeClass("theme-btn");
        		$("#online").addClass("default disabled");*/
        	}
        	if(_IS_OP=='C'){
        		$('#li1').addClass("active");
        		$('#li2').addClass("active");
        		$('#li3').addClass("active");
        		$("#online").removeClass("default disabled");
        		$("#online").addClass("theme-btn");
        	}
        	if(_IS_OP=='D'){
        		$('#li1').addClass("active");
        		$('#li2').addClass("active");
        		$('#li3').addClass("active");
        		$('#li4').addClass("active");
        		//$("#online").disable();
        		$("#upgrade").removeClass("default disabled");
        		$("#upgrade").addClass("theme-btn");
        		$("#offline").removeClass("default disabled");
        		$("#offline").addClass("theme-btn");
        	}
        	if(_IS_OP=='E'||_IS_OP=='G'||_IS_OP=='F'){
        		$('#li1').addClass("active");
         		$('#li2').addClass("active");
        		//$("#online").disable();
         		/*
        		$("#offline").removeClass("default disabled");
        		$("#offline").addClass("theme-btn");*/
         		$("#online").removeClass("default disabled");
        		$("#online").addClass("theme-btn");
        	}
            
        }
    }
}()

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
/**-----begin ------清除选择的API-----------
 */

function clearApiCheck(){
	$("#CheckApi").val("");
    $("#CheckName").val("");
    $("#checkApiNames").val("");
    $("#checkApiIds").val("");
	
}
/**
 * -----end -------清除选择的API-----------
 */

//----begin-------刷新页面-------------------------------
function flash(id){
	form2.action=_APP_PATH+"/mgr/manageDevMgr.shtml?appId="+id;
	form2.submit();
}



