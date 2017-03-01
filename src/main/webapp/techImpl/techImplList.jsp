<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/icon.css">
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
</head>
<body>
<!--body start -->
<ui:form method="post" id="myfrom" name="myform" action="../techimpl/loadTechImplData.shtml">
	<div class="contentWarp">
	   <table class="list-table" cellpadding="1" cellspacing="0" style="width:auto;font-size:12px;">
			<tr class="tab-header">
				<td class="middle">&nbsp;</td>
				<td class="middle" style="width:15%"><s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" /></td>
				<td class="middle" style="width:10%"><s:property value="%{getText('eaap.op2.conf.techimpl.orgName')}" /></td>
   				<td class="middle" style="width:15%"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" /></td>
   				<td class="middle" style="width:15%"><s:property value="%{getText('eaap.op2.conf.techimpl.svcName')}" /></td>
   				<td class="middle" style="width:10%"><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" /></td>
   				<td class="middle" style="width:20%"><s:property value="%{getText('eaap.op2.conf.techimpl.callUrl')}" /></td>
   				<td class="middle" style="width:5%"><s:property value="%{getText('eaap.op2.conf.techimpl.overtime')}" /></td>
   				<td class="middle" style="width:10%"><s:property value="%{getText('eaap.op2.conf.techimpl.createDate')}" /></td>
   			</tr>
   			<c:choose>
   				<c:when test="${fn:length(techImplList)<1}">
   					<tr class="even" align="center">
   						<td colspan=9><s:property value="%{getText('eaap.op2.conf.techimpl.hasNoData')}" /></td>
   					</tr>
	     		</c:when>
	     		<c:otherwise>
	     			<c:forEach items="${techImplList}" var="techImpl" varStatus="status" step="1" >
	     				<tr class="even">
	     					<td class="middle"><input type="radio" name="radioBtn" value="${techImpl.TECH_IMPL_ID},${techImpl.SER_TECH_IMPL_ID}" /></td>
	     					<td class="middle"><a href="javascript:void(0);" onclick="showDetail('${techImpl.TECH_IMPL_ID},${techImpl.SER_TECH_IMPL_ID}');">${techImpl.TECH_IMPL_NAME}</a></td>
	     					<td class="middle">${techImpl.ORG_NAME}</td>
		    				<td class="middle">${techImpl.COMPONENT_NAME}</td>
		    				<td class="middle">${techImpl.SERVICE_CN_NAME}</td>
		    				<td class="middle">${techImpl.COMM_PRO_NAME}</td>
		    				<td class="middle">
		    					<c:choose>
		    						<c:when test="${techImpl.CALL_URL=='' || techImpl.CALL_URL==null}">&nbsp;</c:when>
		    						<c:otherwise>${techImpl.CALL_URL}</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<td class="middle">
		    					<c:choose>
		    						<c:when test="${techImpl.OVERTIME=='' || techImpl.OVERTIME==null}">&nbsp;</c:when>
		    						<c:otherwise>${techImpl.OVERTIME}</c:otherwise>
		    					</c:choose>
		    				</td>
		    				<td class="middle">${techImpl.CREATE_TIME}</td>
		    			</tr>
	     			</c:forEach>
	     		</c:otherwise>
    		</c:choose>
    		<tr class="even" align="left">
   				<td colspan=9 style="PADDING-LEFT:30px;">
   					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.update')}" />" target="_blank" onclick="do_update();">
						<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.update')}" /></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.delete')}" />" target="_blank" onclick="do_delete();">
				  		<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.delete')}" /></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.addTip')}" />" target="_blank"  onclick="do_add();">
				  		<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.addBtn')}" /></span>
					</a>
   				</td>
   			</tr>
   		</table>
   		
   		<div style="position:relative;float:right;botton:0;margin-top:20px;top:auto;clear:both;">
		   	<ui:page id="page"/>
	    </div>
   </div>
</ui:form>
<!--body end --> 
<script type="text/javascript">
	 function do_update(){
	  	var rdoObj = $("input[name='radioBtn']");
	  	var isChoose = false;
	  	var returnStr = "";
	  	for (var i=0;i<rdoObj.length;i++){
	  		if(rdoObj[i].checked){
	  			returnStr = rdoObj[i].value;
				isChoose = true;
	  		}
	  	}
	  	if(!isChoose){
	  		jQuery.messager.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.techimpl.chooseRecord')}" />!','warning');
	        return false;
	    }
	    
	   window.location.href = "${contextPath}/techimpl/updateTechImpl.shtml?radioStr="+returnStr+"&t="+Math.random();
	 }
	 
	 function showDetail(idStr){
	 	window.location.href = "${contextPath}/techimpl/showTechImplDetail.shtml?idStr="+idStr+"&t="+Math.random();
	 }
	 function do_add(){
	 	//$("#list_iframe").attr("src","${contextPath}/techimpl/showTechImpl.shtml");
	 	window.location.href = "${contextPath}/techimpl/showTechImpl.shtml?t="+Math.random();
	 }
	 
	 function do_delete(){
	 	var rdoObj = $("input[name='radioBtn']");
	  	var isChoose = false;
	  	var returnStr = "";
	  	for (var i=0;i<rdoObj.length;i++){
	  		if(rdoObj[i].checked){
	  			returnStr = rdoObj[i].value;
				isChoose = true;
	  		}
	  	}
	  	if(!isChoose){
	  		jQuery.messager.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.techimpl.chooseRecord')}" />!','warning');
	        return false;
	    }
	    
	    $.messager.confirm('<s:property value="%{getText('eaap.op2.conf.monitor.view.confirmTitle')}" />',
	   					  '<s:property value="%{getText('eaap.op2.conf.techimpl.confirmCnt')}" />?',function(r){
	   	  if(r){
		   	$.ajax({
				url : '${contextPath}/techimpl/deleteTechImpl.shtml',
				cache : false,
				async : false,
				dataType : "json",
				type  : 'POST',
				data  : {radioStr:returnStr},
				success : function(response) {
					var result = response.msg;
					if (result == "1"){
						jQuery.messager.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.techimpl.deleteOK')}" />!','info');
						window.location.href = "../techimpl/loadTechImplData.shtml";
					}else{
						jQuery.messager.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.techimpl.deleteFail')}" />!','error');
					}
				}
			});
	   	  }
	   });
	 }
</script>
</body>
</html>
