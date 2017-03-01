<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
		
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<base href="<%=basePath%>">
		<title>Service Manager</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="Jquery EasyUI Test">
		<script type="text/javascript" src="resource/comm/js/jquery.js"></script>
		<script type="text/javascript" src="resource/comm/js/jquery.easyui.min.js"></script>
		
	
   <script type="text/javascript" src="resource/comm/js/jqueryui/jquery.autocomplete.js"></script>
   <link rel="stylesheet" type="text/css"  href="resource/blue/css/easyui/default/jquery.autocomplete.css" />
		<link rel="stylesheet" type="text/css"
			href="resource/blue/css/easyui/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="resource/blue/css/easyui/icon.css">
	</head>
	<script type="text/javascript">

		
		$(function(){
				
			$('#table').datagrid({
				title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serverManager')}" />",
				iconCls:'icon-save',
				width:1350,
				height:580,
				collapsible:true,
				url:'serviceManager/showGrid.shtml',
				striped:true,
				sortName: 'code',
				fit:false,
				sortOrder: 'desc',
				resizable:true,
				remoteSort: false,
				singleSelect: true, 
				frozenColumns:[[
	                {field:'ck',checkbox:true,width:100}
	                 
				]], 
				columns:[
			    [   {title:"",field:'serviceId',hidden:true},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />",field:'contractVersionId',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />",field:'serviceVersion',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCnName')}" />",field:'serviceCnName',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />",field:'serviceEnName',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />",field:'state',width:100,
					formatter:function(value,row,index){
					if(value=='N'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisable')}" />"
					   }
					  if(value=='A'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnable')}" />"
					   }    
					}},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />",field:'serviceCode',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceMsgFlow')}" />",field:'defaultMsgFlow',width:158}
				]],
				pageList : [15,20],         
				pageSize : 10,
				pagination:true,
				rownumbers:true,
				toolbar:[
				{
					id:'add',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAdd')}" />",
					iconCls:'icon-add',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						addServiceManager();
					}
				},{
					id:'update',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" />",
					iconCls:'icon-edit',
					handler:function(){					
					        var rows=$('#table').datagrid('getSelections');
					        if(rows.length==0)
						{
							$.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");  
						}else
						{
					        $('#serviceIdUpdate').val(rows[0].serviceId);
					    	$('#contractVersionUpdate').val(rows[0].contractVersionId);
						    $('#serviceVersionUpdate').val(rows[0].serviceVersion);
						    $('#serviceNameUpdate').val(rows[0].serviceCnName);
						    $('#serviceEnNameUpdate').val(rows[0].serviceEnName);
						    $('#serviceStatusUpdate').val(rows[0].state);
						    $('#serviceCodeUpdate').val(rows[0].serviceCode);
						    $('#MsgFlowUpdate').val(rows[0].defaultMsgFlow);
						$('#btnsave').linkbutton('enable');
						updateServiceManager();
					    }	
					}
				},'-',{
					id:'delete',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDelete')}" />",
					disabled:false,
					iconCls:'icon-remove',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						var rows=$('#table').datagrid('getSelections');
						var deleteVar="";
						if(rows.length==0)
						{
							$.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertDelete')}" />");  
						}else
						{
							for(var i=0;i<rows.length;i++)
							{
								if(i==(rows.length-1))
								{
									deleteVar+=rows[i].serviceId;
								}else
								{
									deleteVar+=rows[i].serviceId+",";
								}
							}
							$.post("serviceManager/deleteServiceManager.shtml",{deleteIDs:deleteVar},function(result){							
									$('#table').datagrid('reload');
							});
						}
					}
				},{
					id:'search',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceSearch')}" />",
					iconCls:'icon-search',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						searchServiceManager();
					}
				},				
				{
					id:'reload',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceRefresh')}" />",
					iconCls:'icon-reload',
					handler:function(){
						$('#table').datagrid('reload');
					}
				}			
				]
			});
			
			var p = $('#table').datagrid('getPager');
			   
  			$(p).pagination({
				pageSize: 5,
        		beforePageText: "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceBeforePageText')}" />",
        		afterPageText: "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAfterPageText')}" />",  
        		displayMsg: "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisplay')}" />"
    		});  
    		
    		
    		function addServiceManager(){
    		  	$('#dialog').show();
                $('#dialog').dialog({
                	title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceWindowAdd')}" />",
                	collapsible: true, 
					minimizable: false, 
					maximizable: true,
					width: 500, 
					height: 300,
					modal:true,
					buttons:[{
						text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceSubmit')}" />",
						iconCls:'icon-ok',
						handler:function(){
							$('#addServiceManager').submit();
						}
					},{
						text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" />",
						iconCls:'icon-cancel',
						handler:function(){
							$('#dialog').dialog('close');
							$('#addServiceManager').form('clear');
						}
					}]
				});   
              } 
              
              
              $('#addServiceManager').form({  
    					url:"serviceManager/addServiceManager.shtml",  
    					onSubmit: function(){
    						  var isValid = $(this).form('validate');
							  return isValid;
    					},  
    					success:function(data){ 
    					      if(data=="ok"){ 
    						  $('#dialog').dialog('close');
    						  $('#addServiceManager').form('clear');
        					  $('#table').datagrid('load');
        					  }else{
        					  $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertAdd')}" />"); 
        					  $('#dialog').dialog('close');
    						  $('#addServiceManager').form('clear');
        					  $('#table').datagrid('load');
        					  }
   				 		}  
			 });  
			 
			function updateServiceManager(){
		    $('#dialog1').show();
		      $('#dialog1').dialog({
                	title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceWindowUpdate')}" />",
                	collapsible: true, 
					minimizable: false, 
					maximizable: true,
					width: 500, 
					height: 300,
					modal:true,
					buttons:[{
						text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceSubmit')}" />",
						iconCls:'icon-ok',
						handler:function(){
							$('#updateServiceManager').submit();
						}
					},{
						text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" />",
						iconCls:'icon-cancel',
						handler:function(){
							$('#dialog1').dialog('close');
							$('#updateServiceManager').form('clear');
						}
					}]
				});   
               
		    }
		    
              $('#updateServiceManager').form({  
    					url:"serviceManager/updateServiceManager.shtml", 
    					onSubmit: function(){
    						  var isValid = $(this).form('validate');
							  return isValid;
    					},  
    					success:function(data){  
    					  
    						  $('#dialog1').dialog('close');
    						  $('#updateServiceManager').form('clear');
        					  $('#table').datagrid('load');
        					 
   				 		}  
			 }); 
             
             
             		
	function searchServiceManager(){
		    $('#dialog2').show();
		      $('#dialog2').dialog({
                	title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceWindowSearch')}" />",
                	collapsible: true, 
					minimizable: false, 
					maximizable: true,
					width: 500, 
					height: 300,
					modal:true,
					buttons:[{
						text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceSubmit')}" />",
						iconCls:'icon-ok',
						handler:function(){
							$('#searchServiceManager').submit();
						}
					},{
						text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" />",
						iconCls:'icon-cancel',
						handler:function(){
							$('#dialog2').dialog('close');
							$('#searchServiceManager').form('clear');
						}
					}]
				});   
               
		    }
		   
              $('#searchServiceManager').form({  
    		 	onSubmit: function(){
    		 	var contractVersionId =  $('#contractVersionSearch').get(0).value;
    		    $('#table').datagrid({
				title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serverManager')}" />",
				iconCls:'icon-save',
				width:1350,
				height:600,
				collapsible:true,
				url:'serviceManager/searchServiceManager.shtml?data='+contractVersionId,
				striped:true,
				sortName: 'code',
				fit:false,
				sortOrder: 'desc',
				resizable:true,
				remoteSort: false,
				singleSelect: true, 
				frozenColumns:[[
	                {field:'ck',checkbox:true,width:100}
	                 
				]], 
				columns:[
			    [   {title:"",field:'serviceId',hidden:true},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />",field:'contractVersionId',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />",field:'serviceVersion',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCnName')}" />",field:'serviceCnName',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />",field:'serviceEnName',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />",field:'state',width:100,
					formatter:function(value,row,index){
					if(value=='N'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisable')}" />"
					   }
					  if(value=='A'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnable')}" />"
					   }    
					}},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />",field:'serviceCode',width:100},
					{title:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceMsgFlow')}" />",field:'defaultMsgFlow',width:158}
				]],
				pageList : [15,20],         
				pageSize : 10,
				pagination:true,
				rownumbers:true,
				toolbar:[
				{
					id:'add',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAdd')}" />",
					iconCls:'icon-add',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						addServiceManager();
					}
				},{
					id:'update',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" />",
					iconCls:'icon-edit',
					handler:function(){					
					        var rows=$('#table').datagrid('getSelections');
					        if(rows.length==0)
						{
							$.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");  
						}else
						{
					        $('#serviceIdUpdate').val(rows[0].serviceId);
					    	$('#contractVersionUpdate').val(rows[0].contractVersionId);
						    $('#serviceVersionUpdate').val(rows[0].serviceVersion);
						    $('#serviceNameUpdate').val(rows[0].serviceCnName);
						    $('#serviceEnNameUpdate').val(rows[0].serviceEnName);
						    $('#serviceStatusUpdate').val(rows[0].state);
						    $('#serviceCodeUpdate').val(rows[0].serviceCode);
						    $('#MsgFlowUpdate').val(rows[0].defaultMsgFlow);
						$('#btnsave').linkbutton('enable');
						updateServiceManager();
					    }	
					}
				},'-',{
					id:'delete',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDelete')}" />",
					disabled:false,
					iconCls:'icon-remove',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						var rows=$('#table').datagrid('getSelections');
						var deleteVar="";
						if(rows.length==0)
						{
							$.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertDelete')}" />");  
						}else
						{
							for(var i=0;i<rows.length;i++)
							{
								if(i==(rows.length-1))
								{
									deleteVar+=rows[i].serviceId;
								}else
								{
									deleteVar+=rows[i].serviceId+",";
								}
							}
							$.post("serviceManager/deleteServiceManager.shtml",{deleteIDs:deleteVar},function(result){							
									$('#table').datagrid('reload');
							});
						}
					}
				},
				{
					id:'search',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceSearch')}" />",
					iconCls:'icon-search',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						searchServiceManager();
					}
				},				
				{
					id:'reload',
					text:"<s:property value="%{getText('eaap.op2.conf.server.manager.serviceRefresh')}" />",
					iconCls:'icon-reload',
					handler:function(){
						$('#table').datagrid('reload');
					}
				}
				]
			});
			
			var p = $('#table').datagrid('getPager');
			   
  			$(p).pagination({
				pageSize: 5,
        		beforePageText: "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceBeforePageText')}" />",
        		afterPageText: "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAfterPageText')}" />",  
        		displayMsg: "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisplay')}" />"
    		});  
    						  var isValid = $(this).form('validate');
							  return isValid;
    					},  
    					success:function(data){  
    						  $('#dialog2').dialog('close');
    						  $('#searchServiceManager').form('clear');
   				 		}  
			 }); 
             
 


});
		
	</script>
	<body> 
	 
		<div id="table">
	
		</div>
		<div id="dialog" style="display: none;">
			<form id="addServiceManager" method="post">
            
				<table align="center">
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />								
						</td>
						<td>
						
                       
							<input class="easyui-validatebox" id="productName" name="Service.contractVersionId"></input>
							
						</td>
					</tr>
				    <tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />							
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceVersion" name="Service.serviceVersion"></input>
						</td>
					</tr>
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCnName')}" />		
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceName" name="Service.serviceCnName"></input>
						</td>
					</tr>
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />		
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceEnName" name="Service.serviceEnName"></input>
						</td>
					</tr>
					<tr>
                       	<td>
                       	<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />		
						</td>
						<td>
						<input class="easyui-validatebox" id="serviceStatus" name="Service.state"></input>							
						</td>
					</tr>
					<tr>
	                    <td>
	                    <s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />								
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceCode" name="Service.serviceCode"></input>
						</td>
					</tr>
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceMsgFlow')}" />		
						</td>
						<td>
							<input class="easyui-validatebox" id="MsgFlow" name="Service.defaultMsgFlow"></input>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dialog1" style="display: none;">
			<form id="updateServiceManager" method="post">
				<table align="center">
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />		
						</td>
						<td>
							<input class="easyui-validatebox" id="contractVersionUpdate" name="Service.contractVersionId"></input>
							<input class="easyui-validatebox" id="serviceIdUpdate" type="hidden" name="Service.serviceId"></input>
						</td>
					</tr>
				    <tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />
							
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceVersionUpdate" name="Service.serviceVersion"></input>
						</td>
					</tr>
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCnName')}" />	
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceNameUpdate" name="Service.serviceCnName"></input>
						</td>
					</tr>
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />
							
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceEnNameUpdate" name="Service.serviceEnName"></input>
						</td>
					</tr>
					<tr>
                       	<td>
                       	<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />	
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceStatusUpdate" name="Service.state"></input>
						</td>
					</tr>
					<tr>
	                    <td>
	                    <s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />	
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceCodeUpdate" name="Service.serviceCode"></input>
						</td>
					</tr>
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceMsgFlow')}" />
						</td>
						<td>
							<input class="easyui-validatebox" id="MsgFlowUpdate" name="Service.defaultMsgFlow"></input>
						</td>
					</tr>
				</table>
			</form>
		</div>
        	<div id="dialog2" style="display: none;">
			<form id="searchServiceManager" method="post">
			
				<table align="center">
					<tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />
						</td>
						<td>
							<input class="easyui-validatebox" id="contractVersionSearch" name="Service.contractVersionId"></input>
						</td>
					</tr>
				    <tr>
						<td>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />					
						</td>
						<td>
							<input class="easyui-validatebox" id="serviceVersionSearch" name="Service.serviceVersion"></input>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
 <script type="text/javascript">  
        var v_product_Store ;  
        $().ready(function() {  
            $("#productName").autocomplete("serviceManager/showServiceManager.shtml", { 
                minChars: 1,    
                max: 12,   
                autoFill: false,  
                dataType : "json", 
                extraParams:   
                {     
                     productName: function()   
                      {   
                       return $("#productName").val();   
                      }     
                   },  
                 parse: function(data)   
                    {  
                     var rows = [];  
                       for(var i=0; i<data.length; i++)  
                         {    
                             rows[rows.length] = {  
                               data:data[i].contractVersionId,  
                               value:data[i].contractVersionId,   
                               result:data[i].contractVersionId  
                             };  
                       }             
                    return rows;  
                },  
                formatItem: function(item) {  
                        return item;  
                }  
            });  
          
        });  
    </script>       
          
</html>
