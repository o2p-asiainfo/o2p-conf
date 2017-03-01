<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	<?import namespace="v" implementation="#default#VML" ?>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/adapter/GooFlow.css" />
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/adapter/GooFlow.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/adapter/GooFlowVariables${localeName}.js"></script>
	
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
	<script>

	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.adapter.sourceNode')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.adapter.targetNode')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.adapter.operation')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.adapter.operationValue')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.adapter.stillNode')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.adapter.sureDelete')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.adapter.moveIsExit')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.adapter.updateTomove')}" />';
	title[8]='<s:property value="%{getText('eaap.op2.conf.adapter.updateIsExit')}" />';
	title[9]='<s:property value="%{getText('eaap.op2.conf.adapter.sureUpdate')}" />';
	title[10]='<s:property value="%{getText('eaap.op2.conf.adapter.otherIsExit')}" />';
	title[11]='<s:property value="%{getText('eaap.op2.conf.adapter.updateToOther')}" />';
	title[12]='<s:property value="%{getText('eaap.op2.conf.adapter.assignIsExit')}" />';
	title[13]='<s:property value="%{getText('eaap.op2.conf.adapter.updateToAssign')}" />';
   //search Function
   function do_operate(){
             $("input[type='hidden']").val(""); 
             }
    

  function clickMethod(index,field,value){   
	  if($('#taskCycleList1').datagrid('getSelections')[0]!=null)
  	{
		  //alert($('#taskCycleList1').datagrid('getSelected'));
 		} 
	} 
  function formatterForOp(value,row,index){
  	
      return "<a  class=\"button-base button-small\" style=\"width: 88px; height: 25px;\" onclick=\"openWindows_lock('${contextPath}/adapter/operate.shtml','Choose Template',650,450,true)\"><span class=\"button-text\">Operation<\span></a>";
    }
  
  var demo;
  
  var scriptDemo = "UniversalAdapterDemo";
  var flag;
  
  //清除节点操作
  function cancleAllLine(value){
		if("L" == value){//左边树
			$("ul.l").empty();
		}else if("R" ==  value){//右边树
			$("ul.r").empty();
		}
  }
  //加载左边树节点
  function srcLoadDemo(){
	  	$.ajax({
			type: "POST",
			async:false,
		    url: "../adapter/getNodeDesc.shtml",
		    dataType:'json',
		    data:{tcpCtrFId:$('#srcTcpCtrFId').val(),loadSideFlg:"L",contractType:$('#srcContractType').val()},
			success:function(msg){ 
				      loadData(msg.nodes,"L");
					  saveContractAdapter();
              }
         });
  }
