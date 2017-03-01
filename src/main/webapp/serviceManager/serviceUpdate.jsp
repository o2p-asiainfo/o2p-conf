<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  </head>
  <style>
	a.linkCss {  color: #0000FF; text-decoration: underline;}
	a.linkCss:hover {  color: #FF0000; text-decoration: underline;}
  </style>
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	    <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.serviceAttrRegister')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.updateService')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <ui:form id="serviceUpdate" action="../serviceManager/UpdateServiceData.shtml" method="post" name="serviceUpdate" >
	   
	   <ui:validators validateAlert="div" validatorGroup="group1"> 
		    <ui:validator fieldId="serviceCnName" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.serviceNameIsNull')}"></ui:validator>
		    <ui:validator fieldId="serviceCnName" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorUpdateService(serviceCnName))" message="%{getText('eaap.op2.conf.server.manager.serviceNameExist')}"></ui:validator>
		    <ui:validator fieldId="serviceVersion" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.serviceVersionIsNull')}"></ui:validator>
		    <ui:validator fieldId="serviceVersion" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorUpdateService(serviceVersion))" message="%{getText('eaap.op2.conf.server.manager.serviceVersionExist')}"></ui:validator>
		    <ui:validator fieldId="serviceCode" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.serviceCodeIsNull')}"></ui:validator>
		    <ui:validator fieldId="serviceCode" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorUpdateService(serviceCode)" message="%{getText('eaap.op2.conf.server.manager.serviceCodeExist')}"></ui:validator>
		 	<ui:validator fieldId="protocol" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.protocolIsNull')}"></ui:validator>
		 </ui:validators>
	   
	 	<table class="mgr-table">
	   		<tr>
	  			<td class="item-center" colspan="4"  style="background-color:#EFEFEF"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceBasicInfor')}" /></td>
	   		</tr>
			<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serviceName')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	
	  				<input type="hidden" name="msgFlowUrl" id="msgFlowUrl" value="${flowUrl}" />
	  				    <input type="hidden" name="Service.serviceId" id="Service.serviceId" value="${serviceHashMap.SERVICE_ID}" /> 
	  				    <input name="serviceFlag" id="serviceFlag" type="hidden" value="${serviceFlag}"></input> 					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="Service.serviceCnName" id="serviceCnName" value="${serviceHashMap.SERVICE_CN_NAME}" ></ui:inputText>
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="Service.serviceCode" id="serviceCode" value="${serviceHashMap.SERVICE_CODE}" ></ui:inputText>
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr style="display:none;">
	   		<%-- 
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceCategory')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	 
	  					<ui:select skin="${contextStyleTheme}" name="Service.serviceType" id="serviceType" value="${serviceHashMap.SERVICE_TYPE}" list="serviceCategoryResultList" width="158" layerWidth="158" listKey="serviceTypeId" listValue="serviceTypeName" ></ui:select>
	  				</div>
	   			</td> --%>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">
	  					<ui:inputText skin="${contextStyleTheme}" name="Service.serviceVersion" id="serviceVersion" value="${serviceHashMap.SERVICE_VERSION}"></ui:inputText>
	  				</div>  	
	   			</td> 
	   		</tr>
	   		<tr>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serviceAPI')}" />:</td>
	   			<td colspan="3">
	   			<input type="hidden" name="attr_spec_id" value="${attr_spec_id}">
	   			   &nbsp;&nbsp;<select id="serviceAPI" name="serviceAPI">
	   			      <c:if test="${serviceAPI == 'Y' }">
	   			      <option value="Y" selected>Y</option>
	   			      <option value="N" >N</option>
	   			      </c:if>
	   			      <c:if test="${serviceAPI == 'N' }">
	   			      <option value="Y">Y</option>
	   			      <option value="N" selected>N</option>
	   			      </c:if>
	   			      <c:if test="${serviceAPI == null }">
	   			      <option value="Y">Y</option>
	   			      <option value="N" selected>N</option>
	   			      </c:if>
	   			   </select>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.whetherToProvideAPIWay')}" />:</td>
	  			<td class="item-content" colspan="3"> 
	  		    <div class="ui-widget" > 
	  				<div class="ui-widget">
	  				<ui:switchOf  skin="${contextStyleTheme}" id="ProvideAPIWay" classCss="${switchMap.ProvideAPIWayClassCs}" state="${switchMap.ProvideAPIWayState}" change="${switchMap.ProvideAPIWayChange}" name="ProvideAPIWay" valueAttr="${switchMap.ProvideAPIWay}"></ui:switchOf>	  					  					
	  				</div>
 		        </div>
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.whetherToUserAuthorization')}" />:</td>
	  			<td class="item-content" colspan="3"> 
	  		    <div class="ui-widget" > 
	  				<div class="ui-widget">	
	  				<ui:switchOf skin="${contextStyleTheme}" id="UserAuthorization" classCss="${switchMap.UserAuthorizationClassCs}" state="${switchMap.UserAuthorizationState}" change="${switchMap.UserAuthorizationChange}" name="UserAuthorization" valueAttr="${switchMap.UserAuthorization}"></ui:switchOf>				  					
	  				</div>
 		        </div>
	   			</td>	 
	   		</tr>
	   		
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceDesc')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">
	  					<ui:textarea skin="${contextStyleTheme}" name="Service.serviceDesc" id="serviceDesc" value="${serviceHashMap.SERVICE_DESC}" width="820"></ui:textarea>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item-center" colspan="4"  style="background-color:#EFEFEF" ><s:property value="%{getText('eaap.op2.conf.server.manager.ServiceClassification')}" /></td>
	   		</tr>
	   	    <tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.BelongingToBusinessProcess')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">	  				  					
	  		  <ui:selectedtree skin="${contextStyleTheme}" attrIsParent="qweeIsParent" method="eaap-op2-conf-server-ServerManagerAction.getBizFunctionSeltree" initId ="${FuncSeletedTreeMap.funcId}"  
            textId="ServiceFunc" attrId="qweeid" attrPid="qweepId"  attrName="qweepName" path="${FuncSeletedTreeMap.funcPath}" id="ServiceFuncTree" value="${FuncSeletedTreeMap.funcValue}" idvalue="${FuncSeletedTreeMap.funcId}" textWidth="450px" chkStyle="checkbox" saveIdTextId="ServiceFuncSave" saveIdTextName="ServiceFuncSave"></ui:selectedtree>
	  				</div> 	
	   			</td>
	   		</tr>
	   	    <tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.BelongingToMenu')}" />:</td>
	   			<td class="item-content" colspan="3">
  				    <div class="ui-widget">	 		
  		     <ui:selectedtree skin="${contextStyleTheme}" attrIsParent="qweIsParent" method="eaap-op2-conf-server-ServerManagerAction.getDirectorySeltree" 
            textId="ServiceDir" attrPid="qwepId" attrId="qweid" path="${DirSeletedTreeMap.dirPath}" initId ="${DirSeletedTreeMap.dirId}"  
           id="ServiceDirTree" value="${DirSeletedTreeMap.dirValue}" idvalue="${DirSeletedTreeMap.dirId}"  attrName="qwepName" chkStyle="checkbox" saveIdTextId="ServiceDirSave" saveIdTextName="ServiceDirSave" textWidth="450px"></ui:selectedtree>
	  				</div>  	
	   			</td>
	   		</tr>
	   	    <tr>
	  			<td class="item-center" colspan="4"   style="background-color:#EFEFEF"><s:property value="%{getText('eaap.op2.conf.server.manager.interfaceProtocol')}" /></td>
	   		</tr>
            <tr>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />:</td>
	  			<td class="item-content">
	  				    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/contractManager/showContractAndVersion.shtml?chooseContractName=protocolDetail&&contractName=protocol&&chooseContractId=contract_id&&contractVersionName=version&&contractVersionID=contractVersionId','%{getText('eaap.op2.conf.server.manager.chooseContract')}',1000,530)" shape="s"></ui:button>	  					  						
	  				    <input name="version" id="version" value="${contractHashMap.VERSION}"  onfocus="changeService();" readonly="true"  style="width:160px; border-width:0; color:#0000FF; cursor:pointer; font-size:12px;text-decoration: underline;"  onclick="showContractVersion()"/>
	  				    <ui:inputText skin="${contextStyleTheme}"  type="hidden" name="Service.contractVersionId" id="contractVersionId" value="${serviceHashMap.CONTRACT_VERSION_ID}"  onfocus="changeService();"></ui:inputText>
	  					
	  					<input type="hidden" name="protocol" id="protocol"  value="${contractHashMap.CONTRACTNAME}"/>
	  					<input type="hidden" name="protocolId" id="protocolId" />
	  					<input type="hidden" name="contract_id" id="contract_id" value="${serviceHashMap.CONTRACT_ID}"/>
	   			</td>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.protocol')}" />:</td>
	   			<td class="item-content">
	  				<a href="#" onclick="procotolDetail()" id="protocolDetail"  class="linkCss"  title="<s:property value="%{getText('eaap.op2.conf.server.manager.detail')}" />" >${contractHashMap.CONTRACTNAME}</a>
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item-center" colspan="4"   style="background-color:#EFEFEF"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceChoreography')}" /></td>
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.defaultFlow')}" />:</td>
	  			<td class="item-content" colspan="3" > 				  									  					
	   				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/messageFlow/showMessageFlow.shtml?pageState=choosePage&objectId=defaultMsgFlow&attrName=defaultMsgFlowName','Select messageFlow')" shape="s"></ui:button>
	   				    <a href="#" onclick="openMsgFlow()" id="defaultMsgFlowName"  class="linkCss"  title="<s:property value="%{getText('eaap.op2.conf.server.manager.detail')}" />" >${serviceHashMap.MESSAGE_FLOW_NAME}</a>
	   				    <input id="defaultMsgFlow" name="Service.defaultMsgFlow" type="hidden" value="${serviceHashMap.MESSAGE_FLOW_ID}"/>
	   			</td>
	   		</tr>
	   		
	   		<tr style="display:none;">
	  			<td class="item-center" colspan="4" ><s:property value="%{getText('eaap.op2.conf.server.manager.api')}" /></td>
	   		</tr>
	   		<tr style="display:none;">
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.apiMethod')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">
	  					<ui:inputText skin="${contextStyleTheme}" name="Api.apiMethod"  id="apiMethod"  value="${switchMap.apiMethod}" style="width:450px"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr style="display:none;">
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.apiDesc')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">
	  					<ui:textarea skin="${contextStyleTheme}" name="Api.apiDesc" id="apiDesc" value="${switchMap.ApiDesc}" width="820"></ui:textarea>
	  				</div>  	
	   			</td>
	   		</tr>
	   		
	   		<tr>
	  			<td class="item-center" colspan="4" >
	  			<c:if test="${pageShowMsg == null }">
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}" onclick="doSubmit()"></ui:button>
	  			</c:if>
	   		    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDirCancel')}" onclick="history.go(-1);" ></ui:button>
	   		    <input type="hidden" name="msgFlowUrl" id="msgFlowUrl" value="${flowUrl}" />
	  			</td>
	   		</tr>
	   		       
	   		
	    </table>
	    
	    </ui:form>
	  </div>
       </div> 
       <ui:iframe skin="${contextStyleTheme}"  iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
       </body>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jqueryui/jquery-ui-v1.10.3.js"></script>
	<style type="text/css">  
	.ui-autocomplete {max-height: 120px;overflow-y: auto; overflow-x:hidden;}
	.ui-autocomplete-loading {background: white url('${contextPath}/resource/${contextStyleTheme}/images/loading.gif') right center no-repeat;}
	* html .ui-autocomplete {height: 120px;}  
	</style>
