<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>

</head>
<!--body start -->
<body >
<div class="contentWarp">
  	<div class="module-path">	
  		<div class="module-path-content">
		      	<img src="../resource/blue/images/search.png" />
		     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
		      	<img src="../resource/blue/images/module-path.png" />
	      		<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.remoteCallInfo')}"/>
	      </div>
	</div>
	
	<ui:form method="post" id="myForm" action="saveRemoteCallInfo.shtml">	
		<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
		<ui:validators validateAlert="word" validatorGroup="group1"> 
			<ui:validator fieldId="remoteCallUrlCode" validatorType="requiredstring" message="%{getText('eaap.op2.conf.remoteCallInfo.code')} %{getText('eaap.op2.conf.remoteCallInfo.notNull')}"/>
			<ui:validator fieldId="remoteCallUrl" validatorType="requiredstring" message="%{getText('eaap.op2.conf.remoteCallInfo.url')} %{getText('eaap.op2.conf.remoteCallInfo.notNull')}"/>
		</ui:validators>
	    <div class="accordion-header"  id="pageTitle">
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;
    				<c:if test="${remoteCallInfo.remoteCallUrlId ==null}">
    						<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.new')}"/>
    				</c:if>
    				<c:if test="${remoteCallInfo.remoteCallUrlId !=null}">
    						<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.edit')}"/>
    				</c:if>
    				</span>
         		</div>       
    	</div>

		<table align="center" class="mgr-table">
             <input type="hidden" id="remoteCallInfo" name="remoteCallInfo.remoteCallUrlId" value="${remoteCallInfo.remoteCallUrlId}"/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
            <tr>
              <td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.remoteCallInfo.code')}"/>:</td>
              <td  colspan="3" width="85%"><ui:inputText skin="${contextStyleTheme}"  name="remoteCallInfo.remoteCallUrlCode"  id="remoteCallUrlCode" value="${remoteCallInfo.remoteCallUrlCode}" style="width:500px"></ui:inputText></td>
            </tr>
            <tr>
              <td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.remoteCallInfo.url')}"/>:</td>
              <td  colspan="3" width="85%"><ui:inputText skin="${contextStyleTheme}"  name="remoteCallInfo.remoteCallUrl"  id="remoteCallUrl" value="${remoteCallInfo.remoteCallUrl}" style="width:500px"></ui:inputText></td>
            </tr>
    	  </table>
</ui:form>
	
<div style="text-align:center;padding-top:10px;">
		<table align="center"  id="updateBut">
		   <tr>
		     <td  colspan="4"  align="center" style="text-align:center;">
  					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.remoteCallInfo.checksubmit')}"  shape="M" id="checksubmitId" onclick="updateRemoteCallInfo();"></ui:button>
  					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.remoteCallInfo.cancel')}"  shape="M" id="checkcancelId" onclick="returnPage();"></ui:button>
			 </td>	
		   </tr>
		</table>
		<table align="center"  id="confirm"  style="display:none">
		   <tr>
		     <td  colspan="4"  align="center">
	  				<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="$(window.parent.document).find('#closeButton').click();"></ui:button>
			 </td>	
		   </tr>
		</table>
</div>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>
		
<script>
	$(document).ready(function(){
		var choosePageState=$("#choosePageState").attr('value');
	    if(choosePageState=="show") {
			document.getElementById("confirm").style.display= "block"; 
			document.getElementById("updateBut").style.display= "none"; 
			document.getElementById("pageTitle").style.display= "none"; 		
	    }
	 })
	 
	function updateRemoteCallInfo(){		
			var form = document.getElementById("myForm");
		  	if(comm_validators_check('group1'))
	       	{
	       	    form.action="saveRemoteCallInfo.shtml";
	       		form.submit();				
	       	}	
		}
		
    function returnPage() {
		window.location="remoteCallInfoList.shtml";
    }
		
    function check_num(obj){
        obj.value = obj.value.replace(/[^\d]/g,'');
    }
    function check_num2(obj){
		obj.value = jQuery.trim(obj.value);
    }
    
</script>