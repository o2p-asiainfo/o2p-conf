<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
  <%
		String panelTitle = StringEscapeUtils.escapeHtml4(request.getParameter("panelTitle"));
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
	Main.init_lineEchart_mainBiz("lineEchart");
	var panelTitle= decodeURIComponent("<%=panelTitle%>");
	$("#panelTitle").html(panelTitle);
	
	var isMax = "<%=request.getParameter("isMax")%>";
	if(isMax=="true"){
		$("#maxBut").hide();
	}
 });
 
 function getDate(strDate) {    
     var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,    
      function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');    
     return date;    
 }  

 function openMaxWind(){
 	openWindows(window.location.href+"&isMax=true",panelTitle,null,388);
 }
 </script>
<body>
          <div class="portlet box blue">
           <div class="portlet-title">
            <div class="caption"  id="panelTitle"></div>
            <div class="tools">
             	<a class="reload" href="javascript:;" data-target="lineEchart" data-url="${contextPath}/monitorView/getAllBizViewData.shtml?tabType=2&localTime={localTime}&timeOffset={timeOffset}"> </a>
				<a id="maxBut" class="glyphicon glyphicon-fullscreen s-fullscreen"  href="javascript:openMaxWind();"></a>
		</div>
            <div class="s-dropdown-menu pull-right">
             <a id="dp-system" href="javascript:;" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="false"> Service User <span class="caret"></span> </a>
             <ul class="dropdown-menu" role="menu" aria-labelledby="dp-system">
              <li><a href="javascript:;" data-url="${contextPath}/monitorView/getAllBizViewData.shtml?tabType=2&localTime={localTime}&timeOffset={timeOffset}">Service User</a> </li>
              <li><a href="javascript:;" data-url="${contextPath}/monitorView/getAllBizViewData.shtml?tabType=3&localTime={localTime}&timeOffset={timeOffset}">Service Provider</a> </li>
             </ul>
            </div>
           </div>
           <div class="portlet-body">
            <div id="lineEchart" style="height:299px"></div>
           </div>
          </div>
  </body>
</html>