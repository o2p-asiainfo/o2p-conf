<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
		
	<script>	
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.prov.contractVersionCode')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.portal.prov.contractName')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.prov.isNeedCheck')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.prov.state')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.prov.createTime')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />';
	
	function updateContract(){		
			var form = document.getElementById("contractForm");	
		  	if(comm_validators_check('group1'))
	       	{
	       		form.submit();				
	       	}	
		}
		
	function addMehtod(){	  
		var contractId = document.getElementById("contractId");
  		window.location = "editContractManager.shtml?contractId="+contractId.value;
   	}
   	function updateMethod(){      
		if($('#contractVersionList').datagrid('getSelections')[0]==null||$('#contractVersionList').datagrid('getSelections')[0].VERSIONID==""){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
	    }
    	else{    				
			var contractVersionId = $('#contractVersionList').datagrid('getSelections')[0].VERSIONID ;
			window.location="editContractManager.shtml?contractVersionId=" + contractVersionId;	
    	} 	
    }
   function clickMethod(index,field,value){   
   /* if($('#contractVersionList').datagrid('getSelections')[0]!=null)
    	{
         var contractVersionId = $('#contractVersionList').datagrid('getSelections')[0].VERSIONID ;
         if(contractVersionId=="")
		  {
		    alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		  }else{
			window.location="editContractManager.shtml?contractVersionId=" + contractVersionId;	
		 }
   		} */
	} 
	function deleteMethod(){ 					   
     if($('#contractVersionList').datagrid('getSelections')[0]==null||$('#contractVersionList').datagrid('getSelections')[0].VERSIONID==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
     }
     else{
    	if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmDel')}" />"))
			{			
				var versionId = $('#contractVersionList').datagrid('getSelections')[0].VERSIONID ;
				var contractId = $('#contractVersionList').datagrid('getSelections')[0].CONTRACTID ;
		   		window.location="deleteContractVersion.shtml?contractVersionId="+versionId+"&contractId="+contractId;
			}	
     	}  
   }
    function formatterForState(value,row,index){
	    if(value=='A'){
	      return "<s:property value="%{getText('eaap.op2.portal.prov.effective')}" />"  ;
	    }else if(value=='R'){
	      return "<s:property value="%{getText('eaap.op2.conf.prov.effectiveLoss')}" />"  ;
	    } 
	    else if(value=='Y'){
	      return "<s:property value="%{getText('eaap.op2.conf.prov.yes')}" />"  ;
	    } 
	    else if(value=='N'){
	      return "<s:property value="%{getText('eaap.op2.conf.prov.no')}" />"  ;
	    }
	    else{
	    }
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
	 
	 
	 $(document).ready(function(){
	    if('${contract.isBase}' == "1") {
	    	 $('#isBaseSelect').attr('colspan','3');
			 $('#contractSelectText').attr('style','display:none');
			 $('#contractSelectSelect').attr('style','display:none');
	     } else {
	    	 baseContractVal = $('#baseContractId').find('option:selected').val();
			 baseContractText = $('#baseContractId').find('option:selected').text();
	     }
     })
	 
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.contractManage')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.prov.editContract')}" />
	      	</div>
	    </div> 
<ui:form method="post" id="contractForm" action="editContract.shtml">	
<ui:validators validateAlert="word" validatorGroup="group1"> 
<ui:validator fieldId="name" validatorType="stringlength" required="true" minLength="2" maxLength="50" trim="true" message="%{getText('eaap.op2.conf.prov.notexceed25char')}"/>
<ui:validator fieldId="code" validatorType="stringlength" required="true" minLength="2" maxLength="50" trim="true" message="%{getText('eaap.op2.conf.prov.notexceed25char')}"/>	
<ui:validator fieldId="contractDescriptor" validatorType="stringlength" minLength="0" maxLength="249" message="%{getText('eaap.op2.conf.prov.notexceed249char')}"/>		
</ui:validators>
	<div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.contractInfo')}" />
         		</div>       
    	   </div>
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.portal.prov.contractName')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="contract.name" id="name" value="${contract.name}" skin="${contextStyleTheme}"/>
	  				<input type="hidden" name="contract.contractId" id="contractId" value="${contract.contractId}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" />:</td>
	  			<td >
	  				<ui:inputText name="contract.code" id="code" value="${contract.code}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.compregauditing.isBase')}" />:
	   			</td>
	   			<td id="isBaseSelect" >
					<ui:select  
	    				name="contract.isBase" 
	    				id="isBase"   
	    			    list="isBaseList" 
	    			    listKey="isBaseCode" 
	    			    listValue="isBaseName" 
	    			    value="${contract.isBase}"
	    			    skin="${contextStyleTheme}"
	    			    onchange="hiddenBaseContract();"
	    			    >
    			    </ui:select>
	  			</td>
	   			
	   			<td id="contractSelectText" align="right" width="15%"><s:property value="%{getText('eaap.op2.portal.prov.contractBasic')}" />:</td>
	   			<td id="contractSelectSelect">
   					<ui:select  
    				name="contract.baseContractId" 
    				id="baseContractId"   
    				emptyOption="true" 
    				headerValue=""
    			    list="baseContractList" 
    			    listKey="BASEID" 
    			    listValue="NAME" 
    			    value="${contract.baseContractId}"
	    			layerWidth="200px" 
	    			skin="${contextStyleTheme}"
	    			onchange="changeContract()"
	    			>
   			    </ui:select>
	   			</td>
	   			
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan=3>
	  				<ui:textarea id="descriptor" name="contract.descriptor" width="800" height="100" value="${contract.descriptor}" skin="${contextStyleTheme}"/> 																					
	   			</td>
		   	</tr>		   		
		    </table>
		</div>
	  	<br/>  	
	  	<table style="width:100%;font-size:12px;">
    		<tr class="even" align="left">
   				<td style="TEXT-ALIGN: center;"> 
   				<c:if test="${pageShowMsg == null}">
   				<ui:button text="%{getText('eaap.op2.conf.prov.update')}" id="checksubmitId" onclick="updateContract()" skin="${contextStyleTheme}"/>
   				<c:if test="${empty pageState}">
   					<ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" id="cancelId" onclick="window.location='${contextPath}/contractManager/showContract.shtml';" skin="${contextStyleTheme}"/>
				</c:if>
				</c:if>
				<c:if test="${pageShowMsg != null}">
				<ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" id="cancelId" skin="${contextStyleTheme}" onclick="history.go(-1);"/>
				</c:if>
				<c:if test="${pageState == 'pageState'}">
   					<ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" id="cancelId" onclick="art.dialog.close();" skin="${contextStyleTheme}"/>
				</c:if>
   																
   				</td>
   			</tr>
   		</table> 		
	</div>
</ui:form>
</div>
	    <ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="contractVersionList" remoteSort="false" sortOrder="desc"  
		onClickCell="true" toolbar="true" fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.prov.contractVersionInfo')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
		method="eaap-op2-conf-contract-ContractAction.getContractVersionList" queryParams="true" queryParamsData="${contract.contractId}" skin="${contextStyleTheme}" >
		<ui:gridEasyColumn width="200" index="0" title="0" field="VERSION" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="1" title="1" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="ISNEEDCHECK" hidden="false"   align="center" formatter="true" formatterMethod="formatterForState"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="3" title="3" field="STATE" hidden="false"   align="center" formatter="true" formatterMethod="formatterForState"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="190" index="4" title="4" field="CREATETIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="300" index="5" title="5" field="DESCRIPTOR" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="6" title="6" field="VERSIONID" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="7" title="7" field="CONTRACTID" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>