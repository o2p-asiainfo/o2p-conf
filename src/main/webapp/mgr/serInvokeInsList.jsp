<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.compregauditing.SysName')}"/></title>
<link href="../resource/blue/css/easyui-comen.css" rel="stylesheet" type="text/css" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
</head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.sercode')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.sername')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compCode')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
title[7]='<s:property value="%{getText('eaap.op2.conf.manager.auth.createtime')}" />';
title[8]='<s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}" />';

$(document).ready(function() {
	 $('#seriiState').val('A'); 
});
</script>
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
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.compregauditing.queryCondition')}"/>
         </div>
    </div>
    
	<div id="queryBlock"> 
	<div class="formLayout" style="padding:5px 0; clear:both;">
    <ui:form name="myForm"  id="myForm" method="post"> 
		<input id="ChooseSerInvokeInsName" name="ChooseSerInvokeInsName" type="hidden" value="${serInvokeInsName}" />
	 	<input id="ChooseSerInvokeInsId" name="ChooseSerInvokeInsId" type="hidden" value="${serInvokeInsId}" />
	 	<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
   			<dl>	
    				<dt><s:property value="%{getText('eaap.op2.conf.manager.auth.service')}" />:</dt>	
    				<dd >
    				 	<ui:inputText skin="${contextStyleTheme}"  id="serserviceName"  name="serserviceName"  readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('serserviceCode','serserviceName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="serserviceCode" name="ser.serviceCode"/>
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/serviceManager/showMainInfo.shtml?pageState=pageState&serviceCode=serserviceCode&&serviceName=serserviceName','Choose Servcice')" shape="s"></ui:button>
					</dd>
   			</dl>
   			<dl>		
    				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}" />:</dt>
    				<dd >
    					<ui:inputText skin="${contextStyleTheme}"  name="orgorgname" id="orgorgName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('orgorgName','orgorgId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="orgorgId" name="org.orgId"/>                         
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgCode=orgorgId&chooseOrgName=orgorgName','Choose Org')" shape="s"></ui:button>
					</dd>
   			</dl>
   			<dl>
    				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />:</dt>
    				<dd >
    				    <ui:inputText skin="${contextStyleTheme}"  id="myComponentName" name="myComponentName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('myComponentName','myComponentId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="myComponentId" name="component.componentId"/>                                   
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=myComponentName&chooseCompCode=myComponentId','Choose Component')" shape="s"></ui:button>
					</dd>	
    		</dl>
    		<dl>	
   				<dt><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}" />:</dt>	
   				<dd >
   				    <ui:inputText skin="${contextStyleTheme}"  type="text" name="serii.serInvokeInsName"  id="mySerInvokeInsName" value="%{getText('eaap.op2.conf.manager.auth.canlike')}" />
   				</dd>
   			</dl>
   			<dl>		
   				<dt><s:property value="%{getText('eaap.op2.conf.manager.auth.state')}"/>:</dt>
   				<dd >
   					<ui:select skin="${contextStyleTheme}"  name="serii.state" id="seriiState"   emptyOption="true" headerValue=""
   			        list="selectSerInvokeInsStateList" listKey="serInvokeInsStateCode" listValue="serInvokeInsStateName" style="width:70px;" ></ui:select>
   				</dd>
   			</dl>
		<div style="text-align:right;float:right; margin-bottom:5px ;">
				<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/>
				<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
		 </div>
	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"  id="seriilistid" remoteSort="false" sortOrder="desc"   onClickCell="true"
			fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true" toolbar="true"  method="eaap-op2-conf-manager-ConfManagerAction.getSerInvokeInsList">
			<ui:gridEasyColumn width="160" index="0" title="0" field="SERVICE_CODE" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="160" index="1" title="1" field="SERVICE_CN_NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="80" index="2" title="2" field="COMPCODE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="160" index="3" title="3" field="COMPNAME" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="160" index="4" title="4" field="SER_INVOKE_INS_NAME" hidden="false"  formatter="true" formatterMethod="linkMessage" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="60" index="5" title="5" field="STATE" hidden="false"  formatter="true" formatterMethod="formatterForState"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="6" title="6" field="LASTEST_DATE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="7" title="7" field="CREATE_DATE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="8" title="8" field="MESSAGE_FLOW_NAME" hidden="false" formatter="true" formatterMethod="formatterForOp"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="9" title="9" field="SER_INVOKE_INS_ID" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="10" title="10" field="MESSAGE_FLOW_ID" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="11" title="11" field="SER_STATE" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
	</div>
	<table class="mgr-table" style="display:none" id="confirm">
	   <tr>
	     <td  colspan="4"  align="center">
	        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseSerInvokeIns();"></ui:button>
	        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
		 </td>	
	   </tr>
	</table>
</div>
<input type="hidden" name="msFlowUrl"  id="msFlowUrl"  value="${msFlowUrl}"/>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"    iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>

function changeDivTitle(title)
{  
 
}

function searchFunc() {
	$("#isInit").val("false");
    var form = $("#myForm").form();
    $('#seriilistid').datagrid("load", sy.serializeObject(form));
}	
      
      
function closeWin(){
 $('#opendialog').window('close');
 }
 
 

