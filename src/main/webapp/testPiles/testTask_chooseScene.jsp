<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}"/></title>
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
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.sceneId')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}"/>';
</script>

</head>
<body>
<!--body start -->
<div class="contentWarp">
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
			<dl class="noBorder">
				<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="sceneListId"  remoteSort="false" sortOrder="desc"  queryParams="true"  queryParamsData="${techImplId}"
					fit="true" collapsible="true"  title=""  fitHeight="230"   striped="true" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true"  toolbar="true"  method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneListByTechImplId">
					<ui:gridEasyColumn width="100" index="0" title="0" field="SCENE_ID" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="900" index="1" title="1" field="SCENE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="0" index="2" title="2" field="REQUEST_MESSAGE_MOD" hidden="true" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="0" index="3" title="3" field="RESPONSE_MESSAGE_MOD" hidden="true" align="center"></ui:gridEasyColumn>
				</ui:gridEasy>
			</dl>
		</div>
	</div>

    <ui:form id="myForm" name="myForm" action="insertTestSceneData.shtml" method="post"> 
          <table align="center" class="mgr-table" id="sceneInfoTable" style="display:none;width:100%; background-color:#F6F6F6;">
             <input type="hidden" id="techImplId" name="TestScene.techImplId" value="${techImplId}"/>
             <input type="hidden" id="taskId" name="TestTaskScene.taskId" value="${TestTaskScene.taskId}"/>
             <input type="hidden" id="endpointId" name="TestTaskScene.endpointId" value="${TestTaskScene.endpointId}"/>
             <input type="hidden" id="chooseSceneId" name="TestScene.sceneId" value=""/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
            <tr>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}"/>:</td>
              <td  colspan="3" width="82%"><ui:inputText skin="${contextStyleTheme}"  name="TestScene.sceneName"  id="sceneName" value="" style="width:450px"></ui:inputText></td>
            </tr>
             <tr>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.requestMessageMod')}"/>:</td>
              <td width="32%">
               		<ui:textarea skin="${contextStyleTheme}" name="TestScene.requestMessageMod"  id="requestMessageMod"   value="" width="450" height="100"></ui:textarea>
               </td>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.responseMessageMod')}"/>:</td>
              <td width="32%">
               		<ui:textarea skin="${contextStyleTheme}" name="TestScene.responseMessageMod"  id="responseMessageMod"   value="" width="450" height="100"></ui:textarea>
               </td>
            </tr>
            <tr>
    			   <td  colspan="4" class="item-content" align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.checksubmit')}"  shape="s" id="checksubmitId" onclick="javascript:save();"></ui:button>
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}"  shape="s" id="checkcancelId" onclick="sceneInfoCancel();"></ui:button>
				   </td>
    		 </tr>
    	  </table>
    	  
          <table align="center" class="mgr-table"  style="width:100%;">
            <tr>
    			   <td  colspan="4" class="item-content" align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.sure')}"  id="checksubmitId" onclick="chooseSceneSure();"></ui:button>
 						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}" id="cancelId" onclick="chooseSceneCancel()"></ui:button>
				   </td>
    		 </tr>
    	  </table>
  </ui:form>
    	
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</div>
</body>
<script>
function searchFunc() {
   var form = $("#myForm").form();
      $('#sceneListId').datagrid("load", sy.serializeObject(form));
 }	
 
function chooseSceneSure(){
    var vOpener=art.dialog.opener; 
	if($('#sceneListId').datagrid('getSelections')[0]==null) {
		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
	}else{
		var sceneId =  $('#sceneListId').datagrid('getSelections')[0].SCENE_ID ;
		var taskId = ${TestTaskScene.taskId};
		var endpointId = ${TestTaskScene.endpointId};
		var ajax_data = "TestTaskScene.taskId="+taskId+"&TestTaskScene.endpointId="+endpointId+"&TestTaskScene.sceneId="+sceneId;
		$.ajax({
	          type:"post",
	          async:false,
	          url:"../testPiles/chooseSceneSave.shtml",
	          dataType:"json",
	          data:ajax_data,
	          success:function(msg,data){
		          if(msg=="failure"){
		          		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
		          }
				  art.dialog.close(); 
				  vOpener.reloadList();
			  }
		});
	}
}
function chooseSceneCancel(){
	art.dialog.close(); 
   	var vOpener=art.dialog.opener; 
	vOpener.reloadList();
}

function addMehtod(){
          $("#chooseSceneId").val(null);
          $("#sceneName").val(null);
          $("#requestMessageMod").val(null);
          $("#responseMessageMod").val(null);
		  $("#editOrAdd").val("add");
		  
		  $('#sceneInfoTable').show();
		  changeTopScrollHeight();
} 

function updateMethod(){
	     if($('#sceneListId').datagrid('getSelections')[0]==null) {
		 	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
		 }else{
		      var sceneId =  $('#sceneListId').datagrid('getSelections')[0].SCENE_ID ;
		      var sceneName =  $('#sceneListId').datagrid('getSelections')[0].SCENE_NAME ;
		      var requestMessageMod =  $('#sceneListId').datagrid('getSelections')[0].REQUEST_MESSAGE_MOD ;
		      var responseMessageMod =  $('#sceneListId').datagrid('getSelections')[0].RESPONSE_MESSAGE_MOD ;
	
	          $("#chooseSceneId").val(sceneId);
	          $("#sceneName").val(sceneName);
	          $("#requestMessageMod").val(requestMessageMod);
	          $("#responseMessageMod").val(responseMessageMod);
			  $("#editOrAdd").val("edit");
			  
			  $('#sceneInfoTable').show();
		 }
}

function save(){
	if($("#sceneName").val() == ""){
		$("#sceneName").focus();
		return;
	}
	if($("#requestMessageMod").val() == ""){
		$("#requestMessageMod").focus();
		return;
	}
	if($("#responseMessageMod").val() == ""){
		$("#responseMessageMod").focus();
		return;
	}
    var ajax_data = $("#myForm").serialize();
   	 $.ajax({
          type:"post",
          async:false,
          url:"../testPiles/saveTestSceneData.shtml",
          dataType:"json",
          data:ajax_data,
          success:function(msg,data){
	          if(msg=="failure"){
	          		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
	          }
	          $('#sceneListId').datagrid('reload');
	  		  $('#sceneInfoTable').hide();
		  }
       });
}

function deleteMethod(){	
	    if($('#sceneListId').datagrid('getSelections')[0]==null) {
		   	  alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))	{
		      	  var sceneId =  $('#sceneListId').datagrid('getSelections')[0].SCENE_ID ;  
				  var ajax_data = "TestScene.sceneId="+sceneId;
				  $.ajax({
				          type:"post",
				          async:false,
				          url:"../testPiles/deleteTestScene.shtml",
				          dataType:"json",
				          data:ajax_data,
				          success:function(msg,data){
					          if(msg=="failure"){
					          		//
					          }
					          $('#sceneListId').datagrid('reload');
						  }
				  });
			  }
		 }
}

function sceneInfoCancel(){
          $("#sceneName").val(null);
          $("#requestMessageMod").val(null);
          $("#responseMessageMod").val(null);
		  $('#sceneInfoTable').hide();
}

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
