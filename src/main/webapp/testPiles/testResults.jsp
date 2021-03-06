<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testResults')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
 
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}"/>';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.testDate')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.testPiles.xiangqing')}" />';
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
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testResults')}"/>
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
    		<!-- dc style="width:355px;">		
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.testPiles.testTime')}" />:
    				</dt>
    				<dd >
    					<input class="input-text" size="15"  type="text" name="test_time"  style="width:70px;"/>~<input class="input-text" size="15"  type="text" name="test_time"  style="width:70px;"/>
    				</dd>
    		</dc -->
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
	 </div>
</ui:form>
</div>
<div style="clear:both;"> 
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"  id="testingList"  remoteSort="false" sortOrder="desc"  
		fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.taskList')}"  fitHeight="337"  striped="true" pageSize="10" pagination="true" frozenColumns="true" 
		rownumbers="true"   method="eaap-op2-conf-testPiles-TestPilesAction.getTestResultsList">
		<ui:gridEasyColumn width="400" index="0" title="0" field="TASK_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="250" index="1" title="1" field="SCENE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="150" index="2" title="2" field="TEST_USER_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="150" index="3" title="3" field="TEST_DATE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="90"   index="4" title="4" field="LOG_ID" hidden="false" formatter="true" formatterMethod="formatterForOp"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="5" title="5" field="TASK_ID" hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="6" title="6" field="TEST_ID" hidden="true" align="center"></ui:gridEasyColumn>
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
 
function formatterForOp(value,row,index){
	return "<a href='${contextPath}/testPiles/testResultInfo.shtml?logId="+row.LOG_ID+"'><s:property value="%{getText('eaap.op2.conf.testPiles.xiangqing')}" />...</a>" ;
}
 
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>