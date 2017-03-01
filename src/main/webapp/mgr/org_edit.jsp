<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>

<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="../resource/comm/css/uploadify.css" /> 
<link rel="stylesheet" type="text/css" href="../resource/comm/css/imgUpload.css" />
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<script type="text/javascript" src="${contextPath}/resource/comm/js/swfobject.js"></script>
<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>
<script type="text/javascript" src="${contextPath}/resource/comm/js/img_upload.js"></script>

<script>
 function getOnchange(){
       
	var sltProvince = document.getElementById("area_a") ;	
	var sltCity = document.getElementById("area_b") ;      
    var provinceId = sltProvince.value ;
    sltCity.length = 0 ;
      
     var i=0 ;
     <c:forEach var="cityBean" items="${cityList}" step="1"> 
      if('${cityBean.PROVINCEID}'==provinceId)
      {
        
       sltCity[i] = new Option('${cityBean.CITYNAME}', '${cityBean.CITYID}') ;
        i++ ;
      }
       
    </c:forEach>
}

function changeProvince(){
	$("#area_b").find("option").remove();
	var provinceId = $("#area_a").val();
	$.ajax({
	     type:"post",
	     async:true,
	     url:"${contextPath}/mgr/loadCityAreaList.shtml",
	     dataType:"json",
	     data:{areaId:provinceId},
	     success:function(msg,data){
				try {
					if(msg!=null && msg!="" && msg.length>0){
						for(var i=0; msg.length>i; i++){
							var areaObj = msg[i];
							$("#area_b").append("<option value='"+areaObj.areaId+"'>"+areaObj.zoneName+"</option>");
						}
					}
				} catch (e) {
				}
   	  	}
	});	
}

function closeWin(){
 $('#opendialog').window('close');
 }
 
function validatorRequired() {
	var flag = false;
	$.each($("input[type=checkbox][id=orgRoles]"), function() {
	     if (this.checked) {
	    	 return flag = true;
	     }
	});
	return flag;
}
 
