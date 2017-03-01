<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>服务/协议交互实例</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/demo.css">
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/easyui/console.css">	
	<script type="text/javascript" src="${contextPath}/resource/plugins/easyui/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/plugins/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/plugins/My97DatePickerBeta/My97DatePicker/WdatePicker.js"></script>
	 <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<script>
	
	
	
	   function getScrId(value,contractInteractionId){
	  window.open("../hbaseLogger/showDetail.shtml?scrId="+value+"&contractInteractionId="+contractInteractionId);
	   
	   }
		$(function(){
			$('#tt').datagrid({
				url: '../hbaseLogger/showGrid.shtml',
				title: '服务/协议交互实例',
                fitColumns:true,
				singleSelect:true,
				columns:[[
					{field:'bizFuncCode',title:'业务流程编码',width:45},
					{field:'bizIntfCode',title:'开放服务编码',width:80},
					{field:'srcTranId',title:'发起方唯一流水号',width:120,
					formatter: function(value,row,index){
					   var html = '<label style="white-space:nowrap;text-overflow:ellipsis;-o-text-overflow:ellipsis;overflow: hidden;" onmouseover="this.title=this.innerHTML">'+value+'</label>';
                     return html
				       }
					},
					{field:'srcOrgCode',title:'发起方机构代码',width:60},
					{field:'dstOrgCode',title:'落地方机构代码',width:60},
					{field:'srcSysCode',title:'发起方系统代码',width:60},
					{field:'dstSysCode',title:'落地方系统代码',width:60},
					{field:'srcReqTime',title:'发起方请求时间',width:100,
					 formatter: function(value,row,index){
					    var time= new Date(value);
					    var year = time.getFullYear();
					    var month = time.getMonth();
					    var date = time.getDate();
					    return month+"/"+date+"/"+year
				       } 
				     },
					{field:'detail',title:'详情',
					  formatter: function(value,row,index){
					    return "<a href='#' onclick=getScrId('"+row.srcTranId+"','"+row.contractInteractionId+"')>"+"详情"+"</a>"
				       } 
			         }
			        
				]]
			});
		});
		

		
	</script>
	
</head>
<body>
	 	<div class="contentWarp" id="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	  			<img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" />Op2
	  			<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />Hbase日志查询
	     	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>查询</span>
	    	</div>
    	</div>
    	<br />
    	 <div id="queryBlock">   	 
<div class="selectList"  style="display:block">
      <dl class="noBorder">
      <dt>场景类型:</dt>
        <select  id="sel" onChange="chg();clearSession()">
     <option value="2">发起方唯一流水号</option>
     <option value="3">开放服务编码+日志时间</option>
     <option value="4">开放服务编码+业务流程编码+日志时间</option>
     <option value="5">开放服务编码+发起方系统代码+日志时间</option>
     <option value="6">开放服务编码+落地方系统代码+日志时间</option>
     <option value="7">开放服务编码+应答类型+日志时间</option>
     <option value="8">开放服务编码+应答代码+日志时间</option>
</select>
    </dl>
    </div> 
