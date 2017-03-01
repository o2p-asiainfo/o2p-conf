<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />		
	
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>		
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>

</head>
<!--body start -->
<body>
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.contractManage')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.prov.addContract')}" />
	      	</div>
	    </div> 

<ui:form method="post" id="contractManagerForm" action="addContractManager.shtml" >	
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
	  			  ${contractDefined.name}
	  				<input type="hidden" name="contractDefined.contractId" id="contractId" value="${contractDefined.contractId}" />
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" />:</td>
	  			<td >
	  			  ${contractDefined.code}	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.portal.prov.contractBasic')}" />:</td>
	   			<td >
	  			  ${contractDefined.baseContractName}	
	   			</td>
	   			<td align="right" ></td>
	   			<td ></td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan=3>
	  				${contractDefined.contractDescriptor}																					
	   			</td>
		   		</tr>		   		
		    </table>
	  	</div>
	  	
	  	<div>
	  	   <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.contractVersionInfo')}" />
         		</div>       
    	   </div>
		 	<table  align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prov.contractVersionCode')}" />:</td>
	   			<td width="40%">
	   				<div style="width:100%; clear:both">
		   				<ui:inputText name="contractDefined.version"   id="contractVersion" value="${contractDefined.version}" skin="${contextStyleTheme}"  style="float:left;"/>	  
		   				<input type="hidden" name="contractDefined.contractVersionId" id="contractVersionId" value="${contractDefined.contractVersionId}"/>		
		   				<span id="holdImg"  style="float:left;"></span>
	   				</div>
	   				<div id ="isHasMsg" style="display:none; width:100%;color:#FF0000; font-size:14px;clear:both"></div>					
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.isNeedCheck')}" />:</td>
	  			<td >
	  			 <ui:select 
		  			 skin="${contextStyleTheme}"
		  			 name="contractDefined.isNeedCheckVersion" 
		  			 id="isNeedCheckVersion" 
		  			 value="${contractDefined.isNeedCheckVersion}" 
		  			 list="selectStateList" 
		  			 listKey="code" 
		  			 listValue="name" >
	  			 </ui:select>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan="3">
	   			<ui:textarea id="contractVersionDescriptor" skin="${contextStyleTheme}" name="contractDefined.contractVersionDescriptor" width="800" height="100" value="${contractDefined.contractVersionDescriptor}"/> 																								
	   			</td>
		   	</tr>	
		    </table>
	  	</div>

	  	<table style="width:100%;font-size:12px;">
    		<tr class="even" align="left">
   				<td style="TEXT-ALIGN: center;">
	   				<ui:button text="%{getText('eaap.op2.conf.prov.next')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="updateContractManager()"/>
	   				<ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="window.location='${contextPath}/contractManager/gotoEditContract.shtml?contractId=' + ${contractDefined.contractId};"></ui:button>												
   				</td>
   			</tr>
   		</table> 		  	
	</div>
</ui:form>
</div>
<!--body end -->
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>
<script>
		var contractVersionIsHas = false;
		var isEdit = false;
		
		$(document).ready(function(){
				$("#isNeedCheckVersion").find('option[value=${contractDefined.isNeedCheckVersion}]').attr("selected",true);
				if ('${contractDefined.isNeedCheckVersion}' == 'Y') {
					$('#isNeedCheckVersion[class=tag_select]').text('<s:property value="%{getText('eaap.op2.conf.prov.yes')}" />');
				} else {
					$('#isNeedCheckVersion[class=tag_select]').text('<s:property value="%{getText('eaap.op2.conf.prov.no')}" />');
				}
				
				var contractVersionId =$("#contractVersionId").val();
				if(contractVersionId.length>0){
					isEdit = true;
					$("#contractVersion").attr("readonly","readonly")
				}else{
					isEdit = false;
				}
		})

		function updateContractManager(){		
			if(contractVersionIsHas){
				$("#contractVersion").focus()
				return;
			}
			var form = document.getElementById("contractManagerForm");
			
			var version = $("#contractVersion").val();
			if (version==""){
				alert('<s:property value="%{getText('eaap.op2.conf.prov.contractVersionIsnotnull')}" />');
				return;
			}
			var contractVersionId
			if ('${contractDefined.contractVersionId}' != '') {
				form.action="${contextPath}/contractManager/addContractManager.shtml?contractVersionId=" + ${contractDefined.contractVersionId} + '&contractId=' + ${contractDefined.contractId};
			} else {
				form.action="${contextPath}/contractManager/addContractManager.shtml?contractId=" + ${contractDefined.contractId};
			}
			
	       	form.submit();				
		}		 
		function closeWin(){
 			$('#opendialog').window('close');
 		}		
 		
 		
		$("#contractVersion").keyup(function(){
			$("#holdImg").html("");
			$("#isHasMsg").html("");
			$("#isHasMsg").css('display','none'); 
		});
		$("#contractVersion").blur(function(){
				hasContractVersion();
		});
		function hasContractVersion(){
			if(isEdit){
				return;
			}
			$("#contractVersion").val(jQuery.trim($("#contractVersion").val()));
			if(jQuery.trim($("#contractVersion").val()) == ""){
				return;
			}
			$("#holdImg").html("<img src='../resource/comm/images/loading.gif'/>");
			var version = jQuery.trim($("#contractVersion").val());
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../contractManager/hasContractVersion.shtml",
			     dataType:"text",
			     data:"version="+version,
			     success:function(msg,data){
						$("#holdImg").html("");
						try {
				      		var jsonObj = eval(msg); 
				      		var isHas = jsonObj[0].isHas;
				      		var docVersions = jsonObj[0].docVersions;
					      	if(isHas=="false"){
					      		//New:
								contractVersionIsHas = false;
								$("#holdImg").html("<img src='../resource/comm/images/onCorrect.gif'/>");
								$("#isHasMsg").html("");
								$("#isHasMsg").css('display','none'); 
					      	}else{
					      		//exist:
								contractVersionIsHas = true;
								$("#holdImg").html("<img src='../resource/comm/images/onFocus.gif'/>");
								$("#isHasMsg").html("<s:property value="%{getText('eaap.op2.conf.prov.contractVersionIsHas')}" />");
								$("#isHasMsg").css('display','block'); 
					      	}
						} catch (e) { 
								$("#holdImg").html("<img src='../resource/comm/images/onFocus.gif'/>");
								$("#isHasMsg").html("<s:property value="%{getText('eaap.op2.conf.prov.contractVersionCheckFailed')}" />");
								$("#isHasMsg").css('display','block'); 
						}
		   	  	}
			});	
		}
</script>