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
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/edit.png" />
     
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.waitingtask')}"/>
      <img src="../resource/blue/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.orgregauditing.orgregcheck')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.userorgforcheck')}"/>
    	</div>
    </div>
    
    <div>
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regrole')}"/>:
    				</td>	
    				<td class="item-content">
    				<c:if test="${orgInfoMap.ROLE_CODE=='1'}">
    				<s:property value="%{getText('eaap.op2.conf.orgregauditing.devrole')}"/>
    				</c:if>
    				<c:if test="${orgInfoMap.ROLE_CODE=='2'}">
    				<s:property value="%{getText('eaap.op2.conf.orgregauditing.prorole')}"/>
    				</c:if>
    				<c:if test="${orgInfoMap.ROLE_CODE=='3'}">
    				<s:property value="%{getText('eaap.op2.conf.orgregauditing.hezuohuoban')}"/>
    				</c:if>
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regusername')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.ORG_USERNAME}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtime')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.CREATE_TIME}
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.email')}"/>:
    				</td>	
    				<td class="item-content">${orgInfoMap.EMAIL}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.area')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.ZONE_NAME}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.address')}"/>:
    				</td>
    				<td class="item-content">${orgInfoMap.ADDRESS}
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
				<c:if test="${orgInfoMap.ORG_TYPE_CODE!='2'}">
					<tr>
						<td  class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardtype')}"/>:
						</td>	
						<td  class="item-content">${orgInfoMap.CARDTYPENAME}
						</td>
						<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardnum')}"/>:
						</td>	
						<td class="item-content">${orgInfoMap.CERT_NUMBER}
						</td>
						<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.indenAddress')}"/>:
						</td>	
						<td class="item-content">${orgInfoMap.INDEN_ADDRESS}
						</td>
					</tr>

					<tr>
						<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.indenEffDate')}"/>:
						</td>	
						<td class="item-content">${orgInfoMap.INDEN_EFF_DATE}
						</td>
						<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.indenExpDate')}"/>:
						</td>	
						<td class="item-content">${orgInfoMap.INDEN_EXP_DATE}
						</td>

						<td  class="item">&nbsp;
						</td>	
						<td  class="item-content">&nbsp;
						</td>
					</tr>
				</c:if>

				<c:if test="${orgInfoMap.ORG_TYPE_CODE=='2'}">
					<tr>
						<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.legalName')}"/>:
						</td>	
						<td colspan="5" class="item-content">${orgInfoMap.LEGAL_NAME}
						</td>
						
					</tr>
				</c:if>
    			<tr> 
    			  <c:choose>
    			     <c:when test="${not empty orgInfoMap.PARTNERTYPENAME}">
    			         	<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regPartnerType')}"/>:
		    				</td>
		    				<td class="item-content">
									${orgInfoMap.PARTNERTYPENAME}
		    				</td>
		    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.intro')}"/>:
		    				</td>
		    				<td colspan="3" class="item-content">${orgInfoMap.DESCRIPTOR}
		    				</td>
    			     </c:when>
    			     <c:otherwise>
    			     		<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.intro')}"/>:
		    				</td>
		    				<td colspan="5" class="item-content">${orgInfoMap.DESCRIPTOR}
		    				</td>
    			     </c:otherwise>
    			  </c:choose>
    			
    			</tr>
    			
    			
    			<c:choose>
    			     <c:when test="${not empty orgInfoMap.SUB_EMAIL && not empty orgInfoMap.SUB_TELEPHONE}">
	    			     <tr>
	    			  			<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regSubEmail')}"/>:
			    				</td>
			    				<td class="item-content">
										${orgInfoMap.SUB_EMAIL}
			    				</td>
			    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regSubPhone')}"/>:
			    				</td>
			    				<td colspan="3" class="item-content">${orgInfoMap.SUB_TELEPHONE}
			    				</td>
	    				</tr>
    			     </c:when>
    			     <c:when test="${not empty orgInfoMap.SUB_EMAIL}">
    			      	<tr>
	    			  			<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regSubEmail')}"/>:
			    				</td>
			    				<td colspan="5" class="item-content">${orgInfoMap.SUB_EMAIL}
			    				</td>
	    				</tr>
    			     </c:when>
    			 	<c:when test="${not empty orgInfoMap.SUB_TELEPHONE}">
    			     	 <tr>
	    			  			<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regSubPhone')}"/>:
			    				</td>
			    				<td colspan="5" class="item-content">${orgInfoMap.SUB_TELEPHONE}
			    				</td>
	    				</tr>
    			     </c:when>
    			</c:choose>
    			
    			<tr style="display: none;">
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.cardphoto')}"/>:
    				</td>	
    				<td colspan="5" class="item-content">
    				<c:if test="${not empty orgInfoMap.FIL_S_FILE_ID}">
    				   <img src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${orgInfoMap.FIL_S_FILE_ID}" width="400" height="300"/>
    				</c:if>
    				</td>
    			</tr>
    		</table>
    		
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.check')}"/>
    	</div>
    </div>
    <div>
           <form action="${contextPath}/orgAndApp/checkOrgOnline.shtml" name="checkOrgOnline">
            <input type="hidden" name ="content_Id" id="content_Id" value="${content_Id}" />
            <input type="hidden" name ="activity_Id" id="activity_Id" value="${activity_Id}" />
            
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>:
    				</td>	
    				<td    colspan="5">
    				<select name="checkState" id="checkState">
    				<option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
    				<option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option>
    				</select>
    				</td>	
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>:
    				</td>
    				<td  colspan="5">
    					<textarea name="checkDesc"  id="checkDesc"  style="WIDTH: 70%; HEIGHT: 66px" ></textarea> 
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
    					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="orgAuditing();"  id="submitId"></ui:button>
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
    </div>

    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkflow')}"/>
    	</div>
    </div>
    <div class="accordion-content">

    </div>
</div>


<!--body end --> 

</body>
</html>
<script type="text/javascript">
function orgAuditing(){
	 var content_Id 	= $("#content_Id").val();
	 var activity_Id	= $("#activity_Id").val();
	 var checkState 	= $("#checkState").val();
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
	 if(checkDesc.length > 512){
			art.dialog.alert("operation","Comment the length cannot exceed 512 characters!");
			return;
		} 
		
	 $.ajax({
			async : false,
			type : "POST",
			url :  "${contextPath}/orgAndApp/checkOrgOnline.shtml",
			dataType : "json",
			data : {content_Id:content_Id,
				activity_Id:activity_Id,
				checkState:checkState,
				checkDesc:checkDesc,
				pushMessageType:pushMessageType},
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
