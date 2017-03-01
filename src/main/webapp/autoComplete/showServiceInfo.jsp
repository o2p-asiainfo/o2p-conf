<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
<!--body start -->
<ui:form method="post" id="form1" name="myform" action="../autocomplete/loadAllService.shtml">
	<div class="contentWarp">
		<table class="list-table" cellpadding="1" cellspacing="0">
			<tr class="tab-header">
				<td class="middle">&nbsp;</td>
				<td class="middle" style="width:20%"><s:property value="%{getText('eaap.op2.conf.techimpl.serviceId')}" /></td>
   				<td class="middle" style="width:40%"><s:property value="%{getText('eaap.op2.conf.techimpl.svcName')}" /></td>
   				<td class="middle" style="width:40%"><s:property value="%{getText('eaap.op2.conf.techimpl.serviceVersion')}" /></td>
   			</tr>
   			<c:choose>
   				<c:when test="${fn:length(serviceList)<1}">
   					<tr class="even" align="center">
   						<td colspan=3><s:property value="%{getText('eaap.op2.conf.techimpl.hasNoData')}" /></td>
   					</tr>
	     		</c:when>
	     		<c:otherwise>
	     			<c:forEach items="${serviceList}" var="service" varStatus="status" step="1" >
	     				<tr class="even">
	     					<td class="middle"><input type="radio" name="radioBtn" onclick="do_select();" value="${service.SERVICE_ID},${service.SERVICE_CN_NAME}" /></td>
		    				<td class="middle">${service.SERVICE_ID}</td>
		    				<td class="middle">${service.SERVICE_CN_NAME}</td>
		    				<td class="middle">${service.SERVICE_VERSION}</td>
		    			</tr>
	     			</c:forEach>
	     		</c:otherwise>
    		</c:choose>
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
	    parent.parent.doSelectSvcCallBack(returnStr);
	    parent.parent.closeSvcWin();
	}
</script>
</body>
</html>
