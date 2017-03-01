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
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
	  		<s:property value="%{getText('eaap.op2.conf.messageFlow.csvTemplateInfo')}" />
	     	</div>
	    </div>
	    
	   <ui:form id="myForm" action="editDataSource.shtml" method="post" name="myForm" >
	   <input type="hidden" name="dataSource.dataSourceId"  id="dataSourceId"  value="${dataSource.dataSourceId}"/>
	   
	   <input type="hidden" name="dataSourceRoute.dataSourceRouteId"  value="${dataSourceRoute.dataSourceRouteId}"/>
	   <input type="hidden" name="dataSourceRoute.dataSourceId"  value="${dataSourceRoute.dataSourceId}"/>
	   <input type="hidden" name="dataSourceRoute.stateDate"  value="${dataSourceRoute.stateDate}"/>
	   
	   <input type="hidden" name="isHaveDefault" id="isHaveDefault" value="${isHaveDefault}"/>
	   <input type="hidden" name="conCurrentDefault" id="conCurrentDefault" value="${dataSource.isDefault}"/>
	   <ui:validators validateAlert="div" validatorGroup="group1">
	   		<ui:validator fieldId="componentName" validatorType="requiredstring" required="true" message="%{getText('eaap.op2.conf.logserver.notnull.componentName')}"/>
	      <ui:validator fieldId="dataSourceName" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.dataSourceName')}"/>
	      <ui:validator fieldId="tabSuffix" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.tabSuffix')}"/>
	      <ui:validator fieldId="pri" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.pri')}"/>
	      
	      <s:if test="dataSourceType==1">
	      		<ui:validator fieldId="driverclassname" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.driverclassname')}"/>
	      		<ui:validator fieldId="url" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.url')}"/>
	      		<ui:validator fieldId="username" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.username')}"/>
	      		<ui:validator fieldId="passwdEncpty" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.passwd')}"/>
	    	</s:if>
	    	
	    	<s:if test="dataSourceType==2">
	      		<ui:validator fieldId="jndiName" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.jndiName')}"/>
	      		<ui:validator fieldId="jndiState" validatorType="requiredstring" required="true"  trim="true" message="%{getText('eaap.op2.conf.logserver.notnull.jndiState')}"/>
	    	</s:if>
	      	
	   </ui:validators>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.dataSourceName')}" />:</td>
	  			<td class="item-content">   					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="dataSource.dataSourceName" id="dataSourceName"  textSize="25" type="text" value="${dataSource.dataSourceName}"></ui:inputText>
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.componentName')}" />:</td>
	   			<td class="item-content">  					  					
	  					<ui:inputText skin="${contextStyleTheme}"  id="componentName" name="componentName" value="${componentName}" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('componentName','componentId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="componentId" name="dataSource.componentId" value="${dataSource.componentId}"/>                                   
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=componentName&chooseCompCode=componentId','Choose Component')" shape="s"></ui:button>	  					
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.tabSuffix')}" />:</td>
	  			<td class="item-content">
	  					  					  					
	  					 <ui:inputText skin="${contextStyleTheme}" name="dataSource.tabSuffix" id="tabSuffix"  textSize="25" type="text" value="${dataSource.tabSuffix}"></ui:inputText>
	  				
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.isBeginInit')}" />:</td>
	   			<td class="item-content">
	   				
	  				  <ui:select skin="${contextStyleTheme}" name="dataSource.isbegininit" id="isbegininit"
										list="listYN" width="160" emptyOption="true"
										listKey="key" listValue="value" value="'${dataSource.isbegininit}'"></ui:select>
	  					
	   			</td>
	   			
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.isDefault')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	 			  					
	  					<ui:select skin="${contextStyleTheme}" name="dataSource.isDefault" id="isDefault"
										list="listType" width="157" emptyOption="true"
										listKey="key" listValue="value" value="${dataSource.isDefault}"></ui:select>
	  				</div>
	   			</td>

	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.logserver.remarks')}" />:</td>
	   			<!--<td class="item-content">
	   				
	  				  <ui:inputText skin="${contextStyleTheme}" name="dataSource.remarks" id="remarks"  textSize="25" type="text" value="${dataSource.remarks}" style="width:167px; height:22px; line-height:22px; border:1px solid #CCCCCC;"></ui:inputText>
	  				
	   			</td>-->
	   			<td class="item-content" style="border-top:1px solid #CCC;">
	  					 <input type="text" name="dataSource.remarks" id="remarks"  value="${dataSource.remarks}"    style="width:167px; height:22px; line-height:22px; border:1px solid #CCCCCC;"/>
	   			</td>
	   		</tr>

	   		<tr>
	  			<td class="item"  style="border-top:1px solid #CCC;"><s:property value="%{getText('eaap.op2.conf.logserver.route_decisionRule')}" />:</td>
	  			<td class="item-content"  style="border-top:1px solid #CCC;">
	  					 <ui:inputText skin="${contextStyleTheme}" name="dataSourceRoute.decisionRule" id="decisionRule"  textSize="25" type="text" value="${dataSourceRoute.decisionRule}" ></ui:inputText>
	   			</td>
	   			<td class="item" style="border-top:1px solid #CCC;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.route_pri')}" />:</td>
	   			<td class="item-content" style="border-top:1px solid #CCC;">
	  					 <input type="text" name="dataSourceRoute.pri" id="pri"  value="${dataSourceRoute.pri}"  onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"  style="width:167px; height:22px; line-height:22px; border:1px solid #CCCCCC;"/>
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.route_state')}" />:</td>
	  			<td class="item-content">
						 <select name="dataSourceRoute.state" id="state"  style="width:165px" >
						 	<option value="A"  <s:if test="dataSourceRoute.state==\"A\"">selected</s:if> ><s:property value="%{getText('eaap.op2.conf.logserver.activation')}" /></option>
						 	<option value="X"  <s:if test="dataSourceRoute.state==\"X\"">selected</s:if> ><s:property value="%{getText('eaap.op2.conf.logserver.failure')}" /></option>
						 </select>
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.dataSourceType')}" />:</td>
	   			<td class="item-content">
					 <select name="dataSourceType" id="dataSourceType"  onchange="dataSourceTypeChange()" style="width:170px"  >
					 	<option value="1"  <s:if test="dataSourceType==1">selected</s:if> >DBCP</option>
					 	<option value="2"  <s:if test="dataSourceType==2">selected</s:if> >JNDI</option>
					 </select>
	   			</td>
	   		</tr>
	    

	    <s:if test="dataSourceType==1">	    
	   		<input type="hidden" name="dataSourceDbcp.dataSourceId" value="${dataSourceDbcp.dataSourceId}">
		   		<tr>
		   			<td class="item" style="border-top:1px solid #CCC;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.driverclassname')}" />:</td>
		   			<td class="item-content" style="border-top:1px solid #CCC;">
		  					 <ui:inputText skin="${contextStyleTheme}" name="dataSourceDbcp.driverclassname" id="driverclassname"  textSize="25" type="text" value="${dataSourceDbcp.driverclassname}"></ui:inputText>
		   			</td>
		  			<td class="item" style="border-top:1px solid #CCC;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.url')}" />:</td>
		  			<!--<td class="item-content" style="border-top:1px solid #CCC;">
		  					 <ui:inputText skin="${contextStyleTheme}" name="dataSourceDbcp.url" id="url"  textSize="25" type="text" value="${dataSourceDbcp.url}"></ui:inputText>
		   			</td>-->
		   			
		   			<td class="item-content" style="border-top:1px solid #CCC;">
	  					 <input type="text" name="dataSourceDbcp.url" id="url"  value="${dataSourceDbcp.url}"   style="width:167px; height:22px; line-height:22px; border:1px solid #CCCCCC;"/>
	   			</td>
		   		</tr>
		   		<tr>
		   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.username')}" />:</td>
		   			<td class="item-content" >
		  					 <ui:inputText skin="${contextStyleTheme}" name="dataSourceDbcp.username" id="username"  textSize="25" type="text" value="${dataSourceDbcp.username}"></ui:inputText>
		   			</td>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.passwd')}" />:</td>
		  			<td class="item-content">
		   		     		<input name="dataSourceDbcp.passwd"  id="passwd"  type="hidden"  value="${dataSourceDbcp.passwd}" />
		   		   		  <input forid="passwd" id="passwdEncpty"  value="<c:if test="${dataSourceDbcp.passwd !=null}">******</c:if>"  type="password"  onclick="this.value=''" onblur="encryptionPassword(event)" onkeyup="trimPsd()" textSize="25"  style="width:167px; height:22px; line-height:22px; border:1px solid #CCCCCC;"/>
		   			</td>
		   		</tr>
		</s:if>
		
	    <s:if test="dataSourceType==2">
	   		<input type="hidden" name="dataSourceJndi.dataSourceId" value="${dataSourceJndi.dataSourceId}">
		   		<tr>
		   			<td class="item" style="border-top:1px solid #CCC;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.jndi_name')}" />:</td>
		   			<td class="item-content" style="border-top:1px solid #CCC;">
		  					 <ui:inputText skin="${contextStyleTheme}" name="dataSourceJndi.jndiName" id="jndiName"  textSize="25" type="text" value="${dataSourceJndi.jndiName}"></ui:inputText>
		   			</td>
		  			<td class="item" style="border-top:1px solid #CCC;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.logserver.jndi_state')}" />:</td>
		  			<td class="item-content" style="border-top:1px solid #CCC;">
							 <select name="dataSourceJndi.state" id="jndiState"  style="width:170px" >
							 	<option value="A"  <s:if test="dataSourceJndi.state==\"A\"">selected</s:if> ><s:property value="%{getText('eaap.op2.conf.logserver.activation')}" /></option>
							 	<option value="X"  <s:if test="dataSourceJndi.state==\"X\"">selected</s:if> ><s:property value="%{getText('eaap.op2.conf.logserver.failure')}" /></option>
							 </select>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td class="item">Jndi <s:property value="%{getText('eaap.op2.conf.logserver.remark')}" />:</td>
		   			<td class="item-content"  colspan="3">
		  					 <ui:textarea skin="${contextStyleTheme}" name="dataSourceJndi.remarks"  id="jndiRemarks"   value="${dataSourceJndi.remarks}" width="680" height="50"></ui:textarea>
		   			</td>
		   		</tr>
		</s:if>
		    </table>
	    
	    </ui:form>
	  </div>
 	  <div align="center">
 	            <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="formSubmit();"></ui:button>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" onclick="location='${contextPath}/logServer/showLogServer.shtml'"></ui:button>
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
// 	$('#myForm').attr('action','../logServer/updateSubmit.shtml');
// 	$('#myForm').submit();
// 	}

		var isHaveDefault = document.getElementById("isHaveDefault").value;
		var isDefault = document.getElementById("isDefault").value;
		if(isHaveDefault=="1"){
			if(isDefault=="0"){
    		var r= confirm("<s:property value="%{getText('eaap.op2.conf.logserver.checkDefault')}" />");
    		if(r==false){
    			return;
    		}
    	}
			
		}
		
    
    
		var form = document.getElementById("myForm");
		var dataType = document.getElementById("dataSourceType").value;
		
	  	if(comm_validators_check('group1')){
       	    form.action="../logServer/editDataSourceSave.shtml";
       		form.submit();				
       	}	
}

function dataSourceTypeChange(){
	var form = document.getElementById("myForm");
	form.action="editDataSource.shtml";
	form.submit();				
}


function encryptionPassword(event){
	var eObj = event.srcElement?event.srcElement:event.target;
	var forid = eObj.attributes["forid"];
	if(forid != undefined){
		var passwordObj = eObj.attributes["forid"].value;
		if(eObj.value==""){
			$("#"+passwordObj).val("");
		}else{
			//加密：
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../techimpl/encryptionPassword.shtml",
			     dataType:"text",
			     data:"PlaintextPassword="+eObj.value,				//传入明文
			     success:function(msg,data){
						try{
				      		var ResultJson = eval('(' + msg + ')'); 
				      		var resultCode = ResultJson.ResultCode;
				      		var CiphertextPassword = ResultJson.CiphertextPassword;		//返回密文
				      		if(resultCode=="Success"){
								$("#"+passwordObj).val(CiphertextPassword);
				      		}
						}catch(e){
						}
		   	  	}
			});	
		}
	}
}
</script>
</html>

