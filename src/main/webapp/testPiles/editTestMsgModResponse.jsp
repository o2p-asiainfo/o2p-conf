<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
</head>
<!--body start -->
<body >
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.testPiles.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testMsgMod')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
		    <s:property value="%{getText('eaap.op2.conf.testPiles.responseMessageMod')}" />
      	</div>
    </div>
    
	<div class="selectList" style="display:block;">	
		<ui:form method="post" id="myForm" action="saveTestMsgModResponse.shtml">	
             <input type="hidden" id="msgId" name="testMsgModResponse.msgId" value="${testMsgModResponse.msgId}"/>
             <input type="hidden" id="modId" name="testMsgModResponse.modId" value="${testMsgModResponse.modId}"/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value="${editOrAdd}"/>
             
		 	<table class="mgr-table">
            <tr>
              <td class="item" style="width:20%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.expression')}"/>:</td>
              <td  width="80%">
              <ui:textarea skin="${contextStyleTheme}" name="testMsgModResponse.expression"  id="expression"   value="${testMsgModResponse.expression}" width="900" height="60"></ui:textarea>
              </td>
            </tr>
            
            <tr>
              <td class="item" ><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.testPiles.responseMessageMod')}"/>:</td>
              <td >
               <ui:textarea skin="${contextStyleTheme}" name="testMsgModResponse.responseMsgMod"  id="responseMsgMod"   value="${testMsgModResponse.responseMsgMod}" width="900" height="250"></ui:textarea>
               </td>
            </tr>

            <tr>
              <td class="item" ><s:property value="%{getText('eaap.op2.conf.testPiles.remark')}"/>:</td>
              <td >
               <ui:textarea skin="${contextStyleTheme}" name="testMsgModResponse.remark"  id="remark"   value="${testMsgModResponse.remark}" width="900" height="50"></ui:textarea>
               </td>
            </tr>
    	  </table>
		</ui:form>
		
	</div>
	<div>
		<table  align="center">
		    <tr>
				<td id="saveButTr"  align="center">
				  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.save')}" id="saveBut" onclick="saveTestMsgModResponse()"></ui:button>
				</td>
				<td align="center">
						<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.testPiles.cancel')}"  shape="M" id="checkcancelId" onclick="returnPage();"></ui:button>
				</td>
			</tr>
		</table>
	</div>
</div>
<ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="250" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>
<script>		
function saveTestMsgModResponse(){
    var vOpener=art.dialog.opener; 
	if(jQuery.trim($("#expression").val()) == ""){
		alert("<s:property value='%{getText(\"eaap.op2.conf.testPiles.expression\")}' /> <s:property value='%{getText(\"eaap.op2.conf.testPiles.notNull\")}' />");
		$("#expression").focus();
		return;
	}
	if(jQuery.trim($("#responseMsgMod").val()) == ""){
		alert("<s:property value='%{getText(\"eaap.op2.conf.testPiles.responseMessageMod\")}' /> <s:property value='%{getText(\"eaap.op2.conf.testPiles.notNull\")}' />");
		$("#responseMsgMod").focus();
		return;
	}
	var msgId 								= $("#msgId").val();
	var modId 								= $("#modId").val();
	var expression 						= jQuery.trim($("#expression").val());
	var responseMsgMod			= jQuery.trim($("#responseMsgMod").val());
	var remark 								= jQuery.trim($("#remark").val());
	$.ajax({
	     type:"post",
	     async:false,
	     url:"../testPiles/saveTestMsgModResponse.shtml",
         dataType:"json",
         data:{
        	 "testMsgModResponse.msgId" : msgId,
        	 "testMsgModResponse.modId" : modId,
        	 "testMsgModResponse.expression" : expression,
        	 "testMsgModResponse.responseMsgMod" : responseMsgMod,
        	 "testMsgModResponse.remark" : remark
        	 },
	     success:function(msg,data){
				try {
			          if(msg=="failure"){
			          		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
			          }
					  art.dialog.close(); 
					  vOpener.reloadList();
				} catch (e) { 
			      		alert("<s:property value="%{getText('eaap.op2.conf.testPiles.saveFailed')}" />");
				}
	   	  }
	});	
}
		
    function returnPage() {
    	art.dialog.close(); 
       	var vOpener=art.dialog.opener; 
    	vOpener.reloadList();
    }
</script>
