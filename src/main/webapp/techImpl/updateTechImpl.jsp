<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    
    <title>updateTechImplInfo.jsp</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	 <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
        <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	     <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle1')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.cfgUpdate')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <ui:form id="updateTechImpl" action="../techimpl/updateTechImplData.shtml" method="post" name="updateTechImpl" >
	   <ui:validators validateAlert="word" validatorGroup="group1">
       	 	<ui:validator fieldId="componentName" validatorType="requiredstring" required="true"  message="%{getText('eaap.op2.conf.techimpl.tip.component')}"/>	
       	 	<ui:validator fieldId="techImplName" validatorType="requiredstring" required="true"   message="%{getText('eaap.op2.conf.techimpl.tip.TechnologyImpl')}"/>
       	 	
		 </ui:validators>
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
               <s:property value="%{getText('eaap.op2.conf.techimpl.cfgUpdate')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
			    <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<input id="componentId" name="TechImpl.componentId" type="hidden" value="${TechImpl.componentId}" />
	  					<ui:inputText skin="${contextStyleTheme}" name="Component.name" id="componentName"  textSize="25" type="text" value="${ComponentName}"></ui:inputText>
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=componentName&chooseCompCode=componentId&chooseOrgName=orgName&chooseOrgId=orgId','Choose Component')" shape="s"></ui:button>	  					
	  				</div> 	
	   			</td>	 
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="Org.name" id="orgName" readonly="true" textSize="25" type="text" value="${orgName}"></ui:inputText>
	  					<input name="Org.orgId" id="orgId" type="hidden" value="${Org.orgId}" />
	  					<!--  
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&chooseOrgCode=orgId','Choose Org')" shape="s"></ui:button>
	  					-->
	  				</div>
 		        </div>
	   			</td>
	   			
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplName" id="techImplName"  textSize="25" type="text" value="${techImplName}"></ui:inputText>
	  					<ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplId" id="techImplId" type="hidden"  textSize="25" value="${TechImpl.techImplId}"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:select skin="${contextStyleTheme}" name="CommProtocal.commProCd" id="commProCd" value="${CommProtocal.commProCd}" list="commProtocalResultList" width="172"  listKey="commProtocalId" listValue="commProtocalName" onchange="getTechAttrSpec(this.value);"></ui:select>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<%--  
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.callUrl')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  			    <ui:inputText name="callUrl" id="callUrl"  textSize="25" type="text" value="${callUrl}"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.overtime')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  			        <ui:inputText name="overtime" id="overtime"  textSize="25" type="text" value="${overtime}"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText name="webserviceMethodName" id="webserviceMethodName"  textSize="25" type="text" value="${webserviceMethodName}"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamNameSpace')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  			    <ui:inputText name="webserviceParamNameSpace" id="webserviceParamNameSpace"  textSize="25" type="text" value="${webserviceParamNameSpace}" ></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   	    <tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamName')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText name="webserviceParamName" id="webserviceParamName"  textSize="25" type="text" value="${webserviceParamName}"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceReturnParamName')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  			    <ui:inputText name="webserviceReturnParamName" id="webserviceReturnParamName"  textSize="25" type="text" value="${webserviceReturnParamName}"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		--%>
	   		<%-- 
          <c:if test="${fn:length(tmpList)>=1}">
	   		<c:forEach var="tmpListVar" items="${tmpList}" step="1">
	   		<tr>
	   		     <td class="item">
	   		     ${tmpListVar.ATTR_SPEC_NAME}
	   		     </td>
	   		     <td class="item-content">
	   		     <div class="ui-widget">
	   		     <ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.ATTR_SPEC_CODE}" name="${tmpListVar.ATTR_SPEC_CODE}" value="${tmpListVar.ATTR_SPEC_VALUE}" textSize="25"/>
	   		     </div> 
	   		     </td>
			</tr>
			</c:forEach>       
	   		</c:if>
	   		 --%>
   		   <c:if test="${fn:length(tmpList)>=1}">
   		   <tr>
	   		<c:forEach var="tmpListVar" items="${tmpList}" step="1" varStatus="vstatus">
	   		     <td class="item">
	   		     ${tmpListVar.ATTR_SPEC_NAME}
	   		     </td>
	   		     <td class="item-content">
	   		     <div class="ui-widget">
	   		     	<input name="attrKey"  type="hidden"  value="${tmpListVar.ATTR_SPEC_CODE}" />
					<c:if test="${tmpListVar.ATTR_SPEC_ID!=83 && tmpListVar.ATTR_SPEC_ID!=11 && tmpListVar.ATTR_SPEC_ID!=15 && tmpListVar.ATTR_SPEC_ID !=213 && tmpListVar.ATTR_SPEC_ID !=215}">
						<ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue" value="${tmpListVar.ATTR_SPEC_VALUE}" textSize="25" />
						
						<c:if test="${tmpListVar.ATTR_SPEC_ID==1}">
				   		  	<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.techRoute')}" onclick="openWindows('/conf/techimpl/gotoTechRoute.shtml?techImplId=${TechImpl.techImplId}','AddTechRoute')"></ui:button>
				   	</c:if> 
					</c:if>	
				   		     	
	   		     	<c:if test="${tmpListVar.ATTR_SPEC_ID==11 || tmpListVar.ATTR_SPEC_ID==15|| tmpListVar.ATTR_SPEC_ID==215|| tmpListVar.ATTR_SPEC_ID==213}">
	   		     		<input id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue"  type="hidden"  value="${tmpListVar.ATTR_SPEC_VALUE}" />
	   		   		  	<input forid="${tmpListVar.ATTR_SPEC_CODE}"  value="<c:if test="${tmpListVar.ATTR_SPEC_VALUE !=null}">******</c:if>"  type="password"  onclick="this.value=''" onblur="encryptionPassword(event)" onkeyup="trimPsd(event)" textSize="25"  style="width:169px; height:22px; border:1px solid #ccc;"/>
	   		     	</c:if>	
				   		     	
					<c:if test="${tmpListVar.ATTR_SPEC_ID==83}">
						<ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue" value="${tmpListVar.ATTR_SPEC_VALUE}" textSize="25" type="file" style="width:172px;"/>
					</c:if>	
	   		     </div> 
	   		     </td>
	   		     <c:if test="${vstatus.index%2==1}">
	   		     </tr>
	   		     <tr>
	   		     </c:if>
   		     </c:forEach>    
			</tr>
			   
	   		</c:if>
	    </table>
	    </ui:form>
	  </div>
	   
	 	 <script type="text/javascript">
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
         </script>
