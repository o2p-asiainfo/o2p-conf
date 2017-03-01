<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/> 
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.testPiles.sceneName')}"/>';
</script>

</head>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.testPiles.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}"/>
      	</div>
    </div>
    
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
			<form id="addTestSceneToNext" action="../testPiles/testSceneEdit.shtml" method="post" name="addTestSceneToNext" >
				   	<div class="module-path">
				  		<div class="module-path-content" align="center">
			               <s:property value="%{getText('eaap.op2.conf.testPiles.testScene')}" />
			               <s:property value="%{getText('eaap.op2.conf.testPiles.add')}"/>
				     	</div>
				    </div>
				 	<table class="mgr-table">
						<tr>
				  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" />:</td>
				  			<td class="item-content"> 
				  		    <div class="ui-widget"> 
				  				<div class="ui-widget">	  					  					
				  					<ui:inputText skin="${contextStyleTheme}" name="techImplName"  id="techImplName"  readonly="true"  textSize="25" style="width:300px"></ui:inputText>
				  					<input name="techImplId" id="techImplId" type="hidden" value="" />
				  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.selectTechImpl')}..." onclick="openWindows('${contextPath}/techimpl/chooseTechImpl.shtml?techImplName=techImplName&techImplId=techImplId','%{getText('eaap.op2.conf.testPiles.selectTechImpl')}')" shape="s"></ui:button>
				  				</div>
			 		        </div>
				   			</td>
				   		</tr>
				   		 <tr>
				  			<td class="item-center" colspan="4" >
				  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.next')}" onclick="toNext()"></ui:button>
				   		    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDirCancel')}" onclick="location='${contextPath}/testPiles/testScene.shtml'"></ui:button>
				  			</td>
				   		</tr>
				    </table>
	    	</form>
		</div>
	</div>

<!--body end --> 
</div>
</body>
<script>
function toNext() {
	  document.addTestSceneToNext.submit();
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
