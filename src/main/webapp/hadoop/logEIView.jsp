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
	title[0]='<s:property value="%{getText('eaap.op2.conf.hadoop.srcTranId')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.hadoop.dstTranId')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.hadoop.serviceId')}" />'; 
	title[3]='<s:property value="%{getText('eaap.op2.conf.hadoop.endpointId')}" />';
 
		
	   //search Function
	function searchTask(){		
		 var form = $("#showhadoopLogForm").form();
	      $('#hadoopLogList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 					   
	  
	}
	   		 
	function addMehtod(){	  
		if($('#hadoopLogList').datagrid('getSelections')[0]==null||$('#hadoopLogList').datagrid('getSelections')[0].endpointInteractionId==""){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		}else{
    		var endpointInteractionId  = $('#hadoopLogList').datagrid('getSelections')[0].endpointInteractionId ;
    	    window.location="gotoEIDetail.shtml?endpointInteractionId=" + endpointInteractionId;	
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
		      		<s:property value="%{getText('eaap.op2.conf.hadoop.hadoopEILog')}" />      
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="selectList" style="display:block;">
	<ui:form id="showhadoopLogForm" method="post" >
        	<div style="margin:0px 0px 10px 0px"></div>
    		<dl class="noBorder">
	    	</dl>
	       <dl class="noBorder">	
	       	     <dc>
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.srcTranId')}" />:</dt>	
    				<dd><ui:inputText id="srcTranId"  name="srcTranId"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
	     		</dc>
	       		<dc>
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.dstTranId')}" />:</dt>	
    				<dd><ui:inputText id="dstTranId"  name="dstTranId"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
	     		</dc>
	     		<dc>
	     			<dt><s:property value="%{getText('eaap.op2.conf.hadoop.serviceId')}" />:</dt>	
    				<dd><ui:inputText id="serviceId"  name="serviceId"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
	     		</dc>
	     		<dc>
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.endpointId')}" />:</dt>	
    				<dd><ui:inputText id="endpointId"  name="endpointId"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
	     		</dc>
	     	</dl>
	     	<dl class="noBorder">
				<dd></dd><dd></dd><dd></dd><dt></dt>		
						<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchTask();" skin="${contextStyleTheme}"/>
	
			</dl>
	</ui:form>

	<dl class="noBorder">	
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="hadoopLogList"  remoteSort="false" sortOrder="desc"  
		fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="true" rownumbers="true"  
		 method="eaap-op2-conf-hadoop-action-hadoopLogAction.getHadoopEIList">
		
		
		<ui:gridEasyColumn width="120" index="0" title="0" field="srcTranId" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80"  index="1" title="1" field="dstTranId" hidden="false" align="center" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="2" title="2" field="serviceId" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="3" title="3" field="endpointId" hidden="false"   align="center"></ui:gridEasyColumn>
  		<ui:gridEasyColumn width="200" index="4" title="4" field="endpointInteractionId" hidden="true"   align="center"></ui:gridEasyColumn>
  		</ui:gridEasy> 

	</dl>
	 </div>
   </div>
</div>
<script>
	$(document).ready(function(){
	  $('#btnadd span span').text("Detail")
	                        .removeClass()
	                        .addClass("l-btn-text icon-remove l-btn-icon-left");
	  $('#btncut').text("");
	  $('#btnsave').text("");
	  $('.datagrid-btn-separator').removeClass();
	});
</script>

</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>