<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.lang.*" pageEncoding="UTF-8"%>
<html>
  <head>
    
    <title>updateTechImplInfo.jsp</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=${contextStyleTheme}" ></script> 
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script> 
  </head>
  
  <body>
	   <ui:form id="templateForm" action="" method="post" name="templateForm" >
	   <ui:validators validateAlert="div" validatorGroup="group1">
	      <ui:validator fieldId="dataSourceName" validatorType="stringlength" required="false" minLength="0" maxLength="20" trim="true" message="%{getText('eaap.op2.conf.logserver.tolong')}"/>
	      <ui:validator fieldId="tabSuffix" validatorType="stringlength" required="false" minLength="0" maxLength="50" trim="true" message="%{getText('eaap.op2.conf.logserver.to50long')}"/>
	   </ui:validators>
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
	  		<s:property value="%{getText('eaap.op2.conf.messageFlow.csvTemplateInfo')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.dataSourceName')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="dataSourceBean.dataSourceName" id="dataSourceName"  textSize="25" type="text" value=""></ui:inputText>
	  					<!--  
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&chooseOrgCode=orgId','Choose Org')" shape="s"></ui:button>
	  					-->
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.componentName')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}"  id="myComponentName" name="myComponentName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('myComponentName','myComponentId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="myComponentId" name="dataSourceBean.componentCode"/>                                   
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=myComponentName&chooseCompCode=myComponentId','Choose Component')" shape="s"></ui:button>	  					
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.tabSuffix')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					 <ui:inputText skin="${contextStyleTheme}" name="dataSourceBean.tabSuffix" id="tabSuffix"  textSize="25" type="text" value=""></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.remarks')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:inputText skin="${contextStyleTheme}" name="dataSourceBean.remarks" id="remarks"  textSize="25" type="text" value=""></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.isDefault')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:select skin="${contextStyleTheme}" name="dataSourceBean.isDefault" id="isDefault"
										list="listType" width="157" emptyOption="true"
										listKey="key" listValue="value"></ui:select>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.isBeginInit')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:select skin="${contextStyleTheme}" name="dataSourceBean.isBeginInit" id="isBeginInit"
										list="listYN" width="157" emptyOption="true"
										listKey="key" listValue="value"></ui:select>
	  				</div>  	
	   			</td>
	   		</tr>
	    </table>
	    </ui:form>
	  </div>
 	  <div align="center">
 	            <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="formSubmit();"></ui:button>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" onclick="window.history.go(-1);"></ui:button>
	  </div> 
</div>
 </body>
<script>
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
function formSubmit(){
// 	if(comm_validators_check('group1')){
// 	$('#templateForm').attr('action','../logServer/addSubmit.shtml');
// 	$('#templateForm').submit();
// 	}
	var form = document.getElementById("templateForm");
  	if(comm_validators_check('group1')){
   	    form.action="addSubmit.shtml";
   		form.submit();				
    }	
}
</script>
</html>

