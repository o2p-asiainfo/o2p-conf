<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
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
	window.location = "addFlowControlPre.shtml";
}

function do_edit(){
	var value = $("input[name='radiobutton']:checked").val();
	
	if(value == undefined){
		alert("<s:property value="%{getText('eaap-op2-conf-flowcontrol.mustselectupdate')}"/>");
		return ;
	}

	$("#id").val(value);
	$("#form2").submit();
	
}
</script>

</head>
<body>


<!--body start -->
	
    
    <div>
       <ui:form  name="myForm" action="../flowcontrol/queryExistsPolicy.shtml" method="post" id="form1" > 
       
    		 <table class="list-table" cellpadding="1" cellspacing="0" id="tab1">
			          							<tr class="tab-header" >
			          								<td width="5%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-flowcontrol.operate')}" /></td>
			          								<td width="20%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-authenticate.component')}" /></td>
			          								<td width="20%" style="font-size: 12px;" align='center' ><s:property value="%{getText('eaap-op2-conf-authenticate.serviceName')}" /></td>
			          								<td width="20%" style="font-size: 12px;" align='center'><s:property value="%{getText('eaap-op2-conf-flowcontrol.controlPolicyName')}" /></td>
			          								<td width="10%" style="font-size: 12px;" align='center'><s:property value="%{getText('eaap-op2-conf-flowcontrol.cycleValue')}" /></td>
			          								<td width="5%" style="font-size: 12px;" align='center'><s:property value="%{getText('eaap-op2-conf-flowcontrol.threshold')}" /></td>
			          								<td width="10%" style="font-size: 12px;" align='center'><s:property value="%{getText('eaap-op2-conf-flowcontrol.state')}" /></td>
			          								<td width="10%" style="font-size: 12px;" align='center'><s:property value="%{getText('eaap-op2-conf-flowcontrol.time')}" /></td>
			          							</tr>
			          			<c:forEach items="${policyList}" step="1" var="policy">
			          				<tr id="${policy.CTL_C_2_COMP_ID}">
			          				    <td align='center'><input type="radio" name="radiobutton" value="${policy.CTL_C_2_COMP_ID}" /> </td>
			          					<td align='center'>${policy.DNAME}</td>
			          					<td align='center'>${policy.SERVICE_CN_NAME}</td>
			          					<td align='center'>${policy.NAME}</td>
			          					<td align='center'>${policy.CYCLE_VALUE}
			          						<c:choose>
			          							<c:when test="${policy.CYCLE_TYPE == 1}"><s:property value="%{getText('eaap-op2-conf-flowcontrol.minute')}"/></c:when>
			          							<c:when test="${policy.CYCLE_TYPE == 2}"><s:property value="%{getText('eaap-op2-conf-flowcontrol.hour')}"/></c:when>
			          							<c:when test="${policy.CYCLE_TYPE == 3}"><s:property value="%{getText('eaap-op2-conf-flowcontrol.day')}"/></c:when>
			          							<c:when test="${policy.CYCLE_TYPE == 4}"><s:property value="%{getText('eaap-op2-conf-flowcontrol.weak')}"/></c:when>
			          							<c:when test="${policy.CYCLE_TYPE == 5}"><s:property value="%{getText('eaap-op2-conf-flowcontrol.month')}"/></c:when>
			          							<c:when test="${policy.CYCLE_TYPE == 6}"><s:property value="%{getText('eaap-op2-conf-flowcontrol.quarter')}"/></c:when>
			          						</c:choose>
			          					</td>
			          					<td align='center'>${policy.CUTMS_VALUE}</td>
			          					<td align='center'><s:property value="%{getText('eaap-op2-conf-authenticate.use')}"/></td>
			          					<td align='center'>${policy.CONFIG_TIME}</td>
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
    	
    	<form action="../flowcontrol/updateFlowControlPre.shtml" id="form2" method="post">
    		<input type="hidden" id="id" name="ctlCounterms2Comp.ctlC2CompId" />
    	</form>
    	
    	<form action="../flowcontrol/deleteCtlCounterms2Comp.shtml" id="form3" method="post">
    		<input type="hidden" id="did" name="ctlCounterms2Comp.ctlC2CompId" />
    	</form>
    </div>
    
</body>
</html>
