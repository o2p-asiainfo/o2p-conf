	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%
	String type = StringEscapeUtils.escapeHtml4(request.getParameter("type"));
%>
<html>
  <head>
    
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
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
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.addService')}" />
	     	</div>
	    </div>

	   <div>
	   <ui:form id="serviceAdd" action="../serviceManager/getServiceAddData.shtml" method="post" name="serviceAdd" >
	   	 <input type="hidden" name="type" id="type" value="<%=type %>" />
		 <ui:validators validateAlert="div" validatorGroup="group1"> 
		    <ui:validator fieldId="serviceCnName" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.serviceNameIsNull')}"></ui:validator>
		    <ui:validator fieldId="serviceCnName" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorService(serviceCnName))" message="%{getText('eaap.op2.conf.server.manager.serviceNameExist')}"></ui:validator>
		    <ui:validator fieldId="serviceVersion" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.serviceVersionIsNull')}"></ui:validator>
		    <ui:validator fieldId="serviceVersion" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorService(serviceVersion))" message="%{getText('eaap.op2.conf.server.manager.serviceVersionExist')}"></ui:validator>
		    <ui:validator fieldId="serviceCode" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.serviceCodeIsNull')}"></ui:validator>
		    <ui:validator fieldId="serviceCode" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorService(serviceCode)" message="%{getText('eaap.op2.conf.server.manager.serviceCodeExist')}"></ui:validator>
			<ui:validator fieldId="protocol" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.protocolIsNull')}"></ui:validator>
			<ui:validator fieldId="defaultMsgFlow" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.defaultFlowIsNull')}"></ui:validator>
		 </ui:validators>
	     
	 	<table class="mgr-table">
	   		<tr>
	  			<td class="item-center" colspan="4"  style="background-color:#EFEFEF"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceBasicInfor')}" /></td>
	   		</tr>
			<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serviceName')}" />:</td>
	  			<td > 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="Service.serviceCnName" id="serviceCnName" textSize="19"></ui:inputText>
	  					<input name="serviceFlag" id="serviceFlag" type="hidden" value="${serviceFlag}"></input>
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />:</td>
	   			<td >
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText  skin="${contextStyleTheme}" name="Service.serviceCode" id="serviceCode"  textSize="19"></ui:inputText>
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr style="display:none;">
	   		<%-- 
	  			<td align="right" width="80"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceCategory')}" />:</td>
	  			<td >
	  				<div class="ui-widget">	  					  					
	  					<ui:select  skin="${contextStyleTheme}" name="Service.serviceType" width="135" id="serviceType" list="serviceCategoryResultList"  emptyOption="true" headerValue=" "	layerWidth="135" listKey="serviceCategoryId" listValue="serviceCategoryName" ></ui:select>
	  				</div>
	   			</td>
	   			 --%>
	   			 
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />:</td>
	   			<td colspan="3">
	   				<div class="ui-widget">
	  					<ui:inputText  skin="${contextStyleTheme}" name="Service.serviceVersion" id="serviceVersion"  textSize="19"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.serviceAPI')}" />:</td>
	   			<td  colspan="3">
	   			   <select id="serviceAPI" name="serviceAPI">
	   			      <option value="Y">Y</option>
	   			      <option value="N">N</option>
	   			   </select>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.whetherToProvideAPIWay')}" />:</td>
	  			<td colspan="3"> 
	  			  <ui:switchOf  skin="${contextStyleTheme}" id="ProvideAPIWay"   state="ON"  name="ProvideAPIWay" valueAttr="1"></ui:switchOf>	  	  				
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.whetherToUserAuthorization')}" />:</td>
	  			<td colspan="3"> 
	  			<ui:switchOf skin="${contextStyleTheme}" id="UserAuthorization" state="ON"  name="UserAuthorization" valueAttr="1"></ui:switchOf>			  								  					
	   			</td>	 
	   		</tr>
	   		
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceDesc')}" />:</td>
	   			<td  colspan="3">
	   				<div class="ui-widget">
	  					<ui:textarea  skin="${contextStyleTheme}" name="Service.serviceDesc" id="serviceDesc" width="820"></ui:textarea>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item-center" colspan="4"   style="background-color:#EFEFEF"><s:property value="%{getText('eaap.op2.conf.server.manager.ServiceClassification')}" /></td>
	   		</tr>
	   	    <tr>
	  			<td  class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.BelongingToBusinessProcess')}" />:</td>
	   			<td colspan="3">
	   				<div class="ui-widget">	  					  					
	  				<ui:seltree id="dewe" skin="${contextStyleTheme}" method="eaap-op2-conf-server-ServerManagerAction.getBizFunctionSeltree"  operationName=""  textId="ce"  chkStyle="checkbox"    
 		            attrId="qweeid" attrPid="qweepId"  attrName="qweepName" textHeight="22px" textWidth="450px" attrIsParent="qweeIsParent" saveIdTextId="Hidce" saveIdTextName="Hidce">
 		            </ui:seltree>
	  				</div> 	
	   			</td>
	   		</tr>
	   	    <tr>
	  			<td  class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.BelongingToMenu')}" />:</td>
	   			<td colspan="3">
  				    <div class="ui-widget">	  					  					
	  				<ui:seltree id="dsfsdf" skin="${contextStyleTheme}" divclass="qwe" method="eaap-op2-conf-server-ServerManagerAction.getDirectorySeltree"  operationName=""  textId="cx" chkStyle="checkbox"    
 		             attrId="qweid" attrPid="qwepId"  attrName="qwepName"  textHeight="22px" textWidth="450px" attrIsParent="qweIsParent" saveIdTextName="Hidcx" saveIdTextId="Hidcx"  >
 		            </ui:seltree>
	  				</div>  	
	   			</td>
	   		</tr>
	   	    <tr>
	  			<td class="item-center" colspan="4"   style="background-color:#EFEFEF"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.interfaceProtocol')}" /></td>
	   		</tr>
            <tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersion')}" />:</td>
	  			<td class="item-content"> 
	  				    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/contractManager/showContractAndVersion.shtml?contractName=protocol&&contractVersionName=version&&contractVersionID=contractVersionId&&chooseContractName=protocolDetail&&chooseContractId=contractId','%{getText('eaap.op2.conf.server.manager.chooseContract')}',1000,530)" shape="s"></ui:button>	  					  						
	  				    <input name="version" id="version" value=""  onfocus="changeService();" readonly="true"  style="width:160px; border-width:0; color:#0000FF; cursor:pointer; font-size:12px;text-decoration: underline;"  onclick="showContractVersion()"/>
	  				    <ui:inputText skin="${contextStyleTheme}"  type="hidden" name="Service.contractVersionId" id="contractVersionId" value="${serviceHashMap.CONTRACT_VERSION_ID}"  onfocus="changeService();"></ui:inputText>
	  					<input type="hidden" name="protocol" id="protocol"  value=""/>
	  					<input type="hidden" name="protocolId" id="protocolId" />
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.protocol')}" />:</td>
	   			<td class="item-content">
	  				<input type="hidden" id="contractId" name="Service.contractId" />
	  				<a href="#" onclick="procotolDetail()" id="protocolDetail"  class="linkCss"  title="<s:property value="%{getText('eaap.op2.conf.server.manager.detail')}" />" ></a>
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item-center" colspan="4"   style="background-color:#EFEFEF"><s:property value="%{getText('eaap.op2.conf.server.manager.serviceChoreography')}" /></td>
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.manager.defaultFlow')}" />:</td>
	   			<td class="item-content" colspan="3" >  									  					
	   				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/messageFlow/showMessageFlow.shtml?pageState=choosePage&objectId=defaultMsgFlow&attrName=defaultMsgFlowName','Select messageFlow',1000,530)" shape="s"></ui:button>
	   				    <a href="#" onclick="openMsgFlow()" id="defaultMsgFlowName"  class="linkCss"  title="<s:property value="%{getText('eaap.op2.conf.server.manager.detail')}" />" ></a>
	   				    <input id="defaultMsgFlow" name="Service.defaultMsgFlow" type="hidden" value=""/>
	   			</td>
	   		</tr>
	   		
	   		<tr style="display:none;">
	  			<td class="item-center" colspan="4" ><s:property value="%{getText('eaap.op2.conf.server.manager.api')}" /></td>
	   		</tr>
	   		<tr style="display:none;">
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.apiMethod')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">
	  					<ui:inputText skin="${contextStyleTheme}" name="Api.apiMethod"  id="apiMethod"  value="" style="width:450px"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr style="display:none;">
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.manager.apiDesc')}" />:</td>
	   			<td class="item-content" colspan="3">
	   				<div class="ui-widget">
	  					<ui:textarea  skin="${contextStyleTheme}" name="Api.apiDesc" id="apiDesc" width="820"></ui:textarea>
	  				</div>  	
	   			</td>
	   		</tr>
	   		
	   		<tr>
	  			<td class="item-center" colspan="4" >
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}" onclick="doSubmit()"></ui:button>
	   		    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDirCancel')}" onclick="history.go(-1);" ></ui:button>
	   		    <input type="hidden" name="msgFlowUrl" id="msgFlowUrl" value="${flowUrl}" />
	  			</td>
	   		</tr>
	   		       
	   		
	    </table>
	    
	    </ui:form>
	  </div>
       
       </div> 
    		
      <%--  <ui:iframe   iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" /> --%>      
      
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
    		 		url:"../serviceManager/showProtocol.shtml",
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
         
         function procotolDetail(){
        	 var protocolId1 = document.getElementById('contractId').value;
        	//haier version
        	//var protocolId1 = document.getElementById('protocolId').value;
        	//var protocolId2 = document.getElementById('protocolId').value;
        	 var contractId = "";
        	 if(protocolId1!=""){
        		 contractId = protocolId1;
        	 }//else if(protocolId2!=""){
        		// contractId = protocolId2;
        	 //}
        	 else{
        		 alert("<s:property value="%{getText('eaap.op2.conf.server.manager.chooseProtocol')}" />");
        		 return;
        	 }
        	 openWindows("${contextPath}/contractManager/gotoEditContract.shtml?pageState=pageState&contractId=" + contractId,"<s:property value="%{getText('eaap.op2.conf.server.manager.protocolDetail')}" />",950,700);
   	  }
         
            function doSubmit(){
            	var ProvideAPIWay = $('input[id=ProvideAPIWay]').val();
            	var UserAuthorization = $('input[id=UserAuthorization]').val();
        //    compareService();
	             if (comm_validators_check('group1')) {
		             if ($('#protocol').val() == "") {
		            	 alert("<s:property value="%{getText('eaap.op2.conf.server.manager.protocolIsNull')}" />");
		            	 return;
		             }
		             if ($('#serviceFlag').val() == "dir") {
		            	 document.serviceAdd.action="${contextPath}/serviceManager/getServiceAddData.shtml?ProvideAPIWay="+ProvideAPIWay+"&UserAuthorization="+UserAuthorization;
		            	 document.serviceAdd.submit();
		             } else {
		            	 document.serviceAdd.action="${contextPath}/serviceManager/getServiceAddDataManager.shtml?ProvideAPIWay="+ProvideAPIWay+"&UserAuthorization="+UserAuthorization;
		            	 document.serviceAdd.submit();
		             }
	             }
            }
            
            function closeWin(){
	  	 	 $('#opendialog').window('close');
	      }
	        function  getChangeData(value){
	               var messageFlowId = value;
	               $('#messageFlowId').val(messageFlowId);
	        }
	        function openMsgFlow(){
				//var messageFlowId =  $('#messageFlowId').val();
				var messageFlowId =  $('#defaultMsgFlow').val();
				if("" != messageFlowId){
					var msgFlowUrl = $('#msgFlowUrl').val()+"?messageFlowId="+messageFlowId;
					window.open(msgFlowUrl,"MessageFlow");
				}else{
					var msgFlowUrl = $('#msgFlowUrl').val();
					window.open(msgFlowUrl,"MessageFlow");
				}
		   }
	       function setMessageFlowInfo(messageFlowNameObj,messageFlowName,messageFlowIdObj,messageFlowId){
	       		$('#'+messageFlowNameObj).text(messageFlowName);
	       		$('#'+messageFlowIdObj).val(messageFlowId);
	       }
		   
	       function showmsgflow(){
                 var messageFlowId =  $('#messageFlowId').val();
 				 window.open($('#msgFlowUrl').val()+"?messageFlowId="+messageFlowId+"&serInvokeInsId=","_bank");
		   }
	       function compareService(){
           var version = document.getElementById("serviceVersion").value;
           var serviceEnName = document.getElementById("serviceCnName").value;
           $.ajax({
           type:"post",
           async:false,
           url:"../serviceManager/compareVersion.shtml?version="+version+"&&serviceEnName="+serviceEnName,
           dataType:"json",
           success:function(msg){
           if(msg="failure"){
           alert("<s:property value="%{getText('eaap.op2.portal.pardProd.serviceEnNameOrVersionUnique')}" />");
           widown.location.reload();
           }
          }
         });
         }
	     function reflashWindow(){
	    	   changeTopScrollHeight();
	       }
	       
	       
         function showContractVersion(){
        	 var contractVersionId = document.getElementById('contractVersionId').value;
        	 if(contractVersionId==""){
        		 return;
        	 }
        	 window.open("${contextPath}/contractManager/addContractManager.shtml?contractVersionId=" + contractVersionId);
   	     }
   </script>   
   <%@ include file="/common/ssoCommon.jsp"%>       
</html>
