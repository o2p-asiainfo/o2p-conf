<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
 
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.messageFlow.cvsFileName')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.messageFlow.fieldSeparator')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.messageFlow.dateFormat')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.messageFlow.charset')}" />';
</script>

<body>
<!--body start -->
<div class="contentWarp">
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
		</div>
    </div>
    
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
    <form name="myForm"  id="myForm" method="post">
			<input name="attrName" id="attrName" type="hidden" value="${attrName}"/>
  			<input name="objectId" id="objectId" type="hidden" value="${objectId}"/>
  			<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="hidden" value="${endpoint_Spec_Attr_Id}"/>
  			<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
			<input type="hidden" name="newState" id="newState" value="${newState}">
            <input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
    		<dl>		
    				<dt>
    					CVS File Name:
    				</dt>	
    				<dd >
    				   <ui:inputText skin="${contextStyleTheme}"  id="cvsFileName"  name="cvsFileName"  value="" />
    				</dd>
	 		</dl>
    				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
	</form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="messageFlowListId"  remoteSort="false" sortOrder="desc"  
			fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.messageFlow.csvTemplate')}"  striped="true"  fitHeight="336" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true" toolbar="true"  method="eaap-op2-conf-messageFlow-MessageFlowAction.getCvsTempleteList">
			<ui:gridEasyColumn width="400" index="0" title="0" field="CSV_FILE_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="1" title="1" field="FIELD_SEPARATOR"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="2" title="2" field="DATE_FORMAT"  hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="3" title="3" field="FILE_CHARSET"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="4" title="4" field="CSV_TEMPLATE_ID"  hidden="true" align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
		<table class="mgr-table"  style="width:100%;">
		   <tr>
		     <td align="center">
		        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseMessageFlow();"></ui:button>
		        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
			 </td>	
		   </tr>
		</table>
</div>

</div>

<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</div>
</body>
<script>
function searchFunc() {
   var form = $("#myForm").form();
      $('#messageFlowListId').datagrid("load", sy.serializeObject(form));
 }
var operationTip = "<s:property value="%{getText('eaap.op2.conf.proof.OperationTips')}" />";
var selected_record = "<s:property value="%{getText('eaap.op2.conf.proof.PleaseselectArecord')}" />";
var sureDel = "<s:property value="%{getText('eaap.op2.conf.proof.sureDel')}" />";
var failureDel = "<s:property value="%{getText('eaap.op2.conf.proof.deleteFailed')}" />";
var successDel = "<s:property value="%{getText('eaap.op2.conf.proof.deleteSuccess')}" />";
var checkout = "<s:property value="%{getText('eaap.op2.conf.proof.checkout')}" />";
function deleteMethod(){
	var rows = $('#messageFlowListId').datagrid('getSelections');
    if(rows.length==0){
    	alert(selected_record);
    return false; 
    } 
    if(confirm(sureDel)){
    	var template_id = rows[0].CSV_TEMPLATE_ID;
        $.ajax({
        type:"post",
        async:false,
        url:"../messageFlow/delTemplate.shtml",
        dataType:"text",
        data:{template_id:template_id},
        success:function(msg){
        if(msg=="ok"){
        	alert(successDel);
        }else if(msg=="fail"){
        	alert(failureDel);
        }else{
        	alert(msg);
        }
        $('#messageFlowListId').datagrid('reload');
    }
    });
    }
 }
		
function addMehtod(){
	window.location.href="../messageFlow/gotoAddPage.shtml?attrName="+$('#attrName').val()+'&objectId='+$('#objectId').val()+'&endpoint_Spec_Attr_Id='+$('#endpoint_Spec_Attr_Id').val()+'&attrSpecCode='+$('#attrSpecCode').val()+'&newState=new'; 
} 
          
function updateMethod(){
      var rows=$('#messageFlowListId').datagrid('getSelections');
      if(rows.length==0)
	    {
    	  alert(selected_record);
           return false;  
		}else
		{ 
		   var template_id = rows[0].CSV_TEMPLATE_ID;
		   window.location.href="../messageFlow/updateTemplate.shtml?template_id="+template_id+'&attrName='+$('#attrName').val()+'&objectId='+$('#objectId').val()+'&endpoint_Spec_Attr_Id='+$('#endpoint_Spec_Attr_Id').val()+'&attrSpecCode='+$('#attrSpecCode').val()+'&newState=new';    
		}
}
function chooseMessageFlow()
{
	var vOpener=art.dialog.opener;
    var templateId = $('#messageFlowListId').datagrid('getSelections')[0].CSV_TEMPLATE_ID;
    var attrName = $('#attrName').val();
    var objId = $('#objectId').val();
    var endId = $('#endpoint_Spec_Attr_Id').val();
    var newState = document.getElementById("newState").value;
	if('new' == newState){
		window.parent.editorPropertyValue(document.getElementById("objectId").value,
				document.getElementById("endpoint_Spec_Attr_Id").value,
				document.getElementById("attrSpecCode").value,templateId);
		$(window.parent.document).find('#closeButton').click();
	}else{
		vOpener.editDynamicAttrFromSpecPage(attrName,templateId,objId,endId);
		art.dialog.close();
	}
 }

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
