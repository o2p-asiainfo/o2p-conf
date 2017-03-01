<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
 
 
 
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatemanger')}"/>
       <img src="../resource/blue/images/module-path.png" />
       <c:if test="${editOrAdd=='edit'}">
       <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataedit')}"/>
       </c:if>
       <c:if test="${editOrAdd=='add'}">
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataadd')}"/>
      </c:if>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataadd')}"/>
         </div>
         
    </div>
    
    <div>
    <ui:form id="myForm" name="myForm" action="insertMainData.shtml" method="post"> 
             <input type="hidden"  name="mainData.mdtCd" value="${mainDataType.mdtCd}"/>
             <input type="hidden"  name="mainData.maindId" value="${mainData.maindId}"/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value="${editOrAdd}"/>
            <table align="center" class="mgr-table">
    		 <tr>
    		  <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypename')}"/>:</td>
              <td>
                ${mainDataType.mdtName}
              </td>
              </tr>
              <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataname')}"/>:</td>
              <td>
                <ui:inputText skin="${contextStyleTheme}"  name="mainData.cepName" id="cepName" value="${mainData.cepName}"></ui:inputText>
              </td>
            
            </tr>
            <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatacode')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  name="mainData.cepCode" id="cepCode" value="${mainData.cepCode}"></ui:inputText>
              </td>
            </tr>
            <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatavalue')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  name="mainData.cepValues" id="cepValues" value="${mainData.cepValues}"></ui:inputText></td>
            </tr>
             <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatadesc')}"/>:</td>
              <td>
               <ui:textarea  skin="${contextStyleTheme}"  name="mainData.cepDes" id="cepDes"   value="${mainData.cepDes}" width="194" height="66"></ui:textarea></td>
            </tr>
              <tr>
    				<td  colspan="2" class="item-content" align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" id="checksubmitId" onclick="myForm.submit();"></ui:button>
						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.cancel')}" id="cancelId" onclick="history.go(-1);"></ui:button>
    			
    				</td>	
    				
    				 
    			</tr>
    		 </table>
    	</ui:form>
    </div>
</div>


<!--body end --> 

</body>
</html>
