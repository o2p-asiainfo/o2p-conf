<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.compregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>

<style>

</style>
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	    	<s:property value="%{getText('eaap.op2.conf.compregauditing.SysName')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.compregauditing.compManage')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.compregauditing.orgSelect')}"/>
      	</div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
         </div>
         
    </div>
    
    <div>
    <ui:form name="myForm" action="preSelectOrg.shtml" method="post"> 
    <h1><s:property value="%{getText('eaap.op2.conf.compregauditing.preSelectOrg')}"/></h1>
  			<table class="mgr-table">
					<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.username')}"/>:
    				</td>	
    				<td class="item-content"><input type="text" name="org.orgUsername" value="${org.orgUsername}"/>
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.orgemail')}"/>:
    				</td>	
    				<td class="item-content"><input type="text" name="org.email" value="${org.email}" />
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regrole')}"/>:
    				</td>
    				<td class="item-content">
    				  <select name="orgRole.roleCode">
    				   <option value=""><s:property value="%{getText('eaap.op2.conf.orgregauditing.all')}"/></option>
    				   <option value="1" <c:if test="${org.orgTypeCode== '1'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.orgregauditing.devrole')}"/></option>
    				   <option value="2" <c:if test="${org.orgTypeCode== '2'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.orgregauditing.prorole')}"/></option>
    				   <option value="3" <c:if test="${org.orgTypeCode== '3'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.orgregauditing.hezuohuoban')}"/></option>
    				  </select>
    				</td>
    			 </tr>
    		    
    		    
    		    <tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.realname')}"/>:
    				</td>	
    				<td class="item-content"><input type="text" name="org.name" value="${org.name}" />
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.mobile')}"/>:
    				</td>	
    				<td class="item-content"><input type="text" name="org.telephone" value="${org.telephone}"/>
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.userstate')}"/>:
    				</td>
    				<td class="item-content">
    				    <select name="org.state">
    				           <option value=""><s:property value="%{getText('eaap.op2.conf.orgregauditing.all')}"/></option>
						       <c:forEach var="orgStateMap" items="${orgStateList}" step="1"> 
                                  <option value="${orgStateMap.key}"   <c:if test="${orgStateMap.key== org.state}">selected</c:if>>${orgStateMap.value}</option>
						       </c:forEach>
						     </select>
					</td>
    			</tr>
    			
    		    <tr>
    				<td colspan=6 style="TEXT-ALIGN: center;PADDING-RIGHT:30px; ">
    					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/>"  href="javascript:myForm.submit();">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/></span>
						  </a>
    				</td>	
    			</tr>
    		</table>

    		<br/>
               <table class="list-table" cellpadding="1" cellspacing="0">
					<tr class="tab-header">
    				<td class="middle" width="14%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.username')}"/></td>	
    				<td class="middle" width="20%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.realname')}"/></td>	
    				<td class="middle"><s:property value="%{getText('eaap.op2.conf.orgregauditing.orgemail')}"/></td>
    				<td class="middle"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regrole')}"/></td>	
    				<td class="middle"><s:property value="%{getText('eaap.op2.conf.orgregauditing.userstate')}"/></td>	
    				<td class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.dosomtthing')}"/></td>
    			</tr>
    			
    			 <c:forEach var="orgInfo" items="${orgInfoList}" step="1"> 
					        <tr class="even">
					              <td align="center">${orgInfo.ORG_USERNAME }</td>
					              <td align="center">${orgInfo.NAME }</td>
					              <td align="center">${orgInfo.EMAIL }</td>  
					              <td align="center">${orgInfo.ROLENAME }</td>  
					              <td align="center">${orgStateMap[orgInfo.STATE]}</td>
					              <td align="center">
                                    <a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.compregauditing.selectOrg')}"/>"  href="${contextPath}/component/preAddCompInfo.shtml?content_Id=${orgInfo.ORG_ID}">
					                    <span class="button-text"><s:property value="%{getText('eaap.op2.conf.compregauditing.selectOrg')}"/></span>
				                    </a>
                                   </td>  
				 </tr>
			    </c:forEach>
			 </table>
			 <div align="right" >
			 <ui:page id="page"/> 
			 </div>
			 </ui:form>
  </div>
<!--body end --> 

</body>
</html>
