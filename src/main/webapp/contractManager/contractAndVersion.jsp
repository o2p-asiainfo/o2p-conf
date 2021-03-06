<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>	
	
	<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.portal.prov.contractName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.portal.prov.contractStatu')}" />';
	
	   //search Function
	function searchContract(){		
		 var form = $("#showContractForm").form();
	      $('#contractList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 					   
     if($('#contractList').datagrid('getSelections')[0]==null||$('#contractList').datagrid('getSelections')[0].CONTRACTID==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
     }
     else{
    	if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmDel')}" />"))
			{			
				var contractId = $('#contractList').datagrid('getSelections')[0].CONTRACTID ;
		   		window.location="deleteContract.shtml?contractId=" + contractId;
			}	
     	}  
   }
   		 
   function addMehtod(){	  
  	window.location = "gotoAddContract.shtml";
   } 
             
  function updateMethod(){      
	if($('#contractList').datagrid('getSelections')[0]==null||$('#contractList').datagrid('getSelections')[0].CONTRACTID==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
    }
    	else{    		
    	//if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmEdit')}" />"))
		//{			
			var contractId = $('#contractList').datagrid('getSelections')[0].CONTRACTID ;
			//window.location="editContractManager.shtml?contractId=" + contractId;
			window.location="gotoEditContract.shtml?contractId=" + contractId;
		//}		
    	} 	
    }	 
    
  function clickMethod(index,field,value){   
    if($('#contractList').datagrid('getSelections')[0]!=null)
    	{
         var contractId = $('#contractList').datagrid('getSelections')[0].CONTRACTID ;
         if(contractId=="")
		  {
		    alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		  }else{
			window.location="gotoEditContract.shtml?contractId=" + contractId;
		 }
   		} 
	} 
  function closecurry(){
	var tmporgid = $('#contractList').datagrid('getSelections')[0].CONTRACTID ;
	var tmporgname = $('#contractList').datagrid('getSelections')[0].CODE ;	
		 if(tmporgid=="")
		 {
		 	alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
		        //parent.document.getElementById("protocol").value=tmporgname;   
			    //parent.document.getElementById("protocolId").value=tmporgid;    
				//parent.closeWin();  
			var vOpener=art.dialog.opener; 		    
		    vOpener.document.getElementById("protocol").value=tmporgname; 
		    vOpener.document.getElementById("protocolId").value=tmporgid; 
		    art.dialog.close() ;
		 }
	}
 function formatterForState(value,row,index){
    if(value=='A'){
      return "<s:property value="%{getText('eaap.op2.portal.prov.effective')}" />"  ;
    }else if(value=='R'){
      return "<s:property value="%{getText('eaap.op2.conf.prov.effectiveLoss')}" />"  ;
    } 
    else{
    }
   }
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.portal.prov.serverManage')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.portal.prov.contractManage')}" />
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
	<ui:form id="showContractForm" method="post" action="showContract.shtml">
	    <input id="ChooseContractName" name="ChooseContractName" type="hidden" value="${contractName}" />
	    <input id="ChooseContractNameText" name="ChooseContractNameText" type="hidden" value="${chooseContractName}" />
	    <input id="ChooseContractId" name="ChooseContractId" type="hidden" value="${chooseContractId}" />
	 	<input id="ChooseContractVersionName" name="ChooseContractVersionName" type="hidden" value="${contractVersionName}" />
	 	<input id="ChooseContractVersionId" name="ChooseContractVersionId" type="hidden" value="${contractVersionID}" />

    		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.portal.prov.contractName')}" />:
    				</dt>	
    				<dd >
    				   <ui:inputText id="contractName"  name="contractName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/>
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" />:
    				</dt>
    				<dd >
    					<ui:inputText id="contractNode"  name="contractNode"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/>
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.portal.prov.contractStatu')}" />:
    				</dt>
    				<dd >
	    				<ui:select  
	    				name="statu" 
	    				id="statu"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="selectStateList" 
	    			    listKey="code" 
	    			    listValue="name" 
	    			    style="width:70px;" 
	    			    skin="${contextStyleTheme}"
	    			    >
    			    </ui:select>
    				</dd>	
    		</dl>
    		<dl>		
    			<dt><s:property value="%{getText('eaap.op2.portal.prov.contractBasic')}" />:</dt>	
    				<dd >
    				<ui:select  
	    				name="base" 
	    				id="base"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="baseContractList" 
	    			    listKey="BASEID" 
	    			    listValue="NAME" 
	    			    layerWidth="200px" 
	    			    skin="${contextStyleTheme}"
	    			    >
    			    </ui:select>
    				</dd>  
    		</dl>

   	      	<div style="text-align:right;float:right; margin-bottom:5px ;">
					<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchContract();" skin="${contextStyleTheme}"/>  
		 	</div>
	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="contractList" remoteSort="false" sortOrder="desc"  onClickCell="true" toolbar="true"
			skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.portal.prov.contractManage')}" striped="true" pageSize="10" pagination="true" 
			frozenColumns="true" rownumbers="true"   method="eaap-op2-conf-contract-ContractAction.getContractAndVersionList">
			<ui:gridEasyColumn width="300" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="260" index="1" title="1" field="CODE" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="300" index="2" title="2" field="VERSION" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="3" title="3" field="STATE" hidden="false"   align="center" formatter="true" formatterMethod="formatterForState"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="1" index="4" title="4" field="VERSIONID" hidden="true"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="1" index="5" title="5" field="CONTRACTID" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
	 </div>
	 </div>
	 <table class="mgr-table" id="confirm">
		  <tr>
		    <td  colspan="4"  align="center">
		       <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseContractId();"></ui:button>
		       <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
			</td>	
	     </tr>
	  </table>