</script>
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.orglist')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.userinfoupdate')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.orgregauditing.userinfoupdate')}"/>
         </div>
         
    </div>
    
    <div>
       <ui:form  name="myForm" id="myForm" action="updateOrgInfo.shtml" method="post"> 
       
       <ui:validators validateAlert="div" validatorGroup="group1">
       	 	<ui:validator fieldId="orgname" validatorType="stringlength" required="true" minLength="2" maxLength="80" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.notexceed50char')}"/>	
       	 	<ui:validator fieldId="orgcode" validatorType="stringlength" required="true" minLength="1" maxLength="9" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.notexceed9char')}"/>
		    <ui:validator fieldId="orgcode" validatorType="ajax" ajaxMethods="eaap-op2-conf-manager-ConfManagerAction.validatorOrgInfo(orgcode))" message="%{getText('eaap.op2.conf.orgregauditing.tip.orgCodeExist')}"></ui:validator>
		    <ui:validator fieldId="email" validatorType="email"  required="true" onFocusMessage="%{getText('eaap.op2.conf.orgregauditing.pleaserightemail')}" message="%{getText('eaap.op2.conf.orgregauditing.notEmailFormat')}"></ui:validator>
		    <ui:validator fieldId="address" validatorType="stringlength"  maxLength="255" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.addressLengthTooLong')}"/>	
		    <ui:validator fieldId="telephone" validatorType="requiredstring" required="true" message="%{getText('eaap.op2.conf.orgregauditing.serviceNumIsNull')}"></ui:validator>
		    <c:if test="${localeName!='_en_US'}">
		    	<ui:validator fieldId="telephone" validatorType="mobile" required="true" message="%{getText('eaap.op2.conf.orgregauditing.notMobileFormat')}"></ui:validator>
		    </c:if> 
       	 	<ui:validator fieldId="telephone" validatorType="stringlength" required="true" minLength="1" maxLength="50" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.notexceed50char')}"/>	
		    <ui:validator fieldId="descriptor" validatorType="stringlength"  minLength="0" maxLength="500" trim="true" message="%{getText('eaap.op2.conf.orgregauditing.desLengthTooLong')}"></ui:validator> 
		 </ui:validators>
       
       <input type="hidden" name="org.orgId" value="${orgInfoMap.ORG_ID}"/>
    		<table class="mgr-table">
            
            <tr>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgname')}"/>:</td>
               <td>
                 <ui:inputText skin="${contextStyleTheme}"  id="orgname"        name="org.name" value="${orgInfoMap.NAME}" />  
              </td>
               
               <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgcode')}"/>:</td>
                <td>
                     <ui:inputText skin="${contextStyleTheme}"  name="org.orgCode" id="orgcode"  value="${orgInfoMap.ORG_CODE}" ></ui:inputText>
                    
                 </td>
            </tr>
            
            <tr>
             <td class="item" width="20%"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgtype')}"/>:</td>	
    		 <td width="30%">
    			      <ui:select skin="${contextStyleTheme}"  name="org.orgTypeCode" id="selectMenuId" value="${orgInfoMap.ORG_TYPE_CODE}"
    			      list="selectOrgTypeList" listKey="orgTypeCode" listValue="orgTypeName" style="width:70px;" ></ui:select>
    		  </td>
              <td class="item" width="20%"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgarea')}"/>:</td>
              <td width="30%">
                	<table border="0" style="border-width:0;margin:0;padding:0;">
                		<tr>
                		<td style="border-width:0;margin:0;padding:0;">
                			<ui:select skin="${contextStyleTheme}"  name="org.areaId" value="${orgInfoMap.AREA_ID}" id="area_b" style="width:70px;" list="provinceList" listKey="PROVINCEID" listValue="PROVINCENAME" ></ui:select>
                		</td>
                		<td style="border-width:0;margin:0;padding:0;display:none;">
                			<ui:inputText skin="${contextStyleTheme}"  name="org.address" id="address"  value="${orgInfoMap.ADDRESS}" ></ui:inputText>
                		</td>
                		</tr>
                	</table>
              </td>
            </tr>
    	    <tr>
              <td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgusername')}"/>:</td>
               <td>
                <ui:inputText skin="${contextStyleTheme}"  name="org.orgUsername"   value="${orgInfoMap.ORG_USERNAME}" readonly="true" id="username"  ></ui:inputText>
               </td>
            
              <td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orguserpassword')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  id="orgPwd"     type="password" value="******"   name="org.orgPwd" />  
              <div id="passwordDescription" class="strength0"></div> 
              </td>
            </tr>
            
            <tr style="display: none;">
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cardtype')}"/>:</td>
              <td>
              <ui:select skin="${contextStyleTheme}"  onchange="changecertNumCheck(this)" name="org.certTypeCode" id="selectCardId"  value="${orgInfoMap.CERT_TYPE_CODE}"
    			      list="selectCardTypeList" listKey="cardCode" listValue="cardName" style="width:90px;" ></ui:select>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cardnumer')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="certNumber"  name="org.certNumber"  value="${orgInfoMap.CERT_NUMBER}"  />  
                  
                  
              </td>
            </tr>
            
            
            
            <tr>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgeamil')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  name="org.email" id="email"   value="${orgInfoMap.EMAIL}" ></ui:inputText>
               </td>
          
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgmobilenum')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  name="org.telephone" id="telephone"   value="${orgInfoMap.TELEPHONE}"  ></ui:inputText> 
              </td>
            </tr>
            
            
             <tr style="display:none;">
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgrole')}"/>:</td>
              <td colspan="3"> 
              	<div id="orgRolesDiv" style="float:left;">
	              <input name="orgRoles" id="orgRoles" type="checkbox" <c:if test="${fn:contains(orgInfoMap.ROLE_CODE,'1')}">checked</c:if>  value="1"/><s:property value="%{getText('eaap.op2.conf.orgregauditing.devrole')}"/>
	              <input name="orgRoles" id="orgRoles" type="checkbox" <c:if test="${fn:contains(orgInfoMap.ROLE_CODE,'2')}">checked</c:if>  value="2"/><s:property value="%{getText('eaap.op2.conf.orgregauditing.prorole')}"/>
	              <input name="orgRoles" id="orgRoles" type="checkbox" <c:if test="${fn:contains(orgInfoMap.ROLE_CODE,'3')}">checked</c:if>  value="3"/><s:property value="%{getText('eaap.op2.conf.orgregauditing.hezuohuoban')}"/>
                </div>
              </td>
            </tr>
            
            
            
            
             <tr>
              <td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
              <td colspan="3"> 
               <ui:textarea skin="${contextStyleTheme}"  id="descriptor" name="org.descriptor" width="800" height="200" value="${orgInfoMap.DESCRIPTOR}"/>
              </td>
            </tr>
            
            
	           <tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgicon')}"/>:</td>
	     			<td colspan="3">
	     				<input id="imgUrl" type="hidden"  value="${orgInfoMap.S_FILE_ID}"  name="org.sFileId" />
	     				<input id="heightSize" type="hidden"  value="100" />
	     				<input id="widthSize" type="hidden"  value="100" />
	     				<div class="browse-files">
	      				<div class="browsebtn-warp clearfix" style="padding-left:1px;">
						<input type="file" name="uploadify" id="uploadify" />
						<!--ä¸ä¼ å¾çæ°ç®æé-->
						<span>
					 		<s:property value=" " />
					    </span>
	                    </div>
						<!--é¦æ¬¡ä¸ä¼ å¾çåæ¾ç¤ºå¾çå®¹å¨-->
						<div class="clearfix" id="div_imgcontainer"></div>
						<!--è¿åº¦æ¡-->
						<div id="imageQueue"></div>
	                    	<p class="fill-remind" ><s:property value="%{getText('eaap.op2.conf.manager.auth.imgUploadDesc')}" /></p>
							<!--ä¸ä¼ éè¯¯æç¤º-->
	             			<p id="p_allcomplete" class="error-inform"></p>
	                        <p class="error-inform"  style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.pngJpg')}" />.</p>
							<p class="error-inform"  id="photo_size_err" style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.imgSize')}" />.</p>
						</div>
						<br/>
						<c:choose>
			                <c:when test="${orgInfoMap.S_FILE_ID!=null and orgInfoMap.S_FILE_ID!=''}">
			                  <img id="imagecard" src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${orgInfoMap.S_FILE_ID}" width="100" height="100"/>
			                </c:when>
			                <c:otherwise>
			                 <img id="imagecard" src="${contextPath}/resource/${contextStyleTheme}/images/exampleImage.png" width="100" height="100"/>
			                </c:otherwise>
			            </c:choose>
	        		</td>
	           	 </tr>
	             <tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgcardimage')}"/>:</td>
	     			<td colspan="3">
	     				<div>
		     				<jsp:include page="/common/uploadifyOther.jsp"/>
	     				</div>
	     				<input id="imgUrlOther" type="hidden" value="${orgInfoMap.FIL_S_FILE_ID}"  name="org.filSFileId" />
	     				<input id="heightOtherSize" type="hidden"  value="250" />
		     		    <input id="widthOtherSize" type="hidden"  value="250" />
	     				<div class="browse-files">
	      				<div class="browsebtn-warp clearfix" style="padding-left:1px;">
						<input type="file" name="uploadifyOther" id="uploadifyOther" />
						<!--ä¸ä¼ å¾çæ°ç®æé-->
						<span>
					 		<s:property value=" " />
					    </span>
	                    </div>
						<!--é¦æ¬¡ä¸ä¼ å¾çåæ¾ç¤ºå¾çå®¹å¨-->
						<div class="clearfix" id="div_imgcontainerOther"></div>
						<!--è¿åº¦æ¡-->
						<div id="imageQueueOther"></div>
	                    	<p class="fill-remind" ><s:property value="%{getText('eaap.op2.conf.manager.auth.imgUploadDesc')}" /></p>
							<!--ä¸ä¼ éè¯¯æç¤º-->
	             			<p id="p_allcompleteOther" class="error-informOther"></p>
	                        <p class="error-informOther"  style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.pngJpg')}" />.</p>
							<p class="error-informOther"  id="photo_size_errOther" style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.imgSize')}" />.</p>
						</div>
						<br/>
						<c:choose>
			                <c:when test="${orgInfoMap.FIL_S_FILE_ID!=null and orgInfoMap.FIL_S_FILE_ID!=''}">
			                  <img id="imagecardOther" src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${orgInfoMap.FIL_S_FILE_ID}" width="250" height="250"/>
			                </c:when>
			                <c:otherwise>
			                 <img id="imagecardOther" src="${contextPath}/resource/${contextStyleTheme}/images/exampleImage.png" width="250" height="250"/>
			                </c:otherwise>
			            </c:choose>
	        		</td>
	           	 </tr>
    		     
    		     <tr>
    				<td  colspan="4" class="item-content" align="center">
    				<c:if test="${pageShowMsg ==null}">
	    				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="comm_validators_check('group1');if(comm_validators_check('group1')){myForm.submit();}"  id="submitId"></ui:button>
	    			</c:if>	
	    				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="history.go(-1);"></ui:button>
    				</td>	
    			</tr>
    			
    			
    		 </table>
    	   
    	</ui:form>
    		
    </div>
</div>

<ui:iframe  skin="${contextStyleTheme}"  divWidth="480" divHeight="235" iframeWidth="458" iframeHeight="200" divId="opendialog" divTitle="upload image" iframeId="iframe_map" iframeSrc="" iframeScrolling="no" frameborder="10" />
<!--body end --> 

</body>
<script> 
    
$(function(){
	initUploadify();
});

$(function(){
	initUploadifyOther();
});
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
