<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.compregauditing.SysName')}"/></title>
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
title[0]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compCode')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compType')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compState')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      <img src="../resource/blue/images/search.png" />
		  <s:property value="%{getText('eaap.op2.conf.compregauditing.SysName')}"/>
	      <img src="../resource/blue/images/module-path.png" />
	      <s:property value="%{getText('eaap.op2.conf.compregauditing.compManage')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.compregauditing.queryCondition')}"/>
         </div>
    </div>
    
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
    <form name="myForm"  id="myForm" method="post">
   		    <input type="hidden" name="compStateMap" id="compStateMap" value="${compStateMap}" />
   			<dl>	
   				<dt>
   					<s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}" />:
   				</dt>	
   				<dd >
   				 	<ui:inputText skin="${contextStyleTheme}"  name="component.name"  id="myCompName" value="%{getText('eaap.op2.conf.manager.auth.canlike')}" />
   				</dd>
   			</dl>
   			<dl>		
   				<dt>
   					<s:property value="%{getText('eaap.op2.conf.compregauditing.compCode')}" />:
   				</dt>
   				<dd >
   					<ui:inputText skin="${contextStyleTheme}"  name="component.componentId" value="${component.componentId}" />
   				</dd>
   			</dl>
   			<dl>
   				<dt>
   					<s:property value="%{getText('eaap.op2.conf.compregauditing.compType')}" />:
   				</dt>
   				<dd >
   				    <ui:multiSelectBox name="componentTypeIds" id="selectComTypeId" skin="${contextStyleTheme}"
   				     list="comTypeList" listKey="COMPONENT_TYPE_ID" listValue="NAME" >
				   </ui:multiSelectBox>
   				</dd>	
    		</dl>
    		<dl>	
   				<dt>
   					<s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}" />:
   				</dt>	
   				<dd >
   				    <ui:inputText skin="${contextStyleTheme}"  type="text" name="org.name" id="orgorgName" value="${org.name}" readonly="true" style="float:left;"/>
   				    <input class="inputClearBtn" onclick="javascript:cleardata('orgorgName','orgorgId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
   					<input type="hidden" id="orgorgId" name="org.orgId"/>
		     		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgCode=orgorgId&chooseOrgName=orgorgName','Select Organization')" shape="s"></ui:button>
   				</dd>
   			</dl>
   			<dl>		
   				<dt>
   					AppKey:
   				</dt>
   				<dd >
   					<ui:inputText skin="${contextStyleTheme}"  type="text"  name="app.appkey" id="app.appkey"></ui:inputText>
   				</dd>
   			</dl>
   			<dl>
   				<dt>
   					<s:property value="%{getText('eaap.op2.conf.compregauditing.compState')}" />:
   				</dt>
   				<dd >
   				    <ui:multiSelectBox skin="${contextStyleTheme}" id="cstateid"  name="componentStates" list="compStateList" listKey="key" listValue="value" ></ui:multiSelectBox>
   				</dd>	
   			</dl> 
	 <div style="text-align:right;float:right; margin-bottom:5px ;">
			<ui:inputText skin="${contextStyleTheme}"  name="isInit" id="isInit" value="" style="display:none"/> 
			<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();" disabled="false"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"  id="comlistid" remoteSort="false" sortOrder="desc"  
		fit="true" fitHeight="308" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" toolbar="true" frozenColumns="true" rownumbers="true"   
		method="eaap-op2-conf-auditing-ComponmentAction.getCompList">
		<ui:gridEasyColumn width="160" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="1" title="1" field="CODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="2" title="2" field="COMPTYPE" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="3" title="3" field="ORGNAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="4" title="4" field="STATE" hidden="false"   formatter="true" formatterMethod="formatterForState"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="5" title="5" field="STATE_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="6" title="6" field="REG_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="7" title="7" field="COMPONENT_ID" hidden="true" align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>
</div>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" frameborder="10" />
</body>
<script>

$(document).ready(function() {
  $("#cstateid").multiselect("widget").find(":checkbox").get(0).click();
});
      
function searchFunc() {
	$("#isInit").val("false");
    var form = $("#myForm").form();
    $('#comlistid').datagrid("load", sy.serializeObject(form));
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
	    
		 if($('#comlistid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
				{
				 var tmpcompid = $('#comlistid').datagrid('getSelections')[0].COMPONENT_ID ;
				  window.location='${contextPath}/component/deleteComp.shtml?content_Id='+tmpcompid;
				}
		 }
     }
    		
    function addMehtod(){
       window.location="${contextPath}/component/preAddCompInfo.shtml";
 	 } 
              
   function updateMethod(){
	    if($('#comlistid').datagrid('getSelections')[0]==null)
		 {
		       alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		  }else{
		        var tmpcompid =  $('#comlistid').datagrid('getSelections')[0].COMPONENT_ID ;
			   window.location='${contextPath}/component/preAddCompInfo.shtml?tmpType=edit&component.componentId='+tmpcompid;
		  }
   }
   
   
    function clickMethod(index,field,value)
     { 
         if($('#comlistid').datagrid('getSelections')[0]!=null)
		 {
		       var tmpcompid =  $('#comlistid').datagrid('getSelections')[0].COMPONENT_ID ;
			   window.location='${contextPath}/component/preAddCompInfo.shtml?tmpType=edit&component.componentId='+tmpcompid;
		  } 
  }   		


 function formatterForState(value,row,index){
     var comm_map_arr ; 
     comm_map_arr=$("#compStateMap").val();
     comm_map_arr =  comm_map_arr.substring(1,comm_map_arr.length-1).split(',');
     for (var i = 0; i < comm_map_arr.length; i++) {
     if (jQuery.trim(comm_map_arr[i].split('=')[0]) == value ) {    
       return comm_map_arr[i].split('=')[1];    
      }    
     }    
       return value ;
 }
</script>

<script language="JavaScript" type="text/javascript">
			function addListener(element,e,fn){    
    	 		if(element.addEventListener){    
          			element.addEventListener(e,fn,false);    
     			 } else {    
         	 		element.attachEvent("on" + e,fn);    
     	 		 }    
			}
			var myinput = document.getElementById("myCompName");
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
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
