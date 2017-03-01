<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
		<input type="hidden" id="modifyCurrentNodeNodeId" value=""/>
		<input type="hidden" id="modifyCurrentNodeOperId" value=""/> 
		<jsp:include page="/adapter/node/modify/modifyCurrentNodeConfigMethodChoose.jsp"/>	
		<jsp:include page="/adapter/node/modify/modifyCurrentNodeConfigFix.jsp"/>
		<jsp:include page="/adapter/node/modify/modifyCurrentNodeConfigDocument.jsp"/>
		<jsp:include page="/adapter/node/modify/modifyCurrentNodeConfigDatabase.jsp"/>
		<jsp:include page="/adapter/node/modify/modifyCurrentNodeConfigExtend.jsp"/>

	
	
