<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
 <script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.manager.auth.serumanager')}"/>
       <img src="../resource/blue/images/module-path.png" />
        <s:property value="%{getText('eaap.op2.conf.manager.auth.seruserreg')}"/>
        <img src="../resource/blue/images/module-path.png" />
        <s:property value="%{getText('eaap.op2.conf.manager.auth.cc2c')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
	        <s:property value="%{getText('eaap.op2.conf.manager.auth.seruserinfo')}"/>
         </div>
    </div>
    
    <div>
        <input type="hidden" name="serInvokeIns.serInvokeInsId"   id="mySerInvokeInsId" value="${serInvokeInsMap.SER_INVOKE_INS_ID}"/>
           <table align="center" class="mgr-table">
    		 <tr>
    		  <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}"/>:</td>
              <td>${serInvokeInsMap.SER_INVOKE_INS_NAME}
              </td>
              <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sercode')}"/>:</td>
              <td>${serInvokeInsMap.SERNAME}
               </td>
            </tr>
            <tr>
              <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</td>
              <td>
               ${serInvokeInsMap.ORGNAME}
              </td>
              <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}"/>:</td>
              <td>
              ${serInvokeInsMap.COMPNAME}
              </td>
            </tr>
             <tr>
                <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
    				<td  colspan="3">
    					${serInvokeInsMap.SER_INVOKE_INS_DESC} 
    				</td>	
    			</tr>
    			<tr>
                    <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}"/>:</td>
    				<td  colspan="3" >
    					${serInvokeInsMap.MFNAME} 
    				</td>	
    		   </tr>
    		 </table>    
    </div>
  
	<div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.manager.auth.cc2c')}"/>
         </div>
     </div>  
     <ui:gridEasy skin="${contextStyleTheme}"  columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" onClickCell="true"   id="cc2clist"  remoteSort="false" sortOrder="desc"    queryParams="true" queryParamsData="${serInvokeInsMap.SER_INVOKE_INS_ID}"
		fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="true"  rownumbers="true"   method="eaap-op2-conf-manager-ConfManagerAction.getCC2CList">
		<ui:gridEasyColumn width="180" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="1" title="1" field="CYCLETYPENAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="280" index="2" title="2" field="VALUENAME" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80"  index="3" title="3" field="STATENAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="4" title="4" field="CONFIG_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="5" title="5" field="LASTEST_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="6" title="6" field="CTL_C_2_COMP_ID" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="7" title="7" field="CYCLE_VALUE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="8" title="8" field="CYCLE_TYPE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="9" title="9" field="CUTMS_VALUE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="10" title="10" field="EFFECT_STATE" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="11" title="11" field="CC_CD" hidden="true"   align="center"></ui:gridEasyColumn>
	  </ui:gridEasy>
	  <ui:form id="myForm" name="myForm" action="insertCC2C.shtml" method="post"> 
	  <table class="mgr-table" id="cc2cinfo"  style="display:none">
	         <input type="hidden" name="reqFrom" value="${reqFrom}"/>
	         <input type="hidden" name="ctlCounterms2Comp.serInvokeInsId"  id="cc2cserInvokeInsId"  value="${serInvokeInsMap.SER_INVOKE_INS_ID}"/>
	         <input type="hidden" name="ctlCounterms2Comp.ctlC2CompId"  id="cc2cctlC2CompId"  value=""/>                                                                    
	         <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
	          <tr>
    		  <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>:</td>
              <td>
                  <ui:select skin="${contextStyleTheme}"  name="ctlCounterms2Comp.ccCd" id="cc2cccCd"  list="ccTypeList" listKey="ccTpyeCode" listValue="ccTpyeName" style="width:100px;" ></ui:select>
              </td>
              <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}"/>:</td>
              <td>
                 <div>
                      <div style="float:left">
	               	       <ui:inputText skin="${contextStyleTheme}"  id="cc2ccycleValue"   name="ctlCounterms2Comp.cycleValue"/>
	                  </div>
	                  <div style="float:left;" >
	             		   <ui:select skin="${contextStyleTheme}"  name="ctlCounterms2Comp.cycleType" id="cc2ccycleType"   list="cycleTyleList" listKey="cycleTypeCode" listValue="cycleTypeName" style="width:70px;" ></ui:select>
	                  </div>
                 </div>
               </td>
            </tr>
            <tr>
              <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  id="cc2ccutmsValue" name="ctlCounterms2Comp.cutmsValue"/> 
              </td>
              
              <td  align="right" width="150" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.state')}"/>:</td>
              <td>
              <ui:select skin="${contextStyleTheme}"  id="cc2ceffectState" name="ctlCounterms2Comp.effectState" list="cc2cStatelist" listKey="stateCode" listValue="stateName" style="width:70px;" ></ui:select> 
              </td>                                                    
            </tr>
                 <tr>
    				<td  colspan="4"  align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" shape="s" id="checksubmitId" onclick="saveControl();"></ui:button>
    				</td>	
    			 </tr>
    		 </table>
    		 <c:if test="${reqFrom!='fromMegFlowMgr'}">
    		  <table class="mgr-table">
    		      <tr> 
    		           <td  colspan="4"  align="center">
    				      <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.next')}" id="checksubmitId" onclick="location='${contextPath}/mgr/showAuthList.shtml?serInvokeIns.serInvokeInsId=${serInvokeInsMap.SER_INVOKE_INS_ID}'"></ui:button>
				    	  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="history.go(-1);"></ui:button>
				    	  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.ignore')}" id="returnid" onclick="location='${contextPath}/mgr/showAuthList.shtml?serInvokeIns.serInvokeInsId=${serInvokeInsMap.SER_INVOKE_INS_ID}'"></ui:button>
					 </td>	
    			 </tr>
    			</table>
    		 </c:if>
    		 
 	</ui:form>   		 
