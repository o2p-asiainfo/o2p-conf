<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.compregauditing.SysName')}"/></title>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
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
title[4]='<s:property value="%{getText('eaap.op2.conf.manager.auth.orgcode')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.compregauditing.compState')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
title[7]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
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
    <ui:form  name="myForm"  id="myForm" method="post"> 
   		<input id="chooseCompCode" name="chooseCompCode" type="hidden" value="${chooseCompCode}" />
		<input id="chooseCompName" name="chooseCompName" type="hidden" value="${chooseCompName}" />
		<input id="chooseComponentCode" name="chooseComponentCode" type="hidden" value="${chooseComponentCode}" />
		<input id="chooseOrgName" name="orgName" type="hidden" value="${chooseOrgName}" />
		<input id="chooseOrgId" name="orgId" type="hidden" value="${chooseOrgId}" />
		<input type="hidden" name="compStateMap" id="compStateMap" value="${compStateMap}" />

		     <dl>
  				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}"/>:</dt>	
  				<dd><ui:inputText skin="${contextStyleTheme}" name="component.name" id="myComName" value="%{getText('eaap.op2.conf.manager.auth.canlike')}"/>
  				</dd>	
  			 </dl>
  			 <dl>
  				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.compCode')}"/>:</dt>	
  				<dd><ui:inputText skin="${contextStyleTheme}" name="component.componentId" value="${component.componentId}" />
  				</dd>
  			 </dl>
  			 <dl>
  				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.compType')}"/>:</dt>
  				<dd>
  				  <ui:multiSelectBox name="componentTypeIds" id="selectComTypeId" skin="${contextStyleTheme}" 
	  				     list="comTypeList" listKey="COMPONENT_TYPE_ID" listValue="NAME">
				   </ui:multiSelectBox>
			 	</dd>
  			</dl>
  		    <dl>
  				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</dt>	
  				<dd><ui:inputText skin="${contextStyleTheme}"  type="text" name="org.name" id="org.name" value="${org.name}" /></dd>	
  			</dl>
  			<dl>	 
  				 <dt>AppKey:</dt>
  				<dd><ui:inputText  skin="${contextStyleTheme}" type="text"  name="app.appkey" id="app.appkey"></ui:inputText></dd>
  			</dl>	
  			<dl>	
  				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.compState')}"/>:</dt>
  				<dd>
	  				  <ui:multiSelectBox skin="${contextStyleTheme}" id="cstateid"  name="componentStates" list="compStateList" listKey="key" listValue="value"  ></ui:multiSelectBox>
	  			 </dd>
  			</dl>
   	      	<div style="text-align:right;float:right; margin-bottom:5px ;">
				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();" disabled="false"/>
		 	</div>
	</ui:form>
	</div>
	<div style=" clear:both;">
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="comlistid" remoteSort="false" sortOrder="desc" queryParams="true" queryParamsData="${orgId}"
		fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   method="eaap-op2-conf-auditing-ComponmentAction.getCompList">
		<ui:gridEasyColumn width="160" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="1" title="1" field="CODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="2" title="2" field="COMPTYPE" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="3" title="3" field="ORGNAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="4" title="4" field="ORGCODE" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="5" title="5" field="STATE" hidden="false" formatter="true" formatterMethod="formatterForState"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="6" title="6" field="STATE_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="7" title="7" field="REG_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="160" index="8" title="8" field="ORG_ID" hidden="true"   align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
	</div>
	</div>
	<table class="mgr-table">
	   <tr>
	     <td  colspan="4"  align="center">
			 <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.sure')}" id="chooseCompId" onclick="javascript:chooseCompId()"></ui:button>
			 <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="javascript:art.dialog.close();"></ui:button>
	      </td>	
	     </tr>
	  </table>
</div>
<!--body end --> 
<ui:iframe skin="${contextStyleTheme}"    iframeWidth="896" iframeHeight="450" iframeScrolling="auto"  divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>


      
function searchFunc() {
   var form = $("#myForm").form();
      $('#comlistid').datagrid("load", sy.serializeObject(form));
      }	
      
      
function closeWin(){
 $('#opendialog').window('close');
 }
 
 
 
function  todeletecomp()
{
 
var tmpcompid = $('#comlistid').datagrid('getSelections')[0].COMPONENT_ID ;
 if(tmpcompid=="")
 {
   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
 }else{
	  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
		{
		  window.location='${contextPath}/component/deleteComp.shtml?content_Id='+tmpcompid;
		}
 }
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



function chooseCompId()
{
var tmpcompid = $('#comlistid').datagrid('getSelections')[0].COMPONENT_ID ;
var tmpcompname = $('#comlistid').datagrid('getSelections')[0].NAME ;
var chooseComponentCode = $('#comlistid').datagrid('getSelections')[0].CODE ;
var chooseOrgId = $('#comlistid').datagrid('getSelections')[0].ORG_ID ;
var chooseOrgName = $('#comlistid').datagrid('getSelections')[0].ORGNAME ;

if(tmpcompid=="")
 {
 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
 }else{
         var vOpener=art.dialog.opener;
        if($("#chooseCompCode").attr('value')!="")
	   {
	    vOpener.document.getElementById($("#chooseCompCode").attr('value')).value=tmpcompid;
	   }
      
	   if($("#chooseCompName").attr('value')!="")
	   {
	    vOpener.document.getElementById($("#chooseCompName").attr('value')).value=tmpcompname;
	   }
	   if($("#chooseComponentCode").attr('value')!="")
	   {
	    vOpener.document.getElementById($("#chooseComponentCode").attr('value')).value=chooseComponentCode;
	   }
	   if($("#chooseOrgId").attr('value')!="" && $("#chooseOrgName").attr('value')!=""){
		   vOpener.document.getElementById($("#chooseOrgId").attr('value')).value=chooseOrgId;
		   vOpener.document.getElementById($("#chooseOrgName").attr('value')).value=chooseOrgName;
	   }
	   art.dialog.close();
	  
		
	 }
}

function formatterForState(value,row,index){
     var comm_map_arr ; 
     comm_map_arr=$("#compStateMap").val();
     comm_map_arr =  comm_map_arr.substring(1,comm_map_arr.length-1).split(',');
     for (var i = 0; i < comm_map_arr.length; i++) {
     if ($.trim(comm_map_arr[i].split('=')[0]) == value ) {    
       return comm_map_arr[i].split('=')[1];    
      }    
     }    
       return value ;
 }

var myinput = document.getElementById("myComName");
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
</html>
