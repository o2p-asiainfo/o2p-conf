<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>服务/协议交互实例_详情</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/demo.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/console.css">		
	<script type="text/javascript" src="${contextPath}/resource/plugins/easyui/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/plugins/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/plugins/easyui/jquery.datagrid.extend.js"></script>
 <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	
</head>
<body>
	 	<div class="contentWarp" id="contentWarp" >
	  	<div class="module-path">
	  		<div class="module-path-content">
	  			<img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" />Op2
	  			<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />Hbase日志查询
	     	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>详情</span>
	    	</div>
    	</div>
<input id="scrId" type="hidden" name="scrId" value="${scrId}"></input>
<input id="contractInteractionId" type="hidden" name="contractInteractionId" value="${contractInteractionId}"></input>

	<div id="queryBlock" >
	<table id="ENDPOINT_INTERACTION"></table>
	</div>
	<br />
	<div id="queryBlock">
	<table id="ORI_LOG_CLOB"></table>
	</div>
	<br />
	<div id="queryBlock">
	<table id="CTG_LOGS"></table>
	</div>
	<br />
	<div id="queryBlock">
	<table id="EXCEPTION_LOGS"></table>
	</div>
	</div>
	
	
	<div id="p" class="easyui-dialog" style="width:450px;height:500px;padding:10px;display:none"
				data-options="title:'My Panel',iconCls:'icon-save',resizable:true,autoScroll:true,
						collapsible:false,closable:true">
		</div>
</body>
	<script>
function htmldecode(str) {
  str = str.replace(/&amp;/gi, '&');
  str = str.replace(/&nbsp;/gi, ' ');
  str = str.replace(/&quot;/gi, '"');
  str = str.replace(/&#39;/g, "'");
  str = str.replace(/&lt;/gi, '<');
  str = str.replace(/&gt;/gi, '>');
  str = str.replace(/<br[^>]*>(?:(rn)|r|n)?/gi, 'n');
  return str;
 }
 
 function decodehtml(str) {
 str = str.replace(/</g,'&lt;');
 str = str.replace(/>/g,'&gt;');
  return str;
 }
        function open1(value){
            var str = value;
            str = decodehtml(str)			
            document.getElementById("p").innerHTML = str;
			$('#p').panel('open');
		}  

		$(function(){
		var srcId = document.getElementById("scrId").value;
		var contractInteractionId = document.getElementById("contractInteractionId").value;
			$('#ENDPOINT_INTERACTION').datagrid({
				url: '../hbaseLogger/showDetailGrid.shtml?scrId='+srcId,
				title: '端点记录',
				fitColumns:true,
				columns:[[
					{field:'reqOrRes',title:'请求/响应',width:100},
					{field:'contractInteractionId',title:'标准交易流水号',width:100,
                    formatter: function(value,row,index){
					   var html = '<span style="white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow: hidden;" onmouseover="this.title=this.innerHTML">'+value+'</span>';
                     return html
				       }
					},
					{field:'srcTranId',title:'发起方唯一流水号',width:100},
					{field:'serviceId',title:'服务ID',width:100},
					{field:'endpointId',title:'服务端点ID',width:100},	
					{field:'createDate',title:'创建时间',width:100,hidden:true,
					 formatter: function(value,row,index){
					    var time= new Date(value);
					    var year = time.getFullYear();
					    var month = time.getMonth();
					    var date = time.getDate();
					    return month+"/"+date+"/"+year
				       }
				       }				        
				]]
			});
			$('#ORI_LOG_CLOB').datagrid({
				url: '../hbaseLogger/showDetailGrid1.shtml?scrId='+srcId,
				title: '原始CLOB日志',
				fitColumns:true,
				onDblClickCell: function(index,field,value){
	                  open1(value);
	             },
				columns:[[
					{field:'contractInteractionId',title:'标准交易流水号',width:140},
					{field:'endpointId',title:'服务端点ID',width:60},	
					{field:'reqOrRes',title:'请求/响应',width:60},
					{field:'srcTranId',title:'发起方唯一流水号',width:120}, 
					{field:'srcOrgCode',title:'发起方机构代码',width:60}, 
					{field:'srcSysCode',title:'发起方系统代码',width:60},
					{field:'msg',title:'消息报文',width:100,
					formatter: function(value,row,index){
					    var str = value;
					  str =  decodehtml(str);
 var html = '<label style="white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow: hidden;" onmouseover="this.title=htmldecode(this.innerHTML)">'+str+'</label>';
                       return html
				       }},  
					{field:'createTime',title:'创建时间',width:100,
					 formatter: function(value,row,index){
					    var time= new Date(value);
					    var year = time.getFullYear();
					    var month = time.getMonth();
					    var date = time.getDate();
					    return month+"/"+date+"/"+year
				       }
				       }					   
				]]
			});
			$('#CTG_LOGS').datagrid({
				url: '../hbaseLogger/showDetailGrid2.shtml?contractInteractionId='+contractInteractionId,
				title: '内部程序异常日志',
				fitColumns:true,
				columns:[[
					{field:'contractInteractionId',title:'标准交易流水号',width:100},
					{field:'srcTranId',title:'发起方唯一流水号',width:100},
					{field:'createDate',title:'创建时间',width:100,
					 formatter: function(value,row,index){
					    var time= new Date(value);
					    var year = time.getFullYear();
					    var month = time.getMonth();
					    var date = time.getDate();
					    return month+"/"+date+"/"+year
				       }
				       }	 
				]]
			});
			$('#EXCEPTION_LOGS').datagrid({
				url: '../hbaseLogger/showDetailGrid3.shtml?scrId='+srcId,
				title: '异常记录',
				fitColumns:true,
				columns:[[
					{field:'exceptionSpecId',title:'异常规格ID',width:100},
					{field:'contractInteractionId',title:'标准交易流水号',width:120},  
					{field:'srcTranId',title:'发起方唯一流水号',width:100},
					{field:'createTime',title:'创建时间',width:100,
					 formatter: function(value,row,index){
					    var time= new Date(value);
					    var year = time.getFullYear();
					    var month = time.getMonth();
					    var date = time.getDate();
					    return month+"/"+date+"/"+year
				       }
				       },	
					{field:'exceptionMessage',title:'异常消息',width:100}, 
					{field:'content',title:'内容',width:100} 
				]]
			});
		});		
		 				$(window).resize(function() {
	          	$("#ENDPOINT_INTERACTION").datagrid("resize",{width:$(document.getElementById("queryBlock")).width()});
	          });
	           				$(window).resize(function() {
	          	$("#ORI_LOG_CLOB").datagrid("resize",{width:$(document.getElementById("queryBlock")).width()});
	          });
	           				$(window).resize(function() {
	          	$("#CTG_LOGS").datagrid("resize",{width:$(document.getElementById("queryBlock")).width()});
	          });
	           				$(window).resize(function() {
	          	$("#EXCEPTION_LOGS").datagrid("resize",{width:$(document.getElementById("queryBlock")).width()});
	          });
	          
	          window.onload =  function() {
	          $('#p').panel('close');
	          }
	</script>
</html>