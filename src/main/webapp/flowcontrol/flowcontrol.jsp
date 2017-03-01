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
	
	
<script type="text/javascript" >
function queryExistsPolicy(){
	$("#form1").submit();
}

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

</script>
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	  	 	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap-op2-conf-flowcontrol.trafficPolicy')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap-op2-conf-flowcontrol.trafficPolicyConfiguration')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap-op2-conf-flowcontrol.trafficPolicySelect')}"/>
         </div>
         
    </div>
    
    <div>
       <ui:form  name="myForm" action="../flowcontrol/queryExistsPolicy.shtml" method="post" id="form1" > 
    		
    		<table class="mgr-table">
			<tr>
	  			<td class="item middle"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">
	  					<input type="hidden" name="serInvokeIns.componentId" id="component_id" value="" />
	  					<input type="text" id="component_name" name="component_name" title="Search" size="25" value="" onfocus="changeComponent();" />
	  					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectCompt')}" />" target="_blank"  onclick="$('#compWin').window('open')">
				  			<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" /></span>
						</a>
	  				</div>
	   			</td>
	  			<td class="item middle"><s:property value="%{getText('eaap.op2.conf.techimpl.svcName')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  					<input type="hidden" name="serInvokeIns.serviceId" id="service_id" value="" />
	  					<input type="text" id="service_name" name="service_name" title="Search" size="25" onfocus="changeService();"/>
	  					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectSvc')}" />" target="_blank" onclick="$('#svcWin').window('open')">
				  			<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" /></span>
						</a>
	  				</div> 
	   			</td>
	   		</tr>
	   		<tr>
	   			<td colspan=4 style="TEXT-ALIGN: right;PADDING-RIGHT:30px; ">
  					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.queryBtn')}" />" target="_blank" onclick="queryExistsPolicy()">
				  		<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.queryBtn')}" /></span>
					</a>
	    		</td>
	   		</tr>
	    </table>
    		
    	<br />
	</ui:form>
    	
    </div>
    <iframe name="list_iframe" id="list_iframe" frameborder="0" src="" style="border:0px;height:600px;width:100%;"></iframe>
    
</div>
<div id="compWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectCompt')}" />" style="width:650px;height:500px;padding:5px;">
	<iframe id="comp_iframe" scrolling="no" frameborder="0" src="${contextPath}/autocomplete/showCompIndex.shtml" style="border:0;width:100%;height:100%"></iframe>
</div>
<div id="svcWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectSvc')}" />" style="width:650px;height:500px;padding:5px;">
	<iframe id="svc_iframe" scrolling="no" frameborder="0" src="${contextPath}/autocomplete/showServiceIndex.shtml" style="border:0;width:100%;height:100%"></iframe>
</div>
<!--body end --> 
<script type="text/javascript">
	 $(document).ready(function(){
	   do_qry();
	 });
	 
	 function do_qry(){
	 	$("#form1").attr("target","list_iframe");
	 	$("#list_iframe").attr("src","../flowcontrol/queryExistsPolicy.shtml");
	 	$('#form1').submit();
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
	    		$("#component_id").val(ui.item.id);
	    	} 
	     });
	 }
	 
	 function changeService(){
	 	 $("#service_id").val("");
	 	
	    $("#service_name").autocomplete({  
	    	minLength:1,
            autoFocus:true,
	    	source: function(request,response){
	    		 var term = request.term;
            	 if (term in svcCache){
            	 	response($.map(svcCache[term],function(item){
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
    		 		url:"../autocomplete/serviceAutoComplete.shtml",
                    dataType:"json",
                    data:{service_name:$("#service_name").val()},
                    success:function(data){
                    	svcCache[term] = data;
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
	    		$("#service_id").val(ui.item.id);
	    	} 
	     });
	 }

	 //close component div,call back
	 function doSelectCallBack(returnStr) {
		var returnStr = returnStr.split(',');
		$("#component_id").val(returnStr[0]);
		$("#component_name").val(returnStr[1]);
	}
	
	 function doSelectSvcCallBack(returnStr) {
		var returnStr = returnStr.split(',');
		$("#service_id").val(returnStr[0]);
		$("#service_name").val(returnStr[1]);
	}
	
	 function closeWin(){
	  	$('#compWin').window('close');
	 }
	 function closeSvcWin(){
	 	$('#svcWin').window('close');
	 }
	 
</script>
</body>
</html>
