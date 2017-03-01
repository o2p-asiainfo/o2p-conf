<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title><s:property
		value="%{getText('eaap.op2.conf.orgregauditing.SysName')}" /></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />


<link rel="stylesheet" type="text/css"
	href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
<script type="text/javascript"
	src="${contextPath}/resource/comm/js/jquery.js"></script>
<s:property
	value="tagUtil.writeScript('/struts/simple/resource/jquery.js')"
	escape="false" />
<s:property
	value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}"
	escape="false" />
<s:property
	value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')"
	escape="false" />

</head>
<body>
	<script language="javascript">
		<s:iterator value="actionScripts">
		<s:property escape="false"/>
		</s:iterator>
	</script>

	<div class="sectionMain dokuwiki clearfix">
		<div class="contentWarp">
			<div class="module-path">
				<div class="module-path-content">
					<img
						src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" />

					<s:property
						value="%{getText('eaap.op2.conf.manualException.waitingtask')}" />
					<img
						src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />
					<s:property
						value="%{getText('eaap.op2.conf.manualException.exceptionCheck')}" />
				</div>
			</div>
			<div class="accordion-header">
				<div class="accordion-header-text">
					<span class="accordion-header-icon">
						&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<s:property
						value="%{getText('eaap.op2.conf.manualException.activitiInfo')}" />
				</div>
			</div>

			<div>
				<table class="mgr-table" id="manualDealInfo">
					<tr>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiId')}" />
						</td>
						<td class="item-content">${subData.actId}</td>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiName')}" />
						</td>
						<td class="item-content">${subData.actName}</td>
					</tr>
					<tr>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiType')}" />
						</td>
						<td class="item-content">${subData.actType}</td>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiDurationInMillis')}" />
						</td>
						<td class="item-content">${subData.durationInMillis}</td>
					</tr>
					<tr>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiStartTime')}" />
						</td>
						<td class="item-content">${subData.startTime}</td>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiEndTime')}" />
						</td>
						<td class="item-content">${subData.endTime}</td>
					</tr>
					<tr>
						<td class="item"><s:property
								value="%{getText('eaap.op2.conf.manualException.activitiTask')}" />
						</td>
						<td colspan="6" class="item-content">${subData.task}</td>
					</tr>
				</table>
			</div>


			<div class="accordion-header">
				<div class="accordion-header-text">
					<span class="accordion-header-icon">
						&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<s:property
						value="%{getText('eaap.op2.conf.manualException.messageDetail')}" />
				</div>
			</div>
			<div>
				<form name="checkPardMix">
					<input type="hidden" name="process_Id" id="process_Id"
						value="${process_Id}" /> <input type="hidden" name="activity_Id"
						id="activity_Id" value="${activity_Id}" /><input type="hidden"
						name="taskId" id="taskId" value="${subData.taskId}" /><input
						type="hidden" name="act_Id" id="act_Id" value="${act_Id}" />

					<table class="mgr-table" id="ErrMsgInfo">
						<tr>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionType')}" />
							</td>
							<td class="item-content"><c:if
									test="${exceptionLog.exceptionType==1006}">
							PRODUCT</c:if> <c:if test="${exceptionLog.exceptionType==1007}">
							PROD_OFFER</c:if> <c:if test="${exceptionLog.exceptionType==1008}">
							SERVICE</c:if> <c:if test="${exceptionLog.exceptionType==1009}">
							SETTLEMENT</c:if><c:if test="${exceptionLog.exceptionType==1010}">
							PARTNER</c:if></td>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionBusinessObjName')}" />
							</td>
							<td class="item-content">${exceptionLog.businessObjName}</td>
						</tr>

						<tr>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionBusinessObjId')}" />
							</td>
							<td class="item-content">${exceptionLog.objectId}</td>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionDestination')}" />
							</td>
							<td class="item-content">${exceptionLog.destination}</td>
						</tr>
						<tr>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionNextTach')}" />
							</td>
							<td colspan="5"><select name="nextTach" id="nextTach">
									<c:forEach items="${nextTachList}" var="nextTachMap">
										<option value="${nextTachMap.id}">${nextTachMap.name}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionResult')}" />
							</td>
							<td colspan="6" class="item-content">${exceptionLog.result}</td>
						</tr>
						<tr>
							<td class="item"><s:property
									value="%{getText('eaap.op2.conf.manualException.exceptionDetails')}" />
							</td>
							<td colspan="5"><textarea name="exceptionDetails"
									id="exceptionDetails" style="WIDTH: 100%; HEIGHT: 200px">${exceptionLog.exceptionDetails}</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="6" align="center"><ui:button
									skin="${contextStyleTheme}"
									text="%{getText('eaap.op2.conf.manualException.exceptionBtnResend')}"
									onclick="javascript:reSendMessage();" id="resendId"></ui:button>
								<ui:button skin="${contextStyleTheme}"
									text="%{getText('eaap.op2.conf.manualException.exceptionBtnCancel')}"
									onclick="cancelBtnCtr();" id="cancelId"></ui:button></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
</body>
</html>


<script type="text/javascript">
	function reSendMessage() {

		// 	 var selectText=$("#nextTach").find("option:selected").text(); //获取Select选择的Text 
		var selectValue = $("#nextTach").val();
		var taskId = $("#taskId").val();
		$.ajax({
			async : false,
			type : "POST",
			url : "${contextPath}/manual/reSendMessage.shtml",
			dataType : "json",
			data : {
				selectValue : selectValue,
				taskId : taskId
			},
			success : function(data) {

					var vOpener = art.dialog.opener;
					vOpener.reloadList();
					art.dialog.close();
			}
		});
	}
	
	
	function cancelBtnCtr(){
		var vOpener = art.dialog.opener;
		vOpener.reloadList();
		art.dialog.close();
	}
</script>
