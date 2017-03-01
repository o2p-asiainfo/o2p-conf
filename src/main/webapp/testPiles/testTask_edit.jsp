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
		 <ui:form id="testTaskAddForm" action="../testPiles/testTaskEditUpdate.shtml" method="post">
	  		<input id="serInvokeInsId" name="TestTask.serInvokeInsId" type="hidden" value="${serInvokeInsMap.SER_INVOKE_INS_ID}" />	
	  		<input id="taskId" name="TestTask.taskId" type="hidden" value="${TestTask.taskId}" />	
		 	<table class="mgr-table">
				<tr>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}" />:</td>
		  			<td class="item-content" colspan="3" > 
			  		    <input type="text" name="TestTask.taskName" id="taskName" value="${testTask.taskName}"  style="width:653px;"/>
		   			</td>
		   		</tr>
				<tr>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />:</td>
		  			<td class="item-content" colspan="3" > 
		   				<span style="float:left;">
			  		    	<ui:textarea skin="${contextStyleTheme}"  id="testUserName" name="TestTask.testUserName" width="650" height="50"  value="${testTask.testUserName}" />
	  						<input id="testUserId" name="TestTask.testUserId" type="hidden" value="${testTask.testUserId}" />	
		   				</span>
		   				<span style="float:left; margin-left:5px;">
				  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.xuanze')}..." onclick="selectUser()" shape="s"></ui:button>
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
		
			<dl class="noBorder">
				<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code"  singleSelect="true"  id="testTaskListId"  remoteSort="false" sortOrder="desc"  queryParams="true"  queryParamsData="[{FIRST_ENDPOINT_ID=${serInvokeInsMap.FIRST_ENDPOINT_ID},TASK_ID=${TestTask.taskId}}]"  
					fit="true" collapsible="true"  title="%{getText('eaap.op2.conf.testPiles.endpointList')}"  fitHeight="200"  striped="true" pageSize="10" pagination="true"  rownumbers="true"   method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneListByTaskId">
					<ui:gridEasyColumn width="220" index="0" title="0" field="ENDPOINT_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="220" index="1" title="1" field="TECH_IMPL_NAME" hidden="false" align="center"  formatter="true" formatterMethod="formatterForTechImplName"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="220" index="2" title="2" field="SCENE_NAME" hidden="false" align="center"  formatter="true" formatterMethod="formatterForSceneName" ></ui:gridEasyColumn>
					<ui:gridEasyColumn width="1" index="3" title="3" field="TECH_IMPL_ID" hidden="true" align="center" ></ui:gridEasyColumn>
					<ui:gridEasyColumn width="1" index="4" title="4" field="ENDPOINT_ID" hidden="true" align="center"></ui:gridEasyColumn>
				</ui:gridEasy>
			</dl>
		</div>
	</div>

 	<table  class="mgr-table">
 		    <tr>
 				<td  colspan="4"  align="center">
				  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.save')}" id="saveBut" onclick="javascript:document.testTaskAddForm.submit();"></ui:button>
 				  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.createFlow')}"  id="createFlowId" onclick="javascript:createFlow()"></ui:button>
				  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.return')}" id="cancelId" onclick="location='${contextPath}/testPiles/testTask.shtml'"></ui:button>
				</td>
 			</tr>
	</table>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</div>
<input type="hidden" id="taskId" value="${TestTask.taskId}" />
</body>
<script>
$(document).ready(function() {
	document.getElementById("testUserName").readOnly=true;
});

function searchFunc() {
   var form = $("#myForm").form();
      $('#testTaskListId').datagrid("load", sy.serializeObject(form));
 }	

function formatterForSceneName(value,row,index){
    var taskId = "${TestTask.taskId}";
    var endpointId = row.ENDPOINT_ID;
	if(row.TECH_IMPL_ID!=null && row.TECH_IMPL_ID!=""){
		if(value==null || value==""){
    		return "<a href='#' onclick='openWindows(\"${contextPath}/testPiles/chooseScene.shtml?techImplId="+row.TECH_IMPL_ID+"&TestTaskScene.endpointId="+endpointId+"&TestTaskScene.taskId="+taskId+"\",\"Choose Test Scene\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.xuanze\")}' />...</a>" ;
    	}else{
	    	return value + " <a href='#' onclick='openWindows(\"${contextPath}/testPiles/chooseScene.shtml?techImplId="+row.TECH_IMPL_ID+"&TestTaskScene.endpointId="+endpointId+"&TestTaskScene.taskId="+taskId+"\",\"Choose Test Scene\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.change\")}' />...</a>"; 
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
function reloadList(){
	$('#testTaskListId').datagrid('reload');
}


function createFlow(){
    var taskId = "${TestTask.taskId}";
	if(taskId != ""){
		   	var ajax_data = "taskId="+taskId;
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../testPiles/createFlow.shtml",
			     dataType:"text",
			     data:ajax_data,
			     success:function(msg,data){
				      if(msg=="failure"){
		      				document.getElementById("saveTd").style.display="block";
							document.getElementById("saveLoadingImg").style.display="none";
							document.getElementById("saveResultInfo").innerText="<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />";
							document.getElementById("saveResultInfo").style.display="block";
				      }else{
				      		var jsonObj = eval('(' + msg + ')'); 
				      		var testId = jsonObj[0].data;
		      				document.getElementById("testId").value = testId;
		      				document.getElementById("saveTd").style.display="none";
							document.getElementById("saveLoadingImg").style.display="none";
							document.getElementById("saveResultInfo").innerText="<s:property value="%{getText('eaap.op2.conf.testPiles.saveSuccess')}" />";
							document.getElementById("saveResultInfo").style.display="block";
				      }
			   	  }
			});	
	}
}

function selectUser(){
	var userIdStr = document.getElementById("testUserId").value;
	var userNameStr = document.getElementById("testUserName").value;
	openWindows('${contextPath}/testPiles/chooseTester.shtml?testUserIdInput=testUserId&testUserNameInput=testUserName&testUserIds='+userIdStr+'&testUserNames='+userNameStr,'Choose Tester');
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
