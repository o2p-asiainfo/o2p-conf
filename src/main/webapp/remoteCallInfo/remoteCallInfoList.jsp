<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
 </head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.code')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.url')}"/>';
</script>

<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path"  id="pagePath">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.remoteCallInfo')}"/>
      	</div>
    </div>
    <div class="accordion-header"  id="searchBarTitle">
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
		</div>
    </div>
    
    <div id="queryBlock">
	<div class="formLayout" style="padding:5px 0;">
	    <ui:form name="myForm" id="myForm" method="post">
	   	    <input id="ChooseModName" name="ChooseModName" type="hidden" value="${modName}" />
			<input id="ChooseModId" name="ChooseModId" type="hidden" value="${modId}" />
			<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
  			<input name="objectId" id="objectId" type="hidden" value="${objectId}"/>
		  	<input name="attrName" id="attrName" type="hidden" value="${attrName}"/>
  			<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="hidden" value="${endpoint_Spec_Attr_Id}"/>
  			<input type="hidden" name="newState" id="newState" value="${newState}">
            <input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.code')}" />:
    				</dt>	
    				<dd >
    				   <ui:inputText skin="${contextStyleTheme}"  id="remoteCallUrlCode"  name="remoteCallInfo.remoteCallUrlCode"  value="" />
    				</dd>
    		</dl>
    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.url')}" />:
    				</dt>	
    				<dd >
    				   <ui:inputText skin="${contextStyleTheme}"  id="remoteCallUrl"  name="remoteCallInfo.remoteCallUrl"  value="" />
    				</dd>
    		</dl>
    		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>

	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="remoteCallInfoListId"  remoteSort="false" sortOrder="desc"  
			fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.remoteCallInfo.remoteCallInfoList')}"  striped="true"  fitHeight="368" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true"   toolbar="true" 
			method="eaap-op2-conf-remoteCallInfo-RemoteCallInfoAction.getRemoteCallInfoList">
			<ui:gridEasyColumn width="400" index="0" title="0" field="REMOTE_CALL_URL_CODE"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="400" index="1" title="1" field="REMOTE_CALL_URL"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="2" title="2" field="REMOTE_CALL_URL_STATUS"  hidden="true" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="3" title="3" field="REMOTE_CALL_URL_ID"  hidden="true" align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
</div>

<table class="mgr-table" style="display:none" id="confirm">
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseObj();"></ui:button>
	  	<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="$(window.parent.document).find('#closeButton').click();"></ui:button>
	 </td>	
   </tr>
</table>
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
$(document).ready(function(){
	var choosePageState=$("#choosePageState").attr('value');
    if(choosePageState!="") {
		document.getElementById("confirm").style.display= ""; 
		document.getElementById("pagePath").style.display= "none"; 
		document.getElementById("searchBarTitle").style.display= "none"; 		
    }
 })
 
function searchFunc() {
	var form = $("#myForm").form();
	$('#remoteCallInfoListId').datagrid("load", sy.serializeObject(form));
 }
 
function deleteMethod(){ 					
    if($('#remoteCallInfoListId').datagrid('getSelections')[0]==null)
	 {
	   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	 }else{
		  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />")){
				var remoteCallUrlId = $('#remoteCallInfoListId').datagrid('getSelections')[0].REMOTE_CALL_URL_ID ;
				window.location='${contextPath}/remoteCallInfo/delRemoteCallInfo.shtml?remoteCallInfo.remoteCallUrlId='+remoteCallUrlId;
			}
	 }
 }
		
function addMehtod(){
   window.location="${contextPath}/remoteCallInfo/editRemoteCallInfo.shtml";
} 
          
function updateMethod(){
    if($('#remoteCallInfoListId').datagrid('getSelections')[0]==null){
		alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	}else{
		var remoteCallUrlId = $('#remoteCallInfoListId').datagrid('getSelections')[0].REMOTE_CALL_URL_ID ;
		window.location='${contextPath}/remoteCallInfo/editRemoteCallInfo.shtml?remoteCallInfo.remoteCallUrlId='+remoteCallUrlId;
	}
}

function chooseObj(){
    var vOpener=art.dialog.opener;
    if ($('#remoteCallInfoListId').datagrid('getSelections')[0]==null) {
    	alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
    } else {
        var remoteCallUrlId		= $('#remoteCallInfoListId').datagrid('getSelections')[0].REMOTE_CALL_URL_ID+'';
    	var remoteCallUrlCode	= $('#remoteCallInfoListId').datagrid('getSelections')[0].REMOTE_CALL_URL_CODE+'';
    	var remoteCallUrl 			= $('#remoteCallInfoListId').datagrid('getSelections')[0].REMOTE_CALL_URL+'';
//     	if($("#chooseRemoteCallUrlId").attr('value')!=""){
// 		  	vOpener.document.getElementById($("#chooseRemoteCallUrlId").attr('value')).value=remoteCallUrlId;
// 		 }
// 		if($("#chooseRemoteCallUrlCode").attr('value')!="") {
// 			vOpener.document.getElementById($("#chooseRemoteCallUrlCode").attr('value')).value=remoteCallUrlCode;
// 		 }
// 		if($("#chooseRemoteCallUrl").attr('value')!="") {
// 			vOpener.document.getElementById($("#chooseRemoteCallUrl").attr('value')).value=remoteCallUrl;
// 		 }
    	var newState = document.getElementById("newState").value;
		if('new' == newState){
			window.parent.editorPropertyValue(document.getElementById("objectId").value,
					document.getElementById("endpoint_Spec_Attr_Id").value,
					document.getElementById("attrSpecCode").value,remoteCallUrlId);
			$(window.parent.document).find('#closeButton').click();
		}else{
			art.dialog.opener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,remoteCallUrlId, document.getElementById("objectId").value,document.getElementById("endpoint_Spec_Attr_Id").value);
			art.dialog.close();
		}
    }
 }
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
