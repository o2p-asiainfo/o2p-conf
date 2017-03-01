<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.lang.*" pageEncoding="UTF-8"%>
<html>
  <head>
    
    <title>updateTechImplInfo.jsp</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=${contextStyleTheme}" ></script> 
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script> 
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	     <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.callEndPoint')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.showTechnologyImpl')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <form id="updateTechImpl" action="" method="post" name="updateTechImpl" >
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
	  		         <s:property value="%{getText('eaap.op2.conf.techimpl.showTechnologyImpl')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="Org.name" id="orgName"  textSize="25" type="text" value="${orgName}"></ui:inputText>
	  					<!--  
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&chooseOrgCode=orgId','Choose Org')" shape="s"></ui:button>
	  					-->
	  				</div>
 		        </div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="Component.name" id="componentName"  textSize="25" type="text" value="${comName}"></ui:inputText>	  					
	  				</div> 	
	   			</td>	 
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplName" id="techImplName"  textSize="25" type="text" value="${techImplName}"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:inputText skin="${contextStyleTheme}" name="TechImpl.techImplName" id="techImplName"  textSize="25" type="text" value="${commProName}"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
   		   <c:if test="${fn:length(listAttrSpec)>=1}">
   		   <tr>
	   		<c:forEach var="tmpListVar" items="${listAttrSpec}" step="1" varStatus="vstatus">
	   		     <td class="item">
	   		     ${tmpListVar.ATTR_SPEC_NAME}
	   		     </td>
	   		     <td class="item-content">
	   		     <div class="ui-widget">
	   		     <ui:inputText skin="${contextStyleTheme}" id="" name="" value="${tmpListVar.ATTR_SPEC_VALUE}" textSize="25"/>
	   		     </div> 
	   		     </td>
	   		     <c:if test="${vstatus.index%2==1}">
	   		     </tr>
	   		     <tr>
	   		     </c:if>
   		     </c:forEach>    
			</tr>
			   
	   		</c:if>
	   		
	   		<!--<s:if test="#listAttrSpec.size > 0">
	   		   <tr>
	   		   <s:iterator var="list" value="#listAttrSpec" status="vstatus">
	   		      <td class="item">
	   		        <s:property value="list.attr_spec_name"/>
	   		     </td>
	   		     <td class="item-content">
	   		     <div class="ui-widget">
	   		     <ui:inputText skin="${contextStyleTheme}" id="" name="" value="list.attr_spec_code" textSize="25"/>
	   		     </div> 
	   		     </td>
	   		     <s:if test="#vstatus.even">
	   		     </tr>
	   		     <tr>
	   		     </s:if>
	   		   </s:iterator>
	   		   </tr>
	   		</s:if> -->
	   		
	    </table>
	    </form>
	  </div>
	   
	 	 <script type="text/javascript">
			var title = [];
			title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>';
			title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />';
			title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />';
			title[3]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
			title[4]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
			title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
         </script>
<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="false" height="200" id="table" fitHeight="200" remoteSort="false" sortOrder="desc" width="1100" queryParams="true" queryParamsData="${serTechImplId}"
fit="false" collapsible="false"   title="%{getText('eaap.op2.conf.server.supplier.controlStrategy')}" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true" method="eaap-op2-conf-messageFlow-MessageFlowAction.getCC2CList">
		<ui:gridEasyColumn width="100" index="0" title="0" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="CYCLEVALUE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="CUTMSVALUE" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80"  index="3" title="3" field="EFFECTSTATE" hidden="false"   align="center"></ui:gridEasyColumn>
</ui:gridEasy>
 	  <div align="center">
	  			<ui:button skin="${contextStyleTheme}" text="cancel" onclick="$(window.parent.document).find('#closeButton').click();"></ui:button>
	  </div> 
</div>
 </body>
<script>
</script>
</html>

