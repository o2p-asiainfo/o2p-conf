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
	   <input name="attrName" id="attrName" type="hidden" value="${attrName}"/>
  			<input name="objectId" id="objectId" type="hidden" value="${objectId}"/>
  			<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="hidden" value="${endpoint_Spec_Attr_Id}"/>
  			<input type="hidden" name="newState" id="newState" value="${newState}">
            <input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
	   <%-- 
	   <ui:validators validateAlert="div" validatorGroup="group1">
	      <ui:validator fieldId="newLine" validatorType="stringlength" required="false" minLength="0" maxLength="10" trim="true" message="%{getText('eaap.op2.conf.messageFlow.tolong')}"/>
	      <ui:validator fieldId="fieldSeparator" validatorType="stringlength" required="false" minLength="0" maxLength="10" trim="true" message="%{getText('eaap.op2.conf.messageFlow.tolong')}"/>
	      <ui:validator fieldId="fileAndDateSep" validatorType="stringlength" required="false" minLength="0" maxLength="10" trim="true" message="%{getText('eaap.op2.conf.messageFlow.tolong')}"/>
	   </ui:validators>
	   --%>
	   <input type="hidden" name="templateModel.csv_template_id" value="${map.CSV_TEMPLATE_ID}"/>
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
	  		<s:property value="%{getText('eaap.op2.conf.messageFlow.csvTemplateInfo')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.cvsFileName')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="templateModel.csv_file_name" id="cvsFileName"  textSize="25" type="text" value="${map.CSV_FILE_NAME}"></ui:inputText>
	  					<!--  
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&chooseOrgCode=orgId','Choose Org')" shape="s"></ui:button>
	  					-->
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.fieldSeparator')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="templateModel.field_separator" id="fieldSeparator"  textSize="25" type="text" value="${map.FIELD_SEPARATOR}"></ui:inputText>	  					
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.quotes')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">		  					
	  					<ui:select skin="${contextStyleTheme}" name="templateModel.quote_mark" id="quotes"
										list="listYN" width="157" emptyOption="true"
										listKey="key" listValue="value" value="'${map.IS_TEXTFIELD_ADD_QUOTE_MARK}'"></ui:select>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.firstLineType')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:select skin="${contextStyleTheme}" name="templateModel.first_line_type" id="firstLineType"
										list="listType" width="157" emptyOption="true"
										listKey="key" listValue="value" value="${map.FIRST_LINE_TYPE}"></ui:select>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.filePlusDate')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	 	  					
	  					<ui:select skin="${contextStyleTheme}" name="templateModel.file_add_date" id="filePlusDate"
										list="listYN" width="157" emptyOption="true"
										listKey="key" listValue="value" value="'${map.IS_FILE_NAME_ADD_DATE}'"></ui:select>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.dateFormat')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:inputText skin="${contextStyleTheme}" name="templateModel.date_format" id="dateFormat"  textSize="25" type="text" value="${map.DATE_FORMAT}"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.fileAndDateSep')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="templateModel.separator_name_and_date" id="fileAndDateSep"  textSize="25" type="text" value="${map.FILE_NAME_AND_DATE_SEPARATOR}"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.newLine')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:inputText skin="${contextStyleTheme}" name="templateModel.new_line_character" id="newLine"  textSize="25" type="text" value="${map.NEW_LINE_CHARACTER}"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.messageFlow.fileEncode')}" />:</td>
	  			<td class="item-content"  colspan="3">
	  				<div class="ui-widget">	  					  					
	  					<ui:select skin="${contextStyleTheme}" name="templateModel.file_charset" id="fileEncode"
										list="listEncode" width="157" emptyOption="true"
										listKey="key" listValue="value" value="${map.FILE_CHARSET}"></ui:select>
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
function formSubmit(){
	//if(comm_validators_check('group1')){
	var newLine = $('#newLine').val();
	if('' == newLine){
		alert('<s:property value="%{getText('eaap.op2.conf.messageFlow.newLine')}" /> '+'<s:property value="%{getText('eaap.op2.conf.prov.isNotNull')}" />');
		return;
	}else if(newLine.length >10){
		alert('<s:property value="%{getText('eaap.op2.conf.messageFlow.newLine')}" /> '+'<s:property value="%{getText('eaap.op2.conf.messageFlow.tolong')}" />');
		return;
	}
	var fieldSeparator = $('#fieldSeparator').val();
	if('' == fieldSeparator){
		alert('<s:property value="%{getText('eaap.op2.conf.messageFlow.fieldSeparator')}" /> '+'<s:property value="%{getText('eaap.op2.conf.prov.isNotNull')}" />');
		return;
	}else if(fieldSeparator.length >10){
		alert('<s:property value="%{getText('eaap.op2.conf.messageFlow.fieldSeparator')}" /> '+'<s:property value="%{getText('eaap.op2.conf.messageFlow.tolong')}" />');
		return;
	}
	var fileAndDateSep = $('#fileAndDateSep').val();
	if('' == fileAndDateSep){
		alert('<s:property value="%{getText('eaap.op2.conf.messageFlow.fileAndDateSep')}" /> '+'<s:property value="%{getText('eaap.op2.conf.prov.isNotNull')}" />');
		return;
	}else if(fileAndDateSep.length >10){
		alert('<s:property value="%{getText('eaap.op2.conf.messageFlow.fileAndDateSep')}" /> '+'<s:property value="%{getText('eaap.op2.conf.messageFlow.tolong')}" />');
		return;
	}
	$('#templateForm').attr('action','../messageFlow/updateSubmit.shtml');
	$('#templateForm').submit();
	//}
}
</script>
</html>

