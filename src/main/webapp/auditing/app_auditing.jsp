<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/${contextStyleTheme}/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<style>

</style>
<script type="text/javascript">
function doSubmit(){
	 var content_Id 	= $("#content_Id").val();
	 var activity_Id	= $("#activity_Id").val();
	 var checkState = $("select[name=checkState]").val();
	 var checkDesc 	= $("#checkDesc").val();
	 var pushMessageType="";
	 $("input[name='pushMessageType']:checkbox").each(function(){ 
         if($(this).attr("checked")){
        	 pushMessageType += $(this).val()+",";
         }
     })
	 if(checkState != "1"){
			if(!checkDesc){
				art.dialog.alert("operation","if you reject,the comment is not empty!");
				return;
			}
		}
	 if(checkDesc){
		 if(checkDesc.length > 512){
			art.dialog.alert("operation","Comment the length cannot exceed 512 characters!");
			return;
		}
	 }
		
	 $.ajax({
			async : false,
			type : "POST",
			url :  "${contextPath}/orgAndApp/checkAppOnlineOrUpgrade.shtml",
			dataType : "json",
			data : {content_Id:content_Id,
				activity_Id:activity_Id,
				checkState:checkState,
				checkDesc:checkDesc,
				pushMessageType:pushMessageType
				},
			success : function(data) {
				try {
		      		var retCode	= data.retCode;
		      		var retMsg	= data.retMsg;
		      		if(retCode=="0000"){		//Success
		      			art.dialog.alert("operation",retMsg);
				      	try {
			    			var vOpener=art.dialog.opener;
			    			vOpener.reloadList();
							art.dialog.close(); 
				      	} catch (e) {
						}
		      		}else{
		      			$("#retMsgDiv").show();
		      			$("#retMsg").html(retMsg);
		      		}
				} catch (e) {
	      			$("#retMsgDiv").show();
				}
			}
	});
}
</script>
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/edit.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.waitingtask')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <c:if test="${process_Model_Id=='25'}"><s:property value="%{getText('eaap.op2.conf.orgregauditing.apponlinetocheck')}"/></c:if>
      <c:if test="${process_Model_Id=='26'}"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appupgradedoto')}"/></c:if>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
      <c:if test="${process_Model_Id=='25'}"><s:property value="%{getText('eaap.op2.conf.orgregauditing.apponlinedesc')}"/></c:if>
      <c:if test="${process_Model_Id=='26'}"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appupgradeinfo')}"/></c:if>
    	
    	</div>
    </div>
     	<table class="mgr-table">
					<tr>
    				<td colspan="6" class="tab-header">
    					<s:property value="%{getText('eaap.op2.conf.orgregauditing.appdevinfo')}"/>
    				</td>
    			</tr>
					<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regusername')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.ORG_USERNAME}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.email')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.EMAIL}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.area')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.ZONE_NAME}
    				</td>
    			</tr>
    			<tr>    				
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtype')}"/>:
    				</td>
    				<td class="item-content">
    				<c:if test="${orgInfoMap.ORG_TYPE_CODE=='0'}">
    				<s:property value="%{getText('eaap.op2.conf.orgregauditing.userisother')}"/>
    				</c:if>
    				<c:if test="${orgInfoMap.ORG_TYPE_CODE=='1'}">
    				<s:property value="%{getText('eaap.op2.conf.orgregauditing.useriscomp')}"/>
    				</c:if>
    				<c:if test="${orgInfoMap.ORG_TYPE_CODE=='2'}">
    				<s:property value="%{getText('eaap.op2.conf.orgregauditing.userisperson')}"/>
    				</c:if>
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.realname')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.NAME}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.mobile')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.TELEPHONE}
    				</td>	
    			</tr>	
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardtype')}"/>:
    				</td>	
    				<td class="item-content">
    				<c:if test="${orgInfoMap.CERT_TYPE_CODE=='1'}">
    				<s:property value="%{getText('eaap.op2.conf.manager.auth.cardtypeisider')}"/>
    				</c:if>
    				<c:if test="${orgInfoMap.CERT_TYPE_CODE=='2'}">
    				<s:property value="%{getText('eaap.op2.conf.manager.auth.cardtypeiscom')}"/>
    				</c:if>
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardnum')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.CERT_NUMBER}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtime')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.CREATE_TIME}
    				</td>
    			</tr>
    		</table>

    		<table class="mgr-table">
    			<tr>
    				<td colspan="6" class="tab-header">
    					<s:property value="%{getText('eaap.op2.conf.orgregauditing.appinfo')}"/>:
    				</td>
    			</tr>
					<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appname')}"/>:
    				</td>	
    				<td class="item-content">${appInfoMap.APP_NAME}
    				</td>	
    				<td class="item">App Key:
    				</td>	
    				<td class="item-content">${appInfoMap.APPKEY}
    				</td>
    				<td class="item">App Secret:
    				</td>
    				<td class="item-content">${appInfoMap.APPSECURE}
    				</td>
    			</tr>
    			<tr>    				
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appcomid')}"/>:
    				</td>
    				<td class="item-content">${appInfoMap.COMPONENT_ID}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.apptype')}"/>:
    				</td>
    				<td class="item-content">${appInfoMap.APP_TYPE_NAME}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.apponlinetime')}"/>:
    				</td>
    				<td class="item-content">${appInfoMap.APP_CREATE_TIME}
    				</td>	
    			</tr>	
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.applogo')}"/>:
    				</td>
    				<td colspan="6" class="item-content">
    				<c:choose>
	                <c:when test="${appInfoMap.S_FILE_ID!=null and appInfoMap.S_FILE_ID!=''}">
	                <img src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${appInfoMap.S_FILE_ID}" width="60" height="60"/>
	                </c:when>
	                <c:otherwise>
	                 <img width="60" height="60" src="${contextPath}/resource/blue/images/app.png"/>
	                </c:otherwise>
	                </c:choose>
					</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appjianjie')}"/>:
    				</td>
    				<td colspan="6" class="item-content">${appInfoMap.APP_SUMMA}
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appdesc')}"/>:
    				</td>
    				<td colspan="6" class="item-content">${appInfoMap.APP_DESC}
    				</td>
    			</tr>
    		</table>
    <div class="accordion-header" >
    
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.bookPackage')}"/>
      <c:if test="${process_Model_Id=='25'}"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appapilist')}"/>:</c:if>
      <c:if test="${process_Model_Id=='26'}"><s:property value="%{getText('eaap.op2.conf.orgregauditing.appupgradetoapi')}"/>:</c:if>
    	
    	</div>
    </div>
				<ui:form action="queryAppInfo.shtml" name="queryAppInfo">
				 <input type="hidden" name ="content_Id" id="content_Id" value="${content_Id}" />
	             <input type="hidden" name ="activity_Id" id="activity_Id" value="${activity_Id}" />
	             <input type="hidden" name ="process_Id" id="process_Id" value="${process_Id}" />
	             
				<table class="list-table" cellpadding="1" cellspacing="0">
					<tr class="tab-header">
    				<td class="middle" width="14%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.packageName')}"/>
    				</td>	
    				<td class="middle" width="20%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.org')}"/>
    				</td>
    				<td class="middle" width="20%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.apiname')}"/>
    				</td>	
    				<td class="middle" width="23%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.pricePlan')}"/>
    				</td>
    				<td class="middle" width="23%"><s:property value="%{getText('eaap.op2.conf.prov.settle')}"/></td>	
    				</tr>
    				<c:forEach var="appPkgInfo" items="${appPkgInfoList}" step="1"> 
					    <tr class="odd">
							<td class="middle">${appPkgInfo.PACKAGENAME}</td>
							<td class="middle">${appPkgInfo.ORG_NAME}</td>
							<td class="middle">
							<c:forEach var="appApiInfo" items="${appPkgInfo.APIs}" step="1"> 
							    <c:if test="${appApiInfo.FLAG=='1'}" >${appApiInfo.API_NAME},</c:if>
							</c:forEach>
						    </td>
						    <td class="middle">
                            <c:forEach var="pricePlanInfo" items="${appPkgInfo.pricePlan}" step="1"> 
							     ${pricePlanInfo.PRICINGNAME},
							</c:forEach>
                            </td>
                            <td class="middle">
                            <c:forEach var="settleInfo" items="${appPkgInfo.settleList}" step="1"> 
							     ${settleInfo.RULE_NAME},
							</c:forEach>
                            </td>
				        </tr>
				   </c:forEach>
			 </table>
			 <div align="right" >
			  
			 </div>
    	    </ui:form>
		<div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.check')}"/>
    	</div>
    </div>
    <div>
          <form action="${contextPath}/orgAndApp/checkOrgOnline.shtml" name="checkAppOnlineOrUpgrade">
            <input type="hidden" name ="content_Id" value="${content_Id}" />
            <input type="hidden" name ="activity_Id" value="${activity_Id}" />
            <input type="hidden" name ="process_Model_Id" value="${process_Model_Id}" />
            <input type="hidden" name ="app.componentId" value="${appInfoMap.COMPONENT_ID}" />
            
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>:
    				</td>	
    				<td  colspan="5">
    				<select name="checkState">
    				<option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
    				<option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option></select>
    				</td>	
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>:
    				</td>
    				<td colspan="5">
    					<textarea name="checkDesc" id="checkDesc" style="WIDTH: 70%; HEIGHT: 66px" ></textarea> 
    				</td>
    			</tr>
    			<c:if test="${not empty pushc_url}">
	    			<tr>
	    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageType')}"/>:
	    				</td>	
	    				<td    colspan="5">
	    					<input type="checkbox" name="pushMessageType" id="pushMessageType" value="1" />&nbsp;<s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageTypeByEmail')}"/>
			            	<input type="checkbox" name="pushMessageType" id="pushMessageType" value="2" />&nbsp;<s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageTypeBySms')}"/>
	    				</td>	
	    			</tr>
	    		</c:if>
    			<tr>
    				<td  colspan="6"   align="center">
						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="javascript:doSubmit();"  id="submitId"></ui:button>
						  <div id="retMsgDiv" style="display:none;color:#FF0000; text-align:left;">
    				    		<div style="color:#FF0000; text-align:left; font-weight:bold;">
    				    			<s:property value="%{getText('eaap.op2.conf.orgregauditing.auditingFailure')}" />
    				    		</div>
    				    		<div id="retMsg" style="color:#FF0000; text-align:left;"></div>
    				    </div>
    				</td>	
    			</tr>
    		</table>
    		</form>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkflow')}"/>
    	</div>
    </div>
    <div class="accordion-content">
			<div class="accordion-content-text"></div>

    	<div></div>
    </div>
</div>
 <ui:warn/> 

<!--body end --> 

</body>
</html>
