<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    
    <title>addTechImplInfo.jsp</title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<!-- 
	<script  src="${contextPath}/resource/resources/scripts/jquery-1.7.1.min.js" />
	
	 <script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
        <script  src="${contextPath}/resource/resources/scripts/ajaxfileupload.js" />
	 -->

	 <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
        <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
        <s:property value="tagUtil.writeScript('/resource/resources/scripts/ajaxfileupload.js')" escape="false"/>
  </head>
  
  <body>
	 	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	     <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle1')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle2')}" />
	     	</div>
	    </div>
	   
	   <div>
	   <!-- ../techimpl/addTechImplConfig.shtml -->
	   <ui:form id="addTechImpl" action="../techimpl/addTechImplInfoToNext.shtml" method="post" name="addTechImpl" enctype="multipart/form-data">
	   	<ui:validators validateAlert="div" validatorGroup="group2">
       	 	<ui:validator fieldId="componentName" validatorType="requiredstring" required="true"  message="%{getText('eaap.op2.conf.techimpl.tip.component')}"/>	
       	 	<ui:validator fieldId="techImplName" validatorType="requiredstring" required="true"   message="%{getText('eaap.op2.conf.techimpl.tip.TechnologyImpl')}"/>
       	 	<ui:validator fieldId="commProCd" validatorType="requiredstring" required="true"   message="%{getText('eaap.op2.conf.proof.notEmpty')}"/>
		 </ui:validators>
	   	<div class="module-path">
	  		<div class="module-path-content" align="center">
               <s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle2')}" />
	     	</div>
	    </div>
	 	<table class="mgr-table">
			<tr>
			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</td>
	   			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<input id=componentId name="techImpl.componentId" type="hidden" value="${techImpl.componentId }" />
	  					<ui:inputText skin="${contextStyleTheme}" name="component.name" id="componentName" readonly="true" value="${component.name }" textSize="25"></ui:inputText>
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=componentName&&chooseCompCode=componentId&chooseOrgName=orgName&chooseOrgId=orgId','%{getText('eaap.op2.conf.server.supplier.chooseComponent')}')" shape="s"></ui:button>	  					
	  				</div> 	
	   			</td>	 
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</td>
	  			<td class="item-content"> 
	  		    <div class="ui-widget"> 
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="org.name" id="orgName"  readonly="true" value="${org.name}" textSize="25"></ui:inputText>
	  					<input name="org.orgId" id="orgId" type="hidden" value="${org.orgId }" />
	  					<!--  
	  					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&chooseOrgCode=orgId','Choose Component')" shape="s"></ui:button>
	  					-->
	  				</div>
 		        </div>
	   			</td>
	   			
	   		</tr>
	   		<tr>
	  			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText skin="${contextStyleTheme}" name="techImpl.techImplName" id="techImplName" value="${techImpl.techImplName }" textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  				  <ui:select skin="${contextStyleTheme}" name="commProtocal.commProCd" id="commProCd" value="${CommProtocal.commProCd}" list="commProtocalResultList" width="172"  emptyOption="true" headerValue=" "	 listKey="commProtocalId" listValue="commProtocalName" onchange="getTechAttrSpec(this.value);"></ui:select>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<!--  
	   		<c:if test="${fn:length(tmpList)>=1}">
	   		<c:forEach var="tmpListVar" items="${tmpList}" step="1">
	   		<tr>
	   		     <td class="item">
	   		     ${tmpListVar.ATTR_SPEC_NAME}
	   		     </td>
	   		     <td class="item-content">
	   		     <div class="ui-widget">
	   		     <ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.ATTR_SPEC_CODE}" name="${tmpListVar.ATTR_SPEC_CODE}" value="" textSize="25"/>
	   		     </div> 
	   		     </td>
			</tr>
			</c:forEach>       
	   		</c:if>
	   		-->
	   		<tr>
	   			<c:if test="${fn:length(tmpList)>=1}">
		   			<c:forEach var="tmpListVar" items="${tmpList}" step="1" varStatus="vs">
		   				 <td class="item">
				   		     ${tmpListVar.ATTR_SPEC_NAME}:
			   		     </td>
			   		     <td class="item-content">
				   		     <div class="ui-widget">
				   		     	<input name="attrKey"  type="hidden"  value="${tmpListVar.ATTR_SPEC_CODE}" />
				   		     	<c:if test="${tmpListVar.ATTR_SPEC_ID !=83 && tmpListVar.ATTR_SPEC_ID !=11 && tmpListVar.ATTR_SPEC_ID !=15 && tmpListVar.ATTR_SPEC_ID !=213 && tmpListVar.ATTR_SPEC_ID !=215}">
				   		   		  <ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue" value="" textSize="25" />
				   		     		
				   		     	</c:if>	
				   		     	
				   		     	<c:if test="${tmpListVar.ATTR_SPEC_ID ==11 || tmpListVar.ATTR_SPEC_ID ==15 || tmpListVar.ATTR_SPEC_ID ==213 || tmpListVar.ATTR_SPEC_ID ==215}">
				   		     		<input id="${tmpListVar.ATTR_SPEC_CODE}" name="attrValue"  type="hidden"value="" />
				   		   		  	<input forid="${tmpListVar.ATTR_SPEC_CODE}"  value=""  type="password"  onclick="this.value=''" onblur="encryptionPassword(event)" onkeyup="trimPsd(event)" textSize="25"  style="width:169px; height:22px; border:1px solid #ccc;"/>
				   		     	</c:if>	
				   		     	
				   		     	<c:if test="${tmpListVar.ATTR_SPEC_ID==83}">
				   		   		  <input  id ="showMsgInput"name=""  type="text" value="" style="width:172px;display:none"ReadOnly/>
				   		   		  <ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.ATTR_SPEC_CODE}" name="${tmpListVar.ATTR_SPEC_CODE}" textSize="25" type="file" style="width:172px;"/>
				   		   		<!-- -
				   		   		  <input  name="upload"  type="button" value="upload" style="width:54px;"onclick="uploadFile()"/>
				   		   		 -->
				   		   		  <a  href="#" style="width:54px;"onclick="uploadFile()">
				   		   		  upload
				   		   		  </a>
				   		   		  <input  id ="uploadHidden"name="attrValue"  type="hidden" value="" style="width:54px;"/>
				   		     	</c:if>
				   		     </div> 
			   		     </td>
			   		     
			   		     
			   		     
			   		     <c:if test="${vs.index%2==1}">
			   		     </tr><tr>
			   		     </c:if>
		   			</c:forEach>
	   			</c:if>
	   		</tr>
	   		<!-- 
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.callUrl')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  			    <ui:inputText name="callUrl" id="callUrl"  textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.overtime')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  			        <ui:inputText name="overtime" id="overtime"  textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText name="webserviceMethodName" id="webserviceMethodName"  textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamNameSpace')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  			    <ui:inputText name="webserviceParamNameSpace" id="webserviceParamNameSpace"  textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamName')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">	  					  					
	  					<ui:inputText name="webserviceParamName" id="webserviceParamName"  textSize="25"></ui:inputText>
	  				</div>
	   			</td>
	   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.webserviceReturnParamName')}" />:</td>
	   			<td class="item-content">
	   				<div class="ui-widget">
	  			    <ui:inputText name="webserviceReturnParamName" id="webserviceReturnParamName"  textSize="25"></ui:inputText>
	  				</div>  	
	   			</td>
	   		</tr>
	   		 -->
	   		 <tr>
	  			<td class="item-center" colspan="4" >
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.save')}" onclick="if(comm_validators_check('group2')){document.addTechImpl.submit();}"></ui:button>
	   		    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDirCancel')}" onclick="goTechImplIndex();"></ui:button>
	  			</td>
	   		</tr>
	    </table>
	     </ui:form>
