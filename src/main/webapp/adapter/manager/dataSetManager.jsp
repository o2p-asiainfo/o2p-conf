<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" import="java.lang.*" pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/orange/css/console.css">	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>	
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/json2.js"></script>
</head>
<body>
<ui:form method="post" id="dataSetForm" name="dataSetForm" action="/adapter/toDataSetManager.shtml">
	<div class="contentWarp">
	   <div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item" width="20%">Query SQL:</td>
	  			<td class="item-content" width="40%">
	  				<ui:inputText skin="${contextStyleTheme}" name="query_SQL" id="query_SQL" textSize="19"></ui:inputText>
	   			</td>
	   			<td colspan="2" style="TEXT-ALIGN: right;PADDING-RIGHT:30px; " width="40%">
					<ui:button skin="${contextStyleTheme}" text="Query" onclick="queryDataSetList()"></ui:button>	
	    		</td>	
	   		</tr>
	    </table>
	    <input type="hidden" id="selectData_Set_Id" name="selectData_Set_Id" value="" />	       	   
	 	<table class="list-table" cellpadding="1" cellspacing="0" id="dataSetTab">
			<tr class="tab-header">
				<td class="middle" style="width:5%">&nbsp;</td>
   				<td class="middle" style="width:5%">DataSource ID</td>
   				<td class="middle" style="width:10%">Datasource type</td>
   				<td class="middle" style="width:55%">Query SQL</td>
   				<td class="middle" style="width:20%">Remark</td>
   				<td class="middle" style="width:5%">State</td>
   			</tr>  			
   			<c:choose>
   				<c:when test="${fn:length(dataSetList)<1}">
   					<tr class="even" align="center">
   						<td colspan="6">No data</td>
   					</tr>
	     		</c:when>
	     		<c:otherwise>
	     			<c:forEach items="${dataSetList}" var="dataSet" varStatus="status" step="1" >
	     				<tr class="even" rowId="${dataSet.DATA_SET_ID}" id="tr${dataSet.DATA_SET_ID}">
	     					<input type="hidden" id="query_SQL_${dataSet.DATA_SET_ID}" value="${dataSet.QUERY_SQL}" />
	     					<td class="middle">
	     					<input  type="radio" name="radioBtn" 
	     						value="${dataSet.DATA_SET_ID}" 
	     						onclick="selectData_Set_Id.value='${dataSet.DATA_SET_ID}';"/>
	     					</td>
		    				<td class="middle" id="cellDataSourceId_${dataSet.DATA_SET_ID}">${dataSet.DATA_SET_ID}
		    				</td>
		    				<td class="middle" id="cellDataSourceType_${dataSet.DATA_SET_ID}">
		    				<span >${dataSet.DATA_SOURCE_TYPE}</span> 
		    				<ui:inputText skin="${contextStyleTheme}" name="DATA_SOURCE_TYPE" style="display:none;" value="${dataSet.DATA_SOURCE_TYPE}"  textSize="12" />
		    				</td>
		    				<td class="middle" id="cellQuery_SQL_${dataSet.DATA_SET_ID}">
		    				<span >${dataSet.QUERY_SQL}</span> 
		    				<ui:inputText skin="${contextStyleTheme}" name="QUERY_SQL" style="display:none;" value="${dataSet.QUERY_SQL}"  textSize="80" />
		    				</td>
		    				<td class="middle" id="cellRemarks_${dataSet.DATA_SET_ID}">
		    				<span >${dataSet.REMARKS}</span> 
		    				<ui:inputText skin="${contextStyleTheme}" name="REMARKS" style="display:none;" value="${dataSet.REMARKS}"  textSize="30" />
		    				</td>
		    				<td class="middle" id="cellState_${dataSet.DATA_SET_ID}">
		    				<s:select list="adapterStateList"  listKey="code" disabled="true" listValue="name" name="STATE"/>
		    				</td>		    				
		    			</tr>
	     			</c:forEach>
	     		</c:otherwise>
    		</c:choose>
    		<tr class="even" align="left">
   				<td colspan="8" style="PADDING-LEFT:30px;">
					<ui:button skin="${contextStyleTheme}" text="Choose" onclick="parent.setDataSetValue(selectData_Set_Id.value);"></ui:button>					
					<ui:button skin="${contextStyleTheme}" text="Add" onclick="addDataSetRow()"></ui:button>		
					<ui:button skin="${contextStyleTheme}" text="Modify" onclick="modifyDataSet()"></ui:button>	
					<ui:button skin="${contextStyleTheme}" text="Delete" onclick="delDataSet()"></ui:button>		
   				</td>
   			</tr>
	    </table>    
   		<div style="position:relative;float:right;botton:0;margin-top:10px;top:auto;clear:both;">
		   	<ui:page id="page"/>
	    </div>	
  
	     <br/>
	   </div>
	</div>
 </ui:form>
