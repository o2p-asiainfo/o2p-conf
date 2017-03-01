<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>	
<link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/>

<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>	
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAlias')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.docVersion')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.importObjectType')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.importFileOrURL')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.importTime')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.remark')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.wsdlImport.details')}" />';
</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png"  align="top"/>
	     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/>
      	</div>
    </div>
    
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
		</div>
    </div>
    
	<div class="formLayout" style="padding:5px 0;">
    <ui:form name="myForm" id="myForm" method="post">
    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAlias')}" />:
    				</dt>	
    				<dd>
    				   <ui:inputText skin="${contextStyleTheme}"  id="resourceAlias"  name="resourceAlias"  value="" />
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.wsdlImport.importObjectType')}" />:
    				</dt>
    				<dd>
					   	<ui:select skin="${contextStyleTheme}"  emptyOption="true"  headerValue=""  name="importObjectType"  id="importObjectType" 
				       	list="importObjectTypeList"  listKey="key" listValue="value"  style="width:70px;" ></ui:select>
    				</dd>
    		</dl>
    		<dl style="width:350px">
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.wsdlImport.importTime')}" />:
    				</dt>
    				<dd style="width:190px">
	     				 <div  style="width:190px;">
		     				<div style="float:left;width:90px;">
		     					<input id="importTimeBegin" name="importTimeBegin" style="width:90px; height:30px; border:1px solid #ccc; cursor:pointer;"/>  
		    				</div>
		    				<div style="float:left;width:9px;font-size:13px;">~</div>
		    				<div style="float:left;width:90px;">
		    					<input id="importTimeEnd" name="importTimeEnd" style="width:90px; height:30px; border:1px solid #ccc; cursor:pointer;"/>
		               	    
		 					</div>
	 					</div>
    				</dd>
    		</dl>
    		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
</ui:form>
</div>
<div style="clear:both;">
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="wsdlImportList"  remoteSort="false" sortOrder="desc"  
		fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.wsdlImport.wsdlImportList')}"  fitHeight="367"  striped="true" pageSize="10" pagination="true" frozenColumns="true"  toolbar="true" 
		rownumbers="true"   method="eaap-op2-conf-wsdlImport-WsdlImportAction.getWsdlImportList">
		<ui:gridEasyColumn width="200" index="0" title="0" field="RESOURCE_ALIAS"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="DOC_VERSION"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="150" index="2" title="2" field="IMPORT_OBJECT_TYPE_NAME"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="350" index="3" title="3" field="IMPORT_FILE_OR_URL"  hidden="false" align="center"  formatter="true"  formatterMethod="formatterForImportFileOrUrl" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="120" index="4" title="4" field="IMPORT_TIME"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="140" index="5" title="5" field="REMARK"  hidden="false" align="center"  formatter="true"  formatterMethod="formatterForRemark" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100"   index="6" title="6" field="IMPORT_ID"  hidden="false" align="center"  formatter="true" formatterMethod="formatterForOp" ></ui:gridEasyColumn>
	</ui:gridEasy>
</div>

<!--  table  class="mgr-table">
    <tr>
		<td  colspan="4"  align="center">
		  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.import')}"  id="import"  onclick="location='${contextPath}/wsdlImport/wsdlImport.shtml'"></ui:button>
		</td>
	</tr>
</table -->
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
$(document).ready(function(){
	  $('#btnadd').html("<span class='l-btn-left'><span class='l-btn-text icon-add l-btn-icon-left'><s:property value="%{getText('eaap.op2.conf.wsdlImport.import')}" /></span></span>");
	  $('#btncut').text("");
	  $('#btnsave').text("");
});

function searchFunc() {
   var form = $("#myForm").form();
      $('#wsdlImportList').datagrid("load", sy.serializeObject(form));
 }
 
function formatterForImportFileOrUrl(value,row,index){
    if(row.IMPORT_OBJECT_TYPE=="1"){
    	return "<a href='#' onclick=\"downloadAttach("+row.FILE_ATTACH_ID+");return false;\"   title='"+row.IMPORT_FILE+"'><img src='${contextPath}/resource/comm/images/download.png' align='absmiddle'/>"+row.IMPORT_FILE+"</a>";
    }else{
    	return "<a href='"+row.IMPORT_URL+"' target='_blank'  title='"+row.IMPORT_URL+"'><img src='${contextPath}/resource/comm/images/urlImg.png' align='absmiddle'/>"+row.IMPORT_URL+"</a>";
    }
}

function formatterForRemark(value,row,index){
    return "<div style=\"width:120px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;\" title=\""+row.REMARK+"\">"+row.REMARK+"</div>";
}

 function downloadAttach(fileAttachId){
	window.location="${contextPath}/fileShare/downloadFile.shtml?fileShare.sFileId="+fileAttachId;
 }

function addMehtod(){
       window.location="${contextPath}/wsdlImport/wsdlImport.shtml";
} 

function formatterForOp(value,row,index){
	var importId = row.IMPORT_ID;
	return "<a href='${contextPath}/wsdlImport/wsdlDetail.shtml?importId="+importId+"'><s:property value="%{getText('eaap.op2.conf.wsdlImport.details')}" />...</a>" ;
}

</script>
<script>
	$(document).ready(function(){
	  $('#importTimeBegin').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i'
		});
		$('#importTimeEnd').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i'
		});
	});
</script> 
<%@ include file="/common/ssoCommon.jsp"%> 
</html>