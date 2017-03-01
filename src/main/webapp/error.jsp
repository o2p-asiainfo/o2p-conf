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
						<s:iterator value="actionMessages">
							<s:property />
						</s:iterator>
						<%
						
						if (exception == null) {
							exception = (Exception) request.getAttribute("exception");
						}
						if(exception!=null){
							//exception.printStackTrace();
						%>
						<table cellspacing='0' cellpadding='0' border='0'  valign="top" >
							<tr height=10 colspan=2>
								<td><div style="width:500; flaot:left;"><font color='red'><b><s:property value="%{getText('eaap.op2.portal.errPage.AppearError')}" /></b></font></div></td>
							</tr>
							<tr>
								<td align="right">
									<hr size="1" style="width:100%"/>
									<div> 
										<font color="red">
										<%
			                        		//exception.printStackTrace();
				                        %>
				                        <%
				                        	String errormsg="";
				                        	
				                        	String error =baseAction.getText("eaap.op2.portal.errPage.AppearError");
				                        	while(exception != null){
				                        		errormsg = exception.getMessage();
				                        		/*
				                        		for (int i = 0; i < exception.getStackTrace().length; i++) {
													errormsg += "<br>"+exception.getStackTrace()[i];
												}*/
				                        		//errormsg += "<br>"+exception.getStackTrace()[0];
				                        		
					                        	if (errormsg == null){
					                        		
					                        	}else if (errormsg.indexOf("There is no Action mapped for action name")!=-1){
					                        		error = baseAction.getText("eaap.op2.portal.errPage.SorryPageNotExists");
					                        	}else if(errormsg.indexOf("ERR-403.1")!=-1){
													error = baseAction.getText("eaap.op2.portal.errPage.SorryNotEnoughPower_403_1");
												}else if(errormsg.indexOf("ERR-403.2")!=-1){
													error = baseAction.getText("eaap.op2.portal.errPage.SorryNotEnoughPower_403_2");
												}else if(errormsg.indexOf("Access is denied")!=-1){
													error = baseAction.getText("eaap.op2.portal.errPage.AccessIsDenied");
												}else if(errormsg.indexOf("ORA-00001")!=-1){
													error = baseAction.getText("eaap.op2.portal.errPage.RepeatAddKeyField");
												}else if(errormsg.indexOf("ORA-01401")!=-1){
													error = baseAction.getText("eaap.op2.portal.errPage.AddColumnValueGreat");
												}else if(errormsg.indexOf("ORA-02292")!=-1){
													error = baseAction.getText("eaap.op2.portal.errPage.SorryRecordCascadeNotDel");
												}else if (errormsg.indexOf("ORA-03114") != -1){
													error = baseAction.getText("eaap.op2.portal.errPage.NotConDatabase");
												}else if (errormsg.indexOf("ORA-") != -1){
													error = baseAction.getText("eaap.op2.portal.errPage.OpeDatabaseError");
												}else {
													error = baseAction.getText("eaap.op2.portal.errPage.UnknownError");
												}
												exception = exception.getCause();
											}
											//.........
											//else if(cause.equals(""))
											
				                        %>
				                          <%=error%>
				                        </font>
									</div>
									<br>
								</td>								
							</tr>
							<tr>
								<td style="word-break:normal;">
									<font color="Blue" style="font-size: 12px;"> 
											<a style="cursor:hand" onclick="err_msg();"><%=baseAction.getText("eaap.op2.portal.errPage.SeeErrorInfo")%></a> 
									</font> 
								</td>
							</tr>
							<tr>
								<td style="word-break:normal;">
									<div id="err_msg" style="display:none; font-size: 12px;" >
										<%=errormsg%>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;
									<hr size="1" style="width:100%"/>
								</td>
							</tr>
							<tr>
								<td align="center">
									<a class="button-base button-middle" title="<%=baseAction.getText("eaap.op2.portal.errPage.Return")%>" href="javascript:history.go(-1);" ><%=baseAction.getText("eaap.op2.portal.errPage.Return")%></a>
								</td>
							</tr>
						</table>
						<%}else{%>
							<font color="red">
								<%=baseAction.getText("eaap.op2.portal.errPage.HaveNoRight")%><br>
								<%=baseAction.getText("eaap.op2.portal.errPage.ContactManager")%><br></br>
								<input type="button" value="<%=baseAction.getText("eaap.op2.portal.errPage.Return")%>" onclick="javascript:history.go(-1);">&nbsp;&nbsp;
							</font>
						<%}%>
					</td>
				</tr>
			</table>
			<br>
		</td>
	</tr>
</table>
<script type="text/javascript">
	function err_msg(){
		if(document.all.err_msg.style.display==""){
			document.all.err_msg.style.display="none";
		}else{
			document.all.err_msg.style.display="";
		}
	}
	
	function toHomepage(){
         var baseuri = top.location.href;
         if(baseuri.indexOf("/EAAP_SSO")>0){
			top.location.href = baseuri;
         }else{
         	top.location.href='${contextPath}/';
         }
	}
</script>
</body>
</html>
