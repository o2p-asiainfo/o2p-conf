<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testing')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>


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
		 	<table class="mgr-table">
				<tr>
		  			<td class="item" style="width:15%;"><s:property value="%{getText('eaap.op2.conf.testPiles.taskName')}" />:</td>
		  			<td class="item-content" style="width:35%;"> 
			  		    ${testResultInfoMap.TASK_NAME}
		   			</td>
		  			<td class="item" style="width:15%;"><s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}" />:</td>
		  			<td class="item-content" style="width:35%;"> 
			  		    ${testResultInfoMap.SCENE_NAME}
		   			</td>
		   		</tr>
				<tr>
		  			<td class="item" style="width:15%;"><s:property value="%{getText('eaap.op2.conf.testPiles.remark')}" />:</td>
		  			<td class="item-content" style="width:35%;" colspan="3"> 
		   				${testResultInfoMap.REMARK}
		   			</td>
		   		</tr>
		    </table>
		 	<table class="mgr-table">
				<tr>
		  			<td class="item" style="width:15%;"><s:property value="%{getText('eaap.op2.conf.testPiles.tester')}" />:</td>
		  			<td class="item-content" style="width:35%;"> 
			  		    ${testResultInfoMap.TEST_USER_NAME}
		   			</td>
		  			<td class="item" style="width:15%;"><s:property value="%{getText('eaap.op2.conf.testPiles.testDate')}" />:</td>
		  			<td class="item-content" style="width:35%;"> 
		   				${testResultInfoMap.TEST_DATE}
		   			</td>
		   		</tr>
		    </table>
	</div>
</div>

