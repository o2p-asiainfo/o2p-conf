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
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/adapter/GooFlow.css" />
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
	<script type="text/javascript" src="../resource/comm/adapter/GooFunc.js"></script>
	<script type="text/javascript" src="../resource/comm/adapter/json2.js"></script>
	<script type="text/javascript" src="../resource/comm/adapter/GooFlow.js"></script>
	<script type="text/javascript" src="../resource/comm/adapter/GooFlowVariables${localeName}.js"></script>
	
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
	<script>

	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.adapter.sourceNode')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.adapter.targetNode')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.adapter.operation')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.adapter.operationValue')}" />';
	
   //search Function
   function do_operate(){
             $("input[type='hidden']").val(""); 
             }
    
	function deleteMethod(){ 					   
   }
   		 
   function addMehtod(){	  
   } 
             
  function updateMethod(){      
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
  function clickRow(obj,to,isR){
	  if(flag){
			 demo.blurItem();
			 //$("#my_"+toid).hide();
			 flag=false;
			 return;
		 }
	  var id = $(obj).attr("id");
	  var toid = $(to).attr("id");

	 // if(demo.$focusNode){
	//	  $("#"+demo.$focusNode ).hide();
	 // }
	 if(isR){
		  demo.focusItem(id,true);
		 // $("#"+demo.$focusNode ).hide();
		  demo.isRepeat = true;
		  demo.repeadId = id;
	 }else {
		 demo.blurItem();
		// $("#operate_"+toid).remove();
		// $("#my_"+toid).show();
		 demo.isRepeat = true;
		 demo.repeadId = id;
		 demo.$focusNode = "my_"+ toid;
	 }

	demo.changeRowColor();
	$(obj).attr('class','datagrid-row datagrid-row-selected');
  }
  
  function newGooflow(){
	   if ($('#'+scriptDemo).attr('class') != 'GooFlow') {
		  demo=new GooFlow($("#" + scriptDemo),{width:960,height:300,haveTool:true});
	  }
	  
  }
  
  function cancleAllLine(){
		$('g').each(function(){
			var id = $(this).attr("id");
			$('#' + id).trigger('click');
			$('.b_x').trigger('click');
        });
		$('tr[id^=demo_line]').remove();
  }
  
  function srcLoadDemo(){
	  	//Ã¥Â·Â¦Ã¨Â¾Â¹Ã§ÂÂÃ¥ÂÂÃ¨Â¡Â¨Ã§ÂÂ"left":5Ã¤Â¸ÂÃ¥Â®ÂÃ¨Â¦ÂÃ§Â­ÂÃ¤ÂºÂ5Ã¯Â¼ÂÃ§ÂÂ¨Ã¤ÂºÂÃ¥ÂÂ¤Ã¦ÂÂ­Ã¦ÂÂ¯Ã¥Â·Â¦Ã¨Â¾Â¹Ã§ÂÂÃ¨Â¡Â¨Ã¦Â Â¼Ã¨Â¿ÂÃ¦ÂÂ¯Ã¥ÂÂ³Ã¨Â¾Â¹Ã§ÂÂÃ¨Â¡Â¨Ã¦Â Â¼
	  	$('div[id^=L]').remove();
		/*demo.loadDataAjax(
				{"type":"POST",
				 "url":"../adapter/getNodeDesc.shtml",
				 "data":{
					"tcpCtrFId":$('#srcTcpCtrFId').val(),
					"loadSideFlg":"L",
					"contractType":$('#srcContractType').val()
					}
				});*/
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/getNodeDesc.shtml",
		    dataType:'json',
		    data:{tcpCtrFId:$('#srcTcpCtrFId').val(),loadSideFlg:"L",contractType:$('#srcContractType').val()},
			success:function(msg){ 
					  demo.loadData(msg);
					  saveContractAdapter();
              }
         });
  }
  
  function tarLoadDemo(){
	  
	  	$('div[id^=R]').remove();
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/getNodeDesc.shtml",
		    dataType:'json',
		    data:{tcpCtrFId:$('#tarTcpCtrFId').val(),loadSideFlg:"R",contractType:$('#tarContractType').val()},
			success:function(msg){ 
					  demo.loadData(msg);
					  saveContractAdapter();
              }
         });
  }
  
  function changeDemo(){
	  scriptDemo = "ScriptAdaptionDemo";
  }
 
  function openWind(spath,sname,tpath,lineid){
	  flag = true;
	  var str = "spath="+spath+"&sname="+sname+"&tpath="+tpath+"&lineid="+lineid;
	  openWindows_lock('${contextPath}/adapter/operate.shtml?'+str,'<s:property value="%{getText('eaap.op2.conf.adapter.chooseTemplate')}"/>',650,450,true);
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
		    data:{sourceMessageText:$('#sourceMessageText').val(),srcTcpCtrFId:src,tarTcpCtrFId:tar,transformerRuleId:$("#transformerRuleId").val()},
			success:function(msg){ 
				$("#testUniversalResult").val(msg);
          }
     });
	}
  
  function testScriptAdapter(){
	  var scriptFileText = $('#scriptFileText').val();
	  var originalFileText = $('#originalFileText').val();
	  var transformerRuleId = $("#transformerRuleId").val();
	  if('' == scriptFileText){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.script')}" />");
		  return;
	  }
	  if('' == originalFileText){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.original')}" />");
		  return;
	  }
	  if(0 == transformerRuleId){
		  alert("<s:property value="%{getText('eaap.op2.conf.contract.change')}" />");
		  return;
	  }
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/testScriptAdapter.shtml",
		    dataType:'text',
		    data:{scriptFileText:$('#scriptFileText').val(),originalFileText:$('#originalFileText').val(),adapterType:$('#adapterType').val(),transformerRuleId:$("#transformerRuleId").val()},
			success:function(msg){ 
				$("#resultsText").val(msg);
            }
       });
	}
  
  function saveScriptAdapter(){
	  if ($('#srcTcpCtrFIdScript').val() == "") {
		  alert("<s:property value="%{getText('eaap.op2.conf.adapter.sourceNotNull')}" />");
          return false;		  
	  }
	  if ($('#tarTcpCtrFIdScript').val() == "") {
		  alert("<s:property value="%{getText('eaap.op2.conf.adapter.targetNotNull')}" />");
          return false;		  
	  }
	  if ($('#scriptFileText').val() == "") {
		  alert("<s:property value="%{getText('eaap.op2.conf.adapter.contractScriptNotNull')}" />");
          return false;		  
	  }
	  
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/saveScriptAdapter.shtml",
		    dataType:'json',
		    data:{scriptFileText:$('#scriptFileText').val(),srcTcpCtrFId:$('#srcTcpCtrFIdScript').val(),tarTcpCtrFId:$('#tarTcpCtrFIdScript').val(),adapterType:$('#adapterType').val(),adapterTypeName: $("#adapterType").find("option:selected").text(),contractAdapterId:$('#contractAdapterId').val()},
			success:function(msg){ 
				var o = msg;
				$("#contractAdapterId").val(o.contractAdapterId);
				$("#transformerRuleId").val(o.contractAdapterId);
				if (o.msg == 'save'){
					alert("<s:property value="%{getText('eaap.op2.conf.adapter.saveSuccess')}" />");
				} else {
					alert("<s:property value="%{getText('eaap.op2.conf.adapter.updateSuccess')}" />");
				}
          }
     });
}
  
  function saveUniversalAdapter(){
	  
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
					alert("<s:property value="%{getText('eaap.op2.conf.adapter.saveSuccess')}" />");
				} else {
					alert("<s:property value="%{getText('eaap.op2.conf.adapter.updateSuccess')}" />");
				}
          }
     });
}


 function saveContractAdapter(){
	 if ($('#tarTcpCtrFId').val() == 0 || $('#srcTcpCtrFId').val() == 0) return;
	 if(""!=$('#contractAdapterID').val() || $('#contractAdapterID').val() > 0)return;
	 $.ajax({
			type: "POST",
			async:true,
		    url: "../adapter/saveAdapterConfig.shtml",
		    dataType:'json',
		    data:{sid:$('#srcTcpCtrFId').val(),tid:$('#tarTcpCtrFId').val(),type:'1',svname:$('#srcContractVersionName').val(),tvname:$('#tarContractVersionName').val()},
			success:function(msg){
				 $("#adapter_name").val(msg.adapter_name);
				 $("#contractAdapterID").val(msg.contractAdapterID);
				 $("#contractAdapterId").val(msg.contractAdapterID);
				 $("#transformerRuleId").val(msg.contractAdapterID);
           }
      });
 }
  function saveNode(lid){
	  flag = true;
	  var val = $("#"+lid+">td[field=sPath]>input[name=way]").val();
	  if(!val){
		  alert("<s:property value="%{getText('eaap.op2.conf.adapter.notOperator')}" />");
		  return;
	  }
	  $.ajax({
			type:'post',
			url:'${contextPath}/adapter/saveNodeDescMap.shtml',
			dataType:"json",
			data:{sid:$("#"+lid+">td[field=sPath]>input[name=sid]").val(),tid:$("#"+lid+">td[field=sPath]>input[name=tid]").val(),type:$("#"+lid+">td[field=sPath]>input[name=type]").val(),way:$("#"+lid+">td[field=sPath]>input[name=way]").val(),assignVal:$("#"+lid+">td[field=sPath]>input[name=assignVal]").val(),assignCondition:$("#"+lid+">td[field=sPath]>input[name=assignCondition]").val()},
			success: function(msg){
				$("#"+lid+">#dec>div>a").remove();
				$("#"+lid+">#dec>div").append("<span class=\"button-text\">OK<\span>");
 			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				
			}
		});
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
  function universalAdaptionTest(){
	  
  }
  function universalAdaptionSubmit(){
	  
  }
  
  $(document).ready( function(){
	  if($('#contractAdapterID').val()==0){
		  $('#contractAdapterID').val('');
		  $('#adapter_name').val('');
	  }
	  
	  setTimeout(function(){
		  $('div[class=datagrid-cell]').unbind('click');  
	  },1000);
	 
  });

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

<!-- å¼¹åºæ¡è¿åæ°æ® -->
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
			<ui:button text="%{getText('eaap.op2.conf.adapter.mapping')}" shape="S" skin="${contextStyleTheme}" onclick="autoMapping();" ></ui:button>
			<br/><br/>
		</div>
		
		<div id="UniversalAdapterDemo" style="padding-left:5px;" onselectstart="return false"></div> 

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
		<br/>
		
		
		<table align="center" class="mgr-table">
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
		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.prov.submit')}" onclick="saveUniversalAdapter()"></ui:button>
		</div>
		
</ui:tabpagediv>

<!-- -------------------------Ã§Â¬Â¬Ã¤ÂºÂÃ©ÂÂÃ©Â¡Â¹Ã¥ÂÂ¡---------------------------------------- -->
<ui:tabpagediv id="test2" title="%{getText('eaap.op2.conf.adapter.scriptAdapter')}"  closable="false"  style="padding:3px;">
		<div class="accordion-header" >
    			<div class="module-path-content" align="center">
    				<span class="accordion-header-icon" ><s:property value="%{getText('eaap.op2.conf.adapter.contractMaping')}" /></span>
         		</div>       
		</div>
		<br/>
		<div align="center">
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
		<br/>
			<div id="demo2" style="padding-left:50px;"></div> 
		<br/>
		

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
						<ui:textarea skin="${contextStyleTheme}" name="scriptFileText" id="scriptFileText" width="850"  value="${scriptFileText}"></ui:textarea>
	               </td>
	            </tr>
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


		</table>

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
		<div align="center">
			<ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.prov.submit')}" onclick="saveScriptAdapter()"></ui:button>
		</div>
</ui:tabpagediv>
</ui:tabpage>
</ui:form>
		
	  </dl>
	  </ui:form>
	  
<table class="mgr-table" style="display:none" id="confirm">
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseAdapter();"></ui:button>
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
	 </td>	
   </tr>
</table>
	  
	 </div>
   </div>
</div>
</body>
<script>
  function scriptAdaptionTest(){
	var scriptForm = $('#scriptForm'); 
	var scriptListValue = $("#scriptListValue").val();
 }
  function scriptAdaptionSubmit(){
	  var scriptForm = $('#scriptForm'); 
  }
  
  
  $(document).ready(function(){
	    $('div[class=datagrid-cell]').unbind('click');
		var choosePageState=$("#choosePageState").attr('value');
	    if(choosePageState!="")
	    {
	   	 document.getElementById("confirm").style.display= ""; 
	    }
  })
  
  
	$(document).ready(function(){
		 
		if ($('#transformerRuleId').val() > 0) {
			newGooflow();
			srcLoadDemo();
			
		  	$('div[id^=R]').remove();
		  	$.ajax({
				type: "POST",
				async:true,
			    url: "../adapter/getNodeDesc.shtml",
			    dataType:'json',
			    data:{tcpCtrFId:$('#tarTcpCtrFId').val(),loadSideFlg:"R",contractType:$('#tarContractType').val()},
				success:function(msg){ 
						  demo.loadData(msg);
	              }
	         });
		  	
		  	
		  	
		  	$.ajax({
				type: "POST",
				async:true,
			    url: "../adapter/getLineDesc.shtml",
			    dataType:'json',
			    data:{tarTcpCtrFId:$('#tarTcpCtrFId').val(),srcTcpCtrFId:$('#srcTcpCtrFId').val(),transformerRuleId:$('#transformerRuleId').val()},
				success:function(msg){ 
					demo.loadData(msg);
					$.each(msg.GooFlow_line_oper,function() {
						operNew(this.name,this.to);
						if(this.actionTypeCd == 'R'){
							$('#' + this.name + '>b[class=b_l7]').css('background-color','');
							$('#' + this.name + '>b[class=b_l9]').css('background-color','orange');
						}else if (this.actionTypeCd == 'A') {
							$('#' + this.name + '>b[class=b_l7]').css('background-color','orange');
							$('#' + this.name + '>b[class=b_l9]').css('background-color','');
						}});
					$.each(msg.GooFlow_line_Adapter,function() {lineAdapterNew(this)});//连接
	             }
	        });
		  	
		}
	})
	
	function showTime(msg) {
	  setTimeout(demo.loadData(msg), 1000);
	  $.each(msg.GooFlow_line_oper,function() {
		  operNew(this.name,this.to);
	  		});
	  $.each(msg.GooFlow_line_Adapter,function() {lineAdapterNew(this)});
   }
	
	function operNew(divName,lineStartId){
		var n1=$('#'+lineStartId);
		n1.append("<div class='GooFlow_line_oper_new' style='top:1px;z-index:10' id="+divName+" ><b class='b_l7' title='" + gooFlow_assign + "'></b><b class='b_l9' title='" + gooFlow_other + "'></b><b class='b_xx' title='" + gooFlow_move + "'  onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'></b></div>");//éå®çº¿æ¶æ¾ç¤ºçæä½æ¡
		demo.$focusNode = divName;
		$('#'+divName).on("click",{nodeId:lineStartId,inthis:demo},function(e){
			This=demo;
			if(!e)e=window.event;
			if(e.target.tagName!="B")	return;
			var nodeId=e.data.nodeId;
			switch($(e.target).attr("class")){
				case "b_xx":
					This.mySetRightLine(nodeId,"4");
					$('#my_'+nodeId).remove();
					This.$nodeData['my_'+nodeId]=null;
					break;
				case "b_l7":
					This.$innerLine['my_'+nodeId]=This.$nodeData[nodeId];
					This.mySetRightLine(nodeId,"5");
					break;
				case "b_l9":
					This.$innerLine['my_'+nodeId]=This.$nodeData[nodeId];
					This.mySetRightLine(nodeId,"6");
					break;
			}
		});
	}
	//连线操作
	function lineAdapterNew(lineAdapter){
		var from = lineAdapter.from;
		if (from == "null") {
			from = "";
		}
		demo.addRecod(lineAdapter.lineId,from,lineAdapter.to,lineAdapter.type,"");
		if (lineAdapter.from != "null" && lineAdapter.to != "null") {
			operActionOperaterNew(lineAdapter);
		}
		$('#' + lineAdapter.wayId).val(lineAdapter.wayVal);
		$('#' + lineAdapter.assignValId).val(lineAdapter.assignVal);
		$('#' + lineAdapter.assignConditionValueId).val(lineAdapter.assignConditionValue);
	}
	
	function operActionOperaterNew(lineAdapter){
		var lineid = lineAdapter.lineId;
		var toid = lineAdapter.lineId;
		var from = demo.$lineData[lineid].from;
		var sname = demo.$nodeData[from].name;
		var spath = demo.$nodeData[from].path;
		var to = demo.$lineData[lineid].to;
		var tpath = demo.$nodeData[to].path;
		var operate ='';
		if (lineAdapter.type == 'Update') {
			operate = "<div class='GooFlow_line_operator' style='top:1px;z-index:10'  id='operate_"+toid+"' onclick=\"openOperate('"+sname+"','"+spath+"','"+tpath+"','"+lineid+"');\"  onmouseover='this.style.backgroundColor=\"#FFFFFF\"' onmouseout='this.style.backgroundColor=\"\"'><b class='b_l8' title='gooFlow_operation'></b></div>";//" + gooFlow_operation + "
		} else if (lineAdapter.type == 'Move') {
			 operate = "<div class='GooFlow_line_operator' style='top:1px;z-index:10'  id='operate_"+toid+"'><b class='b_l5' title='gooFlow_operation_move'></b></div>";
		}
	    demo.$nodeDom[lineAdapter.to].append(operate);
	}
	
	function chooseAdapter()
	{
		var vOpener=art.dialog.opener;
	    var transformerRuleId = $("#transformerRuleId").val();
	    //var transformerRuleId = $("#contractAdapterId").val();
	    art.dialog.opener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,transformerRuleId,
	    document.getElementById("objectId").value,
	    document.getElementById("endpoint_Spec_Attr_Id").value);
	    
	   //parent.closeSelectValueSpecWin(); 
	    	art.dialog.close();
	 }
  
	function autoMapping(){
		if (!confirm("<s:property value="%{getText('eaap.op2.conf.adapter.autoMap')}" />")) return;
		var obj = demo.$nodeData;
		var leftReg = new RegExp("^L[0-9]*$");
		var rightReg = new RegExp("^R[0-9]*$");
		var jsonStr = '{"lines": {';
		var flag = false;
		var exitToStr= "";
		
		for(var k in demo.$lineData){
			exitToStr += demo.$lineData[k].to + ",";
		}

		$.each($('div[id^=my_]'), function (){
			exitToStr += this.id.replace('my_','') + ",";
		})
		
		$.each(obj, function (leftKey, leftValue) {
		  if (leftReg.test(leftKey)) {
			  
		      $.each(obj, function (rightKey, rightValue) {
		    	  
		        if (rightReg.test(rightKey) 
		            && leftValue.name.toUpperCase() == rightValue.name.toUpperCase()
		            && exitToStr.indexOf(rightKey) < 0
		            && rightValue.childCount == "0") {
		        	
		        		exitToStr += rightKey + ",";
	    				flag = true;
	    				//èªå¨æ å°å·²ç»çæçº¿çIDï¼ä¸éè¦éæ°çæ(addRecodå½æ°ä¸­ä¹ä¼çæID),è®¾ç½®isRepeat=falseã
	    				demo.isRepeat = false;
	    				
			        	var lineId = 'UniversalAdapterDemo_line_' + demo.$max++; //è¿ä¸ä¸ªæé®é¢
			        	jsonStr += '"' + lineId + '": {' 
			        		+ '"type": "sl",'
			        		+ '"from": "' + leftKey + '",'
			        		+ '"to": "' + rightKey + '",'
			        		+ '"name": "", "alt": true },';
			        		
			        	demo.addRecod(lineId,leftKey,rightKey,"Move","");
			        	demo.$nodeDom[rightKey].append(demo.actionOperateNew(lineId,"3"));
			        	
			        	$.ajax({
			    			type:'post',
			    			url:'${contextPath}/adapter/saveNodeDescMap.shtml',
			    			dataType:"json",
			    			data:{sid:leftValue.nodeDescId,tid:rightValue.nodeDescId,type:"M"},
			    			success: function(msg){
			     			}
			    		});
			        	
			        	demo.autoAddParentNode(rightKey);
		        }
		    })
		  }
		});
		if (flag) {
			jsonStr = jsonStr.substr(0,jsonStr.length - 1) + '},"areas": {},"initNum":' + demo.$max + '}';
			demo.loadData(JSON.parse(jsonStr));
		}
	}
	
	
</script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>