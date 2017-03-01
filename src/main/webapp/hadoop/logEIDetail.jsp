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
		window.location="showHadoopCI.shtml";
    }
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/search.png" />   
		      <s:property value="%{getText('eaap.op2.conf.hadoop.hadoopEILog')}" />  
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
	     	  <s:property value="%{getText('eaap.op2.conf.hadoop.hadoopEILogDetail')}" />
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
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.endpointInteractionId')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.endpointInteractionId1" id="endpointInteractionId1" readonly="true"  value="${resultMap.endpointInteractionId}" skin="${contextStyleTheme}"/>
	   				<ui:inputText name="resultMap.endpointInteractionId" id="endpointInteractionId" disabled="true" type="hidden" value="${resultMap.endpointInteractionId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.contractInteractionId')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.contractInteractionId" id="contractInteractionId" readonly="true" value="${resultMap.contractInteractionId}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.serviceId')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.serviceId" id="serviceId" readonly="true" value="${resultMap.serviceId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.endpointId')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.endpointId" id="endpointId" readonly="true" value="${resultMap.endpointId}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>				  
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.createDate')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.createDate" id="createDate" readonly="true" value="${resultMap.createDate}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcTranId')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.srcTranId" id="srcTranId" readonly="true" value="${resultMap.srcTranId}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.reqOrRes')}" />:</td>
	   			<td>
	   			    <ui:inputText name="resultMap.reqOrRes" id="reqOrRes" readonly="true" value="${resultMap.reqOrRes}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.queueMsgId')}" />:</td>
	  			<td>
	  			    <ui:inputText name="resultMap.queueMsgId" id="queueMsgId" readonly="true" value="${resultMap.queueMsgId}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.resQueue')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.resQueue" id="resQueue" readonly="true" value="${resultMap.resQueue}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.reqQueue')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.reqQueue" id="reqQueue" readonly="true" value="${resultMap.reqQueue}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstTranId')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.dstTranId" id="dstTranId" readonly="true" value="${resultMap.dstTranId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstOrgCode')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.dstOrgCode" id="dstOrgCode" readonly="true" value="${resultMap.dstOrgCode}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstSysCode')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.dstSysCode" id="dstSysCode" readonly="true" value="${resultMap.dstSysCode}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.centerFwd2DstTime')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.centerFwd2DstTime" id="centerFwd2DstTime" readonly="true" value="${resultMap.centerFwd2DstTime}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstReplyTime')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.dstReplyTime" id="dstReplyTime" readonly="true" value="${resultMap.dstReplyTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.descriptor')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.descriptor" id="descriptor" readonly="true" value="${resultMap.descriptor}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.inCreateTime')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.inCreateTime" id="inCreateTime" readonly="true" value="${resultMap.inCreateTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.outCreateTime')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.outCreateTime" id="outCreateTime" readonly="true" value="${resultMap.outCreateTime}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.endpointSpec')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.endpointSpec" id="endpointSpec" readonly="true" value="${resultMap.endpointSpec}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"> </td>
	  			<td width="40%">
	  			  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.successNum')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="resultMap.successNum" id="successNum" readonly="true" value="${resultMap.successNum}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.failNum')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="resultMap.failNum" id="failNum" readonly="true" value="${resultMap.failNum}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   		<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.failMsg')}" />:</td>
		   		<td colspan=3>
		   			<ui:textarea id="info" name="resultMap.failMsg" value="${resultMap.failMsg}" width="800" height="200" skin="${contextStyleTheme}"/> 																				
	   			</td>
	   		</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.inMsg')}" />:</td>
		   		<td colspan=3>
		   			<ui:textarea id="info" name="resultMap.inMsg" value="${resultMap.inMsg}" width="800" height="200" skin="${contextStyleTheme}"/> 																				
	   			</td>
	   		</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.outMsg')}" />:</td>
		   		<td colspan=3>
		   			<ui:textarea id="info" name="resultMap.outMsg" value="${resultMap.outMsg}" width="800" height="200" skin="${contextStyleTheme}"/> 																				
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