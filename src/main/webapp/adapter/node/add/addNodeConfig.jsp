<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
		<input type="hidden" id="addNodeId" value=""/>
		<input type="hidden" id="addNodeOperId" value=""/>  
		<jsp:include page="/adapter/node/add/addNodeConfigMethodChoose.jsp"/>		
  		<jsp:include page="/adapter/node/add/addNodeConfigFix.jsp"/>
  		<jsp:include page="/adapter/node/add/addNodeConfigDocument.jsp"/>
  		<jsp:include page="/adapter/node/add/addNodeConfigDatabase.jsp"/>
  		<jsp:include page="/adapter/node/add/addNodeConfigExtend.jsp"/>