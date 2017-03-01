<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<head>
<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/${contextStyleTheme}/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<style>
    
/* --------- 2016/04/25 --------- */
.text-left{ text-align: left!important;}
.text-center{ text-align: center!important;}
.bold{font-weight: bold;}
.text-right{ text-align: right!important;}
    .table {
    border-collapse: collapse !important;
    width:100%;
  }
  .table td,
  .table th {
    background-color: #fff !important;
    padding: 8px!important;
  }
  .table-bordered th,
  .table-bordered td {
    border: 1px solid #ddd !important;
  }
.form-control {
  box-sizing:border-box;
  display: block;
  width: 100%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-

box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow 

ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow 

ease-in-out .15s;
}
.form-control:focus {
  border-color: #66afe9;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px 

rgba(102, 175, 233, .6);
          box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px 

rgba(102, 175, 233, .6);
}
.form-control::-moz-placeholder {
  color: #999;
  opacity: 1;
}
.form-control:-ms-input-placeholder {
  color: #999;
}
.form-control::-webkit-input-placeholder {
  color: #999;
}
body{position: relative;}
</style>
</head>
<body>



<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
      		<img src="${contextPath}/resource/blue/images/edit.png" />   
      			<s:property value="%{getText('eaap.op2.conf.prov.waitTask')}" />
      		<img src="${contextPath}/resource/blue/images/module-path.png" />
      		    <c:if test="${audiResult=='audi'}">
      		    	<s:property value="%{getText('eaap.op2.conf.prov.auditApplication')}" />
      		    </c:if>
      			<c:if test="${audiResult=='upgrade'}">
      		    	<s:property value="%{getText('eaap.op2.conf.prov.upGradeApplication')}" />
      		    </c:if>     			
      	</div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    		
    		 	<c:if test="${audiResult=='audi'}">
    				<s:property value="%{getText('eaap.op2.conf.prov.auditApplicationInfo')}" />
    			</c:if>
    			<c:if test="${audiResult=='upgrade'}">
    				<s:property value="%{getText('eaap.op2.conf.prov.upGradeApplicationInfo')}" />
    			</c:if>
    	</div>
    </div> 
    <c:if test="${findOrgList != null}">
    	<c:forEach items="${findOrgList}" var="findOrgList" varStatus="n">	
  			<table class="table table-bordered">
				<tr>
    				<td colspan="6" class="text-center bold">
    					<s:property value="%{getText('eaap.op2.conf.prov.openProvInfo')}" />
    				</td>
    			</tr>
					<tr >
    				<td style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.userName')}" />:
    				</td>	
    				<td style="width:15%">${findOrgList.ORGUSERNAME}
    				</td>	
    				<td style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.email')}" />:
    				</td>	
    				<td style="width:15%">${findOrgList.EMAIL}
    				</td>
    				<td style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.area')}" />:
    				</td>
    				<td style="width:15%">${findOrgList.ZONENAME}
    				</td>
    			</tr>
    			<tr>    				
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.AbilityType')}" />:
    				</td>
    				<td >${findOrgList.ORGTYPENAME}
    				</td>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.trueName')}" />:
    				</td>
    				<td >${findOrgList.NAME}
    				</td>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.mobile')}" />:
    				</td>
    				<td >${findOrgList.TELEPHONE}
    				</td>	
    			</tr>	
    			<tr>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.cardType')}" />:
    				</td>	
    				<td >${findOrgList.CERTTYPENAME}
    				</td>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.cardCode')}" />:
    				</td>	
    				<td >${findOrgList.CERTNUMBER}
    				</td>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.createTime')}" />:
    				</td>	
    				<td >${findOrgList.CREATETIME}
    				</td>
    			</tr>
    			<tr>
    				<td><s:property value="%{getText('eaap.op2.conf.orgregauditing.address')}" />:
    				</td>	
    				<td colspan="5">${findOrgList.ADDRESS}
    				</td>
    				
    			</tr>
    		</table>
		</c:forEach>
	</c:if><br />
    		<table class="table table-bordered">
    			<tr>
    				<td colspan="6" class="text-center bold">
    					<s:property value="%{getText('eaap.op2.conf.prov.sysBasicInfo')}" />
    				</td>
    			</tr>
				<tr>
    				<td style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.sysName')}" />:
    				</td>	
    				<td style="width:15%"> ${component.name}
    				</td>	
    				<td style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.systemNo')}" />:
    				</td>
    				<td style="width:15%">${component.code}
    				</td>
    				<td style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.onLineApplyTime')}" />:
    				</td>
    				<td style="width:15%">${applyTime}
    				</td>	
    			</tr>
    			<c:if test="${not empty component.sfileId}">
    			  <tr>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.systemIcon')}" />:
    				</td>
    				<td colspan="5" >  
    				 <img alt="$img.text" src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${component.sfileId}" width="60" height="60"/>
    				 </td>
   				 </tr>
    			</c:if>
    			<tr>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.sysDetail')}" />:
    				</td>
    				<td colspan="5" >${component.descriptor}
    				</td>
    			</tr>
    		</table>
		    <div class="accordion-header" >
		    	<div class="accordion-header-text">
		    	
		    			<c:if test="${audiResult=='audi'}">
		    				<s:property value="%{getText('eaap.op2.conf.prov.auditApplicationAbility')}" />
		    			</c:if>
		    			<c:if test="${audiResult=='upgrade'}">
		    				 <s:property value="%{getText('eaap.op2.conf.prov.upGradeApplicationAbility')}" />
		    			</c:if>
		    	</div>
		    </div>
				<table class="table table-bordered">
					<tr class="text-center bold">
						<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.serviceProvWay')}" />
    				</td>	
    				<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.fenType')}" />
    				</td>	
    				<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.developName')}" />
    				</td>
    				<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.state')}" />
    				</td>	
    				<td class="middle" width="30%"><s:property value="%{getText('eaap.op2.conf.prov.developValue')}" />
    				</td>	
    			</tr>
    			<c:if test="${findAbilityList != null}">
    			 <c:forEach items="${findAbilityList}" var="obj" varStatus="n">
	    			<tr class="even">
						<td class="middle">
						<c:if test="${obj.SERSPECVA == 'Y'}">
							<s:property value="%{getText('eaap.op2.conf.prov.oneselfService')}" />
						</c:if>
						<c:if test="${obj.SERSPECVA == 'N'}">
							<s:property value="%{getText('eaap.op2.conf.prov.generalService')}" />
						</c:if>												
						</td>
						<td class="middle">${obj.DIRNAME}</td>
						<td class="middle">${obj.CNNAME}</td>
						<td class="middle">
						 ${orgStateMap[obj.STATE]}
						</td>
					    <td class="left"><s:property value="%{getText('eaap.op2.conf.prov.serviceProvAddress')}" />:  ${obj.ATTRSPECVALUE}</td>
					</tr>
				</c:forEach>
			   </c:if>			
    		</table>
    	<div class="accordion-header" >
    		<div class="accordion-header-text">
    			<s:property value="%{getText('eaap.op2.conf.prov.package')}" />
    		</div>
    	</div>
    	<table class="table table-bordered">
					<tr class="text-center bold">
						<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.packageName')}" />
    				</td>	
    				<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.developName')}" />
    				</td>	
    				<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.pricePlan')}" />
    				</td>
    				<td class="middle" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.settle')}" />
    				</td>
    			</tr>
    			 
    			<c:if test="${showPackageList != null}">
    			 <c:forEach items="${showPackageList}" var="objp" varStatus="n">
	    			<tr class="even">
						 
						<td class="middle">${objp.PACKAGENAME}</td>
						<td class="middle">${objp.PRODUCTS}</td>
						<td class="middle">
						 <c:forEach items="${objp.PricePlan}" var="objPP" varStatus="n">
						    ${objPP.PRICINGNAME } ,
						 </c:forEach>
						</td>
						<td class="middle">
						 <c:forEach items="${objp.settleList}" var="objsl" varStatus="n">
						    ${objsl.RULE_NAME } 
						 </c:forEach>
						</td>
					</tr>
				</c:forEach>
			   </c:if>			
    		</table>
		<div class="accordion-header" >
    		<div class="accordion-header-text">
    			<s:property value="%{getText('eaap.op2.conf.prov.audiApprove')}" />
    		</div>
    	</div>
    <div>
    <ui:form id="provAudiForm"  method="post"  action="provAuditSubmit.shtml"> 
    <ui:validators validateAlert="word" validatorGroup="group1"> 
    <ui:validator fieldId="proposal" validatorType="stringlength" required="true" minLength="2" maxLength="1000" trim="true" message="%{getText('eaap.op2.portal.prov.notexceed1000char')}"/>
    </ui:validators>
    		<table class="table table-bordered">
    			<tr>
    				<td  style="width:15%"><s:property value="%{getText('eaap.op2.conf.prov.audiResult')}" />:
    				</td>	
    				<td style="width:75%">   				
	    				<ui:select  
		    				name="result" 
		    				id="result"   
		    				emptyOption="false" 
		    				headerValue=""
		    			    list="selectStateList" 
		    			    listKey="code" 
		    			    listValue="name" 
		    			    layerWidth="200px"
		    			    width="200px">
	    			    </ui:select>
	    			    <input type="hidden" id="audiResult" name="audiResult" value="${audiResult}"/>
    				</td>	
    			</tr>
    			<tr>
    				<td ><s:property value="%{getText('eaap.op2.conf.prov.audiProposal')}" />
    				</td>
    				<td  >
    				 <ui:textarea id="proposal" name="proposal" width="500" height="100"/> <font color="red">   *</font>
    					<input type="hidden" name="content_Id" id="content_Id" value="${content_Id}"/> 
    					<input type="hidden" name="activity_Id" id="activity_Id" value="${activity_Id}"/> 
    					<input type="hidden" name="user_Id" id="user_Id" value="${user_Id}"/> 
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
    				<td  colspan="2" class="item-content" align="center">
    				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.prov.submit')}"  onclick="auditSubmit();"  id="submitId"></ui:button>
    				    <div id="retMsgDiv" style="display:none;color:#FF0000; text-align:left;">
    				    		<div style="color:#FF0000; text-align:left; font-weight:bold;">
    				    			<s:property value="%{getText('eaap.op2.conf.orgregauditing.auditingFailure')}" />
    				    		</div>
    				    		<div id="retMsg" style="color:#FF0000; text-align:left;"></div>
    				    </div>
    				</td>	
    			</tr>
    		</table>
    	</ui:form>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<s:property value="%{getText('eaap.op2.conf.prov.audiProcess')}" />
    	</div>
    </div>
    <div class="accordion-content">
			<img src="${processDefImg}"/>
</div>


<!--body end --> 

</body>
</html>

<script type="text/javascript">
function auditSubmit(){
	 var content_Id 	= $("#content_Id").val();
	 var activity_Id	= $("#activity_Id").val();
	 var result 			= $("select[name=result]").val();
	 var audiResult	= $("#audiResult").val();
	 var proposal 		= $("#proposal").val();
	 var pushMessageType="";
	 $("input[name='pushMessageType']:checkbox").each(function(){ 
         if($(this).attr("checked")){
        	 pushMessageType += $(this).val()+",";
         }
     })
	 if(result != "1"){
		if(!proposal){
			art.dialog.alert("operation","if you reject,the comment is not empty!");
			return;
		}
	}
	 
	 $.ajax({
			async : false,
			type : "POST",
			url :  "${contextPath}/provAudit/provAuditSubmit.shtml",
			dataType : "json",
			data : {content_Id:content_Id,
				activity_Id:activity_Id,
				result:result,
				audiResult:audiResult,
				proposal:proposal,
				pushMessageType:pushMessageType},
			success : function(data) {
				try {
		      		var retCode	= data.retCode;
		      		var retMsg	= data.retMsg;
		      		if(retCode=="0000"){		//Success
				      	alert(retMsg);
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
