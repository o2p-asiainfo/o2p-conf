<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
 
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>

<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>

<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="../resource/comm/css/uploadify.css" /> 
<link rel="stylesheet" type="text/css" href="../resource/comm/css/imgUpload.css" />
<script type="text/javascript" src="${contextPath}/resource/comm/js/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>
<script type="text/javascript" src="${contextPath}/resource/comm/js/img_upload.js"></script>
 
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.compregauditing.compManage')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.useradd')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.compregauditing.compinfo')}"/>
         </div>
         
    </div>
    
    <div>
    <ui:form id="myForm" name="myForm" action="insertCompInfo.shtml" method="post"> 
		 <ui:validators validateAlert="div" validatorGroup="group1">
       	 	<ui:validator fieldId="componentName" validatorType="stringlength" required="true" minLength="2" maxLength="100" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.notexceed100char')}"/>	
       	 	<ui:validator fieldId="componentCode" validatorType="stringlength" required="true" minLength="2" maxLength="100" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.notexceed100char')}"/>
		    <ui:validator fieldId="componentCode" validatorType="ajax" ajaxMethods="eaap-op2-conf-auditing-ComponmentAction.validatorComponentInfo(componentCode)" message="%{getText('eaap.op2.conf.orgregauditing.tip.comCodeExist')}"></ui:validator>
		 	<ui:validator fieldId="orgorgName" validatorType="requiredstring"  message="%{getText('eaap.op2.conf.orgregauditing.orgNameIsNull')}"></ui:validator>
		 </ui:validators> 
 
          <table class="mgr-table">
            
            <tr>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.compName')}"/>:</td>
               <td>
                 <ui:inputText skin="${contextStyleTheme}"  id="componentName"  name="component.name" />  
          
		             
               </td>
               
               <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.compCode')}"/>:</td>
                <td>
                     <ui:inputText skin="${contextStyleTheme}"  name="component.code" id="componentCode"  ></ui:inputText>
                    
                 </td>
            </tr>
            
            <tr>
             <td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compType')}"/>:
    			 </td>	
    				<td>
    			      <ui:select skin="${contextStyleTheme}" name="component.componentTypeId" id="componentTypeId"  onchange="getOnchange(this.value)" 
    			      list="comTypeList" listKey="COMPONENT_TYPE_ID" listValue="NAME" />
    				 </td>
    				
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</td>
              <td>
                    <ui:inputText skin="${contextStyleTheme}"  id="orgorgName" name="org.orgname" readonly="true"/>
    				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgCode=orgorgId&chooseOrgName=orgorgName','Select Organization')" shape="s"></ui:button>
    			    <input id="orgorgId"  name="component.orgId" type="hidden"/>
              </td> 
            </tr>
    	      
    		     <tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.compPic')}"/>:</td>
	     			<td colspan="3" style="padding-left: 5px;">
	     				<input id="imgUrl" type="hidden"  name="component.sfileId" />
	     				<input id="heightSize" type="hidden"  value="100" />
	     				<input id="widthSize" type="hidden"  value="100" />
	     				<div class="browse-files">
	      				<div class="browsebtn-warp clearfix">
						<input type="file" name="uploadify" id="uploadify" />
						<span>
					 		<s:property value=" " />
					    </span>
	                    </div>
						<div class="clearfix" id="div_imgcontainer"></div>
						<div id="imageQueue"></div>
	                    	<p class="fill-remind" ><s:property value="%{getText('eaap.op2.conf.manager.auth.imgUploadDesc')}" /></p>
	             			<p id="p_allcomplete" class="error-inform"></p>
	                        <p class="error-inform"  style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.pngJpg')}" />.</p>
							<p class="error-inform"  id="photo_size_err" style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.imgSize')}" />.</p>
						</div>
						<br/>
						<img id="imagecard" src="${contextPath}/resource/${contextStyleTheme}/images/exampleImage.png" width="100" height="100"/>
	        		</td>
	           	 </tr>
    		     
    		     </table>
    		   
    		   
    	  <table class="mgr-table" id="appinfo">
    	       <tr>
    		       <td  colspan="4">
    					<div class="accordion-header" >
					    	<div class="accordion-header-text">
					    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
					         <s:property value="%{getText('eaap.op2.conf.compregauditing.appinfo')}"/>
					         </div>
					         
					     </div>  
    				</td>
    		 </tr>
    			
             <tr>
              <td class="item"><font color="red">*</font>AppKey:</td>
               <td colspan="4">
                 <ui:inputText skin="${contextStyleTheme}"  id="app.appkey"   textSize="40"   value="${app.appkey }"  readonly="true"   name="app.appkey" />  
          
		             
               </td>
               <%-- 
               <td class="item"><font color="red">*</font>AppSecure:</td>
                <td>
                     <ui:inputText skin="${contextStyleTheme}"  name="app.appsecure" id="appAppsecure" value="${app.appsecure }" readonly="true" ></ui:inputText>
                     <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.refresh')}" id="suaxin" onclick="refreshSecret();" shape="s"/>
                 </td>--%>
            </tr>
            <tr>
             <td  class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.appOauthType')}"/>:
    			 </td>	
    				<td>
    			      <ui:select skin="${contextStyleTheme}" name="app.appOauthType" id="selectMenuId" 
    			      list="appOauthTypeList" listKey="appOauthTypeCode" listValue="appOauthTypeName" style="width:150px;" ></ui:select>
    				 </td>
    				
              <td  class="item">AppSecure:</td>
              <td>
                    <ui:inputText skin="${contextStyleTheme}"  id="app.appsecure" name="app.appsecure"  value="${app.appsecure }"/>
    				 
              </td>
            </tr>
            
            <tr>
             <td  class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.apptype')}"/>:
    			 </td>	
    				<td>
    			      <ui:select skin="${contextStyleTheme}" name="app.appType" id="selectMenuId" 
    			      list="appTypeList" listKey="appTypeCode" listValue="appTypeName" style="width:150px;" ></ui:select>
    				 </td>
    				
              <td  class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.appdangurl')}"/>:</td>
              <td>
                    <ui:inputText skin="${contextStyleTheme}"  id="app.appUrl" name="app.appUrl"/>
    				 
              </td>
            </tr>
    	      
    	      <tr>
    			 <td  class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.apphdurl')}"/>:
    			   </td>	
    				<td>
    				<ui:inputText skin="${contextStyleTheme}"  id="app.appCallbackUrl" name="app.appCallbackUrl"/>
                    </td>
	              	<td  class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.appIntroduction')}"/>:</td>
	             	<td>
	                    <ui:inputText skin="${contextStyleTheme}"  id="app.appSumma" name="app.appSumma"/>
	                </td>
    		     </tr>
    		     
				<tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.compregauditing.appDetails')}"/>:</td>
	     			<td colspan="3" style="padding-left: 5px;">
	     			       <ui:textarea skin="${contextStyleTheme}" name="app.appDesc" id="app.appDesc" width="600" height="100"></ui:textarea>
	        		</td>
	           	 </tr>
    		     </table>
    		     
    		     
    		     
			 <table class="mgr-table">
    		     <tr>
    		       <td  colspan="4" class="item-content" align="center">
    					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" 
    				           onclick="if(comm_validators_check('group1')){myForm.submit();}"  id="submitId"></ui:button>
    				    
    				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="location='${contextPath}/component/showCompList.shtml'"  id="submitId"></ui:button>        
    				</td>
    			 </tr>
    			
    			
    		 </table>
    	</ui:form>
    		
    </div>
