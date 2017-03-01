<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.expression')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.testPiles.responseMessageMod')}"/>';
title[2]='<s:property value="%{getText('eaap.op2.conf.testPiles.remark')}"/>';
</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.testPiles.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
		        <c:if test="${editOrAdd =='edit'}">
		     	    <s:property value="%{getText('eaap.op2.conf.testPiles.updateTestMsgMod')}" />
		   	    </c:if>
		   	    <c:if test="${editOrAdd =='add'}">
					<s:property value="%{getText('eaap.op2.conf.testPiles.addTestMsgMod')}" />		   		  
			    </c:if>		 
      	</div>
    </div>
    
		<div class="selectList" style="display:block;">	
		<ui:form method="post" id="myForm" action="editTestMsgMod.shtml">	
             <input type="hidden" id="modId" name="testMsgMod.modId" value="${modId}"/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value="${editOrAdd}"/>
			<ui:validators validateAlert="word" validatorGroup="group1"> 
				<ui:validator fieldId="modName" validatorType="stringlength" minLength="1" maxLength="100" message="%{getText('eaap.op2.conf.testPiles.notexceed100char')}"/>
				<ui:validator fieldId="requestMessageMod" validatorType="requiredstring" message="%{getText('eaap.op2.conf.testPiles.requestMessageMod')} %{getText('eaap.op2.conf.testPiles.notNull')}"/>
			</ui:validators>

		 	<table class="mgr-table">
            <tr>
              <td class="item" style="width:20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.modName')}"/>:</td>
              <td  width="80%"><ui:inputText skin="${contextStyleTheme}"  name="testMsgMod.modName"  id="modName" value="${testMsgMod.modName}"  style="width:700px"></ui:inputText></td>
            </tr>
            <tr>
              <td class="item" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.msgFormat')}" />:</td>
              <td >
              		<ui:select skin="${contextStyleTheme}"  emptyOption="true" name="testMsgMod.msgFormatType" id="msgFormatType" value="${testMsgMod.msgFormatType}"
    			       list="formatTypeList" listKey="key" listValue="value" style="width:70px;" ></ui:select>
              </td>
            </tr>
            <tr>
              <td class="item" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.requestMessageMod')}"/>:</td>
              <td >
               <ui:textarea skin="${contextStyleTheme}" name="testMsgMod.requestMsgMod"  id="requestMessageMod"   value="${testMsgMod.requestMsgMod}" width="700" height="100"></ui:textarea>
               </td>
            </tr>
            <tr style="display:none;">
              <td class="item" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.expressionFlag')}" />:</td>
              <td >
              		<ui:select skin="${contextStyleTheme}"  emptyOption="true" name="testMsgMod.expressionFlag" id="expressionFlag" value="${testMsgMod.expressionFlag}"
    			       list="expFlagList" listKey="key" listValue="value" style="width:70px;" onchange="expressionFlagChg()"></ui:select>
              </td>
            </tr>
            <tr id="responseMessageModTr"  >
              <td class="item" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.responseMessageMod')}"/>:</td>
              <td >
               <ui:textarea skin="${contextStyleTheme}" name="testMsgMod.responseMsgMod"  id="responseMessageMod"   value="${testMsgMod.responseMsgMod}" width="700" height="100"></ui:textarea>
               </td>
            </tr>
            <tr>
              <td class="item" style="width:20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.delayTime')}"/>:</td>
              <td  width="80%">
  					<div style="width:100%; clear:both">
		              		<ui:inputText skin="${contextStyleTheme}"  name="testMsgMod.delayTime"  id="delayTime" value="${testMsgMod.delayTime}"  style="width:145px"></ui:inputText>
		              		(0~10000)
		              		<span id="delayTimeCheckImg" ></span>
  					</div>
	  		    	<div id="delayTimeCheckMsg"  style="display:none; width:100%;font-size:14px; color:#FF0000; line-height:22px;clear:both;"></div>
              </td>
            </tr>
            <tr>
              <td class="item" ><s:property value="%{getText('eaap.op2.conf.testPiles.remark')}"/>:</td>
              <td >
               <ui:textarea skin="${contextStyleTheme}" name="testMsgMod.remark"  id="remark"   value="${testMsgMod.remark}" width="700" height="40"></ui:textarea>
               </td>
            </tr>
    	  </table>
		</ui:form>
		
		<c:if test="${editOrAdd =='edit'}">
			<dl class="noBorder"  id="testMsgModResponseListDiv" >
			<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="testMsgModResponseList" remoteSort="false" sortOrder="desc"  toolbar="true" queryParams="true"  queryParamsData="${testMsgMod.modId}"
					skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.testPiles.msgModResponseList')}" striped="true"  pagination="true" frozenColumns="true" rownumbers="true"    fitHeight="210" 
					method="eaap-op2-conf-testPiles-TestPilesAction.getTestMsgModResponseListByModId">
				<ui:gridEasyColumn width="120" index="0" title="0" field="EXPRESSION" hidden="false" align="center" ></ui:gridEasyColumn>
				<ui:gridEasyColumn width="120" index="1" title="1" field="RESPONSE_MSG_MOD" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="120" index="2" title="2" field="REMARK" hidden="false" align="center" ></ui:gridEasyColumn>
				<ui:gridEasyColumn width="0" index="3" title="3" field="MOD_ID" hidden="true" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="0" index="4" title="4" field="MSG_ID" hidden="true" align="center"></ui:gridEasyColumn>
			</ui:gridEasy>
			</dl>
		</c:if>
	</div>
	<div>
		<table  align="center">
		    <tr>
				<td id="nextButTr"  align="center" >
				  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.next')}" id="nextBut" onclick="saveTestMsgModData()"></ui:button>
				</td>
				<td id="saveButTr"  align="center" style="display:none;">
				  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.save')}" id="saveBut" onclick="saveTestMsgModData()"></ui:button>
				</td>
				<td align="center">
						<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}"  shape="M" id="checkcancelId" onclick="returnPage();"></ui:button>
				</td>
			</tr>
		</table>
	</div>
