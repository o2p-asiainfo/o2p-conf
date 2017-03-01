<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=orange" ></script>  
    <script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
    <script type="text/javascript" src="../resource/comm/adapter/json2.js"></script>
    <script type="text/javascript">
    var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.adapter.varMapingId')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.adapter.consMapCd')}"/>';
	title[2]='<s:property value="%{getText('eaap.op2.conf.adapter.dataSource')}"/>';
	title[3]='<s:property value="%{getText('eaap.op2.conf.adapter.keyExpress')}"/>';
	title[4]='<s:property value="%{getText('eaap.op2.conf.adapter.valExpress')}"/>';
	title[5]='<s:property value="%{getText('eaap.op2.conf.adapter.version')}"/>';
	title[6]='<s:property value="%{getText('eaap.op2.conf.adapter.state')}"/>';
	
    function do_operate(){
          $("input[type='hidden']").val(""); 
    }
    $(function(){
    	$('#assignCondition').attr("onmouseover","");
      	$('#assignCondition').attr("onmouseout","");
    });
	function deleteMethod(){ 
		var text = $("#hiddenVal").val();
		   if("0"==text){
			   alert('<s:property value="%{getText('eaap.op2.conf.adapter.noSubmit')}"/>');
			   return;
		   }
		var rowData = $('#MetaDataMatchingList').datagrid('getSelections')[0];
		if(!rowData){
			  alert('<s:property value="%{getText('eaap.op2.conf.adapter.chooseOne')}"/>');
			  return;
		  }
		  $.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/delVariableMap.shtml",
			    dataType:'json',
			    data:{varMapingID:rowData.VAR_MAPING_ID},
				success:function(msg){
					 $('#MetaDataMatchingList').datagrid("reload", {"consMapCD":$('#varMapType').val()});
					 $('.tabs>li:eq(2)').attr('class','tabs-selected');
	          }
	     });
   }
   		 
   function addMehtod(){
	   var text = $("#hiddenVal").val();
	   if("0"==text){
		   alert('<s:property value="%{getText('eaap.op2.conf.adapter.noSubmit')}"/>');
		   return;
	   }
	   openWindows_lock('${contextPath}/adapter/addMetaData.shtml','<s:property value="%{getText('eaap.op2.conf.adapter.metaDataMatch')}"/>',350,180,true);
	   $('.tabs>li:eq(2)').attr('class','tabs-selected');
   } 
   function addMeatData(varMapingID,actionType,source,key,val){
	   var param = "{\"actionType\":\""+actionType+"\",\"source\":\""+source+"\",\"key\":\""+key+"\",\"val\":\""+val+"\",\"consMapCD\":\""+$("#varMapType").val()+"\"}";
	   if(varMapingID!=null&&varMapingID!=""){
		   param = param.substr(0,param.length-1);
		   param += ",\"varMapingID\":\""+varMapingID+"\"}";
	   }
       var paramJson = JSON.parse(param);
	   $.ajax({
			type: "POST",
			async:true,
		    url: "${contextPath}/adapter/saveOrUpdateVariableMap.shtml",
		    dataType:'json',
		    data:paramJson,
			success:function(msg){ 
				$('#MetaDataMatchingList').datagrid("load", {"consMapCD":$('#varMapType').val()});
				$('.tabs>li:eq(2)').attr('class','tabs-selected');
          }
     });
   }          
  function updateMethod(){
	  var text = $("#hiddenVal").val();
	   if("0"==text){
		   alert('<s:property value="%{getText('eaap.op2.conf.adapter.noSubmit')}"/>');
		   return;
	   }
	  var rowData = $('#MetaDataMatchingList').datagrid('getSelections')[0];
	  if(!rowData){
		  alert('<s:property value="%{getText('eaap.op2.conf.adapter.chooseOne')}"/>');
		  return;
	  }
      var varMapingID = rowData.VAR_MAPING_ID;
      var consMapCD = rowData.CONS_MAP_CD;
      var source = rowData.DATA_SOURCE;
      var keyExpress = rowData.KEY_EXPRESS;
      var valExpress = rowData.VAL_EXPRESS;
      var param = "varMapingID="+varMapingID+"&consMapCD="+consMapCD+"&source="+source + "&keyExpress="+keyExpress+"&valExpress="+valExpress;
      openWindows_lock('${contextPath}/adapter/addMetaData.shtml?'+param,'<s:property value="%{getText('eaap.op2.conf.adapter.metaDataMatch')}"/>',350,250,true);
	  
    }
  
  function clickMethod(){}
  
  function changeMapType(){
	  $("#hiddenVal").val("0");
  }
  
  function saveMapType(){
	  if("1"==$("#hiddenVal").val()){
		  alert('<s:property value="%{getText('eaap.op2.conf.adapter.haveSubmit')}"/>');
		  return;
	  }
	  var vOpener=window.art.dialog.opener;
	  var lineid = '${lineid}';
  	  //var num = lineid.replace("UniversalAdapterDemo_line_","");
      var tidV = $(vOpener.document.getElementById(lineid)).find("input[name=tid]").val();//父页面目标节点ID值
	  var varMapType = $("#varMapType").val();
	  var nameVal = $("#name").val();
	  var varMapTypeIDV = $("#varMapTypeID").val();
	  var reLoadFlag = true;
	  
	  if(varMapType=="" || nameVal==""){
		  alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
		  return;
	  }
	  if(varMapType.length>16){
		  alert('<s:property value="%{getText('eaap.op2.conf.adapter.varMapTypeLength')}"/>');
		  return;
	  }
	 $.ajax({
			type: "POST",
			async:false,
		    url: "${contextPath}/adapter/addVarMapType.shtml",
		    dataType:'json',
		    data:{consMapCD:varMapType,name:nameVal,varMapTypeID:varMapTypeIDV,tid:tidV},//JSON.parse(json),
			success:function(msg){ 
				if("0"==msg.code){
					reLoadFlag = false;
					alert(msg.errMsg);
				}else if("1"==msg.code){
					document.getElementById("hiddenVal").value="1";
					document.getElementById("varMapTypeID").value=msg.errMsg;
					$("#hiddenVal").val("1");
					$("#varMapTypeID").val(msg.errMsg);
					alert('<s:property value="%{getText('eaap.op2.conf.adapter.saveSuccess')}"/>');
				}
				if(reLoadFlag){
					$('#MetaDataMatchingList').datagrid("load", {"consMapCD":$("#varMapType").val()});
				}
           }
      });
	 
	var actionTypeVal = "add";
   	var assignConditionValue = $('#assignCondition').val();
   	var mapingID = $(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val();//父页面节点取值要求ID
   	var wayValue = $(vOpener.document.getElementById(lineid)).find("input[name=way]").val();//给父页面取值方式赋值
  	if("" != mapingID){
  		if(wayValue!="3"){
  			actionTypeVal = "update";
  		}else{
  			return;
  		}
	}else{
		
	}
	 $.ajax({
			type: "POST",
			async:true,
		    url: "${contextPath}/adapter/addNodeValAdapterRes.shtml",
		    dataType:'json',
		    data:{actionType:actionTypeVal,tid:tidV,way:'3',assignVal:varMapType,assignCondition:assignConditionValue,nodeValAdapterReqId:mapingID},
			success:function(msg){
				if(msg.mapingID){
					$(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val(msg.mapingID);//给父页面节点取值要求ID赋值
					$(vOpener.document.getElementById(lineid)).find("input[name=way]").val("3");//给父页面取值方式赋值
				}
        }
   });
  }
  function initMethod(){
	var vOpener=window.art.dialog.opener;
	var lineid = '${lineid}';
  	var assignVal;
  	var assignConditionVal;
	var wayVal;
  	var consMapCD;
	 var name;
	 var varMapTypeID;
	 var mapingIDVal = $(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val();//父页面节点取值要求ID
	 if(mapingIDVal){
		 $.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/queryVarNodeReq.shtml",
			    dataType:'json',
			    data:{mapingID:mapingIDVal},//JSON.parse(json),
				success:function(msg){
					if("0"==msg.code){
						alert(msg.errMsg);
					}else if("1"==msg.code){ 
						assignVal = msg.assignVal;
						assignConditionVal = msg.assignConditionVal;
						consMapCD = msg.consMapCD;
						name = msg.name;
						varMapTypeID = msg.varMapTypeID;
						wayVal = msg.wayVal;
						 $('#assignCondition').val(assignConditionVal);
							if("2"==wayVal){
								$("#node_value").val(assignVal);
							}else if("4"==wayVal){
								$(".tabs>li>.tabs-inner").eq(1).click();
								$("#codeFragment").val(assignVal);
							}else if("3"==wayVal){
								$(".tabs>li>.tabs-inner").eq(2).click();
								if(consMapCD){ 
									$('#varMapType').val(consMapCD);
									$("#name").val(name);
									$("#varMapTypeID").val(varMapTypeID);
									$("#hiddenVal").val("1");
									$('#MetaDataMatchingList').datagrid("reload", {"consMapCD":consMapCD});
								}else{
									$("#hiddenVal").val("0");
								}
							}
						if(consMapCD){
							$('#MetaDataMatchingList').datagrid("load", {"consMapCD":$("#varMapType").val()});
						}
					}
	        }
	   });
	 }
 }
   
    function checkFixedAssignmentVal(){
    	var vOpener=window.art.dialog.opener;
    	var lineid = '${lineid}';//表格行(tr)的ID
      	var actionTypeVal = "add";//默认是添加状态
    	var value = $("#node_value").val();
    	var assignConditionValue = $('#assignCondition').val();
    	
      	var tid = $(vOpener.document.getElementById(lineid)).find("input[name=tid]").val();//父页面目标节点ID值
      	var mapingID = $(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val();//父页面节点取值要求ID
    	if(!value){
    		alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
    		return;
    	}
    	if("" != mapingID){
    		actionTypeVal = "update";//如果有值说明是更新状态
    	}
    	$.ajax({
			type: "POST",
			async:true,
		    url: "${contextPath}/adapter/addNodeValAdapterRes.shtml",
		    dataType:'json',
		    data:{actionType:actionTypeVal,tid:tid,way:'2',assignVal:value,assignCondition:assignConditionValue,nodeValAdapterReqId:mapingID},
			success:function(msg){
				if(msg.mapingID)
					$(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val(msg.mapingID);//给父页面节点取值要求ID赋值
					$(vOpener.document.getElementById(lineid)).find("input[name=way]").val("2");//给父页面取值方式赋值
				art.dialog.close(); 
           }
      });
    }
    
    function checkJavaBeanAssignment(){
    	var vOpener=window.art.dialog.opener;
    	var javaBean = $('#codeFragment').val();
    	var assignConditionValue = $('#assignCondition').val();
    	if(!javaBean){
    		alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
    		return;
    	}
    	var lineid = '${lineid}';//表格行(tr)的ID
    	var actionTypeVal = "add";//默认是添加状态
    	
    	var tid = $(vOpener.document.getElementById(lineid)).find("input[name=tid]").val();//父页面目标节点ID值
      	var mapingID = $(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val();//父页面节点取值要求ID
    	
    	if("" != mapingID){
    		actionTypeVal = "update";
    	}
    	$.ajax({
			type: "POST",
			async:true,
		    url: "${contextPath}/adapter/addNodeValAdapterRes.shtml",
		    dataType:'json',
		    data:{actionType:actionTypeVal,tid:tid,way:'4',assignVal:javaBean,assignCondition:assignConditionValue,nodeValAdapterReqId:mapingID},
			success:function(msg){
				if(msg.mapingID)
					$(vOpener.document.getElementById(lineid)).find("input[name=assignVal]").val(msg.mapingID);//给父页面节点取值要求ID赋值
				    $(vOpener.document.getElementById(lineid)).find("input[name=way]").val("4");//给父页面取值方式赋值
				art.dialog.close(); 
           }
      });
    }
    function checkMetaDataMatching(){
  	  if("0"== $("#hiddenVal").val()){
  		alert('<s:property value="%{getText('eaap.op2.conf.adapter.noSubmit')}"/>');
  		  return;
  	  }
    	art.dialog.close();
    }
    function format4rouse(value,row,index){
    	if("1"==value){
    		 return "<s:property value="%{getText('eaap.op2.conf.adapter.fromDb')}" />"  ;
    	}else if("2"==value){
    		 return "<s:property value="%{getText('eaap.op2.conf.adapter.fromHost')}" />"  ;
    	}
    }
    </script>
</head>
<body class="easyui-layout" style="width:620px; border: 1px;padding-left:20px;" onload="initMethod();">
 <div>
 	<div style="padding-left:20px;float:left;">
 		<div style="font-weight: bold;"><s:property value="%{getText('eaap.op2.conf.adapter.srcNode')}" /></div>
 		<br style="line-height:8px;"/>
 		<div>
 			<span style="display:-moz-inline-box;display:inline-block;width:80px;text-align:right;"><s:property value="%{getText('eaap.op2.conf.adapter.nodeName')}" /></span>
 			<ui:inputText skin="${contextStyleTheme}" name="node" id="node" value="${sname}" textSize="20" disabled="true"></ui:inputText>
 		</div>
 		<br style="line-height:8px;"/>
 		<br style="line-height:8px;"/>
 		<br style="line-height:8px;"/>
 		<div>
 			<span style="display:-moz-inline-box;display:inline-block;width:80px;text-align:right;"><s:property value="%{getText('eaap.op2.conf.adapter.nodePath')}" /></span>
 			<ui:inputText skin="${contextStyleTheme}" name="path" id="path" value="${spath }" textSize="20" disabled="true"></ui:inputText>
 		</div>
 		<br style="line-height:8px;"/>
 	</div>
 	<div style="padding-left:20px;float:left;">
 		<div style="font-weight: bold;"><s:property value="%{getText('eaap.op2.conf.adapter.assignmentCondition')}" /></div>
 		<div>
 			<ui:textarea skin="${contextStyleTheme}" name="assignCondition" id="assignCondition" width="339" height="90" value=""></ui:textarea>
 			<br style="line-height:8px;"/>
 		</div>
 	</div>
 </div>

 <ui:tabpage skin="${contextStyleTheme}" id="operate"  height="300px" width="600px" loadMode="iframe" onSelect="true">
       <ui:tabpagediv  width="400px" closable="false" id="test1" title="%{getText('eaap.op2.conf.adapter.fixAssign')}">
         <br/>
         <ui:form id="fixedAssignmentForm" name="fixedAssignmentForm" action="" method="post">
	         <div align="center">
		         <span style="display:-moz-inline-box;display:inline-block;width:70px;text-align:right;"><s:property value="%{getText('eaap.op2.conf.adapter.nodePath')}" /></span> 
		         <span><ui:inputText skin="${contextStyleTheme}" name="node_path" id="node_path" textSize="50" value="${tpath }" disabled="true"></ui:inputText></span>
		         <br/><br/>
		         <span style="display:-moz-inline-box;display:inline-block;width:70px;text-align:right;"><s:property value="%{getText('eaap.op2.conf.adapter.nodeValue')}" /></span> 
		         <span><ui:inputText skin="${contextStyleTheme}" name="node_value" id="node_value" textSize="50" value=""></ui:inputText></span>
		         <br/><br/><br/>
		         <div align="center">
		          <ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="checkFixedAssignmentVal();"></ui:button>
		          <ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
		       	</div>
	       	</div>
       	</ui:form>
       </ui:tabpagediv>
       <!-- //////////////////////////////////////////////////////////////////////////////////////////////// -->
       <ui:tabpagediv id="test2" title="%{getText('eaap.op2.conf.adapter.javaAssign')}" width="400px" closable="false" style="overflow: auto;">
       	<br/>
       	<div id="parameterArea" style="" align="center">
       		<ui:form name="parameterForm" action="" method="post" id="parameterForm">
       			<table id="ft" border="0">
       			</table>
         	</ui:form>
       	</div>
       	<br/>
       	<div style="padding-left:40px;">
				<span><s:property value="%{getText('eaap.op2.conf.adapter.codeFrag')}" /></span>
			</div>
       	<div align="center">
			<ui:form action="" method="post" name="codeFragmentForm" id="codeFragmentForm" >
				<ui:textarea skin="${contextStyleTheme}" name="codeFragment" id="codeFragment" width="520" height="150"></ui:textarea>
			</ui:form>
			<br/>
			<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="checkJavaBeanAssignment();"></ui:button>
            <ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
       	</div>
       </ui:tabpagediv>
        <!-- //////////////////////////////////////////////////////////////////////////////////////////////// -->
       <ui:tabpagediv id="test3" title="%{getText('eaap.op2.conf.adapter.metaDataMatch')}" width="400px" closable="false" >
       	<br/>
       	<div align="center">
       		<span><s:property value="%{getText('eaap.op2.conf.adapter.varMapType')}" /></span>
       		<ui:inputText skin="${contextStyleTheme}" id="varMapType" name="varMapType" value="" onchange="changeMapType();"></ui:inputText>&nbsp;&nbsp;
       		<span><s:property value="%{getText('eaap.op2.conf.adapter.name')}" /></span>
       		<ui:inputText skin="${contextStyleTheme}" name="name" value="${adapter_name}" id="name" onchange="changeMapType();"></ui:inputText>&nbsp;&nbsp;
       		<span style="display: none;">
       			<ui:inputText name="hiddenVal" skin="${contextStyleTheme}" id="hiddenVal" value="0"></ui:inputText>
       			<ui:inputText name="varMapTypeID" skin="${contextStyleTheme}" id="varMapTypeID" value=""></ui:inputText>
       		</span>
       		<ui:button text="%{getText('eaap.op2.conf.prov.submit')}" shape="S" id="saveMapeType" skin="${contextStyleTheme}" onclick="saveMapType();"></ui:button>
       	</div>
       	<br/>
       	<div style="width: 550px;height:170px;padding-left:20px;">
       		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="ID" singleSelect="true" id="MetaDataMatchingList" remoteSort="false" sortOrder="desc"  onClickCell="false" 
				skin="${contextStyleTheme}" fit="true" collapsible="true"   title="" striped="true" rownumbers="true" toolbar="true" frozenColumns="true" 
			 	height="170" fitHeight="170" method="eaap-op2-conf-adapterAction.getMetaDataMacthingList">
				<ui:gridEasyColumn width="100" index="0" title="0" field="VAR_MAPING_ID" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="1" title="1" field="CONS_MAP_CD" hidden="true" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="2" title="2" field="DATA_SOURCE" hidden="false" align="center" formatter="true" formatterMethod="format4rouse"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="3" title="3" field="KEY_EXPRESS" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="4" title="4" field="VAL_EXPRESS" hidden="false"   align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="5" title="5" field="VERSION" hidden="true"   align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="60" index="6" title="6" field="STATE" hidden="false"   align="center"></ui:gridEasyColumn>
			</ui:gridEasy> 	
       	</div>
   		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="checkMetaDataMatching();"></ui:button>
          	<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
		</div>
       </ui:tabpagediv>
     </ui:tabpage>
</body>
</html>