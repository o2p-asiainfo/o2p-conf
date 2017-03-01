<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html> 
  <head>
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/panel.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/icon.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/portal.css">
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
    <script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.portal.js"></script> 
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeols.js')" escape="false"/>
	 <link href="${contextPath}/resource/monitor/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	 <link href="${contextPath}/resource/monitor/css/style-plus.css" rel="stylesheet" type="text/css" />
	 
	<link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/ >
	<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>
 </head>
 <!--body start -->
<body>
<div class="contentWarp"  style="margin:0; padding:0; min-height: 420px;">
  	 <form method="post" id="myform" name="myform" action="${contextPath}/monitorView/findMonitorViewIndexNew.shtml">
   	<table >
   		<tr>
   			<td style="text-align:center; padding:0 10px;"><s:property value="%{getText('eaap.op2.conf.monitor.view.Time')}" />:</td>
   			<td>
	            <input type="text" id="searchTime" name="searchTime"  value="${searchTime}" readonly style="width:180px; height:35px; border:1px solid #ccc; cursor:pointer;"/>
   			</td>
   			<td style="padding-left:2px;">
				<button type="button" onclick="myform.submit()" class="btn blue"><i class="fa fa-search"></i> <s:property value="%{getText('eaap.op2.conf.monitor.view.btnOk')}" /></button>
  			</td>
   		</tr>
   	</table>
   	</form>
   	
   	<!-- div class="testModules panel-body panel-body-noheader portal-p" style="overflow: hidden; border: 0px none; float: left; width: 90%; height: auto;" title="" id="1">
   		<iframe frameborder="0" style="border:0;width:100%; height:358px;" scrolling="no" src="../monitorNew/mainTodoTask.jsp?refreshSecond=60000&amp;panelTitle=Task%2520List&amp;panelId=1"></iframe>
   	</div -->
   	
	<div style="position:relative;overflow-x:hidden; margin:7px 0 0 0; padding:0; text-align:center;"><iframe id="taskListFrame"  frameborder="0" style="border:0;width:100%; height:358px;" scrolling="no" src="../monitorNew/mainTodoTask.jsp?refreshSecond=60000&amp;panelTitle=Task%2520List&amp;panelId=1"></iframe></div>
	
	<div id="portal">
		<div></div>
		<div></div>
	</div>
</div>
</body>
<!--body end -->
<%@ include file="/common/ssoCommon.jsp"%>
<script type="text/javascript">
	var portal;
	var col;
	$(function() {
		var refreshSecond = 60000;
		loadCfgPanel(refreshSecond);

		$('#searchTime').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i'
		});
	});
	function changeTime(refreshSecond){
		 $("#portal div").html("");
	 	 loadCfgPanel(refreshSecond);
	}
	 
	function loadCfgPanel(refreshSecond){
		col = $('#portal div').length;
		portal = $('#portal').portal({
			border : false,
			fit : true,
			onStateChange:function(){
				var new_view = [];
				$(".testModules").each(function(){
					new_view.push(this.id);
				});
				var newPanelId = new_view.join(",");
				$.ajax({
					type : 'post',
					url  : '<%=request.getContextPath()%>/monitorView/savePortalPanelCfg.shtml',
					cache: false,
					data : {panelId : newPanelId},
					success : function(response){
					}
				});
			}
		});
		$.ajax({
			url : '<%=request.getContextPath()%>/monitorView/queryModuleViewInfo.shtml',
			cache : false,
			dataType : "json",
			success : function(response) {
				if (response && response.rows) {
					var rows = response.rows;
					var hasTask=0;
					for ( var i = 0; i < rows.length; i++) {
						var src;
						if (/^\//.test(rows[i].path)) {
							src = rows[i].path.substr(1);
						} else {
							src = rows[i].path;
						}
						
						if(src.indexOf("mainTodoTask")>-1){
							hasTask = 1;
							continue;
						}
						
						if (src.indexOf("?")== -1){
							src += "?refreshSecond="+refreshSecond+"&panelTitle="+encodeURIComponent(encodeURIComponent(rows[i].title))+"&panelId="+rows[i].portalPanelId;
						}else{
							src += "&refreshSecond="+refreshSecond+"&panelTitle="+encodeURIComponent(encodeURIComponent(rows[i].title))+"&panelId="+rows[i].portalPanelId;
						}

						var p = $('<div style="overflow:hidden;border:0; float:left;" class="testModules" />').appendTo('body').panel({
						    id : rows[i].portalPanelId,
							content : '<iframe src="' + src + '" frameborder="0" scrolling="no" style="border:0;width:100%; height:358px;"></iframe>'
						});
						portal.portal('add', {
							panel : p,
							columnIndex : (i-hasTask) % col
						});
					}
					portal.portal('resize');
					
					var vPortalHeight =Math.ceil((rows.length-hasTask)/2)*370+400;
					$("#portal").height(vPortalHeight);
					if(vPortalHeight >700){
						$("#mainFrame", window.parent.document).height(vPortalHeight);
					}
				}
			}
		});
	}
	function changeView(currentView){
 		if(currentView == "2"){
 			window.location.href = "${contextPath}/monitorView/showComponentViewIndex.shtml";	
 		}else if (currentView == "3"){
 			window.location.href = "${contextPath}/monitorView/showServiceViewIndex.shtml";	
 		}else if (currentView == "1"){
 			window.location.href = "${contextPath}/monitorView/showSingleBizViewIndex.shtml";
 		}
	}
	
	function deletePanel(panelId){
// 	   artDialog.confirm('${contextStyleTheme}','<s:property value="%{getText('eaap.op2.conf.monitor.view.confirmCnt')}" />',
// 	   		function(){
	   			$.ajax({
					url : '${contextPath}/monitorView/deletePortalPanel.shtml',
					cache : false,
					async : false,
					dataType : "json",
					contentType:'application/x-www-form-urlencoded;charset=UTF-8',
					type  : 'POST',
					data  : {panelId:panelId},
					success : function(response) {
						var result = response.msg;
						if (result == "1"){
// 							artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.alertCnt')}" />','');
							document.location.reload(); 
						}
					}
				});
// 	   		},
// 	   		function(){art.dialog.tips('<s:property value="%{getText('eaap.op2.conf.monitor.view.cancelOperation')}" />');}
// 	   )
	}
	
</script> 
</html>
