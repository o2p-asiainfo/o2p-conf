<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>	
	
	<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.prov.nodeName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.prov.nodeCode')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.prov.parentNode')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.prov.nodePath')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.portal.prov.contractStatu')}" />';
	
	   //search Function
	function searchNodeDesc(){		
		 var form=$("#showNodeDescForm").form();
	      $('#nodeDescList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 					   
   }
   		 
   function addMehtod(){	  
   } 
             
  function updateMethod(){      
    }	 
    
  function clickMethod(index,field,value){   
	} 
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.contractManage')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.prov.chooseNode')}" />
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
	<ui:form id="showNodeDescForm" name="showNodeDescForm" method="post" action="showNodeDesc.shtml">

    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.prov.nodeName')}" />:
    				</dt>	
    				<dd >
    				<ui:inputText id="nodeDescName"  name="nodeDescName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/>
    				   <input id="tcpCtrFId" name="tcpCtrFId" value="${tcpCtrFId}" type="hidden">
    				   <input id="nodeDescId" name="nodeDescId" value="${nodeDescId}" type="hidden">
    				   <input id="rowIndex" name="rowIndex" value="${rowIndex}" type="hidden">
    				   <input id="reqRspFlag" name="reqRspFlag" value="${reqRspFlag}" type="hidden">
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    				
    					<s:property value="%{getText('eaap.op2.conf.prov.nodeCode')}" />:
    				</dt>
    				<dd >
    				<ui:inputText id="nodeDescCode"  name="nodeDescCode"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/>
    				</dd>
    		</dl>

   	      	<div style="text-align:right;float:right; margin-bottom:5px ;">
					<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchNodeDesc();" skin="${contextStyleTheme}"/>  
		 	</div>
	</ui:form>
	</div>
	<div style=" clear:both;">
	    <ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code"  singleSelect="true"  id="nodeDescList"  remoteSort="false" sortOrder="desc"  queryParams="true"  queryParamsData="[{tcpCtrFId=${tcpCtrFId},nodeDescId=${nodeDescId}}]"  
					fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.prov.nodeList')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   method="eaap-op2-conf-contract-ContractAction.getNodeDescList">
			<ui:gridEasyColumn width="300" index="0" title="0" field="NODE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="260" index="1" title="1" field="NODE_CODE" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="2" title="2" field="PARENT_NODE_NAME" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="300" index="3" title="3" field="NODE_PATH" hidden="false"   align="center" ></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="1" index="4" title="4" field="NODE_DESC_ID" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
	 </div>
	 </div>
	 <table class="mgr-table" id="confirm">
		  <tr>
		    <td  colspan="4"  align="center">
		       <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseNodeDesc();"></ui:button>
		       <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();art.dialog.opener.changeTopScrollHeight();"></ui:button>
			</td>	
	     </tr>
	  </table>
</div>
</body>
<script>
	function chooseNodeDesc() {
	    var vOpener=art.dialog.opener;
	    var chooseNodeName = $('#nodeDescList').datagrid('getSelections')[0].NODE_NAME ;
	    var chooseNodeId = $('#nodeDescList').datagrid('getSelections')[0].NODE_DESC_ID ;
	    if(chooseNodeName=="") {
      		alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	     }else{
    	 	vOpener.setParentNodeInfo($('#rowIndex').val(),chooseNodeName,chooseNodeId,$('#reqRspFlag').val());
	 	 	art.dialog.close(); 
		 }
 	}
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>