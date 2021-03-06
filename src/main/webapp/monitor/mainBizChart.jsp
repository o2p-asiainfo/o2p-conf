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
  </head>
  <body>
	  <div id="myTab" class="easyui-tabs" style="height:300px">
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
  	String refreshSecond = StringEscapeUtils.escapeHtml4(request.getParameter("refreshSecond"));
   %>
  <script type="text/javascript">
  	 $(function(){
		changeTab();
	 });
	 
	 function changeTab(){
	 	$('#myTab').tabs({
			cache:false,
			tabPosition:'bottom',
			onSelect:function(title){
				 if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.serviceUse')}"/>"){
				 	$("#svcUseLine").attr("src","../monitor/loadMainBizChartData.jsp?type=2");
				 }else if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.serviceReg')}"/>"){
				 	$("#svcRegLine").attr("src","../monitor/loadMainBizChartData.jsp?type=3");
				 }else{
				 	$("#performance").attr("src","../monitor/loadMainBizChartData.jsp?type=1");
				 }
			}
		});
		setTimeout("changeTab()",<%=refreshSecond%>);
	 }
</script>
</html>
