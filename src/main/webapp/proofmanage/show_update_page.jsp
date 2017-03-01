<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>

<title>show_proof_page.jsp</title>
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
				<s:property value="%{getText('eaap.op2.conf.proof.viewtype')}" />
			</div>
		</div>

		<div>
			<ui:form id="addproof" name="addproof" action="../proofeffect/add_ProofEffect.shtml"
				method="post">
				<input type="hidden" id="hide_proofe_id" value="${prooffId}"/>
				<input type="hidden" id="ifshowButton" value="${flag}"/>
				<ui:validators validateAlert="div" validatorGroup="group2">
						
						<c:forEach var="proof" items="${prooflList}" step="1" varStatus="status"> 
							<ui:validator fieldId="checkValue${status.index+1}"
								validatorType="requiredstring" required="true" message="%{getText('eaap.op2.conf.proof.notEmpty')}" />
						</c:forEach>
					</ui:validators>
				<div class="module-path">
					<div class="module-path-content" align="center">
						<s:property
							value="%{getText('eaap.op2.conf.proof.baseInfo')}" />
					</div>
				</div>
				<table class="mgr-table">
					<tr>
						<td class="item" style="width: 20%;">
							<s:property value="%{getText('eaap.op2.conf.proof.pt_name')}" />:</td>
						<td class="item-content" style="width: 80%;">
									 <ui:select
										skin="${contextStyleTheme}" name="pt_cd" id="pt_cd"
										list="listProofType" width="157" headerValue=" " disabled="true" value="${pt_cd}"
										listKey="PT_CD" listValue="PT_NAME"></ui:select>
						</td>
					</tr>
					<tr>
				    <td class="item" style="width: 20%;"><font color="red">*</font>
							<s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />:</td>
					<td class="item-content" style="width: 80%;">
					<ui:inputText skin="${contextStyleTheme}"  id="myComponentName" name="comName" textSize="25" readonly="true" value="${comName}" style="float:left;"/>
    				    
					</td>
				    </tr>
					<!-- ############start########### -->
				<c:forEach var="proof" items="${prooflList}" step="1" varStatus="status"> 
    		    <tr>  
    		       <td class="item" style="width: 20%;">${proof.PR_ATR_SPEC_NAME}:</td>
    		       <td  class="item-content" style="width: 80%;">
    		        <c:if test="${proof.DISPLAY_TYPE=='10'}">
    		          <ui:inputText skin="${contextStyleTheme}"  textSize="25" name="attrValues" id="checkValue${status.index+1}" value="${proof.ATTR_VALUE}"></ui:inputText>
    		        </c:if>
    		         <c:if test="${proof.DISPLAY_TYPE=='12'}">
    		          <input type="hidden" name="attrValues"  value="${proof.ATTR_VALUE}"/>
    		          <ui:inputText skin="${contextStyleTheme}" textSize="25" type="password" name="" onfocus="javascript:clearValue(this);" onblur="javascript:encodeValue(this);" id="checkValue${status.index+1}" value="******"></ui:inputText>
    		        </c:if>
    		         <c:if test="${proof.DISPLAY_TYPE=='11'}">
    		         
    		          <ui:select skin="${contextStyleTheme}" width="157"  name="attrValues" id="checkValue${status.index+1}"  value="'${proof.ATTR_VALUE}'"
    			      list="attrValuesList" listKey="ATTR_VALUE" listValue="ATTR_VALUE_NAME" params="ATTR_SPEC_ID:${proof.ATTR_SPEC_ID}"></ui:select>
    			       
    		        </c:if>
    		        
    		         <c:if test="${proof.DISPLAY_TYPE=='15'}">
    		           <textarea rows="5" cols="30" name="attrValues" id="checkValue${status.index+1}">${proof.ATTR_VALUE}</textarea>
    		         </c:if>
    		        </td>
    		    </tr>
    		   </c:forEach>
    		   <!-- ############end########### -->
				</table>
			</ui:form>
			<div align="center">
			    <ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.supplier.save')}"
					onclick="javascript:saveDate();"></ui:button>
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}"
					onclick="history.go(-1);"></ui:button>
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
var sureAdd = "<s:property value="%{getText('eaap.op2.conf.proof.sureUpdate')}" />";
function clearValue(obj){
	obj.value = "";
	$(obj).prev('input').val("");
}
function encodeValue(obj){
	var pwd = obj.value;
	if("" != pwd){
		$.ajax({
	        type:"post",
	        async:false,
	        url:"../proofeffect/encodePwd.shtml",
	        dataType:"text",
	        data:{pagePwd:pwd},
	        success:function(msg){
	           if("fail" != msg){
	        	   $(obj).prev('input').val(msg);
	           }
	        }
	    });
	}
}
function saveDate(){
	var prooffId = $('#hide_proofe_id').val();
	var flag = $('#ifshowButton').val();
	if(comm_validators_check('group2')){
	art.dialog.confirm(operationTip,sureAdd, function () {
		$('#addproof').attr('action','../proofeffect/submit_updatePro.shtml?prooffId='+prooffId+'&flag='+flag);
		addproof.submit();
	},function(){});
	}
}
</script>
</html>

