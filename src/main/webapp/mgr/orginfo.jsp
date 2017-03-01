<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
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
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.orglist')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.userinfo')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.orgregauditing.userinfo')}"/>
         </div>
         
    </div>
    
    <div>
        <table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regrole')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.ROLENAME}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regusername')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.ORG_USERNAME}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtime')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.CREATE_TIME}
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.email')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.EMAIL}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.area')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.ZONE_NAME}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtype')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.ORGTYPENAME}
    				</td>
    			</tr>
    			<tr>  
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.realname')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.NAME}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.mobile')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.TELEPHONE}
    				</td>	
    				
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.userstate')}"/>
    				</td>	
    				<td class="item-content">${orgStateMap[orgInfoMap.STATE]}
    				</td>
    			</tr>	
    			<tr style="display: none;">
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardtype')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.CERTTYPENAME}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardnum')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.CERT_NUMBER}
    				</td>
    				<td class="item">&nbsp;
    				</td>	
    				<td class="item-content">&nbsp;
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.intro')}"/>:
    				</td>
    				<td colspan="6" class="item-content">
    				                    <c:choose>  
					                    <c:when test="${orgInfoMap.DESCRIPTOR==''||orgInfoMap.DESCRIPTOR==null}">  
									       <s:property value="%{getText('eaap.op2.conf.orgregauditing.intro')}"/>......
									    </c:when>
									    <c:when test="${fn:length(orgInfoMap.DESCRIPTOR)>50}">  
									        ${fn:substring(orgInfoMap.DESCRIPTOR, 0, 50)}......
									    </c:when>  
									   <c:otherwise>  
									     ${orgInfoMap.DESCRIPTOR}
									    </c:otherwise>  
									</c:choose>  
    				 </td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardphoto')}"/>:
    				</td>	
    				<td colspan="6" class="item-content">
    				  <img src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${orgInfoMap.FIL_S_FILE_ID}" width="400" height="300"/>
    				</td>
    			</tr>
    		</table>
    		
    </div>
</div>


<!--body end --> 

</body>
</html>
