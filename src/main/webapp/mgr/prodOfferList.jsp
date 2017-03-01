<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.prodOffer.selfProdcut')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
 
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.prodOffer.prodOfferName')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.prodOffer.extProdOfferId')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.prodOffer.effDate')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.prodOffer.expDate')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.prodOffer.status')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.prodOffer.statusDate')}" />';
</script>



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
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.prodOffer.queryArea')}"/>
         </div>
         
    </div>
    
    <div>
    <ui:form name="myForm" id="myForm" method="post"> 
  			<table class="mgr-table">
  			
					<tr>
    				<td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.prodOffer.prodOfferName')}"/>:
    				</td>	
    				<td>
    				<input type="hidden" name="prodOfferStatusMap" id="prodOfferStatusMap" value="${prodOfferStatusMap}" />
    			    <ui:inputText skin="${contextStyleTheme}"  name="prodOffer.prodOfferName" id="prodOfferNameId" value="%{getText('eaap.op2.conf.manager.auth.canlike')}"  />
    			  
    				</td>	
    				<td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.prodOffer.extProdOfferId')}"/>:
    				</td>
    				<td><ui:inputText skin="${contextStyleTheme}"  id="extProdOfferId"   name="prodOffer.extProdOfferId" value="${prodOffer.extProdOfferId}"/>
    				</td>
    				
    				<td  align="right" width="150"><s:property value="%{getText('eaap.op2.conf.prodOffer.status')}"/>:
    				</td>
    				<td>
    				
    				 <ui:select skin="${contextStyleTheme}"  name="prodOffer.status" id="statusId"   emptyOption="true" headerValue=""
    			      list="prodOfferStatusList" listKey="key" listValue="value"></ui:select>
    			     </td>
    			     
    			    </tr>
    			    
    			
    		    <tr>
    				<td colspan="6" style="TEXT-ALIGN: right;">
    				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.prodOffer.queryBtn')}"   id="search" onclick="searchFunc();"/>
    					 
    				</td>	
    			</tr>
    		</table>

    		<br/>
    		
    		     
			 </ui:form>
  </div>
 
<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="prodOfferListId"  remoteSort="false" sortOrder="desc"  
fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="true" rownumbers="true"   method="eaap-op2-conf-prodOffer-ProdOfferAction.getProdOfferList">
<ui:gridEasyColumn width="180" index="0" title="0" field="PROD_OFFER_NAME" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="120" index="1" title="1" field="EXT_PROD_OFFER_ID" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="120" index="2" title="2" field="EFF_DATE" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="120" index="3" title="3" field="EXP_DATE" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="120" index="4" title="4" field="STATUS_CD" hidden="false" formatter="true" formatterMethod="formatterForState" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="120" index="5" title="5" field="STATUS_DATE" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="120" index="6" title="6" field="PROD_OFFER_ID" hidden="true" align="center"></ui:gridEasyColumn>
</ui:gridEasy>

<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
        
function searchFunc() {
   var form = $("#myForm").form();
      $('#prodOfferListId').datagrid("load", sy.serializeObject(form));
 }	
    
 function formatterForState(value,row,index){
     var comm_map_arr ; 
     comm_map_arr=$("#prodOfferStatusMap").val();
     comm_map_arr =  comm_map_arr.substring(1,comm_map_arr.length-1).split(',');
     for (var i = 0; i < comm_map_arr.length; i++) {
     if (comm_map_arr[i].split('=')[0].trim() == value ) {    
       return comm_map_arr[i].split('=')[1];    
      }    
     }    
       return value ;
 }
    		  
 
function closeWin(){
 $('#opendialog').window('close');
 }
 
 
 
  function deleteMethod(){ 					
	    if($('#prodOfferListId').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.prodOffer.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.prodOffer.suredelete')}" />"))
				{
					var tmpprodOfferid = $('#prodOfferListId').datagrid('getSelections')[0].PROD_OFFER_ID ;
					$("#prodofferid").val(tmpprodOfferid) ;
					$("#statuscd").val('1300') ;
					window.location='${contextPath}/prodOffer/updateProdOfferStatus.shtml?prodOffer.statusCd=1300&prodOffer.prodOfferId='+tmpprodOfferid;
				}
		 }
     }
    		
    function addMehtod(){
       window.location="${contextPath}/prodOffer/addProdOfferInfo.shtml";
 	 } 
              
   function updateMethod(){
        if($('#prodOfferListId').datagrid('getSelections')[0]==null)
		 {
		 alert("<s:property value="%{getText('eaap.op2.conf.prodOffer.pleasechoose')}" />");
		 }else{
		    var tmpprodOfferid = $('#prodOfferListId').datagrid('getSelections')[0].PROD_OFFER_ID ;
			    $("#prodofferid").val(tmpprodOfferid) ;
				window.location='${contextPath}/prodOffer/queryProdOfferInfo.shtml?prodOffer.prodOfferId='+tmpprodOfferid;
		 }
   }
   
 
</script>
<script language="JavaScript" type="text/javascript">
var myinput = document.getElementById("prodOfferNameId");
if("<s:property value="%{getText('eaap.op2.conf.manager.auth.canlike')}"/>"==myinput.value){
	myinput.style.color="#DCDCDC";
}
function addListener(element,e,fn){
	if(element.addEventListener){
		element.addEventListener(e,fn,false);    
	} else {    
		element.attachEvent("on" + e,fn);    
	}    
}
addListener(myinput,"click",function(){
	if("<s:property value="%{getText('eaap.op2.conf.manager.auth.canlike')}"/>"==myinput.value){
		myinput.value = "";
		myinput.style.color="";
	}
})
addListener(myinput,"blur",function(){
	if(""==myinput.value){
		myinput.value = "<s:property value="%{getText('eaap.op2.conf.manager.auth.canlike')}"/>";
		myinput.style.color="#DCDCDC";
	}
})
</script>

<%@ include file="/common/ssoCommon.jsp"%> 
</html>
