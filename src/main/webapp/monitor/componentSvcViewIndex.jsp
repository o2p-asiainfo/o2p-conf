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
    		var _panelWidth = ($(document.body).width()/2) - 30;
    		$("div[name='_comptPanel']").width(_panelWidth-2);
    		$(".panel").width(_panelWidth);
			$(".panel-header").width(_panelWidth-12);
    	})
    </script>
  </head>
 <!--body start -->
  <body>
  <form method="post" name="myform" action="">
	<div class="contentWarp">
	  <div class="accordion-header" >
    	<div class="accordion-header-text">
    		<span style="float:left"><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.monitor.view.componentSvcList')}" /></span>
    		<span style="float:right">
    		    <table border=0>
	    			<tr style="font-size:14px;">
	    				<td>
	    					<b><s:property value="%{getText('eaap.op2.conf.monitor.view.refreshCiyle')}" /></b>
	    				</td>
	    				<td>
	    					<ui:select skin="${contextStyleTheme}" onchange="changeTime(this.value);" name="refreshSecond" value="" id="refreshSecond" list="%{{#{'ID':'60000','NAME':refreshList[0]},#{'ID':'300000','NAME':refreshList[1]}}}"  listKey="ID" listValue="NAME" width="80" layerWidth="85" layerHeight="50"></ui:select>
	    				</td>
	    			</tr>
	    		</table>
    		</span>
   		</div>
	   </div>
   	   <!-- panel start-->
	   <div id="portal">
	   	 <c:choose>
	   	 	<c:when test="${fn:length(componentSvcList)<1}">
				<div style="background:#feffe2;color:#993300;border-color:#ffc601;margin-top:10px;" align="center" >
					<s:property value="%{getText('eaap.op2.conf.monitor.view.hasNoView')}" />
				</div>
		     </c:when>
		     <c:otherwise>
		     	<c:forEach items="${componentSvcList}" var="componentSvc" varStatus="status" step="1" >
					<c:choose>
						<c:when test="${status.count%2==0}">
							 <div style="margin-top:5px;float:right;">
							 	<em id="tipTitle" title="${componentSvc.ORG_NAME}-${componentSvc.COMPONENT_NAME}-${componentSvc.SERVICE_CN_NAME}"/>
							 	<div name="_comptPanel" id="${componentSvc.SERVICE_ID}" class="easyui-panel" style="height:330px;" data-options="title:'${componentSvc.SERVICE_CN_NAME}',collapsible:true,tools:[{iconCls:'icon-add',handler:function(){addPanel('${componentSvc.COMPONENT_ID}','${componentSvc.SERVICE_CODE}','${componentSvc.SERVICE_CN_NAME}','${componentSvc.ORG_NAME}-${componentSvc.COMPONENT_NAME}-${componentSvc.SERVICE_CN_NAME}');}}]">
									<iframe src="${contextPath}/monitor/showComponentSvcChart.jsp?svcId='${componentSvc.SERVICE_CODE}'&componentId=${componentSvc.COMPONENT_ID}" frameborder="0" scrolling="no" style="border:0;width:100%;height:300px;"></iframe>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							 <div style="margin-top:5px;float:left;">
							 	<em id="tipTitle" title="${componentSvc.ORG_NAME}-${componentSvc.COMPONENT_NAME}-${componentSvc.SERVICE_CN_NAME}"/>
							 	<div name="_comptPanel" id="${componentSvc.SERVICE_ID}" class="easyui-panel" style="height:330px;" data-options="title:'${componentSvc.SERVICE_CN_NAME}',collapsible:true,tools:[{iconCls:'icon-add',handler:function(){addPanel('${componentSvc.COMPONENT_ID}','${componentSvc.SERVICE_CODE}','${componentSvc.SERVICE_CN_NAME}','${componentSvc.ORG_NAME}-${componentSvc.COMPONENT_NAME}-${componentSvc.SERVICE_CN_NAME}');}}]">
							 		<iframe src="${contextPath}/monitor/showComponentSvcChart.jsp?svcId='${componentSvc.SERVICE_CODE}'&componentId=${componentSvc.COMPONENT_ID}" frameborder="0" scrolling="no" style="border:0;width:100%;height:300px;"></iframe>
								</div> 
					  		</div>
						</c:otherwise>
					</c:choose>
					<input type="hidden" name="componentId" value="${componentSvc.COMPONENT_ID}"/>
				</c:forEach>
		     </c:otherwise>
	   	 </c:choose>
	   </div>
	   <div style="position:relative;float:right;botton:0;margin-top:20px;top:auto;clear:both;">
		   	<ui:page id="page"/>
	  </div>
	 </div>
</form>
</body>
<script type="text/javascript">
	function addPanel(componentId,serviceCode,title,tipTitle){
		$.ajax({
			url : '${contextPath}/monitorView/saveCustomPanelCfg.shtml',
			cache : false,
			async : false,
			dataType : "json",
			contentType:'application/x-www-form-urlencoded;charset=UTF-8',
			type  : 'POST',
			data  : {type:2,componentId:componentId,serviceCode:serviceCode,title:title,tipTitle:tipTitle},
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
