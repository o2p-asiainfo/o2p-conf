<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<%
	String type = (String)request.getAttribute("type");
	if("1".equals(type)){
		%>
			<ui:date id="btime" name="paraMap.beginTime"  value="${btime}" width="107" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
			to
			<ui:date id="etime" name="paraMap.endTime"  value="${etime}" width="107" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
		<%
	}else if ("2".equals(type)){
		%>
			<ui:date id="btime" name="paraMap.beginTime"  value="${btime}" width="107" dateFmt="yyyy-MM" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
			to
			<ui:date id="etime" name="paraMap.endTime"  value="${etime}" width="107" dateFmt="yyyy-MM" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
		<%
	}else{
		%>
			<ui:date id="btime" name="paraMap.beginTime"  value="${btime}" width="107" dateFmt="yyyy" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
			to
			<ui:date id="etime" name="paraMap.endTime"  value="${etime}" width="107" dateFmt="yyyy" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
		<%
	}
 %>
    			