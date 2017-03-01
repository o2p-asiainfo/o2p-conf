<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	     <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.serverManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.register')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.supplierAdd')}" />
	     	</div>
	    </div>
	   
	   <div>
<!-- 	   <form id="serviceSupplierResgisterAdd" action="../serviceManager/serviceSupplierResgisterAddToNext.shtml" method="post" name="serviceSupplierResgisterAdd" > -->
	   <form id="addServiceSupReg" name="addServiceSupReg" action="../serviceManager/addServiceSupReg.shtml" method="post">

	 	<table class="mgr-table">
			<tr>
	  			<td class="item" style="width:20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.techimpl.selectSvc')}" />:</td>
	  			<td class="item-content" style="width:80%;"> 
		  		    <div class="ui-widget"> 
		  				<div class="ui-widget">	  					  					
		  					<ui:inputText skin="${contextStyleTheme}" name="Service.serviceCnName" id="serviceName"  style="width:280px;" readonly="true" ></ui:inputText>
		  					<input name="Service.serviceId" id="serviceId" type="hidden"/>
		  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.techimpl.selectBtn')}" onclick="openWindows('${contextPath}/serviceManager/showMainInfo.shtml?serviceId=serviceId&&serviceName=serviceName&&pageState=pageState','Select Service')" shape="s"></ui:button>
		  				</div>
	 		        </div>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
		  				<input id="techImpId" name="TechImpl.techImplId" type="hidden" />
		  			    <ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplName" id="techImplName"  style="width:280px;" readonly="true" ></ui:inputText>
	                    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/techimpl/showTechImplIndex.shtml?techImplId=techImpId&techImplName=techImplName&&ComponentName=componentName&&orgName=orgName&&pageState=pageState','Select TechImpl')" shape="s"></ui:button>
	  				</div>  	
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}" />:</td>
	   			<td class="item-content">
	   				<input  skin="${contextStyleTheme}" name="orgName" id="orgName" style="width:90%;border-width:0;" readonly="readonly"/>	
	   			</td>
	   		</tr>
	   		<tr>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />:</td>
	   			<td class="item-content">
	   				<input  skin="${contextStyleTheme}" name="componentName" id="componentName"  style="width:90%;border-width:0;" readonly="readonly"/>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	  			<td class="item-center" colspan="4" >
 				<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="javascript:saveSubmit();"></ui:button>
<!-- 	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.next')}" onclick="toNext()"></ui:button> -->
	   		    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDirCancel')}"  onclick="javascript:history.go(-1);" ></ui:button>
	  			</td>
	   		</tr>
	    </table>
	    
	    </form>
	  </div>
       </div> 
       <ui:iframe  skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
       
       </body>
       <script type="text/javascript"> 
           	
function saveSubmit(){
	if ($("#serviceName").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.techimpl.selectSvc')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		$("#serviceName").focus();
		return false;
	}
	if ($("#techImplName").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		$("#techImplName").focus();
		return false;
	}
	$("#addServiceSupReg").submit();
}

	function toNext() {
	 document.serviceSupplierResgisterAdd.submit();
	}
	function closeWin() {
		$('#opendialog').window('close');
	}
    function goServiceSupplierIndex(){
	    window.location.href="../serviceManager/ServiceSupRegister.shtml";
	}
</script>   
<%@ include file="/common/ssoCommon.jsp"%>
</html>

