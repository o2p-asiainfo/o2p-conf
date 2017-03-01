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
<ui:form method="post" id="form1" name="myform" action="../autocomplete/loadAllComponent.shtml">
	<div class="contentWarp">
		<table class="list-table" cellpadding="1" cellspacing="0">
			<tr class="tab-header">
				<td class="middle">&nbsp;</td>
				<td class="middle" style="width:50%"><s:property value="%{getText('eaap.op2.conf.techimpl.componentId')}" /></td>
   				<td class="middle" style="width:50%"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" /></td>
   			</tr>
   			<c:choose>
   				<c:when test="${fn:length(componentList)<1}">
   					<tr class="even" align="center">
   						<td colspan=3><s:property value="%{getText('eaap.op2.conf.techimpl.hasNoData')}" /></td>
   					</tr>
	     		</c:when>
	     		<c:otherwise>
	     			<c:forEach items="${componentList}" var="component" varStatus="status" step="1" >
	     				<tr class="even">
	     					<td class="middle"><input type="radio" name="radioBtn" onclick="do_select();" value="${component.COMPONENT_ID},${component.NAME}" /></td>
		    				<td class="middle">${component.COMPONENT_ID}</td>
		    				<td class="middle">${component.NAME}</td>
		    			</tr>
	     			</c:forEach>
	     		</c:otherwise>
    		</c:choose>
    		<!-- 
    		<tr class="even" align="left">
   				<td colspan=3 style="PADDING-LEFT:30px;">
   					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" />" target="_blank" onclick="do_select();">
						<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" /></span>
					</a>
   				</td>
   			</tr>
   			 -->
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
</script>
</body>
</html>
