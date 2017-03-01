<%@ page language="java" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title><s:property value="%{getText('eaap.op2.conf.contractregauditing.SysName')}"/></title>
    <link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
  </head>
  
  <body>
    <div class="contentWarp">
		<div class="module-path">
  			<div class="module-path-content">
		      <img src="../resource/blue/images/search.png" />

		      <s:property value="%{getText('eaap.op2.conf.contractregauditing.eaapPlatfrom')}"/>
		      <img src="../resource/blue/images/module-path.png" />
		      <s:property value="%{getText('eaap.op2.conf.contractregauditing.add')}"/>
	    	</div>
	    </div>

   		<div>
   			<ui:form name="myForm" action="showContractList.shtml" method="post">
               	<table class="list-table" cellpadding="1" cellspacing="0">
               		<tr class="tab-header">
               			<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractVersion')}"/></td>
               			<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractIsNeedCheck')}"/></td>	
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractVersionState')}"/></td>
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractReqRsp')}"/></td>
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.operate')}"/></td>
               		</tr>
               		<c:forEach var="contractInfo" items="${contractVandFList}" step="1"> 
					        <tr class="even">
					              <td align="center">${contractInfo.CONTRACT_VERSION_ID}<s:property value="#contractInfo.CONTRACT_VERSION_ID==''"/></td>
					              <td align="center">${contractInfo.IS_NEED_CHECK}<c:if test="${contractInfo.IS_NEED_CHECK==null }">null</c:if></td>
					              <td align="center">${contractInfo.STATE }</td>
					              <td align="center">${contractInfo.REQ_RSP }</td>  
					              <!-- <td align="center">${orgStateMap[orgInfo.STATE]}</td> -->
					              <td align="center">
                                    <a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.contractregauditing.contractNodeDesc')}"/>"  href="${contextPath}/contract/showNodeDesc.shtml?content_Id=${contractInfo.TCP_CTR_F_ID}">
					                    <span class="button-text"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractNodeDesc')}"/></span>
				                    </a>
                                   </td>  
				 			</tr>
				 			<tr>
								<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractXsdDemo')}"/></td>
				 				<td colspan="5" class="item-content"><textarea style="width: 520px; height: 230px;" id="xsdDemo" class="input-text">${contractInfo.XSD_DEMO }</textarea></td>	
				 			</tr>
			   		 </c:forEach>
		   		 </table>
   			</ui:form>
   		</div>
    </div>
  </body>
</html>
