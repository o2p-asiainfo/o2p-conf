<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="/common/taglibs.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
		
%>
<jsp:useBean id="rbu" class="com.ailk.eaap.op2.common.ResBundleUtils" scope="page"></jsp:useBean>
<% 
rbu.setLang("en_US");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>
		<base href="<%=basePath%>">
		<title>Service Manager</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="protocol adapter config">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resource/orange/css/console.css">	
		<link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/adapter/adapter.css">	
		<%=rbu.writeMsg2Page() %>
		<script type="text/javascript" src="resource/comm/js/jquery.js"></script>
		<script type="text/javascript" src="resource/comm/js/jqueryui/jquery.autocomplete.js"></script>		
		<script src="${contextPath}/resource/comm/js/dhtmlxtree/dhtmlxcommon.js"></script>
		<script src="${contextPath}/resource/comm/js/dhtmlxtree/dhtmlxtree.js"></script>
		<script src="${contextPath}/resource/comm/common.js"></script>
		<script src="${contextPath}/resource/comm/js/adapter/adaptermain.js"></script>
		<script src="${contextPath}/resource/comm/js/adapter/adapteradd.js"></script>
		<script src="${contextPath}/resource/comm/js/adapter/adaptermodify.js"></script>
		<script src="${contextPath}/resource/comm/js/adapter/adapterdelete.js"></script>
		<script src="${contextPath}/resource/comm/js/adapter/commonmethod.js"></script>
		<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
    	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    	<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>	
	</head>
	<body>
		<input type="hidden" id="projectRootPath" value="${pageContext.request.contextPath}"/>
		<input type="hidden" id="adapterId" value="${adapterId}"/>
		<input type="hidden" id="msgSwitchMode" value="${protocolAdapter.msgSwitchMode}"/>
		<input type="hidden" id="inProtocol" value="${protocolAdapter.inProtocol}"/>
		<input type="hidden" id="outProtocol" value="${protocolAdapter.outProtocol}"/>
		<input type="hidden" id="inType" value="${protocolAdapter.inType}"/>
		<input type="hidden" id="outType" value="${protocolAdapter.outType}"/>
		<input type="hidden" id="inputUrl" value="${inputUrl}"/>
		<input type="hidden" id="adapterProcessCode" value="${protocolAdapter.adapterProcessCode}"/>
		<input type="hidden" id="exampleSrcDocument" value="${protocolAdapter.exampleSrcDocument}"/>
		<input type="hidden" id="exampleTarDocument" value="${protocolAdapter.exampleTarDocument}"/>
		<%--
		<div id="protocalInfo" class="easyui-accordion" split="true">
		--%>
		<div id="protocalInfo" class="contentWarp">
			<div title="<s:text name='adapterTagProtocalInfo'/>" iconCls="icon-ok">
				<c:choose>
					<c:when test="${param.actionType=='ADD'}">
					<ui:form id="serviceAdd" action="../serviceManager/getServiceAddData.shtml" method="post" name="serviceAdd" >
						<table class="mgr-table">
							<tr>
								<td align="right" width="160"><s:text name="adapterColInProtocol"></s:text>:</td>
								<td > 
						  		    <div class="ui-widget"> 
						  				<div class="ui-widget">	  					  					
						  					<ui:inputText skin="${contextStyleTheme}" name="protocolAdapter.inProtocol" id="inProtocolText" textSize="19"></ui:inputText>
						  				</div>
					 		        </div>
					   			</td>
								<td align="right" width="160"><s:text name="adapterColOutProtocol"></s:text>:</td>
								<td > 
						  		    <div class="ui-widget"> 
						  				<div class="ui-widget">	  					  					
						  					<ui:inputText skin="${contextStyleTheme}" name="protocolAdapter.outProtocol" id="outProtocolText" textSize="19"></ui:inputText>
						  				</div>
					 		        </div>
					   			</td>					   			
							</tr>
							<tr>
								<td align="right" width="160"><s:text name="adapterColAdapterProcessCode"></s:text>:</td>
								<td > 
						  		    <div class="ui-widget"> 
						  				<div class="ui-widget">	  					  					
						  					<ui:inputText skin="${contextStyleTheme}" name="protocolAdapter.adapterProcessCode" id="adapterProcessCodeText" textSize="19"></ui:inputText>
						  				</div>
					 		        </div>
					   			</td>
								<td align="right" width="160"><s:text name="adapterColMsgSwitchMode"></s:text>:</td>
								<td > 
						  		    <div class="ui-widget"> 
						  				<div class="ui-widget">	  					  					
						  					<ui:select  skin="${contextStyleTheme}" name="protocolAdapter.msgSwitchMode" width="135" id="MsgSwitchModeSel" list="msgSwitchModeList"  emptyOption="true" headerValue=" "	layerWidth="135"  onchange="getChangeData(this.value);"></ui:select>
						  				</div>
					 		        </div>
					   			</td>					   			
							</tr>							
					   		<tr>
					  			<td class="item-center" colspan="4" >
					  			<ui:button skin="${contextStyleTheme}" text="Save" onclick="doSubmit()"></ui:button>
					   		    <ui:button skin="${contextStyleTheme}" text="Back" onclick="history.go(-1);" ></ui:button>
					  			</td>
					   		</tr>							
						</table>	
					</ui:form>	
					</c:when>
					<c:otherwise>
						<table width="100%" class="mgr-table">	
							<tr>
								<td width="10%" class="item">
									<%--<span class="text_font_common_14">适配类型</span>
									--%>
									<span class="text_font_common_14"><s:text name="adapterColAdapterType"></s:text> </span>
								</td>
								<td width="10%" class="item-content">
											<span class="text_font_common_14">From template</span>
		
							</td>
							</tr>
							<tr>
								<td width="10%" class="item">
									<span class="text_font_common_14"><s:text name="adapterColInProtocol"></s:text></span>
								</td>
								<td width="10%" class="item-content">
											<span class="text_font_common_14">${protocolAdapter.inProtocol}</span>
								</td>
							</tr>
							<tr>						
								<td width="10%" class="item">
									<span class="text_font_common_14"><s:text name="adapterColOutProtocol"></s:text></span>
								</td>
								<td width="10%" class="item-content">
											<span class="text_font_common_14">${protocolAdapter.outProtocol}</span>
								</td>
							</tr>
						<%--
							<tr>						
								<td width="10%" class="item">
									<span class="text_font_title">过程编码</span>
								</td>						
								<td width="10%" class="item-content">
									<span class="text_font_title">${protocolAdapter.adapterProcessCode}</span>
								</td>										
							</tr>
						--%>
						</table>
					</c:otherwise>
				</c:choose>

			</div>
			<div title="<s:text name='adapterTagAdapterInfo'/>" class="contentWarp">
				   <table width="100%">	
						<tr>
							<td width="40%">
								<%--
								<span class="text_font_title">&nbsp;&nbsp;Source xml</span>
								--%>
								<span class="text_font_title">&nbsp;&nbsp;<s:text name='adapterColSourceXML'/></span>
							</td>
							<td width="20%">
								<span class="text_font_title">&nbsp;</span>
							</td>				
							<td width="40%">
								<span class="text_font_title">&nbsp;&nbsp;<s:text name='adapterColTargetXML'/></span>
							</td>
						</tr>
						<tr>				
							<td width="40%">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<textarea id="srcDocument"  name="srcDocument" style="width:400px;" rows="10" 
									onblur="document.getElementById('exampleSrcDocument').value=this.value;" 
									class="text_font_common"></textarea>				
							</td>
							<td width="20%" align="middle"><%--
								<a id="generateTreeStructure" onclick="testProtocalAdapter()" iconCls="icon-redo"  class="easyui-linkbutton" >测试</a>
								--%>
								<ui:button skin="${contextStyleTheme}" text="%{getText('adapterVbtnTest')}" onclick="testProtocalAdapter()"></ui:button>						
							</td>				
							<td width="40%">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<textarea id="tarDocument"  name="tarDocument" style="width:400px;" rows="10" class="text_font_common"></textarea>	
							</td>							
						</tr>
					</table> 
					<table width="100%">
						<tr>
							<td width="40%" >
								<span class="text_font_title"><s:text name='adapterTagTarXMLStructure'/>：</span>					
							</td>
							<td style="width:60%" colspan="4">
								<span class="text_font_title"><s:text name='adapterTagConfigInfo'/>:</span>	
							</td>
						</tr>
						<tr>
							<td width="40%" >
								<div id="targetDocumentStructure"
										style="width: 90%; height: 100%; background-color: #f5f5f5; border: 1px solid Silver; overflow:auto;" />					
							</td>
							<td style="width:60%" colspan="4">
								<div id="dialog_ConfigInfo">
									<jsp:include page="/adapter/nodeConfigInfo.jsp"/>
								</div>				
							</td>
						</tr>
					</table>
			</div>
		</div>
		<div id="dataSetManagerWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="Dataset choose" style="width:800px;height:400px;padding:5px;">
			<iframe id="dataSetManagerIframe" scrolling="yes" frameborder="0" src="" style="border:0;width:100%;height:100%" scrolling="yes"></iframe> 
		</div>
		<div id="extendManagerWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="Extend choose" style="width:800px;height:400px;padding:5px;">
			<iframe id="extendManagerIframe" scrolling="yes" frameborder="0" src="" style="border:0;width:100%;height:100%" scrolling="yes"></iframe> 
		</div>	
		<ui:iframe   iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
<script type="text/javascript">
	function ontest(){
		parent.closeSelectValueSpecWin();
	}
	window.onload=function(){
		var adapterId = document.getElementById("adapterId").value;
		var msgSwitchMode=document.getElementById("msgSwitchMode").value;
		var inType=document.getElementById("inType").value;
		var inputUrl=document.getElementById("inputUrl").value;
		var exampleSrcDocument=document.getElementById("exampleSrcDocument").value;
		var exampleTarDocument=document.getElementById("exampleTarDocument").value;
		if(msgSwitchMode=='2'){
			if(inType=='1'){
				$('#srcDocument').val(exampleSrcDocument);
			}else if(inType=='2'){
				$('#srcDocument').val(inputUrl);
			}
			$('#tarDocument').val(exampleTarDocument);
		}
		loadTargetDoucumentStructure(adapterId);
	}
</script>				
	</body>
</html>
