<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<head>            
		<title><s:property value="%{getText('eaap.op2.conf.contract.doc.docManager')}" /></title>  
		<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	

	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/icon.css" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/uploadify.css" /> 
    <link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/docUpload.css" />  
    
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>		 
	<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/> 
	<script type="text/javascript" src="${contextPath}/resource/comm/js/swfobject.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/doc_upload.js"></script>	
	
	 
<script type="text/javascript">

	$(function(){
		initUploadify();
	});
	
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.contract.doc.docName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.contract.doc.createDate')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.contract.doc.state')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.contract.doc.resourceAliss')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.contract.doc.lastestTime')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.contract.doc.contractId')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.contract.doc.docPath')}" />';
	title[8]='Operation';
	
	function deleteMethod(){ 					   
	     if($('#contractDocTab').datagrid('getSelections')[0]==null||$('#contractDocTab').datagrid('getSelections')[0].CONTRACTDOCID==""){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
	     }
	     else{
	    	if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmDel')}" />"))
				{			
					var contractId = $('#contractDocTab').datagrid('getSelections')[0].CONTRACTDOCID ;
			   		window.location="deleteDoc.shtml?delDocId=" + contractId;
				}	
	     	}  
	   }	   
	function addMehtodSubmit(){
		var docName = document.getElementById("docName");
		var docVersion = document.getElementById("docVersion");	
		var fileId = document.getElementById("attach_id1");		
		var resourceAlis = $("#resourceAliss").val();
		if(checkAll())
       	{    		
       		if(fileId.value == ""){
       			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.selUpFile')}" />");
       			return;
       		}
       		//var ajaxValue = ajaxFileUpload(docName.value,docVersion.value,fileId.value);	
       		//if(ajaxValue == 1){
       		//	alert("<s:property value="%{getText('eaap.op2.conf.prov.add')}" /><s:property value="%{getText('eaap.op2.conf.prov.ok')}" />");
       		//}
       		window.location="fileUploadJson.shtml?contractDoc.docName="+docName.value+"&contractDoc.docVersion="+docVersion.value+"&contractDoc.docPath="+fileId.value+"&contractDoc.resourceAliss="+resourceAlis+"&contractDoc.docType="+$('#file_after_name').val();		
       	}
	 }
	function addMehtod(){
		$("#contractId").val('');
		$("#resourceAliss").val('');
		$("#docName").val('');
		$("#docVersion").val('');
		$("#attach_id1").val('');
		$('#show_add').show();
		$('#addButton').show();
		$('#updateButton').hide();
	}
    function chooseDocName(){	
	 	if($('#contractDocTab').datagrid('getSelections')[0]==null||$('#contractDocTab').datagrid('getSelections')[0].DOCNAME==""){
		     alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		}
	    else{    									
		    var name = $('#contractDocTab').datagrid('getSelections')[0].DOCNAME;
		    var id = $('#contractDocTab').datagrid('getSelections')[0].CONTRACTDOCID;
		    var docid=$('#contractDocTab').datagrid('getSelections')[0].DOCPATH
		    var vOpener=art.dialog.opener; 
		    
		    vOpener.document.getElementById("contractDocId").value=id;
		   
		    vOpener.document.getElementById("docName").value=name;
		    vOpener.document.getElementById("DocId").value=docid
		    vOpener.$('#contractHrefId').text(name);
		    
		    
		    	}	     	
	    //This a Function is not This Page,view addContractManager_1.jsp and editContractManager_1.jsp   
		//parent.closeWin(); 
		art.dialog.close() ;				 
	}
    function updateMethod(){       
    	//alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");	
    	if($('#contractDocTab').datagrid('getSelections')[0]==null||$('#contractDocTab').datagrid('getSelections')[0].CONTRACTDOCID==""){
         	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
        	}else{
        		var contractId = $('#contractDocTab').datagrid('getSelections')[0].CONTRACTDOCID ;
        		var contractName = $('#contractDocTab').datagrid('getSelections')[0].DOCNAME ;
        		var version = $('#contractDocTab').datagrid('getSelections')[0].DOCVERSION ;
        		var docPath = $('#contractDocTab').datagrid('getSelections')[0].DOCPATH ;
        		var resourcesAliss = $('#contractDocTab').datagrid('getSelections')[0].RESOURCEALISS ;
        		$("#contractId").val(contractId);
        		$("#resourceAliss").val(resourcesAliss);
        		$("#docName").val(contractName);
        		$("#docVersion").val(version);
        		$("#attach_id1").val(docPath);
        		$('#show_add').show();
        		$("#addButton").hide();
        		$("#updateButton").show();
		   		//window.location="deleteDoc.shtml?delDocId=" + contractId;
        	}
    }
    function downloadDocName(){       
    	if($('#contractDocTab').datagrid('getSelections')[0]==null||$('#contractDocTab').datagrid('getSelections')[0].DOCPATH==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
    	}
    	else{   
    		var docId = $('#contractDocTab').datagrid('getSelections')[0].DOCPATH ; 
			window.location="${contextPath}/fileShare/downloadFile.shtml?contentType=doc&fileShare.sFileId="+docId;		
    	} 	
    }
    function linkMessage(value,row,index){
  	  return "<a href='javascript:downloadDocName();'><font color='red'>"+value+"</font></a>";
    }
    function cleardata(str1,str2)
    {

    $("#"+str1).val(null);
    $("#"+str2).val(null);
    }
    function searchFunc() {
    	var form = $("#myForm").form();
    	$('#contractDocTab').datagrid("load", sy.serializeObject(form));
    }	
    function updateDoc(){
    	var docId = document.getElementById("contractId");
    	var docName = document.getElementById("docName");
		var docVersion = document.getElementById("docVersion");	
		var fileId = document.getElementById("attach_id1");		
		var resourceAlis = $("#resourceAliss").val();
		if(comm_validators_check('group1'))
       	{    		
       		if(fileId.value == ""){
       			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.selUpFile')}" />");
       			return;
       		}
    	window.location="fileUploadJson.shtml?contractDoc.docName="+docName.value+"&contractDoc.docVersion="+docVersion.value+"&contractDoc.docPath="+fileId.value+"&contractDoc.contractDocId="+docId.value+"&contractDoc.resourceAliss="+resourceAlis;	
    }
    }
    function isExit(){
    	//alert(obj);
    	var flag ;
    	$.ajax({
			type: "POST",
			async:false,
		    url: "${contextPath}/docManager/isExitDocName.shtml",
		    dataType:'json',
		    data:{name:$("#docName").val()},
			success:function(msg){ 
					 if(msg.retCode==1){
						flag = true;
					 }else{
						 flag = false;
					 }
              }
         });
    	return flag;
    }
    function isResAlissExit(){
    	var flag ;
    	$.ajax({
			type: "POST",
			async:false,
		    url: "${contextPath}/docManager/isResAlissExit.shtml",
		    dataType:'json',
		    data:{name:$("#resourceAliss").val()},
			success:function(msg){ 
					 if(msg.retCode==1){
						flag = true;
					 }else{
						 flag = false;
					 }
              }
         });
    	return flag;
    }
    function chechRemove(){
    	$('#btncut').remove();
    }
    
    function checkAll(){
    	var docName = $('#docName').val();
		var resourceAliss = $("#resourceAliss").val(); 
		var docVersion = $("#docVersion").val();
		var attach_id1 = $("#attach_id1").val();
		if("" ==  docName){
			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.docNameNotNull')}" />");
			return false;
		}
		if("" == resourceAliss){
			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.resourceAlissNotNull')}" />");
			return false;
		}
		if("" == docVersion){
			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.docVersionNotNull')}" />");
			return false;
		}
		if("" == attach_id1){
			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.selUpDocNotNull')}" />");
			return false;
		}
		if(!isExit()){
			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.docNameExist')}" />");
			return false;
		}
		if(!isResAlissExit()){
			alert("<s:property value="%{getText('eaap.op2.conf.contract.doc.resourceExist')}" />");
			return false;
		}
		return true;
    }
