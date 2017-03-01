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
	title[0]='<s:property value="%{getText('eaap.op2.conf.task.schdInstId')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.task.eventType')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.task.jobName')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.task.jobClass')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.task.staffNo')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.task.ip')}"/>';
	title[6]='<s:property value="%{getText('eaap.op2.conf.task.logType')}"/>';
	title[7]='<s:property value="%{getText('eaap.op2.conf.task.createDT')}" />';
	
	   //search Function
	function searchTask(){		
		 var form = $("#showTaskForm").form();
	      $('#taskLogList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 					   
	  
	}
	   		 
	function addMehtod(){	  
	
		if($('#taskLogList').datagrid('getSelections')[0]==null||$('#taskLogList').datagrid('getSelections')[0].taskLogId==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
    	}
    	else{
    		var taskLogId = $('#taskLogList').datagrid('getSelections')[0].taskLogId ;
    	    window.location="gotoTaskLogDetail.shtml?taskLogId=" + taskLogId;	
    	} 	
	} 
	             
	function updateMethod(){   
	     
	}	 
	    
	function clickMethod(index,field,value){   
	
	} 
	
	function closecurry(){
		
	}
	function formatterForState(value,row,index){
	    if(value=='1'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType1')}" />"  ;
	    } else if(value=='2'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType2')}" />"  ;
	    } else if(value=='3'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType3')}" />"  ;
	    } else if(value=='4'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType4')}" />"  ;
	    } else if(value=='5'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType5')}" />"  ;
	    } else if(value=='6'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType6')}" />"  ;
	    } else if(value=='7'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType7')}" />"  ;
	    } else if(value=='8'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType8')}" />"  ;
	    } else if(value=='9'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType9')}" />"  ;
	    } else if(value=='10'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType10')}" />"  ;
	    }
	 }
	function formatterForLogState(value,row,index){
	    if(value=='1'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.logType1')}" />"  ;
	    }else if(value=='2'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.logType2')}" />"  ;
	    }
	 }
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.task.taskLog')}" />      
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0; clear:both;">
	<ui:form id="showTaskForm" method="post" action="showTask.shtml">
    		<dl class="noBorder">	
    				<dt><s:property value="%{getText('eaap.op2.conf.task.jobName')}" />:</dt>	
    				<dd><ui:inputText id="jobName"  name="jobName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
			</dl>
			<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchTask();" skin="${contextStyleTheme}"/>
	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="taskLogList" remoteSort="false" sortOrder="desc"  toolbar="true"
		onClickCell="true"  skin="${contextStyleTheme}" fit="true" collapsible="true"   
		title="%{getText('eaap.op2.conf.task.ftpTask')}" 
		striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
		method="eaap-op2-conf-task-action-taskLogAction.getTaskLogList">
		<ui:gridEasyColumn width="120" index="0" title="0" field="schdInstId" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80"  index="1" title="1" field="eventType" hidden="false" align="center" formatter="true" formatterMethod="formatterForState"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="2" title="2" field="jobName" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="3" title="3" field="jobClass" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="4" title="4" field="staffNo" hidden="true"   align="center" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="5" title="5" field="ip" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="6" title="6" field="logType" hidden="false"   align="center"  formatter="true" formatterMethod="formatterForLogState"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="7" title="7" field="createDT" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="10"  index="8" title="8" field="taskLogId" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="10"  index="9" title="9" field="taskId" hidden="true"   align="center" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="10" index="10" title="10" field="sessionId" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
   </div>
   </div>
</div>
<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
<script>
	$(document).ready(function(){
	  $('#btnadd span span').text("Detail")
	                        .removeClass()
	                        .addClass("l-btn-text icon-remove l-btn-icon-left");
	  $('#btncut').text("");
	  $('#btnsave').text("");
	  $('.datagrid-btn-separator').removeClass();
	});
</script>
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>