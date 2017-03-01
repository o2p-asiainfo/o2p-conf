<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title>addTechImplInfoToNext.jsp</title>
     <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
        <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
        <script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	    <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle2')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <ui:form id="addTechImpl" action="../techimpl/addTechImpl.shtml" method="post" enctype="multipart/form-data">
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
               <s:property value="%{getText('eaap.op2.conf.server.supplier.supplierInfor')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  
	  				${Org.name}					  					
	  					<input name="Org.name" id="orgName" type="hidden" value="${Org.name}" />
	  					<input name="Org.orgId" id="orgId" type="hidden" value="${Org.orgId}" />
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	 
	  				${Component.name} 					  					
	  					<input id="ComponentName" name="Component.name" type="hidden" value="${Component.name}" />
	  					<input id="componentId" name="TechImpl.componentId" type="hidden" value="${TechImpl.componentId}" />	  					
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	 
	  				${TechImpl.techImplName}  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplName" id="techImplName" type="hidden"  value="${TechImpl.techImplName}" textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	   				    ${CommProtocal.commProCd}
                    <ui:inputText skin="${contextStyleTheme}" name="CommProtocal.commProCd" id="commProCd" type="hidden"  value="${CommProtocal.commProCd}" textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<!-- 动态属性 -->
	   		<tr>
	   			<c:if test="${fn:length(tmpList)>=1}">
		   			<c:forEach var="tmpListVar" items="${tmpList}" step="1" varStatus="vs">
		   				 <td class="item">
				   		     ${tmpListVar.ATTR_SPEC_NAME}
			   		     </td>
			   		     <td class="item-content">
				   		     <div class="ui-widget">
								<c:if test="${tmpListVar.ATTR_SPEC_ID!=11 && tmpListVar.ATTR_SPEC_ID!=15}">
				   		     			<input id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue"  type="hidden"  value="${attrValue[vs.index]}" />
				   		     			${attrValue[vs.index]}	
				   		     			
				   		     			<c:if test="${tmpListVar.ATTR_SPEC_ID==1}">
				   		  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.techRoute')}" onclick="openWindows('/conf/techimpl/gotoTechRoute.shtml?techImplId=${techImplId}','AddTechRoute')"></ui:button>
				   		  				</c:if>   			
								</c:if>	
				   		     	<c:if test="${tmpListVar.ATTR_SPEC_ID==11 || tmpListVar.ATTR_SPEC_ID==15}">
				   		     		<input id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue"  type="hidden"  value="${attrValue[vs.index]}" />
				   		   		  	******
				   		     	</c:if>	
				   		     </div> 
			   		     </td>
			   		     <c:if test="${vs.index%2==1}">
			   		     </tr><tr>
			   		     </c:if>
		   			</c:forEach>
	   			</c:if>
	   		</tr>
	   		<%-- 
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.callUrl')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	 
	  				${address}  					  					
	  			      <ui:inputText skin="${contextStyleTheme}" name="callUrl" id="callUrl"  type="hidden" value="${address}" textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.overtime')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	   				${timeout} 
	  			        <ui:inputText skin="${contextStyleTheme}" name="overtime" id="overtime"  type="hidden" value="${timeout}" textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   			   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	
	  				${method}   					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="webserviceMethodName" id="webserviceMethodName" value="${method}" type="hidden" textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamNameSpace')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	   				${inparamnamespace} 
	  			    <ui:inputText skin="${contextStyleTheme}" name="webserviceParamNameSpace" id="webserviceParamNameSpace" type="hidden" value="${inparamnamespace}" textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamName')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  	
	  				${inparamname} 				  					
	  			    <ui:inputText skin="${contextStyleTheme}" name="webserviceParamName" id="webserviceParamName" type="hidden" value="${inparamname}" textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceReturnParamName')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	   				${returnparam} 
	  			    <ui:inputText skin="${contextStyleTheme}" name="webserviceReturnParamName" id="webserviceReturnParamName" type="hidden" value="${returnparam}" textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.namespace')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  	
	  				${namespace} 				  					
	  			    <ui:inputText skin="${contextStyleTheme}" name="namespace" id="namespace" type="hidden" value="${namespace}" textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"></td>
	   			<td class="item-content">
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item-center" colspan="4" >
	  			<input id="techImplId" name="TechImpl.techImplId"  type="hidden"/>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="history.go(-1);"></ui:button>
	  			</td>
	   		</tr>
	   		       
			    <ui:inputText skin="${contextStyleTheme}" name="sftpUsername" id="sftpUsername" type="hidden" value="${sftpUsername}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="sftpPassword" id="sftpPassword" type="hidden" value="${sftpPassword}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="sftpServerIp" id="sftpServerIp" type="hidden" value="${sftpServerIp}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="sftpPort" id="sftpPort" type="hidden" value="${sftpPort}" textSize="25"></ui:inputText>
			  
			    <ui:inputText skin="${contextStyleTheme}" name="ftpUsername" id="ftpUsername" type="hidden" value="${ftpUsername}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="ftpPassword" id="ftpPassword" type="hidden" value="${ftpPassword}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="ftpServerIp" id="ftpServerIp" type="hidden" value="${ftpServerIp}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="ftpPort" id="ftpPort" type="hidden" value="${ftpPort}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="AUTH_FILE_PATHFileName" id="fileFileName" type="hidden" value="${AUTH_FILE_PATHFileName}" textSize="25"></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="fileFilePath" id="fileFilePath" type="hidden" value="${fileFilePath}" textSize="25"></ui:inputText>
	   		--%>
	   		<tr>
	  			<td class="item-center" colspan="4" >
	  			<input id="techImplId" name="TechImpl.techImplId"  value="${techImplId}" type="hidden"/>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="history.go(-1);"></ui:button>
	  			</td>
	   		</tr>
	    </table>
	    </ui:form>

 

       
	 
	 	 <script type="text/javascript">
        var title = [];
          title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>';
          title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />';
          title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />';
          title[3]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
          title[4]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
          title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
         </script>
