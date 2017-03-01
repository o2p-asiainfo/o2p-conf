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
	
	<style type="text/css">  
	.ui-autocomplete {max-height: 120px;overflow-y: auto; overflow-x:hidden;}
	.ui-autocomplete-loading {background: white url('${contextPath}/resource/${contextStyleTheme}/images/loading.gif') right center no-repeat;}
	* html .ui-autocomplete {height: 120px;}  
	</style>
<script type="text/javascript">

<c:if test="${!empty sessionScope.msg}">
var msg = '${sessionScope.msg}';
if (msg != '') {
	alert(msg);
}
</c:if>

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
				ser.append("<option value='"+msg.serviceList[i].SERVICE_ID+"'>"+msg.serviceList[i].SERVICE_CN_NAME+"</option>");
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

var cache = {};
var svcCache = {};
function changeComponent(){
   $("#component_id").val("");
	
   $("#component_name").autocomplete({  
   	minLength:1,
       autoFocus:true,
   	source: function(request,response){
   		 var term = request.term;
       	 if (term in cache){
       	 	response($.map(cache[term],function(item){
              		return {
                        label:item.label,
                        value:item.value,
                        id:item.id
                    };
               }));
               return;
       	 }
       	 
		 	lastXhr = $.ajax({
		 		type:"POST",
		 		url:"../autocomplete/cmptAutoComplete.shtml",
               dataType:"json",
               data:{component_name:$("#component_name").val()},
               success:function(data){
               	cache[term] = data;
               	response($.map(data,function(item){
               		return {
                            label:item.label,
                            value:item.value,
                            id:item.id
                       };
               	}));
               }
		 	});
   	},
   	select:function(event,ui){
   		$("#componentId").val(ui.item.id);
   		getServiceInfo();
   	} 
    });
}

//close component div,call back
function doSelectCallBack(returnStr) {
	var returnStr = returnStr.split(',');
	$("#componentId").val(returnStr[0]);
	$("#component_name").val(returnStr[1]);
	getServiceInfo() ;
}

function closeWin(){
 	$('#compWin').window('close');
}
function cancelForm(){
	window.location = "authenticateIndex.shtml";
}
</script>

</head>
<body>

    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap-op2-conf-flowcontrol.trafficPolicyAdd')}"/>
         </div>
         
    </div>
<!--body start -->
	
       <form  name="myForm" action="addFlowControl.shtml" method="post" id="myForm"> 
            <table class="mgr-table">
    		<tr>
	  			<td class="item middle"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">
	  					<input type="hidden" name="serInvokeIns.componentId" id="componentId" value="${serInvokeIns.componentId}" />
	  					<input type="text" id="component_name" name="component_name" title="Search" size="25" value="${data}" onfocus="changeComponent();" />
	  					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectCompt')}" />" target="_blank"  onclick="$('#compWin').window('open')">
				  			<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" /></span>
						</a>
	  				</div>
	   			</td>
	  			<td class="item middle" ><s:property value="%{getText('eaap-op2-conf-authenticate.serviceName')}"/>:
    				 </td>
    				<td class="item-content" >
                       <select name="serInvokeIns.serviceId" id="serviceId" >
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
                       <select name="ctlCounterms2Comp.ccCd"  style="width: 137px">
                        <c:forEach var="controlCounterms" items="${controlCountermsList}" step="1">
                        	<option value="${controlCounterms.CC_CD}">${controlCounterms.NAME}</option>
                        </c:forEach>
    				  </select>
    			 </td>
    			 	<td class="item middle"  ><s:property value="%{getText('eaap-op2-conf-flowcontrol.cycleValue')}"/>:
    			 </td>
    		  	<td class="item-content" ><input type="text" name="ctlCounterms2Comp.cycleValue"  />
    		  			<select name="ctlCounterms2Comp.cycleType" >
    			 		<option value="1"><s:property value="%{getText('eaap-op2-conf-flowcontrol.minute')}"/></option>
    			 		<option value="2"><s:property value="%{getText('eaap-op2-conf-flowcontrol.hour')}"/></option>
    			 		<option value="3"><s:property value="%{getText('eaap-op2-conf-flowcontrol.day')}"/></option>
    			 		<option value="4"><s:property value="%{getText('eaap-op2-conf-flowcontrol.weak')}"/></option>
    			 		<option value="5"><s:property value="%{getText('eaap-op2-conf-flowcontrol.month')}"/></option>
    			 		<option value="6"><s:property value="%{getText('eaap-op2-conf-flowcontrol.quarter')}"/></option>
    			 	</select>
    		  	</td>
			  </tr>
			  <tr>
    			 
    			 <td class="item middle"  ><s:property value="%{getText('eaap-op2-conf-flowcontrol.threshold')}"/>:
    			 </td>
    			 <td class="item-content" colspan="3"><input type="text" name="ctlCounterms2Comp.cutmsValue"  /></td>
			  
			  </tr>
			  
    	      <tr>
    				<td  colspan="4" class="item-content" align="center">
    					<a class="button-base button-middle" title="<s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/>" onclick="submitForm()">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/></span>
						  </a>
    				</td>	
    			</tr>
    		</table>
    	</form>
<%session.removeAttribute("msg"); %>
<!--body end --> 
<div id="compWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectCompt')}" />" style="width:650px;height:500px;padding:5px;">
	<iframe id="comp_iframe" scrolling="no" frameborder="0" src="${contextPath}/autocomplete/showCompIndex.shtml" style="border:0;width:100%;height:100%"></iframe>
</div>
<script type="text/javascript">

  	$(document).ready(function(){
		getServiceInfo();
	 });
	
  </script>
</body>
</html>
