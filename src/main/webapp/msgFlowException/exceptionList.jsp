<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />	
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>		
<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.server.supplier.service')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.msgFlowException.messageFlowName')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.msgFlowException.exceptionEndpoint')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.msgFlowException.createDate')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.msgFlowException.updateDate')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.msgFlowException.tryNum')}" />';
	title[8]='<s:property value="%{getText('eaap.op2.conf.msgFlowException.tryStatus')}" />';
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">	
  		<div class="module-path-content">
	      <img src="${contextPath}/resource/blue/images/search.png" />   
	      		<s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
	      <img src="${contextPath}/resource/blue/images/module-path.png" />
	      		<s:property value="%{getText('eaap.op2.conf.msgFlowException.msgFlowExceptionManag')}" />      
      	</div>
    </div>
   	<div class="accordion-header" >
    	<div class="accordion-header-text">
    		<span><span class="accordion-header-icon" ></span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
    	</div>
   	</div>

    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
	<ui:form id="myForm"  name="myForm" method="post" action="showTask.shtml">					
    	<ui:inputText id="allFlag"  name="allFlag"  type="hidden" skin="${contextStyleTheme}" style="float:left;"/>
    			<dl>
    				<dt><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}" />:</dt>	
    				<dd>
						 <ui:inputText  skin="${contextStyleTheme}" name="serinvokeinsName" id="serinvokeinsName"  style="float:left;"></ui:inputText>
	   				</dd>	
    			</dl>
    			
				<dl>
					<dt>
						<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />:
					</dt>
					<dd>
						 <ui:inputText  skin="${contextStyleTheme}" name="serviceName" id="serviceName"  style="float:left;"></ui:inputText>
					</dd>
				</dl>
				
				<dl>
					<dt>
						<s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}" />:
					</dt>
					<dd>
						 <ui:inputText  skin="${contextStyleTheme}" name="componentName" id="componentName"  style="float:left;"></ui:inputText>
					</dd>
				</dl>
				
				<dl>
					<dt>
						<s:property value="%{getText('eaap.op2.conf.msgFlowException.messageFlowName')}" />:
					</dt>
					<dd>
						 <ui:inputText  skin="${contextStyleTheme}" name="messageflowName" id="messageflowName"  style="float:left;"></ui:inputText>
					</dd>
				</dl>
				
				<dl>
					<dt>
						<s:property value="%{getText('eaap.op2.conf.msgFlowException.exceptionEndpoint')}" />:
					</dt>
					<dd>
						 <ui:inputText  skin="${contextStyleTheme}" name="endpointName" id="endpointName"  style="float:left;"></ui:inputText>
					</dd>
				</dl>
				
				<dl>
					<dt>
						<s:property value="%{getText('eaap.op2.conf.msgFlowException.tryStatus')}" />:
					</dt>
					<dd>
				    	<ui:multiSelectBox skin="${contextStyleTheme}"  name="tryStatus" id="tryStatus"  list="tryStatusList" listKey="key" listValue="value"></ui:multiSelectBox>
					</dd>
				</dl>
			   	<div style="text-align:right;float:right; margin-bottom:5px ;">
						<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/> 
						<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchFunc();" skin="${contextStyleTheme}"/>
				 </div>
	</ui:form>
	</div>
	<div style="clear:both;">   
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="false" id="exceptionList" remoteSort="false" sortOrder="desc"  onClickCell="true"  
			skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.msgFlowException.msgFlowExceptionList')}" 
			striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
			method="eaap-op2-conf-msgFlowException-MsgFlowExceptionAction.getExceptionDealInfoList">
		<ui:gridEasyColumn width="180" index="0" title="0" field="SERINVOKEINS_NAME" hidden="false"  align="center"   formatter="true" formatterMethod="openDetail" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="170" index="1" title="1" field="SERVICE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="150" index="2" title="2" field="COMPONENT_NAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="170" index="3" title="3" field="MESSAGEFLOW_NAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="120" index="4" title="4" field="ENDPOINT_NAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="120" index="5" title="5" field="CREATE_DATE" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="120" index="6" title="6" field="UPDATE_DATE" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="55" index="7" title="7" field="TRY_NUM" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="70" index="8" title="8" field="TRY_STATUS" hidden="false"   align="center"   formatter="true" formatterMethod="formatterForStatus" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="9" title="9" field="EXCEPTION_ID" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
   </div>
   
	<table class="mgr-table" >
	   <tr>
	    	<td align="center">
				<table>
				   <tr>
						<td id="tryBut"  align="center" style="border-width:0;">
							<ui:button text="%{getText('eaap.op2.conf.msgFlowException.try')}" id="toTrying" onclick="toTrying();" skin="${contextStyleTheme}"/>
						</td>	
						<td id="tryLoadImg" style="display:none;border-width:0;">
								<div style="width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.msgFlowException.Executioning')}" /></div>
						</td>
						<td id="cancelBut"  align="center" style="border-width:0;">
							<ui:button text="%{getText('eaap.op2.conf.msgFlowException.toCancel')}" id="toCancel" onclick="toCancel();" skin="${contextStyleTheme}"/>
						</td>	
				     </tr>
				</table>	
			</td>	
	     </tr>
	</table>
   </div>