</div>
<c:if test="${reqFrom=='from'}">
<ui:button text="%{getText('eaap.op2.conf.prov.close')}" id="chooseCompId" onclick="closecurry()" skin="${contextStyleTheme}"></ui:button>
</c:if >
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto"  divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body>
<script>
	function chooseContractId()
   {
    var vOpener=art.dialog.opener;
    var chooseContractName = $('#contractList').datagrid('getSelections')[0].NAME ;
    var chooseContractId = $('#contractList').datagrid('getSelections')[0].CONTRACTID ;
    var chooseContractVersionName = $('#contractList').datagrid('getSelections')[0].VERSION ;
    var chooseContractVersionId = $('#contractList').datagrid('getSelections')[0].VERSIONID ;
    if(chooseContractName=="")
     {
      alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
     }else{
		    if($("#ChooseContractName").attr('value')!="")
			 {
			  vOpener.document.getElementById($("#ChooseContractName").attr('value')).value=chooseContractName;
			 }
		    if($("#ChooseContractId").attr('value')!="")
			 {
			  vOpener.document.getElementById($("#ChooseContractId").attr('value')).value=chooseContractId;
			 }
		    if($("#ChooseContractNameText").attr('value')!="")
			 {
			  vOpener.document.getElementById($("#ChooseContractNameText").attr('value')).innerText=chooseContractName;
			 }
			if($("#ChooseContractVersionName").attr('value')!="")
			 {
			vOpener.document.getElementById($("#ChooseContractVersionName").attr('value')).value=chooseContractVersionName;
			 }
			if($("#ChooseContractVersionId").attr('value')!="")
			 {
			 vOpener.document.getElementById($("#ChooseContractVersionId").attr('value')).value=chooseContractVersionId;
			 }
			
			if(vOpener.reflashWindow){
				vOpener.reflashWindow();
			}
			art.dialog.close(); 
	 }
 }
	$(function(){
		var flag="${reqFrom}";
		if(flag!="from"){
		   $(".datagrid-toolbar").hide();
		}
	});

</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>