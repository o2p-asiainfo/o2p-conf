<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}"/>';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.testDate')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.testPiles.state')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.testPiles.testing')}" />';
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
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testing')}"/>
      	</div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
		</div>
    </div>
    
<div class="formLayout" style="padding:5px 0;">
<ui:form name="myForm" id="myForm" method="post">
	<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}" />:
			</dt>	
			<dd >
			   <ui:inputText skin="${contextStyleTheme}"  id="taskName"  name="taskName"  value="" />
			</dd>
	</dl>
	<dl>		
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}" />:
			</dt>
			<dd >
				<ui:inputText skin="${contextStyleTheme}"  id="sceneName"   name="sceneName"  value="" />
			</dd>
	</dl>
	<c:if test="${personId ==null}">
   		<dl>
   				<dt>
   					<s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />:
   				</dt>
   				<dd>
   					<ui:inputText skin="${contextStyleTheme}"  id="testUserName"   name="testUserName"  value="" />
   				</dd>
   		</dl>
  	</c:if>
	 <div style="text-align:right; margin:0 10px 10px 0px ; float:right;">
		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
	 </div>
</ui:form>
</div>
<div style="clear:both;"> 
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"  id="testingList"  remoteSort="false" sortOrder="desc"  
		fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.taskList')}"  fitHeight="337"  striped="true" pageSize="10" pagination="true" frozenColumns="true" 
		rownumbers="true"   method="eaap-op2-conf-testPiles-TestPilesAction.queryTestTestingList">
		<ui:gridEasyColumn width="250" index="0" title="0" field="TASK_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="1" title="1" field="SCENE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="150" index="2" title="2" field="TEST_USER_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="130" index="3" title="3" field="TEST_DATE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="110" index="4" title="4" field="STATE" hidden="false" align="center" formatter="true" formatterMethod="formatterForState" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="90"   index="5" title="5" field="TASK_ID" hidden="false" formatter="true" formatterMethod="formatterForOp"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="6" title="6" field="TEST_ID" hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="7" title="7" field="LOG_COUNT" hidden="true" align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
function searchFunc() {
	var form = $("#myForm").form();
	$("#testingList").datagrid("load", sy.serializeObject(form));
 }	
 
function formatterForState(value,row,index){
	if(row.LOG_COUNT!=null && row.LOG_COUNT!="" && row.LOG_COUNT>0){ 
		return "<s:property value="%{getText('eaap.op2.conf.testPiles.isTest')}" />" ;
	}else{
		return "<s:property value="%{getText('eaap.op2.conf.testPiles.noTest')}" />" ;
	}
}

function formatterForOp(value,row,index){
	if(row.LOG_COUNT!=null && row.LOG_COUNT!="" && row.LOG_COUNT>0){ 
		return "<a href='${contextPath}/testPiles/testing.shtml?testId="+row.TEST_ID+"'><s:property value="%{getText('eaap.op2.conf.testPiles.testAgain')}" />...</a>" ;
	}else{
		return "<a href='${contextPath}/testPiles/testing.shtml?testId="+row.TEST_ID+"'><s:property value="%{getText('eaap.op2.conf.testPiles.opTesting')}" />...</a>" ;
	}
}
 
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>