//加载右边树节点
  function tarLoadDemo(){
	  	$.ajax({
			type: "POST",
			async:false,
		    url: "../adapter/getNodeDesc.shtml",
		    dataType:'json',
		    data:{tcpCtrFId:$('#tarTcpCtrFId').val(),loadSideFlg:"R",contractType:$('#tarContractType').val()},
			success:function(msg){ 
					  loadData(msg.nodes,"R");
					  saveContractAdapter();
              }
         });
  }
  
  function changeDemo(){
	  scriptDemo = "ScriptAdaptionDemo";
  }
 
  function openWind(spath,sname,tpath,lineid){
	  //flag = true;
	  var str = "spath="+spath+"&sname="+sname+"&tpath="+tpath+"&lineid="+lineid;
	  openWindows_lock('${contextPath}/adapter/operate.shtml?'+str,'<s:property value="%{getText('eaap.op2.conf.adapter.chooseTemplate')}"/>',650,450,true);
  }
  function openAssignWind(spath,sname,tpath,lineid){
	  //flag = true;
	  var str = "spath="+spath+"&sname="+sname+"&tpath="+tpath+"&lineid="+lineid;
	  openWindows_lock('${contextPath}/adapter/operateAssign.shtml?'+str,'<s:property value="%{getText('eaap.op2.conf.adapter.chooseTemplate')}"/>',650,450,true);
  }
  function openOperate(sname,spath,tpath,lineid){
	  openWind(spath,sname,tpath,lineid);
  }
  function setUploadFile(selectedfile){
		 
	  var fname = selectedfile.value;
	  var i,j;
	  var fileExt=fname.substr(fname.lastIndexOf(".")).toLowerCase();    
	  var allowImgExt=".py|.js|.java|.txt|" ;
	  
	  i=fname.lastIndexOf("\\",fname.length);
	  j=fname.lastIndexOf(".",fname.length);
	  if((j<0)||(j<i)) j=fname.length;
	  fname=fname.substring(i+1,j);
	  
      if(allowImgExt!=0 && allowImgExt.indexOf(fileExt+"|")==-1) {
    	  alert("<s:property value="%{getText('eaap.op2.conf.adapter.fileError')}" />");
    	  return false;
      }
	  //document.getElementById('para_DOC_TITLE').value=fname;
	  //checkProperty(selectedfile);
	  
	  $.ajaxFileUpload({
          url: "../adapter/uploadFile.shtml",
          secureuri:false,
          fileElementId:'scriptFileUpload',
          dataType: 'text',
          type : "post" ,
          success: function (msg) {
        	  $("#scriptFileText").val(msg);
          }
      });
	 
	 }
  
  function setUploadFileOriginal(selectedfile){
		 
	  var fname = selectedfile.value;
	  var i,j;
	  var fileExt=fname.substr(fname.lastIndexOf(".")).toLowerCase();    
	  var allowImgExt=".py|.js|.java|.txt|" ;
	  
	  i=fname.lastIndexOf("\\",fname.length);
	  j=fname.lastIndexOf(".",fname.length);
	  if((j<0)||(j<i)) j=fname.length;
	  fname=fname.substring(i+1,j);
	  
      if(allowImgExt!=0 && allowImgExt.indexOf(fileExt+"|")==-1) {
    	  alert("<s:property value="%{getText('eaap.op2.conf.adapter.fileError')}" />");
    	  return false;
      }
	  
	  //document.getElementById('para_DOC_TITLE').value=fname;
	  //checkProperty(selectedfile);
	  
	  $.ajaxFileUpload({
          url: "../adapter/originalFileUpload.shtml",
          secureuri:false,
          fileElementId:'originalFileUpload',
          dataType: 'text',
          type : "post" ,
          success: function (msg) {
        	  $("#originalFileText").val(msg);
          }
      });
	 
	 }
  
  function testUniversalAdapter(){
	  var src = $('#srcTcpCtrFIdScript').val();
	  var tar = $('#tarTcpCtrFIdScript').val();
	  var sourceTypeId = $('#sourceTypeId').val();
	  if(0 == src){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.source')}" />");
		  return;
	  }
	  if(0 == tar){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.target')}" />");
		  return;
	  }
	  	$.ajax({
			type: "POST",
			async:false,
		    url: "../adapter/testUniversalAdapter.shtml",
		    dataType:'text',
		    data:{sourceMessageText:$('#sourceMessageText').val(),srcTcpCtrFId:src,tarTcpCtrFId:tar,transformerRuleId:$("#transformerRuleId").val(),sourceType:sourceTypeId},
			success:function(msg){ 
				$("#testUniversalResult").val(msg);
          }
     });
	}
  
  function testScriptAdapter(){
	  var scriptFileText = $('#scriptFileText').val();
	  var originalFileText = $('#originalFileText').val();
	  //var transformerRuleId = $("#transformerRuleId").val();
	  var scriptTypeId = $('#scriptTypeId').val();
	  if('' == scriptFileText){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.script')}" />");
		  return;
	  }
	  if('' == originalFileText){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.original')}" />");
		  return;
	  }
	  /*if(0 == transformerRuleId){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.change')}" />");
		  return;
	  }*/
	  
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/testScriptAdapter.shtml",
		    dataType:'text',
		    data:{scriptFileText:$('#scriptFileText').val(),originalFileText:$('#originalFileText').val(),adapterType:$('#adapterType').val(),transformerRuleId:$("#transformerRuleId").val(),sourceType:scriptTypeId},
			success:function(msg){ 
				$("#resultsText").val(msg);
            }
       });
	}
  //脚本转化的保存
   function saveScriptAdapter(){
	   var url = location.search; //获取url中"?"符后的字串 
	   var theRequest = new Object(); 
	   if (url.indexOf("?") != -1) { 
	   	   var str = url.substr(1); 
		   strs = str.split("&"); 
		    for(var i = 0; i < strs.length; i ++) { 
				theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
			}
	   }
	   var attrSpecCode=theRequest['attrSpecCode'];
	  /*if ($('#srcTcpCtrFIdScript').val() == "") {
		  alert("Source Contract Version is Required .");
          return false;		  
	  }
	  if ($('#tarTcpCtrFIdScript').val() == "") {
		  alert("Source Contract Version is Required .");
          return false;		  
	  }*/
	  var type = $('#adapterType').val();
	  if(12 != type &&  14 != type){
		  if ($('#scriptFileText').val() == "") {
			  alert("Protocol script input is required .");
	          return false;		  
		  }
	  }
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/saveScriptAdapter.shtml",
		    dataType:'json',
		    data:{scriptFileText:$('#scriptFileText').val(),srcTcpCtrFId:$('#srcTcpCtrFIdScript').val(),tarTcpCtrFId:

$('#tarTcpCtrFIdScript').val(),adapterType:$('#adapterType').val(),adapterTypeName: $("#adapterType").find("option:selected").text

(),contractAdapterId:$("#contractAdapterId").val()},
			success:function(msg){ 
				var o = msg;
				$("#contractAdapterId").val(o.contractAdapterId);
				if (o.msg == 'save'){
					alert("Save success");
				} else {
					alert("Updated successfully .");
				}
				
					window.parent.editorPropertyValue(document.getElementById("objectId").value,
							document.getElementById("endpoint_Spec_Attr_Id").value,attrSpecCode,o.contractAdapterId);
					$(window.parent.document).find('#closeButtonCacheStrategy').click();
				
          }
     });
}

  
  function saveUniversalAdapter(){
	   var url = location.search; //获取url中"?"符后的字串 
	   var theRequest = new Object(); 
	   if (url.indexOf("?") != -1) { 
	   	   var str = url.substr(1); 
		   strs = str.split("&"); 
		    for(var i = 0; i < strs.length; i ++) { 
				theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
			}
	   }
	   var attrSpecCode=theRequest['attrSpecCode'];
	  //if(isSureAbleSubmit()){
		  $.ajax({
				type: "POST",
				async:true,
			    url: "../adapter/saveUniversalAdapter.shtml",
			    dataType:'json',
			    data:{transformerRuleId:$("#transformerRuleId").val()},
				success:function(msg){ 
					var o = msg;
					$("#contractAdapterId").val(o.contractAdapterId);
					if (o.msg == 'save'){
						alert("Save success");
					} else {
						alert("Updated successfully .");
					}
					window.parent.editorPropertyValue(document.getElementById("objectId").value,
							document.getElementById("endpoint_Spec_Attr_Id").value,
							attrSpecCode,o.contractAdapterId);
					$(window.parent.document).find('#closeButtonCacheStrategy').click();
			
	          }
	     });
	  //}else{
		  //alert(title[4]);
	  //}
}