</div>
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>
<script>		
	$(document).ready(function(){
		var editOrAdd	= "${editOrAdd}";
    	var expressionFlag = "${testMsgMod.expressionFlag}";
    	if(editOrAdd=="edit"){
    		//if(expressionFlag=="1"){
        		$("#testMsgModResponseListDiv").show();
        	//}else{
        	//	$("#testMsgModResponseListDiv").hide();
        	//}
    		
       		$("#nextButTr").hide();
       		$("#saveButTr").show();
    	}

		
    	$(".datagrid-pager").prop('outerHTML', '');
	});
	
	var oldVal = "${testMsgMod.delayTime}";
	$("#delayTime").keyup(function(){
		var  val = this.value.replace(/[^\d]/g,'');
		if(val!=""){
			val = parseInt(val);
		}else{
			val = 0;
		}
		if(val>10000){
			val = oldVal;
		}
		oldVal = val;
		this.value=val;
	});
	$("#delayTime").blur(function(){
		var  val = this.value.replace(/[^\d]/g,'');
		if(val!=""){
			val = parseInt(val);
		}else{
			val = 0;
		}
		if(val>10000){
			val = oldVal;
		}
		oldVal = val;
		this.value=val;
		checkDelayTimeCount();
	});
	
	var delayTimeCount=0;
	var delayTimeOld = "${testMsgMod.delayTime}";
	function checkDelayTimeCount(){
		var editOrAdd	= "${editOrAdd}";
		var delayTime	 = jQuery.trim($("#delayTime").val());
		if(delayTime>0 && delayTimeOld==0){
			$("#delayTimeCheckImg").html("<img src='../resource/comm/images/loading.gif'/>");
			$("#delayTimeCheckMsg").html("");
			$("#delayTimeCheckMsg").css('display','none'); 
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../testPiles/checkDelayTimeCount.shtml",
			     dataType:"text",
			     data:"",
			     success:function(msg,data){
						$("#delayTimeCheckImg").html("");
						try {
				      		var jsonObj = eval('(' + msg + ')'); 
				      		delayTimeCount= jsonObj[0].count;
				      		if(delayTimeCount >=10 && editOrAdd=="add"){
								$("#delayTimeCheckMsg").html("<s:property value="%{getText('eaap.op2.conf.testPiles.delayTimeCheckMsg')}" />");
								$("#delayTimeCheckMsg").css('display','block'); 
					      	}else if(delayTimeCount >=10 && editOrAdd=="add"){
								$("#delayTimeCheckMsg").html("<s:property value="%{getText('eaap.op2.conf.testPiles.delayTimeCheckMsg')}" />");
								$("#delayTimeCheckMsg").css('display','block'); 
					      	}else if(editOrAdd=="edit"  && delayTimeOld>0){
								$("#delayTimeCheckMsg").html("");
								$("#delayTimeCheckMsg").css('display','none'); 
					      	}else{
								$("#delayTimeCheckMsg").html("");
								$("#delayTimeCheckMsg").css('display','none'); 
					      	}
						} catch (e) {
						}
		   	  	}
			});	
		}else{
			$("#delayTimeCheckMsg").html("");
			$("#delayTimeCheckMsg").css('display','none'); 
		}
	}

	function updateTestMsgMod(){
			var form = document.getElementById("myForm");
		  	if(comm_validators_check('group1'))
	       	{
	       	    form.action="editTestMsgMod.shtml";
	       		form.submit();				
	       	}	
	}
		
    function returnPage() {
		window.location="showTestMsgMod.shtml";
    }
		
    function check_num(obj){
        obj.value = obj.value.replace(/[^\d]/g,'');
    }
    function check_num2(obj){
		obj.value = jQuery.trim(obj.value);
    }
    
    function expressionFlagChg(){
    	var expressionFlag = $("#expressionFlag").val();
    	if(expressionFlag=="1"){
    		$("#responseMessageModTr").hide();
    	}else{
    		$("#responseMessageModTr").show();
    	}
    	var editOrAdd	= $("#editOrAdd").val();
    	if(editOrAdd=="add"){
    		if(expressionFlag=="1"){
        		$("#nextButTr").show();
        		$("#saveButTr").hide();
        	}else{
        		$("#nextButTr").hide();
        		$("#saveButTr").show();
        	}
    	}
    	if(editOrAdd=="edit"){
    		if(expressionFlag=="1"){
        		$("#testMsgModResponseListDiv").show();
        	}else{
        		$("#testMsgModResponseListDiv").hide();
        	}
    	}
    }
    
    function saveTestMsgModData(){
    	//if(comm_validators_check('group1')){
	    	var modId 								= $("#modId").val();
	    	var modName 						= jQuery.trim($("#modName").val());
	    	var msgFormatType 				= $("#msgFormatType").val();
	    	var requestMessageMod		= jQuery.trim($("#requestMessageMod").val());
	    	var responseMessageMod	= jQuery.trim($("#responseMessageMod").val());
	    	var remark 								= jQuery.trim($("#remark").val());
	    	var delayTime							= jQuery.trim($("#delayTime").val());
	    	var expressionFlag					= $("#expressionFlag").val();
	    	var editOrAdd 						= $("#editOrAdd").val();

	    	if(expressionFlag=="0" && responseMessageMod==""){
	    		alert("<s:property value='%{getText(\"eaap.op2.conf.testPiles.responseMessageMod\")}' /> <s:property value='%{getText(\"eaap.op2.conf.testPiles.notNull\")}' />");
	    		$("#responseMessageMod").focus();
	    		return;
	    	}
	
	    	if(editOrAdd=="edit" && expressionFlag=="1"){
				var  rowSize = $("#testMsgModResponseList").datagrid('getRows').length;
				if(rowSize=="0"){
		      		//alert("<s:property value="%{getText('eaap.op2.conf.testPiles.pleaseSetResponseMsgMod')}" />");
		      		//return;
				}
	    	}
	    	
	    	if(delayTimeCount >=10 && delayTime>0 && delayTimeOld==0){
	    		$("#delayTime").focus();
				$("#delayTimeCheckMsg").html("<s:property value="%{getText('eaap.op2.conf.testPiles.delayTimeCheckMsg')}" />");
				$("#delayTimeCheckMsg").css('display','block'); 
	    		return;
	    	}

	    	if(delayTime==""){
	    		delayTime=0
	    	}
	    	
	    	$.ajax({
	    	     type:"post",
	    	     async:false,
	    	     url:"../testPiles/saveTestMsgModData.shtml",
	             dataType:"json",
	             data:{
	            	 "testMsgMod.modId" : modId,
	            	 "testMsgMod.modName" : modName,
	            	 "testMsgMod.msgFormatType" : msgFormatType,
	            	 "testMsgMod.requestMsgMod" : requestMessageMod,
	            	 "testMsgMod.responseMsgMod" : responseMessageMod,
	            	 "testMsgMod.remark" : remark,
	            	 "testMsgMod.expressionFlag" : expressionFlag,
	            	 "testMsgMod.delayTime" : delayTime,
	            	 editOrAdd : editOrAdd
	            	 },
	    	     success:function(msg,data){
	    				try {
					 		var isjson = typeof(msg)=="object" && Object.prototype.toString.call(msg).toLowerCase() == "[object array]" && msg.length>0; 
							if(isjson){
	    			      		var rEditOrAdd = msg[0].editOrAdd;
	    				      	if(rEditOrAdd != null && rEditOrAdd=="add" && expressionFlag=="1"){
	    	    					window.location="${contextPath}/testPiles/gotoEditTestMsgMod.shtml?editOrAdd=edit&modId="+modId
	    				      	}else{
	    				      		window.location="${contextPath}/testPiles/showTestMsgMod.shtml";
	    				      	}
					      	}
	    				} catch (e) { 
	    			      		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
	    				}
	    	   	  }
	    	});	
    	//}
    }
    


    function addMehtod(){
    	var modId	= $("#modId").val();
    	openWindows("${contextPath}/testPiles/testMsgModResponseEdit.shtml?modId="+modId,"");
    } 

    function updateMethod(){
    	var msgId	=  $('#testMsgModResponseList').datagrid('getSelections')[0].MSG_ID;
    	openWindows("${contextPath}/testPiles/testMsgModResponseEdit.shtml?msgId="+msgId,"");
    }

    function deleteMethod(){
    	    if($('#testMsgModResponseList').datagrid('getSelections')[0]==null) {
    		   	  alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
    		 }else{
    			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))	{
    			      var msgId	=  $('#testMsgModResponseList').datagrid('getSelections')[0].MSG_ID;
    				  var ajax_data = "testMsgModResponse.msgId="+msgId;
    				  $.ajax({
    				          type:"post",
    				          async:false,
    				          url:"../testPiles/deleteTestMsgModResponse.shtml",
    				          dataType:"json",
    				          data:ajax_data,
    				          success:function(msg,data){
    					          $("#testMsgModResponseList").datagrid("reload");
    						  }
    				  });
    			  }
    		 }
    }

    function reloadList(){
    	$('#testMsgModResponseList').datagrid('reload');
    }
</script>
