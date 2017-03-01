<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/uploadify.css" /> 
    <link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/docUpload.css" />  
	<script type="text/javascript" src="${contextPath}/resource/comm/js/swfobject.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/doc_upload.js"></script>
	<script>
	
	$(function(){
		initUploadify();
	});
	
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.contract.doc.docName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.contract.doc.createDate')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.contract.doc.state')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.contract.doc.stateTime')}" />';
	

    </script>
</head>
<body>

<!--body start -->
<div class="contentWarp">
    <div>
	<ui:form id="showContractForm" method="post" action="showContract.shtml">
    		<table class="mgr-table" style="width:100%;font-size:12px;">
    			<tr>
    				<td  align="right" width="150">
    					<s:property value="%{getText('eaap.op2.portal.prov.contractName')}" />:
    				</td>	
    				<td >
    				   <ui:inputText id="contractName"  name="contractName"  readonly="false"/>
    				</td>
    				<td align="right" width="150">
    					
    				</td>
    				<td colspan="6" style="TEXT-ALIGN: left;">
    					<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchContract();"/>  					 
    				</td>
    			</tr>    			
    		</table>		
	</ui:form>
	<br/>	
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="contractDocTab" remoteSort="false" sortOrder="desc"  toolbar="true"
			fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   method="eaap-op2-conf-contractDoc-DocAction.getContractDocList">		  
			<ui:gridEasyColumn width="350" index="0" title="0" field="DOCNAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="1" title="1" field="DOCVERSION" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="2" title="2" field="DOCCREATETIME" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="3" title="3" field="STATE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="4" title="4" field="LASTESTTIME" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="50" index="5" title="5" field="CONTRACTDOCID" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
   </div>
</div>
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>