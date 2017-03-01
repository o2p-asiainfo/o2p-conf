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
<style type="text/css">
.noBorder{
	border-collapse:collapse;
	border-width:0;
}
.noBorder td{
	border-collapse:collapse;
	border-width:0;
}
</style>
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
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testing')}"/>
      	</div>
    </div>
    
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
		 <ui:form id="testTaskinfo" action="../techimpl/addTechImpl.shtml" method="post">
		 	<table class="mgr-table">
		   		<tr>
		  			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}" />:</td>
		  			<td class="item-content" colspan="5">${testMsgInfoMap.TASK_NAME}</td>
		   		</tr>
				<tr>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.testMessageFlow')}" />:</td>
		   			<td class="item-content">${testMsgInfoMap.MESSAGE_FLOW_NAME}</td>	 
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.serInvokeInsName')}" />:</td>
		   			<td class="item-content">${testMsgInfoMap.SER_INVOKE_INS_NAME}</td>	 
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.requestComponent')}" />:</td>
		   			<td class="item-content">${testMsgInfoMap.COMPONENT_NAME}</td>	 
		   		</tr>
		    </table>
		 </ui:form>
		

<table  class="mgr-table">
	<tr>
		<td align="center" style="margin:0;padding:0;">
		<% int ii=0; %>
		<c:forEach items="${testSceneLists}" var="dataSet" varStatus="status"  step="1" >
		<% ii++; %>
		 	<table class="mgr-table"  style="margin:0;padding:0;">
				<tr>
		  			<td class="accordion-header" colspan="5" style="text-align:left;">
		  				<span style="font-weight:bold; font-size:14px;">
		  					<s:property value="%{getText('eaap.op2.conf.testPiles.endpoint')}" /><%= ii %> :
		  				</span>
		  				<span style="font-size:12px; margin-left:20px;">
			  				<b><s:property value="%{getText('eaap.op2.conf.testPiles.endpointName')}" />:</b>
			  					${dataSet.ENDPOINT_NAME}
		  					<c:if test="${dataSet.TECH_IMPL_NAME != null}">
			  					&nbsp;&nbsp;&nbsp;
			  					<b><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</b>
			  					${dataSet.TECH_IMPL_NAME}
			  					&nbsp;&nbsp;&nbsp;
			  					<b><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</b>
			  					${dataSet.COMPONENT_NAME}
			  					&nbsp;&nbsp;&nbsp;
			  					<b><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</b>
			  					${dataSet.COMM_PRO_NAME}
			  					&nbsp;&nbsp;&nbsp;
			  					<b>address :</b>
			  					${dataSet.ADDRESS}
		  					</c:if>
		  				</span>
		  			</td>
		   		</tr>
		  		<c:if test="${dataSet.TECH_IMPL_NAME != null}">
		  		<input type="hidden" name="tiEndpointId" value="${dataSet.ENDPOINT_ID}"/>
		   		<tr>
		   			<td class="item"  style="width:12%;text-align:left;"><s:property value="%{getText('eaap.op2.conf.testPiles.requestMessage')}" />:</td>
		   			<td class="item-content"  style="width:34%;text-align:right; padding-right:20px;">
		   				<a href="#"  onclick="document.getElementById('requestDoc_${dataSet.ENDPOINT_ID}').value=document.getElementById('requestMessageMod_${dataSet.ENDPOINT_ID}').value"><s:property value="%{getText('eaap.op2.conf.testPiles.loadFromTheTemplate')}" /></a>
		  				<!-- a href="#"  style="margin-left:20px"><s:property value="%{getText('eaap.op2.conf.testPiles.loadFromTheHistoricalRecord')}" />...</a -->
		   			</td>
		   			<td style="width:8%;"></td>
		  			<td class="item"  style="width:12%;text-align:left;"><s:property value="%{getText('eaap.op2.conf.testPiles.testResultsInfo')}" />:</td>
		   			<td class="item-content" style="width:34%;text-align:right; padding-right:20px;">&nbsp;</td>
		   		</tr>
		   		<tr>
		   			<td class="item-content"  colspan="2" style="padding:0;">
		   				<input  type="hidden" id="sceneId_${dataSet.ENDPOINT_ID}"  value="${dataSet.SCENE_ID}"/>
		   				<textarea id="requestMessageMod_${dataSet.ENDPOINT_ID}"  width="100%" height="1" style="display:none;" >${dataSet.REQUEST_MESSAGE_MOD}</textarea>
			   			<textarea id="requestDoc_${dataSet.ENDPOINT_ID}"  width="100%" height="250" style="width:99%; height:250px;" >${dataSet.REQUEST_MESSAGE}</textarea>
		   			</td>
		   			<td style="width:8%; text-align:center;">
      					<div id="loadingImg_${dataSet.ENDPOINT_ID}"  style="text-align:center; display:none;"><img  src="../resource/comm/images/loading.gif" /></div>
      					<div id="testingBut_${dataSet.ENDPOINT_ID}"  style="text-align:center;">
		   					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.testing')}"  onclick="javascript:testing(${dataSet.ENDPOINT_ID})"></ui:button>
		   				</div>
		   			</td>
		   			<td class="item-content"  colspan="2" style="padding:0;">
			   			<textarea id="responseDoc_${dataSet.ENDPOINT_ID}"  width="100%" height="250" style="width:99%; height:250px;" >${dataSet.RESPONSE_MESSAGE}</textarea>
		   			</td>
		   		</tr>
		  		</c:if>
		    </table>
		</c:forEach>

		</td>
	</tr>
    <tr>
		<td align="center">
				<table>
					<tr>
						<td id="saveTd" style="border-width:0; display:none;">
							<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.saveTestResult')}" id="saveId" onclick="javascript:saveTestResult()"></ui:button>
						</td>
						<td id="saveLoadingImg" style="border-width:0; display:none;">
							<img  src="../resource/comm/images/loading.gif" />
						</td>
						<td id="saveResultInfo" style="border-width:0; display:none;">
							<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.saveTestResult')}" id="saveId" onclick="javascript:saveTestResult()"></ui:button>
						</td>
						<td style="border-width:0;">
	  						<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.return')}" id="cancelId" onclick="location='${contextPath}/testPiles/testingList.shtml'"></ui:button>
						</td>
					</tr>
				</table>
		</td>
	</tr>
