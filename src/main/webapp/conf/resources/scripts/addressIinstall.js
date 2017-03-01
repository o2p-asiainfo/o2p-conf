var setInstall=function(){
	var setType;
	var funList = null;
	var globalData;
	var thisEditId="";
	//验证不能为空
	var dataValida=function(e){
		$("#techRoutehtml input").each(function(index, element) {
			if($(this).attr("validtde") && $(this).val()==""){
				$(this).addClass("requireerror");
				$(this).bind("blur",function(e){
						if($(this).val()!=""){$(this).removeClass("requireerror")}
						else{
							$(this).addClass("requireerror");
						}
					});
				}
        });
		};

	//
	var loadObj=function(e){
			var techImplId = $("#techImplId").val();
			
            oTable = $('#techNodeList').dataTable({
                //"processing": true,
                //serverSide": true,
                "ajax": {
                    "url":  "/conf/techimpl/editTechRoute.shtml?techImplId="+techImplId,
/*                   "data": function(d) {
                        return $('#searchBarForm').serialize();
                    },*/
                    "dataSrc": function(data) {
                     return data;
                       
                    },
                    "type": "POST"
                },
                "emptyTable":false,
				"paging": false,
				"info": false,
                "searching": false,
                //"pagingType": "bootstrap_full_number",
                //"lengthChange": false,
                "ordering": false,
                "autoWidth": false,
                "columns": [{
                    "data": "TECH_IMPL_NODE_ID"
                },
                {
                    "data": "NODE_HOST"
                }, 
                {
                    "data": "NODE_IP"
                },
                {
                    "data": "NODE_PORT"
                }, 
                {
                    "data": "TECH_ROUTE_EXPR"
                }],
                "columnDefs": [
                {
                    "targets": 0,
                    render: function(data, type, full, meta) {
                        var html = '<input type="checkbox" id="'+data+'"></input>';
                        return html;
                    }
                },
                {
					"targets": 1,
                    render: function(data, type, full, meta) {
                        
                    	var html = '<input class="form-control" type="text" value="'+data+'"  validtde="true"> ';
                        return html;
                    }	
				}
                ,{
					"targets": 2,
                    render: function(data, type, full, meta) {
                        var html = '<input class="form-control" type="text" value="'+data+'"  validtde="true"> ';
                        return html;
                    }	
				}
                ,
                {
					"targets": 3,
                    render: function(data, type, full, meta) {
                        var html = '<input class="form-control" type="text" value="'+data+'"  validtde="true"> ';
                        return html;
                    }	
				},
				{
					"targets":4,
                    render: function(data, type, full, meta) {
                        var html = '<input class="form-control" type="text"  value="'+data+'"  validtde="true">';
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
	
		//增加obj
		$("#addRoute").on("click",function(){
			
			$(".dataTables_empty").parent("tr").remove();
			var tr='<tr><td width="10%"><input type="checkbox"></td><td><input class="form-control" type="text"  placeholder="HOST" validtde="true"></td><td><input class="form-control" type="text"  placeholder="IP" validtde="true"></td><td><input class="form-control" type="text"  placeholder="PORT" validtde="true"></td><td><input class="form-control" type="text"  placeholder="TECH_ROUTE_EXPR" validtde="true"></td></tr>';
			
			$("#techNodeList tbody").append(tr);
			App.initUniform();
			
		});
		//删除OBJ
		$("#removeRoute").bind("click",function(){
			$("#techNodeList tbody input[type='checkbox']").each(function(index, element) {
				$(this).is(":checked")? $(this).closest("tr").remove():"";
            });
			//$("#techNodeList .checkall").is(":checked")?
		});
		$("#routeObjClose").bind("click",function(){
			
			$(window.parent.document).find('.aui_state_focus').removeClass("aui_state_focus").attr("style","display: none; position: absolute;");
			
			});
		$("#routeObjOk").bind("click",function(){
			dataValida();
			
			if($(".requireerror").length>0){
				return;
			}
				
			var routeObjs=[];
			$("#techNodeList tbody tr").each(function(index, element) {

			   var obj={};
			   obj.TECH_ROUTE_EXPR=$(this).find("input.form-control:last").val();
			   obj.NODE_HOST=$(this).find("input.form-control:first").val();
			   obj.NODE_IP=$(this).find("input.form-control").eq(1).val();
			   obj.NODE_PORT=$(this).find("input.form-control").eq(2).val();
			   routeObjs.push(obj); 
			   
            });
			
			
			
			var str=JSON.stringify(routeObjs);
			
			var techImplId = $("#techImplId").val();
			
			$.ajax({
                url: "/conf/techimpl/addTechImplRoute.shtml",
                data: {
					"techImplId":techImplId,
					"routeObjs":str,
					},
                type: "post",
                success: function(backdata) {
                    
                    if (backdata == 200) {
						
                        toastr.success(App.i18n('CNF20000016'));
                        
                        //$(window.parent.document).find('#closeButtonCacheStrategy').click();
						$(window.parent.document).find('.aui_state_focus').removeClass("aui_state_focus").attr("style","display: none; position: absolute;");
                    } else if (backdata == 500) {
                    	window.toastr.error(App.i18n('CNF20000017'));
						
                    }
                },
                error: function(error) {
                    toastr.error(App.i18n('CNF20000017')); 
					
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
            loadObj();
        }
		

    }
}()