<script type="text/javascript">
     $("#serviceCode").keyup(function(){
     	setValueAsServiceCode();
     });
     $("#serviceCode").blur(function(){
     	setValueAsServiceCode();
     });
     function setValueAsServiceCode(){
     	var sCode = $("#serviceCode").val();
     	$("#serviceVersion").val(sCode);
     	$("#apiMethod").val(sCode);
     }

     $("#serviceDesc").keyup(function(){
     	setValueAsServiceDesc();
     });
     $("#serviceDesc").blur(function(){
     	setValueAsServiceDesc();
     });
     function setValueAsServiceDesc(){
     	var sDesc = $("#serviceDesc").val();
     	$("#apiDesc").val(sDesc);
     }

    var svcCache = {};
	 function changeService(){
	    $("#protocolId").val("");
	 	
	    $("#protocol").autocomplete({  
	    	minLength:1,
            autoFocus:true,
	    	source: function(request,response){
	    		 var term = request.term;
            	 if (term in svcCache){
            	 	response($.map(svcCache[term],function(item){
                   		return {
                             label:item.name,
                             value:item.name,
                             id:item.contractId
                         };
                    }));
                    return;
            	 }
            	 
    		 	lastXhr = $.ajax({
    		 		type:"POST",
    		 		url:"../serviceManager/showProtocol.shtml?reqFrom=from",
                    dataType:"json",
                    data:{protocol:$("#protocol").val()},
                    success:function(data){
                    	svcCache[term] = data;
                    	response($.map(data,function(item){
                    		return {
                                 label:item.name,
                                 value:item.name,
                                 id:item.contractId
                            };
                    	}));
                    }
    		 	});
	    	},
	    	select:function(event,ui){
	    		$("#protocolId").val(ui.item.id);
	    		ss();
	    	} 
	     });
	 }
         function ss(){
          var protocolId = document.getElementById('protocolId').value;
             $.ajax({
				type: "POST",
				async:true,
			    url: "../serviceManager/serviceAddprotocolVersion.shtml",
			    dataType:'json',
			    data:{value:protocolId},
				success:function(msg){ 
				alert(msg);
                }
                });
            }
            
             onclick="openWindows('${contextPath}/contractManager/editContractManager.shtml?contractVersionId="+document.getElementById("contractVersionId").value
         
         function showContractVersion(){
        	 var contractVersionId = document.getElementById('contractVersionId').value;
        	 if(contractVersionId==""){
        		 return;
        	 }
        	 window.open("${contextPath}/contractManager/addContractManager.shtml?contractVersionId=" + contractVersionId);
   	     }
	
	function procotolDetail(){
        	 var protocolId1 = document.getElementById('contract_id').value;
        	 //var protocolId2 = document.getElementById('protocolId').value;
        	 var contractId = "";
        	 if(protocolId1!=""){
        		 contractId = protocolId1;
        	 }//else if(protocolId2!=""){
        		// contractId = protocolId2;
        	 //}
        	 else{
        		 alert("no selected!!");
        		 return;
        	 }
        	 openWindows("${contextPath}/contractManager/gotoEditContract.shtml?pageState=pageState&contractId=" + contractId,"<s:property value="%{getText('eaap.op2.conf.server.manager.protocolDetail')}" />",950,700);
   	  }
            function doSubmit(){
            	var ProvideAPIWay = $('input[id=ProvideAPIWay]').val();
            	var UserAuthorization = $('input[id=UserAuthorization]').val();
	             if (comm_validators_check('group1')) {
		             if ($('#protocol').val() == "") {
		            	 alert("<s:property value="%{getText('eaap.op2.conf.server.manager.protocolIsNull')}" />");
		            	 return;
		             }
		             if ($('#defaultMsgFlow').val() == "") {
		            	 alert("<s:property value="%{getText('eaap.op2.conf.server.manager.defaultFlowIsNull')}" />");
		            	 return;
		             }
		             
		             if ($('#serviceFlag').val() == "dir") {
		            	 document.serviceUpdate.action="${contextPath}/serviceManager/UpdateServiceData.shtml?ProvideAPIWay="+ProvideAPIWay+"&UserAuthorization="+UserAuthorization;
		            	 document.serviceUpdate.submit();
		             } else {
		            	 document.serviceUpdate.action="${contextPath}/serviceManager/UpdateServiceDataManger.shtml?ProvideAPIWay="+ProvideAPIWay+"&UserAuthorization="+UserAuthorization;
		            	 document.serviceUpdate.submit();
		             }
	             }
            }
            
 			function closeWin(){
	  	 	 $('#opendialog').window('close');
	      }
