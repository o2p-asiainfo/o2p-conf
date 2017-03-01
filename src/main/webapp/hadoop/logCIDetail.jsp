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
	title[0]='<s:property value="%{getText('eaap.op2.conf.hadoop.endpointInteractionId')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.hadoop.endpointId')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.hadoop.createDate')}"/>';
	title[3]='<s:property value="%{getText('eaap.op2.conf.hadoop.reqOrRes')}" />';

	function searchTask(){		
		 var form = $("#showhadoopLogForm").form();
	      $('#hadoopLogList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 					   
	  
	}
	   		 
	function addMehtod(){	  
		if($('#hadoopLogList').datagrid('getSelections')[0]==null){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		}else{
   		var rowkeyValue  = $('#hadoopLogList').datagrid('getSelections')[0].rowkeyValue ;
   	    //window.location="gotoEIDetail.shtml?contractInteractionId=${resultMap.contractInteractionId}&endpointInteractionId=" + endpointInteractionId;	
		openWindows('${contextPath}/hadoopLog/gotoEIDetail.shtml?rowkeyValueEI=' + rowkeyValue,'Detail');

		} 

	} 
	             
	function updateMethod(){   
	     
	}	 
	    
	function clickMethod(index,field,value){   
	
	} 
	
	function closecurry(){
		
	}
	function formatterForState(value,row,index){
	    if(value=='1'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType1')}" />"  ;
	    } else if(value=='2'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType2')}" />"  ;
	    } else if(value=='3'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType3')}" />"  ;
	    } else if(value=='4'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType4')}" />"  ;
	    } else if(value=='5'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType5')}" />"  ;
	    } else if(value=='6'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType6')}" />"  ;
	    } else if(value=='7'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType7')}" />"  ;
	    } else if(value=='8'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType8')}" />"  ;
	    } else if(value=='9'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType9')}" />"  ;
	    } else if(value=='10'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.evenType10')}" />"  ;
	    }
	 }
	function formatterForLogState(value,row,index){
	    if(value=='1'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.logType1')}" />"  ;
	    }else if(value=='2'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.logType2')}" />"  ;
	    }
	 }
    function returnPage() {
		window.location="showHadoopCI.shtml";
    }
	function formatterEIId(value,row,index){
	    return "<a href='${contextPath}/hadoopLog/gotoEIDetail.shtml?rowkeyValueEI="+row.rowkeyValue+"'>"+value+"</a>" ;
 		
	}
	function openWindowsFun(url){
		openWindows(url+"&pageShowMsg=true",'Detail');
	}
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/search.png" />   
		      <s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      <s:property value="%{getText('eaap.op2.conf.hadoop.hadoopCILog')}" />  
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
	     	  <s:property value="%{getText('eaap.op2.conf.hadoop.hadoopCILogDetail')}" />
	      	</div>
	    </div> 
	   <div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         		</div>       
    	   </div>
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.contractInteractionId')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.contractInteractionId1" id="contractInteractionId1" readonly="true"  value="${resultMap.contractInteractionId}" skin="${contextStyleTheme}"/>
	   				<ui:inputText name="resultMap.contractInteractionId" id="contractInteractionId" disabled="true" type="hidden" value="${resultMap.contractInteractionId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.bizFuncCode')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.bizFuncCode" id="bizFuncCode" readonly="true" value="${resultMap.bizFuncCode}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.bizIntfCode')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.bizIntfCode" id="bizIntfCode" readonly="true" value="${resultMap.bizIntfCode}" skin="${contextStyleTheme}"/>
	   				<a href="#" onclick="openWindowsFun('${contextPath}/serviceManager/showUpdateServiceData.shtml?serviceId=${resultMap.bizIntfId}')">View</a>	
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.contractVersion')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.contractVersion" id="contractVersion" readonly="true" value="${resultMap.contractVersion}" skin="${contextStyleTheme}"/>
	  				<a href="#" onclick="openWindowsFun('${contextPath}/serviceManager/showUpdateServiceData.shtml?serviceId=${resultMap.bizIntfId}')">View</a>		  	  				
	   			</td>
		   	</tr>				  
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.regSerCode')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.regSerCode" id="regSerCode" readonly="true" value="${resultMap.regSerCode}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.regSerVersion')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.regSerVersion" id="regSerVersion" readonly="true" value="${resultMap.regSerVersion}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcTranId')}" />:</td>
	   			<td>
	   			    <ui:inputText name="resultMap.srcTranId" id="srcTranId" readonly="true" value="${resultMap.srcTranId}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstTranId')}" />:</td>
	  			<td>
	  			    <ui:inputText name="resultMap.dstTranId" id="dstTranId" readonly="true" value="${resultMap.dstTranId}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.serviceLevel')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.serviceLevel" id="serviceLevel" readonly="true" value="${resultMap.serviceLevel}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcOrgCode')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.srcOrgCode" id="srcOrgCode" readonly="true" value="${resultMap.srcOrgCode}" skin="${contextStyleTheme}"/>
	  				<a href="#" onclick="openWindowsFun('${contextPath}/mgr/queryOrgInfo.shtml?tmpType=edit&content_Id=${resultMap.srcOrgId}')">View</a>		   			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstOrgCode')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.dstOrgCode" id="dstOrgCode" readonly="true" value="${resultMap.dstOrgCode}" skin="${contextStyleTheme}"/>
	   				<a href="#" onclick="openWindowsFun('${contextPath}/mgr/queryOrgInfo.shtml?tmpType=edit&content_Id=${resultMap.dstOrgId}')">View</a>		
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcSysCode')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.srcSysCode" id="srcSysCode" readonly="true" value="${resultMap.srcSysCode}" skin="${contextStyleTheme}"/>	  	
	  				<a href="#" onclick="openWindowsFun('${contextPath}/component/preAddCompInfo.shtml?tmpType=edit&component.componentId=${resultMap.srcSysId}')">View</a>	
	   			</td>
		   	</tr>
			<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstSysCode')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.dstSysCode" id="dstSysCode" readonly="true" value="${resultMap.dstSysCode}" skin="${contextStyleTheme}"/>
	   				<a href="#" onclick="openWindowsFun('${contextPath}/component/preAddCompInfo.shtml?tmpType=edit&component.componentId=${resultMap.dstSysId}')">View</a>	
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.testFlag')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.testFlag" id="testFlag" readonly="true" value="${resultMap.testFlag}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcReqTime')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.srcReqTime" id="srcReqTime" readonly="true" value="${resultMap.srcReqTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.centerRecReqTime')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.centerRecReqTime" id="centerRecReqTime" readonly="true" value="${resultMap.centerRecReqTime}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.centerFwd2DstTime')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.centerFwd2DstTime" id="centerFwd2DstTime" readonly="true" value="${resultMap.centerFwd2DstTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstRecTime')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.dstRecTime" id="dstRecTime" readonly="true" value="${resultMap.dstRecTime}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.dstReplyTime')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.dstReplyTime" id="dstReplyTime" readonly="true" value="${resultMap.dstReplyTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.centerRecDstTime')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.centerRecDstTime" id="centerRecDstTime" readonly="true" value="${resultMap.centerRecDstTime}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.centerFwd2SrcTime')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.centerFwd2SrcTime" id="centerFwd2SrcTime" readonly="true" value="${resultMap.centerFwd2SrcTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcConfirmTime')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.srcConfirmTime" id="srcConfirmTime" readonly="true" value="${resultMap.srcConfirmTime}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcResponseTime')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.srcResponseTime" id="srcResponseTime" readonly="true" value="${resultMap.srcResponseTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.responseType')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.responseType" id="responseType" readonly="true" value="${resultMap.responseType}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   			   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.responseCode')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.responseCode" id="responseCode" readonly="true" value="${resultMap.responseCode}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.responseDes')}" />:</td>
	  			<td width="35%">
	  				<ui:inputText name="resultMap.responseDes" id="responseDes" readonly="true" value="${resultMap.responseDes}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.srcIp')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.srcIp" id="srcIp" readonly="true" value="${resultMap.srcIp}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.inputFileNum')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.inputFileNum" id="inputFileNum" readonly="true" value="${resultMap.inputFileNum}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.outputSuccessFileNum')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.outputSuccessFileNum" id="outputSuccessFileNum" readonly="true" value="${resultMap.outputSuccessFileNum}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.outputErrFileNum')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.outputErrFileNum" id="outputErrFileNum" readonly="true" value="${resultMap.outputErrFileNum}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.hadoop.createTime')}" />:</td>
	   			<td width="35%">
	   				<ui:inputText name="resultMap.createTime" id="createTime" readonly="true" value="${resultMap.createTime}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"></td>
	  			<td width="35%">
	   			</td>
		   	</tr>

 		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.exceptionMessage')}" />:</td>
		   		<td colspan=3>
		   			<ui:textarea id="info" name="resultMap.exceptionMessage" value="${resultMap.exceptionMessage}" width="600" height="150" skin="${contextStyleTheme}"/> 																				
	   			</td>
	   		</tr>
	   		<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.hadoop.content')}" />:</td>
		   		<td colspan=3>
		   			<ui:textarea id="info" name="resultMap.content" value="${resultMap.content}" width="600" height="150" skin="${contextStyleTheme}"/> 																				
	   			</td>
	   		</tr>
		    </table>
		    
			<dl class="noBorder">	
			<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="hadoopLogList"  remoteSort="false" sortOrder="desc"  
				fit="true" collapsible="true"   pageInfo="true"  title="%{getText('eaap.op2.conf.hadoop.hadoopEILog')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="true" rownumbers="true"  
				queryParams="true" queryParamsData="${rowkeyValueCI}"
				 method="eaap-op2-conf-hadoop-action-hadoopLogAction.getHadoopEIList" >
				
				<ui:gridEasyColumn width="260" index="0" title="0" field="endpointInteractionId" hidden="false" align="center" formatter="true" formatterMethod="formatterEIId"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="260" index="1" title="1" field="endpointId" hidden="false"   align="center" ></ui:gridEasyColumn>
				<ui:gridEasyColumn width="200" index="2" title="2" field="createDate" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="200"  index="3" title="3" field="reqOrRes" hidden="false" align="center" ></ui:gridEasyColumn>
		  		<ui:gridEasyColumn width="200" index="4" title="6" field="rowkeyValue" hidden="true"   align="center"></ui:gridEasyColumn>
		  		</ui:gridEasy> 
		
			</dl>
		 
			 <table align="center" class="mgr-table">
					<tr>	
					  	<td  colspan="4"  align="center">
				  <ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="history.go(-1);"></ui:button>   				       
						</td>
					</tr>
			  </table>
		</div>	
<script>
	$(document).ready(function(){
		var detail='<s:property value="%{getText('eaap.op2.conf.hadoop.detail')}" />';
		  $('#btnadd span span').text(detail)
	                        .removeClass()
	                        .addClass("l-btn-text icon-remove l-btn-icon-left");
	  $('#btncut').text("");
	  $('#btnsave').text("");
	  $('.datagrid-btn-separator').removeClass();
	});
</script>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>