<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true" height="200" id="table" fitHeight="200" remoteSort="false" sortOrder="desc" queryParams="true" queryParamsData="${TechImpl.techImplId}"
fit="false" collapsible="false"   title="%{getText('eaap.op2.conf.server.supplier.controlStrategy')}" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true" toolbar="true" method="eaap-op2-conf-server-ServerManagerAction.getCC2CList">
		<ui:gridEasyColumn width="60" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="40" index="1" title="1" field="CYCLETYPENAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="40" index="2" title="2" field="VALUENAME" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="40"  index="3" title="3" field="STATENAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="40" index="4" title="4" field="CONFI_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="5" title="5" field="LASTEST_TIME" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="6" title="6" field="TECH_IMPL_ID" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="7" title="7" field="CYCLE_VALUE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="8" title="8" field="CYCLE_TYPE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="9" title="9" field="CUTMS_VALUE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="10" title="10" field="EFFECT_STATE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="11" title="11" field="CC_CD" hidden="true"   align="center"></ui:gridEasyColumn>	
</ui:gridEasy>
      
	
      
	 <ui:form id="myForm"  method="post" name="myForm">
	  <table class="mgr-table" id="cc2cinfo"  style="display:none">
	  			
	          <tr>
	          
    		  <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>:</td>
              <td>
                  <ui:select skin="${contextStyleTheme}" name="CtlCounterms2Tech.ccCd" id="ccCd"  list="ccTypeList" listKey="ccTpyeCode" listValue="ccTpyeName" width="147" layerHeight="80"></ui:select>   
                  	<ui:inputText skin="${contextStyleTheme}" name="chooseTechImplId" id="chooseTechImplId" type="hidden"  textSize="25" value="${TechImpl.techImplId}"></ui:inputText>   				 
              </td>
              
              
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}"/>:</td>
              <td>
               		<table style="padding:0;margin:0; border-width:0;">
	               		<tr>
		               		<td style="padding:0;margin:0; border-width:0;"><ui:inputText skin="${contextStyleTheme}" id="cycleValue" textSize="30"   name="ctlCounterms2Tech.cycleValue"  style="width:80px;"/></td>
		               		<td style="padding:0;margin:0; border-width:0;"><ui:select skin="${contextStyleTheme}" id="cycleType"   name="ctlCounterms2Tech.cycleType"   list="cycleTyleList" listKey="cycleTypeCode" listValue="cycleTypeName" width="80px" layerWidth="85px" layerHeight="100px" style="float:left;"></ui:select></td>
	               		</tr>
               		</table>
               </td>
             
            </tr>
             
            <tr>
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}" id="cutmsValue" name="CtlCounterms2Tech.cutmsValue"/> 
              </td>           
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.state')}"/>:</td>
              <td>
              		<ui:select skin="${contextStyleTheme}" id="effectState" name="ctlCounterms2Tech.effectState" list="cc2cStatelist" listKey="stateCode" listValue="stateName" width="100px" layerWidth="105px" layerHeight="50px" ></ui:select> 
              </td>                                                    
            </tr>       		
            <tr>
    		   <td  colspan="4"  align="center">
    			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" id="checksubmitId" onclick="xx();"></ui:button>
			   </td>	
    		  </tr>
    		 </table>
 	</ui:form>   
 		   <div align="center">
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="if(comm_validators_check('group1')){document.updateTechImpl.submit();}"></ui:button>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" onclick="history.go(-1);"></ui:button>
	  		</div> 
