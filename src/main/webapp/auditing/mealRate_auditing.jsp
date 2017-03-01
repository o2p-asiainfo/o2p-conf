<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>

<style>

.inline {
	BACKGROUND-COLOR: #fff; BORDER-SPACING: 0px; BORDER-COLLAPSE: collapse
}
.inline TH {
	BORDER-BOTTOM: #e0e0e0 1px solid; BORDER-LEFT: #e0e0e0 1px solid; BACKGROUND: #dee7ec; HEIGHT: 25px; BORDER-TOP: #e0e0e0 1px solid; FONT-WEIGHT: 400; BORDER-RIGHT: #e0e0e0 1px solid
}
.inline TD {
	BORDER-BOTTOM: #e0e0e0 1px solid; BORDER-LEFT: #e0e0e0 1px solid; PADDING-BOTTOM: 0px; PADDING-LEFT: 5px; PADDING-RIGHT: 5px; HEIGHT: 25px; BORDER-TOP: #e0e0e0 1px solid; BORDER-RIGHT: #e0e0e0 1px solid; PADDING-TOP: 0px
}

</style>
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/edit.png" />
     
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.waitingtask')}"/>
      <img src="../resource/blue/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.mealrate.mealrateCheck')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.mealrate.mealrateCheckApplication')}"/>
    	</div>
    </div>
    
    <div>
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.prodOfferId')}"/>:
    				</td>	
    				<td class="item-content">${prodOffer.prodOfferId}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.prodOfferName')}"/>:
    				</td>	
    				<td class="item-content">${prodOffer.prodOfferName}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.prodOfferStatus')}"/>:</td>
    				<td class="item-content">
    					<c:choose>
    						<c:when test="${prodOffer.statusCd == 1000}">
    							<s:property value="%{getText('eaap.op2.conf.mealrate.effective')}"/>
    						</c:when>
    						<c:when test="${prodOffer.statusCd == 1200}">
    							<s:property value="%{getText('eaap.op2.conf.mealrate.notEffective')}"/>
    						</c:when>
    						<c:when test="${prodOffer.statusCd == 1299}">
    							<s:property value="%{getText('eaap.op2.conf.mealrate.pending')}"/>
    						</c:when>
    						<c:when test="${prodOffer.statusCd == 1298}">
    							<s:property value="%{getText('eaap.op2.conf.mealrate.notPassed')}"/>
    						</c:when>
    						<c:when test="${prodOffer.statusCd == 1300}">
    							<s:property value="%{getText('eaap.op2.conf.mealrate.archived')}"/>
    						</c:when>
    						<c:otherwise>
    							<s:property value="%{getText('eaap.op2.conf.mealrate.offTheAssemblyLine')}"/>
    						</c:otherwise>
    					</c:choose>
    				</td>
    			</tr>
    		
    			<tr>  
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.effDate')}"/>:
    				</td>
    				<td class="item-content"><fmt:formatDate value="${prodOffer.effDate}" type="date" dateStyle="default"/> 
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.expDate')}"/>:
    				</td>
    				<td class="item-content" colspan="4"><fmt:formatDate value="${prodOffer.expDate}" type="date" dateStyle="default"/>
    				</td>	
    			 </tr>	
    			              <tr>
			                		<td align="right"  class="item"  width="200"><s:property value="%{getText('eaap.op2.conf.mealrate.price')}"/>:</td>
			                		<td width="450px" colspan="5">
			                			 <table class="inline" style="width:450px" id="tab1">
			          						<tbody>
			          							<tr>
			          								<th width="20%" style="TEXT-ALIGN:left;"><s:property value="%{getText('eaap.op2.conf.mealrate.feeType')}" /></th>
			          								<th width="20%" style="TEXT-ALIGN:left;"><s:property value="%{getText('eaap.op2.conf.mealrate.feeContent')}" /></th>
			          								<th width="20%" style="TEXT-ALIGN:left;"><s:property value="%{getText('eaap.op2.conf.mealrate.beyondFee')}" /></th>
			          							</tr>
			          							 <c:if test="${fn:length(pricingList)>=1}">
			       							      <c:forEach var="pricingBean" items="${pricingList}" step="1"> 
									                 <tr>
										                 <td style="TEXT-ALIGN:left;" >${pricingBean.NAME}</td>
										                 <td style="TEXT-ALIGN:left;" >${pricingBean.PRICING_DESC}</td>
										                 <td style="TEXT-ALIGN:left;" >${pricingBean.BEYOND_DESC}</td>
										             </tr> 
							                     </c:forEach>
       							  
       							                 </c:if>
			          							
			          						</tbody>
			          					 </table>
			                		</td>
			                	</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.prodOfferDesc')}"/>:
    				</td>	
    				<td class="item-content" colspan="5"><textarea rows="6" cols="70" disabled="disabled">${prodOffer.prodOfferDesc}</textarea>     
    				</td>
    			</tr>
    			<c:if test="${!empty voiceList}">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.voiceCalls')}"/>:
    				</td>
    				<td colspan="6" class="item-content">
							<c:forEach var="voice" items="${voiceList}" step="1">
								${voice.ATTR_SPEC_NAME} : ${voice.DEFAULT_VALUE} ${voice.CEP_NAME}
								<br />
							</c:forEach>
						
    				</td>
    			</tr>
    			</c:if>	
    			<c:if test="${!empty dataList}">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.dataServices')}"/>:
    				</td>
    				<td colspan="6" class="item-content">
							<c:forEach var="data" items="${dataList}" step="1">
								${data.ATTR_SPEC_NAME} : ${data.DEFAULT_VALUE} ${data.CEP_NAME}
								<br />
							</c:forEach>
    				</td>
    			</tr>
    			</c:if>
    			<c:if test="${!empty msgList}">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.msgServices')}"/>:
    				</td>
    				<td colspan="6" class="item-content">
						
							<c:forEach var="msg" items="${msgList}" step="1">
								${msg.ATTR_SPEC_NAME} : ${msg.DEFAULT_VALUE} ${msg.CEP_NAME}
								<br />
							</c:forEach>
							
    				</td>
    			</tr>
    			</c:if>
    			<c:if test="${!empty productList}">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.mealrate.products')}"/>:
    				</td>
    				<td colspan="6" class="item-content">
							<c:forEach var="product" items="${productList}" step="1">
								${product.PRODUCT_NAME}
								<br />
							</c:forEach>
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
           <form action="${contextPath}/mealRate/checkProdOffer.shtml" name="checkProdOffer" method="post">
            <input type="hidden" name ="content_Id" value="${content_Id}" />
            <input type="hidden" name ="activity_Id" value="${activity_Id}" />
            
    		<table class="mgr-table">
    			<tr>
    				<td class="item" style="width:30%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>:
    				</td>	
    				<td class="item-content" style="width:70%">
    				<select name="checkState">
    				<option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
    				<option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option>
    				</select>
    				</td>	
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>:
    				</td>
    				<td class="item-content">
    					<textarea name="checkDesc" style="WIDTH: 70%; HEIGHT: 66px" ></textarea> 
    				</td>
    			</tr>
    			<tr>
    				<td  colspan="2" class="item-content" align="center">
    					<a class="button-base button-middle" title="<s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/>" href="javascript:checkProdOffer.submit();">
						  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"/></span>
						  </a>
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

    	..................
    		
    </div>
</div>


<!--body end --> 

</body>
</html>
