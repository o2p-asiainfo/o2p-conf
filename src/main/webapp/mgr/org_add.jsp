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

function Validate(){
 var orgPwd = document.myForm.orgPwd.value;
 var ls = 0;
 if(orgPwd.match(/([a-z])+/)){  ls++; }  
 if(orgPwd.match(/([0-9])+/)){  ls++; }  
 if(orgPwd.match(/([A-Z])+/)){   ls++; }  
 if(orgPwd.match(/[^a-zA-Z0-9]+/)){ ls++;}  
 if(orgPwd.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ){ ls++;}  
 if(orgPwd.length > 12){ ls++;}
 
 if(ls<2){
   return false ;  
 }
 return true ;  
}

 
function passwordStrength(password)
{
 var desc = new Array();
 desc[0] = "<s:property value="%{getText('eaap.op2.conf.orgregauditing.passwordinfo')}"/>".split(",")[0];
 desc[1] = "<s:property value="%{getText('eaap.op2.conf.orgregauditing.passwordinfo')}"/>".split(",")[1];
 desc[2] = "<s:property value="%{getText('eaap.op2.conf.orgregauditing.passwordinfo')}"/>".split(",")[2];
 desc[3] = "<s:property value="%{getText('eaap.op2.conf.orgregauditing.passwordinfo')}"/>".split(",")[3];
 desc[4] = "<s:property value="%{getText('eaap.op2.conf.orgregauditing.passwordinfo')}"/>".split(",")[4];
 desc[5] = "<s:property value="%{getText('eaap.op2.conf.orgregauditing.passwordinfo')}"/>".split(",")[5];
 var score   = 0;
 //if password bigger than 6 give 1 point
  
 //if password has both lower and uppercase characters give 1 point 
 if ( ( password.match(/[a-z]/) ) && ( password.match(/[A-Z]/) ) ) score++;
 //if password has at least one number give 1 point
 if (password.match(/\d+/)) score++;
 //if password has at least one special caracther give 1 point
 if ( password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;
 //if password bigger than 12 give another 1 point
 if (password.length > 12) score++;
 if(score>2)
 {
  
 $('#passwordDescription').show();
 }
  document.getElementById("passwordDescription").innerHTML = desc[score];
  document.getElementById("passwordDescription").className = "strength" + score;

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
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.useradd')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.orgregauditing.useradd')}"/>
         </div>
         
    </div>
    
    <div>
    <ui:form  name="orgaddForm" id="orgaddForm" action="insertOrgInfo.shtml" method="post"> 
    
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
   
          <table class="mgr-table">
            
            <tr>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgname')}"/>:</td>
               <td>
                 <ui:inputText skin="${contextStyleTheme}"  id="orgname"        name="org.name" />  
          
		             
               </td>
               
               <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgcode')}"/>:</td>
                <td>
                     <ui:inputText skin="${contextStyleTheme}"  name="org.orgCode" id="orgcode"  ></ui:inputText>
                    
                 </td>
            </tr>
            
            <tr>
             	<td class="item"  width="20%"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgtype')}"/>:</td>	
    			<td  width="30%">
    			      <ui:select skin="${contextStyleTheme}"   name="org.orgTypeCode" id="selectMenuId" 
    			      list="selectOrgTypeList" listKey="orgTypeCode" listValue="orgTypeName" style="width:70px;" ></ui:select>
    		  </td>
              <td class="item"  width="20%"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgarea')}"/>:</td>
              <td width="30%">
                	<table border="0" style="border-width:0; margin:0;padding:0;">
                		<tr>
                		<td style="border-width:0;margin:0;padding:0;">
                			<ui:select skin="${contextStyleTheme}"  name="org.areaId" id="area_a" style="width:70px;" list="provinceList" listKey="PROVINCEID" listValue="PROVINCENAME" ></ui:select>
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
                <ui:inputText skin="${contextStyleTheme}"  name="org.orgUsername"  id="username"  ></ui:inputText>
               </td>
            
              <td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orguserpassword')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  id="orgPwd"     type="password"   name="org.orgPwd" />  
              <div id="passwordDescription" class="strength0"></div> 
              </td>
            </tr>
            
            <tr style="display: none;">
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cardtype')}"/>:</td>
              <td> <ui:select skin="${contextStyleTheme}"   name="org.certTypeCode" id="selectCardId" list="selectCardTypeList" listKey="cardCode" listValue="cardName" style="width:70px;" ></ui:select></td>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.cardnumer')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="certNumber"  name="org.certNumber" />  
                  
                  
              </td>
            </tr>
            
            
            
            <tr>
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgeamil')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  name="org.email" id="email"  ></ui:inputText>
               </td>
          
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgmobilenum')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  name="org.telephone" id="telephone"  ></ui:inputText> 
              </td>
            </tr>
            
            
             <tr style="display:none;">
              <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgrole')}"/>:</td>
              <td colspan="3"> 
                <div id="orgRolesDiv" style="float:left;">
	              <input name="orgRoles" id="orgRoles" type="checkbox" value="1"/><s:property value="%{getText('eaap.op2.conf.orgregauditing.devrole')}"/>
	              <input name="orgRoles" id="orgRoles" type="checkbox" value="2"/><s:property value="%{getText('eaap.op2.conf.orgregauditing.prorole')}"/>
	              <input name="orgRoles" id="orgRoles" type="checkbox" value="3"/><s:property value="%{getText('eaap.op2.conf.orgregauditing.hezuohuoban')}"/>
              	</div>
              </td>
            </tr>
            
             <tr>
              <td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
              <td colspan="3"> 
               <ui:textarea skin="${contextStyleTheme}"   id="descriptor" name="org.descriptor" width="800" height="200"/> 
              </td>
            </tr>
    		     
	           <tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgicon')}"/>:</td>
	     			<td colspan="3">
	     				<input id="imgUrl" type="hidden"  name="org.sFileId" />
	     				<input id="heightSize" type="hidden"  value="100" />
	     				<input id="widthSize" type="hidden"  value="100" />
	     				<div class="browse-files" >
	      				<div class="browsebtn-warp clearfix" style="padding-left:1px;">
						<input type="file" name="uploadify" id="uploadify" />
						<!--上传图片数目提醒-->
						<span>
					 		<s:property value="  " />
					    </span>
	                    </div>
						<!--首次上传图片后显示图片容器-->
						<div class="clearfix" id="div_imgcontainer"></div>
						<!--进度条-->
						<div id="imageQueue"></div>
	                    	<p class="fill-remind" ><s:property value="%{getText('eaap.op2.conf.manager.auth.imgUploadDesc')}" /></p>
							<!--上传错误提示-->
	             			<p id="p_allcomplete" class="error-inform"></p>
	                        <p class="error-inform"  style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.pngJpg')}" />.</p>
							<p class="error-inform"  id="photo_size_err" style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.imgSize')}" />.</p>
						</div>
						<br/>
						<img id="imagecard" src="${contextPath}/resource/${contextStyleTheme}/images/exampleImage.png" width="100" height="100"/>
	        		</td>
	           	 </tr>
	             <tr>
	        		<td class="item"><s:property value="%{getText('eaap.op2.conf.manager.auth.orgcardimage')}"/>:</td>
	     			<td colspan="3">
	     				<div>
		     				<jsp:include page="/common/uploadifyOther.jsp"/>
	     				</div>
	     				<input id="imgUrlOther" type="hidden"  name="org.filSFileId" />
	     				<input id="heightOtherSize" type="hidden"  value="250" />
		     		    <input id="widthOtherSize" type="hidden"  value="250" />
	     				<div class="browse-files">
	      				<div class="browsebtn-warp clearfix" style="padding-left:1px;">
						<input type="file" name="uploadifyOther" id="uploadifyOther" />
						<!--上传图片数目提醒-->
						<span>
					 		<s:property value="  " />
					    </span>
	                    </div>
						<!--首次上传图片后显示图片容器-->
						<div class="clearfix" id="div_imgcontainerOther"></div>
						<!--进度条-->
						<div id="imageQueueOther"></div>
	                    	<p class="fill-remind" ><s:property value="%{getText('eaap.op2.conf.manager.auth.imgUploadDesc')}" /></p>
							<!--上传错误提示-->
	             			<p id="p_allcompleteOther" class="error-informOther"></p>
	                        <p class="error-informOther"  style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.pngJpg')}" />.</p>
							<p class="error-informOther"  id="photo_size_errOther" style="display:none;"><s:property value="%{getText('eaap.op2.conf.manager.auth.imgSize')}" />.</p>
						</div>
						<br/>
					    <img id="imagecardOther" src="${contextPath}/resource/${contextStyleTheme}/images/exampleImage.png" width="100" height="100"/>
	        		</td>
	           	 </tr>
    		     <tr>
    				<td  colspan="4" class="item-content" align="center">
    					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="if(comm_validators_check('group1')){orgaddForm.submit();}"  id="submitId"></ui:button>
    				     <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="history.go(-1);"></ui:button>
    				</td>	
    			</tr>
    			
    			
    		 </table>
    	</ui:form>
    		
    </div>
</div>
 <ui:iframe  skin="${contextStyleTheme}"  iframeWidth="480" iframeHeight="235" divId="opendialog" divTitle="upload image" iframeId="iframe_map" iframeSrc="" iframeScrolling="no" frameborder="10" />
 <ui:warn skin="${contextStyleTheme}"/>
<!--body end --> 

</body>
<script> 
 function changecertNumCheck(certtype)
 {
     alert(certtype.value);
   
 }
function closeWin(){
 $('#opendialog').window('close');
 }
 
  function testwarn()
 {
 
 
 confirmMsg('title','MSG',function a(t){
        alert(t);
 
 })
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

$(function(){
	initUploadifyOther();
	changeProvince();
});

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