<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true" fitHeight="200"  id="table" remoteSort="false" sortOrder="desc" 
fit="true" collapsible="false"   title="%{getText('eaap.op2.conf.server.supplier.controlStrategy')}" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true" toolbar="true" method="eaap-op2-conf-techimpl-TechImplAction.getCC2CList">
		<ui:gridEasyColumn width="80" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="1" title="1" field="CYCLETYPENAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="2" title="2" field="VALUENAME" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80"  index="3" title="3" field="STATENAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="4" title="4" field="CONFI_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
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
                   <ui:inputText skin="${contextStyleTheme}" id="techImplIdSeq" type="hidden"   value="${techImplId}" name="techImplIdSeq"/>  				 
              </td>
              
              
              <td class="tar"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}"/>:</td>
              <td>
                    <table style="padding:0;margin:0; border-width:0;">
	               		<tr>
		               		<td style="padding:0;margin:0; border-width:0;"><ui:inputText skin="${contextStyleTheme}" id="cycleValue" textSize="15"   name="CtlCounterms2Tech.cycleValue"/></td>
		               		<td style="padding:0;margin:0; border-width:0;"><ui:select skin="${contextStyleTheme}" name="CtlCounterms2Tech.cycleType" id="cycleType"   list="cycleTyleList" listKey="cycleTypeCode" listValue="cycleTypeName" width="80px" layerWidth="80px" layerHeight="100px"></ui:select></td>
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
              <ui:select skin="${contextStyleTheme}" id="effectState" name="CtlCounterms2Tech.effectState" list="cc2cStatelist" listKey="stateCode" listValue="stateName" width="80px" layerWidth="80px" layerHeight="50px" ></ui:select> 
              </td>                                                    
            </tr>       		
            <tr>
    		   <td  colspan="4"  align="center">
    			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" id="checksubmitId" onclick="javascript:xx();"></ui:button>
			   </td>	
    		  </tr>
    		 </table>
 	</ui:form>   
 		   <div align="center">
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="goTechImplIndex();"></ui:button>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" onclick="goTechImplIndex();"></ui:button>
	  		</div> 
</div>
	  </div>
 <ui:iframe  skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog"   divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
 </body>

<script>
$(function(){
	$('#btncut').remove();
});
var techImplId ="";
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
          url:"../techimpl/addServiceSupRegTechCtl.shtml",
          dataType:"json",
          data:ajax_data,
          success:function(msg,data){
          techImplId = msg[0].data;
          $("#techImplIdSeq").val(techImplId);
          $("#techImplId").val(techImplId);
          if(msg=="failure"){
          alert("<s:property value="%{getText('eaap.op2.portal.pardProd.prodOfferunique')}" />");
          }
          $('#table').datagrid('load', {  
           techImplId: techImplId  
          });
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
       
	  function goTechImplIndex(){
	  window.location.href="../techimpl/showTechImplIndex.shtml";
	  }
</script>
 <%@ include file="/common/ssoCommon.jsp"%> 
</html>

