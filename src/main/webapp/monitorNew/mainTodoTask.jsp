<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
  <%
  	  String bizCode = StringEscapeUtils.escapeHtml4(request.getParameter("bizCode"));
  	  String panelTitle = StringEscapeUtils.escapeHtml4(request.getParameter("panelTitle"));
   %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <title></title>
 <meta content="width=device-width, initial-scale=1" name="viewport" />
 <meta content="" name="description" />
 
 <script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=${contextStyleTheme}" ></script> 
 <script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script> 
	
 <link href="${contextPath}/resource/monitor/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
 <link href="${contextPath}/resource/monitor/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" type="text/css" />
 <!-- END GLOBAL MANDATORY STYLES -->
 <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
 <link href="${contextPath}/resource/monitor/plugins/jquery-notific8/jquery.notific8.min.css" rel="stylesheet" type="text/css" />
 <%@ include file="/common/mainGlob.jsp"%>
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
 
 <%@ include file="/common/mainConfig.jsp"%>

 <!-- END CORE PLUGINS -->
 <!-- BEGIN PAGE LEVEL SCRIPTS -->
 <script src="${contextPath}/resource/monitor/scripts/core/app.js" type="text/javascript"></script>
 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/echarts/esl.js"></script>
 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/data-tables/DT_bootstrap.js"></script>
 <script src="${contextPath}/resource/monitor/scripts/custom/main.js" type="text/javascript"></script>
 <!-- END PAGE LEVEL SCRIPTS -->
 <script>
	var contextPath="${contextPath}";
	var taskListTitle = [];
	taskListTitle[0]='<s:property value="%{getText('eaap.op2.conf.monitor.view.workId')}" />';
	taskListTitle[1]='<s:property value="%{getText('eaap.op2.conf.monitor.view.processName')}" />';
	taskListTitle[2]='<s:property value="%{getText('eaap.op2.conf.monitor.view.eventContent')}" />';
	taskListTitle[3]='<s:property value="%{getText('eaap.op2.conf.monitor.view.submittedStaff')}" />';
	taskListTitle[4]='<s:property value="%{getText('eaap.op2.conf.monitor.view.distributeTime')}" />';
</script>
</head>
<body>
          <div class="portlet box blue" onclick="setDHeight();">
           <div class="portlet-title">
            <div class="caption" id="panelTitle"></div>
            <div class="tools">
             	<a class="reload" href="javascript:;" data-url="${contextPath}/monitorView/getTodoWordGrid.shtml" id="reloadDataTable"></a>
				<a id="maxBut" class="glyphicon glyphicon-fullscreen s-fullscreen"  href="javascript:openMaxWind();"></a>
            </div>
           </div>
           <div class="portlet-body" style="overflow-x:hidden;overflow-y:auto;"></div>
          </div>
 </body>
<script>
var dHeight=160;
jQuery(document).ready(function() {
	App.init();
	Main.init_tableListEchart("reloadDataTable");
	var panelTitle= decodeURIComponent("<%=panelTitle%>");
	$("#panelTitle").html(panelTitle);
  
	var isMax = "<%=request.getParameter("isMax")%>";
	if(isMax=="true"){
		$("#maxBut").hide();
	}
	window.setTimeout("setDHeight()",300); 
 });
 
function openMaxWind(){
	openWindows(window.location.href+"&isMax=true",panelTitle,null,388);
}

function setDHeight(){
	n=0;
	dHeight = $(".portlet-body").height();
	window.setTimeout("getDHeight()",500); 
}

var n=0;
function getDHeight(){
	var listHeight = $(".portlet-body").height();
	if(listHeight == dHeight){
		if(n<10){
			window.setTimeout("getDHeight()",500); 
		}else{
			setParentHeight(listHeight);
		}
		n++;
	}else{
		setParentHeight(listHeight);
	}
}

function setParentHeight(listHeight){
	var pf = $("#taskListFrame", window.parent.document);
	if(pf!=null){
		$("#taskListFrame", window.parent.document).height(listHeight+60);
	}
}

function reloadList(){
	Main.init_tableListEchart("reloadDataTable");
	setDHeight();
}

</script>
</html>
