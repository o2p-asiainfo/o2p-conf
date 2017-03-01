<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/icon.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jqueryui/jquery-ui-v1.10.3.js"></script>
	
<script type="text/javascript">

function getServiceInfo(){
	var value = $("#componentId").val();
	$.ajax({
		type:'post',
		url:'getServiceInfo.shtml',
		data:'data='+value,
		dataType:'json',
		success:function(msg){
			var ser = $("#serviceId") ;
			$("#serviceId option:not(:first)").remove();
			for(var i=0;i<msg.serviceList.length;i++){
				if("${serInvokeIns.serviceId}" == msg.serviceList[i].SERVICE_ID){
					ser.append("<option value='"+msg.serviceList[i].SERVICE_ID+"' selected >"+msg.serviceList[i].SERVICE_CN_NAME+"</option>");
				}else{
					ser.append("<option value='"+msg.serviceList[i].SERVICE_ID+"' >"+msg.serviceList[i].SERVICE_CN_NAME+"</option>");
				}
			}			
		},
		error:function(){
			alert("ajax error");
		}
		});	
}

function submitForm(){
	$("#myForm").submit();
}

function cancelForm(){
	window.location = "authenticateIndex.shtml";
}
</script>
<style>
	.mgr-table .tditem{BACKGROUND-COLOR:#FBFBFB;width:20%;TEXT-ALIGN: center;PADDING-RIGHT: 10px; }
	.mgr-table .tditem-content{width:80%;PADDING-LEFT: 15px;}
</style>
</head>
<body>

<div class="contentWarp">
 	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap-op2-conf-authenticate.authenticate')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.authenticate.authenticateUpdate')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.authenticate.authenticateUpdate')}"/>
         </div>
         
    </div>
<!--body start -->
	
       <form  name="myForm" action="updateAuthenticate.shtml" method="post" id="myForm"> 
            <table class="mgr-table">
    		<tr>
	  			<td class="item middle"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">
	  					<input type="hidden" name="serInvokeIns.componentId" id="componentId" value="${serInvokeIns.componentId}" />
	  					<input type="text" id="component_name" name="component_name" title="Search" size="25" value="${data}" disabled="disabled" />
	  				</div>
	   			</td>
	  			<td class="item middle" ><s:property value="%{getText('eaap-op2-conf-authenticate.serviceName')}"/>:
    				 </td>
    				<td class="item-content" >
                       <select name="serInvokeIns.serviceId" id="serviceId" disabled="disabled" >
                       <option value="0"><s:property value="%{getText('eaap-op2-conf-authenticate.select')}"/></option>
    				  </select>
    				  
    				</td>
	   		</tr>
    				
    				<tr>
			  			<td colspan="4">
			  <c:forEach items="${hashMap.proofTypeList}" step="1" var="proofType">
			  		<br/>
			  			<b>${proofType.PT_NAME}</b>
			  			
			  			<hr /><br/>
			  			
			  			<c:forEach items="${proofType.attrList}" step="1" var="attr">
			  				 <table class="mgr-table">
    							 <tr>
					    			 <td class="tditem" >${attr.ATTR_SPEC_NAME}
					    			 <input type="hidden" name="proofValuesId" value="${attr.PV_ID}" />
					    			 </td>		
					    			 <td class="tditem-content"><input type="text" name="attrValues" value="${attr.ATTR_VALUE}" /> &nbsp;&nbsp;&nbsp;&nbsp; <font color="orange">* ${attr.ATTR_SPEC_DESC}</font></td>
				    			 </tr>
				    		  </table>
			  			</c:forEach>
			  			
			  	<br/>
			  		
			  </c:forEach>
			  
			  		</td>
			  		</tr>
    	      <tr>
    				<td  colspan="4" class="item-content" align="center">
    					<a class="button-base button-middle" title="<s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/>" onclick="submitForm()">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/></span>
						  </a>
						    <a class="button-base button-middle" title="<s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/>" onclick="cancelForm()">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cancel')}"/></span>
						  </a>
    				</td>	
    			</tr>
    		</table>
    		
    		<br/>
    		
    	</form>
</div>
 <script type="text/javascript">

  	$(document).ready(function(){
		getServiceInfo();
	 });
	
  </script>
  
</body>
</html>