<script type="text/javascript">
	var $dataSourceSel = $('#dataSourceSel');  
	var _tmpRows = $('tr.even[rowId]');
	function saveDataSet(dsArray){
		var _dataStr = JSON.stringify(dsArray);
		
		$.ajax({
			   url: "${contextPath}/adapter/saveDataSet.shtml?random="+(Math.random()*100000000),
			   data: _dataStr,
			   type:'POST',
			   async:false,
			   contentType:'text/plain; charset=UTF-8',
			   cache:false,
			   beforeSend:function(){
				 //submit tip message  
			   },
			   dataType:'json',
			   success: function(data){
				   //refresh the page
				   location.reload();
			   }
			 });
	}
	_tmpRows.click(function(){
		var _trId = this.id;
		var _newRows = $('tr.even[rowFlag]');
		var _dataSets = [];
		_newRows.each(function (index, domEle) {
	          // domEle == this
	          var ds = {};
	          var _r = $(domEle);
	          var _trEditId = _r.attr('id');
	          if(_trId==_trEditId){
	        	  //the row may be editing
	        	  return ;
	          }
	          var _id = _r.attr('rowId');
	          var _dataSourceType = _r.find('[name="DATA_SOURCE_TYPE"]')[0].value;
	          var _querySql = _r.find('[name="QUERY_SQL"]')[0].value;
	          var _remarks = _r.find('[name="REMARKS"]')[0].value;
	          var _state = _r.find('[name="STATE"]')[0].value;
	          if(_querySql==''||_dataSourceType==''){
	        	  return ;
	          }
			  ds.dataSourceType = _dataSourceType;
			  ds.querySql = _querySql;
			  ds.remarks = _remarks;
			  ds.state = _state;
			  ds.id = _id;
			  ds.actionType = _r.attr('rowFlag');
			  _dataSets.push(ds);
	        });
		if(_dataSets.length>0)
			saveDataSet(_dataSets);
	});
	function addDataSetRow(){
		var _oneRow;
		if(_tmpRows.length>0){
			_oneRow = _tmpRows[0];
		}
		var _newRow = $(_oneRow).clone();
		//_newRow.find('span').hide();
		_newRow.find('span').remove();
		_newRow.find('input.box1').show();
		_newRow.attr('rowId','');
		_newRow.attr('rowFlag','ADD');
		_newRow.find('input.box1').val('');
		_newRow.find('td:eq(1)').html('');
		_newRow.find('select').attr('disabled',false)
		_tmpRows.last().after(_newRow);

	}
	function modifyDataSet(){
		var $dsRow = $('input[name=radioBtn]:radio:checked');
		if($dsRow.length==0){
			//$.messager.alert('Tip','Please select a row you want to modify!');
			alert('Please select a row you want to modify!');
			return ;
		}
		var dataSetId = $dsRow[0].value
		//var $rowSpn1 = $('#tr'+dataSetId+'>td#cellDataSourceId_'+dataSetId).find('span');
		var _rowSpans = $('#tr'+dataSetId+'>td>span');
		_rowSpans.hide();
		$('#tr'+dataSetId+'>td>input.box1').show();
		$('#tr'+dataSetId+'>td>select').attr('disabled',false);
		var _$tr = $('#tr'+dataSetId);
		_$tr.attr('rowId',dataSetId);
		_$tr.attr('rowFlag','MOD');
	}
	function delDataSet(){
		var $dsRow = $('input[name=radioBtn]:radio:checked');
		if($dsRow.length==0){
			//$.messager.alert('Tip','Please select a row you want to modify!');
			alert('Please select a row you want to modify!');
			return ;
		}	
		var dataSetId = $dsRow[0].value;
		var _dataSets = [];
		_dataSets[0] = {};
		_dataSets[0].dataSourceType = '';
		_dataSets[0].querySql = '';
		_dataSets[0].remarks = '';
		_dataSets[0].state = '';
		_dataSets[0].id = dataSetId;
		_dataSets[0].actionType = 'DEL';
		saveDataSet(_dataSets);
	}
	function queryDataSetList(){
		
	}
</script>
</body>