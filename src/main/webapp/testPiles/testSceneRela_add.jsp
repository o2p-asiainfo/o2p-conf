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
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.type')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.name')}"/>';

title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}"/>';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}"/>';
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
<ui:form id="myForm" name="myForm"  action=""  method="post"> 
<input type="hidden" id="sceneId" name="TestSceneRela.sceneId" value="${TestSceneRela.sceneId}"/>
<input type="hidden" id="objTypeSel"  name="objTypeSel" />
<input type="hidden" id="objId"  name="objId" />

<table align="center" class="mgr-table"  style="width:100%;">
	<tr>
		<td align="center" style="width:50%;padding:0;margin:0;" valign="top">
	  		<div style="background-color:#ccc;padding:5px;">
		     	<s:property value="%{getText('eaap.op2.conf.testPiles.chooseForTestingSerInvokeInsOrService')}"/>
	      	</div>
		    <div id="queryBlock">
				<div class="selectList" style="display:block;">	
					<dl class="noBorder" style="padding:5px 0; margin-bottom:2px;">
		    			<dc style="width:500px;">	
		    				<dt style="width:100px; ">
		    					<s:property value="%{getText('eaap.op2.conf.testPiles.type')}" />:
		    				</dt>
		    				<dd style="width:120px; text-align:left;">
			                    <ui:select skin="${contextStyleTheme}"  emptyOption="true" name="objType" id="objType"  
			    			       list="objTypeList" listKey="key" listValue="value" style="width:120px;" onchange="searchObjList()"  layerWidth="170" ></ui:select>
		    				</dd>
		    				<dt style="width:120px; ">
		    					<s:property value="%{getText('eaap.op2.conf.testPiles.name')}" />:
		    				</dt>	
		    				<dd style="width:120px;">
				                <ui:inputText skin="${contextStyleTheme}" name="objName"  id="objName"  textSize="18" style="float:left;" onkeyup="searchObjList()"></ui:inputText>
		    				</dd>
		    			</dc>
		    		</dl>
					<dl class="noBorder" style="height:320px;" onclick="chooseObj()">
		    			<dc style="width:100%">
								<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save"  sortName="code"  singleSelect="true"   id="objList"  remoteSort="false" sortOrder="desc" 
									fit="true" collapsible="true"  title=""  striped="true" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true"  fitHeight="315"  onClickCell="true" 
									method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneRelaObjList" >
									<ui:gridEasyColumn width="200" index="0" title="0" field="OBJ_TYPE" hidden="false" align="center" formatter="true" formatterMethod="formatterForObjType" ></ui:gridEasyColumn>
									<ui:gridEasyColumn width="800" index="1" title="1" field="OBJ_NAME" hidden="false" align="center"></ui:gridEasyColumn>
								</ui:gridEasy>
		    			</dc>
					</dl>
				</div>
			</div>
		</td>
		<td align="center"></td>
		<td align="center" style="width:50%;padding:0;margin:0;" valign="top">
	  		<div style="background-color:#ccc;padding:5px;">
		     	<s:property value="%{getText('eaap.op2.conf.testPiles.chooseForTestingMod')}"/>
	      	</div>
		    <div id="queryBlock">
				<div class="selectList" style="display:block;">	
					<dl class="noBorder" style="padding:5px 0; margin-bottom:2px;">
		    			<dc style="width:500px;">	
		    				<dt style="width:120px; ">
		    					<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}" />:
		    				</dt>
		    				<dd style="width:120px; text-align:left;">
				                <ui:inputText skin="${contextStyleTheme}" name="modName"  id="modName"  textSize="18" style="float:left;" onkeyup="searchModList()"></ui:inputText>
		    				</dd>
		    				<dt style="width:120px; ">
		    					<s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}" />:
		    				</dt>	
		    				<dd style="width:120px;text-align:left;">
			              		<ui:select skin="${contextStyleTheme}"  emptyOption="true" name="msgFormatType"  id="msgFormatType"  
			    			       list="formatTypeList" listKey="key" listValue="value" style="width:70px;" onchange="searchModList()" ></ui:select>
		    				</dd>
		    			</dc>
		    		</dl>
					<dl class="noBorder" style="height:320px;">
		    			<dc style="width:100%" class="noBorder selectList">
							<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="testSceneRelaModList"  remoteSort="false" sortOrder="desc" 
								fit="true" collapsible="true"  title=""  fitHeight="315"   striped="true" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true"  
								method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneRelaModList">
								<ui:gridEasyColumn width="0" index="0" title="0" field="MOD_ID" hidden="true" align="center"></ui:gridEasyColumn>
								<ui:gridEasyColumn width="0" index="1" title="1" field="MOD_ID" hidden="true" align="center"></ui:gridEasyColumn>
								<ui:gridEasyColumn width="400" index="2" title="2" field="MOD_NAME" hidden="false" align="center"></ui:gridEasyColumn>
								<ui:gridEasyColumn width="130" index="3" title="3" field="MSG_FORMAT_TYPE" hidden="false" align="center" formatter="true" formatterMethod="formatterForMsgType" ></ui:gridEasyColumn>
							</ui:gridEasy>
		    			</dc>
					</dl>
				</div>
			</div>
		</td>
	</tr>
