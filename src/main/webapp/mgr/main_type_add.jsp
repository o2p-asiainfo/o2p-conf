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
       <c:if test="${editOrAdd=='add'}">
        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeadd')}"/>
       </c:if>
       <c:if test="${editOrAdd=='edit'}">
        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeedit')}"/>
       </c:if>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
           <c:if test="${editOrAdd=='add'}">
	        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeadd')}"/>
	       </c:if>
	       <c:if test="${editOrAdd=='edit'}">
	        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeedit')}"/>
	       </c:if>
         </div>
         
    </div>
    
    <div>
    <ui:form id="myForm" name="myForm" action="insertMainDataType.shtml" method="post"> 
    <ui:validators validateAlert="div" validatorGroup="group1">
	      <ui:validator fieldId="mdtSign" validatorType="requiredstring" required="true" minLength="0" message="%{getText('eaap.op2.conf.proof.notEmpty')}" />
	      <ui:validator fieldId="mdtName" validatorType="requiredstring" required="true" minLength="0" message="%{getText('eaap.op2.conf.proof.notEmpty')}" />
	      <ui:validator fieldId="mdtDesc" validatorType="requiredstring" required="true" minLength="0" message="%{getText('eaap.op2.conf.proof.notEmpty')}" />
	   </ui:validators>
             <input type="hidden"  name="mainDataType.mdtCd" value="${mainDataType.mdtCd}"/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value="${editOrAdd}"/>
            <table align="center" class="mgr-table">
    		 <tr>
    		 
    		  <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypesign')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="mdtSign"    value="${mainDataType.mdtSign}"  name="mainDataType.mdtSign"/>
              </td>
              
              
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypename')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="mdtName"   value="${mainDataType.mdtName}"  name="mainDataType.mdtName"/>
               </td>
             
            </tr>
             
            <tr>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypedesc')}"/>:</td>
              <td colspan="3">
              <ui:textarea  skin="${contextStyleTheme}"   id="mdtDesc" name="mainDataType.mdtDesc" value="${mainDataType.mdtDesc }" width="800" height="200"/> 
              </td>
            </tr>
              <tr>
    				<td  colspan="4"  align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" id="checksubmitId" onclick="if(comm_validators_check('group1')){myForm.submit();}"></ui:button>
						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.cancel')}" id="cancelId" onclick="history.go(-1);"></ui:button>
    				</td>	
    				
    				 
    			</tr>
    		 </table>
    	</ui:form>
    </div>
</div>
<script>
function toaddoredit()
{
  if($("#editOrAdd").val()!=null && $("#editOrAdd").val()=='edit')
  {
   myForm.action="insertMainDataType.shtml" ;
  }else
  {
  myForm.action="insertMainDataType.shtml" ;
  }
  
  myForm.submit();

}
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
