<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testTask')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/> 
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

<script>
var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.endpointName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.forTestingScene')}"/>';
</script>

</head>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.testPiles.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testTask')}"/>
      	</div>
    </div>
    
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
		 <ui:form id="testTaskAddForm" action="../testPiles/testTaskAddInsert.shtml" method="post">
	  		<input id="serInvokeInsId" name="TestTask.serInvokeInsId" type="hidden" value="${serInvokeInsMap.SER_INVOKE_INS_ID}" />	
	  		<input id="taskId" name="TestTask.taskId" type="hidden" value="${TestTask.taskId}" />	
		 	<table class="mgr-table">
				<tr>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}" />:</td>
		  			<td class="item-content" colspan="3" > 
			  		    <input type="text" name="TestTask.taskName" id="taskName" value="${serInvokeInsMap.SER_INVOKE_INS_NAME} <s:property value="%{getText('eaap.op2.conf.testPiles.test')}" />"  style="width:350px;"/>
		   			</td>
		   		</tr>
				<tr>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />:</td>
		  			<td class="item-content" colspan="3" > 
		   				<span style="float:left;">
			  		    	<ui:textarea skin="${contextStyleTheme}"  id="personNames" name="" width="650" height="50" value=""/>
	  						<input id="personIds" name="personIds" type="hidden" value="" />	
		   				</span>
		   				<span style="float:left; margin-left:5px;">
		   					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.xuanze')}..."   shape="s"   onclick="" ></ui:button>
		   				</span>
		   			</td>
		   		</tr>
		   		
				<tr>
		  			<td class="module-path-content"  colspan="4"  style="text-align:center;font-weight:bold;"> 	
		  			<s:property value="%{getText('eaap.op2.conf.testPiles.forTestingSerInvokeInsInfo')}" />
		   			</td>	 
		   		</tr>
				<tr>
		  			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.serInvokeInsName')}" />:</td>
		  			<td class="item-content"> 
		  		    <div class="ui-widget"> 
		  				<div class="ui-widget">	  
		  					${serInvokeInsMap.SER_INVOKE_INS_NAME}
		  				</div>
	 		        </div>
		   			</td>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
		   			<td class="item-content">
		  				<div class="ui-widget">
		  					${serInvokeInsMap.COMPNAME}
		  				</div> 	
		   			</td>	 
		   		</tr>
				<tr>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.serviceName')}" />:</td>
		   			<td class="item-content">
		  				<div class="ui-widget">
		  					${serInvokeInsMap.SERNAME}
		  				</div>
		   			</td>
		  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
		  			<td class="item-content">
		  		    <div class="ui-widget">
		  				<div class="ui-widget">
		  					${serInvokeInsMap.ORGNAME}
		  				</div>
	 		        </div>
		   			</td>
		   		</tr>
		    </table>
		 </ui:form>
		
			<!-- dl class="noBorder">
				<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code"  singleSelect="true"  id="testTaskListId"  remoteSort="false" sortOrder="desc"  queryParams="true"  queryParamsData="${serInvokeInsMap.FIRST_ENDPOINT_ID}"
					fit="true" collapsible="true"  title="%{getText('eaap.op2.conf.testPiles.endpointList')}"  fitHeight="200"  striped="true" pageSize="10" pagination="true"  rownumbers="true"   method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneListByTaskId">
					<ui:gridEasyColumn width="220" index="0" title="0" field="ENDPOINT_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="220" index="1" title="1" field="TECH_IMPL_NAME" hidden="false" align="center"  formatter="true" formatterMethod="formatterForTechImplName"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="220" index="2" title="2" field="SCENE_NAME" hidden="false" align="center"  formatter="true" formatterMethod="formatterForSceneName" ></ui:gridEasyColumn>
					<ui:gridEasyColumn width="1" index="3" title="3" field="TECH_IMPL_ID" hidden="true" align="center" ></ui:gridEasyColumn>
					<ui:gridEasyColumn width="1" index="4" title="4" field="ENDPOINT_ID" hidden="true" align="center"></ui:gridEasyColumn>
				</ui:gridEasy>
			</dl -->
		</div>
	</div>

    	  <table  class="mgr-table">
    		    <tr>
    				<td  colspan="4"  align="center">
 						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.server.supplier.next')}" id="saveBut" onclick="javascript:document.testTaskAddForm.submit();"></ui:button>
 						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}" id="cancelId" onclick="location='${contextPath}/testPiles/testTask.shtml'"></ui:button>
    				</td>
    			</tr>
    		 </table>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</div>
</body>
<script>
function searchFunc() {
   var form = $("#myForm").form();
      $('#testTaskListId').datagrid("load", sy.serializeObject(form));
 }	

function formatterForSceneName(value,row,index){
	if(row.TECH_IMPL_ID!=null && row.TECH_IMPL_ID!=""){
		if(value==null || value==""){
    		//return "<s:property value='%{getText(\"eaap.op2.conf.testPiles.qingxuanze\")}' />" ;
    		return "<a href='#' onclick='openWindows(\"${contextPath}/testPiles/chooseScene.shtml?techImplId="+row.TECH_IMPL_ID+"\",\"Choose Test Scene\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.xuanze\")}' />...</a>" ;
    	}else{
	    	return value ;
		}
	}else{
    	return "<font style='color:#ccc;'>--</font>" ;
	}
}

function formatterForTechImplName(value,row,index){
	if(row.TECH_IMPL_ID==null || row.TECH_IMPL_ID==""){
    	return "<font style='color:#ccc;'>--</font>" ;
	}else{
		return value ;
	}
}

function formatterForOp(value,row,index){
	if(value!=null && value!=""){
    	return "<a href='#' onclick='openWindows(\"${contextPath}/testPiles/chooseScene.shtml?techImplId="+value+"\",\"Choose Test Scene\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.xuanze\")}' />...</a>" ;
	}
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
