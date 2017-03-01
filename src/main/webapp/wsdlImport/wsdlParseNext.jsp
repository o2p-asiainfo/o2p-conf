<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/icon.css" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/uploadify.css" /> 
    <link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/docUpload.css" />  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>		 
	<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/> 	
	 <script type="text/javascript" src="${contextPath}/resource/comm/adapter/json2.js" ></script>
 </head>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png"  align="top"/>
	     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/>
      	</div>
    </div>
    
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
		 <ui:form id="myForm" name="myForm" action="wsdlImportSave.shtml" method="post">
			<input id="wsdlJson"  name="wsdlJson"  type="hidden" />

			<div id="saveResultInfo"  style="padding:10px;"></div>
			
			<table id="selTable"   style="display:none;"  class="mgr-table" width="100%" >
				<tr>
		  			<td class="item" style="width:25%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.wsdlImport.isSelectServiceProvider')}" />:</td>
		  			<td class="item-content" style="width:75%;">
                    	<select id="isSelectServiceProvider"  name="isSelectServiceProvider"  onchange="isSelectServiceProviderChange()"  style="width:180px">
							<option value="1"><s:property value="%{getText('eaap.op2.conf.wsdlImport.yes')}" /></option>
							<option value="0"><s:property value="%{getText('eaap.op2.conf.wsdlImport.no')}" /></option>
						</select>
		   			</td>
		   		</tr>
		    </table>
			
		    <div  id="chooseTechImpl_Div"  style="display:none;">
			<table class="mgr-table"  width="100%">
				<tr>
		  			<td class="item" style="width:25%;"><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
		  			<td class="item-content" style="width:75%;">
		   				<div class="ui-widget">
			  				<input id="techImplId"  name="techImplId"  type="hidden" />
			  			    <ui:inputText skin="${contextStyleTheme}" name="techImplName" id="techImplName"  style="width:280px;" readonly="true" ></ui:inputText>
		                    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/techimpl/showTechImplIndex.shtml?techImplId=techImplId&techImplName=techImplName&&pageState=pageState','Select Technology Implementation')" shape="s"></ui:button>
		  				</div>  
		   			</td>
		   		</tr>
		    </table>
			</div>
			
			
		 </ui:form>
	</div>
</div>

<div  id="saveButTb"   style="display:none;"  style="text-align:center;">
	<table align="center" >
	    <tr>
	    	<td style="padding:20px;">
	    			<div id="saveBut">
				  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.sure')}" id="sureBut" onclick="wsdlImportSave()"></ui:button>
	    			</div>
			  		<div id="saveLoadImg" style="display:none;width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.wsdlImport.saving')}" /></div>
			</td>
		</tr>
	</table>
</div>

<div  id="cancelButTb"   style="display:none;"  style="text-align:center;">
	<table align="center" >
	    <tr>
	    	<td style="padding:20px;">
					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.sure')}"  id="returnBut" onclick="location='${contextPath}/wsdlImport/wsdlImportList.shtml'"></ui:button>&nbsp;&nbsp;
			</td>
		</tr>
	</table>
</div>

<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<input id="objId" name="objId" type="hidden" />	
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	try {
			var saveResult = ${saveResult}
			if(saveResult.RespCode=="success"){
				  $("#selTable").show();
				  $("#chooseTechImpl_Div").show();
				  $("#saveButTb").show();
				  $("#saveResultInfo").html("<font style='color:#518400; font-size:16px;'>Import Success.</font>");
			}else{
				  $("#selTable").hide();
				  $("#chooseTechImpl_Div").hide();
				  $("#saveButTb").hide();
				  $("#cancelButTb").show();
				  $("#saveResultInfo").html("<font style='color:#FF0000; font-size:16px;'>Import Failure ! </font><br>"+saveResult.RespDesc);
			}
	} catch (e) {
	
	}
})

function isSelectServiceProviderChange(){
	  var isSelectServiceProvider =  $('#isSelectServiceProvider').val();
	  if (isSelectServiceProvider == "1") {
		  $("#chooseTechImpl_Div").show();
	  } else {
		  $("#chooseTechImpl_Div").hide();
	  }
}

function wsdlImportSave(){
	  var isSelectServiceProvider =  $('#isSelectServiceProvider').val();
	  var tt = $("#wsdlJson").val();
	  if (isSelectServiceProvider == "1") {
			if(jQuery.trim($("#techImplId").val()) == ""){
				return;
			}
			var wsdlStr = ${wsdlJsonStr};
			var WsdlJson = eval(wsdlStr);
			var wsdlJsonStr = JSON.stringify(WsdlJson);
			$("#wsdlJson").val(wsdlJsonStr);
			var form = document.getElementById("myForm");
			form.action="wsdlImportSave.shtml";
			form.submit();	
			$("#saveLoadImg").show();
			$("#saveBut").hide();
	  } else {
			window.location="${contextPath}/wsdlImport/wsdlImportList.shtml";
	  }
}

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
