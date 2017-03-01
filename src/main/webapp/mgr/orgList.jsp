<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
 </head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.orgname')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.orgcode')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.orgtype')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.regrole')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.manager.auth.orgusername')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.cardnum')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.mobile')}" />';
title[7]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.userstate')}" />';
title[8]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />'; 
</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      <img src="../resource/blue/images/search.png" />
	      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      <img src="../resource/blue/images/module-path.png" />
	      <s:property value="%{getText('eaap.op2.conf.orgregauditing.orglist')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
				<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
         </div>
    </div>
    
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
    <ui:form name="myForm" id="myForm" method="post"> 
		<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.manager.auth.orgname')}" />:
			</dt>	
			<dd >
			   <input type="hidden" name="orgStateMap" id="orgStateMap" value="${orgStateMap}" />
		       <ui:inputText skin="${contextStyleTheme}"  name="org.name" id="myOrgName" value="%{getText('eaap.op2.conf.manager.auth.canlike')}"  />
			</dd>
		</dl>
		<dl>		
			<dt>
				<s:property value="%{getText('eaap.op2.conf.manager.auth.orgcode')}" />:
			</dt>
			<dd >
				<ui:inputText skin="${contextStyleTheme}"  id="org.orgCode"   name="org.orgCode" value="${org.orgCode}"  style="float:left;"/>
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
		<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.orgregauditing.regrole')}" />:
			</dt>	
			<dd >
			   <ui:select skin="${contextStyleTheme}"  emptyOption="true" headerValue="" name="orgRole.roleCode" id="selectMenuId" 
		       list="selectRoleList" listKey="roleCode" listValue="roleName" style="width:70px;" ></ui:select>
			</dd>
		</dl>
		<dl>		
			<dt>
				<s:property value="%{getText('eaap.op2.conf.manager.auth.orgusername')}" />:
			</dt>
			<dd >
				<ui:inputText skin="${contextStyleTheme}"    name="org.orgUsername" value="${org.orgUsername}" />
			</dd>
		</dl>
		<dl>
			<dt>
				<s:property value="%{getText('eaap.op2.conf.orgregauditing.cardnum')}" />:
			</dt>
			<dd >
			    <ui:inputText skin="${contextStyleTheme}"    name="org.certNumber" value="${org.certNumber}" />
			</dd>	
		</dl>
		<%--<dl>
			<dt>
				<s:property value="%{getText('eaap.op2.conf.orgregauditing.orgemail')}" />:
			</dt>	
			<dd >
			   <ui:inputText skin="${contextStyleTheme}"    name="org.email" value="${org.email}" />
			</dd>
		</dl> --%>
		<dl>	
			<dt>
				<s:property value="%{getText('eaap.op2.conf.orgregauditing.mobile')}" />:
			</dt>
			<dd >
				<ui:inputText skin="${contextStyleTheme}"  name="org.telephone" value="${org.telephone}" />
			</dd>
		</dl>
		<dl>
			<dt>
				<s:property value="%{getText('eaap.op2.conf.orgregauditing.userstate')}" />:
			</dt>
			<dd >
			    <ui:multiSelectBox skin="${contextStyleTheme}"  name="arrayState" id="selectStateId"   
		      	list="orgStateList" listKey="key" listValue="value"></ui:multiSelectBox>
			</dd>	
		</dl>
		<div style="text-align:right; float:right; margin-bottom:5px ;">
			<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/> 
			<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}"   id="chaxun" onclick="searchFunc();"/>
		</div>
	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="orglistid"  remoteSort="false" sortOrder="desc"  
			fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="true" rownumbers="true"   
			method="eaap-op2-conf-manager-ConfManagerAction.getOrgList">
			<ui:gridEasyColumn width="120" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="1" title="1" field="ORG_CODE" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="110" index="2" title="2" field="ORG_TYPE_CODE" hidden="false"  formatter="true" formatterMethod="formatterForOrgType"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="3" title="3" field="roleName" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="4" title="4" field="ORG_USERNAME" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="5" title="5" field="CERT_NUMBER" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="6" title="6" field="TELEPHONE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="80" index="7" title="7" field="STATE" hidden="false" formatter="true" formatterMethod="formatterForState"  align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="8" title="8" field="STATE_TIME" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="9" title="9" field="ORG_ID" hidden="true" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="10" title="10" field="DELFLAG" hidden="true" align="center" ></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
</div>