</script>     
	</head>    
	<body onload="chechRemove();">
	<div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0; clear:both;">
    <ui:form name="myForm"  id="myForm" method="post"> 
   			<dl>	
    				<dt><s:property value="%{getText('eaap.op2.conf.contract.doc.docName')}" />:</dt>	
    				<dd >
    				 	<ui:inputText skin="${contextStyleTheme}"  id="selDocName"  name="selDocName" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('selDocName','selDocName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				  
					</dd>
   			</dl>
   			<dl>		
    				<dt><s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" />:</dt>
    				<dd >
    					<ui:inputText skin="${contextStyleTheme}"  name="selDocVersion" id="selDocVersion"  style="float:left;"/>
    				  <input class="inputClearBtn" onclick="javascript:cleardata('selDocVersion','selDocVersion');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
					</dd>
   			</dl>
   			<dl>
    				<dt><s:property value="%{getText('eaap.op2.conf.contract.doc.resourceAliss')}" />:</dt>
    				<dd >
    				    <ui:inputText skin="${contextStyleTheme}"  id="selResAliss" name="selResAliss"  style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('selResAliss','selResAliss');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
					</dd>	
    		</dl>
    		
		<div style="text-align:center;float:center; margin-bottom:5px ;">
				<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
		 </div>
	</ui:form>
	</div>
	<div style=" clear:both;">
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="contractDocTab" remoteSort="false" sortOrder="desc"  toolbar="true"
		skin="${contextStyleTheme}"	fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.prov.docManager')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   method="eaap-op2-conf-contractDoc-DocAction.getContractDocList">		  
			<ui:gridEasyColumn width="80" index="0" title="0" field="DOCNAME" hidden="false" align="center" formatter="true" formatterMethod="linkMessage" ></ui:gridEasyColumn>
			<ui:gridEasyColumn width="80" index="1" title="1" field="DOCVERSION" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="50" index="2" title="2" field="DOCCREATETIME" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="20" index="3" title="3" field="STATE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="50" index="4" title="4" field="RESOURCEALISS" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="0" index="5" title="5" field="LASTESTTIME" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="30" index="6" title="6" field="CONTRACTDOCID" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="50" index="7" title="7" field="DOCPATH" hidden="false"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
		</div>
		</br>
		<div id="show_add" style="display:none;">
		<ui:form method="post" id="fileUploadJsonForm" action="fileUploadJson.shtml">
		<%--<ui:validators validateAlert="word" validatorGroup="group1">
			<ui:validator fieldId="docName" validatorType="stringlength" required="true" minLength="2" maxLength="25" trim="true" message="%{getText('eaap.op2.conf.prov.notexceed25char')}"/>	
			<ui:validator fieldId="docName" validatorType="fun"  required="true" expression="isExit" message="%{getText('eaap.op2.conf.prov.isExit')}"></ui:validator>
			<ui:validator fieldId="docVersion" validatorType="stringlength" required="true" minLength="2" maxLength="25" trim="true" message="%{getText('eaap.op2.conf.prov.notexceed25char')}"/>	
			
			<ui:validator fieldId="resourceAliss" validatorType="fun"  required="true" expression="isResAlissExit" message="%{getText('eaap.op2.conf.prov.isExit')}"></ui:validator>
		</ui:validators> --%>
		<table class="mgr-table" style="width:100%;font-size:12px;">
			<tr>
   				<td  align="right" width="12%">
   					<s:property value="%{getText('eaap.op2.conf.contract.doc.docName')}" />:
   				</td>	
   				<td >
   				   <ui:inputText id="contractId"  name="contractDoc.docId" skin="${contextStyleTheme}" type="hidden"/>
   				   <ui:inputText id="docName"  name="contractDoc.docName" skin="${contextStyleTheme}"/>
   				</td>
   				<td  align="right" width="12%">
   					<s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" />:
   				</td>	
   				<td >
   				   <ui:inputText id="docVersion"  name="contractDoc.docVersion" skin="${contextStyleTheme}"/>
   				</td>
   			</tr>	
			<tr>
   				<td align="right"  >
   					<s:property value="%{getText('eaap.op2.conf.contract.doc.selUpDoc')}" />:
   				</td>	
   				<td >
   				    <input type="hidden" name="file_after_name" id="file_after_name" />
   					<input id="attach_id1"  type="text"  name="mainAttach.hiddenSFileId" disabled="disabled"/>
                    <input type="file" name="uploadify" id="uploadify" />
				    &nbsp;&nbsp;
				    <a href="javascript:jQuery('#uploadify').uploadifyUpload()">
				    	<s:property value="%{getText('eaap.op2.conf.reseller.contract.beginUpload')}" />
				    </a>
				</td>
			    <td colspan="2">
			    <div class="clearfix" id="div_filecontainer"></div>
  					<div id="fileQueue"></div>
              		<p id="p_allcomplete" class="error-inform"></p>
			    </td>
			</tr>
			<tr>
			 <td  align="right" width="12%">
   					<s:property value="%{getText('eaap.op2.conf.contract.doc.resourceAliss')}" />:
   				</td>	
   				<td>
   				   <ui:inputText id="resourceAliss"  name="contractDoc.resourceAliss" skin="${contextStyleTheme}"/>
   				</td>
   				<td  colspan="2"></td>
			</tr>
  			<tr>
	   			<td colspan="4" align="center">
	   				<span id="addButton">
	   					<ui:button text="%{getText('eaap.op2.conf.prov.add')}" skin="${contextStyleTheme}" id="chooseCompId" onclick="javascript:addMehtodSubmit();"></ui:button>  
	   				</span>
	   				<span id="updateButton" style="display: none;">
	   					<ui:button text="%{getText('eaap.op2.conf.prov.update')}" skin="${contextStyleTheme}" id="chooseCompId" onclick="javascript:updateDoc();">
	   				</ui:button></span>		   				
	   		   </td>
    		</tr>	
    	</table>
  	</ui:form>	
   </div>
                    <div align="center">
	    				<ui:button text="%{getText('eaap.op2.conf.prov.define')}" skin="${contextStyleTheme}" id="chooseCompId" onclick="javascript:chooseDocName()"></ui:button>	                                		  					   				
	    				<input type="hidden" name="reqFrom" id="reqFrom" value="${reqFrom}"/>
	    		    </div>
<%@ include file="/common/ssoCommon.jsp"%>	 
	</body>

</html>
