<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}"/></title>
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
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}"/>
      	</div>
    </div>
    
		<div class="selectList" style="display:block;">	
		 <ui:form id="myForm" name="myForm" action="saveTestSceneData.shtml" method="post"> 
	  		<input id="sceneId" name="TestScene.sceneId" type="hidden" value="${testScene.sceneId}" />	
	  		<input id="editOrAdd" name="editOrAdd" type="hidden" value="${editOrAdd}" />	

		 	<table class="mgr-table">
				<tr>
		  			<td class="item" style="width:20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}" />:</td>
		  			<td class="item-content" style="width:80%;">
			  		    <ui:inputText skin="${contextStyleTheme}"  name="TestScene.sceneName"  id="sceneName" value="${testScene.sceneName}" style="width:653px"></ui:inputText>
		   			</td>
		   		</tr>
				<tr>
		  			<td class="item"><s:property value="%{getText('eaap.op2.conf.testPiles.remark')}" />:</td>
		  			<td class="item-content" > 
		   				<span style="float:left;">
			  		    	<ui:textarea skin="${contextStyleTheme}"  id="remark" name="TestScene.remark" width="650" height="50"  value="${testScene.remark}" />
		   				</span>
		   			</td>
		   		</tr>
		    </table>
		 </ui:form>
		<c:if test="${editOrAdd =='edit'}">
		<dl class="noBorder">
			<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="sceneRelaListId" remoteSort="false" sortOrder="desc"  toolbar="true" queryParams="true"  queryParamsData="${testScene.sceneId}"
					skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.forTestingSerInvokeInsOrService')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
					method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneRelaListBySceneId">
				<ui:gridEasyColumn width="120" index="0" title="0" field="OBJ_TYPE" hidden="false" align="center" formatter="true" formatterMethod="formatterForObjType" ></ui:gridEasyColumn>
				<ui:gridEasyColumn width="120" index="1" title="1" field="OBJ_NAME" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="120" index="2" title="2" field="MOD_NAME" hidden="false" align="center" ></ui:gridEasyColumn>
				<ui:gridEasyColumn width="0" index="3" title="3" field="MOD_ID" hidden="true" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="0" index="4" title="4" field="OBJ_ID" hidden="true" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="0" index="5" title="5" field="SCENE_ID" hidden="true" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="0" index="6" title="6" field="RELA_ID" hidden="true" align="center"></ui:gridEasyColumn>
			</ui:gridEasy>
		</dl>
		</c:if>
	</div>

<table  class="mgr-table">
    <tr>
		<td  colspan="4"  align="center">
			<c:if test="${editOrAdd =='add'}">
		  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.next')}" id="saveBut" onclick="saveTestSceneData()"></ui:button>
		  	</c:if>
			<c:if test="${editOrAdd =='edit'}">
		  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.save')}" id="saveBut" onclick="saveTestSceneData()"></ui:button>
		  	</c:if>
		  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.return')}" id="cancelId" onclick="location='${contextPath}/testPiles/testScene.shtml'"></ui:button>
		</td>
	</tr>
</table>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<input id="objId" name="objId" type="hidden" />	
</div>
</body>
<script>
$(document).ready(function(){
	$("#btncut").html(null);

	$(".datagrid-pager").prop('outerHTML', '');
});

function searchFunc() {
   var form = $("#myForm").form();
      $('#sceneRelaListId').datagrid("load", sy.serializeObject(form));
 }	