</div>
 <ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialogtochoose" divTitle="choose org" iframeId="iframe_org" iframeSrc="" frameborder="10" />
 <ui:iframe  skin="${contextStyleTheme}"  iframeWidth="480" iframeHeight="235" divId="opendialog" divTitle="upload image" iframeId="iframe_map" iframeSrc="" iframeScrolling="no" frameborder="10" />
 <ui:warn skin="${contextStyleTheme}" />
<!--body end --> 

</body>
<script> 

if('2'==$("#componentTypeId").val())
{
// changeTopScrollHeight();
// $('#appinfo').show();
}
 function getOnchange(str){
  
//  if('2'==str)
//  {
//  $('#appinfo').show();
//  }else {
  
//  $('#appinfo').hide();
//  }
//  changeTopScrollHeight();
 }
 
 
 function changecertNumCheck(certtype)
 {
     alert(certtype.value);
   
 }
function closeWin(){
 $('#opendialog').window('close');
 $('#opendialogtochoose').window('close');
 
 }
 
  function testwarn()
 {
 
 
 confirmMsg('title','MSG',function a(t){
        alert(t);
 
 })
 }
 
 
 function refreshSecret(){
  	if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmRef')}" />"))
    {			
	var url = "${contextPath}/mgr/result.jsp";
	$.ajax({
    url: url,
    type: 'GET',
    timeout: 1000,
    error: function(){
        alert('Error loading');
    },
    success: function(xml){
        $("#appAppsecure").val(xml.replace(/^\s+|\s+$/g,""));
    }
});
	}					
}

function respCb(originalRequest){
   
     var result = originalRequest.responseText.replace(/^\s+|\s+$/g,"");
	 $("#appAppsecure").val(result);
	 
}

 
 var sltCity1 = document.getElementById("area_b") ; 
 var j=0;
 
     <c:forEach var="cityBean" items="${cityList}" step="1"> 
      if('${cityBean.PROVINCEID}'==600103)
      { 
         
        sltCity1[j] = new Option('${cityBean.CITYNAME}', '${cityBean.CITYID}') ;
         
        j++ ;
      }
    </c:forEach>
    
$(function(){
	initUploadify();
});
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
