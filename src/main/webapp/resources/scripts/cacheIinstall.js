var setInstall=function(){
	var setType;
	var funList = null;
	var globalData;
	var thisEditId="";
	//验证不能为空
	var dataValida=function(e){
		$("#addCacheModal input").each(function(index, element) {
			if($(this).attr("validtde")){
				if(!$(this).val()){$(this).addClass("requireerror").attr("placeholder","this is require");result=false}
				$(this).bind("blur",function(e){
					if($(this).val()==""){$(this).attr("placeholder","this is require");}
					else{$(this).removeClass("requireerror")}
				})
				}
        });
		}
	//调用后台的配置涵数
	var setFunction=function(){
		$.ajax({
			type: "POST",
			async:true,
		    url: "../newadapter/getFunctionList.shtml",
		    dataType:'json',
			success:function(msg){
				 if('success' == msg.code){
					 $("ul.functionOp").empty();
					 var functionObj = msg.result;
					 if(functionObj && functionObj.functionList) {
						 funList = functionObj.functionList;
						 $.each(functionObj.functionList, function(){
							 var funItem = this;
							 $("ul.functionOp").append("<li type='"+funItem.name+"'>fn:"+funItem.name+"</li>");
						 })
					 }
				 }else{
					 alert(dataDoerror);
				 }
            }
       });
	}
	//涵数解析
	var xqueryFunction=function(str,fun){
		var funStr = "";
		if(str==""){
			str="value"
			}
		if(funList) {
			$.each(funList, function(){
				var funItem = this;
				if(fun==funItem.name) {
					funStr += "fn:"+fun+"(";
					$.each(funItem.paramDetail, function(){
						var paramItem = this;
						if(funStr.charAt(funStr.length-1) != "(") {
							funStr += ",";
						}
						if(paramItem.isMulti && paramItem.isMulti == true) {
							if(paramItem.dataType == "union") {
								if(paramItem.paramName && paramItem.paramName.length > 0) {
									$.each(paramItem.paramName, function(){
										var paramChildItem = this;
										funStr += paramChildItem.paramName+"1,";
									});
									$.each(paramItem.paramName, function(){
										var paramChildItem = this;
										funStr += paramChildItem.paramName+"2,";
									});
									funStr += "..."
								}
							} else {
								funStr += str +","+paramItem.paramName+"2,...";
							}
						} else {
							if(paramItem.paramName=="str" || paramItem.paramName=="defaultResult") {
								funStr += str;
							} else {
								funStr += paramItem.paramName;
							}
						}
					});
					funStr += ")";
					return;
				}
			});
		}
		return funStr;
	}
	//涵数方法调用
	$("ul.functionOp").delegate("li","click",function(){
		var fun=$(this).attr("type");
		$("#variAE2").val(xqueryFunction($("#variAE2").val(),fun));
	})
	//
	$("body").delegate(".input-group-btn[data-target]","click",function(){
			setType=$(this).attr("data-target");
			$(".input-group-btn[data-modal='true']").removeAttr("data-modal");
			$(this).attr("data-modal","true");
			if($(this).attr("data-target")=="variable"){
				$("#variableModal").modal("show");
				$("#variAE2").val($(this).prev("input").val());
				}
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
		if (!$.fn.DataTable.isDataTable('#cacheObjList')) {
            oTable = $('#cacheObjList').dataTable({
                //"processing": true,
                //serverSide": true,
                "ajax": {
                    "url": App.urls.cacheObjList,
/*                   "data": function(d) {
                        return $('#searchBarForm').serialize();
                    },*/
                    "dataSrc": function(data) {
					    globalData=data;
//                        if (!App.checker(data.health)) {
//                            return []
//                        } else {
							$("#cacheName").val(data.NAME);
							$("#cacheType option[text='"+data.CACHE_TYPE+"']").attr("selected", true);
							$("#forceRefresh option[text='"+data.FORCE_REFRESH+"']").attr("selected",true); 
							
							$("#expireTime").val(data.EXPIRE_TIME);
							$("#expireTimeParth").val(data.EXPIRE_TIME_PATH);
                            return data.cacheObjs;
//                        }
                    },
                    "type": "POST"
                },
                "searching": false,
                //"pagingType": "bootstrap_full_number",
                //"lengthChange": false,
                "ordering": false,
                "autoWidth": false,
                "columns": [{
                    "data": "ID"
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
                        var html = '<input class="form-control" style="float:left; width:250px" type="text" value="'+data+'" data-type="expression" validtde="true"> <span class="input-group-btn left" data-target="variableFun" style="float:left"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button></span>';
                        return html;
                    }	
				},{
					"targets": 2,
                    render: function(data, type, full, meta) {
                        var html = '<input class="form-control" style="float:left; width:250px" type="text"  value="'+data+'" data-type="expression" validtde="true"> <span class="input-group-btn left" data-target="variable" style="float:left"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button></span>';
                        return html;
                    }	
				}],
                "drawCallback": function() {
                    App.initUniform();
                    App.handlePopover();
                }
            });
        } else {
            oTable.api().ajax.reload();
        }
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
			var tr='<tr><td width="10%"><input type="checkbox"></td><td><input class="form-control" style="float:left; width:250px" type="text"  placeholder="XPath" data-type="expression" validtde="true"> <span class="input-group-btn left" data-target="variableFun" style="float:left"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button></span></td><td><input class="form-control" style="float:left; width:250px" type="text"  placeholder="XPath" data-type="expression" validtde="true"> <span class="input-group-btn left" data-target="variable" style="float:left"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button></span></td></tr>';
			$("#cacheObjList tbody").append(tr);
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
		$("#cacheObjOk").bind("click",function(){
			dataValida();
			if($(".requireerror").length>0){
				}
			$("#cacheName").val();
			$("#cacheType").val();
			$("#forceRefresh").val();
			$("#expireTime").val();
			$("#expireTimeParth").val();
			var json={};
			json.NAME=$("#cacheName").val();
			json.CACHE_TYPE=$("#cacheType").val();
			json.FORCE_REFRESH=$("#forceRefresh").val();
			json.EXPIRE_TIME=$("#expireTime").val();
			json.EXPIRE_TIME_PATH=$("#expireTimeParth").val();
			json.TENANT_ID="dddd";
			json.ID=thisEditId;
			json.cacheObjs=[];
			$("#cacheObjList tbody tr").each(function(index, element) {
			   var obj={};
			   obj.VALUE_PATH=$(this).find("input.form-control:last").val();
			   obj.KEY_RULE=$(this).find("input.form-control:first").val();
			   obj.TENANT_ID="";
			   json.cacheObjs.push(obj); 
            });
			var urls;
			if(thisEditId==""){
				urls=App.urls.cacheAddStrategy;
				}
			else{
				urls=App.urls.cacheUpdateStrategy;
				}
			var str=JSON.stringify(json);
			alert(str);
			$.ajax({
                url: urls,
                data: {
                	"NAME":"fjs"
                },
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
			})
		$("#choselist").bind("click",function(e){
			$("#listLoad").modal("show");
			e.stopPropagation();
			})
	};
	return {
        init:function(e) {
            handlesetInstall();
			if(e!=""){
				thisEditId=e;
				loadObj(e);
				}
        }
		

    }
}()