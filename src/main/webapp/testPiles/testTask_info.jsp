<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testTask')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.type')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.name')}"/>';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.forTestingMod')}"/>';
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
		 <ui:form id="myForm" name="myForm" action="saveTestTaskData.shtml" method="post"> 
	  		<input id="taskId" name="TestTask.taskId" type="hidden" value="${testTask.taskId}" />	
	  		<input id="procId" name="TestTask.procId" type="hidden" value="${testTask.procId}" />	
	  		<input id="editOrAdd" name="editOrAdd" type="hidden" value="${editOrAdd}" />
			<ui:validators validateAlert="word" validatorGroup="group1"> 
				<ui:validator fieldId="taskName" validatorType="stringlength" minLength="1" maxLength="100" message="%{getText('eaap.op2.conf.testPiles.notexceed100char')}"/>
				<ui:validator fieldId="taskName" validatorType="requiredstring" message="%{getText('eaap.op2.conf.testPiles.taskName')} %{getText('eaap.op2.conf.testPiles.notNull')}"/>
				<ui:validator fieldId="sceneName" validatorType="requiredstring" message="%{getText('eaap.op2.conf.testPiles.forTestingScene')} %{getText('eaap.op2.conf.testPiles.notNull')}"/>
				<ui:validator fieldId="testUserName" validatorType="requiredstring" message="%{getText('eaap.op2.conf.testPiles.tester')} %{getText('eaap.op2.conf.testPiles.notNull')}"/>
			</ui:validators>
		 	<table class="mgr-table">
				<tr>
		  			<td class="item" style="width:20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}" />:</td>
		  			<td class="item-content" style="width:80%;"> 
			  		    <ui:inputText skin="${contextStyleTheme}"  id="taskName"  name="TestTask.taskName"  value="${testTask.taskName}" style="width:650px;"/>
			  		</td>
		   		</tr>
				<tr>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.forTestingScene')}" />:</td>
		  			<td class="item-content" > 
		   				<span style="float:left;">
			  		    	<textarea skin="${contextStyleTheme}"  id="sceneName"  name="TestScene.sceneName"  readonly="true"  style="width:650px;height:50px;">${testScene.sceneName}</textarea>
	  						<input id="sceneId" name="TestScene.sceneId"  type="hidden"  value="${testScene.sceneId}" />	
		   				</span>
		   				<span style="float:left; margin-left:5px; margin-top:27px;">
				  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.xuanze')}..."  id="sceneNameBut" onclick="selectScene()" shape="s"></ui:button>
		   				</span>
		   			</td>
		   		</tr>
				<tr>
		  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />:</td>
		  			<td class="item-content" > 
		   				<span style="float:left;">
			  		    	<textarea skin="${contextStyleTheme}"  id="testUserName" name="testUserName"  readonly="true"  style="width:650px;height:50px;">${testUserNames}</textarea>
	  						<input id="testUserId" name="testUserId" type="hidden" value="${testUserIds}" />	
		   				</span>
		   				<span style="float:left; margin-left:5px; margin-top:27px;">
				  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.xuanze')}..." onclick="selectUser()" shape="s"></ui:button>
		   				</span>
		   			</td>
		   		</tr>
				<tr>
		  			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.remark')}" />:</td>
		  			<td class="item-content" > 
		   				<span style="float:left;">
			  		    	<ui:textarea skin="${contextStyleTheme}"  id="remark" name="TestTask.remark" width="650" height="50"  value="${testTask.remark}" />
		   				</span>
		   			</td>
		   		</tr>
		    </table>
		 </ui:form>

	</div>
</div>

<table  class="mgr-table">
    <tr>
		<td  colspan="4"  align="center">
			<c:if test="${TestTask.procId == null}">
		  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.save')}" id="saveBut" onclick="saveTestTaskData()"></ui:button>
		 	</c:if>
		  	<c:if test="${TestTask.taskId != null && TestTask.procId == null}">
 		  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.createFlow')}"  id="createFlowId" onclick="createFlow()"></ui:button>
 		  	</c:if>
		  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.return')}" id="cancelId" onclick="location='${contextPath}/testPiles/testTask.shtml'"></ui:button>
		</td>
	</tr>
</table>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<input id="objId" name="objId" type="hidden" />	
</div>
</body>
<script>

function saveTestTaskData(){
	  	if(!comm_validators_check('group1')){
			return;	
		}
		if(jQuery.trim($("#testUserName").val()) == ""){
			$("#testUserName").focus();
			$("#testUserName").css({
	             "border": "2px solid #ff0000"
	        });
			return;
		}else{
			$("#testUserName").css({
	             "border": ""
	        });
		}
		var taskName = jQuery.trim($("#taskName").val());
		var remark = jQuery.trim($("#remark").val());
		var sceneId = $("#sceneId").val();
		var testUserId = $("#testUserId").val();
		var taskId = $("#taskId").val();
		$.ajax({
		     type:"post",
		     async:false,
		     url:"../testPiles/saveTestTaskData.shtml",
		     dataType:"text",
		     data:"taskName="+taskName+"&testUserId="+testUserId+"&sceneId="+sceneId+"&remark="+remark+"&taskId="+taskId,
		     success:function(msg,data){
					try { 
				      		var jsonObj = eval('(' + msg + ')'); 
				      		var taskId = jsonObj[0].taskId;
					      	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveSuccess')}" />");
		    				window.location="${contextPath}/testPiles/testTaskInfo.shtml?editOrAdd=edit&taskId="+taskId;
					} catch (e) { 
				      		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
					}
		   	  }
		});	
}

function saveTestTaskData_2(){
  	if(!comm_validators_check('group1')){
		return;	
	}
	if(jQuery.trim($("#testUserName").val()) == ""){
		$("#testUserName").focus();
		$("#testUserName").css({
             "border": "2px solid #ff0000"
        });
		return;
	}else{
		$("#testUserName").css({
             "border": ""
        });
	}
	
	var form = document.getElementById("myForm");
	form.action="saveTestTaskData.shtml";
	form.submit();	
}

function selectUser(){
	var userIdStr = document.getElementById("testUserId").value;
	var userNameStr = document.getElementById("testUserName").value;
	openWindows('${contextPath}/testPiles/chooseTester.shtml?testUserIdInput=testUserId&testUserNameInput=testUserName&testUserIds='+userIdStr+'&testUserNames='+userNameStr,'Choose Tester');
}

function selectScene(){
	openWindows('${contextPath}/testPiles/chooseTestScene.shtml?sceneIdInput=sceneId&sceneNameInput=sceneName','Choose The Test Scene');
}


function createFlow(){
  	if(!comm_validators_check('group1')){
		return;	
	}
	var taskId = $("#taskId").val();
	if(taskId != ""){
		   	var ajax_data = "taskId="+taskId;
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../testPiles/createFlow.shtml",
			     dataType:"text",
			     data:ajax_data,
			     success:function(msg,data){
						try { 
				      		var jsonObj = eval('(' + msg + ')'); 
				      		var taskId = jsonObj[0].taskId;
					      	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.taskAllocationSuccess')}" />");
		    				window.location="${contextPath}/testPiles/testTaskInfo.shtml?editOrAdd=edit&taskId="+taskId;
						} catch (e) { 
					      	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.taskAllocationFailed')}" />");
						}
		   	  	}
			});	
	}
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
