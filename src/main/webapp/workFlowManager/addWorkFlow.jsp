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
			action="addWorkFlow.shtml">
			
  		 <ui:validators validateAlert="div" validatorGroup="group1"> 
		    <ui:validator fieldId="bizName" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.bizFunNameIsNull')}"></ui:validator>
			<ui:validator fieldId="bizCode" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.bizFunCodeIsNull')}"></ui:validator>
			<ui:validator fieldId="bizCode" validatorType="ajax" ajaxMethods="eaap-op2-conf-server-ServerManagerAction.validatorBizFun(bizCode))" message="%{getText('eaap.op2.conf.server.manager.bizCodeExist')}"></ui:validator>
		 </ui:validators>
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
								<font color="red">*</font><s:property
									value="%{getText('eaap.op2.conf.server.manager.workFlowName')}" />
								:
							</td>
							<td class="item-content">
								<ui:inputText type="text" skin="${contextStyleTheme}" name="BizFunction.name"
									id="bizName" />
												  
							</td>

							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.directory.manager.dirUpLevel')}" />
								:
							</td>
							<td class="item-content">
	
					<ui:seltree id="dewe" skin="${contextStyleTheme}" method="eaap-op2-conf-workFlow-manager-WorkFlowManagerAction.getBizData" operationName="" handleName=""   textId="ce"  chkStyle="radio"    
 		            attrId="qweid" attrPid="qwepId"  attrName="qwepName" textHeight="22px" textWidth="192px" attrIsParent="qweIsParent" saveIdTextId="BizId" saveIdTextName="BizName">
 		            </ui:seltree>
 		            </td>
						</tr>
						<tr>
							<td class="item">
								<font color="red">*</font><s:property
									value="%{getText('eaap.op2.conf.server.manager.workFlowCode')}" />
								:
							</td>
							<td class="item-content">
								<ui:inputText type="text" name="BizFunction.code" skin="${contextStyleTheme}"
									id="bizCode" />
												  
							</td>
							<td colspan="2"></td>
							
							</tr>
                       <tr>
                       </tr>

						<tbody id="cfgTable"></tbody>
						<tr>
							
							
							<td colspan="4" style="TEXT-ALIGN: center;">
								
								<ui:button skin="${contextStyleTheme}" id="butSubmit" onclick="if(comm_validators_check('group1')){addWorkflow();}"
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
	<!-- 初始化 -->
 <script>
 	var name = '${dirName}';
 	var id = '${bizFunction.bizBizFunctionId }';
 	$('#ce').val(name);
 	$("#BizId").val(id);
 </script>
 <!-- 定义函数 -->
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
         
		function addWorkflow(){
		   //document.getElementById("addWorkFlowForm").submit();
		   var flag ='';
			$.ajax({
		            type:"post",
		            async:false,
		            url:"../workFlowManager/isExistWorkFlowName.shtml",
		            dataType:"json",
		            data:{bizBizFunctionId:$("#BizId").val(),name:$("#bizName").val()},
		            success:function(msg){
		            	flag=JSON.stringify(msg);
		            }
		        }); 
			if (flag == 'true') {
			    $.ajax({
			            type:"post",
			            async:false,
			            url:"../workFlowManager/addWorkFlow.shtml",
			            dataType:"json",
			            data:{BizName:$("#BizId").val(),name:$("#bizName").val(),code:$("#bizCode").val()},
			            success:function(msg){
				            var vOpener=art.dialog.opener;
							    vOpener.reSearch();
							    art.dialog.close();
			            }
			        }
		        );
			} else {
				alert("<s:property value="%{getText('eaap.op2.conf.server.workFlowNameExist')}" />");
			}
		}
	    
</script>

</html>
