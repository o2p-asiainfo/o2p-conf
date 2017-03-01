<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.comp/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.comp/1999/xhtml">
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
      <s:property value="%{getText('eaap.op2.conf.compregauditing.compDetail')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.compregauditing.compDetail')}"/>
         </div>
         
    </div>
    
    <div>
       <div style="TEXT-ALIGN: right;">
       <a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.compregauditing.update')}"/>"  href="${contextPath}/component/queryCompInfo.shtml?tmpType=edit&content_Id=${compInfoMap.COMPONENT_ID}">
		 <span class="button-text"><s:property value="%{getText('eaap.op2.conf.compregauditing.update')}"/></span>
	   </a>
        </div>
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compType')}"/>:
    				</td>	
    				<td class="item-content">${compInfoMap.COMPTYPE}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}"/>:
    				</td>	
    				<td class="item-content">${compInfoMap.NAME}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}"/>:
    				</td>	
    				<td class="item-content">${compInfoMap.REG_TIME}
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compCode')}"/>:
    				</td>	
    				<td class="item-content">${compInfoMap.CODE}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.orgId')}"/>:
    				</td>
    				<td class="item-content">${compInfoMap.ORG_ID}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compState')}"/>:
    				</td>
    				<td class="item-content">${compStateMap[compInfoMap.STATE]}<c:if test="${compStateMap[compInfoMap.STATE]==null}">null</c:if>
    				</td>
    			</tr>
    			<tr>  
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compDesc')}"/>:
    				</td>
    				<td colspan="6" class="item-content">${compInfoMap.DESCRIPTOR}
    				</td>
    			</tr>	
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compPic')}"/>:
    				</td>	
    				<td colspan="6" class="item-content">
    				  <img src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${compInfoMap.S_FILE_ID}" width="400" height="300"/>
    				</td>
    			</tr>
    		</table>
    		
    </div>
</div>


<!--body end --> 

</body>
</html>