function saveTestSceneData(){
	if(jQuery.trim($("#sceneName").val()) == ""){
		alert("<s:property value='%{getText(\"eaap.op2.conf.testPiles.sceneName\")}' /> <s:property value='%{getText(\"eaap.op2.conf.testPiles.notNull\")}' />");
		$("#sceneName").focus();
		return;
	}
	
	var sceneName = jQuery.trim($("#sceneName").val());
	var remark = jQuery.trim($("#remark").val());
	var sceneId = $("#sceneId").val();
	var editOrAdd = $("#editOrAdd").val();
	$.ajax({
	     type:"post",
	     async:false,
	     url:"../testPiles/saveTestSceneData.shtml",
	     dataType:"text",
	     data:"sceneId="+sceneId+"&sceneName="+sceneName+"&remark="+remark+"&editOrAdd="+editOrAdd,
	     success:function(msg,data){
				try { 
				      	//alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveSuccess')}" />");
			      		var jsonObj = eval('(' + msg + ')'); 
			      		var rEditOrAdd = jsonObj[0].editOrAdd;
				      	if(rEditOrAdd != null && rEditOrAdd=="add"){
	    					window.location="${contextPath}/testPiles/testSceneInfo.shtml?sceneId="+sceneId;
				      	}else{
				      		window.location="${contextPath}/testPiles/testScene.shtml";
				      	}
				} catch (e) { 
			      		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
				}
	   	  }
	});	
}

function formatterForObjType(value,row,index){
	if(value=="0"){
    	return "<s:property value='%{getText(\"eaap.op2.conf.testPiles.service\")}' />" ;
	}else if(value=="1"){
    	return "<s:property value='%{getText(\"eaap.op2.conf.testPiles.serInvokeIns\")}' />" ;
	}
}

function formatterForModName(value,row,index){
    var sceneId = "${testScene.sceneId}";
    var relaId = row.RELA_ID;
    var objId = row.OBJ_ID;
    var objType = row.OBJ_TYPE;
	if(objId!=null && objId!="" && objType!=null && objType!=""){
		if(value==null || value==""){
    		return 			  "<a href='#' onclick='openWindows(\"${contextPath}/testPiles/testSceneRela_chooseMod.shtml?TestSceneRela.relaId="+relaId+"&TestSceneRela.sceneId="+sceneId+"&TestSceneRela.objId="+objId+"&TestSceneRela.objType="+objType+"\",\"Choose Message Template\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.xuanze\")}' />...</a>" ;
    	}else{
    		return value + "<a href='#' onclick='openWindows(\"${contextPath}/testPiles/testSceneRela_chooseMod.shtml?TestSceneRela.relaId="+relaId+"&TestSceneRela.sceneId="+sceneId+"&TestSceneRela.objId="+objId+"&TestSceneRela.objType="+objType+"\",\"Choose Message Template\")'><s:property value='%{getText(\"eaap.op2.conf.testPiles.change\")}' />...</a>" ;
		}
	}else{
    	return "<font style='color:#ccc;'>--</font>" ;
	}
}

function addMehtod(){
	if(jQuery.trim($("#sceneName").val()) == ""){
		alert("<s:property value='%{getText(\"eaap.op2.conf.testPiles.sceneName\")}' /> <s:property value='%{getText(\"eaap.op2.conf.testPiles.notNull\")}' />");
		$("#sceneName").focus();
		return;
	}	
    var sceneId = "${testScene.sceneId}";
	openWindows("${contextPath}/testPiles/testSceneRela_add.shtml?TestSceneRela.sceneId="+sceneId,"Choose");
} 

function updateMethod(){
}

function deleteMethod(){
	    if($('#sceneRelaListId').datagrid('getSelections')[0]==null) {
		   	  alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))	{
		      	  var relaId =  $('#sceneRelaListId').datagrid('getSelections')[0].RELA_ID ;
				  var ajax_data = "TestSceneRela.relaId="+relaId;
				  $.ajax({
				          type:"post",
				          async:false,
				          url:"../testPiles/testSceneRelaDel.shtml",
				          dataType:"json",
				          data:ajax_data,
				          success:function(msg,data){
					          if(msg=="failure"){
					          		//
					          }
					          $('#sceneRelaListId').datagrid('reload');
						  }
				  });
			  }
		 }
}

function reloadList(){
	$('#sceneRelaListId').datagrid('reload');
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
