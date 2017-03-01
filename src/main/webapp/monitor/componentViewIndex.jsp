<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/icon.css')" escape="false"/>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/panel.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/tooltip.css">
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<script src="${contextPath}/resource/comm/js/jqueryui/jquery.ui.tooltip.js"></script>
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.cookie.js"></script>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  
    <script type="text/javascript">
    	$(document).ready(function(){
    		//var sysMgrWidth = 252;
    		var _panelWidth = ($(document.body).width()/2) - 30;
    		$("div[name='_comptPanel']").width(_panelWidth-2);
    		$(".panel").width(_panelWidth);
			$(".panel-header").width(_panelWidth-12);
    	})
    </script>
  </head>
 <!--body start -->
<body>
  	 <form method="post" id="myform" name="myform" action="${contextPath}/monitorView/showComponentViewIndex.shtml">
  	 	<div class="contentWarp">
		    <div class="accordion-header" >
		    	<div class="accordion-header-text">
		    	<table border=0>
	    			<tr style="font-size:14px;">
		    				<td width="1100px" style="margin-top: -2px;">
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
				             		<ui:select skin="${contextStyleTheme}" onchange="changeView(this.value);" name="viewSwitch" value="2" id="viewSwitch" list="viewSwitchMaps" listKey="ID" listValue="NAME" width="160" layerWidth="165" layerHeight="100"></ui:select>
				                  </div>
				              </div>
		    					
		    				</td>
		    			</tr>
		    	</table>
		    	</div>
		    </div>
	    	<div>
		    	<table class="mgr-table" style="font-size:12px;">
		    		<tr>
		    			<td class="item"><s:property value="%{getText('eaap.op2.conf.monitor.view.orgName')}" />:</td>
		    			<td>
		   					<ui:multiSelectBox skin="${contextStyleTheme}" id="org_code_box" name="org.orgCode" list="selectOrgList" listKey="orgId" listValue="name"></ui:multiSelectBox>
		    			</td>
		    			<td class="item"><s:property value="%{getText('eaap.op2.conf.monitor.view.componentName')}" />:</td>
		    			<td>
		   					<ui:multiSelectBox skin="${contextStyleTheme}" id="compt_box" name="component.componentId" list="selectComponentList" listKey="componentId" listValue="name" layerWidth="160"></ui:multiSelectBox>
		    			</td>
		    			<td style="TEXT-ALIGN: right;PADDING-RIGHT:30px;">
		   					<a class="button-base button-small" onclick="do_submit();"  title="<s:property value="%{getText('eaap.op2.conf.monitor.view.btnOk')}" />" target="_blank" >
							  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.monitor.view.btnOk')}" /></span>
							</a>
		   				</td>
		    		</tr>
		    	</table>
		    </div>
		     <!-- panel start-->
   	   		<form name="portalform" method="post">
   	   				<c:choose>
			   			<c:when test="${fn:length(componentList)<1}">
							<div style="background:#feffe2;color:#993300;border-color:#ffc601;margin-top:10px;" align="center" >
								<s:property value="%{getText('eaap.op2.conf.monitor.view.hasNoView')}" />
							</div>
				     	</c:when>
				     	<c:otherwise>
				     		<c:forEach items="${componentList}" var="component" varStatus="status" step="1" >
								<c:choose>
									<c:when test="${status.count%2==0}">
										 <div style="margin-top:5px;float:right;overflow:hidden">
										    <em id="tipTitle" title="${component.ORG_NAME}-${component.NAME}"/>
										 	<div name="_comptPanel" id="${component.COMPONENT_ID}" class="easyui-panel" style="height:330px;" data-options="title:'${component.NAME}',collapsible:true,tools:[{iconCls:'icon-add',handler:function(){addPanel('${component.COMPONENT_ID}','${component.NAME}','${component.ORG_NAME}-${component.NAME}');}}]">
												<iframe src="${contextPath}/monitor/showComponentChart.jsp?componentId=${component.COMPONENT_ID}" frameborder="0" scrolling="no" style="border:0;width:100%;height:300px;"></iframe>
											</div>
										  </div>
									</c:when>
									<c:otherwise>
										 <div style="margin-top:5px;float:left;">
										 	<em id="tipTitle" title="${component.ORG_NAME}-${component.NAME}"/>
										 	<div name="_comptPanel" id="${component.COMPONENT_ID}" class="easyui-panel" style="height:330px;" data-options="title:'${component.NAME}',collapsible:true,tools:[{iconCls:'icon-add',handler:function(){addPanel('${component.COMPONENT_ID}','${component.NAME}','${component.ORG_NAME}-${component.NAME}');}}]">
										 		<iframe src="${contextPath}/monitor/showComponentChart.jsp?componentId=${component.COMPONENT_ID}" frameborder="0" scrolling="no" style="border:0;width:100%;height:300px;"></iframe>
											</div> 
										  </div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
				     	</c:otherwise>
	   				</c:choose>
   	   			<div style="position:relative;float:right;botton:0;margin-top:20px;top:auto;clear:both;">
		   			<ui:page id="page"/>
	      		</div>
		    </form>
		</div>
  	 </form>
</body>
<script type="text/javascript">
	function do_submit(){
		myform.submit();
	}
	
	function addPanel(componentId,title,tipTitle){
		$.ajax({
			url : '${contextPath}/monitorView/saveCustomPanelCfg.shtml',
			cache : false,
			async : false,
			dataType : "json",
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			type  : 'POST',
			data  : {type:1,componentId:componentId,title:title,tipTitle:tipTitle},
			success : function(response) {
				var result = response.msg;
				if (result == "1"){
					artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.cfgPanelOk')}" />','');
				}else if(result == "2"){
					artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.hasCfg')}" />','');
				}else{
					artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.cfgPanelFail')}" />','');
				}
			}
		});
	}
	
	function changeTime(refreshTime){
		$.cookie('monitor_refreshTime', null, { path: '/eaap_conf' });
		$.cookie('monitor_refreshTime',refreshTime, { path: '/eaap_conf'});
	}
	
	function changeView(currentView){
 		if(currentView == "2"){
 			window.location.href = "${contextPath}/monitorView/showComponentViewIndex.shtml";	
 		}else if (currentView == "3"){
 			window.location.href = "${contextPath}/monitorView/showServiceViewIndex.shtml";	
 		}else if (currentView == "1"){
 			window.location.href = "${contextPath}/monitorView/showSingleBizViewIndex.shtml";
 		}else if (currentView == "4"){
 			window.location.href = "${contextPath}/monitorView/findMonitorViewIndex.shtml";
 		}
	}
	
	$(function(){
		var refreshTime = $("#refreshTime").val();
	    $.cookie('monitor_refreshTime',refreshTime, { path: '/eaap_conf'});
	    
		$( "#tipTitle" ).tooltip({
			show: null,
			position: {
				my: "left top",
				at: "left bottom"
			},
			open: function( event, ui ) {
				ui.tooltip.animate({ top: ui.tooltip.position().top + 10 }, "fast" );
			}
		});
		
		$('.icon-add').tooltip({
			position: 'left',
			content: '<span><s:property value="%{getText('eaap.op2.conf.monitor.view.cfgPanel')}"/></span>',
			onShow: function(){
				$(this).tooltip('tip').css({
					backgroundColor: '#fff',
					borderColor: '#fcc676'
				});
			}
		});
	});
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>
