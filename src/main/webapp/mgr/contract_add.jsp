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
       <form  name="myForm" action="insertContractInfo.shtml" method="post"> 
            <table class="mgr-table">
    		 <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractName')}"/>:</td>
              <td>   
              	<input id="contract.name" class="input-text" size="30" type="text" name="contract.name" />
              </td> 
             </tr>
            <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractCode')}"/>:</td>
              <td><input id="contract.code" class="input-text" size="30" type="text" name="contract.code" /></td>
            </tr>
            <tr>
              <td class="tar"><font color="red"></font><s:property value="%{getText('eaap.op2.conf.contractregauditing.contractDesc')}"/>:</td>
              <td><input id="contract.descriptor" class="input-text" size="30" type="text" name="contract.descriptor" /></td>
            </tr>
            <tr>
              <td class="tar"><s:property value="%{getText('eaap.op2.conf.orgregauditing.area')}"/>:</td>
              <td><select id="contract.baseContractId" name="contract.baseContractId">
                    <c:forEach var="baseContractBean" items="${baseContractMap}" step="1"> 
                        <option value="${baseContractBean.key}">${baseContractBean.value}</option>
					</c:forEach>
                 </select>
              </td>
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
