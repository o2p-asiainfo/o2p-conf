<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	     <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.serverManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.register')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.supplierAdd')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <ui:form id="addServiceSupReg" action="../serviceManager/addServiceSupReg.shtml" method="post">
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
               <s:property value="%{getText('eaap.op2.conf.server.supplier.supplierInfor')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.service')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					${Service.serviceCnName}
	  					<input name="Service.serviceId" id="serviceId" type="hidden" value="${Service.serviceId}" />
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  
	  				   ${Org.name} 					  					
	  					<input id="orgId" name="Org.orgId" type="hidden" value="${Org.orgId}" />
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	
	  				    ${Component.name}     					  					
	  					<input id="code" name="Component.code" type="hidden" value="${Component.code} "/>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	   				${TechImpl.techImplName}
	  				<input id="techImpId" name="TechImpl.techImplId" type="hidden" value="${TechImpl.techImplId}" />
	  				</div>  	
	   			</td>
	   		</tr>
	    </table>
	    </ui:form>
	  </div>
 
	   <div align="center" style="margin-top:5px;">
	   		<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="history.go(-1);"></ui:button>
 			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="javascript:document.addServiceSupReg.submit();"></ui:button>
 			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}" onclick="goServiceSupplierIndex();"></ui:button>
 		</div> 
</div>
 <ui:iframe  skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
 </body>
<script>
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
     function goServiceSupplierIndex(){
	    window.location.href="../serviceManager/ServiceSupRegister.shtml";
	}	  
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>

