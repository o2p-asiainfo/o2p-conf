<%@page language="java" isErrorPage="true"%>
<%@page import="com.linkage.rainbow.ui.struts.BaseAction"%>

<%@ include file="/common/taglibs.jsp"%>
<%
BaseAction baseAction = new BaseAction();
%>
<html>  
<head>
<base>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/platform.css" />
<title><s:property value="%{getText('eaap.op2.portal.index.SysName')}" /></title>
</head>
<body topmargin="0" leftmargin="0">
<table width="100%" height="100%" cellspacing='0' cellpadding='0' border='0'>
	<tr>
		<td valign="middle">
			<table width="450" height="157" cellspacing='0' cellpadding='0' border='0' align="center" >
				<tr height=30>
					<td colspan=4></td>
				</tr>
				<tr>
					<td width=30></td>
					<td  width=150><img src="${contextPath}/resource/${contextStyleTheme}/images/error.png"></td>

					<td valign="top">
						<table cellspacing='0' cellpadding='0' border='0'  valign="top">
							<tr height=10 colspan=2>
								<td></td>
							</tr>
							<tr>
								<td style="PADDING-left:12px;">
									<html:errors/>
									<br>
								</td>
							</tr>
							<tr height=7 colspan=2>
								<td></td>
							</tr>
							<tr>
								<td colspan=2 align=right> </td>
							</tr>
						</table>
						
						<font color="red">
							 Your login time already timeout, please login again!
						</font>
					</td>
				</tr>
			</table>
			<br>
		</td>
	</tr>
</table>
</body>
</html>
