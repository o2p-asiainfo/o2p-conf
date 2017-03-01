<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> Add Service Pricing</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
</head>
<script>
var title = [];

</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png"  align="top"/>
	     	<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionId')}" />
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.techimpl.title')}" />
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.pricing.manager.addServicePrice')}" />
      	</div>
    </div>
    
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
	      	<s:property value="%{getText('eaap.op2.conf.pricing.manager.addServicePrice')}" />
		</div>
    </div>
    
	<div class="formLayout" style="padding:5px 0;">
    <form name="myForm" id="myForm" method="post" action="${contextPath}/pricing/addservicePkg.shtml">
    		<dl>	
			<span style="color:red">*</span>
    				<dt style="display: inline;">
    					<s:property value="%{getText('eaap.op2.conf.pricing.manager.packageName')}" /> :
    				</dt>	
    				<dd style="display: inline;">
    				   <ui:inputText skin="${contextStyleTheme}"  id="packageName"  name="packageName"  value="${packageName}" />
    				    <input name="serviceIds" id="serviceIds" type="hidden" value="${serviceIds}"/>
    				</dd>
    				<input name="serserviceId" id="serserviceId" type="hidden" />
    		        <input name="serserviceName" id="serserviceName" type="hidden" />
    		    	<input name="serserviceCode" id="serserviceCode" type="hidden" />
    		        <input name="serviceMsgFlowId" id="serviceMsgFlowId" type="hidden" />
    		        <input name="serviceCkt" id="serviceCkt" type="hidden" value = 1 />
    		       
    		        
    		        
    		</dl>
</form>
</div>
<div style="clear:both;">	
<div id="toolbar" >
<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addMehtod()">ADD
<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteMethod()">Delete</a>
</div>
<div>
	<table class="easyui-datagrid"  id ="tab1"  style="height:250px"data-options="singleSelect:true,collapsible:true," toolbar="#toolbar" >
		<thead>
		<tr>
			<th data-options="field:'check',width:50,checkbox:true">111</th>
        	<th data-options="field:'id',width:50,hidden:true"></th>
		    <th data-options="field:'serviceName',width:250,align:'center'">Servicefff Name</th>
			<th data-options="field:'serviceCode',width:250,align:'center'">Service Code</th>
			<th data-options="field:'organization',width:100,align:'center'">Organization</th>
			<th data-options="field:'componentName',width:200,align:'center'">Component Name</th>
			<th data-options="field:'createdTime',width:200,align:'center'">Created Time </th>
			<th data-options="field:'statusTime',width:200,align:'center'">Status Time</th>
            <th data-options="field:'status',width:137,align:'center'">Status</th>
		</tr>
	</thead>
    <tbody  id='tbody'>  
          
    </tbody>
</table>
</div>
<div style="width:100%; text-align:center; padding-top:20px; ">
		<a class="button-base button-middle" onclick = save();>
		<span class="button-text"> <s:property value="%{getText('eaap.op2.conf.pricing.manager.save')}" /> </span>
		</a>
		<a class="button-base button-middle" onclick="history.go(-1);">
		<span class="button-text"> <s:property value="%{getText('eaap.op2.conf.pricing.manager.cancel')}" /> </span>
		</a>
		

</div>
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
$(document).ready(function(){
  $('#tab1').datagrid({selectOnCheck:false})
});

function deleteMethod(){ 
	 
	var rows = $('#tab1').datagrid('getSelections');
    if(rows.length==0){
        $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
        return false; 
        } 
    var index = $('#tab1').datagrid('getRowIndex', rows[0]);
    $('#tab1').datagrid('deleteRow', index);  
  
 
}  

function searchFunc() {
    
 }
 
function formatterForImportFileOrUrl(value,row,index){

}

function formatterForRemark(value,row,index){

}

 function downloadAttach(fileAttachId){
  }

function addMehtod(){
	 
	openWindows('${contextPath}/serviceManager/showMainInfo.shtml?pageState=pageState&serviceCode=serserviceCode&&serviceName=serserviceName&&serviceMsgFlowId=serviceMsgFlowId&&serviceId=serserviceId','Choose Servcice');
	
	///window.location="${contextPath}/serviceManager/showMainInfo.shtml?pageState=pageState&serviceCode=serserviceCode&&serviceName=serserviceName&&serviceMsgFlowId=serviceMsgFlowId&&serviceId=serserviceId','Choose Servcice";
	 
	} 

function formatterForOp(value,row,index){
	 
}
function addTab1(ids,codes,names,providers){
  
	var newTr = "";
	 
		newTr = "<tr id='"+ids+"'>"  
		   +"<td><input name='checkbox' type='checkbox'/></td>"
		   +"<td><input type='hidden' value='"+ids+"'/>"+names+"</td>"
		   +"<td>"+codes+"</td>"
		   +"<td>"+providers+"</td>"
		   +"<td><input type='text'/></td>"
		   +"<td><input type='text'/></td>"
		   +"<td><span  onclick=\"$(this).closest('tr').remove()\"><img src='${contextPath}/resource/${contextStyleTheme}/images/icon-delete.png' width='16' height='16'/></span></td>"
		   +"</tr>";  
		    
		//  $('#tab1').append(newTr);  
		  $('#tab1').datagrid('appendRow',{
			  
			  id:ids,
			  serviceName:names,
			  serviceCode:codes,
			  organization:providers
          });
		 
}
function save(){ 
	var t=$('#tab1').datagrid("getRows"); 
	var rl= t.length;  
	var serviceIds = "";
	var pkgName = $("#packageName").val();
	if(pkgName!=null&&""!=pkgName){
		
	}else{
		$.messager.alert("Wornning","<s:property value="%{getText('eaap.op2.conf.pricing.manager.offerNameCheck')}" />");
		return;
	}
	if(rl>0){
		for (i=0;i<rl;i++) {  
			var id = t[i].id;
			serviceIds+=id+",";
		}
	}else{
		$.messager.alert("Wornning","<s:property value="%{getText('eaap.op2.conf.pricing.manager.serviceNameCheck')}" />");
		return;
	}

	   $("#serviceIds").val(serviceIds);
	   
	   myForm.submit();
	
	
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>