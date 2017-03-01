<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
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
       <c:if test="${editOrAdd=='add'}">
        <s:property value="%{getText('eaap.op2.conf.manager.auth.add')}"/>
       </c:if>
       <c:if test="${editOrAdd=='edit'}">
        <s:property value="%{getText('eaap.op2.conf.manager.auth.update')}"/>
       </c:if>
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
    		  <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="serInvokeInsName"   value="${serInvokeInsMap.SER_INVOKE_INS_NAME}"  name="serInvokeIns.serInvokeInsName"/></td>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.service')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="serserviceName" name="serserviceName"  readonly="true"   value="${serInvokeInsMap.SERNAME}"  />
                  <input type="hidden"  id="serserviceId" name="serInvokeIns.serviceId"  onpropertychange="changeProvince()" value="${serInvokeInsMap.SERVICE_ID}"/>
                  
                  <input type="hidden"  id="serserviceCode" name="serserviceCode"/>
                  <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/serviceManager/showMainInfo.shtml?pageState=pageState&serviceCode=serserviceCode&serviceName=serserviceName&serviceMsgFlowId=sermessageFlowId&serviceMsgFlowName=defaultMsgFlowName&serviceId=serserviceId','Choose Servcice');init();" shape="s"></ui:button>
               </td>
            </tr>
             
            <tr>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}"/>:</td>
              <td>
	              <ui:inputText skin="${contextStyleTheme}"  id="sercomponentName" name="sercomponentName"  readonly="true" value="${serInvokeInsMap.COMPNAME}"/> 
	              <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="selectComponet()" shape="s"/> 
	              <input type="hidden" id="sercomponentId" name="serInvokeIns.componentId" value="${serInvokeInsMap.COMPONENT_ID}"/>
              </td>
              <td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="serorgName" name="serorgName"  readonly="true"  value="${serInvokeInsMap.ORGNAME}"  />
                  <input type="hidden"  id="serorgId" name="org.orgId" value="${serInvokeInsMap.COMPCODE}"/>
                 <!-- 
                 <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgCode=serorgId&chooseOrgName=serorgName','Choose Org')" shape="s"></ui:button>
               	 --> 
               </td>
            </tr>
            <tr>
            	<td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.compregauditing.logLevel')}"/>:</td>
              	<td>
	               <ui:select skin="${contextStyleTheme}"  emptyOption="true" headerValue="" name="serInvokeIns.logLevel" id="logLevelId" 
		       		list="logLevelList" listKey="LOG_LEVEL" listValue="LOG_LEVEL" style="width:70px;" value="'${serInvokeInsMap.LOG_LEVEL}'"></ui:select>
              	</td>
              	<td></td>
              	<td></td>
            </tr>
            <tr>
                <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
    				<td  colspan="3">
    					  <ui:textarea skin="${contextStyleTheme}"  id="serInvokeIns.serInvokeInsDesc" name="serInvokeIns.serInvokeInsDesc" value="${serInvokeInsMap.SER_INVOKE_INS_DESC}" width="800" height="200"/> 
    				</td>
    		 </tr>
    		 <tr>
                  <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}"/>:</td>
    				<td colspan="3">
	   				    <a href="#" onclick="openMsgFlow()" id="defaultMsgFlowName"  name="defaultMsgFlowName" class="linkCss"  title="<s:property value="%{getText('eaap.op2.conf.server.manager.detail')}" />" >${serInvokeInsMap.MFNAME}</a>
	   				    <input name="serInvokeIns.messageFlowId" id="sermessageFlowId"  type="hidden"   value="${serInvokeInsMap.MESSAGE_FLOW_ID}"/> 
	   				    <!--<ui:inputText skin="${contextStyleTheme}" name="serInvokeIns.messageFlowId" id="sermessageFlowId" type="hidden" value="${serInvokeInsMap.MESSAGE_FLOW_ID}"></ui:inputText>-->
	   				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/messageFlow/showMessageFlow.shtml?pageState=choosePage&objectId=sermessageFlowId&attrName=defaultMsgFlowName','Select messageFlow')" shape="s"></ui:button>
    			  </td>	
    		  </tr>
              <tr>
    				<td  colspan="4"  align="center">
    					  <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.next')}" id="checksubmitId" onclick="nextSubmit()"></ui:button>
						  <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="history.go(-1);"></ui:button>
    				       <c:if test="${editOrAdd=='edit'}">
					        <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.ignore')}" id="returnId" onclick="location='${contextPath}/mgr/showProof.shtml?serInvokeIns.serInvokeInsId=${serInvokeInsMap.SER_INVOKE_INS_ID}'"></ui:button>
					       </c:if>
    				</td>	
    			</tr>
    		 </table>
    		  <br><br><br><br><br>
    	</ui:form>
    </div>
</div>
<ui:iframe  skin="${contextStyleTheme}"  iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<script>
function closeWin(){
 $('#opendialog').window('close');
 }
function showmsgflow(serInvokeInsId){
	window.open($("#msgFlowUrl").val()+"?messageFlowId="+$("#sermessageFlowId").val()+"&serInvokeInsId="+serInvokeInsId,"_bank");
} 

function nextSubmit(){
	if ($("#serInvokeInsName").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		$("#serInvokeInsName").focus();
		return false;
	}
	if ($("#serserviceName").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.manager.auth.service')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		return false;
	}
	if ($("#sercomponentName").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		return false;
	}
	if ($("#sermessageFlowId").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.compregauditing.ServiceOrchestration')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		return false;
	}
	$("#myForm").submit();
}

function changeProvince(){
	var sltProvince = document.getElementById("serserviceId")
	var provinceId = sltProvince.value ;
    var paramStr = "serviceId:"+provinceId;
    var select_id = "sermessageFlowId";
	var	ajaxUrl="${contextPath}/rainbowui/getSelectBoxData.shtml?t=&method=eaap-op2-conf-server-ServerManagerAction.loadServiceMessgList&params="+paramStr+"&listKey=MESSFLOWID&listValue=MESSFLOWNAME";
	    // $("#sermessageFlowId").cascadeMethod(select_id,ajaxUrl);
}

function init(){
   if("\v"=="v"){
    document.getElementById("serserviceId").onpropertychange=changeValue;
   }else{ 
 document.getElementById("serserviceId").addEventListener("input",changeProvince(),false);
   }
  }
  
function selectComponet(){
  var serorgId = document.getElementById("serorgId").value;
  openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=sercomponentName&chooseOrgName=serorgName&chooseOrgId=serorgId&chooseCompCode=sercomponentId&orgId='+serorgId,'Choose Component');
}  


function openMsgFlow(){
	var messageFlowId =  $("#sermessageFlowId").val();
	if("" !=  messageFlowId){
		var msgFlowUrl = $('#msgFlowUrl').val()+"?messageFlowId="+messageFlowId;
		window.open(msgFlowUrl,"MessageFlow");
	}else{
		var msgFlowUrl = $('#msgFlowUrl').val();
		window.open(msgFlowUrl,"MessageFlow");
	}
}
function setMessageFlowInfo(messageFlowNameObj,messageFlowName,messageFlowIdObj,messageFlowId){
		$('#'+messageFlowNameObj).text(messageFlowName);
		$('#'+messageFlowIdObj).val(messageFlowId);
}
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
