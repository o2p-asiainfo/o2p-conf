<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="ui" uri="/rainbow-ui-tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/> 
<%response.setContentType("text/html;charset="+org.apache.struts2.config.DefaultSettings.get("struts.i18n.encoding"));%>
<link href="../resource/blue/css/easyui-comen.css" rel="stylesheet" type="text/css" />
<script>
 var FRONT_END_URL = "${frontEnd_url}";
</script>