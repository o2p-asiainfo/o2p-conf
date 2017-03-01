<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<script>
	
function do_delete(){
	var value = $("input[name='radiobutton']:checked").val();
	
	if(value == undefined){
		alert("<s:property value="%{getText('eaap-op2-conf-flowcontrol.mustselect')}"/>");
		return ;
	}
	
	if (confirm("<s:property value="%{getText('eaap-op2-conf-authenticate.deleteConfirm')}"/>")) {
		$("#did").val(value);
		$("#form3").submit();
    }
}

function do_add(){
	window.top.location = "addAuthenticatePre.shtml";
}

function do_edit(){
	var value = $("input[name='radiobutton']:checked").val();
	if(value == undefined){
		alert("<s:property value="%{getText('eaap-op2-conf-flowcontrol.mustselectupdate')}"/>");
		return ;
	}

	if($("#"+value+"Len").val() > 0){
		$("#serInvokeInsId").val(value) ;
		$("#comIdf4").val($("#"+value+"ComId").val());
		$("#serIdf4").val($("#"+value+"SerId").val());
		$("#namef4").val($("#"+value+"Name").val());
		$("#form4").submit();
	}else{
		$("#comId").val($("#"+value+"ComId").val());
		$("#serId").val($("#"+value+"SerId").val());
		$("#name").val($("#"+value+"Name").val());
		$("#form2").submit();
	}
	
}

function addAuthenticate(comId , serId ,name){
	$("#comId").val(comId);
	$("#serId").val(serId);
	$("#name").val(name);
	$("#form2").submit();
}
</script>

</head>
<body>


<!--body start -->
	
    
    <div>
       <ui:form  name="myForm" action="../authenticate/queryExistsAuthenticate.shtml" method="post" id="form1" > 
       
    		 	 <table class="list-table" cellpadding="1" cellspacing="0" id="tab1">
			          							<tr class="tab-header" >
			          								<td width="5%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-flowcontrol.operate')}" /></td>
			          								<td width="25%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-authenticate.component')}" /></td>
			          								<td width="25%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-authenticate.serviceName')}" /></td>
			          								<td width="45%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-authenticate.authenticationType')}" /></td>
			          							</tr>
			          			<c:forEach items="${existsDataList}" step="1" var="data">
			          			    <input type="hidden" id="${data.SER_INVOKE_INS_ID}ComId" value="${data.COMPONENT_ID}" />
			          			    <input type="hidden" id="${data.SER_INVOKE_INS_ID}SerId" value="${data.SERVICE_ID}" />
			          			    <input type="hidden" id="${data.SER_INVOKE_INS_ID}Name" value="${data.NAME}" />
			          			    <input type="hidden" id="${data.SER_INVOKE_INS_ID}Len" value="${fn:length(data.proofTypeList)}" />
			          			    
			          				<tr id="${data.SER_INVOKE_INS_ID}">
			          				    <td align='center'><input type="radio" name="radiobutton" value="${data.SER_INVOKE_INS_ID}" /> </td>
			          					<td align='center'>${data.NAME}</td>
			          					<td align='center'>${data.SERVICE_CN_NAME}</td>
			          					<td >
			          					
			          					<c:choose>
			          						<c:when test="${fn:length(data.proofTypeList)<1}">
				          							&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="addAuthenticate('${data.COMPONENT_ID}','${data.SERVICE_ID}','${data.NAME}')" ><s:property value="%{getText('eaap-op2-conf-authenticate.msg')}" /></a>
				          					</c:when>
			          					</c:choose>
			          						<c:forEach items="${data.proofTypeList}" step="1" var="proofType" varStatus="pstatus">
				          							&nbsp;&nbsp;&nbsp;&nbsp;${proofType.PT_NAME}&nbsp;&nbsp;:&nbsp;&nbsp;[
				          								<c:forEach items="${proofType.attrList}" step="1" var="attr" varStatus="status">
				          								
				          								<c:choose>
				          									<c:when test="${fn:length(proofType.attrList)-1 == status.index}">
				          										 &nbsp;${attr.ATTR_SPEC_NAME}&nbsp;:&nbsp;${attr.ATTR_VALUE}&nbsp;
				          									</c:when>
				          									<c:otherwise>
				          										 &nbsp;${attr.ATTR_SPEC_NAME}&nbsp;:&nbsp;${attr.ATTR_VALUE}&nbsp;&nbsp;|&nbsp;
				          									</c:otherwise>
				          								</c:choose>
								          				
					          							</c:forEach>
			          							
			          							<c:choose>
				          									<c:when test="${fn:length(data.proofTypeList)-1 == pstatus.index}">
				          									]
				          									</c:when>
				          									<c:otherwise>
				          										]<br/>
				          									</c:otherwise>
				          								</c:choose>
			          							
			          						</c:forEach>
			          					</td>
			          				</tr>
			          			</c:forEach>	
			          			
			       <tr class="even" align="left">
   						<td colspan=8 style="PADDING-LEFT:30px;">
   					<a class="button-base button-small" title="<s:property value="%{getText('eaap-op2-conf-flowcontrol.add')}" />" target="_blank" onclick="do_add();">
						<span class="button-text"><s:property value="%{getText('eaap-op2-conf-flowcontrol.add')}" /></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap-op2-conf-flowcontrol.edit')}" />" target="_blank" onclick="do_edit();">
				  		<span class="button-text"><s:property value="%{getText('eaap-op2-conf-flowcontrol.edit')}" /></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.delete')}" />" target="_blank" onclick="do_delete();">
				  		<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.delete')}" /></span>
					</a>
					
   				</td>
   			</tr>
			</table>
			
		<div style="position:relative;float:right;botton:0;margin-top:20px;top:auto;clear:both;">
		   	<ui:page id="page"/>
	    </div>
    		
    	</ui:form>
    	
    	<form action="../authenticate/addAuthenticatePre.shtml" id="form2" method="post" target="_top" >
    		<input type="hidden" id="comId" name="serInvokeIns.componentId" />
    		<input type="hidden" id="serId" name="serInvokeIns.serviceId" />
    		<input type="hidden" id="name" name="data" />
    	</form>
    	
    	<form action="../authenticate/deleteAuthenticate.shtml" id="form3" method="post">
    		<input type="hidden" id="did" name="serInvokeIns.serInvokeInsId" />
    	</form>
    	
    	<form action="../authenticate/updateAuthenticatePre.shtml" id="form4" method="post" target="_top">
    		<input type="hidden" id="comIdf4" name="serInvokeIns.componentId" />
    		<input type="hidden" id="serIdf4" name="serInvokeIns.serviceId" />
    		<input type="hidden" id="namef4" name="data" />
    		<input type="hidden" id=serInvokeInsId name="serInvokeIns.serInvokeInsId" />
    	</form>
    </div>
    
</body>
</html>
