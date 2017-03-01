<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Service pricing management</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
</head>
<style>
.formLayout dl{width:420px; display:inline-block;  height:34px;float:left;}
.formLayout dl dt{ display:inline-block;width:150px; text-align:right; float:left;padding-right:3px}
.formLayout dl dd{ display:inline-block;width:260px;}
</style>
<script>

//console.log(document.domain);
var title = [];                              
title[0]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.packageName')}" />';
title[1]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.serviceNames')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.createdTime')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.statusTime')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.status')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.price')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.pricing.manager.price')}" />';
$(document).ready(function() {
	 $('#SelectMenuData').val('A'); 
});
</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png"  align="top"/>
	     	<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionId')}" />
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.techimpl.title')}" />
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.pricing.manager.servicePricingMgt')}" />
	      	
      	</div>
    </div>
    
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.pricing.manager.servicePricingMgt')}" />:
		</div>
    </div>
    
	<div class="formLayout" style="padding:5px 0;">
    <form name="myForm" id="myForm" method="post">
    		<dl>	
    				<dt>
    				    <s:property value="%{getText('eaap.op2.conf.pricing.manager.packageName')}" />
    				</dt>	
    				<dd>
    				   <ui:inputText skin="${contextStyleTheme}"  id="packageName"  name="packageName"  value="${packageName }" />
    				</dd>
    		</dl>
    		<dl>
			<dt>
				<s:property value="%{getText('eaap.op2.conf.manager.auth.orgtype')}" />:
			</dt>
			<dd >
			    <ui:multiSelectBox name="orgTypeCodes" id="filter1" skin="${contextStyleTheme}"
			     list="selectOrgTypeList" listKey="orgTypeCode" listValue="orgTypeName">
				</ui:multiSelectBox>
			</dd>	
		    </dl>
		    <dl style="display:none">
    		<dt><s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />:</dt>
			<dd>
			  <ui:select skin="${contextStyleTheme}" name="state" id="SelectMenuData" list="resultList" width="157"  emptyOption="true" headerValue=" "	 listKey="componentId" listValue="name"  ></ui:select>
	  	    </dd>
	  	    </dl>
    		
    		<dl>	 
				<dt>
					<s:property value="%{getText('eaap.op2.conf.server.supplier.service')}" />:
				</dt>
				<dd style="width:260px;">
				  	<ui:inputText  skin="${contextStyleTheme}" name="serviceName" id="serviceName"  textSize="25"  readonly="true" style="float:left;width:145px"></ui:inputText>
		  		    <input class="inputClearBtn" onclick="javascript:cleardata('serviceId','serviceName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/> 					
		  			<input name="serviceId" id="serviceId" type="hidden" />
		  			<input name="serviceCode" id="serviceCode" type="hidden"  />
		  			<input name="attrName" id="attrName" type="hidden" value="${attrName}"/>
		  			<input name="objectId" id="objectId" type="hidden" value="${objectId}"/>
		  			<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="hidden" value="${endpoint_Spec_Attr_Id}"/>
		  			<input name="chooseSerTechImplId" id="chooseSerTechImplId" type="hidden" value="${serTechImplId}" />
		  			<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />

				 	<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/serviceManager/showMainInfo.shtml?serviceId=serviceId&&serviceName=serviceName&&serviceCode=serviceCode&&pageState=pageState','Select Service')" shape="s"></ui:button>
				</dd>
		   
    		</dl>
    	
    		<div style="text-align:right;float:right;margin-bottom:5px ;">
   	    		<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/> 
				<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
		    </div>
		    <div  style="clear:both;"></div>
</form>
</div>
<div style="clear:both;">	
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="packageList"  remoteSort="false" sortOrder="desc"  
		fit="true" collapsible="true"   title=""  fitHeight="367"  striped="true" pageSize="10" pagination="true" frozenColumns="true"  toolbar="true"  onClickCell="true" 
		rownumbers="true"   method="eaap-op2-conf-pricing-servicePricingAction.getPackageList">
		<ui:gridEasyColumn width="200" index="0" title="0" field="PACKAGENAME"  hidden="false" align="center" formatter="true" formatterMethod="formatter4Code"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="PRODUCTS"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="120" index="2" title="2" field="STATUS_DATE"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="150" index="3" title="3" field="STATUS_DATE"  hidden="false" align="left" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="120" index="4" title="4" field="STATUS_CD"  hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="140" index="5" title="5" field="Status Time"  hidden="false" align="center" formatter="true" formatterMethod="formatterForOp"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="140" index="6" title="6" field="PROD_OFFER_ID"  hidden="true" align="center" ></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
$(document).ready(function(){

});

function searchFunc() {
   var form = $("#myForm").form();
   //console.log(form);
   //console.log($("#packageName").val());
  // console.log($("#SelectMenuData").val());
  // console.log($("#serviceId").val());
      $('#packageList').datagrid("load", sy.serializeObject(form));
 }
 
function formatterForImportFileOrUrl(value,row,index){
   
}

function formatterForRemark(value,row,index){
}

 function downloadAttach(fileAttachId){
 }

function addMehtod(){
       window.location="${contextPath}/pricing/addServicePricing.shtml";
} 
function deleteMethod(){
	var rows = $('#packageList').datagrid('getSelections');
	
    if(rows.length==0){
       $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
       return false; 
       } 
   var value = rows[0].PROD_OFFER_ID;
	  if(confirm("<s:property value="%{getText('eaap.op2.conf.pricing.manager.delMsg')}"/>"));
	  {
		  var urle = "${contextPath}/pricing/delServicePkg.shtml?";
		  
		  $.ajax({
				type: "POST",
				async:true,
				url: urle,
				dataType:'json',
				data:{pkgId:value},
				error: function(){
					 
			    }, 
			    success: function(data){
			    	var form = $("#myForm").form();
			    	$('#packageList').datagrid("load", sy.serializeObject(form));
			    	//console.log(222);
			    	//rows[0].PROD_OFFER_ID.innerHTML ="aaa";
	            }
		    });
	 
	  }
	 
}

function updateMethod(){
	 
	 var rows = $('#packageList').datagrid('getSelections');
	
     if(rows.length==0){
        $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
        return false; 
        } 
    var value = rows[0].PROD_OFFER_ID;
    window.location.href = "${contextPath}/pricing/servicePkgDetail.shtml?offerId="+value+"&ordType=modify";
    }	

function formatterForOp(value,row,index){
	  return "<a onclick=\"clickEvent('"+row.PROD_OFFER_ID+"')\">"+"Detail"+"</a>";
}
function formatter4Code(value,row,index){
	
	  return "<span onclick=\"clickEvent('"+row.PROD_OFFER_ID+"')\">"+value+"</span>";
}

function clickEvent(value){
	 window.location.href = "${contextPath}/pricing/servicePkgDetail.shtml?offerId="+value+"&ordType=detail";
	  
}
function clickMethod(index,field,value){  
	  
	  if("PROD_OFFER_ID"==field){
		  window.location.href = "${contextPath}/pricing/servicePkgDetail.shtml?offerId="+value+"&ordType=detail";
	  }
} 

</script>

</html>