//保存协议转化数据
 function saveContractAdapter(){
	if($('#tarTcpCtrFId').val() != 0 && $('#srcTcpCtrFId').val() != 0){
		$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/saveAdapterConfig.shtml",
		    dataType:'json',
		    data:{sid:$('#srcTcpCtrFId').val(),tid:$('#tarTcpCtrFId').val(),type:'1',svname:$('#srcContractVersionName').val(),tvname:$('#tarContractVersionName').val(),contractAdapterID:$('#contractAdapterID').val()},
			success:function(msg){
				 $("#adapter_name").val(msg.adapter_name);
				 $("#contractAdapterID").val(msg.contractAdapterID);
				 $("#contractAdapterId").val(msg.contractAdapterID);
				 $("#transformerRuleId").val(msg.contractAdapterID);
           }
      });
	}
 }
  function selectConVersion(type){
		 if($('.datagrid-btable>tbody>tr').length>0){
			 alert("<s:property value="%{getText('eaap.op2.conf.adapter.mappingExist')}" />");
			 return;
		 }
		 var uri;
		 if("R"==type)
		 	uri = '${contextPath}/adapter/chooseVersion.shtml?contractName=tarContractName&contractVersionName=tarContractVersionName&contractId=tarContractId&contractVersionId=tarContractVersionId&chooseTcpCtrFId=tarTcpCtrFId&contractType=tarContractType&loadSideFlg=R&chooseReqRspFlag=tarReqRspFlag&tcpCtrFId=' + $('#tarTcpCtrFId').val() + '&noTcpCtrFId=' + $('#srcTcpCtrFId').val() + '&reqRspFlag=' + $('#srcReqRspFlag').val();
		 else
			uri = '${contextPath}/adapter/chooseVersion.shtml?contractName=srcContractName&contractVersionName=srcContractVersionName&contractId=srcContractId&contractVersionId=srcContractVersionId&chooseTcpCtrFId=srcTcpCtrFId&contractType=srcContractType&loadSideFlg=L&chooseReqRspFlag=srcReqRspFlag&tcpCtrFId=' + $('#srcTcpCtrFId').val() + '&noTcpCtrFId=' + $('#tarTcpCtrFId').val() + '&reqRspFlag=' + $('#tarReqRspFlag').val();
			openWindows_lock(uri,'<s:property value="%{getText('eaap.op2.conf.adapter.selectContract')}" />',960,490,true);
	 }
