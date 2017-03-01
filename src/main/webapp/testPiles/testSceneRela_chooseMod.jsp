<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.modId')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}"/>';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}"/>';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.remark')}"/>';
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
<ui:form id="myForm" name="myForm"  action=""  method="post"> 
    <input type="hidden" id="relaId" name="relaId" value="${TestSceneRela.relaId}"/>
    <input type="hidden" id="sceneId" name="sceneId" value="${TestSceneRela.sceneId}"/>
    <input type="hidden" id="objType"  name="objType" value="${TestSceneRela.objType}"/>
    <input type="hidden" id="objId"  name="objId" value="${TestSceneRela.objId}"/>
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
			<dl class="noBorder">
				<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="testSceneRelaModList"  remoteSort="false" sortOrder="desc" 
					fit="true" collapsible="true"  title=""  fitHeight="230"   striped="true" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true"  toolbar="true"  
					method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneRelaModList">
					<ui:gridEasyColumn width="100" index="0" title="0" field="MOD_ID" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="400" index="1" title="1" field="MOD_NAME" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="130" index="2" title="2" field="MSG_FORMAT_TYPE" hidden="false" align="center" formatter="true" formatterMethod="formatterForMsgType" ></ui:gridEasyColumn>
					<ui:gridEasyColumn width="400" index="3" title="3" field="REMARK" hidden="false" align="center"></ui:gridEasyColumn>
				</ui:gridEasy>
			</dl>
		</div>
	</div>
</ui:form>
<ui:form id="modForm" name="modForm" action="insertTestSceneData.shtml" method="post"> 
          <table align="center" class="mgr-table" id="modInfoTable" style="display:none;width:100%; background-color:#F6F6F6;">
		    <input type="hidden" id="objType"  name="TestMsgModRela.objType" value="${TestSceneRela.objType}"/>
		    <input type="hidden" id="objId"  name="TestMsgModRela.objId" value="${TestSceneRela.objId}"/>
             <input type="hidden" id="modId" name="TestMsgMod.ModId" value=""/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
            <tr>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.modName')}"/>:</td>
              <td width="82%">
              		<ui:inputText skin="${contextStyleTheme}"  name="TestMsgMod.modName"  id="modName" value="" style="width:700px"></ui:inputText>
              </td>
            </tr>
            <tr>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}"/>:</td>
              <td  width="82%">
              		<ui:select skin="${contextStyleTheme}"  emptyOption="true" name="TestMsgMod.msgFormatType"  id="msgFormatType"  
    			       list="formatTypeList" listKey="key" listValue="value" style="width:70px;" ></ui:select>
              </td>
            </tr>
            <tr>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.requestMessageMod')}"/>:</td>
              <td width="82%">
               		<ui:textarea skin="${contextStyleTheme}" name="TestMsgMod.requestMsgMod"  id="requestMsgMod"   value="" width="700" height="100"></ui:textarea>
               </td>
            </tr>
            <tr>
              <td align="right" width="18%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.responseMessageMod')}"/>:</td>
              <td width="82%">
               		<ui:textarea skin="${contextStyleTheme}" name="TestMsgMod.responseMsgMod"  id="responseMsgMod"   value="" width="700" height="100"></ui:textarea>
               </td>
            </tr>
            <tr>
              <td align="right" width="18%"><s:property value="%{getText('eaap.op2.conf.testPiles.remark')}"/>:</td>
              <td width="82%">
               		<ui:textarea skin="${contextStyleTheme}" name="TestMsgMod.remark"  id="remark"  value=""  width="700" height="35"></ui:textarea>              
              </td>
            </tr>
            <tr>
    			   <td  colspan="4" class="item-content" align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.checksubmit')}"  shape="s" id="checksubmitId" onclick="javascript:saveModInfo();"></ui:button>
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}"  shape="s" id="checkcancelId" onclick="modInfoCancel();"></ui:button>
				   </td>
    		 </tr>
    	  </table>
    	  
          <table align="center" class="mgr-table"  style="width:100%;">
            <tr>
    			   <td  colspan="4" class="item-content" align="center">
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
$(document).ready(function(){
	setTimeout(searchFunc,200);
})
function searchFunc() {
	  var form = $("#myForm").form();
      $('#testSceneRelaModList').datagrid("load", sy.serializeObject(form));
 }	
 
 function formatterForMsgType(value,row,index){
    if(value=='1')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.xml')}" />' ;
    }else if(value=='2')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.json')}" />' ;
    }
}