<table  class="mgr-table">
	<tr>
		<td align="center" style="margin:0;padding:0;">
		
		<% int ii=0; %>
		<c:forEach items="${testResultSceneObjList}" var="dataSet" varStatus="status"  step="1" >
		<% ii++; %>
		 	<table class="mgr-table"  style="margin:0;padding:0;">
				<tr>
		  			<td class="accordion-header" colspan="5" style="text-align:left;">
		  				<div style="font-weight:bold; font-size:14px;">
		  					<%= ii %>. ${dataSet.OBJ_NAME} 
		  				</div>
		  				<div style="font-size:12px; margin-left:20px;">
			  					<c:if test="${dataSet.OBJ_TYPE == 0}">
			  						<b><s:property value="%{getText('eaap.op2.conf.testPiles.type')}" />:</b>
			  						<s:property value="%{getText('eaap.op2.conf.testPiles.service')}" />
			  						&nbsp;&nbsp;&nbsp;
			  						<b><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</b>
			  						${dataSet.ORG_NAME}
			  						&nbsp;&nbsp;&nbsp;
			  						<b><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</b>
			  						${dataSet.COMPONENT_NAME}
			  						&nbsp;&nbsp;&nbsp;
			  						<b><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</b>
			  						${dataSet.TECH_IMPL_NAME}
			  						&nbsp;&nbsp;&nbsp;
			  						<b><s:property value="%{getText('eaap.op2.conf.testPiles.protocalType')}" />:</b>
			  						${dataSet.COMM_PRO_NAME}
		  						</c:if>
			  					<c:if test="${dataSet.OBJ_TYPE == 1}">
			  						<b><s:property value="%{getText('eaap.op2.conf.testPiles.type')}" />:</b>
			  						<s:property value="%{getText('eaap.op2.conf.testPiles.serInvokeIns')}" />
		  						</c:if>
		  						
		  						&nbsp;&nbsp;&nbsp;
		  						<b>address:</b>
		  						${dataSet.ADDRESS}
		  				</div>
		  			</td>
		   		</tr>
		   		<tr>
		   			<td class="item"  style="width:12%;text-align:left;"><s:property value="%{getText('eaap.op2.conf.testPiles.requestMessage')}" />:</td>
		   			<td class="item-content"  style="width:34%;text-align:right; padding-right:20px;">
		   				<span onclick="loadMsgMod(${dataSet.RELA_ID})" style="color:#00F; cursor:pointer;" onmouseover="this.style.color='#F00';" onmouseout="this.style.color='#00F';">
		   					<s:property value="%{getText('eaap.op2.conf.testPiles.loadFromTheTemplate')}" />
		   				</span>
		   			</td>
		   			<td style="width:8%;"></td>
		  			<td class="item"  style="width:12%;text-align:left;"><s:property value="%{getText('eaap.op2.conf.testPiles.testResultsInfo')}" />:</td>
		   			<td class="item-content" style="width:34%;text-align:right; padding-right:20px;">&nbsp;</td>
		   		</tr>
		   		<tr>
		   			<td class="item-content"  colspan="2" style="width:46%;padding:0;">
		   				<textarea id="requestMsgMod_${dataSet.RELA_ID}"  width="100%" height="1" style="display:none;" >${dataSet.REQUEST_MSG_MOD}</textarea>
			   			<textarea id="requestDoc_${dataSet.RELA_ID}"  width="100%" height="250" style="width:99%; height:250px; word-break:break-all;">${dataSet.REQUEST_MSG}</textarea>
		   			</td>
		   			<td style="width:8%; text-align:center;">
      					<div id="loadingImg_${dataSet.RELA_ID}"  style="text-align:center; display:none;"><img  src="../resource/comm/images/loading.gif" /></div>
      					<div id="testingBut_${dataSet.RELA_ID}"  style="text-align:center;">
		   					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.testing')}"  onclick="javascript:testSingle(${dataSet.RELA_ID})"></ui:button>
		   				</div>
		   			</td>
		   			<td class="item-content"  colspan="2" style="width:46%;padding:0;">
			   			<textarea id="responseDoc_${dataSet.RELA_ID}"  width="100%" height="250" style="width:99%; height:250px; word-break:break-all;">${dataSet.RESPONSE_MSG}</textarea>
		   			</td>
		   		</tr>
		    </table>
	  		<input type="hidden"  name="vRelaId"  value="${dataSet.RELA_ID}"/>
	   		<input type="hidden"  id="modId_${dataSet.RELA_ID}"  	value="${dataSet.MOD_ID}"/>
	   		<input type="hidden"  id="objId_${dataSet.RELA_ID}"		value="${dataSet.OBJ_ID}"/>
	   		<input type="hidden"  id="objType_${dataSet.RELA_ID}" value="${dataSet.OBJ_TYPE}"/>
	   		<input type="hidden"  id="sceneId_${dataSet.RELA_ID}" 	value="${dataSet.SCENE_ID}"/>
	   		<input type="hidden"  id="taskId_${dataSet.RELA_ID}" 	value="${dataSet.TASK_ID}"/>
	   		<input type="hidden"  id="commProName_${dataSet.RELA_ID}"  value="${dataSet.COMM_PRO_NAME}"/>
	   		<input type="hidden"  id="address_${dataSet.RELA_ID}"  value="${dataSet.ADDRESS}"/>
		</c:forEach>

		</td>
	</tr>
    <tr>
		<td align="center" >
				<table>
					<tr>
						<td id="testingBut" style="border-width:0;">
							<c:choose>
							       <c:when test="${testResultInfoMap.LOG_ID != null }">
											<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.testAgain')}"  onclick="testExe()"></ui:button>
							       </c:when>
							       <c:otherwise>
											<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.opTesting')}"  onclick="testExe()"></ui:button>
							       </c:otherwise>
							</c:choose>
						</td>
						<td id="loadingImg" style="border-width:0; display:none;"><img  src="../resource/comm/images/loading.gif" /></td>
						<td id="saveResultInfo" style="border-width:0; display:none;"></td>
						<td style="border-width:0;">
	  						<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.return')}" id="cancelId" onclick="location='${contextPath}/testPiles/testingList.shtml'"></ui:button>
						</td>
					</tr>
				</table>
		</td>
	</tr>
</table>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<input id="logId" name="logId" type="hidden"  value="${testResultInfoMap.LOG_ID}"/>	
</div>
</body>
<script>
$(document).ready(function(){
})

var testId = ${testId};

function loadMsgMod(relaId){
	 var requestMsgMod = $("#requestMsgMod_"+relaId).val();
	 $("#requestDoc_"+relaId).val(requestMsgMod)
}

function testSingle(relaId){
	$("#testingBut_"+relaId).hide();
	$("#loadingImg_"+relaId).show();
	$("#responseDoc_"+relaId).val(null);

	var requestMsg = $("#requestDoc_"+relaId).val();
	if(jQuery.trim(requestMsg) == ""){
		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleaseEnterRequestMsg')}" />");
		$("#testingBut_"+relaId).show();
		$("#loadingImg_"+relaId).hide();
		$("#requestDoc_"+relaId).focus();
		return;
	}

	var logId	=	$("#logId").val();
	if(logId ==""){
		logId = getLogId();
	}
	var requestMsg			=	$("#requestDoc_"+relaId).val();
	var modId					=	$("#modId_"+relaId).val();
	var objId						=	$("#objId_"+relaId).val();
	var objType				=	$("#objType_"+relaId).val();
	var sceneId					=	$("#sceneId_"+relaId).val();
	var taskId					=	$("#taskId_"+relaId).val();
	var commProName	=$("#commProName_"+relaId).val();
	var address 				=$("#address_"+relaId).val();
   	var ajax_data = "logId="+logId+"&testId="+testId+"&relaId="+relaId+"&modId="+ modId +"&requestDoc="+ requestMsg+"&address="+address
   							+"&objId="+ objId+"&objType="+ objType+"&sceneId="+ sceneId+"&taskId="+ taskId+"&commProName="+ commProName;
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../testPiles/testExe.shtml",
	     dataType:"text",
	     data:ajax_data,
	     success:function(msg,data){
				if(msg=="failure"){
			   		$("#responseDoc_"+relaId).val("Failure!");
				}else{
			   		$("#responseDoc_"+relaId).val(msg);
				}
				$("#testingBut_"+relaId).show();
				$("#loadingImg_"+relaId).hide();
	   	  }
	});	
}