</div>
    	<br />   
	<div id="search2" class="selectList"  style="display:none">
    <form id="searchForm2" method="post">
   <input type="hidden" id="querySence" name="querySence" value="2">
     <dl class="noBorder"> 
      <dc>
      <dt>发起方唯一流水号:</dt>
      <dd><input id="SRC_TRAN_ID" name="SRC_TRAN_ID" ></input></dd>
      </dc>
    </dl>   
    </form>
    </div>
    
    <div id="search3" class="selectList" style="display:none">
    <form id="searchForm3" method="post">
   <input type="hidden" id="querySence" name="querySence" value="3">
   <dl class="noBorder">
      <dc>
      <dt>开放服务编码:</dt>
      <dd><input id="BIZ_INTF_CODE" name="BIZ_INTF_CODE" ></input></dd> 
      </dc> 
      <dc>
      <dt>起始时间:</dt>
      <dd><input type="text" id="START_TIME" name="START_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
      </dc>
      <dc>
      <dt>终止时间:</dt>
      <dd><input type="text" id="END_TIME" name="END_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
      </dc>
   </dl>
    </form>
    </div>
    
    <div id="search4" class="selectList"  style="display:none">
    <form id="searchForm4" method="post">
    <input type="hidden" id="querySence" name="querySence" value="4">
    <dl class="noBorder">
    <dc>
      <dt>开放服务编码:</dt>
      <dd><input id="BIZ_INTF_CODE" name="BIZ_INTF_CODE" ></input></dd>
    </dc> 
    <dc>    
      <dt>起始时间:</dt>
      <dd><input type="text" id="START_TIME" name="START_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
    </dc>
    <dc>  
      <dt>终止时间:</dt>
      <dd><input type="text" id="END_TIME" name="END_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>             
      </tr>
    </dc>
    <dc>  
      <dt>业务流程编码:</dt>
      <dd><input id="BIZ_FUNC_CODE" name="BIZ_FUNC_CODE" ></input></dd>
    </dc> 
    </dl>  
    </form>
    </div>
    
    <div id="search5" class="selectList"  style="display:none">
    <form id="searchForm5" method="post">
    <input type="hidden" id="querySence" name="querySence" value="5">
    <dl class="noBorder">
    <dc>
      <dt>开放服务编码:</dt>
      <dd><input id="BIZ_INTF_CODE" name="BIZ_INTF_CODE" ></input></dd>
    </dc>
    <dc>   
      <dt>起始时间:</dt>
      <dd><input type="text" id="START_TIME" name="START_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
    </dc> 
    <dc>  
      <dt>终止时间:</dt>
      <dd><input type="text" id="END_TIME" name="END_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>             
    </dc>
    <dc>  
      <dt>发起方系统代码:</dt>
      <dd><input id="SRC_SYS_CODE" name="SRC_SYS_CODE" ></input></dd>
    </dc>
    </dl>   
    </form>
    </div>
    
    <div id="search6" class="selectList"  style="display:none">
    <form id="searchForm6" method="post">
    <input type="hidden" id="querySence" name="querySence" value="6">
    <dl class="noBorder">
    <dc>
      <dt>开放服务编码:</dt>
      <dd><input id="BIZ_INTF_CODE" name="BIZ_INTF_CODE" ></input></dd>
   </dc> 
   <dc>       
      <dt>起始时间:</dt>
      <dd><input type="text" id="START_TIME" name="START_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
  </dc>  
  <dc>  
      <dt>终止时间:</dt>
      <dd><input type="text" id="END_TIME" name="END_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>              
  </dc>
  <dc>  
      <dt>落地方系统代码:</dt>
      <dd><input id="DST_SYS_CODE" name="DST_SYS_CODE" ></input></dd>
   </dc>
  </dl>
    </form>
    </div>
    
    <div id="search7" class="selectList"  style="display:none">
    <form id="searchForm7" method="post">
   <input type="hidden" id="querySence" name="querySence" value="7">
   <dl class="noBorder">
   <dc>
      <dt>开放服务编码:</dt>
      <dd><input id="BIZ_INTF_CODE" name="BIZ_INTF_CODE" ></input></dd>
   </dc>
   <dc>    
      <dt>起始时间:</dt>
      <dd><input type="text" id="START_TIME" name="START_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
   </dc> 
   <dc>  
      <dt>终止时间:</dt>
      <dd><input type="text" id="END_TIME" name="END_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
   </dc>                 
   <dc>      
      <dt>应答类型:</dt>
      <dd><input id="RESPONSE_TYPE" name="RESPONSE_TYPE" ></input></dd>
  </dc>
  </dl>      
    </form>
    </div>
    
    <div id="search8" class="selectList"  style="display:none">
    <form id="searchForm8" method="post">
   <input type="hidden" id="querySence" name="querySence" value="8">
   <dl class="noBorder">
   <dc>
      <dt>开放服务编码:</dt>
      <dd><input id="BIZ_INTF_CODE" name="BIZ_INTF_CODE" ></input></dd>
   </dc>
   
   <dc>   
      <dt>起始时间:</dt>
      <dd><input type="text" id="START_TIME" name="START_TIME"  onClick="WdatePicker({dateFmt:'yyyy/MM/dd HH:mm'})"/></dd>
   </dc> 
   <dc>  
      <dt>终止时间:</dt>
      <dd><input type="text" id="END_TIME" name="END_TIME"  onClick="WdatePicker({dateFmt:'yyy/MM/dd HH:mm'})"/></dd>             
   </dc> 
   <dc>    
      <dt>应答代码:</dt>
      <dd><input id="RESPONSE_CODE" name="RESPONSE_CODE" ></input></dd>
   </dc>
   </dl>  
    </form>
    </div>

 
 </div>
	
 <div id="queryBlock">
<div class="selectList"  style="display:block">
      <dl class="noBorder">
    <dt></dt><dt></dt><dt></dt><dt></dt><dt></dt><dt></dt><dt></dt>

	<a id="search" class="button-base button-middle" >