function chooseSceneSure(){
    var vOpener=art.dialog.opener; 
	if($('#testSceneRelaModList').datagrid('getSelections')[0]==null) {
		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
	}else{
		var relaId = ${TestSceneRela.relaId};
		var sceneId = ${TestSceneRela.sceneId};
		var objType = ${TestSceneRela.objType};
		var objId = ${TestSceneRela.objId};
		var modId =  $('#testSceneRelaModList').datagrid('getSelections')[0].MOD_ID ;
		var ajax_data = "TestSceneRela.relaId="+relaId+"&TestSceneRela.sceneId="+sceneId+"&TestSceneRela.objType="+objType+"&TestSceneRela.objId="+objId+"&TestSceneRela.modId="+modId;
		$.ajax({
	          type:"post",
	          async:false,
	          url:"../testPiles/testSceneRelaUpdateMod.shtml",
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
          $("#modId").val(null);
          $("#modName").val(null);
          $("#requestMsgMod").val(null);
          $("#responseMsgMod").val(null);
          $("#msgFormatType").val(null);
          $("#remark").val(null);
		  $("#editOrAdd").val("add");
		  
		  $('#modInfoTable').show();
		  changeTopScrollHeight();
} 

function updateMethod(){
	     if($('#testSceneRelaModList').datagrid('getSelections')[0]==null) {
		 	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
		 }else{
		      var modId =  $('#testSceneRelaModList').datagrid('getSelections')[0].MOD_ID ;
		      var modName =  $('#testSceneRelaModList').datagrid('getSelections')[0].MOD_NAME ;
		      var requestMsgMod =  $('#testSceneRelaModList').datagrid('getSelections')[0].REQUEST_MSG_MOD ;
		      var responseMsgMod =  $('#testSceneRelaModList').datagrid('getSelections')[0].RESPONSE_MSG_MOD ;
		      var msgFormatType =  $('#testSceneRelaModList').datagrid('getSelections')[0].MSG_FORMAT_TYPE ;
		      var remark =  $('#testSceneRelaModList').datagrid('getSelections')[0].REMARK ;
	
	          $("#modId").val(modId);
	          $("#modName").val(modName);
	          $("#requestMsgMod").val(requestMsgMod);
	          $("#responseMsgMod").val(responseMsgMod);
	          $("#msgFormatType").val(msgFormatType);
	          $("#remark").val(remark);
			  $("#editOrAdd").val("edit");
			  
			  $('#modInfoTable').show();
		 }
}

function deleteMethod(){
	    if($('#testSceneRelaModList').datagrid('getSelections')[0]==null) {
		   	  alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))	{
				  var objType = ${TestSceneRela.objType};
				  var objId = ${TestSceneRela.objId};
		      	  var modId =  $('#testSceneRelaModList').datagrid('getSelections')[0].MOD_ID ;
				  var ajax_data = "testMsgModRela.objType="+objType+"&testMsgModRela.objId="+objId+"&testMsgModRela.modId="+modId;
				  $.ajax({
				          type:"post",
				          async:false,
				          url:"../testPiles/testSceneRelaModDel.shtml",
				          dataType:"json",
				          data:ajax_data,
				          success:function(msg,data){
					          if(msg=="failure"){
					           //failure
		 						alert("<s:property value="%{getText('eaap.op2.conf.testPiles.delFailed')}" />");
					          }
					          $('#testSceneRelaModList').datagrid('reload');
						  }
				  });
			  }
		}
}

function saveModInfo(){
	if(jQuery.trim($("#modName").val()) == ""){
		$("#modName").focus();
		return;
	}
	if(jQuery.trim($("#requestMsgMod").val()) == ""){
		$("#requestMsgMod").focus();
		return;
	}
	if(jQuery.trim($("#responseMsgMod").val()) == ""){
		$("#responseMsgMod").focus();
		return;
	}
    var ajax_data = $("#modForm").serialize();
   	 $.ajax({
          type:"post",
          async:false,
          url:"../testPiles/testSceneRelaModSave.shtml",
          dataType:"json",
          data:ajax_data,
          success:function(msg,data){
	          if(msg=="failure"){
	          		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
	          }
	          $('#testSceneRelaModList').datagrid('reload');
	  		  $('#modInfoTable').hide();
		  }
       });
}

function modInfoCancel(){
	      $("#editOrAdd").val(null);
	      $("#modId").val(null);
          $("#modName").val(null);
          $("#requestMsgMod").val(null);
          $("#responseMsgMod").val(null);
          $("#msgFormatType").val(null);
          $("#remark").val(null);
		  $('#modInfoTable').hide();
}

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
