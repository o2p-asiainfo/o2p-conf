<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<include file="com/linkage/rainbow/ui/views/action/struts-comm-package.xml" />

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
			%>
<html>
	<head>
<link rel="stylesheet" type="text/css"
			href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=${contextStyleTheme}" ></script> 
<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script>
	</head>
	 
	<body>
		<!--body start -->
		<s:actionerror/>
		<s:actionmessage/>
		
	 
		<ui:form method="post" name="addWorkFlowForm" id="addWorkFlowForm"
			action="">
  		 <ui:validators validateAlert="div" validatorGroup="group1"> 
		    <ui:validator fieldId="bizName" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.bizFunNameIsNull')}"></ui:validator>
			<ui:validator fieldId="bizCode" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.bizFunCodeIsNull')}"></ui:validator>
		 </ui:validators>			
			<ui:inputText name="BizFunction.bizFunctionId" type="hidden" id="bizFunctionId" skin="${contextStyleTheme}" value="${bizFunction.bizFunctionId }"></ui:inputText>
 
			<div class="contentWarp">
				<div>
					<div class="accordion-header">
						<div class="accordion-header-text">
							<span><span class="accordion-header-icon">
									&nbsp;&nbsp;&nbsp;&nbsp;</span> 
							 </span>
						</div>	
					</div>
					<table class="mgr-table">
						<tr>
							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.server.manager.workFlowName')}" />
								:
							</td>
							<td class="item-content">
								<ui:inputText type="text" skin="${contextStyleTheme}" name="BizFunction.name"
									id="bizName" value="${bizFunction.name }"/>
												  
							</td>

							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.directory.manager.dirUpLevel')}" />
								:
							</td>
							<td class="item-content">
	
					<ui:seltree id="dewe" skin="${contextStyleTheme}" method="eaap-op2-conf-workFlow-manager-WorkFlowManagerAction.getBizData" operationName="" handleName=""   textId="ce"  chkStyle="radio" 
 		            attrId="qweid" attrPid="qwepId"  attrName="qwepName" params="bizFunctionId:${bizFunction.bizFunctionId }" textHeight="22px" textWidth="192px" attrIsParent="qweIsParent" saveIdTextId="BizId" saveIdTextName="BizName">
 		            </ui:seltree>
 		            <script>
 		            	var name = '${dirName}';
 		            	var id = '${bizFunction.bizBizFunctionId }';
 		            	$('#ce').val(name);
 		            	$("#BizId").val(id);
 		            </script>
 		            </td>
						</tr>
						<tr>
							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.server.manager.workFlowCode')}" />
								:
							</td>
							<td class="item-content">
								<ui:inputText type="text" name="BizFunction.code" skin="${contextStyleTheme}"
									id="bizCode" value="${bizFunction.code }"/>
												  
							</td>
							<td colspan="2"></td>
							
							</tr>
                       <tr>
                       </tr>

						<tbody id="cfgTable"></tbody>
						<tr>
							
							
							<td colspan="4" style="TEXT-ALIGN: center;">
								
								<ui:button skin="${contextStyleTheme}" id="butSubmit" onclick="if(comm_validators_check('group1')){updateWorkflow();}"
									text="%{getText('eaap.op2.conf.directory.manager.dirSubmit')}" />
 
								<ui:button skin="${contextStyleTheme}" id="butCancel" onclick="art.dialog.close();"
									text="%{getText('eaap.op2.conf.directory.manager.dirCancel')}" />


							</td>

						</tr>
					</table>
				</div>
			</div>
		</ui:form>

		<div id="dialog" style="display: none;">
			<form id="test" method="post">
			</form>
		</div>
		
		<ui:iframe skin="${contextStyleTheme}" iframeWidth="480" iframeHeight="235" divId="opendialog"
			divTitle="upload image" iframeId="iframe_map" iframeSrc=""
			iframeScrolling="no" frameborder="10" />

		<!--body end -->

	</body>

	<script> 
	function closeWin(){
	 $('#opendialog').window('close');
	 }
	 
	function ale()
	{
		 
	}
	 
	 function addServiceManager(){
    		  	$('#dialog').show();
                $('#dialog').dialog({
                	title:"<s:property value="%{getText('eaap.op2.conf.directory.manager.dirCancel')}" />",
                	collapsible: true, 
					minimizable: false, 
					maximizable: true,
					width: 500, 
					height: 300,
					modal:true,
					buttons:[{
						text:"<s:property value="%{getText('eaap.op2.conf.directory.manager.dirCancel')}" />",
						iconCls:'icon-ok',
						handler:function(){
							$('#addServiceManager').submit();
						}
					},{
						text:"<s:property value="%{getText('eaap.op2.conf.directory.manager.dirCancel')}" />",
						iconCls:'icon-cancel',
						handler:function(){
							$('#dialog').dialog('close');
							$('#addServiceManager').form('clear');
						}
					}]
				});   
         } 
         
		function updateWorkflow(){
		   //document.getElementById("addWorkFlowForm").submit();
		  // alert($("#BizId").val());
		    $.ajax({
				type: "POST",
				async:false,
			    url: "${contextPath}/workFlowManager/isExistWorkFlowName.shtml",
			    dataType:'json',
			    data:{bizFunctionId:$("#bizFunctionId").val(),bizBizFunctionId:$("#BizId").val(),name:$("#bizName").val()},
				success:function(msg){
						 if(JSON.stringify(msg) == 'true'){
								
							    $.ajax({
									type: "POST",
									async:false,
								    url: "${contextPath}/workFlowManager/isExistBizFunctionCodeWhenEdit.shtml",
								    dataType:'json',
								    data:{bizFunctionId:$("#bizFunctionId").val(),bizFunctionCode:$("#bizCode").val()},
									success:function(msg){
											 if(JSON.stringify(msg) == 'true'){
														 $.ajax({
													            type:"post",
													            async:false,
													            url:"../workFlowManager/updateWorkFlow.shtml",
													            dataType:"json",
													            data:{bizFunctionId:$("#bizFunctionId").val(),bizBizFunctionId:$("#BizId").val(),name:$("#bizName").val(),code:$("#bizCode").val()},
													            success:function(msg){
														            var vOpener=art.dialog.opener;
																	    vOpener.reSearch();
																	    art.dialog.close();
													            }
													        }
												        );
											 }else{
												alert("<s:property value="%{getText('eaap.op2.conf.server.bizFunctionCodeIsExist')}" />");
												$("#bizCode").focus();
											 }
						              }
						         });
					        
						 }else{
							alert("<s:property value="%{getText('eaap.op2.conf.server.workFlowNameExist')}" />");
							$("#bizName").focus();
						 }
	              }
	         });
		}
	    
</script>

</html>
