<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/icon.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
<!--body start -->
<ui:form method="post" id="form1" name="myform" action="../techimpl/loadHasCfgData.shtml">
	<div class="contentWarp">
		<table class="list-table" cellpadding="1" cellspacing="0">
			<tr class="tab-header">
				<td class="middle">&nbsp;</td>
				<td class="middle" style="width:20%"><s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" /></td>
   				<td class="middle" style="width:30%"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" /></td>
   				<td class="middle" style="width:15%"><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" /></td>
   				<td class="middle" style="width:15%"><s:property value="%{getText('eaap.op2.conf.techimpl.controlMethod')}" /></td>
   				<td class="middle" style="width:10%"><s:property value="%{getText('eaap.op2.conf.techimpl.controlVal')}" /></td>
   				<td class="middle" style="width:10%"><s:property value="%{getText('eaap.op2.conf.techimpl.cycleVal')}" /></td>
   			</tr>
   			<c:choose>
   				<c:when test="${fn:length(techImplList)<1}">
   					<tr class="even" align="center">
   						<td colspan=7><s:property value="%{getText('eaap.op2.conf.techimpl.hasNoData')}" /></td>
   					</tr>
	     		</c:when>
	     		<c:otherwise>
	     			<c:forEach items="${techImplList}" var="techImpl" varStatus="status" step="1" >
	     				<tr class="even">
	     					<td class="middle"><input type="radio" name="radioBtn" value="${techImpl.TECH_IMPL_NAME},${techImpl.COMPONENT_ID},${techImpl.CUTMS_VALUE},${techImpl.CYCLE_TYPE},${techImpl.CYCLE_VALUE},${techImpl.COMM_PRO_CD},${techImpl.TECH_IMPL_ID},${techImpl.CC_CD}" /></td>
		    				<td class="middle">${techImpl.TECH_IMPL_NAME}</td>
		    				<td class="middle">${techImpl.COMPONENT_NAME}</td>
		    				<td class="middle">${techImpl.COMM_PRO_NAME}</td>
		    				<td class="middle">${techImpl.CC_NAME}</td>
		    				<td class="middle">
		    					${techImpl.CUTMS_VALUE}
		    					<c:choose>
		    						<c:when test="${techImpl.CC_CD==1}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.ci')}" />)
		    						</c:when>
		    						<c:when test="${techImpl.CC_CD==2}">
		    							(M)
		    						</c:when>
		    						<c:when test="${techImpl.CC_CD==3}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.ge')}" />)
		    						</c:when>
		    					</c:choose>
		    				</td>
		    				<td class="middle">
		    					${techImpl.CYCLE_VALUE}
		    					<c:choose>
		    						<c:when test="${techImpl.CYCLE_TYPE==1}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.minitue')}" />)
		    						</c:when>
		    						<c:when test="${techImpl.CYCLE_TYPE==2}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.hour')}" />)
		    						</c:when>
		    						<c:when test="${techImpl.CYCLE_TYPE==3}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.day')}" />)
		    						</c:when>
		    						<c:when test="${techImpl.CYCLE_TYPE==4}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.week')}" />)
		    						</c:when>
		    						<c:when test="${techImpl.CYCLE_TYPE==5}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.month')}" />)
		    						</c:when>
		    						<c:when test="${techImpl.CYCLE_TYPE==6}">
		    							(<s:property value="%{getText('eaap.op2.conf.techimpl.quarter')}" />)
		    						</c:when>
		    					</c:choose>
		    				</td>
		    			</tr>
	     			</c:forEach>
	     		</c:otherwise>
    		</c:choose>
    		<tr class="even" align="left">
   				<td colspan=7 style="PADDING-LEFT:30px;">
   					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" />" target="_blank" onclick="do_select();">
						<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" /></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.addBtn')}" />" target="_blank" onclick="do_add();">
						<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.addBtn')}" /></span>
					</a>
   				</td>
   			</tr>
   		</table>
   		<div style="position:relative;float:right;botton:0;margin-top:10px;top:auto;clear:both;">
		   	<ui:page id="page"/>
	    </div>
   </div>
</ui:form>
<!--body end --> 
<script type="text/javascript">
	function do_select(){
		var rdoObj = $("input[name='radioBtn']");
	  	var isChoose = false;
	  	var returnStr = "";
	  	for (var i=0;i<rdoObj.length;i++){
	  		if(rdoObj[i].checked){
	  			returnStr = rdoObj[i].value;
				isChoose = true;
	  		}
	  	}
	  	if(!isChoose){
	  		jQuery.messager.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.techimpl.chooseRecord')}" />!','warning');
	        return false;
	    }
	    parent.parent.doSelectCallBack(returnStr);
	    parent.parent.closeWin();
	}
	
	function do_add(){
	 	window.location.href = "${contextPath}/techimpl/addTechImplInfo.shtml?t="+Math.random();
	}
</script>
</body>
</html>
