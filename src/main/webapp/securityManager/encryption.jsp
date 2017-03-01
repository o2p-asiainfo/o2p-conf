<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    <title>Encryption</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/jquery.js" ></script>
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/jquery-ui.min.js" ></script>
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/jquery.easyui.min.js" ></script>		 
	<link rel="stylesheet" type="text/css" href="${contextPath}/struts/simple/resource/skin/orange/queryBlock.css">
	<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=orange" ></script>
	 <script type="text/javascript" src="${contextPath}/resource/comm/adapter/json2.js" ></script>
        
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	     <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" />
	      	     <s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle1')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />
		    	<s:property value="%{getText('eaap.op2.conf.securityManager.encryption')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <ui:form id="addTechImpl" action="../techimpl/addTechImplInfoToNext.shtml" method="post" name="addTechImpl" enctype="multipart/form-data">

	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
               <s:property value="%{getText('eaap.op2.conf.securityManager.encipherTitle')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
				<td>
					<div style="text-align:center; padding:10px;">
						<span style="width:100px; height:25px; text-align:left; line-height:23px;"><s:property value="%{getText('eaap.op2.conf.securityManager.plaintext')}" />: </span> 
						<input id="plaintextPassword"  type="text"  style="width:70%; height:25px; border:1px solid #ccc; line-height:23px;;"/>
					</div>
					<div style="text-align:center; padding:10px;">
						<table align="center">
							<tr>
								<td id="loadImg" style="border:0; display:none;">
									<div style="width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.securityManager.enciphering')}" /></div>
					  			</td>
								<td id="encBut" style="border:0;">
		  							<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.securityManager.encryption')}"  onclick="encryptionPassword()"></ui:button>
					  			</td>
					   		</tr>
					    </table>
					</div>
					<div style="text-align:center; padding:10px;">
						<span style="width:100px; height:25px; text-align:left; line-height:23px;"><s:property value="%{getText('eaap.op2.conf.securityManager.ciphertext')}" />: </span> 
						<input id="ciphertextPassword"  type="text" style="width:70%; height:25px; border:1px solid #ccc; line-height:23px;" readonly="readonly"/>
					</div>
	  			</td>
	   		</tr>
	    </table>
</ui:form>
</div>
</div> 
</body>
<script type="text/javascript">
function encryptionPassword(){
		var plaintext = $("#plaintextPassword").val();
		if(plaintext !=""){
			$("#loadImg").show();
			$("#encBut").hide();
			//加密：
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../techimpl/encryptionPassword.shtml",
			     dataType:"json",
			     data:{PlaintextPassword:plaintext},			//传入明文
			     success:function(msg,data){
						$("#loadImg").hide();
						$("#encBut").show();
						try{
					 		var isjson = typeof(msg)=="object" && Object.prototype.toString.call(msg).toLowerCase() == "[object object]" && !msg.length; 
							if(isjson){
					      		var resultCode = msg.ResultCode;
					      		var ciphertext = msg.CiphertextPassword;		//返回密文
					      		if(resultCode=="Success"){
									$("#ciphertextPassword").val(ciphertext);
					      		}else{
					      			alert("<s:property value="%{getText('eaap.op2.conf.securityManager.encryptionFailure')}" />");
					      		}
							}
						}catch(e){
				      		alert("<s:property value="%{getText('eaap.op2.conf.securityManager.encryptionFailure')}" />");
						}
		   	  	}
			});	
		}
}
</script>   
</html>

