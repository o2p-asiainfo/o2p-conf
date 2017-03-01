<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>

<title>add_proof_page.jsp</title>
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
			<ui:form id="addproof" name="addproof" action="../proofeffect/add_ProofEffect.shtml"
				method="post">
				<input type="hidden" id="flag" name="flag" value="${flag}"/>
				<ui:validators validateAlert="div" validatorGroup="group2">
						<ui:validator fieldId="myComponentId"
							validatorType="requiredstring" required="true" message="%{getText('eaap.op2.conf.proof.notEmpty')}" />
						<ui:validator fieldId="pt_cd"
							validatorType="requiredstring" required="true" message="%{getText('eaap.op2.conf.proof.notEmpty')}" />
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
						<td class="item" style="width: 20%;"><font color="red">*</font>
							<s:property value="%{getText('eaap.op2.conf.proof.pt_name')}" />:</td>
						<td class="item-content" style="width: 80%;">
									<intput type="hidden" id="hide_proofe_id"> <ui:select
										skin="${contextStyleTheme}" name="pt_cd" id="pt_cd"
										list="listProofType" width="157" headerValue=" " emptyOption="true"
										listKey="PT_CD" listValue="PT_NAME" onchange="addproof.submit();"></ui:select>
						</td>
					</tr>
					<tr>
				    <td class="item" style="width: 20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />:</td>
					<td class="item-content" style="width: 80%;">
					<ui:inputText skin="${contextStyleTheme}"  id="myComponentName" name="myComponentName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('myComponentName','myComponentId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="myComponentId" name="componentId"/>                                   
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=myComponentName&chooseCompCode=myComponentId','Choose Component')" shape="s"></ui:button>
					</td>
				    </tr>
					
					<!-- ############start########### -->
				<c:forEach var="proof" items="${prooflList}" step="1" varStatus="status"> 
    		    <tr>  
    		       <td class="item" style="width: 20%;"><font color="red">*</font>${proof.PR_ATR_SPEC_NAME}:</td>
    		       <td  class="item-content" style="width: 80%;">
    		        <c:if test="${proof.DISPLAY_TYPE=='10'}">
    		          <ui:inputText skin="${contextStyleTheme}" textSize="25" name="attrValues" id="checkValue${status.index+1}" value="${proof.ATTR_VALUE}"></ui:inputText>
    		        </c:if>
    		        <c:if test="${proof.DISPLAY_TYPE=='12'}">
    		          <ui:inputText skin="${contextStyleTheme}" textSize="25" type="password" name="attrValues" id="checkValue${status.index+1}" value="${proof.ATTR_VALUE}"></ui:inputText>
    		        </c:if>
    		         <c:if test="${proof.DISPLAY_TYPE=='11'}">
    		         
    		          <ui:select skin="${contextStyleTheme}" width="157" name="attrValues" id="checkValue${status.index+1}"  value="${proof.ATTR_VALUE}"
    			      list="attrValuesList" listKey="ATTR_VALUE" listValue="ATTR_VALUE_NAME" params="ATTR_SPEC_ID:${proof.ATTR_SPEC_ID}"></ui:select>
    			       
    		        </c:if>
    		        
    		         <c:if test="${proof.DISPLAY_TYPE=='15'}">
    		           <%--<ui:textarea  skin="${contextStyleTheme}"    name="attrValues" id="attrValues" value="${proof.ATTR_VALUE}"/>  --%>
    		           <textarea rows="5" cols="30" name="attrValues" id="checkValue${status.index+1}"></textarea>
    		         </c:if>
    		         <input type="hidden" name="ptSpecs" value="${proof.PT_CD},${proof.PR_ATR_SPEC_CD}"/>
    		        </td>
    		    </tr>
    		   </c:forEach>
    		   <!-- ############end########### -->
					<tr>
					<%-- 
						<td class="item-center" colspan="4"><ui:button
								skin="${contextStyleTheme}" id="show_button"
								text="%{getText('eaap.op2.conf.server.supplier.save')}"
								onclick="javascript:changeOperation();"></ui:button></td>--%>
					</tr>
				</table>
			</ui:form>
			<div align="center">
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.supplier.save')}"
					onclick="javascript:saveDate();"></ui:button>
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}"
					onclick="window.location.href='../proofeffect/showProofEffect.shtml';"></ui:button>
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
	var flag = $('#flag').val();
	if(comm_validators_check('group2')){
	art.dialog.confirm(operationTip,sureAdd, function () {
		$('#addproof').attr('action','../proofeffect/submit_ProofEffect.shtml');
		addproof.submit();
	},function(){});
	}
}
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
</script>
</html>

