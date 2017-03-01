<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.lang.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
 
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>

<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>

<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
</head>
<body>
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.logaudit.logaudit')}" />
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.logaudit.detaillog')}" />
      </div>
    </div>
    
    <div>
    <form id="myForm" name="myForm" action="#" method="post"> 
    	  <table class="mgr-table" id="appinfo">
    	       <tr>
    		       <td  colspan="4">
    					<div class="accordion-header" >
					    	<div class="accordion-header-text">
					    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
					         <s:property value="%{getText('eaap.op2.conf.logaudit.operatingdetails')}"/>
					         </div>
					         
					     </div>  
    				</td>
    		 </tr>
            <tr>
             <td  class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.username')}"/>:
    			 </td>	
    				<td>
    			      <label>${pageModel.userName}</label>
    				 </td>
    				
              <td  class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.operationDate')}"/>:</td>
              <td>
    				<label>${pageModel.createDate}</label>
              </td>
            </tr>
    	      
    	      <tr>
    			 <td  class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.userIp')}"/>:
    			   </td>	
    				<td colspan="4">
                 <label>${pageModel.userIp}</label>  
               </td>
    		 </tr>
    		 <tr>
             <td  class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.executionmethod')}"/>:
    			 </td>	
    				<td>
    			      <label>${pageModel.execMethod}</label>
    				 </td>
    				
              <td  class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.operatingtable')}" />:</td>
              <td>
    				<label>${pageModel.tableName}</label>
              </td>
            </tr>
            <tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.SQLstatement')}"/>:</td>
	     			<td colspan="3" style="padding-left: 5px;">
	     			       <ui:textarea skin="${contextStyleTheme}" name="app.appDesc" id="app.appDesc" width="800" height="200"  value="${pageModel.sqlLog}"></ui:textarea>
	        		</td>
	        </tr>
    		 <tr>
              <td class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.executionaction')}"/>:</td>
               <td colspan="4">
                 <label>${pageModel.optAction}</label>
               </td>
            </tr>
             <tr>
              <td class="item"><s:property value="%{getText('eaap.op2.conf.logaudit.changehistory')}"/>:</td>
               <td colspan="4" style="padding:0px,0px,0px,0px;">
               <div style="overflow:auto;width:864px;">
               ${pageModel.dataLog }
                 <%-- 
                 <table style="overflow:auto;width:800px;"> 
                     <tr align="center">
                       <td width="200px" style="border:1px solid #A3A7AC;"></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column A</b></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column B</b></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column C</b></td>
                       
                     </tr>
                     <tr align="center">
                       <td style="border:1px solid #A3A7AC;"><b><s:property value="%{getText('eaap.op2.conf.logaudit.originaldata')}"/></b></td>
                       <td></td>
                       <td></td>
                       <td></td>
                      
                     </tr>
                     <tr align="center">
                       <td style="border:1px solid #A3A7AC;"><b><s:property value="%{getText('eaap.op2.conf.logaudit.nowdata')}"/></b></td>
                       <td></td>
                       <td></td>
                       <td></td>
                       
                     </tr>
                 </table>
                 <br>
                 <table style="overflow:auto;width:1000px;"> 
                     <tr align="center">
                       <td width="200px" style="border:1px solid #A3A7AC;"></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column A</b></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column B</b></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column C</b></td>
                       <td width="200px" style="border:1px solid #A3A7AC;"><b>Column D</b></td>
                     </tr>
                     <tr align="center">
                       <td style="border:1px solid #A3A7AC;"><b><s:property value="%{getText('eaap.op2.conf.logaudit.originaldata')}"/></b></td>
                       <td></td>
                       <td></td>
                       <td></td>
                       <td></td>
                     </tr>
                     <tr align="center">
                       <td style="border:1px solid #A3A7AC;"><b><s:property value="%{getText('eaap.op2.conf.logaudit.nowdata')}"/></b></td>
                       <td></td>
                       <td></td>
                       <td></td>
                       <td></td>
                     </tr>
                 </table>
                 --%>
                 </div>
               </td>
            </tr>
    	</table>
    		     
    		     
    		     
			 <table class="mgr-table">
    		     <tr>
    		       <td  colspan="4" class="item-content" align="center">
    				    
    				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="javascript:history.go(-1);"  id="submitId"></ui:button>        
    				</td>
    			 </tr>
    		 </table>
    	</form>
    		
    </div>
</div>
</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
