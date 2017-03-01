<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
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
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.messageFlowId')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.messageFlowName')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.state')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.testPiles.descriptor')}" />';
</script>

<body>
<!--body start -->
<div class="contentWarp">
	<c:if test="${pageState !='choosePage'}">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.messageFlow')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.messageFlow')}"/>
      	</div>
    </div>
    </c:if>
    
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
  			<input name="chooseMessageFlowId" id="chooseMessageFlowId" type="hidden" value="${messageFlowId}" />
  			<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
			<input type="hidden" name="newState" id="newState" value="${newState}">
            <input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.testPiles.messageFlowName')}" />:
    				</dt>	
    				<dd >
    				   <ui:inputText skin="${contextStyleTheme}"  id="messageFlowName"  name="messageFlowName"  value="" />
    				</dd>
	 		</dl>
    				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
	</form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="messageFlowListId"  remoteSort="false" sortOrder="desc"  
			fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.messageFlowList')}"  striped="true"  fitHeight="336" pageSize="10" pagination="true" frozenColumns="true"  rownumbers="true"   method="eaap-op2-conf-messageFlow-MessageFlowAction.getMessageFlowList">
			<ui:gridEasyColumn width="200" index="0" title="0" field="MESSAGE_FLOW_ID"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="400" index="1" title="1" field="MESSAGE_FLOW_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="2" title="2" field="STATE"  hidden="false"  formatter="true" formatterMethod="formatterForState"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="3" title="3" field="DESCRIPTOR"  hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="4" title="4" field="FIRST_ENDPOINT_ID"  hidden="true" align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>

	<c:if test="${pageState =='choosePage'}">
		<table class="mgr-table"  style="width:100%;">
		   <tr>
		     <td align="center">
		        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseMessageFlow();"></ui:button>
		        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
			 </td>	
		   </tr>
		</table>
    </c:if>
</div>

</div>

</div>
</body>
<script>
function searchFunc() {
   var form = $("#myForm").form();
      $('#messageFlowListId').datagrid("load", sy.serializeObject(form));
 }

function formatterForState(value,row,index)
{
    if(value=='A')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.onUse')}" />' ;
    }else if(value=='R')
    {
    return '<s:property value="%{getText('eaap.op2.conf.testPiles.unUse')}" />' ;
    }
}

function chooseMessageFlow()
{
	var vOpener=art.dialog.opener;
    var chooseMessageFlowId = $('#messageFlowListId').datagrid('getSelections')[0].MESSAGE_FLOW_ID;
    var chooseMessageFlowName = $('#messageFlowListId').datagrid('getSelections')[0].MESSAGE_FLOW_NAME;
   // vOpener.document.getElementById("messageFlowId").value=chooseMessageFlowId;
   // vOpener.document.getElementById("defaultMsgFlow").value=chooseMessageFlowName;
    var newState = document.getElementById("newState").value;
	if('new' == newState){
		window.parent.editorPropertyValue(document.getElementById("objectId").value,
				document.getElementById("endpoint_Spec_Attr_Id").value,
				document.getElementById("attrSpecCode").value,chooseMessageFlowId);
		$(window.parent.document).find('#closeButton').click();
	}else{
		art.dialog.opener.setMessageFlowInfo(document.getElementById("attrName").value,chooseMessageFlowName, document.getElementById("objectId").value,chooseMessageFlowId);				//serviceManager/serviceUpdate.jsp
	    art.dialog.close();
	}
    
 }

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
