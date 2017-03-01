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
	<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>	
    <link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/>
    
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>		
	<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.hadoop.contractInteractionId')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.hadoop.contractVersion')}"/>';
	title[2]='<s:property value="%{getText('eaap.op2.conf.hadoop.srcTranId')}"/>';
	title[3]='<s:property value="%{getText('eaap.op2.conf.hadoop.serviceLevel')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.hadoop.srcSysCode')}" />'; 
	title[5]='<s:property value="%{getText('eaap.op2.conf.hadoop.dstSysCode')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.hadoop.srcReqTime')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.hadoop.responseCode')}" />'; 
	title[8]='<s:property value="%{getText('eaap.op2.conf.hadoop.status')}" />';
	   //search Function
	function searchTask(){
		if($('#dataSourceId').val()==null||$('#dataSourceId').val()==""){
			alert('<s:property value="%{getText('eaap.op2.conf.logserver.notnull.dataSourceName')}" />');
		}else{
			var form = $("#showhadoopLogForm").form();
	    	$('#hadoopLogList').datagrid("load", sy.serializeObject(form));		   
		}
	}

	function deleteMethod(){ 					   
	  
	}
	   		 
	function addMehtod(){	  
		if($('#hadoopLogList').datagrid('getSelections')[0]==null){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		}else{
    		var rowkeyValue = $('#hadoopLogList').datagrid('getSelections')[0].rowkeyValue ;
    	    window.location="gotoCIDetail.shtml?rowkeyValueCI=" + rowkeyValue;	
	    } 
	} 
	             
	function updateMethod(){   
	     
	}	 
	    
	function clickMethod(index,field,value){   
		if($('#hadoopLogList').datagrid('getSelections')[0]!=null){
    		var rowkeyValue = $('#hadoopLogList').datagrid('getSelections')[0].rowkeyValue ;
    	    window.location="gotoCIDetail.shtml?rowkeyValueCI=" + rowkeyValue;	
	    } 
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
	function formatterCIId(value,row,index){
   
	    return "<a href='${contextPath}/hadoopLog/gotoCIDetail.shtml?rowkeyValueCI="+row.rowkeyValue+"'>"+value+"</a>" ;
 		
	}
	function formatterForStatus(value,row,index){
		 if(value=='N'){
	      return "<s:property value="%{getText('eaap.op2.conf.hadoop.statusN')}" />"  ;
	    } else if(value=='MT'){
	      return "<s:property value="%{getText('eaap.op2.conf.hadoop.statusMT')}" />"  ;
	    } else if(value=='AT'){
	      return "<s:property value="%{getText('eaap.op2.conf.hadoop.statusAT')}" />"  ;
	    }else{
	    	return value;
	    }
	}
	function cleardata(str1,str2){
	
		$("#"+str1).val(null);
		$("#"+str2).val(null);
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
		      		<s:property value="%{getText('eaap.op2.conf.hadoop.hadoopCILog')}" />      
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
	<ui:form id="showhadoopLogForm" method="post" >
    		<dl>	
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.contractVersion')}" />:</dt>
					<dd>
					  <input id="contractVersionID" name="contractVersionID" type="hidden" />
					  <input id="protocol" name="protocol" type="hidden" />
					  <ui:inputText skin="${contextStyleTheme}" name="contractVersion" id="contractVersion"   readonly="true" style="float:left;"></ui:inputText>
					   <input class="inputClearBtn" onclick="javascript:cleardata('contractVersionID','contractVersion');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
 						<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/contractManager/showContractAndVersion.shtml?contractName=protocol&&contractVersionName=contractVersion&&contractVersionID=contractVersionID','%{getText('eaap.op2.conf.hadoop.chooseContractVersion')}')" shape="s"></ui:button> 
					</db>
    		</dl>
    		<dl>		
    				<dt style="line-height:15px;"><s:property value="%{getText('eaap.op2.conf.hadoop.srcTranId')}" />:</dt>	
    				<dd><ui:inputText id="srcTranId"  name="srcTranId"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('eaap.op2.conf.hadoop.srcSysCode')}" />:
    					 
    				</dt>
    				<dd >
    				    <ui:inputText skin="${contextStyleTheme}"  id="srcSysCodeName" name="srcSysCodeName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('srcSysCodeName','srcSysCode');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="srcSysCode" name="srcSysCode"/>
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=srcSysCodeName&chooseComponentCode=srcSysCode','%{getText('eaap.op2.conf.hadoop.chooseComponent')}')" shape="s"></ui:button>
					</db>	
    		</dl>
    		<dl>		
    				<dt style="line-height:15px;"><s:property value="%{getText('eaap.op2.conf.hadoop.dstSysCode')}" />:</dt>
    				<dd >
    				    <ui:inputText skin="${contextStyleTheme}"  id="dstSysCodeName" name="dstSysCodeName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('dstSysCodeName','dstSysCode');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="dstSysCode" name="dstSysCode"/>                                   
			 
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=dstSysCodeName&chooseComponentCode=dstSysCode','%{getText('eaap.op2.conf.hadoop.chooseComponent')}')" shape="s"></ui:button>
					</db>	
    		</dl>
    		<dl>			
	     			<dt><s:property value="%{getText('eaap.op2.conf.hadoop.srcReqTime')}" />:</dt>	
     				<dd>
		     				<div style="float:left">
		     					<input type="text" id="bSrcReqTime" name="bSrcReqTime" value="${beginReqTime}" style="width:120px; height:30px; border:1px solid #ccc; cursor:pointer;" readonly/> 
		    				</div>
		    				<div style="float:left">~</div>
		    				<div style="float:left">
		    					<input type="text" id="eSrcReqTime" name="eSrcReqTime" value="${endReqTime}" style="width:120px; height:30px; border:1px solid #ccc; cursor:pointer;" readonly/>
		 					</div>
					</dd>	 
    		</dl>
    		<dl style="width:375px;">		
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.responseCode')}" />:</dt>	
    				<dd style="width:220px;"><ui:inputText id="responseCode"  name="responseCode"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    		</dl>
    		<dl>		
    			<dt style="line-height:15px;">
    				<s:property value="%{getText('eaap.op2.conf.logserver.dataSourceName')}" />:
    			</dt>	
    			<dd>
    				<ui:select skin="${contextStyleTheme}"  name="dataSourceId" id="dataSourceId"   emptyOption="false" headerValue=""
   			        list="dataSourceList" listKey="dataSourceId" listValue="dataSourceName" style="float:left;" ></ui:select>
    			</dd>	
    		</dl>
			<div style="float: right;">		
				<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchTask();" skin="${contextStyleTheme}"/>
			</div>
	</ui:form>
</div>
<div style="clear:both;">  
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="hadoopLogList"  remoteSort="false" sortOrder="desc"  
	fit="true" collapsible="true" title="" pageInfo="true"  striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="false" rownumbers="true"   
	queryParams="true"  queryParamsData="{bSrcReqTime:\"${beginReqTime}\",eSrcReqTime:\"${endReqTime}\"}"
	method="eaap-op2-conf-hadoop-action-hadoopLogAction.getHadoopCIList">
			<ui:gridEasyColumn width="260" index="0" title="0" field="contractInteractionId" hidden="false"   align="center" formatter="true" formatterMethod="formatterCIId"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="1" title="1" field="contractVersion" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="2" title="2" field="srcTranId" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="3" title="3" field="serviceLevel" hidden="false" align="center" ></ui:gridEasyColumn>
			<ui:gridEasyColumn width="180" index="4" title="4" field="srcSysCode" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="180" index="5" title="5" field="dstSysCode" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="160" index="6" title="6" field="srcReqTime" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="180" index="7" title="7" field="responseCode" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="8" title="8" field="rowkeyValue" hidden="true"   align="center"></ui:gridEasyColumn>
	</ui:gridEasy> 
</div>
</div>
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
<script>
	$(document).ready(function(){
	  $('#bSrcReqTime').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i',
			onShow:function(ct){
				this.setOptions({
					maxDate:getDateLimit('#eSrcReqTime'),
					maxTime:getTimeLimit('#eSrcReqTime',ct)
				});
			},
			onChangeDateTime:function(ct) {
				this.setOptions({
					maxTime:getTimeLimit('#eSrcReqTime',ct)
				});
			}
		});
		$('#eSrcReqTime').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i',
			onShow:function(ct){
				this.setOptions({
					minDate:getDateLimit('#bSrcReqTime'),
					minTime:getTimeLimit('#bSrcReqTime',ct)
				});
			},
			onChangeDateTime:function(ct){
				this.setOptions({
					minTime:getTimeLimit('#bSrcReqTime',ct)
				});
			}
		});
	});
	
	function getDateLimit(idString){
		//maxDate minDate 
		//valid format: new Date(), '1986/12/08', '-1970/01/05','-1970/01/05'
		//invalid format: '1986-01-01'
		return $(idString).val() ? $(idString).val().replace("-", "/").replace("-", "/").substring(0,10) : false;
	}
	function getTimeLimit(idString,ct){
		if($(idString).val() && ct && date2String(ct,"-")==$(idString).val().substring(0,10)){
			return $(idString).val().substring(11,16);
		}else{
			return false;
		}
	}
	function date2String(datetime,split){
		var date = new Date(datetime);
		var year = date.getFullYear();
		var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
		var date = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
		return year + split + month + split + date;
	}
</script> 
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>