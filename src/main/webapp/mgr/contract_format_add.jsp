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
      <s:property value="%{getText('eaap.op2.conf.contractregauditing.eaapPlatfrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.contractregauditing.manageContract')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.contractregauditing.add')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.contractregauditing.add')}"/>
         </div>
         
    </div>
    
    <div>
       <form  name="myForm" action="insertContractFormat.shtml" method="post"> 
       <input type="hidden" name="contractFormat.contractVersionId" value="${contractFormat.contractVersionId}"/>
            <table class="mgr-table">
    		 <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatReqRsp')}"/>:</td>
              <td>   
              	<select name="contractFormat.reqRsp">
			      	<option value="REQ"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatReq')}"/></option>
			      	<option value="RSP"><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatRsp')}"/></option>
				</select>
              </td> 
             </tr>
            <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatConType')}"/>:</td>
              <td>
	              <select name="contractFormat.conType">
				       <c:forEach var="conTypeVar" items="${conType}" step="1"> 
	                       <option value="${conTypeVar.key}"   <c:if test="${conTypeVar.key== 1}">selected</c:if>>${conTypeVar.value}</option>
				       </c:forEach>
			       </select>
		       </td>
            </tr>
            <tr>
              <td class="tar"><font color="red"></font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatHeader')}"/>:</td>
              <td><textarea style="width: 396px; height: 300px;" id="description" class="input-text" rows="6" cols="60" name="contractFormat.xsdHeaderFor"></textarea> </td>
            </tr>
            <tr>
              <td class="tar"><font color="red"></font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatFormat')}"/>:</td>
              <td><textarea style="width: 396px; height: 300px;" id="description" class="input-text" rows="6" cols="60" name="contractFormat.xsdFormat"></textarea> </td>
            </tr>
            <tr>
              <td class="tar"><font color="red"></font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatDemo')}"/>:</td>
              <td><textarea style="width: 396px; height: 300px;" id="description" class="input-text" rows="6" cols="60" name="contractFormat.xsdDemo"></textarea> </td>
            </tr>
            <tr>
              <td class="tar"><font color="red"></font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractFormatDesc')}"/>:</td>
              <td><textarea style="width: 396px; height: 300px;" id="description" class="input-text" rows="6" cols="60" name="contractFormat.descriptor"></textarea></td>
            </tr>
    		     
    	      <tr>
    				<td  colspan="2" class="item-content" align="center">
    					<a class="button-base button-middle" title="<s:property value="%{getText('eaap.op2.conf.contractregauditing.checksubmit')}"/>" href="javascript:myForm.submit();">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.contractregauditing.checksubmit')}"/></span>
						  </a>
    				</td>	
    			</tr>
    			
    		</table>
    	</form>
    		
    </div>
</div>


<!--body end --> 

</body>
</html>
