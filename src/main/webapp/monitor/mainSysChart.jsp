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
	  <div id="myTab" data-options="tools:'#all-tools'" class="easyui-tabs" style="height:300px">
	  	<div title="<s:property value="%{getText('eaap.op2.conf.monitor.view.allPerformance')}"/>" style="padding:10px">
			<iframe id="both" scrolling="no" frameborder="0"  src="" style="border:0;width:100%;height:100%"></iframe>
		</div>
		<div title="<s:property value="%{getText('eaap.op2.conf.monitor.view.csb')}"/>" style="padding:10px">
			<iframe id="svcUseLine" scrolling="no" frameborder="0"  src="" style="border:0;width:100%;height:100%"></iframe>
		</div>
		<div title="<s:property value="%{getText('eaap.op2.conf.monitor.view.svcLocal')}"/>" style="padding:10px">
		   <iframe id="svcRegLine" scrolling="no" frameborder="0"  src="" style="border:0;width:100%;height:100%;"></iframe>
		</div>
	  </div>
	  <div id="all-tools" style="border:3;PADDING-RIGHT:15px;padding-top:5px">
	  	<input type="checkbox" id="line_box1" name="lineBox" />&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.view.lineChart')}"/>
		<input type="checkbox" id="line_box2" name="lineBox" />&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.view.yibiaopan')}"/>
	  </div>
  </body>
  <%
  	String refreshSecond = StringEscapeUtils.escapeHtml4(request.getParameter("refreshSecond"));
  %>
  <script type="text/javascript">
   $(function(){
	 	//isChecked=1 ->line ,isChecked=0 ->yibiaopan
  	      $(':checkbox').click(function(){
  	         var tabObj = $('#myTab').tabs('getSelected');   
  	         var tabText = tabObj.panel('options').tab.text();
  	         
  	      	 if ($(this).attr('id') == 'line_box1'){
  	     		 if ($(this).attr('checked')== 'checked'){
  	     		 	$(this).attr('checked',true);
				    document.getElementById('line_box2').checked = false;
				   	changeChart(tabText);
			     }
			 }else{
			 	if ($(this).attr('checked')== 'checked'){
			 	   $(this).attr('checked',true);
				   document.getElementById('line_box1').checked = false;
				   changeChart(tabText);
				}
			 }
		 });
	 	changeTab();
  	 });
  	 
  	 function changeTab(){
  	 	 $('#myTab').tabs({
			cache:false,
			tabPosition:'bottom',
			onSelect:function(title){
				 if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.csb')}"/>"){
			 		if(($("#line_box1").attr('checked')==undefined || $("#line_box1").attr('checked')==false)){
						$("#svcUseLine").attr("src","../monitor/loadMainSysChartData.jsp?type=2&isChecked=0&refreshSecond="+<%=refreshSecond%>);
					}else{
						$("#svcUseLine").attr("src","../monitor/loadMainSysChartData.jsp?type=2&isChecked=1&refreshSecond="+<%=refreshSecond%>);
					}
				 }else if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.svcLocal')}"/>"){
			 		if(($("#line_box1").attr('checked')==undefined || $("#line_box1").attr('checked')==false)){
						$("#svcRegLine").attr("src","../monitor/loadMainSysChartData.jsp?type=3&isChecked=0&refreshSecond="+<%=refreshSecond%>);
					}else{
						$("#svcRegLine").attr("src","../monitor/loadMainSysChartData.jsp?type=3&isChecked=1&refreshSecond="+<%=refreshSecond%>);					
					}
				 }else if (title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.allPerformance')}"/>"){
				 	if(($("#line_box1").attr('checked')==undefined || $("#line_box1").attr('checked')==false)){
						$("#both").attr("src","../monitor/loadMainSysChartData.jsp?type=1&isChecked=0&refreshSecond="+<%=refreshSecond%>);
					}else{
						$("#both").attr("src","../monitor/loadMainSysChartData.jsp?type=1&isChecked=1&refreshSecond="+<%=refreshSecond%>);					
					}
				 }
			}
		});
		setTimeout("changeTab()",<%=refreshSecond%>);
  	 }
  	 function changeChart(title){
  	 	 if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.csb')}"/>"){
	 		if(($("#line_box1").attr('checked')==undefined || $("#line_box1").attr('checked')==false)){
				$("#svcUseLine").attr("src","../monitor/loadMainSysChartData.jsp?type=2&isChecked=0&refreshSecond="+<%=refreshSecond%>);
			}else{
				$("#svcUseLine").attr("src","../monitor/loadMainSysChartData.jsp?type=2&isChecked=1&refreshSecond="+<%=refreshSecond%>);
			}
		 }else if(title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.svcLocal')}"/>"){
	 		if(($("#line_box1").attr('checked')==undefined || $("#line_box1").attr('checked')==false)){
				$("#svcRegLine").attr("src","../monitor/loadMainSysChartData.jsp?type=3&isChecked=0&refreshSecond="+<%=refreshSecond%>);
			}else{
				$("#svcRegLine").attr("src","../monitor/loadMainSysChartData.jsp?type=3&isChecked=1&refreshSecond="+<%=refreshSecond%>);					
			}
		 }else if (title == "<s:property value="%{getText('eaap.op2.conf.monitor.view.allPerformance')}"/>"){
		 	if(($("#line_box1").attr('checked')==undefined || $("#line_box1").attr('checked')==false)){
				$("#both").attr("src","../monitor/loadMainSysChartData.jsp?type=1&isChecked=0&refreshSecond="+<%=refreshSecond%>);
			}else{
				$("#both").attr("src","../monitor/loadMainSysChartData.jsp?type=1&isChecked=1&refreshSecond="+<%=refreshSecond%>);					
			}
		 }
  	 }
</script>
</html>
