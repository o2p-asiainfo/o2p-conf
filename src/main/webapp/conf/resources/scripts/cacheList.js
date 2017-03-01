var cacheList = function() {
    var oTable,
        $searchBtn, // button()副本   
        form;
    var handleSelect2 = function() {
        $(".select2").select2({
            placeholder: App.i18n('CNF00000027'),
        })
    };
	//增加缓存
	var cacheAdd = function() {
		$("#cacheListhtml").hide();
		$("#cacheObjhtml").show();
		$("#cacheName").val("");
		$("#expireTime").val("");
		
		setInstall.init("");
		};
	//删除缓存
	var cacheDel = function() {
		if($("#dt tbody tr").find(":checked").length<1){
			toastr.error(App.i18n('CNF20000018'));
			return;
			}
		var keyarray=[];
		var id=$("#dt tbody tr").find(":checked").attr("id");
		$.ajax({
            url: App.urls.cacheDelById+"?ID="+id,
            type: "post",
            success: function(backdata) {
                if (backdata == "SUCCESS") {
                    oTable.api().ajax.reload();
                    toastr.success(App.i18n('CNF20000016'));
                } else if (backdata == "FAIL") {
                   toastr.error(App.i18n('CNF20000017'));
                }
            },
            error: function(error) {
                toastr.error(App.i18n('CNF20000017'));
            }
        });
		};
	//修改缓存
	var cacheEdit = function() {
		if($("#dt tbody tr").find(":checked").length<1){
			toastr.error(App.i18n('CNF20000018'));
			}
		else{
			var id=$("#dt tbody tr").find(":checked").attr("id");
			$("#cacheListhtml").hide();
			$("#cacheObjhtml").show();
			setInstall.init(id); 
			}
		};
    //校验搜索栏的表单
	
    var validForm = function() {
        form = $('#searchBarForm');
        /*
         *自定义校验规则
         *parma: method name,function,messages
         *调用方法 放在rules里面，类似required:true( domain:'#username'),#username为对象ID
         */
        //可以不填，但是填了必须2个都填
        jQuery.validator.addMethod("dateRange", function(value, element, params) {
            var startTime = $('#startTime').val(),
                endTime = $('#endTime').val();
            if (startTime == '' && endTime != '' || startTime != '' && endTime == "") {
                return false
            } else {
                return true
            }
        }, App.i18n('CNF00000025'));
        jQuery.validator.addMethod("invalidString", function(value, element) {
            return value == '' || !/[`~!@#\$%\^\&\*\(\)_\+<>\?:"\{\},\.\\\/;'\[\]]/im.test(value);
        }, App.i18n('CNF00000026'));
        form.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            rules: {
                offerName: {
                    invalidString: 'offerName'
                },
                startTime: {
                    dateRange: '#startTime'
                },
                endTime: {
                    dateRange: '#endTime'
                },
            },
            messages: {},
            invalidHandler: function(event, validator) { //display error alert on form submit   
                // $('.alert-danger', $('.login-form')).show();
            },
            highlight: function(element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
            },
            success: function(label) {
                label.closest('.form-group').removeClass('has-error');
                label.remove();
            },
            // http://jqueryvalidation.org/validate/#groups
            groups: {
                dateRange: "startTime endTime"
            },
            errorPlacement: function(error, element) {
                if (element.attr("name") == "startTime" || element.attr("name") == "endTime") {
                    error.appendTo("#error-container");
                } else {
                    error.appendTo(element.closest('.form-group'));
                }
            },
            submitHandler: function(form) {
                // form.submit(); // form validation success, call ajax form submit
            },
        });
    };
	var queryCondition=function(event){
		$searchBtn = $(this).button('loading');
		oTable.fnClearTable();
    	oTable=$("#dt").dataTable({
    		"bDestroy":true,
    		"processing": true,
            "serverSide": true,
            "searching": false,
            "pagingType": "bootstrap_full_number",
            "lengthChange": false,
            "ordering": false,
            "autoWidth": false,
            "ajax": {
                "url": App.urls.cacheList+"?NAME="+$("#CacheStrategyName").val(),
                   "dataSrc": function(data) {
//                        if (!App.checker(data.health)) {
//                            return []
//                        } else {
                            return data.data;
//                        }
                    },
                 "type": "GET"
             },
             "columns": [{
                 "data": "ID"
             },{
                 "data": "NAME"
             }, {
                 "data": "CACHE_TYPE"
             }, {
                 "data": "FORCE_REFRESH"
             }, {
                 "data": "EXPIRE_TIME"
             }],
             "columnDefs": [{
                 "targets": 0,
                 render: function(data, type, full, meta) {
                     var html = '<input name="dd" type="radio" id="'+data+'"></input>';
                     return html;
                     }
                 },{
                     "targets": 2,
                     render: function(data, type, full, meta) {
                         return "REMOTE";
                     }
                     
                 },{
                         "targets": 3,
                         render: function(data, type, full, meta) {
                         	if(data=="1"){data="Y";}
                         	else if(data=="2"){data="N";}

                             return data;
                     }
              }],
             "drawCallback": function() {
                 App.initUniform();
                 App.handlePopover();
             }
    	})
    	
    };
    var queryOffer = function(event) {
        //校验通过，根据seach按钮上的init属性判定是否初始化过datatable
			$searchBtn = $(this).button('loading');
            oTable = $('#dt').dataTable({
				"bDestroy":true,
                "processing": true,
                "serverSide": true,
                "ajax": {
                   "url": App.urls.cacheList+"?NAME="+$("#CacheStrategyName").val(),
               
                   "dataSrc": function(data) {
//                        if (!App.checker(data.health)) {
//                            return []
//                        } else {
                            return data.data;
//                        }
                    },
                    "type": "GET"
                },
                "searching": false,
                "pagingType": "bootstrap_full_number",
                "lengthChange": false,
                "ordering": false,
                "autoWidth": false,
                "columns": [{
                    "data": "ID"
                },{
                    "data": "NAME"
                }, {
                    "data": "CACHE_TYPE"
                }, {
                    "data": "FORCE_REFRESH"
                }, {
                    "data": "EXPIRE_TIME"
                }],
                "columnDefs": [{
                    "targets": 0,
                    render: function(data, type, full, meta) {
                        var html = '<input name="dd" type="radio" id="'+data+'"></input>';
                        return html;
                    }
				},{
                        "targets": 2,
                        render: function(data, type, full, meta) {
                            return "REMOTE";
                        }
                        
                    },{
                            "targets": 3,
                            render: function(data, type, full, meta) {
                            	if(data=="1"){data="Y";}
                            	else if(data=="2"){data="N";}

                                return data;
                        }
                }],
                "drawCallback": function() {
                    App.initUniform();
                    App.handlePopover();
                }
            });
     
    };
    /**
     * 绑定在checkbox上,记录checkbox的值
     * 以name:[value1,value2]形式保存在body上，name为checkbox的name
     * 一组table里面的所有checkbox的name必须一致，包括全选按钮的name
     * @return {[type]} [description]
     */
    return {
        init: function() {
            queryOffer();
		    $("#topcontrol").remove();
            $('body').on('click', '#search', queryCondition);
            
			$("#btn-add").bind("click",function(){
				cacheAdd();
				})
			$("#btn-edit").bind("click",function(){
				cacheEdit();
				})
			$("#btn-del").bind("click",function(){
				cacheDel();
				})
			$("#cacheOk").bind("click",function(){
				if($("#dt tbody tr").find(":checked").length<1){
					toastr.error(App.i18n('CNF20000018'));
					return;
				}
				else{
					var url = location.search; //获取url中"?"符后的字串 
					var theRequest = new Object(); 
					if (url.indexOf("?") != -1) { 
						var str = url.substr(1); 
						strs = str.split("&"); 
						for(var i = 0; i < strs.length; i ++) { 
							theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
						}
						var newState=theRequest['newState'];
						if(newState=="new"){
							var objId=theRequest['objectId'];
							var espaId=theRequest['endpoint_Spec_Attr_Id'];
					    	var asCode=theRequest['attrSpecCode'];
							var id=$("#dt tbody tr").find(":checked").attr("id");
							window.parent.editorPropertyValue(objId,espaId,asCode,id);
							$(window.parent.document).find('#closeButtonCacheStrategy').click();
							}
						else{
							var attrName=theRequest['attrName'];
							var id=$("#dt tbody tr").find(":checked").attr("id");
							var objId=theRequest['objectId'];
							var espaId=theRequest['endpoint_Spec_Attr_Id'];
							var newState=theRequest['newState'];
							window.parent.editDynamicAttrFromSpecPage(attrName,id,objId,espaId);
							$(window.parent.document).find('.aui_state_focus').remove();
							}
						
						
						//art.dialog.close();
					}

				}
			$(window.parent.document).find('#closeButton').click();
			});

			$("#cacheClose").bind("click",function(){
				//$(window.parent.document).find('.aui_state_focus').remove();
				//art.dialog.close();
                //$(window.parent.document).find('#closeButtonCacheStrategy').click();
                $(window.parent.document).find('#closeButton').click();
			});
			$('#dt').on('xhr.dt', function(e, settings, processing) {
                $searchBtn.button('reset');
            });

        }
    }
}()