function getRadioValue()
{
 var mymdtcd=document.getElementsByName("mycompIds");   
 var strNew="";   
 for(var i=0;i<mymdtcd.length;i++)   
 {     
 if(mymdtcd[i].checked){    
   
   strNew=mymdtcd[i].value;    
    break; 
 }
}
 return strNew ;
}



   function deleteMethod(){ 					
	    
		 if($('#seriilistid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
				{
				  var seriid = $('#seriilistid').datagrid('getSelections')[0].SER_INVOKE_INS_ID ;
				  window.location='${contextPath}/mgr/updateSerInvokeIns.shtml?serInvokeIns.state=R&serInvokeIns.serInvokeInsId='+seriid;
				}
		 }
    		
     }
    		
    function addMehtod(){
 	     window.location='${contextPath}/mgr/preAddSerInvokeIns.shtml';
    } 
              
   function updateMethod(){
	  
        if($('#seriilistid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
		     var seriid = $('#seriilistid').datagrid('getSelections')[0].SER_INVOKE_INS_ID ;
			 window.location='${contextPath}/mgr/preAddSerInvokeIns.shtml?editOrAdd=edit&serInvokeIns.serInvokeInsId='+seriid;
		 }
   }
   
  function formatterForState(value,row,index){
    if(value=='A'){
      return "<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateA')}" />"  ;
    }else if(value=='R'){
      return "<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateR')}" />"  ;
    } 
   
 }
  function linkMessage(value,row,index){
	  return "<a href='javascript:show_address("+row.SER_INVOKE_INS_ID+");'><font>"+value+"</font></a>";
  }
  function show_address(ser_invoke_ins_id){
	  var url = '${contextPath}/mgr/show_addrdss.shtml?serInvokeInsId='+ser_invoke_ins_id;
	  var name = "<s:property value="%{getText('eaap.op2.conf.proof.view')}" />"  ;
	  openWindows(url,name);
  }
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}


function formatterForOp(value,row,index){
   if(value==null){
		return "";
   }else{
		return '<a href="${msFlowUrl}?messageFlowId='+row.MESSAGE_FLOW_ID+'" target="_blank">'+value+'</a>' ;
   }
}
  
// function openMsgFlow(messageFlowId){
// 	var msFlowUrl = $('#msFlowUrl').val()+"?messageFlowId="+messageFlowId;
// 	window.open(msFlowUrl,"Message Flow");
// }
</script>
<script language="JavaScript" type="text/javascript">
			function addListener(element,e,fn){    
    	 		if(element.addEventListener){    
          			element.addEventListener(e,fn,false);    
     			 } else {    
         	 		element.attachEvent("on" + e,fn);    
     	 		 }    
			}
			var myinput = document.getElementById("mySerInvokeInsName");
			if("<s:property value="%{getText('eaap.op2.conf.manager.auth.canlike')}"/>"==myinput.value){
			    myinput.style.color="#DCDCDC";
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
			
			$(document).ready(function(){
		   	   var choosePageState=$("#choosePageState").attr('value');
		       if(choosePageState!="")
		       {
		      	 document.getElementById("confirm").style.display= ""; 
		       }
		    })
			function chooseSerInvokeIns()
		    {
			    var vOpener=art.dialog.opener;
			    if ($('#seriilistid').datagrid('getSelections')[0]==null) {
			    	alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
			    } else {
			        var chooseSerInvokeInsId = $('#seriilistid').datagrid('getSelections')[0].SER_INVOKE_INS_ID ;
			    	var chooseSerInvokeInsName = $('#seriilistid').datagrid('getSelections')[0].SER_INVOKE_INS_NAME ;
			    	var chooseServiceStatus = $('#seriilistid').datagrid('getSelections')[0].SER_STATE;
			    	var chooseServiceStatusName = $('#seriilistid').datagrid('getSelections')[0].SER_STATE_NAME;
			    	
			    	if(chooseServiceStatus){
			    		if(vOpener.document.getElementById("serviceStatusInput")!=null && vOpener.document.getElementById("serviceStatusName")!=null){
				    		vOpener.document.getElementById("serviceStatusInput").value=chooseSerInvokeInsId;
				    		vOpener.document.getElementById("serviceStatusName").value= chooseServiceStatusName;
			    		}
			    	}
			    	
			    	if($("#chooseSerInvokeInsId").attr('value')!="")
					 {
					  	vOpener.document.getElementById($("#ChooseSerInvokeInsId").attr('value')).value=chooseSerInvokeInsId;
						//window.opener.document.getElementById($("#ChooseSerInvokeInsId").attr('value')).value =chooseSerInvokeInsId;
					//	window.opener.document.all($("#ChooseSerInvokeInsId").attr('value')).value =chooseSerInvokeInsId;
					 }
					if($("#chooseSerInvokeInsName").attr('value')!="")
					 {
						vOpener.document.getElementById($("#ChooseSerInvokeInsName").attr('value')).value=chooseSerInvokeInsName;
						//window.opener.document.getElementById($("#ChooseSerInvokeInsName").attr('value')).value =chooseSerInvokeInsName;
					//	window.opener.document.all($("#ChooseSerInvokeInsName").attr('value')).value =chooseSerInvokeInsName;
					 }
					 	art.dialog.close(); 
						//window.close();
			    }
		     }

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
