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
		      		<s:property value="%{getText('eaap.op2.conf.task.taskLog')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
	     	  <s:property value="%{getText('eaap.op2.conf.task.taskLogDetail')}" />
	      	</div>
	    </div> 
<ui:form method="post" id="taskForm" action="">	
	   <div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         		</div>       
    	   </div>
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.schdInstId')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="taskJobLogBean.schdInstId" id="schdInstId" readonly="true"  value="${taskJobLogBean.schdInstId}" skin="${contextStyleTheme}"/>
	   				<ui:inputText name="taskJobLogBean.taskLogId" id="taskLogId" disabled="true" type="hidden" value="${taskJobLogBean.taskLogId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.eventType')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="taskJobLogBean.eventType" id="eventType" readonly="true" value="${taskJobLogBean.eventType}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.jobName')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="taskJobLogBean.jobName" id="jobName" readonly="true" value="${taskJobLogBean.jobName}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.jobClass')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="taskJobLogBean.jobClass" id="jobClass" readonly="true" value="${taskJobLogBean.jobClass}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>				  
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.staffNo')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="taskJobLogBean.staffNo" id="staffNo" readonly="true" value="${taskJobLogBean.staffNo}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.ip')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="taskJobLogBean.ip" id="ip" readonly="true" value="${taskJobLogBean.ip}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.logType')}" />:</td>
	   			<td>
	   			    <ui:inputText name="taskJobLogBean.logType" id="logType" readonly="true" value="${taskJobLogBean.logType}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.createDT')}" />:</td>
	  			<td>
	  			    <ui:inputText name="taskJobLogBean.createDT" id="createDT" readonly="true" value="${taskJobLogBean.createDT}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.taskId')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="taskJobLogBean.taskId" id="taskId" readonly="true" value="${taskJobLogBean.taskId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.sessionId')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="taskJobLogBean.sessionId" id="sessionId" readonly="true" value="${taskJobLogBean.sessionId}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.task.info')}" />:</td>
		   		<td colspan=3>
		   			<ui:textarea id="info" name="taskJobLogBean.info" value="${taskJobLogBean.info}" width="800" height="200" skin="${contextStyleTheme}"/> 																				
	   			</td>
	   		</tr>
	   		<tr>	
	   		  	<td  colspan="4"  align="center">
					  <ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="history.go(-1);"></ui:button>   				       
   				</td>
	   		</tr>
		    </table>
	</div>
</ui:form>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>