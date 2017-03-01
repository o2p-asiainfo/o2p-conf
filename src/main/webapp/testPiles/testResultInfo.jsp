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
		  				<div style="font-weight:bold; font-size:14px; ">
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
		  		<input type="hidden"  name="vRelaId"  value="${dataSet.RELA_ID}"/>
		   		<input type="hidden"  id="modId_${dataSet.RELA_ID}"  	value="${dataSet.MOD_ID}"/>
		   		<input type="hidden"  id="objId_${dataSet.RELA_ID}"		value="${dataSet.OBJ_ID}"/>
		   		<input type="hidden"  id="objType_${dataSet.RELA_ID}" value="${dataSet.OBJ_TYPE}"/>
		   		<input type="hidden"  id="sceneId_${dataSet.RELA_ID}" 	value="${dataSet.SCENE_ID}"/>
		   		<input type="hidden"  id="taskId_${dataSet.RELA_ID}" 	value="${dataSet.TASK_ID}"/>
		   		<tr>
		   			<td class="item"  style="width:12%;text-align:left;"><s:property value="%{getText('eaap.op2.conf.testPiles.requestMessage')}" />:</td>
		   			<td class="item-content"  style="width:38%;text-align:right; padding-right:20px;">
		   			</td>
		  			<td class="item"  style="width:12%;text-align:left;"><s:property value="%{getText('eaap.op2.conf.testPiles.testResultsInfo')}" />:</td>
		   			<td class="item-content" style="width:38%;text-align:right; padding-right:20px;">&nbsp;</td>
		   		</tr>
		   		<tr>
		   			<td class="item-content"  colspan="2" style="padding:0;">
		   				<textarea id="requestMsgMod_${dataSet.RELA_ID}"  width="100%" height="1" style="display:none;" >${dataSet.REQUEST_MSG_MOD}</textarea>
			   			<textarea id="requestDoc_${dataSet.RELA_ID}"  width="100%" height="250" style="width:99%; height:250px;" >${dataSet.REQUEST_MSG}</textarea>
		   			</td>
		   			<td class="item-content"  colspan="2" style="padding:0;">
			   			<textarea id="responseDoc_${dataSet.RELA_ID}"  width="100%" height="250" style="width:99%; height:250px;" >${dataSet.RESPONSE_MSG}</textarea>
		   			</td>
		   		</tr>
		    </table>
		</c:forEach>


		</td>
	</tr>
    <tr>
		<td align="center" >
				<table>
					<tr>
						<td style="border-width:0;">
	  						<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.return')}" id="cancelId" onclick="location='${contextPath}/testPiles/testResults.shtml'"></ui:button>
						</td>
					</tr>
				</table>
		</td>
	</tr>
</table>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<input id="objId" name="objId" type="hidden" />	
</div>
</body>
<script>
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
