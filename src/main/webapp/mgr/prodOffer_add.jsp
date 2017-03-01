<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title><s:property value="%{getText('eaap.op2.conf.prodOffer.addSelfProdOffer')}"/></title>
<link href="../resource/blue/css/easyui-comen.css" rel="stylesheet" type="text/css" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>

<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>	
<link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/>
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.prodOffer.partnerSys')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.prodOffer.manager')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.prodOffer.selfProdcut')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.prodOffer.addProdOffer')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.prodOffer.addProdOffer')}"/>
         </div>
         
    </div>
    
    <div>
    <form  name="addProdOfferForm" id="addProdOfferForm" action="insertProdOfferInfo.shtml" method="post"> 
   
          <table class="mgr-table">
            
	            <tr>
	              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prodOffer.prodOfferName')}"/>:</td>
	              <td>
	                 <ui:inputText skin="${contextStyleTheme}"   name="prodOffer.prodOfferName" id="prodOfferName" />  
	              </td>
	               
	              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prodOffer.extProdOfferId')}"/>:</td>
	              <td>
	                 <ui:inputText skin="${contextStyleTheme}"  name="prodOffer.extProdOfferId" id="extProdOfferId"  ></ui:inputText>
	              </td>
	            </tr>
	            
	            
	            <tr>
	              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prodOffer.effDate')}"/>:</td>
	              <td>
	              	<input id="effDate" name="prodOffer.effDate" style="width:83px; height:30px; border:1px solid #ccc; cursor:pointer;"/> 
	                
	              </td>
	          
	              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prodOffer.expDate')}"/>:</td>
	              <td>
	              	<input id="expDate" name="prodOffer.expDate" style="width:83px; height:30px; border:1px solid #ccc; cursor:pointer;"/> 
	                
	              </td>
	            </tr>
            
	             <tr>
	             	<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
		  			<td class="item-content"> 
			  		    <div class="ui-widget"> 
			  				<div class="ui-widget">	  					  					
			  					<ui:inputText skin="${contextStyleTheme}" name="Org.name" id="orgName"  textSize="25"></ui:inputText>
			  					<input name="Org.orgId" id="orgId" type="hidden" value="" />
			  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&chooseOrgCode=orgId','Choose Component')" shape="s"></ui:button>
			  				</div>
		 		        </div>
		   			</td>
	              <td class="item"><s:property value="%{getText('eaap.op2.conf.prodOffer.prodOfferDesc')}"/>:</td>
	              <td colspan="3"> 
	               <ui:textarea skin="${contextStyleTheme}"   name="prodOffer.prodOfferDesc" id="prodOfferDesc"  width="800" height="200"/> 
	              </td>
	             </tr>
            
    		     
    		     <tr>
    			   <td  colspan="4" class="item-content" align="center">
    			   	<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.prodOffer.addBtn')}"  onclick="addProdOfferForm.submit();"  id="submitId"></ui:button>
    			    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.prodOffer.returnBtn')}" id="cancelId" onclick="history.go(-1);"></ui:button>
    			   </td>	
    			</tr>
    		 </table>
    	</form>
    		
    </div>
</div>
 <ui:iframe  skin="${contextStyleTheme}"  iframeWidth="480" iframeHeight="235" divId="opendialog" divTitle="upload image" iframeId="iframe_map" iframeSrc="" iframeScrolling="no" frameborder="10" />
 <ui:warn skin="${contextStyleTheme}"/>
<!--body end --> 

</body>
<script> 
function closeWin(){
 $('#opendialog').window('close');
 }
</script>
<script>
	$(document).ready(function(){
	  $('#effDate').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i'
		});
		$('#expDate').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i'
		});
	});
</script> 
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
