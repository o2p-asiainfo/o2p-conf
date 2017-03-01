<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<head>
	<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
	<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
	 
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />  
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
	<script type="text/javascript">
	function goPricePlan(priceInfoId,priceTarget){
		openWindows_lock("http://o2p.test2.telenor.eu:10080/portal/price/goPricePlan.shtml?prodIds="+$("input[name=content_Id]").val()+"&pricingPlan.pricingInfoId="+priceInfoId+"&actionType=detail&pricingTarget.pricingTargetId="+priceTarget+"&pricingPlan.applicType=1",'Price Plan',850,500,true);
	}
	function goSettle(busiCodeV){
		openWindows_lock("http://o2p.test2.telenor.eu:10080/portal/settle/goSettle.shtml?action=detail&settleCycleDef.busiCode="+busiCodeV+"&settleSpBusiDef.servCode="+$("input[name=content_Id]").val(),'Add/Update Settlement',850,550,true);
	}
	function showWind(type,objId,objType){
		openWindows('${frontEndUrl}/conf/offerAuditing/offerDetail_show_auditing.jsp?type='+type+'&objId='+objId+'&objType='+objType,'Product Offer',null,380);
	}
	</script>
	<style>
.text-left{ text-align: left!important;}
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
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.form-control:focus {
  border-color: #66afe9;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
          box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
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
</style>
</head>
<body>
	<script language="javascript">	
		<s:iterator value="actionScripts">
			<s:property escape="false"/>
		</s:iterator>
	</script>
	
	<div class="sectionMain dokuwiki clearfix">
		<div class="contentWarp">
			 <div class="module-path">
		  		<div class="module-path-content">
			      <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" />
			     
			      <s:property value="%{getText('eaap.op2.conf.orgregauditing.waitingtask')}"/>
			      <img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.pardOffer.offerCheck')}"/>
			      </div>
			  </div>
	    	  <div class="accordion-header" >
		    	<div class="accordion-header-text">
		    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.prodofferinfo')}"/>
		    	</div>
		    </div>
	    	
	    	<div>
	    		<table class="table table-bordered">
	    			<tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardOffer.offerName')}"/></td>	
	    				<td class="item-content">
		    					${prodOffer.prodOfferName}
	    				</td>	
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardOffer.offerCode')}"/></td>	
	    				<td class="item-content">${prodOffer.extProdOfferId}</td>
	    			</tr>
	    			<tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtime')}"/>
	    				</td>	
	    				<td class="item-content">${prodOffer.createDt}
	    				</td>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardmix.onlinetime')}"/>
	    				</td>	
	    				<td class="item-content">
	    				<ui:date id="btime" name="prodOffer.formatEffDate"   disabled="true" value="${prodOffer.formatEffDate}" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
	               			 ~ 
	               	    <ui:date id="etime" name="prodOffer.formatExpDate"   disabled="true" value="${prodOffer.formatExpDate}" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
	    				</td>
	    			</tr>
	    			<tr>
	    				<td class="text-right" width="150">Sales Channel </td>
	    				<td class="item-content">
	    				    <input type="checkbox" name="channel" id="channel" value="2" checked="checked" disabled="disabled"/>&nbsp;Third Party Partners 
		            		<input type="checkbox" name="channel" id="channel" value="2" checked="checked" disabled="disabled"/>&nbsp;Operator
	    				</td>
	    				
	    				<td class="text-right" width="150">Offer Type </td>
	    				<td class="item-content">
	    					<c:if test="${prodOffer.offerType==11}">
		                     	<label class="checkbox-inline">
									<input type="radio" value="11" name="prodOffer.offerType" checked="checked" disabled="disabled"/>
								Main Offer </label>
							</c:if> 
	                        <c:if test="${prodOffer.offerType==12}">
	                        	<label class="checkbox-inline">
									<input type="radio" value="12" name="prodOffer.offerType" checked="checked" disabled="disabled"/>
								Add On Offer </label>
							</c:if> 
	    				</td>
	    			</tr>
	    			<tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardmix.salearea')}"/>
	    				</td>
	    				<td colspan="6" class="item-content">
  				            ${FuncSeletedTreeMap.funcValue}
	    				</td>
	    			</tr>
	    			 <tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardOffer.offerDesc')}"/>
	    				</td>
	    				<td colspan="6" class="item-content">
  				                <c:choose>  
			                    <c:when test="${empty prodOffer.prodOfferDesc}">  
							       <s:property value="%{getText('eaap.op2.conf.orgregauditing.intro')}"/>......
							    </c:when>
							    <c:when test="${fn:length(prodOffer.prodOfferDesc)>50}">  
							        ${fn:substring(prodOffer.prodOfferDesc, 0, 50)}......
							    </c:when>  
							   <c:otherwise>  
							     ${prodOffer.prodOfferDesc}
							    </c:otherwise>  
							</c:choose>  
	    				</td>
	    			</tr>
	    			<c:if test="${fn:length(offerProdRelList)>=1 }">
	    			<tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardmix.proffer')}"/>
	    				</td>	
	    				<td colspan="6" class="item-content">
		    			 <table class="table table-bordered text-left">
				    			 	<tr>
          								<th width="20%"><s:property value="%{getText('eaap.op2.conf.pardSpec.provider')}" /></th>
          								<th width="20%"><s:property value="%{getText('eaap.op2.conf.pardSpec.code')}" /></th>
          								<th width="20%"><s:property value="%{getText('eaap.op2.conf.pardSpec.name')}" /></th>
          								<th width="20%"><s:property value="%{getText('eaap.op2.conf.pardSpec.minimum')}" /></th>
          								<th width="20%"><s:property value="%{getText('eaap.op2.conf.pardSpec.maximum')}" /></th>
          							</tr>
          								<c:forEach items="${offerProdRelList }" var="prod">
          									<tr id="${prod.productId }">
          										<td><input type='hidden' value="${prod.productId }"/>${prod.productProviderName }</td>
 												<td>${prod.extProdId }</td>
   												<td>${prod.productName }</td>
   												<td>${prod.minCount }</td>
   												<td>${prod.maxCount }</td>
          									</tr>
          								</c:forEach>
          					 </table>
          			   </td>
	    			</tr>
	    			</c:if>
	    			<c:if test="${fn:length(prodOfferRelList1)>=1 }">
	    		 <tr>
	                <td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardOffer.selOffer')}"/></td>
	                <td  colspan="6" class="item-content">
	                	 <table class="table table-bordered" id="tab2">
       						<tbody>
       							<tr>
       								<th width="25%"><s:property value="%{getText('eaap.op2.conf.pardSpec.code')}" /></th>
       								<th width="25%"><s:property value="%{getText('eaap.op2.conf.pardSpec.name')}" /></th>
       								<th width="25%"><s:property value="%{getText('eaap.op2.conf.pardSpec.minimum')}" /></th>
       								<th width="25%"><s:property value="%{getText('eaap.op2.conf.pardSpec.maximum')}" /></th>
       							</tr>
       								<c:forEach items="${prodOfferRelList1 }" var="offer">
       									<trid="${offer.offerZId }">
       										<td><input type='hidden' value="${offer.offerZId }"/>${offer.extProdOfferId }</td>
										<td>${offer.prodOfferName }</td>
												<td>${offer.minCount }</td>
												<td>${offer.maxCount }</td>
       									</tr>
       								</c:forEach>
       						</tbody>
       					 </table>
	                </td>
	             </tr>
	             </c:if>
	             <c:if test="${fn:length(prodOfferRelList2)>=1 }">
	             <tr>
	                <td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardOffer.selOfferForE')}"/></td>
	                <td  colspan="6" class="item-content">
	                	 <table class="table table-bordered" id="tab3">
       						<tbody>
       							<tr>
       								<th width="50%"><s:property value="%{getText('eaap.op2.conf.pardSpec.code')}" /></th>
       								<th width="50%"><s:property value="%{getText('eaap.op2.conf.pardSpec.name')}" /></th>
       							</tr>
       								<c:forEach items="${prodOfferRelList2 }" var="offer">
       									<tr id="${offer.offerZId }">
       										<td><input type='hidden' value="${offer.offerZId }"/>${offer.extProdOfferId }</td>
										<td>${offer.prodOfferName }</td>
       									</tr>
       								</c:forEach>
       						</tbody>
       					 </table>
	                </td>
	             </tr>
	             </c:if>
	             <c:if test="${fn:length(pricingPlanList)>=1}">
	             <tr>
    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardmix.odrPrice')}"/>
    				</td>
    				<td colspan="5">       					 
    				       <table class="table table-bordered text-left" id="tab4">
       						<thead>
       							<tr>
       								<th>Price Name</th>
       								<th>Offset Type</th>
       								<th>Effective Date</th>
       								<th>Price Object-Product</th>
       								<th>Priority</th>
       								<th>Charge Information</th>
       							</tr>
       						</thead>
       						<tbody>
   								<c:forEach items="${pricePlanList}" var="pricePlan" varStatus="vs">
   									<tr>
   									 	<td>${pricePlan.priceName }</td>
   									 	<td>${pricePlan.offsetType }</td>
   									 	<td>${pricePlan.effectiveDate }</td>
   									 	<td>${pricePlan.priceObjectProduct }</td>
   									 	<td>${pricePlan.priority }</td>
     									 <td style="line-height:23px;">
		       								<c:forEach items="${pricePlan.chargeInformation}" var="chargeInformation" varStatus="vs">
		       									 <c:if test="${chargeInformation.type==0}"> 
		       									 	<a href="#" onclick="showWind('PLAN_PRICE',${chargeInformation.id},${chargeInformation.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal;">Basic Tariff</a>
		       									 </c:if>
		       									 <c:if test="${chargeInformation.type==3}">
		       									 	<a href="#" onclick="showWind('PLAN_PRICE',${chargeInformation.id},${chargeInformation.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal;">Free Resource</a>
		       									 </c:if>
		       									 <c:if test="${chargeInformation.type==7}">
		       									 	<a href="#" onclick="showWind('PLAN_PRICE',${chargeInformation.id},${chargeInformation.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal;">Recurring Charge</a>
		       									 </c:if>
		       									 <c:if test="${chargeInformation.type==5}">
		       									 	<a href="#" onclick="showWind('PLAN_PRICE',${chargeInformation.id},${chargeInformation.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal; ">Rating Discount</a>
		       									 </c:if>
		       									 <c:if test="${chargeInformation.type==9}">
		       									 	<a href="#" onclick="showWind('PLAN_PRICE',${chargeInformation.id},${chargeInformation.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal; ">One-Time Charge</a>
		       									 </c:if>
		       									 <c:if test="${chargeInformation.type==8}">
		       									 	<a href="#" onclick="showWind('PLAN_PRICE',${chargeInformation.id},${chargeInformation.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal; ">Billing Discount</a>
		       									 </c:if>
		       								</c:forEach>
										</td>
   									</tr>
   								</c:forEach>
       						</tbody>
       					 </table>
    				</td>
    			</tr>
    			</c:if>
    			<c:if test="${fn:length(settlementList)>=1}">
    			<tr>
	            	<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.pardOffer.account')}"/></td>
	            	<td class="item-content" colspan="5">         					 
               			 <table class="table table-bordered" id="tab5">
         						<thead>
         							<tr>
         								<th>Operator</th>
						                <th> Name </th>
						                <th> First Settlement Date </th>
						                <th> Cycle Type </th>
						                <th> Product Category </th>
						                <th> Effective Date </th>
						                <th> Description </th> 
						                <th> Rule </th>
         							</tr>
         						</thead>
         						<tbody>
       								<c:forEach items="${settlementList }" var="s" varStatus="vs">
       									<tr>
       									 	<td>${s.operator }</td>
       									 	<td>${s.name }</td>
       									 	<td>${s.firstSettlementDate }</td>
       									 	<td>${s.cycleType }</td>
       									 	<td>${s.productCategory }</td>
       									 	<td>${s.effectiveDate }</td>
       									 	<td>${s.description }</td>
       									 	<td style="line-height:23px;">
			       								<c:forEach items="${s.rules}" var="rule" varStatus="vss">
			       									 <c:if test="${rule.type==1}">
			       									 	<a href="#" onclick="showWind('SETTLE_RULE',${rule.id},${rule.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal;">Recurring Rule</a>
			       									 </c:if>
			       									 <c:if test="${rule.type==2}">
			       									 	<a href="#" onclick="showWind('SETTLE_RULE',${rule.id},${rule.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal;">One Time Charge</a>
			       									 </c:if>
			       									 <c:if test="${rule.type==4}">
			       									 	<a href="#" onclick="showWind('SETTLE_RULE',${rule.id},${rule.type})" style="padding:2px 5px; background-color:#038CD6; color:#fff; white-space:nowrap; word-wrap:normal; word-break:normal; ">Aggregation Rule</a>
			       									 </c:if>
			       								</c:forEach>
											</td>
       									</tr>
       								</c:forEach>
         						</tbody>
         					 </table>         					 
               		</td>
	            </tr>
	            </c:if>
	    		</table>
	    	</div>
	    	
	    	<div class="accordion-header" >
		    	<div class="accordion-header-text">
		    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.check')}"/>
		    	</div>
		    </div>
		    <div>
	           <form name="checkPardMix">
	            <input type="hidden" name ="content_Id" id ="content_Id" value="${content_Id}" />
	            <input type="hidden" name ="activity_Id"  id ="activity_Id" value="${activity_Id}" />
	            <input type="hidden" name ="orgId"   id="orgId"  value="${prodOffer.offerProviderId}" />
	            
	    		<table class="table table-bordered">
	    			<tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>
	    				</td>	
	    				<td colspan="5">
	    				<select name="checkState" id="checkState">
	    				<option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
	    				<option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option>
	    				</select>
	    				</td>	
	    			</tr>
	    			<tr>
	    				<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>
	    				</td>
	    				<td colspan="5">
	    					<textarea name="checkDesc" id="checkDesc" class="form-control"></textarea> 
	    				</td>
	    			</tr>
	               <c:if test="${not empty pushc_url}">
	    		    <tr>
						<td class="text-right" width="150"><s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageType')}"/>:
						</td>	
						<td    colspan="5">
							<input type="checkbox" name="pushMessageType" id="pushMessageType" value="1" />&nbsp;<s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageTypeByEmail')}"/>
							<input type="checkbox" name="pushMessageType" id="pushMessageType" value="2" />&nbsp;<s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageTypeBySms')}"/>
						</td>	
    			  </tr>
 		       </c:if>
	    			<tr>
	    				<td  colspan="6"   align="center">
	    				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="pardOfferAuditing()"  id="submitId"></ui:button>
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
	</div>
	</div>
	<ui:warn/> 
</body>
</html>
<script type="text/javascript">
function pardOfferAuditing(){
	var checkState = $("select[name=checkState]").val();
	 var pushMessageType="";
	 $("input[name='pushMessageType']:checkbox").each(function(){ 
         if($(this).attr("checked")){
        	 pushMessageType += $(this).val()+",";
         }
     })
	if(checkState != "1"){
		var checkDesc = $("#checkDesc").val();
		if(!checkDesc){
			art.dialog.alert("operation","If you reject,the comment is not empty!");
			return;
		}
	}
	 if(checkDesc){
		 if(checkDesc.length > 512){
			art.dialog.alert("operation","Comment the length cannot exceed 512 characters!");
			return;
		}
	 }

	 var content_Id 	= $("#content_Id").val();
	 var activity_Id	= $("#activity_Id").val();
	 var checkState 	= $("#checkState").val();
	 var checkDesc 	= $("#checkDesc").val();
	 var orgId 	= $("#orgId").val();
	 $.ajax({
			async : false,
			type : "POST",
			url :  "${contextPath}/prodAndOffer/checkPardOffer.shtml",
			dataType : "json",
			data : {content_Id:content_Id,
				activity_Id:activity_Id,
				checkState:checkState,
				checkDesc:checkDesc,
				orgId:orgId,
				pushMessageType:pushMessageType},
			success : function(data) {
				try {
		      		var retCode	= data.retCode;
		      		var retMsg	= data.retMsg;
		      		if(retCode=="0000"){		//Success
				      	try {
				      		var vOpener=art.dialog.opener;
			    			vOpener.reloadList();
							if(checkState=="1"){
								//Approval Result=Approve 审核"通过"，跳到提价：
				    			if("${o2pWebDomin}"=="cloud"){
				    				art.dialog.alert("operation"," Approval results submitted successfully. \r Next, please increase price and synchronous.");
					    			window.location.href="${frontEndUrl}/conf/offerAuditing/offerDetail_auditing.jsp?offerId=${prodOffer.prodOfferId}";
				    			}else{
				    				art.dialog.alert("operation",retMsg);
									art.dialog.close(); 
				    			}
							}else{
								//Approval Result=Reject 不通过：
								art.dialog.close(); 
							}
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
