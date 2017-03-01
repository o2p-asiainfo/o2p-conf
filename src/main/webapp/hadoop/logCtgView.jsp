<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<link href="../resource/blue/css/easyui-comen.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>	
	
	<link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/ >
	<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>	
	<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.hadoop.contractionInteractionId')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.hadoop.logSeq')}"/>';
	title[2]='<s:property value="%{getText('eaap.op2.conf.hadoop.errCode')}"/>';
	title[3]='<s:property value="%{getText('eaap.op2.conf.hadoop.errMsg')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.hadoop.funName')}" />'; 
	title[5]='<s:property value="%{getText('eaap.op2.conf.hadoop.srcSysSign')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.hadoop.descriptor')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.hadoop.createDate')}" />'; 
	//title[8]='<s:property value="%{getText('eaap.op2.conf.hadoop.status')}" />';
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
	//	if($('#hadoopLogList').datagrid('getSelections')[0]==null){
	     	//alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		//}else{
    	//	var rowkeyValue = $('#hadoopLogList').datagrid('getSelections')[0].rowkeyValue ;
    	    //window.location="gotoCtgDetail.shtml?rowkeyValueCI=" + rowkeyValue;	
	    //} 
	} 
	             
	function updateMethod(){
	}	 
	    
	function clickMethod(index,field,value){   
		if($('#hadoopLogList').datagrid('getSelections')[0]!=null){
    		var rowkeyValue = $('#hadoopLogList').datagrid('getSelections')[0].rowkeyValue ;
    	    window.location="gotoCtgDetail.shtml?rowkeyValueCI=" + rowkeyValue;	
	    } 
	} 
	
	function formatterCIId(value,row,index){
	    return "<a href='${contextPath}/hadoopLog/gotoCtgDetail.shtml?rowkeyValueCI="+row.rowkeyValue+"'>"+value+"</a>" ;
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
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.logSeq')}" />:</dt>	
    				<dd><ui:inputText id="logSeq"  name="logSeq"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    		</dl>
    		<dl>		
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.funName')}" />:</dt>	
    				<dd><ui:inputText id="funName"  name="funName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    		</dl>
    		<dl>		
    				<dt><s:property value="%{getText('eaap.op2.conf.hadoop.errCode')}" />:</dt>	
    				<dd><ui:inputText id="errCode"  name="errCode"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    		</dl>
    		<dl>			
	     			<dt><s:property value="%{getText('eaap.op2.conf.hadoop.createDate')}" />:</dt>	
     				<dd>
		     				<div style="float:left; width:123px;">
		    					<input type="text" id="startCreateDate" name="startCreateDate" value="${beginReqTime}" style="width:123px; height:30px; border:1px solid #ccc; cursor:pointer;"/> 
		    				</div>
		    				<div style="float:left;font-size:12px;">~</div>
		     				<div style="float:left; width:123px;">
		     					<input type="text" id="endCreateDate" name="endCreateDate" value="${endReqTime}" style="width:123px; height:30px; border:1px solid #ccc; cursor:pointer;"/> 
		      		 					</div>
					</dd>	 
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
			<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchTask();" skin="${contextStyleTheme}"/>
	</ui:form>
</div>
<div style="clear:both;">   
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="hadoopLogList"  remoteSort="false" sortOrder="desc"  
	fit="true" collapsible="true" title="" pageInfo="true"  striped="true" pageSize="10" pagination="true" frozenColumns="true" toolbar="false" rownumbers="true"  
	queryParams="true"  queryParamsData="{bSrcReqTime:\"${beginReqTime}\",eSrcReqTime:\"${endReqTime}\"}" 
	method="eaap-op2-conf-hadoop-action-hadoopLogAction.getHadoopCtgList">
			
			<ui:gridEasyColumn width="260" index="0" title="0" field="contractionInteractionId" hidden="false"   align="center" formatter="true" formatterMethod="formatterCIId"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="1" title="1" field="logSeq" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="150" index="2" title="2" field="errCode" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="120" index="3" title="3" field="errMsg" hidden="false" align="center" ></ui:gridEasyColumn>
			<ui:gridEasyColumn width="180" index="4" title="4" field="funName" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="180" index="5" title="5" field="srcSysSign" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="160" index="6" title="6" field="descriptor" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="180" index="7" title="7" field="createDate" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="8" title="8" field="rowkeyValue" hidden="true"   align="center"></ui:gridEasyColumn>
	</ui:gridEasy> 
</div>
</div>
</div>
<script>
	$(document).ready(function(){
		var detail='<s:property value="%{getText('eaap.op2.conf.hadoop.detail')}" />';
	  $('#btnadd span span').text(detail).removeClass().addClass("l-btn-text icon-remove l-btn-icon-left");
	  $('#btncut').text("");
	  $('#btnsave').text("");
	  $('.datagrid-btn-separator').removeClass();
	  id="bSrcReqTime" name="bSrcReqTime" value="${beginReqTime}"
	});
</script>
<script>
	$(document).ready(function(){
	  $('#startCreateDate').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i',
			onShow:function(ct){
				this.setOptions({
					maxDate:getDateLimit('#endCreateDate'),
					maxTime:getTimeLimit('#endCreateDate',ct)
				});
			},
			onChangeDateTime:function(ct) {
				this.setOptions({
					maxTime:getTimeLimit('#endCreateDate',ct)
				});
			}
		});
		$('#endCreateDate').datetimepicker({
			value:'${searchTime}',
			step:10,
			format:'Y-m-d H:i',
			onShow:function(ct){
				this.setOptions({
					minDate:getDateLimit('#startCreateDate'),
					minTime:getTimeLimit('#startCreateDate',ct)
				});
			},
			onChangeDateTime:function(ct){
				this.setOptions({
					minTime:getTimeLimit('#startCreateDate',ct)
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