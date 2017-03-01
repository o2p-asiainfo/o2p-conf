<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<script>
	 function isExit(){
	    	//alert(obj);
	    	var flag ;
	    	$.ajax({
				type: "POST",
				async:false,
			    url: "${contextPath}/contractManager/isExitConCode.shtml",
			    dataType:'json',
			    data:{code:$("#code").val()},
				success:function(msg){ 
						 if(msg.retCode==1){
							flag = true;
						 }else{
							 flag = false;
						 }
	              }
	         });
	    	//alert(flag);
	    	return flag;
	    }
	 
	 var baseContractVal = "";
	 var baseContractText = "";
	 function hiddenBaseContract(){
		 
		 var isBaseVal = $('#isBase').find('option:selected').val();
		 if (isBaseVal == "1") {
			 $("#baseContractId").find('option[value=]').attr("selected",true);
			 $('#baseContractId[class=tag_select]').text("");
			 
			 $('#isBaseSelect').attr('colspan','3');
			 $('#contractSelectText').attr('style','display:none');
			 $('#contractSelectSelect').attr('style','display:none');
			 
		 }else if(isBaseVal == "0") {
			 $('#isBaseSelect').removeAttr('colspan');
			 $('#contractSelectText').removeAttr('style');
			 $('#contractSelectSelect').removeAttr('style');
			 
			 $("#baseContractId").find('option[value=' + baseContractVal + ']').attr("selected",true);
			 $('#baseContractId[class=tag_select]').text(baseContractText);
		 }
	 }
	 
	 function changeContract() {
		 baseContractVal = $('#baseContractId').find('option:selected').val();
		 baseContractText = $('#baseContractId').find('option:selected').text();
	 }
	 
	</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.contractManage')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.prov.addContract')}" />
	      	</div>
	    </div> 

<div id="main_container">
<ui:form method="post" id="contractForm" action="addContract.shtml">
<ui:validators validateAlert="div" validatorGroup="group1"> 
<ui:validator fieldId="name" validatorType="stringlength" required="true" minLength="2" maxLength="50" trim="true" message="%{getText('eaap.op2.conf.prov.notexceed25char')}"/>
<ui:validator fieldId="code" validatorType="stringlength" required="true" minLength="2" maxLength="50" trim="true" message="%{getText('eaap.op2.conf.prov.notexceed25char')}"/>	
<ui:validator fieldId="code" validatorType="fun"  required="true" expression="isExit" message="%{getText('eaap.op2.conf.prov.isExit')}"></ui:validator>	
<ui:validator fieldId="descriptor" validatorType="stringlength" minLength="0" maxLength="249" message="%{getText('eaap.op2.conf.prov.notexceed249char')}"/>		
</ui:validators>	
	<div class="contentWarp">
	   <div>
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.contractInfo')}" />
         		</div>       
    	   </div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.portal.prov.contractName')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText id="name"  name="contract.name" skin="${contextStyleTheme}" />
	   			</td>
	   			<td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" />:</td>
	  			<td >
	  				<ui:inputText id="code"  name="contract.code" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right"><s:property value="%{getText('eaap.op2.conf.compregauditing.isBase')}" />:
	   			</td>
	   			<td id="isBaseSelect" >
					<ui:select  
	    				name="contract.isBase" 
	    				id="isBase"   
	    			    list="isBaseList" 
	    			    listKey="isBaseCode" 
	    			    listValue="isBaseName" 
	    			    skin="${contextStyleTheme}"
	    			    onchange="hiddenBaseContract();"
	    			    >
    			    </ui:select>
	  			</td>
	   			<td align="right" id="contractSelectText"><s:property value="%{getText('eaap.op2.portal.prov.contractBasic')}" />:</td>
	   			<td id="contractSelectSelect" >
	  				<ui:select  
	    				name="contract.baseContractId" 
	    				id="baseContractId"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="baseContractList" 
	    			    listKey="BASEID" 
	    			    listValue="NAME" 
	    			    layerWidth="200px"
	    			    skin="${contextStyleTheme}"
	    			    onchange="changeContract();"
	    			    >
    			    </ui:select>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan=3>
	   			<ui:textarea id="descriptor" name="contract.descriptor" width="800" height="200" skin="${contextStyleTheme}"/> 																				
	   			</td>
		   		</tr>
		   		<tr>	
		   		  <td  colspan="4"  align="center">
    					  <ui:button text="%{getText('eaap.op2.conf.prov.next')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="if(comm_validators_check('group1')){contractForm.submit();}"></ui:button>
						  <ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="history.go(-1);"></ui:button>   				       
    				</td>
		   		</tr>
		    </table>
	  	</div>
	</div>
</ui:form>
</div>


<!--body end --> 
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>