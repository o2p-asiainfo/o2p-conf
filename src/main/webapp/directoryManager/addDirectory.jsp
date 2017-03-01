<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils"%>
<include file="com/linkage/rainbow/ui/views/action/struts-comm-package.xml" />

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String dirType = StringEscapeUtils.escapeHtml4(request.getParameter("dirType"));	 
	if (dirType == null) dirType ="1";
	String getDirDataProc ="";
	
	if ( "1".equals(dirType) )
	{
		getDirDataProc  = "eaap-op2-conf-directory-manager-DirectoryManagerAction.getDirDataReg" ;  
	}
	else if ("2".equals(dirType) ){
		getDirDataProc  = "eaap-op2-conf-directory-manager-DirectoryManagerAction.getDirDataHelp" ; 
	}
	else  {
	    getDirDataProc = "eaap-op2-conf-directory-manager-DirectoryManagerAction.getDirDataApi";
	}
 
%>

<html>
	<head>
		<link rel="stylesheet" type="text/css"
			href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
		<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
  		<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  		
  		<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
  		<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
		<link rel="stylesheet" type="text/css" href="../resource/comm/css/uploadify.css" /> 
		<link rel="stylesheet" type="text/css" href="../resource/comm/css/imgUpload.css" />
		<script type="text/javascript" src="${contextPath}/resource/comm/js/swfobject.js"></script>
		<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>
		<script type="text/javascript" src="${contextPath}/resource/comm/js/img_upload.js"></script>
	</head>
	<body>
		<!--body start -->
		<s:actionerror/>
		<s:actionmessage/>
		
	 
		<ui:form method="post" name="addDirForm" id="addDirForm"
			action="addDirectory.shtml">
			
 		 <ui:validators validateAlert="div" validatorGroup="group1"> 
		    <ui:validator fieldId="dirName" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.server.manager.directoryNameIsNull')}"></ui:validator>
		 </ui:validators>
			<div class="contentWarp">
				<div>
					<div class="accordion-header">
						<div class="accordion-header-text">
							<span><span class="accordion-header-icon">
									&nbsp;&nbsp;&nbsp;&nbsp;</span> 
						   <% if ("0".equals(dirType) ){%>
									<s:property	value="%{getText('eaap.op2.conf.directory.manager.addApiTypeDirTile')}" />
							<%}	else if ("1".equals(dirType) ){%>
									<s:property	value="%{getText('eaap.op2.conf.directory.manager.addRegTypeDirTile')}" />
							<%}	else {%> 								
									<s:property	value="%{getText('eaap.op2.conf.directory.manager.addHelpTypeDirTitle')}" />
							<%}%>
							 </span>
						</div>	
					</div>
					<table class="mgr-table">
						<tr>
							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.directory.manager.dirName')}" />
								:
							</td>
							<td class="item-content">
								<ui:inputText type="text" name="directory.dirName"
									id="dirName" />
												  
							</td>

							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.directory.manager.dirUpLevel')}" />
								:
							</td>

							<td class="item-content">
	  		    <ui:seltree id="dirUpLevel"  method="eaap-op2-conf-server-ServerManagerAction.getDirectorySeltree" skin="${contextStyleTheme}" operationName=""  textId="cx" chkStyle="radio"    
 		        attrId="qweid" attrPid="qwepId" textHeight="22px"  attrName="qwepName"  cascadeCheck=""  attrIsParent="qweIsParent" saveIdTextName="faDirId" saveIdTextId="faDirId1"  >
 		        </ui:seltree>
                </td>         
						</tr>
						<tr>
							<td class="item">
								<s:property
									value="%{getText('eaap.op2.conf.directory.manager.dirIcon')}" />
								:
							</td>
							<td colspan="3" style="padding-left: 5px;">
			     				<input id="imgUrl" type="hidden"  name="directory.sFileId" />
			     				<input id="heightSize" type="hidden"  value="100" />
			     				<input id="widthSize" type="hidden"  value="100" />
			     				<div class="browse-files">
			      				<div class="browsebtn-warp clearfix">
								<input type="file" name="uploadify" id="uploadify" />
								<!--ä¸ä¼ å¾çæ°ç®æé-->
								<span>
							 		<s:property value=" " />
							    </span>
			                    </div>
								<!--é¦æ¬¡ä¸ä¼ å¾çåæ¾ç¤ºå¾çå®¹å¨-->
								<div class="clearfix" id="div_imgcontainer"></div>
								<!--è¿åº¦æ¡-->
								<div id="imageQueue"></div>
			                    	<p class="fill-remind" ><s:property value="%{getText('eaap.op2.conf.manager.auth.imgUploadDesc')}" /></p>
									<!--ä¸ä¼ éè¯¯æç¤º-->
			             			<p id="p_allcomplete" class="error-inform"></p>
			                        <p class="error-inform"  style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.pngJpg')}" />.</p>
									<p class="error-inform"  id="photo_size_err" style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.imgSize')}" />.</p>
								</div>
								<br/>
								<img id="imagecard" src="${contextPath}/resource/${contextStyleTheme}/images/exampleImage.png" width="100" height="100"/>
			        		</td>
							
								<td class="item-content" style="display:none">
						 			<input type="text" size="30" name="directory.dirType" 	value="<%=dirType%>"  id="dirType" style="display: none;"/> 
								</td>
						</tr>

						<tbody id="cfgTable"></tbody>
						<tr>
							
							
							<td colspan="4" style="TEXT-ALIGN: center;">
								
								<ui:button id="butSubmit" skin="${contextStyleTheme}" onclick="if(comm_validators_check('group1')){addDir();}"
									text="%{getText('eaap.op2.conf.directory.manager.dirSubmit')}" />
 
								<ui:button id="butCancel"  skin="${contextStyleTheme}" onclick="art.dialog.close();"
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
		var id = '${directory.faDirId}';
		$("#cx").val(name);
		$("#faDirId1").val(id);
	</script>
	
	<!-- 方法定义 -->
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
		
	 	$(function(){
			initUploadify();
		});
		
		function addDir(){	 
			var flag ='';
			$.ajax({
		            type:"post",
		            async:false,
		            url:"../directoryManager/isExistDirName.shtml",
		            dataType:"json",
		            data:{dirName:$("#dirName").val(),faDirId:$("#faDirId1").val(),sFileId:$("#imgUrl").val(),dirType:$("#dirType").val()},
		            success:function(msg){
		            	flag=JSON.stringify(msg);
		            }
		        }
	        );
			if (flag == 'true') {
				$.ajax({
		            type:"post",
		            async:false,
		            url:"../directoryManager/addDirectory.shtml",
		            dataType:"json",
		            data:{dirName:$("#dirName").val(),faDirId:$("#faDirId1").val(),sFileId:$("#imgUrl").val(),dirType:$("#dirType").val()},
		            success:function(msg){
			            var vOpener=art.dialog.opener;
						    vOpener.reSearch();
						    art.dialog.close();
		           	 }
		           }
	        	);
			} else {
				alert("<s:property value="%{getText('eaap.op2.conf.directory.manager.dirExist')}" />");
			}
			
	 		//document.getElementById("addDirForm").submit();
	 		//setTimeout("close()",2000);	 
	 	}
	 	
	 	
	 	
	 	function close(){
			art.dialog.close();
		}	
		
		function addDir1(){
		   //document.getElementById("addWorkFlowForm").submit();
		    
		    $.ajax({
		            type:"post",
		            async:false,
		            url:"../directoryManager/addDirectory.shtml",
		            dataType:"json",
		            data:{BizName:$("#BizId").val(),name:$("#bizName").val(),code:$("#bizCode").val()},
		            success:function(msg){
			            var vOpener=art.dialog.opener;
						    vOpener.reSearch();
						    art.dialog.close();
		            }
		        }
	        );
		}
		

</script>

</html>
