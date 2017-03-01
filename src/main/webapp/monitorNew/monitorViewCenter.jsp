<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <title>VERIS Open Operational Platform</title>
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
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
 <!-- END CORE PLUGINS -->
 <!-- BEGIN PAGE LEVEL SCRIPTS -->
 <script src="${contextPath}/resource/monitor/scripts/core/app.js" type="text/javascript"></script>
 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/echarts/esl.js"></script>
 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/data-tables/DT_bootstrap.js"></script>
 <script src="${contextPath}/resource/monitor/scripts/custom/main.js" type="text/javascript"></script>
 <!-- END PAGE LEVEL SCRIPTS -->
 
 
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/panel.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/icon.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/portal.css">
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
    <script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.portal.js"></script> 
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeols.js')" escape="false"/>
	
 <style> 

 </style>
 <script>
var contextPath="${contextPath}";
</script>
</head>
<body>
<div class="page-content"  style="padding-top:16px;">    
    <div class="row"   style='display:none;'>
     <div class="col-md-12"  style="height:41px;">
      <!-- BEGIN BREADCRUMB-->     
      <ul class="page-breadcrumb breadcrumb">
       <i class="fa fa-home"></i>
       <li><s:property value="%{getText('eaap.op2.conf.monitor.view.SysName')}" /></li>
       <i class="fa fa-angle-right"></i>
       <li><s:property value="%{getText('eaap.op2.conf.monitor.view.monitoringView')}" /></li>
      </ul>
      <!-- END BREADCRUMB-->
     </div>
    </div>

    <!-- BEGIN TAB -->
    <div class="row">
     <div class="col-md-12">
      <div class="tabbable tabbable-custom boxless tabbable-reversed">
       <ul class="nav nav-tabs">
        <li class="active"> <a data-toggle="tab" href="#tab_0"  onClick="reLadMain()"><s:property value="%{getText('eaap.op2.conf.monitor.view.mainView')}" /></a> </li>
        <li> <a data-toggle="tab" href="#tab_1"  onClick="serSrc('bizFrame','showSingleBizViewIndexNew.shtml')"><s:property value="%{getText('eaap.op2.conf.monitor.view.bizView')}" /></a> </li>
        <li> <a data-toggle="tab" href="#tab_2"  onClick="serSrc('compFrame','showComponentViewIndexNew.shtml')"><s:property value="%{getText('eaap.op2.conf.monitor.view.componentView')}" /></a> </li>
        <li> <a data-toggle="tab" href="#tab_3"  onClick="serSrc('serFrame','showServiceViewIndexNew.shtml')"><s:property value="%{getText('eaap.op2.conf.monitor.view.svcPerformanceView')}" /></a> </li>
       </ul>
       <div class="tab-content">
	        <div id="tab_0" class="tab-pane active">
				<iframe id="mainFrame" src="${contextPath}/monitorView/findMonitorViewIndexNew.shtml" frameborder="0" scrolling="no" style="border:0;width:100%;height:820px;"></iframe>
	        </div>
	        <div id="tab_1" class="tab-pane " >
				<iframe id="bizFrame" src="" frameborder="0" scrolling="no" style="border:0;width:100%;height:820px;"></iframe>
	        </div>
	        <div id="tab_2" class="tab-pane">
				<iframe id="compFrame"  src="" frameborder="0" scrolling="no" style="border:0;width:100%;height:820px;"></iframe>
			</div>
	        <div id="tab_3" class="tab-pane">
				<iframe id="serFrame"  src="" frameborder="0" scrolling="no" style="border:0;width:100%;height:820px;"></iframe>
			</div>
       </div>
      </div>
     </div>
    </div>
 </div>

 <!-- Modal -->
 <div class="modal fade md-modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog s-modal-dialog-lg">
   <div class="modal-content">
    <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
     <h4 class="modal-title" id="myModalLabel">Modal title</h4>
    </div>
    <div class="modal-body" id="fullChart">
    </div>
   </div>
  </div>
 </div>
 <!-- /Modal -->
</body>
<!-- END BODY -->

</html>
<script type="text/javascript">
function serSrc(frameId,srcUrl){
	var srcc = $("#"+frameId).attr("src"); 
	if(srcc ==""){
		$("#"+frameId).attr("src","${contextPath}/monitorView/"+srcUrl);
	}
}

var needReLad=false;
function reLadMain(){
	if(needReLad){
		$("#mainFrame").attr("src","${contextPath}/monitorView/findMonitorViewIndexNew.shtml");
		needReLad=false;
	}
}
</script> 