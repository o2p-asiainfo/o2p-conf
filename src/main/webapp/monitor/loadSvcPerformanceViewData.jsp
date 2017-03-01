<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
<html>
  <head>
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/FusionCharts.js"></script>
  </head>
  <%
  		String tabType = StringEscapeUtils.escapeHtml4(request.getParameter("tabType"));
  		String componentId = StringEscapeUtils.escapeHtml4(request.getParameter("componentId"));
  		String serviceCode = StringEscapeUtils.escapeHtml4(request.getParameter("serviceCode"));
   %>
  <div id="<%=serviceCode %>"></div>
  <script type="text/javascript">
  	  $(function(){
  	 	drawLine();
  	  });
  	  
	 function drawLine(){
	 	var sysErrTotal = '<s:property value="%{getText('eaap.op2.conf.monitor.view.sysErrTotal')}"/>';
	    var bizTotal = '<s:property value="%{getText('eaap.op2.conf.monitor.view.bizTotal')}"/>';
	    var bizErrTotal = '<s:property value="%{getText('eaap.op2.conf.monitor.view.bizErrTotal')}"/>';
	    
	    var allPerfomance = '<s:property value="%{getText('eaap.op2.conf.monitor.view.allPerformance')}"/>';
	    var csbPerfomance = '<s:property value="%{getText('eaap.op2.conf.monitor.view.csb')}"/>';
	    var supplyPerfomance = '<s:property value="%{getText('eaap.op2.conf.monitor.view.svcLocal')}"/>';
	    var yUnits;
	    if ("<%=tabType%>" == 1){
	    	 yUnits = '<s:property value="%{getText('eaap.op2.conf.monitor.view.svcYUnits')}"/>';
	    }else{
	    	 yUnits = '<s:property value="%{getText('eaap.op2.conf.monitor.view.YUnits')}"/>';
	    }
	    
		var chart = new FusionCharts("../resource/comm/swf/MSLine.swf", "svcChart", "100%", 260, "0", "1");
	 	$.ajax({
			url : '<%=request.getContextPath()%>/monitorView/loadSvcPerformanceViewData.shtml',
			cache : false,
			async : false,
			type : 'post',
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			data : {serviceCode :"<%=serviceCode%>",componentId:"<%=componentId%>",tabType:"<%=tabType%>",sysErrTotal:sysErrTotal,bizTotal:bizTotal,bizErrTotal:bizErrTotal,yUnits:yUnits,allPerfomance:allPerfomance,csbPerfomance:csbPerfomance,supplyPerfomance:supplyPerfomance},
			dataType : "json",
			success : function(response) {
	 	 		chart.setDataXML(response[0]); 
			}
		});
    	chart.render("<%=serviceCode %>");
	 }
</script>
</html>