<%--
<table width="100%" border="0" cellspacing="0" cellpadding="0">
       <s:iterator id="riddleClass" value="riddleClasses" status="st">

        <s:if test="#st.last&&#st.odd">
         <tr align=center>

          <td class=pic_button_blue HEIGHT="45" BORDER=0 ALT="">
           <s:url id="toContent" action="toRiddleContentList">
            <s:param name="classid">
             <s:property value="%{id}" />
            </s:param>
           </s:url>
           <s:a href="%{toContent}">
            <s:property value="name" />
           </s:a>
          </td>
          <td>
           dfdf
          </td>
         </tr>

        </s:if>
        <s:elseif test="#st.odd">
         <tr align=center>
          <td class=pic_button_blue HEIGHT="45" BORDER=0 ALT="">
           <s:url id="toContent" action="toRiddleContentList">
            <s:param name="classid">
             <s:property value="%{id}" />
            </s:param>
           </s:url>
           <s:a href="%{toContent}">
            <s:property value="name" />
           </s:a>
          </td>
        </s:elseif>

        <s:else>
         <td class=pic_button_blue HEIGHT="45" BORDER=0 ALT="">
          <s:url id="toContent" action="toRiddleContentList">
           <s:param name="classid">
            <s:property value="%{id}" />
           </s:param>
          </s:url>
          <s:a href="%{toContent}">
           <s:property value="name" />
          </s:a>
         </td>
         </tr>
        </s:else>
       </s:iterator>

      </table>
	     --%>
	 
	  </div>
       </div> 
       <ui:iframe  skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
       </body>
          
      
       <script type="text/javascript">  
       
      function getTechAttrSpec(value){
    	  var orgName = $('#orgName').val();//Org.name
    	  var orgId = $('#orgId').val();//Org.orgId
    	  var componentName = $('#componentName').val();//Component.name
    	  var componentId = $('#componentId').val();//TechImpl.componentId
    	  var techImplName = $('#techImplName').val();//TechImpl.techImplName
       window.location.href="../techimpl/getTechAttrSpec.shtml?commProtocal.commProCd="+value+"&org.name="+orgName
    		   +"&org.orgId"+orgId+"&component.name="+componentName+"&techImpl.componentId="+componentId+
    		   "&techImpl.techImplName="+techImplName; 
      }      	
	  function toNext() {
	  document.addTechImpl.submit();
	  }
	  function closeWin() {
		$('#opendialog').window('close');
	  }
	  function goTechImplIndex(){
	  window.location.href="../techimpl/showTechImplIndex.shtml";
	  }
	  $(function () {

      })
	  function uploadFile() {
		 // alert(8888);
          $.ajaxFileUpload
          (
              {
                  url: '../techimpl/uploadFile.shtml', //用于文件上传的服务器端请求地址
                  secureuri: false, //是否需要安全协议，一般设置为false
                  fileElementId: 'AUTH_FILE_PATH', //文件上传域的ID
                  dataType: 'json', //返回值类型 一般设置为json
                  success: function (data)  //服务器成功响应处理函数
                  {
                	  if(data[0].msg==1){
                		$("#showMsgInput").val(data[0].data);  
                		$("#uploadHidden").val(data[0].data);  
                      	alert("Uploaded successfully!");
                		$("#showMsgInput").show();  
                	  }else{
                		$("#uploadHidden").val("");  
                    	  alert(data[0].data);
                	  }
                	 // alert(8888999);
                	//  alert(data[0].data);
                      //alert(7777);
                  //    alert(data[0].msg);
                  
                  },
                  error: function (data, status, e)//服务器响应失败处理函数
                  {
               		$("#uploadHidden").val("");  
                      alert("Failed to upload!");
                    //  alert(e);
                  }
              }
          )
          return false;
      }
      