</table>

<table align="center" class="mgr-table"  style="width:100%;">
	<tr>
		<td align="center">
			<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.sure')}"  id="submitId" onclick="chooseSceneSure();"></ui:button>
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

function searchObjList() {
	  var form = $("#myForm").form();
      $('#objList').datagrid("load", sy.serializeObject(form));
}
  
function chooseObj(){
	var objType = $('#objList').datagrid('getSelections')[0].OBJ_TYPE ;
	var objId = $('#objList').datagrid('getSelections')[0].OBJ_ID ;
	$("#objType").val(objType);
	$("#objId").val(objId)
}
 
function formatterForObjType(value,row,index){
	if(value=="0"){
    	return "<s:property value='%{getText(\"eaap.op2.conf.testPiles.service\")}' />" ;
	}else if(value=="1"){
    	return "<s:property value='%{getText(\"eaap.op2.conf.testPiles.serInvokeIns\")}' />" ;
	}
}

function formatterForMsgType(value,row,index){
    if(value=='1') {
    	return '<s:property value="%{getText('eaap.op2.conf.testPiles.xml')}" />' ;
    }else if(value=='2'){
    	return '<s:property value="%{getText('eaap.op2.conf.testPiles.json')}" />' ;
    }
}

function clickMethod(index,field,value){
	$("#modName").val(null);
	$("#msgFormatType").val(null);  $(".tag_select").text('');
	setTimeout(searchModList,300);
}
function searchModList(){
	if($('#objList').datagrid('getSelections')[0]!=null){
		var objType= $('#objList').datagrid('getSelections')[0].OBJ_TYPE ;
		var objId 	= $('#objList').datagrid('getSelections')[0].OBJ_ID ;
		$("#objTypeSel").val(objType);
		$("#objId").val(objId)
		var form = $("#myForm").form();
		$('#testSceneRelaModList').datagrid("load", sy.serializeObject(form));
	} 
}

function chooseSceneSure(){
    var vOpener=art.dialog.opener; 
	if($('#objList').datagrid('getSelections')[0]==null || $('#testSceneRelaModList').datagrid('getSelections')[0]==null) {
		if($('#objList').datagrid('getSelections')[0]==null) {
			alert("<s:property value="%{getText('eaap.op2.conf.testPiles.chooseForTestingSerInvokeInsOrService')}" />");
		}else if($('#testSceneRelaModList').datagrid('getSelections')[0]==null){
			alert("<s:property value="%{getText('eaap.op2.conf.testPiles.chooseForTestingMod')}" />");
		}
	}else{
		var sceneId = ${TestSceneRela.sceneId};
		var objType = $('#objList').datagrid('getSelections')[0].OBJ_TYPE ;
		var objId = $('#objList').datagrid('getSelections')[0].OBJ_ID ;
		var modId =  $('#testSceneRelaModList').datagrid('getSelections')[0].MOD_ID ;
		var ajax_data = "TestSceneRela.sceneId="+sceneId+"&TestSceneRela.objType="+objType+"&TestSceneRela.objId="+objId+"&TestSceneRela.modId="+modId;
		$.ajax({
	          type:"post",
	          async:false,
	          url:"../testPiles/testSceneRelaSave.shtml",
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

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
