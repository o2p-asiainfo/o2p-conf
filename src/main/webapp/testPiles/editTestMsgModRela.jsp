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
	<script>
	function updateTestMsgModRela(){
		var form = document.getElementById("myForm");
		var objType =  $('#objType').find('option:selected').val();
		if ($("#modName").val() == "") {
		    alert("<s:property value="%{getText('eaap.op2.conf.testPiles.modName')}" />" 
            + " " + "<s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
            return false;
	    } 
		
	    if (objType == "0" && $("#serviceName").val() == "") {
		    alert("<s:property value="%{getText('eaap.op2.conf.testPiles.service')}" />" 
            + " " + "<s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
            return false;
	    } else if (objType == "1" && $("#serInvokeInsName").val() == "") {
	 	    alert("<s:property value="%{getText('eaap.op2.conf.testPiles.serInvokeIns')}" />" 
            + " " + "<s:property value="%{getText('eaap.op2.conf.testPiles.notNull')}" />");
            return false;
	    }
		
	    $.ajax({
	            type:"post",
	            async:false,
	            url:"../testPiles/editTestMsgModRela.shtml",
	            dataType:"json",
	            data:{objType:$('#objType').find('option:selected').val(),modId:$("#modId").val(),serInvokeInsId:$("#serInvokeInsId").val(),serviceId:$("#serviceId").val()},
	            success:function(msg){
	            	var o = msg;
		            if(o.msg=='faile'){
		            	alert("<s:property value="%{getText('eaap.op2.conf.testPiles.existsTestMsgModRela')}" />");
	            	}else{
	            		window.location="showTestMsgModRela.shtml";
	            	}
	        	}
        });
	}
	
    function returnPage() {
		window.location="showTestMsgModRela.shtml";
    }
		
    function cleardata(str1,str2)
    {
	    $("#"+str1).val(null);
	    $("#"+str2).val(null);
    }
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
  		<div class="module-path-content">
		      	<img src="../resource/blue/images/search.png" />
		     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
		      	<img src="../resource/blue/images/module-path.png" />
		      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
		      	<img src="../resource/blue/images/module-path.png" />
				<s:property value="%{getText('eaap.op2.conf.testPiles.addModelObject')}" />		   		  
	      	</div>
	    </div> 
<ui:form method="post" id="myForm" action="editTestMsgModRela.shtml">	
	<ui:validators validateAlert="word" validatorGroup="group1"> 
	</ui:validators>
	<div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         		</div>       
    	   </div>
	   <div>
		 	<table align="center" class="mgr-table">
             <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
            <tr>
              <td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.modName')}"/>:</td>
              <td  width="40%">
                  <ui:inputText skin="${contextStyleTheme}" name="modName" id="modName"  textSize="25" readonly="true" style="float:left;"></ui:inputText> 
	  		      <input id="modId" name="testMsgModRela.modId" type="hidden"  />
	  		      <input class="inputClearBtn" onclick="javascript:cleardata('modelId','modelName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
	  		      <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/testPiles/showTestMsgMod.shtml?pageState=pageState&modId=modId&modName=modName','%{getText('eaap.op2.conf.testPiles.chooseModel')}')" shape="s"></ui:button>
            </tr>
            <tr>
              <td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.relatedObjType')}"/>:</td>
              <td  width="40%">
                    <ui:select skin="${contextStyleTheme}"  emptyOption="true" name="testMsgModRela.objType" id="objType" onchange="objTypeOnchange()"
    			       list="objTypeList" listKey="key" listValue="value" style="width:70px;" ></ui:select>
              </td>
            </tr>
            
            <tr id="serInvokeIns">
                <td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.relatedSerInvokeIns')}"/>:</td>
                <td width="40%">
                    <ui:inputText skin="${contextStyleTheme}" name="serInvokeInsName" id="serInvokeInsName"  textSize="25" readonly="true" style="float:left;"></ui:inputText> 
	   				<input class="inputClearBtn" onclick="javascript:cleardata('serInvokeInsId','serInvokeInsName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
	   				<ui:inputText name="serInvokeInsId" id="serInvokeInsId" type="hidden" value="${bean.serInvoKeIns.serInvokeInsId}" skin="${contextStyleTheme}"/>
	   				<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/selectSerInvokeInsList.shtml?pageState=pageState&serInvokeInsId=serInvokeInsId&&serInvokeInsName=serInvokeInsName','%{getText('eaap.op2.conf.testPiles.chooseSerInvokeIns')}')" shape="s"></ui:button>
	   			</td>
            </tr>
            
            <tr id="service">
               <td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.relatedService')}"/>:</td>
               <td width="40%">
	  		      <ui:inputText skin="${contextStyleTheme}" name="serviceName" id="serviceName"  textSize="25" readonly="true" style="float:left;"></ui:inputText> 
	  		      <input class="inputClearBtn" onclick="javascript:cleardata('serviceId','serviceName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
	  		      <input id="serviceId" name="serviceId" type="hidden"  />
	  			  <input name="serviceCode" id="serviceCode" type="hidden"  />
			 	  <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/serviceManager/showMainInfo.shtml?serviceId=serviceId&&serviceName=serviceName&&serviceCode=serviceCode&&pageState=pageState','%{getText('eaap.op2.conf.testPiles.chooseService')}')" shape="s"></ui:button>
               </td>
            </tr>
            
            <tr>
    			   <td  colspan="4" class="item-content" align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.checksubmit')}"  shape="M" id="checksubmitId" onclick="updateTestMsgModRela();"></ui:button>
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}"  shape="M" id="checkcancelId" onclick="returnPage();"></ui:button>
				   </td>
    		 </tr>
    	  </table>
	</div>
	</div>
</ui:form>
</div>
<script>
	$(document).ready(function(){
	  var objType =  $('#objType').find('option:selected').val();
	  if (objType == "1") {
		  $('#service').attr("style","display:none");
		  $('#serInvokeIns').removeAttr('style');
	  } else if (objType == "0") {
		  $('#serInvokeIns').attr("style","display:none");
		  $('#service').removeAttr('style');
	  }
	});
	
	function objTypeOnchange(){
		  var objType =  $('#objType').find('option:selected').val();
		  if (objType == "1") {
			  $('#service').attr("style","display:none");
			  $('#serInvokeIns').removeAttr('style');
		  } else if (objType == "0") {
			  $('#serInvokeIns').attr('style','display:none');
			  $('#service').removeAttr('style');
		  }
	}
	

</script>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>