// 	      	 function  getChangeData(value){
// 	               var messageFlowId = value;
// 	               $('#messageFlowId').val(messageFlowId);
// 	        }
	       function showmsgflow(){
                 var messageFlowId =  $('#defaultMsgFlow').val();
                 //openWindows($('#msgFlowUrl').val()+"?messageFlowId="+messageFlowId+"&serInvokeInsId=","_bank");
                 openWindows('${contextPath}/messageFlow/showMessageFlow.shtml',"<s:property value="%{getText('eaap.op2.conf.server.manager.chooseFlow')}" />",1000,500);
		   }
	       function openMsgFlow(){
				var messageFlowId =  $('#defaultMsgFlow').val();
				if("" !=  messageFlowId){
					var msgFlowUrl = $('#msgFlowUrl').val()+"?messageFlowId="+messageFlowId;
					window.open(msgFlowUrl,"MessageFlow");
				}else{
					var msgFlowUrl = $('#msgFlowUrl').val();
					window.open(msgFlowUrl,"MessageFlow");
				}
		   }
	       
	       function reflashWindow(){
	    	   changeTopScrollHeight();
	       }
	       function setMessageFlowInfo(messageFlowNameObj,messageFlowName,messageFlowIdObj,messageFlowId){
	       		$('#'+messageFlowNameObj).text(messageFlowName);
	       		$('#'+messageFlowIdObj).val(messageFlowId);
	       }
   </script>   
   <%@ include file="/common/ssoCommon.jsp"%>        
</html>
