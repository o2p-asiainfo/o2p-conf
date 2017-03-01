<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.modId')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}"/>';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.delayTime')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.testPiles.remark')}" />';
</script>

<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testMsgMod')}"/>
      	</div>
    </div>
    <div class="accordion-header" >
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
    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}" />:
    				</dt>	
    				<dd >
    				   <ui:inputText skin="${contextStyleTheme}"  id="modName"  name="testMsgMod.modName"  value="" />
    				</dd>
    		</dl>
    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}" />:
    				</dt>	
    				<dd >
    				   <ui:select skin="${contextStyleTheme}"  emptyOption="true" headerValue="" name="testMsgMod.msgFormatType" id="msgFormatType" 
    			       list="formatTypeList" listKey="key" listValue="value" style="width:70px;" ></ui:select>
    				</dd>
    		</dl>
    		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>

	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="testMsgModListId"  remoteSort="false" sortOrder="desc"  
			fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.testMsgModList')}"  striped="true"  fitHeight="368" pageSize="10" pagination="true" frozenColumns="true"  
			rownumbers="true"   toolbar="true" method="eaap-op2-conf-testPiles-TestPilesAction.getTestMsgModList">
			<ui:gridEasyColumn width="100" index="0" title="0" field="MOD_ID"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="1" title="1" field="MOD_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="2" title="2" field="MSG_FORMAT_TYPE"  hidden="false" formatter="true" formatterMethod="formatterForMsgType" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="400" index="3" title="3" field="DELAY_TIME"  hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="400" index="4" title="4" field="REMARK"  hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="5" title="5" field="PERSON_ID"  hidden="true" align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
</div>

<table class="mgr-table" style="display:none" id="confirm">
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseModel();"></ui:button>
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
	 </td>	
   </tr>
</table>
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
function searchFunc() {
   var form = $("#myForm").form();
      $('#testMsgModListId').datagrid("load", sy.serializeObject(form));
 }

function formatterForMsgType(value,row,index)
{
    if(value=='1')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.xml')}" />' ;
    }else if(value=='2')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.json')}" />' ;
    }
}

function deleteMethod(){ 					
    if($('#testMsgModListId').datagrid('getSelections')[0]==null)
	 {
	   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	 }else{
		  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
			{
			var tmpmodid = $('#testMsgModListId').datagrid('getSelections')[0].MOD_ID ;
			 
			window.location='${contextPath}/testPiles/delTestMsgMod.shtml?testMsgMod.modId='+tmpmodid;
			 
			}
	 }
 }
		
function addMehtod(){
   window.location="${contextPath}/testPiles/gotoEditTestMsgMod.shtml?editOrAdd=add";
} 
          
function updateMethod(){
   
    if($('#testMsgModListId').datagrid('getSelections')[0]==null)
	 {
	 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	 }else{
	    var tmpmodid = $('#testMsgModListId').datagrid('getSelections')[0].MOD_ID ;
		    $("#mycontentId").val(tmpmodid) ;
			$("#tmpTypeId").val('edit') ;
			window.location="${contextPath}/testPiles/gotoEditTestMsgMod.shtml?editOrAdd=edit&modId="+tmpmodid;
	 }
}

$(document).ready(function(){
	var choosePageState=$("#choosePageState").attr('value');
    if(choosePageState!="")
    {
   	 document.getElementById("confirm").style.display= ""; 
    }
 })

function chooseModel()
{
    var vOpener=art.dialog.opener;
    if ($('#testMsgModListId').datagrid('getSelections')[0]==null) {
    	alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
    } else {
        var chooseModId = $('#testMsgModListId').datagrid('getSelections')[0].MOD_ID ;
    	var chooseModName = $('#testMsgModListId').datagrid('getSelections')[0].MOD_NAME ;
    	
    	if($("#chooseModId").attr('value')!="")
		 {
		  	vOpener.document.getElementById($("#ChooseModId").attr('value')).value=chooseModId;
		 }
		if($("#chooseModName").attr('value')!="")
		 {
			vOpener.document.getElementById($("#ChooseModName").attr('value')).value=chooseModName;
		 }
		 	art.dialog.close(); 
    }
 }

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
