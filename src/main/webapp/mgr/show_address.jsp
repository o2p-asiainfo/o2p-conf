<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/> 
 
 
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.manager.auth.serumanager')}"/>
       <img src="../resource/blue/images/module-path.png" />
        <s:property value="%{getText('eaap.op2.conf.proof.view')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          <s:property value="%{getText('eaap.op2.conf.manager.auth.seruserinfo')}"/>
         </div>
         
    </div>
    
    <div>
    <ui:form id="myForm" name="myForm" action="insertSerInvokeIns.shtml" method="post"> 
             <input type="hidden" name="msgFlowUrl" id="msgFlowUrl" value="${msgFlowUrl}" />
             <input type="hidden"  name="serInvokeIns.serInvokeInsId" value="${serInvokeInsMap.SER_INVOKE_INS_ID}"/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value="${editOrAdd}"/>
            <table align="center" class="mgr-table">
    		 <tr>
    		  <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}"/>:</td>
              <td><label>${serInvokeInsMap.SER_INVOKE_INS_NAME}</label></td>
              <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.manager.auth.service')}"/>:</td>
              <td><label><a id="service_name">${serInvokeInsMap.SERNAME}</a></label>
              <input type="hidden"  id="serserviceId" name="serInvokeIns.serviceId"   value="${serInvokeInsMap.SERVICE_ID}"/>
               </td>
            </tr>
             
            <tr>
              <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}"/>:</td>
              <td>
	              <label><a id="component_name">${serInvokeInsMap.COMPNAME}</a></label>
	              <input type="hidden" id="sercomponentId" name="serInvokeIns.componentId" value="${serInvokeInsMap.COMPONENT_ID}"/>
              </td>
              <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</td>
              <td><label><a id="org_name">${serInvokeInsMap.ORGNAME}</a></label>
              <input type="hidden"  id="serorgId" name="org.orgId" value="${serInvokeInsMap.ORGID}"/>
               </td>
            </tr>
    		 <tr>
                  <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}"/>:</td>
    				<td>
    				<label><a id="messageFlow_name">${serInvokeInsMap.MFNAME}</a></label>
    				<input type="hidden"  id="messageFlow_id" name="" value="${serInvokeInsMap.MESSAGE_FLOW_ID}"/>
    			  </td>	
    			  <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.proof.ProtocolVersion')}"/>:</td>
                  <td><label><a id="version_name">${serInvokeInsMap.VERSION}</a></label>
                  <input type="hidden"  id="contract_id" name="" value="${serInvokeInsMap.CONTRACT_ID}"/>
               </td>
    		  </tr>
    		   <tr>
                <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
    				<td  colspan="3">
    					  <%-- <ui:textarea skin="${contextStyleTheme}"  id="serInvokeIns.serInvokeInsDesc" name="serInvokeIns.serInvokeInsDesc" value="${serInvokeInsMap.SER_INVOKE_INS_DESC}" width="800" height="200"/> --%>
    					  <label>${serInvokeInsMap.SER_INVOKE_INS_DESC}</label>
    				</td>
    		 </tr>
    		  <c:if test="${pageWebserviceAdd!=null}">
    		  <tr>
                <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.proof.Webservice')}"/>:</td>
    				<td  colspan="3">
    					  <%-- <ui:textarea skin="${contextStyleTheme}"  id="serInvokeIns.serInvokeInsDesc" name="serInvokeIns.serInvokeInsDesc" value="${serInvokeInsMap.SER_INVOKE_INS_DESC}" width="800" height="200"/> --%>
    					  <label>${pageWebserviceAdd }</label>
    				</td>
    		 </tr>
    		  </c:if>
    		  <c:if test="${pageHttpAdd != null }">
    		  <tr>
                <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.proof.Http')}"/>:</td>
    				<td  colspan="3">
    					  <%-- <ui:textarea skin="${contextStyleTheme}"  id="serInvokeIns.serInvokeInsDesc" name="serInvokeIns.serInvokeInsDesc" value="${serInvokeInsMap.SER_INVOKE_INS_DESC}" width="800" height="200"/> --%>
    					  <label>${pageHttpAdd}</label>
    				</td>
    		 </tr>
    		  </c:if>
    		 <c:if test="${pageRestAdd !=null }">
    		 <tr>
                <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.proof.Rest')}"/>:</td>
    				<td  colspan="3">
    					  <%-- <ui:textarea skin="${contextStyleTheme}"  id="serInvokeIns.serInvokeInsDesc" name="serInvokeIns.serInvokeInsDesc" value="${serInvokeInsMap.SER_INVOKE_INS_DESC}" width="800" height="200"/> --%>
    					  <label>${pageRestAdd}</label>
    				</td>
    		 </tr>
    		 </c:if>
    		 
              <tr>
    				<td  colspan="4"  align="center">
						  <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="art.dialog.close();"></ui:button>
    				</td>	
    			</tr>
    		 </table>
    		  <br><br><br><br><br>
    	</ui:form>
    </div>
</div>
<ui:iframe  skin="${contextStyleTheme}"  iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<script>
$('#service_name').click(function(){
	var service_id = $('#serserviceId').val();
	window.location.href="${contextPath}/serviceManager/showUpdateServiceData.shtml?serviceId="+service_id+"&pageShowMsg=show"; 
});
$('#component_name').click(function(){
	var component_id = $('#sercomponentId').val();
	window.location.href='${contextPath}/component/preAddCompInfo.shtml?tmpType=edit&pageShowMsg=show&component.componentId='+component_id;
});
$('#org_name').click(function(){
	var org_id = $('#serorgId').val();
	window.location.href='${contextPath}/mgr/queryOrgInfo.shtml?tmpType=edit&pageShowMsg=show&content_Id='+org_id;
});
$('#messageFlow_name').click(function(){
	var messageFlow_id = $('#messageFlow_id').val();
	var url = '${msFlowUrl}?messageFlowId='+messageFlow_id;
	//openWindows(url,'MessageFlow');
	window.open(url);
	//window.location.href=url;
});
$('#version_name').click(function(){
	var contract_id = $('#contract_id').val();
	window.location.href="${contextPath}/contractManager/gotoEditContract.shtml?pageShowMsg=show&contractId=" + contract_id;
});
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
