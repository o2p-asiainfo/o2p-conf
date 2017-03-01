<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>

<title>addhideprocess.jsp</title>
<s:property
	value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}"
	escape="false" />
<s:property
	value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')"
	escape="false" />
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
</head>

<body>
	<div class="contentWarp">
		<div class="module-path">
			<div class="module-path-content">
				<img
					src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" />
				<s:property
					value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
				<img
					src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />
				<s:property value="%{getText('eaap.op2.conf.proof.Addingauthenticationtype')}" />
			</div>
		</div>

		<div>
			<ui:form id="addproof" name="addproof" action="#"
				method="post">
<input id="rowIndex" name="rowIndex" value="${rowIndex}" type="hidden">
<input id="reqRspFlag" name="reqRspFlag" value="${reqRspFlag}" type="hidden">
				<div class="module-path">
					<div class="module-path-content" align="center">
						<s:property
							value="%{getText('eaap.op2.conf.proof.baseInfo')}" />
					</div>
				</div>
				<table class="mgr-table">
				    
				    
					<tr>
						<td class="item" style="width: 20%;"><font color="red">*</font>
							<s:property value="%{getText('eaap.op2.conf.process.type')}" />:</td>
						<td class="item-content" style="width: 80%;">
						 <ui:select
										skin="${contextStyleTheme}" name="fuzzyModel.fuzzyType" id="fuzzyType"
										list="type" width="157" 
										listKey="id" listValue="val" onchange="javascript:changeShowFrame(this.value);"></ui:select>
						</td>
					</tr>
					<tr id="Id_fuzzySymbols">
				    <td class="item" style="width: 20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.process.alternativeSymbols')}" />:</td>
					<td class="item-content" style="width: 80%;">
					<ui:inputText skin="${contextStyleTheme}"  id="fuzzySymbols" textSize="25" name="fuzzyModel.fuzzySymbols" style="float:left;"/>		    
					</td>
				    </tr>
				    <tr id="Id_fuzzyStart">
				    <td class="item" style="width: 20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.process.startingPosition')}" />:</td>
					<td class="item-content" style="width: 80%;">
					<ui:inputText skin="${contextStyleTheme}"  id="fuzzyStart" textSize="25" name="fuzzyModel.fuzzyStart" onchange="javascript:validateNum('fuzzyStart',this.value);" style="float:left;"/>		    
					</td>
				    </tr>
				    <tr id="Id_fuzzyEnd">
				    <td class="item" style="width: 20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.process.endPosition')}" />:</td>
					<td class="item-content" style="width: 80%;">
					<ui:inputText skin="${contextStyleTheme}"  id="fuzzyEnd" textSize="25" name="fuzzyModel.fuzzyEnd" onchange="javascript:validateNum('fuzzyEnd',this.value);" style="float:left;"/>		    
					</td>
				    </tr>
				</table>
			</ui:form>
			<div align="center">
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.supplier.save')}"
					onclick="javascript:saveDate();"></ui:button>
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}"
					onclick="javascript:history.go(-1);"></ui:button>
			</div>
		</div>
	</div>
	<ui:iframe skin="${contextStyleTheme}" iframeWidth="900"
		iframeHeight="450" divId="opendialog" divTitle="choose org"
		iframeId="iframe_org" iframeSrc="" iframeScrolling="no"
		frameborder="10" />
</body>
<script>
var operationTip = "<s:property value="%{getText('eaap.op2.conf.proof.OperationTips')}" />";
var sureAdd = "<s:property value="%{getText('eaap.op2.conf.proof.sureAdd')}" />";

function saveDate(){
	var type = $('#fuzzyType').val();
	var fuzzySymbols = $('#fuzzySymbols').val();
	var fuzzyStart = $('#fuzzyStart').val();
	var fuzzyEnd = $('#fuzzyEnd').val();
	if(2 != type){
		if('' == fuzzySymbols){
			alert('fuzzySymbols is not null');
			return ;
		}else{
			if(fuzzySymbols.length > 1){
				alert('fuzzySymbols is too long');
				return ;
			}
		}
		if('' == fuzzyStart){
			alert('fuzzyStart is not null');
			return ;
		}
		if('' == fuzzyEnd){
			alert('fuzzyEnd is not null');
			return ;
		}
	}
	$('#addproof').attr('action','../operatorlog/addhideProcess.shtml');
	addproof.submit();
}
function changeShowFrame(value){
	if(2 == value){
		$('#Id_fuzzySymbols').hide();
		$('#Id_fuzzyStart').hide();
		$('#Id_fuzzyEnd').hide();
	}else{
		$('#Id_fuzzySymbols').show();
		$('#Id_fuzzyStart').show();
		$('#Id_fuzzyEnd').show();
	}
}
function validateNum(id,value){
	if(!check_validate1(value)){
		$('#'+id).val('');
	}
}
function check_validate1(value){    
 var reg = new RegExp("^[0-9]*$");
 if(!reg.test(value)){
     return false;
 }
 return true;
}
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
</script>
</html>

