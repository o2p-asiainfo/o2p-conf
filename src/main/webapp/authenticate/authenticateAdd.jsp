<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ page import="java.lang.Math"%>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="/common/taglibs.jsp"%>
<% 
	List<HashMap> mapList = (List<HashMap> )request.getAttribute("proofTypeList");
%>
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
      <s:property value="%{getText('eaap-op2-conf-authenticate.authenticateAdd')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap-op2-conf-authenticate.authenticateAdd')}"/>
         </div>
         
    </div>
<!--body start -->
	
       <form  name="myForm" action="addAuthenticate.shtml" method="post" id="myForm"> 
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
			  			<td colspan="4">
			  <c:forEach items="${proofTypeList}" step="1" var="proofType">
			  		<br/>
			  			<b>${proofType.PT_NAME}</b>
			  			
			  			<hr /><br/>
			  			
			  			<c:forEach items="${proofType.attrList}" step="1" var="attr">
			  				 <table class="mgr-table">
    							 <tr>
					    			 <td class="tditem" >${attr.ATTR_SPEC_NAME}
					    			 <input type="hidden" name="proofTypeAtrSpecCdValues" value="${attr.PR_ATR_SPEC_CD}" />
					    			 <input type="hidden" name="proofTypePtcdValues" value="${attr.PT_CD}" />
					    			 </td>		
					    			 <td class="tditem-content"><input type="text" name="attrValues" /> &nbsp;&nbsp;&nbsp;&nbsp; <font color="orange">* ${attr.ATTR_SPEC_DESC}</font></td>
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
<%session.removeAttribute("msg"); %>
<!--body end --> 
<div id="compWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectCompt')}" />" style="width:650px;height:500px;padding:5px;">
	<iframe id="comp_iframe" scrolling="no" frameborder="0" src="${contextPath}/autocomplete/showCompIndex.shtml" style="border:0;width:100%;height:100%"></iframe>
</div>
<div id="svcWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectSvc')}" />" style="width:650px;height:500px;padding:5px;">
	<iframe id="svc_iframe" scrolling="no" frameborder="0" src="${contextPath}/autocomplete/showServiceIndex.shtml" style="border:0;width:100%;height:100%"></iframe>
</div>
</div>

 <script type="text/javascript">

  	$(document).ready(function(){
		getServiceInfo();
	 });
	
  </script>
</body>

</html>