</script>


</head>
<body>
<!--body start -->
<div class="contentWarp">
<div id="queryBlock">    
<div class="selectList" style="display:block;" align="center">
<ui:form id="showTaskCycleForm" method="post" action="uploadFile.shtml" enctype="multipart/form-data" theme="simple">	
<dl class="noBorder">	
<ui:form id="searchServiceManager" method="post">
<!-- Ã¥Â¼Â¹Ã¥ÂÂºÃ¦Â¡ÂÃ¨Â¿ÂÃ¥ÂÂÃ¦ÂÂ°Ã¦ÂÂ® -->
<div style="display:none">
	<input name="attrName" id="attrName" type="" value="${attrName}"/>
	<input name="objectId" id="objectId" type="" value="${objectId}"/>
	<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="" value="${endpoint_Spec_Attr_Id}"/>
	<input name="transformer" id="transformer" type="" value="${transformer}" />
	<input name="chooseTransformerRuleId" id="chooseTransformerRuleId" type="" value="${chooseTransformerRuleId}" />
	<input name="choosePageState" id="choosePageState" type="" value="${pageState}" />
</div>

<ui:tabpage  skin="${contextStyleTheme}" id="tt"  height="1100"  loadMode="ajax"  onSelect="true"  width="970px">
<ui:tabpagediv closable="false" id="test1" title="%{getText('eaap.op2.conf.adapter.universalAdapter')}"  style="padding:3px; width:100%;">
		<div class="accordion-header" align="center">
    			<div class="module-path-content">
    				<span class="accordion-header-icon" ><s:property value="%{getText('eaap.op2.conf.adapter.contractMaping')}" /></span>
    				<div style="display:none">
						<ui:inputText skin="${contextStyleTheme}" type="" id="adapter_name" textSize="10"   name="adapter_name" value="${adapter_name}"/>
						<ui:inputText skin="${contextStyleTheme}" type="" id="contractAdapterID" textSize="10"   name="contractAdapterID" value="${transformerRuleId}"/>
         			</div>
         		</div>       
		</div>
		<br/>
		<div align="center">
			<span ><s:property value="%{getText('eaap.op2.conf.adapter.srcContract')}" /></span>
			<div style="display:none;">
				<ui:inputText skin="${contextStyleTheme}" id="transformerRuleId" textSize="10"   name="transformerRuleId" value="${transformerRuleId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcContractId" textSize="10"   name="srcContractId" value="${srcContractId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcContractVersionId" textSize="10"   name="srcContractVersionId" value="${srcContractVersionId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcTcpCtrFId" textSize="10"   name="srcTcpCtrFId" value="${srcTcpCtrFId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcReqRspFlag" textSize="10"   name="srcReqRspFlag" value="${srcReqRspFlag}"/>
			</div>
			<ui:inputText skin="${contextStyleTheme}" id="srcContractName" disabled="true" textSize="10"  name="srcContractName" value="${srcContractName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="srcContractVersionName" disabled="true" textSize="10"   name="srcContractVersionName" value="${srcContractVersionName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="srcContractType" textSize="10"  disabled="true" name="srcContractType" value="${srcContractType}"/>
			<ui:button text="%{getText('eaap.op2.conf.prov.select')}" skin="${contextStyleTheme}" shape="S"
				onclick="selectConVersion('L');"></ui:button>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span ><s:property value="%{getText('eaap.op2.conf.adapter.tarContract')}" /></span>
			<div style="display:none">
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarContractId" textSize="10"   name="tarContractId" value="${tarContractId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarContractVersionId" textSize="10"   name="tarContractVersionId" value="${tarContractVersionId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarTcpCtrFId" textSize="10"   name="tarTcpCtrFId" value="${tarTcpCtrFId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarReqRspFlag" textSize="10"   name="tarReqRspFlag" value="${tarReqRspFlag}"/>
			</div>
			<ui:inputText skin="${contextStyleTheme}" id="tarContractName" textSize="10" disabled="true"  name="tarContractName" value="${tarContractName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="tarContractVersionName" textSize="10"  disabled="true" name="tarContractVersionName" value="${tarContractVersionName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="tarContractType" textSize="10"   disabled="true"  name="tarContractType" value="${tarContractType}"/>
			<ui:button text="%{getText('eaap.op2.conf.prov.select')}" shape="S" skin="${contextStyleTheme}"
				onclick="selectConVersion('R');"></ui:button>
			<br/><br/>
			<%--
			<ui:button text="%{getText('eaap.op2.conf.adapter.mapping')}" shape="S" skin="${contextStyleTheme}" onclick="autoMapping();" ></ui:button>
			<br/><br/> --%>
		</div>
		
		<div id="UniversalAdapterDemo" style="padding-left:5px;" class="GooFlow" onselectstart="return false"></div> 

		<br/>
			<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="taskCycleList1" remoteSort="false" sortOrder="desc"  onClickCell="false" 
				skin="${contextStyleTheme}" fit="true" collapsible="true"   title=""  rownumbers="true"
				striped="true" pageSize="10" 
				method="eaap-op2-conf-adapterAction.getList">
				<ui:gridEasyColumn width="200" index="0" title="0" field="sPath" hidden="false" align="center" ></ui:gridEasyColumn>
				<ui:gridEasyColumn width="200" index="1" title="1" field="tPath" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="2" title="2" field="action" hidden="false"   align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="3" title="3" field="cz" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="100" index="4" title="4" field="dec" hidden="true"   align="center"></ui:gridEasyColumn>
			</ui:gridEasy>
		<%-- <br/>
		
		<div style="display:none;">
		<table align="center" class="mgr-table">
		       <tr>
	               <td align="right" width="15%">Source Message Type</td>
	               <td colspan="3" width="85%">
	               		<select id="sourceTypeId">
	               		   <option value="1">XML</option>
	               		   <option value="2">JSON</option>
	               		</select>
	               </td>
	            </tr>
	           <tr>
	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.sourceMsg')}" /></td>
	               <td colspan="3" width="85%">
	               		<ui:textarea skin="${contextStyleTheme}" name="sourceMessageText" id="sourceMessageText" width="850" ></ui:textarea>
	               </td>
	            </tr>
		</table>
		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="S" text="%{getText('eaap.op2.conf.adapter.test')}" onclick="testUniversalAdapter();"></ui:button>
		</div>
		<br/>
		
		<table align="center" class="mgr-table">
	           <tr>
	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.testResult')}" /></td>
	               <td colspan="3" width="85%">
	               		<ui:textarea skin="${contextStyleTheme}" name="testUniversalResult" id="testUniversalResult" width="850" ></ui:textarea>
	               </td>
	            </tr>
		</table>
		</div>
		--%>
		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.prov.submit')}" onclick="saveUniversalAdapter()"></ui:button>
			 <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="$(window.parent.document).find('#closeButtonCacheStrategy').click();"></ui:button>
		</div>
		
</ui:tabpagediv>

<!-- -------------------------ÃÂ§ÃÂ¬ÃÂ¬ÃÂ¤ÃÂºÃÂÃÂ©ÃÂÃÂÃÂ©ÃÂ¡ÃÂ¹ÃÂ¥ÃÂÃÂ¡---------------------------------------- -->
<ui:tabpagediv id="test2" title="%{getText('eaap.op2.conf.adapter.scriptAdapter')}"  closable="false"  style="padding:3px;">
		<div class="accordion-header" >
    			<div class="module-path-content" align="center">
    				<span class="accordion-header-icon" ><s:property value="%{getText('eaap.op2.conf.adapter.contractMaping')}" /></span>
         		</div>       
		</div>
		<div align="center" style="display:none;">
			<span ><s:property value="%{getText('eaap.op2.conf.adapter.srcContract')}" /></span>
			<div style="display:none">
			    <ui:inputText skin="${contextStyleTheme}" id="contractAdapterId" textSize="10"   name="contractAdapterId" value="${contractAdapterId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcContractIdScript" textSize="10"   name="srcContractIdScript" value="${srcContractId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcContractVersionIdScript" textSize="10"   name="srcContractVersionIdScript" value="${srcContractVersionId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcTcpCtrFIdScript" textSize="10"   name="srcTcpCtrFIdScript" value="${srcTcpCtrFId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="srcReqRspFlagScript" textSize="10"   name="srcReqRspFlagScript" value="${srcReqRspFlag}"/>
			</div>
			<ui:inputText skin="${contextStyleTheme}" id="srcContractNameScript" readonly="true" textSize="10"   name="srcContractNameScript" value="${srcContractName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="srcContractVersionNameScript" readonly="true"  textSize="10"   name="srcContractVersionNameScript" value="${srcContractVersionName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="srcContractTypeScript"  readonly="true" textSize="10"   name="srcContractTypeScript" value="${srcContractType}"/>
			<ui:button text="%{getText('eaap.op2.conf.prov.select')}" skin="${contextStyleTheme}" shape="S"
				onclick="openWindows_lock(
				'${contextPath}/adapter/chooseVersion.shtml?contractName=srcContractName&contractVersionName=srcContractVersionName&contractId=srcContractId&contractVersionId=srcContractVersionId&chooseTcpCtrFId=srcTcpCtrFId&contractType=srcContractType&loadSideFlg=L&chooseReqRspFlag=srcReqRspFlag&tcpCtrFId=' + $('#srcTcpCtrFId').val() + '&noTcpCtrFId=' + $('#tarTcpCtrFId').val() + '&reqRspFlag=' + $('#tarReqRspFlag').val(),
				'%{getText('eaap.op2.conf.adapter.chooseContract')}',850,490,true)"></ui:button>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span ><s:property value="%{getText('eaap.op2.conf.adapter.tarContract')}" /></span>
			<div style="display:none">
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarContractIdScript" textSize="10"   name="tarContractIdScript" value="${tarContractId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarContractVersionIdScript" textSize="10"   name="tarContractVersionIdScript" value="${tarContractVersionId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarTcpCtrFIdScript" textSize="10"   name="tarTcpCtrFIdScript" value="${tarTcpCtrFId}"/>
				<ui:inputText skin="${contextStyleTheme}" type="" id="tarReqRspFlagScript" textSize="10"   name="tarReqRspFlagScript" value="${tarReqRspFlag}"/>
			</div>
			<ui:inputText skin="${contextStyleTheme}" id="tarContractNameScript" textSize="10" readonly="true"  name="tarContractNameScript" value="${tarContractName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="tarContractVersionNameScript" textSize="10"  readonly="true" name="tarContractVersionNameScript" value="${tarContractVersionName}"/>
			<ui:inputText skin="${contextStyleTheme}" id="tarContractTypeScript" textSize="10"  readonly="true"   name="tarContractTypeScript" value="${tarContractType}"/>
			<ui:button text="%{getText('eaap.op2.conf.prov.select')}" shape="S" skin="${contextStyleTheme}"
				onclick="openWindows_lock(
				'${contextPath}/adapter/chooseVersion.shtml?contractName=tarContractName&contractVersionName=tarContractVersionName&contractId=tarContractId&contractVersionId=tarContractVersionId&chooseTcpCtrFId=tarTcpCtrFId&contractType=tarContractType&loadSideFlg=R&chooseReqRspFlag=tarReqRspFlag&tcpCtrFId=' + $('#tarTcpCtrFId').val() + '&noTcpCtrFId=' + $('#srcTcpCtrFId').val() + '&reqRspFlag=' + $('#srcReqRspFlag').val(),
				'%{getText('eaap.op2.conf.adapter.chooseContract')}',850,490,true)"></ui:button>
		</div>
		<%-- 
		<br/>
			<div id="demo2" style="padding-left:50px;display:none;"></div> 
		<br/>
		--%>

		<table align="center" class="mgr-table">
	           <tr>

	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.scriptType')}" /></td>
	               <td colspan="3" width="85%" >
	               	    <ui:select  
		    				name="adapterType" 
		    				id="adapterType"   
		    				emptyOption="true" 
		    			    list="scriptL" 
		    			    listKey="id" 
		    			    listValue="val" 
		    			    value="${adapterType}"
		    			    style="width:70px;" 
		    			    skin="${contextStyleTheme}"
		    			    >
	    			    </ui:select>
	               </td>
	            </tr>
	           <tr>



	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.scriptUpload')}" /></td>
	               <td colspan="3" width="85%">
	               		<script type="text/javascript" src="../resource/comm/js/ajaxfileupload.js"></script>
						<s:file name="scriptFileUpload" id="scriptFileUpload" onchange="setUploadFile(this)" size="30" cssClass="sys-text-area"/>
	               </td>
	            </tr>
	           <tr>
	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.contractScript')}" /></td>
	               <td colspan="3" width="85%">
						<ui:textarea skin="${contextStyleTheme}" name="scriptFileText" id="scriptFileText" height="280" width="850"  value="${scriptFileText}"></ui:textarea>
	               </td>
	            </tr>
	            <%-- 
	           <tr>
	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.messageUpload')}" /></td>
	               <td colspan="3" width="85%">
						<s:file name="originalFileUpload"   id="originalFileUpload"   onchange="setUploadFileOriginal(this)" size="30" cssClass="sys-text-area"/>
	               </td>
	            </tr>
	           <tr>
	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.messageInput')}" /></td>
	               <td colspan="3" width="85%">
						<ui:textarea skin="${contextStyleTheme}" name="originalFileText" id="originalFileText"  width="850"></ui:textarea>
	               </td>
	            </tr>
                <tr>
	               <td align="right" width="15%">Original Message Type</td>
	               <td colspan="3" width="85%">
	               		<select id="scriptTypeId">
	               		   <option value="1">XML</option>
	               		   <option value="2">JSON</option>
	               		</select>
	               </td>
	            </tr>
               --%>
		</table>
        <%-- 
		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="S" text="%{getText('eaap.op2.conf.adapter.test')}" name="testScrpt" id="testScrpt" onclick="testScriptAdapter();"></ui:button>
		</div>
		
		<table align="center" class="mgr-table">
	           <tr>
	               <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.adapter.testResult')}" /></td>
	               <td colspan="3" width="85%">
						<ui:textarea skin="${contextStyleTheme}" name="resultsText" id="resultsText" width="850"></ui:textarea>
	               </td>
	            </tr>
		</table>
		--%>
		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.prov.submit')}" onclick="saveScriptAdapter()"></ui:button>
			 <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="$(window.parent.document).find('#closeButtonCacheStrategy').click();"></ui:button>
		</div>
</ui:tabpagediv>
</ui:tabpage>
</ui:form>
		
	  </dl>
	  </ui:form>
	  <%--
<table class="mgr-table" style="display:none" id="confirm">
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseAdapter();"></ui:button>
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="$(window.parent.document).find('#closeButton').click();"></ui:button>
	 </td>	
   </tr>
</table>
	   --%>
	 </div>
   </div>
</div>
</body>
<script>
  $(document).ready(function(){
	  if($('#contractAdapterID').val()==0){
		  $('#contractAdapterID').val('');
		  $('#adapter_name').val('');
	  }
	  setTimeout(function(){
		  $('div[class=datagrid-cell]').unbind('click');  
	  },1000);//取消表格单击事件
	  demo=new GooFlow($("#" + scriptDemo),{width:960,height:450,haveTool:true});//初使化图形
	  //初使化树数据
	  var adapterType = '${adapterType}';
		if ($('#transformerRuleId').val() > 0) {
			if(adapterType > 1){//说明是脚本配置
				$(".tabs>li>.tabs-inner").eq(1).click();
			}else{
				srcLoadDemo();//加载左边树
				tarLoadDemo();//加载右边树
				loadLineDemo();//初使化加载线用
			}
		}
		//注册TAB的点击事件
		var tab1  =  $(".tabs>li>.tabs-inner").eq(0).attr('href');
		$(".tabs>li>.tabs-inner").eq(0).attr('href',tab1+';onclickTab(1);');
		var tab2  =  $(".tabs>li>.tabs-inner").eq(1).attr('href');
		$(".tabs>li>.tabs-inner").eq(1).attr('href',tab2+';onclickTab(2);');
		
	 
  });
  //响应tab的点击事件
  function onclickTab(num){
	  var type = '${adapterType}';
	  if($('#transformerRuleId').val() > 0){
		  if(1 == num){//第一个TAB
			  if(type > 1){//说明在做变换配置
				  if(!confirm('Adaptive data already exists, if you want to modify ?')){
					  $(".tabs>li>.tabs-inner").eq(1).click();
				  }
			  }
		  }else if(2 == num){//第二个TAB
              if(type <=1){//说明在做变换配置
            	  if(!confirm('Adaptive data already exists, if you want to modify ?')){
					  $(".tabs>li>.tabs-inner").eq(0).click();
				  }
			  }
		  }
	  }
  }
	//初使化加载线用
	function loadLineDemo(){
	  $.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/getLineDesc.shtml",
		    dataType:'json',
		    data:{tarTcpCtrFId:$('#tarTcpCtrFId').val(),srcTcpCtrFId:$('#srcTcpCtrFId').val(),transformerRuleId:$('#transformerRuleId').val()},
			success:function(msg){ 
				loadLine(msg.lines);//加载线数据
				repeadJson = msg.repeadJson;//操作记录同步
				$.each(msg.GooFlow_line_Adapter,function() {
					var trId = "UniversalAdapterDemo_line_"+this.lineId;
					//lineAdapterNew(this);
					addRecod(this.lineId,this.from,this.to,this.type,"");
					$('#' + trId).find("input[name=way]").val(this.wayVal);
					$('#' + trId).find("input[name=assignVal]").val(this.assignVal);
					$('#' + trId).find("input[name=assignCondition]").val(this.assignConditionValue);
					
				});//加载正常线
				changeRowColor();//改变表格行样式
           }
      });
    }
	//消息回调选中方法
	function chooseAdapter()
	{
		if(isSureAbleSubmit()){
			var vOpener=art.dialog.opener;
			var transformerRuleId = $("#transformerRuleId").val();
		    vOpener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,transformerRuleId,
		    document.getElementById("objectId").value,
		    document.getElementById("endpoint_Spec_Attr_Id").value);
		    art.dialog.close();
		}else{
			alert(title[4]);
		}
		
	 }
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>