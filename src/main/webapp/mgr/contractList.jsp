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
		      <s:property value="%{getText('eaap.op2.conf.contractregauditing.manageContract')}"/>
	    	</div>
	    </div>
      	<div class="accordion-header" >
   			<div class="accordion-header-text">
   				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
        			<s:property value="%{getText('eaap.op2.conf.contractregauditing.queryCondition')}"/>
        		</div>  
   		</div>
   		<div>
   			<ui:form name="myForm" action="showContractList.shtml" method="post">
   				<table class="mgr-table">
   					<tr>
	   					<td class="item4"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractID')}"/>:</td>	
	    				<td ><input type="text" name="contract.contractId" value="${contract.contractId}"/></td>	
	    				<td class="item4"><s:property value="%{getText('eaap.op2.conf.contractregauditing.baseConractID')}"/>:</td>	
	    				<td ><input type="text" name="contract.baseContractId" value="${contract.baseContractId}"/></td>
	    				<td class="item4"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractName')}"/>:</td>	
	    				<td ><input type="text" name="contract.name" value="${contract.name}"/></td>
	    				<td class="item4" ><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractCode')}"/>:</td>	
	    				<td ><input type="text" name="contract.code" value="${contract.code}"/></td>
   					</tr>
   					<tr>
	    				<td colspan=8 style="TEXT-ALIGN: center;PADDING-RIGHT:30px; ">
	    					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.contractregauditing.checksubmit')}"/>"  href="javascript:myForm.submit();">
							  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.contractregauditing.checksubmit')}"/></span>
							  </a>
	    				</td>	
    				</tr>
   				</table>
   				<br/>
    		 	<div style="TEXT-ALIGN: right;">
					<a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.contractregauditing.add')}"/>"  href="${contextPath}/contract/preInsertContractInfo.shtml">
						<span class="button-text"><s:property value="%{getText('eaap.op2.conf.contractregauditing.add')}"/></span>
					</a>
               	</div>
               	<table class="list-table" cellpadding="1" cellspacing="0">
               		<tr class="tab-header">
               			<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractID')}"/></td>
               			<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.baseConractID')}"/></td>	
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractName')}"/></td>
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractCode')}"/></td>
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractState')}"/></td>
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractDesc')}"/></td>
    					<td class="middle"><s:property value="%{getText('eaap.op2.conf.contractregauditing.operate')}"/></td>
               		</tr>
               		<c:forEach var="contractInfo" items="${contractList}" step="1"> 
					        <tr class="even">
					              <td align="center">${contractInfo.CONTRACT_ID}</td>
					              <td align="center">${contractInfo.BASE_CONTRACT_ID}<c:if test="${contractInfo.BASE_CONTRACT_ID==null }">null</c:if></td>
					              <td align="center">${contractInfo.NAME }<c:if test="${contractInfo.NAME==null }">null</c:if></td>
					              <td align="center">${contractInfo.CODE }<c:if test="${contractInfo.CODE==null }">null</c:if></td>  
					              <td align="center">${contractStateMap[contractInfo.STATE] }</td>  
					              <td align="center">${contractInfo.DESCRIPTOR }<c:if test="${contractInfo.DESCRIPTOR==null }">null</c:if></td>  
					              <td align="center">
                                    <a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.contractregauditing.detail')}"/>"  href="${contextPath}/contract/showContractVersionAndFormatList.shtml?content_Id=${contractInfo.CONTRACT_ID}">
					                    <span class="button-text"><s:property value="%{getText('eaap.op2.conf.contractregauditing.detail')}"/></span>
				                    </a>
				                    <c:if test="${contractInfo.STATE!='R'}">
				                    <a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.contractregauditing.delete')}"/>"  href="javascript:if(confirm('Are you sure to delete the component and cascade delete relational data?'))window.location='${contextPath}/contract/deleteContract.shtml?content_Id=${contractInfo.CONTRACT_ID}'">
					                    <span class="button-text"><s:property value="%{getText('eaap.op2.conf.contractregauditing.delete')}"/></span>
				                    </a>
				                    </c:if>
                                   </td>  
				 			</tr>
			   		 </c:forEach>
		   		 </table>
		   		 <div align="right" >
				 	<ui:page id="page"/> 
				 </div> 
   			</ui:form>
   		</div>
    </div>
  </body>
</html>