</table>
	 
		</div>
	</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</div>
<input type="hidden"  id="testId"  value="${testResult.testId}"/>
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
    	return value ;
	}
}

function formatterForOp(value,row,index){
	if(value!=null && value!=""){
    	return "<a href='#' onclick='openWindows(\"${contextPath}/testPiles/chooseScene.shtml?techImplId="+value+"\",\"Choose Test Scene\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.xuanze\")}' />...</a>" ;
	}
}

function testing(endpointId){
  	document.getElementById("saveTd").style.display="none";
	document.getElementById("saveLoadingImg").style.display="none";
	document.getElementById("saveResultInfo").style.display="none";

	document.getElementById("testingBut_"+endpointId).style.display="none";
	document.getElementById("loadingImg_"+endpointId).style.display="block";
	document.getElementById("responseDoc_"+endpointId).value="";

	var requestMsg = document.getElementById("requestDoc_"+endpointId).value;
	if(jQuery.trim(requestMsg) == ""){
		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleaseEnterRequestMsg')}" />");
		document.getElementById("loadingImg_"+endpointId).style.display="none";
		document.getElementById("testingBut_"+endpointId).style.display="block";
		return;
	}
   	var ajax_data = "endpointId="+endpointId+"&sceneId="+ document.getElementById("sceneId_"+endpointId).value +"&requestDoc="+ requestMsg;
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../testPiles/test.shtml",
	     dataType:"text",
	     data:ajax_data,
	     success:function(msg,data){
	     debugger;
		      if(msg=="failure"){
		      		document.getElementById("responseDoc_"+endpointId).value = "Failure!";
		      }else{
		      		document.getElementById("responseDoc_"+endpointId).value = msg;
		      }
				document.getElementById("loadingImg_"+endpointId).style.display="none";
				document.getElementById("testingBut_"+endpointId).style.display="block";
		      	document.getElementById("saveTd").style.display="block";
	   	  }
	});	
}

function saveTestResult(){
	document.getElementById("saveTd").style.display="none";
	document.getElementById("saveLoadingImg").style.display="block";
	var tiEndpoints= document.getElementsByName("tiEndpointId");
	for(var i=0; tiEndpoints.length>i; i++){
			var taskId = ${taskId};
			var endpointId = tiEndpoints[i].value;
			var testId = document.getElementById("testId").value;
			var requestMsg = document.getElementById("requestDoc_"+endpointId).value;
			var responseMsg = document.getElementById("responseDoc_"+endpointId).value;
		   	var ajax_data = "testId="+testId+"&taskId="+taskId+"&endpointId="+endpointId+"&requestMsg="+ requestMsg +"&responseMsg="+ responseMsg;
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../testPiles/saveTestResult.shtml",
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

function createFlow(){
	var testId = document.getElementById("testId").value;
	if(testId != ""){
		   	var ajax_data = "testId="+testId;
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

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
