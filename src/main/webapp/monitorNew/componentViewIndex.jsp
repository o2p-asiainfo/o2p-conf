<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	
	 <!-- BEGIN SELECT STYLE -->
	 <link rel="stylesheet" type="text/css" href="${contextPath}/resource/monitor/plugins/select2-4.0.0-rc.2/dist/css/select2.min.css" rel="stylesheet" type="text/css">
	 <!-- END SELECT STYLE-->
	 <!-- BEGIN SELECT SCRIPT -->
	 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/jquery-easyui-1.4.2/jquery.min.js"></script>
	 <script type="text/javascript" src="${contextPath}/resource/monitor/plugins/select2-4.0.0-rc.2/dist/js/select2.full.js"></script>
	 <!-- END SELECT SCRIPT -->
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/icon.css')" escape="false"/>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/panel.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/tooltip.css">
	<!-- <s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/> -->
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<script src="${contextPath}/resource/comm/js/jqueryui/jquery.ui.tooltip.js"></script>
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.cookie.js"></script>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/> 
	 <script type="text/javascript" src="${contextPath}/resource/comm/adapter/json2.js" ></script>
	
	 <link href="${contextPath}/resource/monitor/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	 <link href="${contextPath}/resource/monitor/css/style-plus.css" rel="stylesheet" type="text/css" />
	 
   <link href="${contextPath}/resource/monitor/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
   <link href="${contextPath}/resource/css/style-template.css" rel="stylesheet" type="text/css" />
   <script src="${contextPath}/resource/monitor/plugins/jquery.bootpag.min.js"></script>
	 
	<link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/ >
	<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>
   
    <script type="text/javascript">
    	$(document).ready(function(){
    		//var sysMgrWidth = 252;
    		var _panelWidth = ($(document.body).width()/2) - 30;
    		$("div[name='_comptPanel']").width(_panelWidth-2);
    		$(".panel").width(_panelWidth);
			$(".panel-header").width(_panelWidth-12);

		  $(".js-example-basic-multiple").select2({
// 		  placeholder: "Select a state"
		  });

 		});
</script>
</head>
 <!--body start -->
<body>
<div class="contentWarp"  style="min-height: 420px;">
   	<table>
   		<tr>
   			<td style="width:160px; text-align:center;"><s:property value="%{getText('eaap.op2.conf.monitor.view.componentName')}" />:</td>
   			<td>
  					<select  id="componentId" name="component.componentId"  class="js-example-basic-multiple" multiple="multiple"  style="width:250px">
				     	<c:forEach items="${selectComponentList}" var="sComponent" varStatus="status" step="1" >
				     		<option value="${sComponent.code}">${sComponent.name}</option>
						</c:forEach>
					</select>
   			</td>
   			<td style="text-align:center; padding:0 10px;"><s:property value="%{getText('eaap.op2.conf.monitor.view.Time')}" />:</td>
   			<td>
	            <input type="text"  id="searchTime" name="searchTime"  value="${searchTime}" readonly style="width:180px; height:34px; border:1px solid #ccc; cursor:pointer;"/>
   			</td>
   			<td style="padding-left:2px;">
				<button type="button" onclick="getSearchData()" class="btn blue"><i class="fa fa-search"></i> <s:property value="%{getText('eaap.op2.conf.monitor.view.btnOk')}" /></button>
  			</td>
   		</tr>
   	</table>
	 <div id="content"></div>
  	 <div style="width:100%; clear:both; border-top:1px solid #EEE;">
			<div id="pageBar" class="demo pull-right"></div>
	 </div>
</div>
</body>
<script type="text/javascript">	
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
					window.parent.needReLad=true;
				}else if(result == "2"){
					artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.hasCfg')}" />','');
				}else{
					artDialog.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.monitor.view.cfgPanelFail')}" />','');
				}
			}
		});
	}


	 jQuery(document).ready(function() {
	 	var totalPage = ${totalPage};
		if(totalPage>9){
			setbootpag(10,totalPage);
		}else{
			setbootpag(totalPage,totalPage);
		}
		if(totalPage>0){
			getPageData(1); 
		}else{
			var retHtml="<br><s:property value="%{getText('eaap.op2.conf.monitor.view.hasNoView')}" /><br><br>";
			$("#content").html(retHtml); 
		}

		$('#searchTime').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i'
		});
	 });
	
	function setbootpag(_startVisible,_totalPage){
		$("#pageBar").bootpag({
		   total: _startVisible,
		   page:1
		   }).on("page", function(event, num){
				getPageData(num); 
				$(this).bootpag({total:_totalPage, maxVisible: 10});
		});                       
	}
	
	function getPageData(num){
		var retJson = getData(num);
		if(retJson !=""){
			var recordList = retJson.RecordList;
			setPageHtml(recordList);
		}
	}
	
	function getSearchData(){
		var retJson = getData(1);
		if(retJson !=""){
			var totalPage = retJson.TotalPage;
			if(totalPage>9){
				$("#pageBar").bootpag({
				   total: 10
				   }).on("page", function(event, num){
						$(this).bootpag({total:totalPage, maxVisible: 10});
				});              
			}else{
				$("#pageBar").bootpag({
				   total: totalPage
				   }).on("page", function(event, num){
						$(this).bootpag({total:totalPage, maxVisible: 10});
				});       
			}
			var recordList = retJson.RecordList;
			setPageHtml(recordList);
		}
	}
	
	function setPageHtml(recordList){
		var retHtml="";
		if(recordList.length>0){
			for (var i=0; recordList.length>i; i++){
				var _componentId 	= recordList[i].CODE;
				var _name				= recordList[i].NAME;
				var _tipTitle				= recordList[i].ORG_NAME+"-"+recordList[i].NAME;
				var _position = "left";
				if(i%2==1){
					_position = "right";
				}
				retHtml +="<div style=\"margin-top:5px;float:"+_position+"; width:49.5%; height:358px;\">";
				retHtml +="		<iframe src=\"${contextPath}/monitorNew/showComponentChart.jsp?componentId="+_componentId+"&panelTitle="+encodeURIComponent(encodeURIComponent(_name))+"&tipTitle="+encodeURIComponent(encodeURIComponent(_tipTitle))+"\" frameborder=\"0\" scrolling=\"no\" style=\"border:0;width:100%;height:358px\"></iframe>";
				retHtml +="</div>";
			}
		}else{
			retHtml="<br><s:property value="%{getText('eaap.op2.conf.monitor.view.hasNoView')}" /><br><br>";
		}
		$("#content").html(retHtml); 
	}
	
	function getData(num){
		var retJson = "";
		var componentId = $("#componentId").val();		//component.code
		$.ajax({
		     type:"post",
		     async:false,
		     url:"${contextPath}/monitorView/getComponentViewIndexList.shtml",
		     dataType:"text",
		     data:"currentPage="+num+"&componentId="+componentId,
		     success:function(msg,data){
					try {
						var getJson = JSON.parse(msg);
				 		var isjson = typeof(getJson)=="object" && Object.prototype.toString.call(getJson).toLowerCase()=="[object object]"; 
						if(isjson){
							retJson = getJson;
						}else{
						}
					} catch (e) {
					}
	   	  	}
		});	
		return retJson;
	}
	
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>