function changeNodeValue(){
		var obj = event.srcElement;
		var forid = obj.attributes["forid"];
		if(forid != undefined){
			var foridObj = obj.attributes["forid"].value;
			$("#"+foridObj).val(obj.value);
		}
}

function trimPsd(event){
	var eObj = event.srcElement?event.srcElement:event.target;
	eObj.value =jQuery.trim(eObj.value);
}
	
function encryptionPassword(event){
	var eObj = event.srcElement?event.srcElement:event.target;
	var forid = eObj.attributes["forid"];
	if(forid != undefined){
		var passwordObj = eObj.attributes["forid"].value;
		if(eObj.value==""){
			$("#"+passwordObj).val("");
		}else{
			//加密：
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../techimpl/encryptionPassword.shtml",
			     dataType:"json",
			     data:{PlaintextPassword : eObj.value},				//传入明文
			     success:function(msg,data){
						try{
					 		var isjson = typeof(msg)=="object" && Object.prototype.toString.call(msg).toLowerCase() == "[object object]" && !msg.length; 
							if(isjson){
					      		var resultCode = msg.ResultCode;
					      		var CiphertextPassword = msg.CiphertextPassword;		//返回密文
					      		if(resultCode=="Success"){
									$("#"+passwordObj).val(CiphertextPassword);
					      		}
							}
						}catch(e){
						}
		   	  	}
			});	
		}
	}
}
</script>   
</html>

