<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
<script>
var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}" />';
	title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.remark')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.createDate')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.xiangqing')}" />';
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	<c:if test="${isChoosePage == false}">
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
	    <div class="accordion-header" style="display:${displayStr};">
	    	<div class="accordion-header-text">
				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
				<s:property value="%{getText('eaap.op2.conf.testPiles.querytype')}"/>
			</div>
	    </div>
	</c:if>
	
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
    <ui:form name="myForm"   id="myForm"   method="post"> 
		<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}" />:
			</dt>	
			<dd>
             	<ui:inputText skin="${contextStyleTheme}" name="sceneName"  id="sceneName"  textSize="18" style="float:left;"></ui:inputText>
			</dd>
		</dl>
		<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.testPiles.remark')}" />:
			</dt>
			<dd>
             	<ui:inputText skin="${contextStyleTheme}" name="remark"  id="remark"  textSize="18" style="float:left;"></ui:inputText>
			</dd>
		</dl>
		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.query')}" id="chaxun" onclick="searchFunc();"/>	
   </ui:form>
</div>
<div style="clear:both;">      
	<c:if test="${isChoosePage == false}">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="testSceneListid"  remoteSort="false" sortOrder="desc" 
			fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.sceneList')}:"  fitHeight="367"  striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"  toolbar="true"  
			method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneList">
			<ui:gridEasyColumn width="400" index="0" title="0" field="SCENE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="400" index="1" title="1" field="REMARK" hidden="false"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="2" title="2" field="CREATE_DATE" hidden="false"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="3" title="3" field="SCENE_ID" hidden="false"  align="center"  formatter="true" formatterMethod="formatterForOp" ></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="4" title="4" field="SCENE_ID" hidden="true"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="5" title="5" field="STATE" hidden="true"  align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</c:if>
	<c:if test="${isChoosePage == true}">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="testSceneListid"  remoteSort="false" sortOrder="desc" 
			fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.sceneList')}:"  fitHeight="367"  striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
			method="eaap-op2-conf-testPiles-TestPilesAction.getTestSceneList">
			<ui:gridEasyColumn width="400" index="0" title="0" field="SCENE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="400" index="1" title="1" field="REMARK" hidden="false"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="2" title="2" field="CREATE_DATE" hidden="false"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="3" title="3" field="SCENE_ID" hidden="true"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="4" title="4" field="STATE" hidden="true"  align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</c:if>
</div>
</div>

<c:if test="${isChoosePage == true}">
	<table class="mgr-table" style="" id="confirm">
	   <tr>
	     <td  colspan="4"  align="center">    
	        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.sure')}"  onclick="chooseSceneRet();"></ui:button>
	        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.cancel')}"  onclick="art.dialog.close();"></ui:button>
	     </td>	
	     </tr>
	</table>
</c:if>
</div>
<input id="sceneIdInput"  name="sceneIdInput" type="hidden" value="${sceneIdInput}" />
<input id="sceneNameInput"  name="sceneNameInput" type="hidden" value="${sceneNameInput}" />
<ui:iframe  skin="${contextStyleTheme}"  iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="test_Scene"  iframeId="iframe_testScene" iframeSrc="" frameborder="10" />
</body>
<script>

function searchFunc() {
   var form = $("#myForm").form();
      $('#testSceneListid').datagrid("load", sy.serializeObject(form));
 }	

function formatterForOp(value,row,index){
    return "<a href='${contextPath}/testPiles/testSceneInfo.shtml?sceneId="+value+"'><s:property value="%{getText('eaap.op2.conf.testPiles.xiangqing')}" />...</a>" ;
}
 
function addMehtod(){
       window.location="${contextPath}/testPiles/testSceneInfo.shtml?editOrAdd=add";
} 
              
function updateMethod(){
	     if($('#testSceneListid').datagrid('getSelections')[0]==null) {
		 	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
		 }else{
		    var sceneId =  $('#testSceneListid').datagrid('getSelections')[0].SCENE_ID ;
		    window.location='${contextPath}/testPiles/testSceneInfo.shtml?sceneId='+sceneId;	
		 }
}
   
function deleteMethod(){
	    if($('#testSceneListid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
		 }else{
		   if(confirm("<s:property value="%{getText('eaap.op2.conf.testPiles.suredelete')}" />")){
				  var sceneId =  $('#testSceneListid').datagrid('getSelections')[0].SCENE_ID ;
				  var ajax_data = "testScene.sceneId="+sceneId;
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
					          $('#testSceneListid').datagrid('reload');
						  }
				  });
			 }
		 }
}
   
function chooseSceneRet() {
  	if($('#testSceneListid').datagrid('getSelections')[0]==null){
			alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleasechoose')}" />");
	 }else{
			var vOpener=art.dialog.opener; 
		  	var sceneId =  $('#testSceneListid').datagrid('getSelections')[0].SCENE_ID ;
		  	var sceneName =  $('#testSceneListid').datagrid('getSelections')[0].SCENE_NAME ;
			if($("#sceneIdInput").attr('value')!=""){
				vOpener.document.getElementById($("#sceneIdInput").attr('value')).value=sceneId;
			}
			if($("#sceneNameInput").attr('value')!="") {
				vOpener.document.getElementById($("#sceneNameInput").attr('value')).value=sceneName;
			}
			art.dialog.close(); 
	 }
}  
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
