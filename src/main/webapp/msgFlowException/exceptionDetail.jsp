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

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
		
	<script>		
    function returnPage() {
		window.location="showTaskLog.shtml";
    }
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
				<img src="${contextPath}/resource/blue/images/edit.png" />   
	      		<s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
				<img src="${contextPath}/resource/blue/images/module-path.png" />
				<s:property value="%{getText('eaap.op2.conf.msgFlowException.msgFlowExceptionManag')}" />
				<img src="${contextPath}/resource/blue/images/module-path.png" />
				<s:property value="%{getText('eaap.op2.conf.msgFlowException.detail')}" />
	      	</div>
	    </div> 
<ui:form method="post" id="taskForm" action="">	
	   <div class="contentWarp">
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%">Exception ID:</td>
	   			<td width="40%">
	   				${exceptionDealInfo.exceptionId}
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}" />:</td>
	  			<td width="40%">
	  				${exceptionDealInfo.serInvokeInsName}
	   			</td>
		   	</tr>
		   	
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.manager.auth.sername')}" />:</td>
	   			<td width="40%">
	   				${exceptionDealInfo.serviceName}
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}" />:</td>
	  			<td width="40%">
	  				${exceptionDealInfo.componentName}
	   			</td>
		   	</tr>
		   	
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.msgFlowException.messageFlowName')}" />:</td>
	   			<td width="40%">
	   				${exceptionDealInfo.messageFlowName}
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.msgFlowException.exceptionEndpoint')}" />:</td>
	  			<td width="40%">
	  				${exceptionDealInfo.endPointName}
	   			</td>
		   	</tr>
		   	
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.msgFlowException.createDate')}" />:</td>
	  			<td width="40%">
	  				${exceptionDealInfo.createDate}
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.msgFlowException.updateDate')}" />:</td>
	  			<td width="40%">
	  				${exceptionDealInfo.updateDate}
	   			</td>
		   	</tr>
		   	
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.msgFlowException.tryNum')}" />:</td>
	   			<td width="40%">
	   				${exceptionDealInfo.tryNum}
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.msgFlowException.tryStatus')}" />:</td>
	   			<td width="40%">
	   				${exceptionDealInfo.tryStatus}
	   			</td>
		   	</tr>

		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.msgFlowException.exceptionCode')}" />:</td>
		   		<td colspan=3>
		   			<div id="exceptionCode" name="exceptionCode"  style="width:100%;height:145px; overflow-x:hidden; overflow-y:auto;">${exceptionDealInfo.exceptionCode}</div> 																				
	   			</td>
	   		</tr>

		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.msgFlowException.exceptionStack')}" />:</td>
		   		<td colspan=3>
		   			<div id="exceptionStack" name="exceptionStack"  style="width:100%;height:125px; overflow-x:hidden; overflow-y:auto;">${exceptionDealInfo.exceptionStack}</div> 																			
	   			</td>
	   		</tr>
	   		<tr>	
	   		  	<td  colspan="4"  align="center">
					  <ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId"  onclick="window.location='${contextPath}/msgFlowException/showException.shtml'"></ui:button>   				       
   				</td>
	   		</tr>
		    </table>
	</div>
</ui:form>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>