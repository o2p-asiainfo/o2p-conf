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
 
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.objType')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.objName')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.simulationServiceAddress')}"/>';
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
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testMsgModRela')}"/>
      	</div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
		</div>
    </div>
    
<div id="queryBlock">
<div class="formLayout" style="padding:5px 0;clear:both;">
<form name="myForm" id="myForm" method="post">
	<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}" />:
			</dt>	
			<dd >
			   <ui:inputText skin="${contextStyleTheme}"  id="modName"  name="modName"  value="" />
			</dd>
	</dl>
	<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.objName')}" />:
			</dt>	
			<dd >
			   <ui:inputText skin="${contextStyleTheme}"  id="objName"  name="objName"  value="" />
			</dd>
	</dl>
	<dl>
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.objType')}" />:
			</dt>	
			<dd>
			   <ui:select skin="${contextStyleTheme}"  emptyOption="true" headerValue="" name="objType" id="objType" 
		       list="objTypeList" listKey="key" listValue="value" style="width:70px;" ></ui:select>
			</dd>
	</dl>
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
    		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="testMsgModRelaListId"  remoteSort="false" sortOrder="desc"  
		fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.testMsgModRelaList')}"  striped="true"  fitHeight="368" pageSize="10" pagination="true" frozenColumns="true" 
		 rownumbers="true"   toolbar="true" method="eaap-op2-conf-testPiles-TestPilesAction.getTestMsgModRelaList">
		<ui:gridEasyColumn width="180" index="0" title="0" field="OBJ_TYPE"  hidden="false" formatter="true" formatterMethod="formatterForObjType"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="300" index="1" title="1" field="OBJ_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="300" index="2" title="2" field="MOD_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="390" index="3" title="3" field="ADDRESS"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="4" title="4" field="PERSON_ID"  hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="5" title="5" field="MOD_ID"  hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="6" title="6" field="OBJ_ID"  hidden="true" align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>
</div>

<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
function searchFunc() {
   var form = $("#myForm").form();
      $('#testMsgModRelaListId').datagrid("load", sy.serializeObject(form));
 }

function formatterForObjType(value,row,index)
{
    if(value=='0')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.service')}" />' ;
    }else if(value=='1')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.serInvokeIns')}" />' ;
    }
}

function deleteMethod(){ 					
    if($('#testMsgModRelaListId').datagrid('getSelections')[0]==null)
	 {
	   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	 }else{
		  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
			{
			var tmpmodid = $('#testMsgModRelaListId').datagrid('getSelections')[0].MOD_ID ;
			var tmpobjid = $('#testMsgModRelaListId').datagrid('getSelections')[0].OBJ_ID ;
			var tmpobjtype = $('#testMsgModRelaListId').datagrid('getSelections')[0].OBJ_TYPE ;
			 
			window.location='${contextPath}/testPiles/delTestMsgModRela.shtml?testMsgModRela.modId='
					+tmpmodid+'&testMsgModRela.objId='+tmpobjid+'&testMsgModRela.objType='+tmpobjtype;
			 
			}
	 }
 }
		
function addMehtod(){
   window.location="${contextPath}/testPiles/gotoEditTestMsgModRela.shtml";
} 
          
function updateMethod(){
   
}

$(document).ready(function(){
	  $('#btncut').text("");
});

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
