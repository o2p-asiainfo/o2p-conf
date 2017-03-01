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
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/search.png" />   
		      <s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      <s:property value="%{getText('eaap.op2.conf.hadoop.hadoopCILog')}" />  
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
	     	  <s:property value="%{getText('eaap.op2.conf.hadoop.hadoopCILogDetail')}" />
	      	</div>
	    </div> 
	   <div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         		</div>       
    	   </div>
    	   
    	   
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.contractionInteractionId')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.contractionInteractionId" id="contractionInteractionId" readonly="true"  value="${resultMap.contractionInteractionId}" skin="${contextStyleTheme}" style="width:40%"/>
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.logSeq')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.logSeq" id="logSeq" readonly="true"  value="${resultMap.logSeq}" skin="${contextStyleTheme}" style="width:40%"/>
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.funName')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.funName" id="funName" readonly="true"  value="${resultMap.funName}" skin="${contextStyleTheme}" style="width:40%"/>
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.srcSysSign')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.srcSysSign" id="srcSysSign" readonly="true"  value="${resultMap.srcSysSign}" skin="${contextStyleTheme}" style="width:40%"/>
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.errCode')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.errCode" id="errCode" readonly="true"  value="${resultMap.errCode}" skin="${contextStyleTheme}" style="width:40%"/>
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.errMsg')}" />:</td>
	   			<td>
		   			<ui:textarea id="info" name="resultMap.errMsg" value="${resultMap.errMsg}" width="800" height="50" skin="${contextStyleTheme}"/> 
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.descriptor')}" />:</td>
	   			<td>
		   			<ui:textarea id="info" name="resultMap.descriptor" value="${resultMap.descriptor}" width="800" height="50" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		 	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.createDate')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.createDate" id="createDate" readonly="true"  value="${resultMap.createDate}" skin="${contextStyleTheme}" style="width:40%"/>
	   			</td>
		   	</tr>
		 	<!-- tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.status')}" />:</td>
	   			<td>
	   				<ui:inputText name="resultMap.status" id="status" readonly="true"  value="${resultMap.status}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr-->
		   	
		    </table>
		    		 
			 <table align="center" class="mgr-table">
					<tr>	
					  	<td  colspan="4"  align="center">
				  <ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="history.go(-1);"></ui:button>   				       
						</td>
					</tr>
			  </table>
		</div>	
<script>
	$(document).ready(function(){
		var detail='<s:property value="%{getText('eaap.op2.conf.hadoop.detail')}" />';
		  $('#btnadd span span').text(detail)
	                        .removeClass()
	                        .addClass("l-btn-text icon-remove l-btn-icon-left");
	  $('#btncut').text("");
	  $('#btnsave').text("");
	  $('.datagrid-btn-separator').removeClass();
	});
</script>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>