</div>
<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
<script>
$(document).ready(function() {
	//$("#tryStatus").multiselect("widget").find(":checkbox").get(1).click();
	//$("#tryStatus").multiselect("widget").find(":checkbox").get(2).click();
	var defValue="E,W";			//W:初始异常需要人工处理，R:准备调度，D:调度中，C:调度完成（成功），E:调度完成（失败），X:异常调度作废
	var tryStatus = $("#tryStatus").multiselect("widget").find(":checkbox");
	for(var i=0; tryStatus.length>i; i++){
		var val=tryStatus[i].value;
		if(defValue.indexOf(val)>-1){
			tryStatus[i].click();
		}
	}
});

function searchFunc() {
	$("#isInit").val("false");
    var form = $("#myForm").form();
    $('#exceptionList').datagrid("load", sy.serializeObject(form));
}


function openDetail(value,row,index){
	var exceptionId = row.EXCEPTION_ID;
	var retText ="<a href=\"${contextPath}/msgFlowException/showDetail.shtml?exceptionId="+exceptionId+"\"   title=\"<s:property value="%{getText('eaap.op2.conf.msgFlowException.detail')}"/>\">"+value+"</a>";
	return retText ;
}


function formatterForStatus(value,row,index){
	var tryStatus = row.TRY_STATUS;
	var tryStatusList = $("#tryStatus").find("option");
	var retText="";
	for(var i=0; i<tryStatusList.length; i++){
		var pValue=tryStatusList[i].value;
		if(tryStatus==pValue){
			retText = tryStatusList[i].text;
			break;
		}
	}
	return retText ;
}

function toTrying(){
	if($('#exceptionList').datagrid('getSelections')[0]==null) {
		alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		return;
	}
	var  exceptionIds="";
	var sel = $('#exceptionList').datagrid('getSelections');
	for(var i=0; i<sel.length; i++){
		var tryStatus = sel[i].TRY_STATUS;
		if(tryStatus!="W" && tryStatus!="E"){
			alert("<s:property value="%{getText('eaap.op2.conf.msgFlowException.allowsRetry')}" />");
      		return;
		}
		if(exceptionIds==""){
			exceptionIds = sel[i].EXCEPTION_ID;
		}else{
			exceptionIds += ","+sel[i].EXCEPTION_ID;
		}
	}
	$("#tryLoadImg").show();
	$("#tryBut").hide();
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../msgFlowException/tryStatusUpdate.shtml",
	     dataType:"json",
	     data:{exceptionId:exceptionIds,tryStatus:'R'},
	     success:function(msg,data){
				$("#tryLoadImg").hide();
				$("#tryBut").show();
				try {
		      		var tryResult = msg[0].tryResult;
			      	if(tryResult=="true"){
						$('#exceptionList').datagrid('reload');
			      		alert("succeed");
			      	}else{
			      		alert("Failed:"+msg[0].tryResult);
			      	}
				} catch (e) { 
			      	alert("Failed");
				}
   	  	}
	});	
}


function toCancel(){
	if($('#exceptionList').datagrid('getSelections')[0]==null) {
		alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		return;
	}
	var  exceptionIds="";
	var sel = $('#exceptionList').datagrid('getSelections');
	for(var i=0; i<sel.length; i++){
		var tryStatus = sel[i].TRY_STATUS;
		if(tryStatus!="W" && tryStatus!="E"){
			alert("<s:property value="%{getText('eaap.op2.conf.msgFlowException.allowsToVoid')}" />");
      		return;
		}
		if(exceptionIds==""){
			exceptionIds = sel[i].EXCEPTION_ID;
		}else{
			exceptionIds += ","+sel[i].EXCEPTION_ID;
		}
	}
	$("#tryLoadImg").show();
	$("#cancelBut").hide();
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../msgFlowException/tryStatusUpdate.shtml",
	     dataType:"json",
	     data:{exceptionId:exceptionIds,tryStatus:'X'},
	     success:function(msg,data){
				$("#tryLoadImg").hide();
				$("#cancelBut").show();
				try {
		      		var tryResult = msg[0].tryResult;
			      	if(tryResult=="true"){
						$('#exceptionList').datagrid('reload');
			      		alert("succeed");
			      	}else{
			      		alert("Failed:"+msg[0].tryResult);
			      	}
				} catch (e) { 
			      	alert("Failed");
				}
   	  	}
	});	
}


function getTryStatusText(values){
	var tryStatusList = $("#tryStatus").find("option");
	var retText="";
	for(var i=0; i<tryStatusList.length; i++){
		var pValue=tryStatusList[i].value;
		if(values.indexof(pValue) > -1){
			retText += ","+tryStatusList[i].text;
		}
	}
	return retText ;
}

function setMessageFlowInfo(msgFlowNameInp,msgFlowNameValue,msgFlowIdInp,msgFlowIdValue){
	$("#"+msgFlowNameInp).val(msgFlowNameValue);
	$("#"+msgFlowIdInp).val(msgFlowIdValue);
}

function cleardata(str1,str2){
	$("#"+str1).val(null);
	$("#"+str2).val(null);
}
</script>
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>