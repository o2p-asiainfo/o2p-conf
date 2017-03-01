<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" errorPage="/error.jsp" %>
<head>
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/platform.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/register.css" />

  <script language="javascript">	
	 
	<s:iterator value="actionScripts">
		//parent.FunListFrm.window.location.reload();
		<s:property escape="false"/>
	</s:iterator>
	if(parent.Console!=null){
		parent.Console.treeLoader();
	}
	
</script>
 
</head>
<body  style="text-align: center;PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px;">
	<center>
		<div class='cell2-shape'>
			<span id='title-1'>
				<h3>
				   <c:choose>
				   <c:when test="${uploadSate=='N'}">
				   <a><b><s:property value="%{getText('eaap.op2.conf.manager.auth.doUploadError')}"/></b> </a>
				   </c:when>
				   <c:otherwise>
				   <a><b><s:property value="%{getText('eaap.op2.conf.manager.auth.doUploadSuccess')}"/></b> </a>
				   </c:otherwise>
				   </c:choose>
					
				</h3> &nbsp; </span>
			<span id='lc-t'></span>
			<span id='l-content'> <span id="info"></span>
				<table class='cell2-shape'>
					<tr>
						<td id="msg">
							<s:if test="actionMessages==null || actionMessages.size==0">
						<s:property value="%{getText('SYS.OPERATESUCCESS')}"/>!
					</s:if>
							<s:else>
								<s:iterator value="actionMessages">
									<s:property />
								</s:iterator>
							</s:else>
						</td>
					</tr>
					
				</table> 
				
				<br/>
				<a id="show"></a> <s:if test="buttons==null || buttons.size()==0">
				 <a id="cancel_button" class="button-base button-swhite" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.regOver')}"/>"  onclick="parent.closeWin();">
					  <span class="button-text"><s:property value="%{getText('eaap.op2.conf.manager.auth.regOver')}"/></span>
				 </a>
				 </s:if> <s:iterator value="buttons">
					<a class="links" href="<s:property value='url'/>"><s:property value="name" /> </a>
				</s:iterator> </span>
				 
			<span id='lc-b'></span>
		</div>
	</center>
</body>