</div>
 <ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" frameborder="10" />
<script>
 function toaddcc2c()
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
 
   if($('#cc2clist').datagrid('getSelections')[0]!=null)
    {
      var cc2cId = $('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID ;
      if(cc2cId!=null&&cc2cId!='')
      {
      
          $("#cc2cctlC2CompId").val(cc2cId);
          $("#cc2cccCd").find('option[value=' + $('#cc2clist').datagrid('getSelections')[0].CC_CD + ']').attr("selected",true);
          var cc2cccCdText = $('#cc2cccCd').find('option:selected').text();
          $('#cc2cccCd[class=tag_select]').text(cc2cccCdText);
		  $("#cc2ccycleValue").val($('#cc2clist').datagrid('getSelections')[0].CYCLE_VALUE);
		  $("#cc2ccycleType").find('option[value=' + $('#cc2clist').datagrid('getSelections')[0].CYCLE_TYPE + ']').attr("selected",true);
          var cc2ccycleTypeText = $('#cc2ccycleType').find('option:selected').text();
          $('#cc2ccycleType[class=tag_select]').text(cc2ccycleTypeText);
		  $("#cc2ccutmsValue").val($('#cc2clist').datagrid('getSelections')[0].CUTMS_VALUE);
		  $("#cc2ceffectState").find('option[value=' + $('#cc2clist').datagrid('getSelections')[0].EFFECT_STATE + ']').attr("selected",true);
          var cc2ceffectStateText = $('#cc2ceffectState').find('option:selected').text();
          $('#cc2ceffectState[class=tag_select]').text(cc2ceffectStateText);
		  $("#editOrAdd").val("edit");
		  $('#cc2cinfo').show();
	  }
      changeTopScrollHeight();
     }
 }   	
  
   function deleteMethod(){ 
		 if($('#cc2clist').datagrid('getSelections')[0]==null||$('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID=="") {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />")){
				   var  cc2cid = $('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID;
				   window.location="${contextPath}/mgr/insertCC2C.shtml?editOrAdd=del&ctlCounterms2Comp.effectState=R&ctlCounterms2Comp.ctlC2CompId="+cc2cid+"&ctlCounterms2Comp.serInvokeInsId="+$('#mySerInvokeInsId').attr('value');
				}
		 }
     }
    		
    function addMehtod(){
 	      $("#cc2cccCd").val("1");
		  $("#cc2ccycleValue").val(null);
		  $("#cc2ccycleType").val("1");
		  $("#cc2ccutmsValue").val(null);
		  $("#cc2ceffectState").val("A");
		  $("#cc2cctlC2CompId").val(null);
		  
		  $("#editOrAdd").val("add");
		  
		  $('#cc2cinfo').show();
		  changeTopScrollHeight();
    } 
              
   function updateMethod(){
	    
	      if($('#cc2clist').datagrid('getSelections')[0]==null||$('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID=="")
	      {
	         alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	      }else{
	          var cc2cId = $('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID ;
	          $("#cc2cctlC2CompId").val(cc2cId);
	          
	          $("#cc2cccCd").find('option[value=' + $('#cc2clist').datagrid('getSelections')[0].CC_CD + ']').attr("selected",true);
	          var cc2cccCdText = $('#cc2cccCd').find('option:selected').text();
	          $('#cc2cccCd[class=tag_select]').text(cc2cccCdText);
	          
			  $("#cc2ccycleValue").val($('#cc2clist').datagrid('getSelections')[0].CYCLE_VALUE);
			  
	          $("#cc2ccycleType").find('option[value=' + $('#cc2clist').datagrid('getSelections')[0].CYCLE_TYPE + ']').attr("selected",true);
	          var cc2ccycleTypeText = $('#cc2ccycleType').find('option:selected').text();
	          $('#cc2ccycleType[class=tag_select]').text(cc2ccycleTypeText);
	          
			  $("#cc2ccutmsValue").val($('#cc2clist').datagrid('getSelections')[0].CUTMS_VALUE);
			  
	          $("#cc2ceffectState").find('option[value=' + $('#cc2clist').datagrid('getSelections')[0].EFFECT_STATE + ']').attr("selected",true);
	          var cc2ceffectStateText = $('#cc2ceffectState').find('option:selected').text();
	          $('#cc2ceffectState[class=tag_select]').text(cc2ceffectStateText);
	          
			  $("#editOrAdd").val("edit");
			  $('#cc2cinfo').show();
			  changeTopScrollHeight();
	  }
   }
   
   function saveControl() {
	   
	   if ($("#cc2ccycleValue").val() == "") {
			alert("\"<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
			$("#cycleValue").focus();
			return false;
		}
		if ($("#cc2ccutmsValue").val() == "") {
			alert("\"<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />\" <s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
			$("#cutmsValue").focus();
			return false;
		}
		
		var ccCdStr = "";
		$.each($('#cc2clist').datagrid('getRows'),function(){
			ccCdStr += this.CC_CD + ",";
		});
		if ($("#editOrAdd").val() == "edit" ) {
			var  cc2cid = $('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID;
			window.location="${contextPath}/mgr/insertCC2C.shtml?editOrAdd=edit&ctlCounterms2Comp.effectState=R&ctlCounterms2Comp.ctlC2CompId="+cc2cid+"&ctlCounterms2Comp.serInvokeInsId="+$('#mySerInvokeInsId').attr('value');
		} else if (ccCdStr.indexOf($("#cc2cccCd").val()) > -1) {
			alert($("#cc2cccCd option[value=" + $("#cc2cccCd").val() + "]").text() + " <s:property value="%{getText('eaap.op2.conf.server.manager.isExist')}" />");
			return false;
		}
		myForm.submit();
   }
 	  
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