function testExe(){
	getLogId();
	var vRelaIds= $("input[name='vRelaId']");
	for(var i=0; vRelaIds.length>i; i++){
		var relaId = vRelaIds[i].value;
		var requestMsg = $("#requestDoc_"+relaId).val();
		if(jQuery.trim(requestMsg) == ""){
			alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleaseEnterRequestMsg')}" />");
			$("#requestDoc_"+relaId).focus();
			return;
		}
	}
	
	var logId=$("#logId").val();
	if(logId ==""){
		logId = getLogId();
	}
	
	$("#loadingImg").show();
	$("#testingBut").hide();
		
	for(var i=0; vRelaIds.length>i; i++){
		var relaId = vRelaIds[i].value;
		$("#responseDoc_"+relaId).val("");
		var requestMsg			=	$("#requestDoc_"+relaId).val();
		var modId					=	$("#modId_"+relaId).val();
		var objId						=	$("#objId_"+relaId).val();
		var objType				=	$("#objType_"+relaId).val();
		var sceneId					=	$("#sceneId_"+relaId).val();
		var taskId					=	$("#taskId_"+relaId).val();
		var commProName	=$("#commProName_"+relaId).val();
		var address 				=$("#address_"+relaId).val();
	   	var ajax_data = "logId="+logId+"&testId="+testId+"&relaId="+relaId+"&modId="+ modId +"&requestDoc="+ requestMsg+"&address="+address
	   							+"&objId="+ objId+"&objType="+ objType+"&sceneId="+ sceneId+"&taskId="+ taskId+"&commProName="+ commProName;
		$.ajax({
		     type:"post",
		     async:false,
		     url:"../testPiles/testExe.shtml",
		     dataType:"text",
		     data:ajax_data,
		     success:function(msg,data){
			      if(msg=="failure"){
			      		$("#responseDoc_"+relaId).val("Failure!");
			      }else{
			      		$("#responseDoc_"+relaId).val(msg);
			      }
		   	  }
		});	
	}
	$("#loadingImg").hide();
	$("#testingBut").show();
}

function getLogId(){
		var logId ="";
		$.ajax({
		     type:"post",
		     async:false,
		     url:"../testPiles/getLogId.shtml",
		     dataType:"text",
		     data:"testId="+testId,
		     success:function(msg,data){
			      if(msg=="failure"){
			      		//alert("NO");
			      }else{
			      		var jsonObj = eval('(' + msg + ')'); 
			      		logId = jsonObj[0].data;
			      		$("#logId").val(logId)
			      }
		   	  }
		});	
		return logId;
}

/*
function saveTestResult(){
	document.getElementById("loadingImg").style.display="block";
	var vRelaIds= document.getElementsByName("vRelaId");
	for(var i=0; vRelaIds.length>i; i++){
			var testId = ${testId};
			var relaId = vRelaIds[i].value;
			var requestMsg = document.getElementById("requestDoc_"+relaId).value;
			var responseMsg = document.getElementById("responseDoc_"+relaId).value;
		   	var ajax_data = "testId="+testId+"&testId="+testId+"&relaId="+relaId+"&requestMsg="+ requestMsg +"&responseMsg="+ responseMsg;
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../testPiles/saveTestResult.shtml",
			     dataType:"text",
			     data:ajax_data,
			     success:function(msg,data){
				      if(msg=="failure"){
							document.getElementById("loadingImg").style.display="none";
							document.getElementById("saveResultInfo").innerText="<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />";
							document.getElementById("saveResultInfo").style.display="block";
				      }else{
				      		var jsonObj = eval('(' + msg + ')'); 
				      		var testId = jsonObj[0].data;
		      				document.getElementById("testId").value = testId;
							document.getElementById("loadingImg").style.display="none";
							document.getElementById("saveResultInfo").innerText="<s:property value="%{getText('eaap.op2.conf.testPiles.saveSuccess')}" />";
							document.getElementById("saveResultInfo").style.display="block";
				      }
			   	  }
			});	
	}
}
*/

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
