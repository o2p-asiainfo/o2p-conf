<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" import="java.lang.*" pageEncoding="UTF-8"%>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/orange/css/console.css">	

</head>
<body>
<ui:form method="post" id="extendForm" name="extendForm" action="/adapter/queryExtendMethod.shtml">
	<div class="contentWarp">
	   <div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item" width="20%">Query SQL:</td>
	  			<td class="item-content" width="40%">
	  				<input type="text" id="query_SQL" name="query_SQL" value=""/>
	   			</td>
	   			<td colspan="2" style="TEXT-ALIGN: right;PADDING-RIGHT:30px; " width="40%">
  					<a class="button-base button-small" title="Query" target="_blank" onclick="queryExtendList()">
				  		<span class="button-text">Query</span>
					</a>
	    		</td>	
	   		</tr>
	    </table>
	    <input type="hidden" id="selectMethod_Id" name="selectMethod_Id" value="" />
	 	<table class="list-table" cellpadding="1" cellspacing="0">
			<tr class="tab-header">
				<td class="middle" style="width:5%">&nbsp;</td>
   				<td class="middle" style="width:10%">Extend method ID</td>
   				<td class="middle" style="width:10%">Extend type</td>
   				<td class="middle" style="width:10%">Class name</td>
   				<td class="middle" style="width:10%">Bean ID</td>
   				<td class="middle" style="width:10%">Method name</td>
   				<td class="middle" style="width:35%">Code Segment</td>
   				<td class="middle" style="width:10%">Remark</td>
   			</tr>  			
   			<c:choose>
   				<c:when test="${fn:length(extendList)<1}">
   					<tr class="even" align="center">
   						<td colspan="6">No data</td>
   					</tr>
	     		</c:when>
	     		<c:otherwise>
	     			<c:forEach items="${extendList}" var="extend" varStatus="status" step="1" >
	     				<tr class="even">
	     					<td class="middle">
	     					<input type="radio" name="radioBtn" 
	     						value="${extend.methodId}" 
	     						onclick="selectMethod_Id.value='${extend.methodId}';"/>
	     					</td>
		    				<td class="middle" id="cellMethodId_${extend.methodId}" >${extend.methodId}</td>
		    				<td class="middle" id="cellMethodType_${extend.methodId}">${extend.methodType}</td>
		    				<td class="middle" id="cellClassName_${extend.methodId}">${extend.className}</td>
		    				<td class="middle" id="cellBeanid_${extend.methodId}">${extend.beanid}</td>
		    				<td class="middle" id="cellMethodName_${extend.methodId}">${extend.methodName}</td>
		    				<td class="middle" id="cellSegmentRealize_${extend.methodId}">${extend.segmentRealize}</td>
		    				<td class="middle" id="cellRemarks_${extend.methodId}">${extend.remarks}</td>
		    			</tr>
	     			</c:forEach>
	     		</c:otherwise>
    		</c:choose>
    		<tr class="even" align="left">
   				<td colspan="7" style="PADDING-LEFT:30px;">
   					<a class="button-base button-small" title="Choose" target="_blank" onclick="parent.setExtendValue(selectMethod_Id.value);">
						<span class="button-text">Choose</span>
					</a>
					<a class="button-base button-small" title="Add" target="_blank" onclick="">
						<span class="button-text">Add</span>
					</a>
					<a class="button-base button-small" title="Delete" target="_blank" onclick="">
						<span class="button-text">Delete</span>
					</a>
   				</td>
   			</tr>
	    </table>    
   		<div style="position:relative;float:right;botton:0;margin-top:10px;top:auto;clear:both;">
		   	<ui:page id="page"/>
	    </div>	    
	     <br/>
	   </div>
	</div>
</ui:form>
</body>