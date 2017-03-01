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
  		String type = StringEscapeUtils.escapeHtml4(request.getParameter("type"));
  		String isChecked = StringEscapeUtils.escapeHtml4(request.getParameter("isChecked"));
   %>
  <div id="sysChartId"></div>
  <script type="text/javascript">
  	  $(function(){
  	 		drawLine();
  	  });
  	 var unitSecond = "<s:property value="%{getText('eaap.op2.conf.monitor.view.unitSecond')}"/>";
	 var unitMs = "<s:property value="%{getText('eaap.op2.conf.monitor.view.svcYUnits')}"/>";
	 
	 function drawLine(){
	 	var tabType = <%=type%>;
	 	var chartType = <%=isChecked%>;
	 	var dataUrl;
	 	var swfUrl;
	 	if (tabType == "2"){
	 		if(chartType == "1"){ //line
	 			dataUrl = "${contextPath}/monitorView/querySysViewData.shtml?chartType=1&tabType=2";
	 			swfUrl = "../resource/comm/swf/Line.swf";
	 			loadLineData(swfUrl,dataUrl);
	 		}else{ //yibiaopan
	 			dataUrl = "${contextPath}/monitorView/querySysViewData.shtml?chartType=0&tabType=2";
	 			swfUrl = "../resource/comm/swf/AngularGauge.swf";
	 			loadLineData(swfUrl,dataUrl);
	 		}
	 	}else if (tabType == "3"){
	 		if(chartType == "1"){ //line
	 			dataUrl = "${contextPath}/monitorView/querySysViewData.shtml?chartType=1&tabType=3";
	 			swfUrl = "../resource/comm/swf/Line.swf";
	 			loadLineData(swfUrl,dataUrl);
	 		}else{ //yibiaopan
	 			dataUrl = "${contextPath}/monitorView/querySysViewData.shtml?chartType=0&tabType=3";
	 			swfUrl = "../resource/comm/swf/AngularGauge.swf";
	 			loadLineData(swfUrl,dataUrl);
	 		}
	 	}else if (tabType == "1"){
	 		if(chartType == "1"){ //line
	 			dataUrl = "${contextPath}/monitorView/querySysViewData.shtml?chartType=1&tabType=1";
	 			swfUrl = "../resource/comm/swf/Line.swf";
	 			loadLineData(swfUrl,dataUrl);
	 		}else{ //yibiaopan
	 			dataUrl = "${contextPath}/monitorView/querySysViewData.shtml?chartType=0&tabType=1";
	 			swfUrl = "../resource/comm/swf/AngularGauge.swf";
	 			loadLineData(swfUrl,dataUrl);
	 		}
	 	}
	 }
	 
	  function loadLineData(swfUrl,dataUrl){
		var chart = new FusionCharts(swfUrl, "sysChart", "100%", 260, "0", "1");
	 	$.ajax({
			url : dataUrl,
			cache : false,
			async : false,
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			type  : 'POST',
			data  : {unitMs:unitMs,unitSecond:unitSecond},
			dataType : "json",
			success : function(response) {
	 	 		chart.setDataXML(response[0]); 
			}
		});
    	chart.render("sysChartId"); 
	 }
</script>
</html>