<span class="button-text" onclick="searchFunc()">查询</span>
</a> 
    </dl>
    </div> 
</div>




 <div id="queryBlock">
<div class="selectList"  style="display:block">
	<dl class="noBorder">
	<table id="tt"></table>
	</dl>
	
<br />
	 <dl class="noBorder">
	 <dt></dt><dt></dt><dt></dt><dt></dt><dt></dt><dt></dt><dt></dt>
	<a id="buttonid" class="button-base button-middle">
<span class="button-text" onclick="searchFunc()">下一页</span>
</a> 
	</dl>
</div>	


</div>
</body>
    <script type="text/javascript" >
     
         var sy = $.extend({}, sy);
          sy.serializeObject = function (form) { 
          var o = {};
          $.each(form.serializeArray(), function (index) {
          if (o[this['name']]) {
            o[this['name']] = o[this['name']] + "," + this['value'];
          } else {
            o[this['name']] = this['value'];
          }
          });
          return o;
          };
         function searchFunc() {
          var i =  document.getElementById("sel").value
	      var form = $("#searchForm"+i).form();
          $('#tt').datagrid("load", sy.serializeObject(form));
          }	

         function show2(){
          document.getElementById("search2").style.display="block";
          document.getElementById("search3").style.display="none";
          document.getElementById("search4").style.display="none";
          document.getElementById("search5").style.display="none";
          document.getElementById("search6").style.display="none";
          document.getElementById("search7").style.display="none";
          document.getElementById("search8").style.display="none";
         }

         function show3(){
          document.getElementById("search2").style.display="none";
          document.getElementById("search3").style.display="block";
          document.getElementById("search4").style.display="none";
          document.getElementById("search5").style.display="none";
          document.getElementById("search6").style.display="none";
          document.getElementById("search7").style.display="none";
          document.getElementById("search8").style.display="none";
         }
         function show4(){
          document.getElementById("search2").style.display="none";
          document.getElementById("search3").style.display="none";
          document.getElementById("search4").style.display="block";
          document.getElementById("search5").style.display="none";
          document.getElementById("search6").style.display="none";
          document.getElementById("search7").style.display="none";
          document.getElementById("search8").style.display="none";
         }
         function show5(){
          document.getElementById("search2").style.display="none";
          document.getElementById("search3").style.display="none";
          document.getElementById("search4").style.display="none";
          document.getElementById("search5").style.display="block";
          document.getElementById("search6").style.display="none";
          document.getElementById("search7").style.display="none";
          document.getElementById("search8").style.display="none";
         }         
         function show6(){
          document.getElementById("search2").style.display="none";
          document.getElementById("search3").style.display="none";
          document.getElementById("search4").style.display="none";
          document.getElementById("search5").style.display="none";
          document.getElementById("search6").style.display="block";
          document.getElementById("search7").style.display="none";
          document.getElementById("search8").style.display="none";
         }
         function show7(){
          document.getElementById("search2").style.display="none";
          document.getElementById("search3").style.display="none";
          document.getElementById("search4").style.display="none";
          document.getElementById("search5").style.display="none";
          document.getElementById("search6").style.display="none";
          document.getElementById("search7").style.display="block";
          document.getElementById("search8").style.display="none";
         } 
         function show8(){
          document.getElementById("search2").style.display="none";
          document.getElementById("search3").style.display="none";
          document.getElementById("search4").style.display="none";
          document.getElementById("search5").style.display="none";
          document.getElementById("search6").style.display="none";
          document.getElementById("search7").style.display="none";
          document.getElementById("search8").style.display="block";
         }                           
         function chg(){
          if(document.getElementById("sel").value=="2"){
          show2();
          }if(document.getElementById("sel").value=="3"){
          show3();
          }if(document.getElementById("sel").value=="4"){
          show4();
          }if(document.getElementById("sel").value=="5"){
          show5();
          }if(document.getElementById("sel").value=="6"){
          show6();
          }if(document.getElementById("sel").value=="7"){
          show7();
          }if(document.getElementById("sel").value=="8"){
          show8();
          }
}
      function clearSession(){
        $.ajax({
            type:"post",
            async:false,
            url:"../hbaseLogger/clearSession.shtml",
            dataType:"json",
            data:{deleteIDs:1},
            success:function(msg){
            if(msg=="failure"){
            }
        }
        });
      }
            				$(window).resize(function() {
	          	$("#tt").datagrid("resize",{width:$(document.getElementById("queryBlock")).width()});
	          });

    </script>
</html>