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
  function changeMapType(){
	  $("#hiddenVal").val("0");
  }
  $(function(){
  	$('#assignCondition').attr("onmouseover","");
  	$('#assignCondition').attr("onmouseout","");
  });
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
							}
							else if("4"==wayVal){
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
     </ui:tabpage>
</body>
</html>