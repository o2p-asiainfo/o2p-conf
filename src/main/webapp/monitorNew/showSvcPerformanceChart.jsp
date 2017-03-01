<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
  <%
  	  String componentId 	= StringEscapeUtils.escapeHtml4(request.getParameter("componentId"));		//component.code
  	  String serviceCode 		= StringEscapeUtils.escapeHtml4(request.getParameter("serviceCode"));
  	  String refreshSecond 	= StringEscapeUtils.escapeHtml4(request.getParameter("refreshSecond"));
  	  String panelTitle 			= StringEscapeUtils.escapeHtml4(request.getParameter("panelTitle"));
  	  String tipTitle 				= StringEscapeUtils.escapeHtml4(request.getParameter("tipTitle"));
   %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <title>VERIS Open Operational Platform</title>
 <meta content="width=device-width, initial-scale=1" name="viewport" />
 <meta content="" name="description" />
 <link href="${contextPath}/resource/monitor/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" type="text/css" />
 <!-- END GLOBAL MANDATORY STYLES -->
 <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
 <link href="${contextPath}/resource/monitor/plugins/jquery-notific8/jquery.notific8.min.css" rel="stylesheet" type="text/css" />
 <!-- END PAGE LEVEL PLUGIN STYLES -->
 <!-- BEGIN THEME STYLES -->
 <link href="${contextPath}/resource/monitor/css/style-plus.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/css/style.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/css/style-responsive.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/css/plugins.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/css/themes/orange.css" rel="stylesheet" type="text/css" id="style_color" />
 <link href="${contextPath}/resource/monitor/css/custom.css" rel="stylesheet" type="text/css" />
 <!-- END THEME STYLES -->
 
 <script src="${contextPath}/resource/monitor/plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/jquery.blockui.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/jquery.cokie.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/data-tables/jquery.dataTables.min.js" type="text/javascript"></script>
 <script src="${contextPath}/resource/monitor/plugins/jquery-notific8/jquery.notific8.min.js" type="text/javascript"></script>
 <%@ include file="/common/mainConfig.jsp"%>
 <!-- END CORE PLUGINS -->
 <!-- BEGIN PAGE LEVEL SCRIPTS -->
 <script src="${contextPath}/resource/monitor/scripts/core/app.js" type="text/javascript"></script>
 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/echarts/esl.js"></script>
 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/data-tables/DT_bootstrap.js"></script>
 <script src="${contextPath}/resource/monitor/scripts/custom/main.js" type="text/javascript"></script>
 <!-- END PAGE LEVEL SCRIPTS -->
 <script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=orange" ></script>  
 <script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script>
 <script>
var contextPath="${contextPath}";
</script>
  </head>
<script>
 jQuery(document).ready(function() {
	var d=new Date();
	var searchTime = jQuery('#searchTime',window.parent.document).val();
	if(searchTime !=null && searchTime !=undefined && searchTime !="undefined" && searchTime!=""){
		 d = getDate(searchTime+":00");
		 d.setMinutes(d.getMinutes()+1);
	 }
	var localTime 		=	d.getTime(); 
	var timeOffset	=	d.getTimezoneOffset();
	var bodyHtml = document.body.innerHTML;
	bodyHtml = bodyHtml.replace(new RegExp(/({localTime})/g),localTime);
	bodyHtml = bodyHtml.replace(new RegExp(/({timeOffset})/g),timeOffset);
	document.body.innerHTML=bodyHtml;
	
	App.init();
	Main.init_lineEchart("lineEchart");
	var panelTitle= decodeURIComponent("<%=panelTitle%>");
	$("#panelTitle").html(panelTitle);
	$("#panelTitle").attr("title",panelTitle);
	
	var panelId = "<%=request.getParameter("panelId")%>";
	if(panelId !="null" && panelId !=""){
		$("#addBut").hide();
		$("#delBut").show();
	}else{
		$("#addBut").show();
		$("#delBut").hide();
	}
	
	var isMax = "<%=request.getParameter("isMax")%>";
	if(isMax=="true"){
		$("#maxBut").hide();
		$("#addBut").hide();
		$("#delBut").hide();
	}
	
	setTimeout("setPanelTitleWidth()",200);
 });
 
 function setPanelTitleWidth(){
		$("#panelTitle").width(window.document.body.offsetWidth -215);
 }
 
 function getDate(strDate) {    
     var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,    
      function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');    
     return date;    
 }  

 function openMaxWind(){
 	openWindows(window.location.href+"&isMax=true",panelTitle,null,388);
 }
 
 function addPanel(){
	var panelTitle	= decodeURIComponent("<%=panelTitle%>");
	var tipTitle		= decodeURIComponent("<%=tipTitle%>");
 	window.parent.addPanel("<%=componentId%>","<%=serviceCode%>",panelTitle,tipTitle);
 }
 
 function deletePanel(){
	var panelId ="<%=request.getParameter("panelId")%>";
 	window.parent.deletePanel(panelId);
 }
 </script>
  <body>
          <div class="portlet box blue">
           <div class="portlet-title">
	            <div class="caption" id="panelTitle"  style="width:350px; white-space:nowrap;overflow:hidden;text-overflow:ellipsis;"></div>
	            <div class="tools">
	             	<a class="reload" href="javascript:;" data-target="lineEchart" data-url="${contextPath}/monitorView/getSingleServiceData.shtml?tabType=1&componentId=<%=componentId%>&localTime={localTime}&timeOffset={timeOffset}"> </a>
					<a id="addBut" class="glyphicon glyphicon-plus s-fullscreen"  href="javascript:addPanel();"></a>
					<a id="delBut" class="glyphicon glyphicon-minus s-fullscreen"  href="javascript:deletePanel();"></a>
					<a id="maxBut" class="glyphicon glyphicon-fullscreen s-fullscreen"  href="javascript:openMaxWind();"></a>
				</div>
	            <div class="s-dropdown-menu pull-right">
		             <a id="dp-system" href="javascript:;" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false"> Performance <span class="caret"></span> </a>
		             <ul class="dropdown-menu" role="menu" aria-labelledby="dp-system">
		              <li><a href="javascript:;" data-url="${contextPath}/monitorView/getSingleServiceData.shtml?tabType=1&componentId=<%=componentId%>&localTime={localTime}&timeOffset={timeOffset}">Performance</a> </li>
		              <!-- li><a href="javascript:;" data-url="${contextPath}/monitorView/getSingleServiceData.shtml?tabType=2&serviceCode=< %=serviceCode%>&componentId=< %=componentId%>&localTime={localTime}&timeOffset={timeOffset}">Service User</a> </li-->
		              <li><a href="javascript:;" data-url="${contextPath}/monitorView/getSingleServiceData.shtml?tabType=3&componentId=<%=componentId%>&localTime={localTime}&timeOffset={timeOffset}">Service Provider</a> </li>
		             </ul>
	            </div>
           </div>
           <div class="portlet-body">
            <div id="lineEchart" style="height:299px"></div>
           </div>
          </div>
  </body>
</html>