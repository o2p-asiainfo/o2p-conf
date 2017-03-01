<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
   </head>
  <body>
   	<script type="text/javascript">
	   var title = [];
	   title[0]='<s:property value="%{getText('eaap.op2.conf.monitor.view.workId')}" />';
	   title[1]='<s:property value="%{getText('eaap.op2.conf.monitor.view.processName')}" />';
	   title[2]='<s:property value="%{getText('eaap.op2.conf.monitor.view.eventContent')}" />';
	   title[3]='<s:property value="%{getText('eaap.op2.conf.monitor.view.submittedStaff')}" />';
	   title[4]='<s:property value="%{getText('eaap.op2.conf.monitor.view.distributeTime')}" />';
	</script>
	
	<div class="formLayout" style="padding:5px 0;">
    <ui:form name="myForm" id="myForm" method="post">
    		<dl style="width:200px;">	
    				<dt style="width:100px;">
    					<s:property value="%{getText('eaap.op2.conf.monitor.view.processName')}" />:
    				</dt>	
    				<dd style="width:95px;">
    				   <ui:inputText skin="${contextStyleTheme}"  id="processName"  name="processName"  value=""  style="width:95px;"/>
    				</dd>
    		</dl>
    		<dl style="width:200px;">		
    				<dt style="width:100px;">
    					<s:property value="%{getText('eaap.op2.conf.monitor.view.eventContent')}" />:
    				</dt>
    				<dd  style="width:95px;">
    					<ui:inputText skin="${contextStyleTheme}"  id="eventContent" name="eventContent"  value=""  style="width:95px;"/>
    				</dd>
    		</dl>
    		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"  id="chaxun" onclick="searchFunc();" shape="s"/>
	</ui:form>
	</div>
	<div style="clear:both;">   
	 <ui:gridEasy columns="cols" iconCls="" sortName="code" skin="${contextStyleTheme}" singleSelect="true" id="task_table" remoteSort="false" sortOrder="desc"
       	fit="true" fitHeight="265" collapsible="false"  title="" striped="true" pageList="10" pagination="true" rownumbers="false" method="eaap-op2-conf-monitor-MonitorViewAction.loadTodoWordGrid">
     	<ui:gridEasyColumn width="70" index="0" title="0" field="deal_Url" hidden="false" formatter="true" formatterMethod="formatterForOp" align="center"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="100" index="1" title="1" field="proc_Name" hidden="false" align="center"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="440" index="2" title="2" field="content" hidden="false" align="left"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="60" index="3" title="3" field="src_User_Name" hidden="false" align="center"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="120" index="4" title="4" field="create_Date" hidden="false" align="center"></ui:gridEasyColumn>
    </ui:gridEasy>
 	</div>
 	<script type="text/javascript">
		function searchFunc() {
		   var form = $("#myForm").form();
		      $('#task_table').datagrid("load", sy.serializeObject(form));
		 }
		 
 		function formatterForOp(value,row,index){
 		    var resultStr = value.split(";");
    		return "<a href=\"#\" onclick=\"openWindows('"+resultStr[1]+"','<s:property value="%{getText('eaap.op2.conf.monitor.view.taskexec')}" />')\">"+resultStr[0]+"</a>" ;
   		}
 		function formatterForTaskType(value,row,index){
 		    if(value=="1"){
    			return "<font title=\"<s:property value="%{getText('eaap.op2.conf.monitor.view.processTacheCreateTask')}" />\"><s:property value="%{getText('eaap.op2.conf.monitor.view.processTacheCreateTask')}" /></font>" ;
 		    }else if(value=="2"){
    			return "<font title=\"<s:property value="%{getText('eaap.op2.conf.monitor.view.processTacheExecutionTask')}" />\"><s:property value="%{getText('eaap.op2.conf.monitor.view.processTacheExecutionTask')}" /></font>" ;
 		    }else if(value=="3"){
    			return "<font title=\"<s:property value="%{getText('eaap.op2.conf.monitor.view.processStartUpTask')}" />\"><s:property value="%{getText('eaap.op2.conf.monitor.view.processStartUpTask')}" /></font>" ;
 		    }else{
    			return "" ;
 		    }
   		}
 	</script>
  </body>
</html>
