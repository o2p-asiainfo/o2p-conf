<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin=orange')}" escape="false"/>  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
   </head>
  <body>
   	<script type="text/javascript">
	   var title = [];
	   title[0]='<s:property value="%{getText('eaap.op2.conf.monitor.view.workId')}" />';
	   title[1]='<s:property value="%{getText('eaap.op2.conf.monitor.view.eventGrade')}" />';
	   title[2]='<s:property value="%{getText('eaap.op2.conf.monitor.view.eventContent')}" />';
	   title[3]='<s:property value="%{getText('eaap.op2.conf.monitor.view.distributeTime')}" />';
	</script>
	
	 <ui:gridEasy columns="cols" iconCls="" sortName="code" skin="${contextStyleTheme}" singleSelect="true" id="task_table" remoteSort="false" sortOrder="desc"
       	fit="true" collapsible="false"  title="" striped="true" pageList="10" pagination="true" rownumbers="false" method="eaap-op2-conf-monitor-MonitorViewAction.loadTodoWordGrid">
     	<ui:gridEasyColumn width="70" index="0" title="0" field="deal_Url" hidden="false" formatter="true" formatterMethod="formatterForOp" align="center"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="70" index="1" title="1" field="grade_Desc" hidden="false" align="center"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="440" index="2" title="2" field="content" hidden="false" align="center"></ui:gridEasyColumn>
        <ui:gridEasyColumn width="120" index="3" title="3" field="create_Date" hidden="false" align="center"></ui:gridEasyColumn>
    </ui:gridEasy>
 
 	<script type="text/javascript">
 		function formatterForOp(value,row,index){
 		    var resultStr = value.split(";");
    		return "<a href=\"#\" onclick=\"openWindows('"+resultStr[1]+"','<s:property value="%{getText('eaap.op2.conf.monitor.view.taskexec')}" />')\">"+resultStr[0]+"</a>" ;
   		}
 	</script>
  </body>
</html>