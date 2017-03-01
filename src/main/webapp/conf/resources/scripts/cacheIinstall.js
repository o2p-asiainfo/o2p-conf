var setInstall=function(){
	var setType;
	var funList = null;
	var globalData;
	var thisEditId="";
	//验证不能为空
	var dataValida=function(e){
		$("#cacheObjhtml input").each(function(index, element) {
			if($(this).attr("id")=="cacheName"){
				if($(this).val().length>20 || $(this).val().length==0 ){
					$(this).addClass("requireerror");
					toastr.error(App.i18n('CNF20000020'));
					$("#cacheName").bind("blur",function(e){
						if($("#cacheName").length<=20 && $("#cacheName").length>=1){$(this).removeClass("requireerror")}
						else{
							$(this).addClass("requireerror");
							toastr.error(App.i18n('CNF20000020'));
						}
					});
				}
			
			}
			else if($(this).attr("id")=="expireTime"){
				var RegularExp=/^[0-9]+$/;
				if($(this).val()!="" && !RegularExp.test($(this).val())){
					$(this).addClass("requireerror");
					toastr.error(App.i18n('CNF20000021'));
					$("#expireTime").bind("blur",function(e){
						if($(this).val()=="" || RegularExp.test($(this).val())){$(this).removeClass("requireerror")}
						else{
							$(this).addClass("requireerror");
							toastr.error(App.i18n('CNF20000021'));
						}
					});
					}  
				}
			
			    
  			

			else if($(this).attr("validtde")&&$(this).val()==""){
				$(this).addClass("requireerror");
				$(this).bind("blur",function(e){
						if($(this).val()){$(this).removeClass("requireerror")}
						else{
							$(this).addClass("requireerror");
						}
					});
				}
        });
		}
	var setFunction=function (){
		$("ul.functionOp").empty();
		$("ul.functionOp").append("<li type='conact'>fn:conact</li>");
		$("ul.functionOp").append("<li type='substring'>fn:substring</li>");
		$("ul.functionOp").append("<li type='lower'>fn:lower</li>");
		$("ul.functionOp").append("<li type='upper'>fn:upper</li>");
		$("ul.functionOp").append("<li type='cache'>fn:cache</li>");
		}
	//function实例
	var xqueryFunction=function (str,fun){
		var funStr;
		if(str==""){
			str="value"
			}
		if(fun=="conact"){
			funStr="fn:conact("+str+",value2,...)";
			}
		else if(fun=="substring"){
			funStr="fn:substring("+str+",beginIndex, endIndex)";
			}
		else if(fun=="lower"){
			funStr="fn:lower("+str+")";
			}
		else if(fun=="upper"){
			funStr="fn:upper("+str+")";
			}
		else if(fun=="cache"){
			funStr="fn:cache("+str+")";
			}
		return funStr;
		}


	//涵数方法调用
	$("body").delegate("ul.functionOp li","click",function(){
		var fun=$(this).attr("type");
		$("#variAE2").val(xqueryFunction($("#variAE2").val(),fun));
	})
	//
	$("body").delegate(".input-group-btn[data-target]","click",function(){
			setType=$(this).attr("data-target");
			$(".input-group-btn[data-modal='true']").removeAttr("data-modal");
			$(this).attr("data-modal","true");
			if($(this).attr("data-target")=="variable"){
				
				}
			$("#variableModal").modal("show");
			$("#variAE2").val($(this).prev("input").val());
			});
	//
	$("body").delegate('#pathOk','click',function(){
		$("#variableModal").modal("hide");
		$(".input-group-btn[data-modal='true']").prev("input").val($("#variAE2").val());
		})
	//
	var variablestart,variableend;
	$("body").delegate("textarea[type='data-area']",'mouseup',function(e){
		var thisid=$(this).attr("id");
		variablestart=document.getElementById(thisid).selectionStart;
		variableend=document.getElementById(thisid).selectionEnd;
		})
	$("body").delegate("textarea[type='data-area']",'change',function(e){
		var thisid=$(this).attr("id");
		variablestart=document.getElementById(thisid).selectionStart;
		variableend=document.getElementById(thisid).selectionEnd;
		})
	var loadObj=function(e){
	        var urls=App.urls.cacheObjList;
	        urls+="?ID="+e;
            oTable = $('#cacheObjList').dataTable({
                //"processing": true,
                //serverSide": true,
                "ajax": {
                    "url": urls,
/*                   "data": function(d) {
                        return $('#searchBarForm').serialize();
                    },*/
                    "dataSrc": function(data) {
					    globalData=data;
//                        if (!App.checker(data.health)) {
//                            return []
//                        } else {
							$("#cacheName").val(data.NAME);
							if(data.FORCE_REFRESH=="1"){$("#forceRefresh").val(1);}
							else{$("#forceRefresh").val(2);}
							$("#expireTime").val(data.EXPIRE_TIME);
							$("#expireTimeParth").val(data.EXPIRE_TIME_PATH);
                            return data.cacheObjs;
//                        }
                    },
                    "type": "POST"
                },
				"paging": false,
				"info": false,
                "searching": false,
                //"pagingType": "bootstrap_full_number",
                //"lengthChange": false,
                "ordering": false,
                "autoWidth": false,
                "columns": [{
                    "data": "ID"
                }, {
                    "data": ""
                }, {
                    "data": "KEY_RULE"
                }, {
                    "data": "VALUE_PATH"
                }],
                "columnDefs": [{
                    "targets": 0,
                    render: function(data, type, full, meta) {
                        var html = '<input type="checkbox" id="'+data+'"></input>';
                        return html;
                    }
                },{
					"targets": 1,
                    render: function(data, type, full, meta) {
                        return "cacheStrategy";
                    }	
				},{
					"targets": 2,
                    render: function(data, type, full, meta) {
						var str=data.substring(13);
                        var html = '<input class="form-control  kyerule" style="float:left;" type="text" value="'+str+'" data-type="expression" validtde="true" data-value='+str+'> ';
                        return html;
                    }	
				},{
					"targets": 3,
                    render: function(data, type, full, meta) {
                        var html = '<input class="form-control" style="float:left;" type="text"  value="'+data+'" data-type="expression" validtde="true">';
                        return html;
                    }	
				}],
                "drawCallback": function() {
                    App.initUniform();
                    App.handlePopover();
                }
            });
        
		}
	var handlesetInstall=function(){
		

		$("#ProtocolMChoose").bind("click",function(){
			$("#listLoad").modal("hide");
			if(setType=="variable"){}
			else if(setType=="variableFun"){}
			$("#variableModal").modal("show");
		});
		//增加obj
		$("#addCache").bind("click",function(){
			$(".dataTables_empty").parent("tr").remove();
			var tr='<tr><td width="10%"><input type="checkbox"></td><td>cacheStrategy</td><td><input class="form-control kyerule" style="float:left; " type="text"  placeholder="Key Rule" data-type="expression" validtde="true"></td><td><input class="form-control" style="float:left;" type="text"  placeholder="Value Path" data-type="expression" validtde="true"></td></tr>';
			$("#cacheObjList tbody").append(tr);
			App.initUniform();
		});
		//删除OBJ
		$("#removeCache").bind("click",function(){
			$("#cacheObjList tbody input[type='checkbox']").each(function(index, element) {
				$(this).is(":checked")? $(this).closest("tr").remove():"";
            });
			//$("#cacheObjList .checkall").is(":checked")?
		});
		//批量选择
		$(".checkall").bind("click",function(){
			$(this).is(":checked")? $("#cacheObjList tbody input[type='checkbox']").attr("checked",true):$("#cacheObjList  tbody input[type='checkbox']").attr("checked",false);
			});
		//提交保存
		$('body').on('blur', '.kyerule',function(){
			var val="cacheStrategy"+$(this).val();
			var $this=$(this);
			$(this)
			if($(this).val()==$(this).attr("data-value") && $(this).val()!=""){return}
			$.ajax({
	            url: App.urls.checkCacheKey+"?cacheKey="+val,
	            type: "post",
	            success: function(backdata) {
	                if (backdata == "EXIST") {
						$this.addClass("requireerror");
	                    toastr.error(App.i18n('CNF20000024'));
	                }
					else{
						$this.removeClass("requireerror");
						}
	            },
	        });
			
		});
	
		$("#cacheObjClose").bind("click",function(){
			location.reload();
			})
		$("#cacheObjOk").bind("click",function(){
			dataValida();
			if($(".requireerror").length>0){
				return;
				}
			var cacheObjs=[];
			$("#cacheObjList tbody tr").each(function(index, element) {
			   var obj={};
			   obj.VALUE_PATH=$(this).find("input.form-control:last").val();
			   obj.KEY_RULE="cacheStrategy"+$(this).find("input.form-control:first").val();
			   obj.TENANT_ID="";
			   cacheObjs.push(obj); 
            });
			var urls;
			if(thisEditId==""){
				urls=App.urls.cacheAddStrategy;
				}
			else{
				urls=App.urls.cacheUpdateStrategy;
				}
			var str=JSON.stringify(cacheObjs);
			var eTime;
			if($("#expireTime").val()==""){
				eTime=2592000;
				}
			else{eTime=$("#expireTime").val()}
			$.ajax({
                url: urls,
                data: {
					"NAME":$("#cacheName").val(),
					"CACHE_TYPE":$("#cacheType").val(),
					"FORCE_REFRESH":$("#forceRefresh").val(),
					"EXPIRE_TIME":eTime,
					"EXPIRE_TIME_PATH":$("#expireTimeParth").val(),
					"TENANT_ID":"",
					"ID":thisEditId,
					"cacheObjs":str,
					},
                type: "post",
                success: function(backdata) {
                	
                    if (backdata == 'SUCCESS') {
                    
                        
                        toastr.success(App.i18n('CNF20000016'));
					    window.location.reload();
                    } else if (backdata == 'FAIL') {
                        toastr.success(App.i18n('CNF20000017'));
						
                    }
                },
                error: function(error) {
                    toastr.success(App.i18n('CNF20000017'));
					
                }
            });
			})
		$("#choselist").bind("click",function(e){
			$("#listLoad").modal("show");
			e.stopPropagation();
			})
	};
	return {
        init:function(e) {
            handlesetInstall();
			setFunction();
			if(e!=""){
				thisEditId=e;
				loadObj(e);
				}
        }
		

    }
}()