</div>
 <ui:iframe  skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
 </body>
 <%@ include file="/common/ssoCommon.jsp"%>
 <script>
$(function(){
	$('#btncut').remove();
});

 function addMehtod(index,field,value)
 {
  
  $("#cc2cccCd").val(null);
  $("#cc2ccycleValue").val(null);
  $("#cc2ccycleType").val(null);
  $("#cc2ccutmsValue").val(null);
  $("#cc2ceffectState").val(null);
  $("#cc2cctlC2CompId").val(null);
  
  $("#editOrAdd").val("add");
  
  $('#cc2cinfo').show();
  changeTopScrollHeight();
 }
 
 
 
 function clickMethod(index,field,value)
 {
 
     if(field=='NAME')
     {
      var cc2cId = $('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID ;
      if(cc2cId!=null&&cc2cId!='')
      {
      
          $("#cc2cctlC2CompId").val(cc2cId);
		  $("#cc2cccCd").val($('#cc2clist').datagrid('getSelections')[0].CC_CD);
		  $("#cc2ccycleValue").val($('#cc2clist').datagrid('getSelections')[0].CYCLE_VALUE);
		  $("#cc2ccycleType").val($('#cc2clist').datagrid('getSelections')[0].CYCLE_TYPE);
		  $("#cc2ccutmsValue").val($('#cc2clist').datagrid('getSelections')[0].CUTMS_VALUE);
		  $("#cc2ceffectState").val($('#cc2clist').datagrid('getSelections')[0].EFFECT_STATE);
		  $("#editOrAdd").val("edit");
		  $('#cc2cinfo').show();
	  }
     } 
 }   
 
     	  function closeWin(){
          $('#opendialog').window('close');
          }
          
function xx(){
	if ($("#cycleValue").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		$("#cycleValue").focus();
		return false;
	}
	if ($("#cutmsValue").val() == "") {
		alert("\"<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
		$("#cutmsValue").focus();
		return false;
	}
	
	var ccCdStr = "";
	$.each($('#table').datagrid('getRows'),function(){
		ccCdStr += this.CC_CD + ",";
	});
	
	if (ccCdStr.indexOf($("#ccCd").val()) > -1) {
		alert($("#ccCd option[value=" + $("#ccCd").val() + "]").text() + " <s:property value="%{getText('eaap.op2.conf.server.manager.isExist')}" />");
		return false;
	}
	
    var ajax_data = $("#myForm").serialize();
    	 $.ajax({
          type:"post",
          async:false,
          url:"../techimpl/addServiceSupRegTechCtlUpdate.shtml",
          dataType:"json",
          data:ajax_data,
          success:function(msg,data){
          var chooseTechImplId = msg[0].data;
          $("#chooseTechImplId").val(chooseTechImplId);
          if(msg=="failure"){
          alert("<s:property value="%{getText('eaap.op2.portal.pardProd.prodOfferunique')}" />");
          }
          $('#table').datagrid('reload');
          $('#cc2cinfo').hide();
        }
        });
}
 
 function deleteMethod(index,field,value)
 {
  var rows = $('#table').datagrid('getSelections');
  if(rows.length==0){
     $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
	return false; 
  }
  var cc_cd = $('#table').datagrid('getSelections')[0].CC_CD ;
  var techImplId = $('#table').datagrid('getSelections')[0].TECH_IMPL_ID ;
  if(cc_cd==""||techImplId==""){
    $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
	return false; 
  }else{
  $.ajax({
          type:"post",
          async:false,
          url:"../techimpl/delServiceSupRegTechCtlUpdate.shtml",
          dataType:"json",
          data:{cc_cd:cc_cd,techImplId:techImplId},
          success:function(msg,data){
          if(msg=="failure"){
          alert("<s:property value="%{getText('eaap.op2.portal.pardProd.prodOfferunique')}" />");
          }
          $('#table').datagrid('reload');
        }
        });
  }
       

 }
       function getTechAttrSpec(value){
       var techImplId= $("#techImplId").val();
       var componentId= $("#componentId").val();
       var componentName= $("#componentName").val();
       var orgId= $("#orgId").val();
       var orgName= $("#orgName").val();
       var code= $("#code").val();
       var techImplName= $("#techImplName").val();
       window.location.href="../techimpl/getUpdateTechAttrSpec.shtml?TechImpl.componentId="+componentId+"&&TechImpl.techImplId="+techImplId+"&&Org.orgId="+orgId+"&&orgName="+orgName+"&&Component.code="+code+"&&ComponentName="+componentName+"&&techImplName="+techImplName+"&&CommProtocal.commProCd="+value
      }     
      
      
      
function trimPsd(event){
	var eObj = event.srcElement?event.srcElement:event.target;
	eObj.value =jQuery.trim(eObj.value);
}
	
function encryptionPassword(event){
	var eObj = event.srcElement?event.srcElement:event.target;
	var forid = eObj.attributes["forid"];
	
	if(forid != undefined){
		var passwordObj = eObj.attributes["forid"].value;
		if(eObj.value==""){
			$("#"+passwordObj).val("");
		}else{
			//加密：
			
			
			
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../techimpl/encryptionPassword.shtml",
			     dataType:"json",
			     data:{PlaintextPassword : eObj.value},				//传入明文
			     success:function(msg,data){
						try{
							
					 		var isjson = typeof(msg)=="object" && Object.prototype.toString.call(msg).toLowerCase() == "[object object]" && !msg.length; 
							if(isjson){
					      		var resultCode = msg.ResultCode;
					      		var CiphertextPassword = msg.CiphertextPassword;		//返回密文
					      		
					      		if(resultCode=="Success"){
									$("#"+passwordObj).val(CiphertextPassword);
					      		}
							}
						}catch(e){
						}
		   	  	}
			});	
		}
	}
}
</script>
</html>