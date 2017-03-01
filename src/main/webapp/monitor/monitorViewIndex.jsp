<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html> 
  <head>
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
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
  </head>
 <!--body start -->
<body class="easyui-layout" fit="true">
	<div region="center" style="overflow: hidden;" border="false">
		<div class="contentWarp">
		    <div class="accordion-header" style="padding-right: 0px; padding-left: 0px; margin-left: 5px; margin-right: 5px;">
		    	<div class="accordion-header-text">
		    		<table border=0>
		    			<tr style="font-size:14px;">
		    				<td width="250px" style="margin-top: -2px;">
		    					<div>
				                  <div style="float:left">
				               	       <b><s:property value="%{getText('eaap.op2.conf.monitor.view.refreshCiyle')}" />&nbsp;</b>
				                  </div>
				              	  <div style="float:left;">
				             		<ui:select skin="${contextStyleTheme}" onchange="changeTime(this.value);" name="refreshSecond" value="" id="refreshSecond" list="refreshSecondMaps"  listKey="ID" listValue="NAME" width="80" layerWidth="85" layerHeight="50"></ui:select>
				                  </div>
				              </div>
		    				</td>
		    				<td width="300px" style="margin-top: -2px;">
		    					<div>
				                  <div style="float:left">
				               	       <b><s:property value="%{getText('eaap.op2.conf.monitor.view.viewSwitch')}" />&nbsp;</b>
				                  </div>
				              	  <div style="float:left;">
				             		<ui:select skin="${contextStyleTheme}" onchange="changeView(this.value);" name="viewSwitch" value="" emptyOption="true" headerValue="%{getText('eaap.op2.conf.monitor.view.pleaseSelect')}" id="viewSwitch" list="viewSwitchMaps" listKey="ID" listValue="NAME" width="160" layerWidth="165" layerHeight="90"></ui:select>
				                  </div>
				              </div>
		    					
		    				</td>
		    			</tr>
		    		</table>
		    	 </div>
		   </div>
	    </div>
	    <!-- panel start-->
		<div id="portal" style="position:relative;overflow-x:hidden;">
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
		var refreshSecond = $("#refreshSecond").val();
		loadCfgPanel(refreshSecond);
		
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
					for ( var i = 0; i < rows.length; i++) {
						var src;
						if (/^\//.test(rows[i].path)) {
							src = rows[i].path.substr(1);
						} else {
							src = rows[i].path;
						}
						if (src.indexOf("?")== -1){
							src += "?refreshSecond="+refreshSecond;
						}else{
							src += "&refreshSecond="+refreshSecond;
						}
						
						var p = $('<div style="overflow:hidden;" class="testModules" />').appendTo('body').panel({
						    id : rows[i].portalPanelId,
							title : rows[i].title,
							content : '<iframe src="' + src + '" frameborder="0" scrolling="no" style="border:0;width:100%; height:100%;"></iframe>',
							height : '329',
							collapsible : true,
							tools:"<div><a class='icon-tip' title='"+rows[i].tips+"'></a></div>"
						});
						portal.portal('add', {
							panel : p,
							columnIndex : i % col
						});
					}
					portal.portal('resize');
					
					var vPortalHeight =Math.ceil(rows.length/2)*339+20;
					$("#portal").height(vPortalHeight);
					changeTopScrollHeight( vPortalHeight+50);
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
	   artDialog.confirm('${contextStyleTheme}','<s:property value="%{getText('eaap.op2.conf.monitor.view.confirmCnt')}" />',
	   		function(){
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
							artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.alertCnt')}" />','');
							document.location.reload(); 
						}
					}
				});
	   		},
	   		function(){art.dialog.tips('<s:property value="%{getText('eaap.op2.conf.monitor.view.cancelOperation')}" />');}
	   )
	}
</script> 
</html>
