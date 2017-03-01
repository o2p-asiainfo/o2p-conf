<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
	<style>
  tr.datagrid-row-selected{color:#000}
</style>
<head>
	<title>
		<s:property value="%{getText('eaap.op2.conf.logserver.logserver')}" />
	</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/contractDoc_files/contractDiv.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/json2.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
 </head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.logserver.dataSourceName')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.logserver.componentCode')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.logserver.componentName')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.logserver.tabSuffix')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.logserver.isDefault')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.logserver.isBeginInit')}" />';
</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<%--<div class="module-path">
  		<div class="module-path-content">
	      <img src="../resource/blue/images/search.png" />
	      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      <img src="../resource/blue/images/module-path.png" />
	      <s:property value="%{getText('eaap.op2.conf.logserver.logserver')}"/>
      </div>
    </div> --%>
    <div class="accordion-header"  id="searchBarTitle">
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
         </div>
    </div>
    
    <div id="queryBlock">    
		<div class="formLayout" style="padding:5px 0;">
		<ui:form name="myForm" id="myForm" method="post">
		<input name="attrName" id="attrName" type="hidden" value="${attrName}"/>
  			<input name="objectId" id="objectId" type="hidden" value="${objectId}"/>
  			<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="hidden" value="${endpoint_Spec_Attr_Id}"/>
  			<input type="hidden" name="newState" id="newState" value="${newState}">
            <input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.logserver.dataSourceName')}" />:
				</dt>	
				<dd >
					<ui:inputText skin="${contextStyleTheme}"  name="dataSourceName" id="dataSourceName" value="${dataSourceName}" style="width:150px;"/>
				</dd>
			</dl>
			
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.logserver.componentName')}" />:
				</dt>	
				<dd >
					<ui:inputText skin="${contextStyleTheme}"  name="componentName" id="componentName" value="${componentName}" style="width:150px;"/>
				</dd>
			</dl>
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.logserver.tabSuffix')}" />:
				</dt>	
				<dd >
				    <ui:inputText skin="${contextStyleTheme}"  name="tabSuffix" id="tabSuffix" value="${tabSuffix}" style="width:150px;"/>
				</dd>
			</dl>
			<div style="text-align:right; float:right; margin-bottom:5px;">
				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
			</div>
			</ui:form>
		</div>
	</div>
	<div style="clear:both;overflow:hide;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" sortName="code" singleSelect="true"   id="table"  remoteSort="false" sortOrder="desc" onClickCell="true"
			fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true" fitHeight="368"  toolbar="true" 
			method="eaap-op2-conf-logserver-logServerAction.getDataSourceList">
			<ui:gridEasyColumn width="120" index="0" title="0" field="dataSourceName" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="1" title="1" field="componentCode" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="2" title="2" field="componentName" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="3" title="3" field="tabSuffix" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="4" title="4" field="isDefault" hidden="false"  align="center" formatter="true" formatterMethod="formatterForIsDefalut"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="5" title="5" field="isbegininit" hidden="false" align="center" formatter="true" formatterMethod="formatterForIsInit"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="6" title="6" field="dataSourceId" hidden="true" align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
	<table class="mgr-table" style="display:none" id="confirm">
		   <tr>
		     <td align="center">
		        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseMessageFlow();"></ui:button>
		        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
			 </td>	
		   </tr>
	</table>
	<input name="pageState" id="pageState" type="hidden" value="${pageState}" />
</body>
<script>

function searchFunc(){
	var form = $("#myForm").form();
    $('#table').datagrid("load", sy.serializeObject(form));
}

var operationTip = "<s:property value="%{getText('eaap.op2.conf.proof.OperationTips')}" />";
var selected_record = "<s:property value="%{getText('eaap.op2.conf.proof.PleaseselectArecord')}" />";
var sureDel = "<s:property value="%{getText('eaap.op2.conf.proof.sureDel')}" />";
var failureDel = "<s:property value="%{getText('eaap.op2.conf.proof.deleteFailed')}" />";
var successDel = "<s:property value="%{getText('eaap.op2.conf.proof.deleteSuccess')}" />";
var checkout = "<s:property value="%{getText('eaap.op2.conf.proof.checkout')}" />";

function deleteMethod(){
	var rows = $('#table').datagrid('getSelections');
    if(rows.length==0){
    	alert(selected_record);
    return false; 
    } 
    if(confirm(sureDel)){
    	var dataSourceId = rows[0].dataSourceId;
        $.ajax({
        type:"post",
        async:false,
        url:"../logServer/delDataSource.shtml",
        dataType:"text",
        data:{dataSourceId:dataSourceId},
        success:function(msg){
        if(msg=="ok"){
        	alert(successDel);
        }else if(msg=="fail"){
        	alert(failureDel);
        }else{
        	alert(msg);
        }
        $('#table').datagrid('reload');
    }
    });
    }
 }
		
function addMehtod(){
	//window.location.href="../logServer/gotoAddData.shtml"; 
	window.location.href="../logServer/editDataSource.shtml"; 
} 
          
function updateMethod(){
      var rows=$('#table').datagrid('getSelections');
      if(rows.length==0)
	    {
    	  alert(selected_record);
           return false;  
		}else
		{ 
		   var dataSourceId = rows[0].dataSourceId;
		   //window.location.href="../logServer/updateDataSource.shtml?dataSourceId="+dataSourceId;    
		   window.location.href="../logServer/editDataSource.shtml?dataSourceId="+dataSourceId;    
		}
}

window.onload = function(){
	$(".datagrid-cell-check").hide();
	var pageState=$("#pageState").attr('value');
    if(pageState!="") {
		$(".datagrid-toolbar").hide();
		document.getElementById("confirm").style.display= ""; 
		document.getElementById("searchBarTitle").style.display= "none"; 	
    }
}

function formatterForIsDefalut(value,row,index){
   if(value=='0'){
      return "<s:property value="%{getText('eaap.op2.conf.logserver.yes')}" />";
   }else{
      return "<s:property value="%{getText('eaap.op2.conf.logserver.no')}" />";
   }
}

function formatterForIsInit(value,row,index){
	if(value=='Y'){
	    return "<s:property value="%{getText('eaap.op2.conf.logserver.yes')}" />";
	}else{
	    return "<s:property value="%{getText('eaap.op2.conf.logserver.no')}" />";
	}
}

function getText(value){
	return value ? value : ""; 
}

function showObj(obj){
	var objStr="";
	for(items in obj){
		var str="objStr+=items+'='+obj."+items+"+'\\n';";
		eval(str);
	}
	return objStr;
}

function chooseMessageFlow()
{
	var vOpener=art.dialog.opener;
    var dataSourceId = $('#table').datagrid('getSelections')[0].dataSourceId;
    var attrName = $('#attrName').val();
    var objId = $('#objectId').val();
    var endId = $('#endpoint_Spec_Attr_Id').val();
    var newState = document.getElementById("newState").value;
	if('new' == newState){
		window.parent.editorPropertyValue(document.getElementById("objectId").value,
				document.getElementById("endpoint_Spec_Attr_Id").value,
				document.getElementById("attrSpecCode").value,dataSourceId);
		$(window.parent.document).find('#closeButton').click();
	}else{
		vOpener.editDynamicAttrFromSpecPage(attrName,dataSourceId,objId,endId);
		art.dialog.close();
	}
 }

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>