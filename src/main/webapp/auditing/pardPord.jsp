<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>



</head>
<body>

<script language="javascript">	
	<s:iterator value="actionScripts">
		<s:property escape="false"/>
	</s:iterator>
</script>
<!--body start -->
	
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/edit.png" />
     
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.waitingtask')}"/>
      <img src="../resource/blue/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.pardpord.pardpordCheck')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.pardpord.pardpordCheckApplication')}"/>
    	</div>
    </div>
    
    <div>
    		<table class="mgr-table" cellpadding="0" cellspacing="0">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.prodOfferId')}"/>:
    				</td>	
    				<td class="item-content">${prodOffer.prodOfferId}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.prodOfferName')}"/>:
    				</td>	
    				<td class="item-content">${prodOffer.prodOfferName}
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.portal.pardProd.prodDetail.prodCode')}"/>:
    				</td>	
    				<td class="item-content">${prodOffer.extProdOfferId}
    				</td>		
    			</tr>
    		
    			<tr>  
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.effDate')}"/>:
    				</td>
    				<td class="item-content"><fmt:formatDate value="${prodOffer.effDate}" type="date" dateStyle="default"/> 
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.expDate')}"/>:
    				</td>
    				<td class="item-content"><fmt:formatDate value="${prodOffer.expDate}" type="date" dateStyle="default"/>
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.portal.pardProd.prodDetail.prodSvc')}"/>:
    				</td>	
    				<td class="item-content">
    				       <c:forEach var="prodDealSvc" items="${prodDealSvcList}" step="1">
				            ${prodDealSvc.SERVICE_CN_NAME }
				           </c:forEach>
				    </td>
    			</tr>	
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.portal.pardProd.prodDetail.prodDesc')}"/>
    				</td>
    				<td colspan="6" class="item-content">
						${prodOffer.prodOfferDesc}				
    				</td>
    			</tr>
    			<c:if test="${!empty channelTypeMap}">
    		
			    <tr>
				     <td class="item"><s:property value="%{getText('eaap.op2.portal.pardProd.prodDetail.saleArea')}"/></td>
				     <td colspan="6" class="item-content">
				     <c:forEach var="prodChannelType" items="${channelTypeMap}" step="1">
				         ${prodChannelType.value} 
				     </c:forEach>
			         </td>
                </tr>
    			</c:if>
    		    <tr>
				  <td  class="item" ><s:property value="%{getText('eaap.op2.portal.pardpord.productIdentificationInformation')}"/></td>
				   <td colspan="6">
				       
			       </td>
				      </tr>
                       <c:forEach var="attrAllHashMapsBean" items="${attrAllHashMaps}" step="1">
                        <tr>
                         <td ></td>
                         <td colspan="6">
                           <table style="width:100%">
                              <tbody>
                                 <tr>
				                	<td width="25%" style="TEXT-ALIGN:left;"><s:property value="%{getText('eaap.op2.portal.pardpord.applicationsName')}" /></td>
				                	<td style="TEXT-ALIGN:left;">${attrAllHashMapsBean.applicationsName}</td>
				                </tr>
				                <tr>
				                	<td width="25%" style="TEXT-ALIGN:left;"><s:property value="%{getText('eaap.op2.portal.pardpord.applicationsAim')}" /></td>  
				                	<td style="TEXT-ALIGN:left;">${attrAllHashMapsBean.applicationsNameAimList}</td>				                			    
				                	</tr>
				                	<tr>	
				                	<td width="25%" style="TEXT-ALIGN:left;"><s:property value="%{getText('eaap.op2.portal.pardpord.trafficldenRule')}" /></td>		                			     
				                	<td style="TEXT-ALIGN:left;">${attrAllHashMapsBean.trafficldenRuleList}</td>				                			    
				                </tr>
				             </tbody>
				            </table>
				         </td>
				        </tr>
				         <br />
				        </c:forEach>
                                   
    		    
    		    
    		    
			       <c:if test="${!empty attr}">
 				   <tr>
				    <td class="item"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.define')}"/></td>
			        <td colspan="6">
			           <table  style="width:100%">
			          		<tbody>
			          			<tr>
			          			<td class="item-center" colspan="2"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.defineName')}" />
			          			</td>
			          			<td class="item-center" colspan="2"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.defineValue')}" /></td>
			          			</tr>
       							
			       				<c:forEach var="attrBean" items="${attr}" step="1"> 
								<tr>
								<td class="item-content" align="center" colspan="2">${attrBean.attrSpecName}</td>
								<td class="item-content" align="center" colspan="2">${attrBean.defaultValue}</td>
								</tr> 
							   </c:forEach>
                               			
			          		</tbody>
			          </table>
			         </td>
			        </tr>
			       </c:if> 
    	<c:if test="${!empty pricingPlanList}">
				 <tr>
				 <td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.price')}"/></td>
			        <td colspan="6">
			           <table style="width:100%">
			          	<tbody>
			          	<tr>
			          		<td class="item-center" colspan="2"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.feeType')}" /></td>
			          		<td class="item-center" colspan="2"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.feeContent')}" /></td>
			          		<td class="item-center" colspan="2"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.beyondFee')}" /></td>
			          	</tr>

			          		<c:forEach var="pricingPlanListBean" items="${pricingPlanList}" step="1"> 
				            <tr>
		                    <td class="item-content" align="center" colspan="2">${pricingPlanListBean.NAME}</td>
							<td class="item-content" align="center" colspan="2">${pricingPlanListBean.PRICING_DESC}</td>
							<td class="item-content" align="center" colspan="2">${pricingPlanListBean.BEYOND_DESC}</td>
							</tr> 
							</c:forEach>
					
                            </tbody>
			          </table>
			        </td>
			     </tr> 
	   </c:if>	     			 			
    		<c:if test="${!empty commissionPlanList}">
				 <tr>
				 <td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.commission')}"/></td>
			        <td colspan="6">
			           <table style="width:100%" cellpadding="0" cellspacing="0" >
			          	<tbody>
			          	<tr>
			          		<td class="item-center" colspan="3"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.feeType')}" /></td>
			          		<td class="item-center" colspan="3"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.feeContent')}" /></td>
			          	</tr>
			          		<c:forEach var="commissionPlanListBean" items="${commissionPlanList}" step="1"> 
				            <tr>
		                    <td class="item-content" align="center" colspan="3">${commissionPlanListBean.NAME}</td>
							<td class="item-content" align="center" colspan="3">${commissionPlanListBean.PRICING_DESC}</td>
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
           <form action="${contextPath}/pardPord/checkProdOffer.shtml" name="checkProdOffer" method="post">
            <input type="hidden" name ="content_Id" value="${content_Id}" />
            <input type="hidden" name ="activity_Id" value="${activity_Id}" />
            
    		<table class="mgr-table">
    			<tr>
    				<td class="item" style="width:30%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>:
    				</td>	
    				<td class="item-content" style="width:70%">
    				<ui:select  skin="${contextStyleTheme}"  name="checkState" id="checkState" 
    			      list="checkStateList" listKey="key" listValue="value" style="width:70px;" ></ui:select>
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
					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" onclick="doSubmit();" ></ui:button>
    				</td>	
    			</tr>
    		</table>
    	</form>	
    </div>

  
</div>


<!--body end --> 

</body>
<script type="text/javascript" >
function doSubmit(){
     document.checkProdOffer.submit();
}
</script>
</html>
