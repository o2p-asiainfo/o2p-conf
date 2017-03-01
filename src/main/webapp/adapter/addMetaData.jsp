<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>	
	
    <script type="text/javascript">
	  function changeMethod(obj){
		  if("2"==$(obj).val()){
			  $("#valExpress").hide();
		  }else{
			  $("#valExpress").show();
		  }
		}
   		function metaDataMachingFormSubmit(){
   			var source = $('#source').val();
   			var key = $("#key").val();
   			var val = $("#val").val();
   			if(!key || source=="1" && !val ){
   				alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
   			}
   			var vOpener=window.art.dialog.opener;
   			var varMapingID = $("#varMapingID").val();
   			var actionType = "";
   			if($("#varMapingID").val()==""){
   				actionType = "insert";
   			}else{
   				actionType = "update";
   			}
   			vOpener.addMeatData(varMapingID,actionType,source,key,val);
   			art.dialog.close();
   		}
   		
    </script>
</head>
<body class="easyui-layout" style="width:350px; border: 1px;">
	<ui:form id="metaDataMachingForm" name="metaDataMachingForm" action="saveOrUpdateVariableMap.shtml" method="post">
		<ui:inputText skin="${contextStyleTheme}" name="actionType" id="actionType" textSize="30" type="hidden" value=""></ui:inputText>
		<ui:inputText skin="${contextStyleTheme}" name="varMapingID" id="varMapingID" textSize="30" type="hidden" value="${contractTypeMap.varMapingID }"></ui:inputText>
		<table align="center" class="mgr-table">
	            <tr>
	               <td align="right" width="35%"><s:property value="%{getText('eaap.op2.conf.adapter.dataSource')}"/></td>
	               <td colspan="3" width="65%">
						<ui:select onchange="changeMethod(this);" skin="${contextStyleTheme}"  name="source" width="" id="source" list="metaDataMachingL"  emptyOption="fasle"
								headerValue=""	layerWidth="135" layerHeight="65" listKey="id" listValue="val" value="${contractTypeMap.dataSource }">
							</ui:select>
	               </td>
	            </tr>
	            <tr>
	               <td align="right" width="35%"><s:property value="%{getText('eaap.op2.conf.adapter.keyExpress')}"/></td>
	               <td colspan="3" width="65%">
						<ui:inputText skin="${contextStyleTheme}" name="key" id="key" textSize="30" value="${contractTypeMap.keyExpress }"></ui:inputText>
	               </td>
	            </tr>
	            <tr id="valExpress">
	               <td align="right" width="30%"><s:property value="%{getText('eaap.op2.conf.adapter.valExpress')}"/></td>
	               <td colspan="3" width="65%">
						<ui:inputText skin="${contextStyleTheme}" name="val" id="val" textSize="30" value="${contractTypeMap.valExpress }"></ui:inputText>
	               </td>
	            </tr>
	       </table>
	       <br/>
	       <div align="center">
	       		<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.server.manager.confirm')}" onclick="metaDataMachingFormSubmit();"></ui:button>
            	<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
	       </div>
	</ui:form>
</body>
</html>