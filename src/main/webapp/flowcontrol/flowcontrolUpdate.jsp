<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>

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
				if("${ctlCounterms2CompInfo.SERVICE_ID}" == msg.serviceList[i].SERVICE_ID){
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

	var componentId = $("#componentId").val();
	var serviceId = $("#serviceId").val();
	if(componentId == 0){
		alert("<s:property value="%{getText('eaap-op2-conf-flowcontrol.componentAdd')}"/>");
		return ;
	}
	
	if(serviceId == 0){
		alert("<s:property value="%{getText('eaap-op2-conf-flowcontrol.serviceAdd')}"/>");
		return ;
	}
	$("#myForm").submit();
}
</script>

</head>
<body>

    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap-op2-conf-flowcontrol.trafficPolicyUpdate')}"/>
         </div>
         
    </div>
<!--body start -->
	
       <form  name="myForm" action="updateFlowControl.shtml" method="post" id="myForm"> 
            <table class="mgr-table">
     <tr>
            
    			 <td class="item middle" ><s:property value="%{getText('eaap-op2-conf-authenticate.component')}"/>:
    			 </td>	
    				<td class="item-content" >
                       <select name="serInvokeIns.componentId" id="componentId" onchange="getServiceInfo()" disabled="disabled">
                       <option value="0"><s:property value="%{getText('eaap-op2-conf-authenticate.select')}"/></option>
                        <c:forEach var="component" items="${componentList}" step="1">
                        	<option value="${component.COMPONENT_ID}" <c:if test="${ctlCounterms2CompInfo.COMPONENT_ID == component.COMPONENT_ID}">selected</c:if>>${component.NAME}</option>
                        </c:forEach>
                        
    				  </select>
    				  
    				</td>
    				<td class="item middle" ><s:property value="%{getText('eaap-op2-conf-authenticate.serviceName')}"/>:
    				 </td>
    				<td class="item-content" >
                       <select name="serInvokeIns.serviceId" id="serviceId" disabled="disabled">
                       <option value="0"><s:property value="%{getText('eaap-op2-conf-authenticate.select')}"/></option>
                        <!--  <c:forEach var="service" items="${serviceList}" step="1">
                        	<option value="${service.SERVICE_ID}">${service.SERVICE_CN_NAME}</option>
                        </c:forEach>
                        -->
    				  </select>
    				  
    				</td>
    				</tr>
           			 <tr>
			    <td class="item middle"><s:property value="%{getText('eaap-op2-conf-flowcontrol.controlPolicy')}"/>:
    			</td>	
    			<td  class="item-content" >
                       <select name="ctlCounterms2Comp.ccCd" >
                        <c:forEach var="controlCounterms" items="${controlCountermsList}" step="1">
                        	<option value="${controlCounterms.CC_CD}" <c:if test="${ctlCounterms2CompInfo.CC_CD == controlCounterms.CC_CD}">selected</c:if>>${controlCounterms.NAME}</option>
                        </c:forEach>
    				  </select>
    			 </td>
    			 	<td class="item middle"  ><s:property value="%{getText('eaap-op2-conf-flowcontrol.cycleValue')}"/>:
    			 </td>
    		  	<td class="item-content" ><input type="text" name="ctlCounterms2Comp.cycleValue"  value="${ctlCounterms2CompInfo.CYCLE_VALUE}" />
    		  		<select name="ctlCounterms2Comp.cycleType" >
    			 		<option value="1" <c:if test="${ctlCounterms2CompInfo.CYCLE_TYPE == 1}">selected</c:if>><s:property value="%{getText('eaap-op2-conf-flowcontrol.minute')}"/></option>
    			 		<option value="2" <c:if test="${ctlCounterms2CompInfo.CYCLE_TYPE == 2}">selected</c:if>><s:property value="%{getText('eaap-op2-conf-flowcontrol.hour')}"/></option>
    			 		<option value="3" <c:if test="${ctlCounterms2CompInfo.CYCLE_TYPE == 3}">selected</c:if>><s:property value="%{getText('eaap-op2-conf-flowcontrol.day')}"/></option>
    			 		<option value="4" <c:if test="${ctlCounterms2CompInfo.CYCLE_TYPE == 4}">selected</c:if>><s:property value="%{getText('eaap-op2-conf-flowcontrol.weak')}"/></option>
    			 		<option value="5" <c:if test="${ctlCounterms2CompInfo.CYCLE_TYPE == 5}">selected</c:if>><s:property value="%{getText('eaap-op2-conf-flowcontrol.month')}"/></option>
    			 		<option value="6" <c:if test="${ctlCounterms2CompInfo.CYCLE_TYPE == 6}">selected</c:if>><s:property value="%{getText('eaap-op2-conf-flowcontrol.quarter')}"/></option>
    			 	</select>
    		  	</td>
			  </tr>
			  <tr>
    			 <td class="item middle"  ><s:property value="%{getText('eaap-op2-conf-flowcontrol.threshold')}"/>:
    			 </td>
    			 <td class="item-content" colspan="3"><input type="text" name="ctlCounterms2Comp.cutmsValue" value="${ctlCounterms2CompInfo.CUTMS_VALUE}" /></td>
			   
			  </tr>
			  
    	      <tr>
    				<td  colspan="4" class="item-content" align="center">
    					<a class="button-base button-middle" title="<s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/>" onclick="submitForm()">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/></span>
						  </a>
    				</td>	
    			</tr>
    		</table>
    		
    		<input type="hidden" value="${ctlCounterms2CompInfo.CTL_C_2_COMP_ID}" name="ctlCounterms2Comp.ctlC2CompId" />
    	</form>

<!--body end --> 
  <script type="text/javascript">

  	$(document).ready(function(){
		getServiceInfo();
	 });
	
  </script>
</body>
</html>
