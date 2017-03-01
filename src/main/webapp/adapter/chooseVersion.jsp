<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
	<title><s:property value="%{getText('contract version')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>	
	<script type="text/javascript" src="../resource/comm/adapter/GooFlow.js"></script>
	<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.adapter.contractName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.adapter.contractVersion')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.adapter.contractType')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.adapter.httpType')}" />';
	
	   //search Function
	function searchContract(){
		 var noTcpCtrFId = $("#noTcpCtrFId").val();
		 var form = $("#showContractForm").form();
		 form.action="chooseVersion.shtml?noTcpCtrFId=" + noTcpCtrFId;
	     $('#contractList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 					   
   }
   		 
   function addMehtod(){	  
   } 
             
  function updateMethod(){      
    }	 
    
  function clickMethod(index,field,value){   
	} 
  
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
<table>
   <tr>
     <td align="center">
	<div class="formLayout" style="padding:5px 0;">
	<ui:form id="showContractForm" method="post" action="chooseVersion.shtml">
	    <input id="ChooseContractName" name="ChooseContractName" type="hidden" value="${contractName}" />
	 	<input id="ChooseContractVersionName" name="ChooseContractVersionName" type="hidden" value="${contractVersionName}" />
	 	<input id="ChooseContractVersionId" name="ChooseContractVersionId" type="hidden" value="${contractVersionId}" />
	 	<input id="ChooseContractId" name="ChooseContractId" type="hidden" value="${contractId}" />
	 	<input id="ChooseTcpCtrFId" name="ChooseTcpCtrFId" type="hidden" value="${chooseTcpCtrFId}" />
	 	<input id="ChooseContractType" name="ChooseContractType" type="hidden" value="${contractType}" />
	 	<input id="ChooseReqRspFlag" name="ChooseReqRspFlag" type="hidden" value="${chooseReqRspFlag}" />
	 	<input id="loadSideFlg" name="loadSideFlg" type="hidden" value="${loadSideFlg}" />
	 	<input id="tcpCtrFId" name="tcpCtrFId" type="hidden" value="${tcpCtrFId}" />
	 	<input id="noTcpCtrFId" name="noTcpCtrFId" type="hidden" value="${noTcpCtrFId}" />
	 	<input id="reqRspFlag" name="reqRspFlag" type="hidden" value="${reqRspFlag}" />
   		<dl>	
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.adapter.contractName')}" />:
    				</dt>	
    				<dd style="text-align:left;">
    				   <ui:inputText id="contractName"  name="contractName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/>
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.adapter.contractVersion')}" />:
    				</dt>
    				<dd style="text-align:left;">
    					<ui:inputText id="contractVersion"  name="contractVersion"  readonly="false" skin="${contextStyleTheme}" />
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.adapter.contractType')}" />:
    				</dt>
    				<dd style="text-align:left;">
	    				<ui:select  
	    				name="contractType" 
	    				id="contractType"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="contractTypeList" 
	    			    listKey="key" 
	    			    listValue="value" 
	    			    style="width:70px;" 
	    			    skin="${contextStyleTheme}"
	    			    >
    			    </ui:select>
    				</dd>	
    		</dl>
    		<dl>		
    			<dt><s:property value="%{getText('eaap.op2.conf.adapter.httpType')}" />:</dt>	
    				<dd style="text-align:left;">
    				<ui:select  
	    				name="httpType" 
	    				id="httpType"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="httpTypeList" 
	    			    listKey="key" 
	    			    listValue="value" 
	    			    style="width:70px;" 
	    			    skin="${contextStyleTheme}"
	    			    >
    			    </ui:select>
    				</dd>  
    		</dl>
			<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchContract();" skin="${contextStyleTheme}"/>  
	</ui:form>
</div>
		</td>
	</tr>
   <tr>
     <td align="center">
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="contractList" remoteSort="false" sortOrder="desc"  onClickCell="false" queryParams="true" queryParamsData="${noTcpCtrFId}"
			skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.portal.prov.contractManage')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
			 fitHeight="320"   method="eaap-op2-conf-adapterAction.getContractAndVersionList">
			<ui:gridEasyColumn width="100" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="1" title="1" field="VERSION" hidden="false"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="2" title="2" field="CONTYPE" hidden="false"   align="center" formatter="true" formatterMethod="formatterForType"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="3" title="3" field="REQ_RSP" hidden="false"   align="center" ></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="4" title="4" field="VERSIONID" hidden="true"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="5" title="5" field="CONTRACTID" hidden="true"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="6" title="6" field="TCPCTRFID" hidden="false"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
		</td>
	</tr>
   <tr>
     <td align="center">
        <ui:button skin="${contextStyleTheme}" shape="M"  text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseContractId();"></ui:button>
        <ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
      </td>	
  </tr>
</table>
</div>
</body>
<script>
	function chooseContractId(){
	    var vOpener=window.art.dialog.opener;
	    var chooseContractName = $('#contractList').datagrid('getSelections')[0].NAME ;
	    var chooseContractVersionName = $('#contractList').datagrid('getSelections')[0].VERSION ;
	    var chooseContractVersionId = $('#contractList').datagrid('getSelections')[0].VERSIONID ;
	    var chooseContractId = $('#contractList').datagrid('getSelections')[0].CONTRACTID ;
	    var chooseTcpCtrFId = $('#contractList').datagrid('getSelections')[0].TCPCTRFID ;
	    var chooseContractType = $('#contractList').datagrid('getSelections')[0].CONTYPE ;
	    var chooseReqRspFlag = $('#contractList').datagrid('getSelections')[0].REQ_RSP ;
	    if(chooseContractName==""){
	      alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	     }
	    /*  此处为类型判断能
	    else if ($('#reqRspFlag').val() != "" 
	    		 && chooseReqRspFlag.toUpperCase() != $('#reqRspFlag').val().toUpperCase() 
	    		 && $('#ChooseContractName').val() == "tarContractName") {
	    	 alert("<s:property value="%{getText('eaap.op2.conf.adapter.chooseContractWarn1')}" />" 
	    			 + " " + $('#reqRspFlag').val().toUpperCase() + "."  
	    			 + "<s:property value="%{getText('eaap.op2.conf.adapter.chooseContractWarn3')}" />" );
		}else  if ($('#reqRspFlag').val() != "" 
		   		 && chooseReqRspFlag.toUpperCase() != $('#reqRspFlag').val().toUpperCase() 
				 && $('#ChooseContractName').val() == "srcContractName") {
			 alert("<s:property value="%{getText('eaap.op2.conf.adapter.chooseContractWarn2')}" />" 
					 + " " + $('#reqRspFlag').val().toUpperCase() + "."  
					 + "<s:property value="%{getText('eaap.op2.conf.adapter.chooseContractWarn3')}" />" );
		}*/
		else{
	    if($("#chooseContractName").attr('value')!="")
		 {
		  vOpener.document.getElementById($("#ChooseContractName").attr('value')).value=chooseContractName;
		  vOpener.document.getElementById($("#ChooseContractName").attr('value') + 'Script').value=chooseContractName;
		 }
		if($("#chooseContractVersionName").attr('value')!="")
		 {
		vOpener.document.getElementById($("#ChooseContractVersionName").attr('value')).value=chooseContractVersionName;
		vOpener.document.getElementById($("#ChooseContractVersionName").attr('value') + 'Script').value=chooseContractVersionName;
		 }
		if($("#chooseContractVersionId").attr('value')!="")
		 {
		 vOpener.document.getElementById($("#ChooseContractVersionId").attr('value')).value=chooseContractVersionId;
		 vOpener.document.getElementById($("#ChooseContractVersionId").attr('value') + 'Script').value=chooseContractVersionId;
		 }
		if($("#chooseContractId").attr('value')!="")
		 {
		 vOpener.document.getElementById($("#ChooseContractId").attr('value')).value=chooseContractId;
		 vOpener.document.getElementById($("#ChooseContractId").attr('value') + 'Script').value=chooseContractId;
		 }
		if($("#chooseTcpCtrFId").attr('value')!="")
		 {
		 vOpener.document.getElementById($("#ChooseTcpCtrFId").attr('value')).value=chooseTcpCtrFId;
		 vOpener.document.getElementById($("#ChooseTcpCtrFId").attr('value') + 'Script').value=chooseTcpCtrFId;
		 }
		if($("#ChooseContractType").attr('value')!="")
		 {
			chooseContractType = formatterForType(chooseContractType,0,0);
			if(chooseContractType != undefined){
				 vOpener.document.getElementById($("#ChooseContractType").attr('value')).value=chooseContractType;
				 vOpener.document.getElementById($("#ChooseContractType").attr('value') + 'Script').value=chooseContractType;
			 }
		 }
		if($("#ChooseReqRspFlag").attr('value')!="")
		 {
		 vOpener.document.getElementById($("#ChooseReqRspFlag").attr('value')).value=chooseReqRspFlag;
		 vOpener.document.getElementById($("#ChooseReqRspFlag").attr('value') + 'Script').value=chooseReqRspFlag;
		 }
		//vOpener.newGooflow();
		
		if ($('#loadSideFlg').val() == "L" ) {
			vOpener.cancleAllLine("L");
			vOpener.srcLoadDemo();
		} else {
			vOpener.cancleAllLine("R");
			vOpener.tarLoadDemo();
		}
		art.dialog.close(); 
	 }
 }
	
	function formatterForType(value,row,index){
	    if(value=='1'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.contractType1')}" />"  ;
	    }
	    else if(value=='2'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.contractType2')}" />"  ;
	    } 
	    else if(value=='3'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.contractType3')}" />"  ;
	    } 
	    else if(value=='4'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.contractType4')}" />"  ;
	    }
	    else if(value=='5'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.contractType5')}" />"  ;
	    } 
	    else if(value=='6'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.contractType6')}" />"  ;
	    }
	    else{
	    }
   }
	
	function formatterForHttp(value,row,index){
	    if(value.toUpperCase()=='REQ'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.request')}" />"  ;
	    }
	    else if(value.toUpperCase()=='RSP'){
	      return "<s:property value="%{getText('eaap.op2.conf.adapter.response')}" />"  ;
	    } 
   }
	
	$('#contractList').datagrid({onLoadSuccess : function(data){
		if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0) $('.panel-noscroll').attr('style','HEIGHT: 360px');
		var i = 0;
		$('.datagrid-row>td[field=TCPCTRFID]').each(function(){
			if($(this).text() == $('#tcpCtrFId').val()) {
				$('#contractList').datagrid('selectRow',i);
			}
			i++;
        })
	}});
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>