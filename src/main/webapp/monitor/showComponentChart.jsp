<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/linkbutton.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/tabs.css">
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.cookie.js"></script>
  </head>
   <body>
	  <div id="componentTab" class="easyui-tabs" style="height:300px">
		<div title="<s:property value="%{getText('eaap.op2.conf.monitor.view.serviceUse')}"/>" style="padding:10px">
			<iframe id="svcUseLine" scrolling="no" frameborder="0"  src="" style="border:0;width:100%;height:100%"></iframe>
		</div>
		<div title="<s:property value="%{getText('eaap.op2.conf.monitor.view.serviceReg')}"/>" style="padding:10px">
		   <iframe id="svcRegLine" scrolling="no" frameborder="0"  src="" style="border:0;width:100%;height:100%;"></iframe>
		</div>
		<div title="<s:property value="%{getText('eaap.op2.conf.monitor.view.performanceTab')}"/>"  style="padding:10px">
			<iframe id="performance" scrolling="no" frameborder="0"  src="" style="border:0;width:100%;height:100%"></iframe>
		</div>
	  </div>
  </body>
  <%
  	  String componentId = StringEscapeUtils.escapeHtml4(request.getParameter("componentId"));
   %>
  <script type="text/javascript">
	  $(function(){
		changeTab();
	 });
	
	function changeTab(){
		$('#componentTab').tabs({
			cache:false,
			tabPosition:'bottom',
			onSelect:function(title){
				 if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.serviceUse')}"/>"){
				 	$("#svcUseLine").attr("src","../monitor/loadComponentViewData.jsp?tabType=2&componentId="+<%=componentId%>);
				 }else if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.serviceReg')}"/>"){
				 	$("#svcRegLine").attr("src","../monitor/loadComponentViewData.jsp?tabType=3&componentId="+<%=componentId%>);
				 }else{
				 	$("#performance").attr("src","../monitor/loadComponentViewData.jsp?tabType=1&componentId="+<%=componentId%>);
				 }
			}
		});
		
		var refreshSecond = $.cookie('monitor_refreshTime');
		if (refreshSecond != null){
			setTimeout("changeTab()", refreshSecond);
		}
	}
</script>
</html>
