<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<jsp:useBean id="vd" scope="page" class="com.ailk.eaap.op2.conf.auditing.action.CompRegAuditingAction" />
<jsp:setProperty name="vd" property="*" />
  <%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
  String id = vd.refreshSecret();
  out.println(id) ;
%>
