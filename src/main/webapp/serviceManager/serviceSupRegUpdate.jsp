<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
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
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.supplierUpdate')}" />
	     	</div>
	    </div>
	   
	   <div>	
	   <ui:form id="addServiceSupReg" action="../serviceManager/ServiceSupRegUpdate.shtml" method="post">
	 	<table class="mgr-table">
			<tr>
	  			<td class="item" style="width:20%;"><s:property value="%{getText('eaap.op2.conf.server.supplier.service')}" />:</td>
	  			<td class="item-content" style="width:80%;"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					${serHashMap.SERVICE_CN_NAME}
	  					<input name="Service.serviceId" id="serviceId" type="hidden" value="${serHashMap.SERVICE_ID}" />
	  					<input name="SerTechImpl.serTechImplId" id="serTechImplId" type="hidden" value="${serHashMap.SER_TECH_IMPL_ID}" />
	  				</div>
 		        </div>
	   			</td>
	   		</tr>
	   		<tr>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	   				<ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplName" id="techImplName"   style="width:280px;" value="${serHashMap.TECH_IMPL_NAME}"></ui:inputText>
	  				<input id="techImplId" name="TechImpl.techImplId" type="hidden" value="${serHashMap.TECH_IMPL_ID}" />
	  				   <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="openWindows('${contextPath}/techimpl/showTechImplIndex.shtml?techImplId=techImplId&&techImplName=techImplName&&ComponentName=componentName&&orgName=orgName&&pageState=pageState','Select Technology Implementation')" shape="s"></ui:button>
	  				</div>  	
	   			</td>
	   		</tr>   
	   		<tr>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  
	  				    <input  skin="${contextStyleTheme}" name="orgName" id="orgName" value="${serHashMap.ORGNAME}"  style="width:90%;border-width:0;" readonly="readonly"/> 					
	  					<input id="orgId" name="Org.orgId" type="hidden" value="${serHashMap.ORG_ID}" />
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">
	  				    <input  skin="${contextStyleTheme}" name="componentName" id="componentName"  value="${serHashMap.COMPONENTNAME}"  style="width:90%;border-width:0;" readonly="readonly"/>				  					
	  					<input id="code" name="Component.code" type="hidden" value="${serHashMap.CODE} "/>
	  				</div>
	   			</td>
	   		</tr>    
	   		
	    </table>
	    
	    </ui:form>
	  </div> 	
	   <div align="center" style="margin-top:5px;">
  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="javascript:document.addServiceSupReg.submit();"></ui:button>
  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" onclick="history.go(-1);"></ui:button>
 		</div> 
</div>
 <ui:iframe   skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
 </body>
<script>
function closeWin(){
	$('#opendialog').window('close');
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>