<form name="todeleteorgForm" method="post" id="todeleteorgForm" action="">
	 <input  type="hidden"  id="orgid"  name="org.orgId"/>
	 <input  type="hidden"  id="orgstate"  name="org.state"/> 
	 <input  type="hidden"  id="tmpTypeId"  name="tmpType"/>
	 <input  type="hidden"  id="mycontentId"  name="content_Id"/>
  </form>
<!--body end --> 
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>

$(document).ready(function() {
	$("#selectStateId").multiselect("widget").find(":checkbox").get(0).click();
});
  
function searchFunc() {
   $("#isInit").val("false");
   var form = $("#myForm").form();
   $('#orglistid').datagrid("load", sy.serializeObject(form));
}	
    
 function formatterForState(value,row,index){
     var comm_map_arr ; 
     comm_map_arr=$("#orgStateMap").val();
     comm_map_arr =  comm_map_arr.substring(1,comm_map_arr.length-1).split(',');
     for (var i = 0; i < comm_map_arr.length; i++) {
     if (jQuery.trim(comm_map_arr[i].split('=')[0]) == value ) {
       return comm_map_arr[i].split('=')[1];    
      }    
     }    
       return value ;
 }
function formatterForOrgType(value,row,index)
  {
      if(value=='0')
      {
      return  '<s:property value="%{getText('eaap.op2.conf.orgregauditing.userisother')}" />' ;
      }else if(value=='1')
      {
      return '<s:property value="%{getText('eaap.op2.conf.orgregauditing.useriscomp')}" />' ;
      }else if(value=='2')
      {
      return '<s:property value="%{getText('eaap.op2.conf.orgregauditing.userisperson')}" />' ;
      }
  }
 
 function clickMethod(index,field,value)
 { 
      
        if($('#orglistid').datagrid('getSelections')[0]!=null)
		 {
		       var tmporgid = $('#orglistid').datagrid('getSelections')[0].ORG_ID ;
		        $("#mycontentId").val(tmporgid) ;
				$("#tmpTypeId").val('edit') ;
				window.location='${contextPath}/mgr/queryOrgInfo.shtml?tmpType=edit&content_Id='+tmporgid;
		 } 
  }   		  
 

function  toqueryorg()
{
var tmporgid = getRadioValue() ;
 if(tmporgid=="")
 {
 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
 }else{
	    $("#mycontentId").val(tmporgid) ;
		$("#tmpTypeId").val('info') ;
		todeleteorgForm.action="${contextPath}/mgr/queryOrgInfo.shtml" ;
		todeleteorgForm.submit();
		 
 }
}
 
function getRadioValue()
{
 var mymdtcd=document.getElementsByName("myorgIds");   
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

function closeWin(){
 $('#opendialog').window('close');
 }
 
 
 
  function deleteMethod(){ 					
	    if($('#orglistid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />")){
				  var isdele = $('#orglistid').datagrid('getSelections')[0].DELFLAG;
				  if(isdele==0){
						var tmporgid = $('#orglistid').datagrid('getSelections')[0].ORG_ID ;
						$.ajax({
	        				type: "POST",
	        				async:false,
	        			    url: "${contextPath}/mgr/isDeleteByproductOrOffer.shtml",
	        			    dataType:'json',
	        			    data:{orgId:tmporgid},
	        				success:function(msg){
	        					if(msg.code=="0"){
	        						$("#orgid").val(tmporgid) ;
	        						$("#orgstate").val('X') ;
	        						window.location='${contextPath}/mgr/updateOrgInfoState.shtml?org.state=X&org.orgId='+tmporgid;
	        						alert("The organization has been deleted");
	        					}else{
	        						alert(msg.result);
	        					}
	        		        }
	        		   });
				  }else
					  alert("The organization for containing component that  cannot be deleted");
			}
		 }
     }
    		
    function addMehtod(){
       window.location="${contextPath}/mgr/preAddOrgInfo.shtml";
 	 } 
              
   function updateMethod(){
        if($('#orglistid').datagrid('getSelections')[0]==null)
		 {
		 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
		    var tmporgid = $('#orglistid').datagrid('getSelections')[0].ORG_ID ;
			    $("#mycontentId").val(tmporgid) ;
				$("#tmpTypeId").val('edit') ;
				window.location='${contextPath}/mgr/queryOrgInfo.shtml?tmpType=edit&content_Id='+tmporgid;
		 }
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
			var myinput = document.getElementById("myOrgName");
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

</script>

<%@ include file="/common/ssoCommon.jsp"%> 
</html>
