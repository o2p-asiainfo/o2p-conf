<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
 
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />  
<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
 
</head>
<body>
<script>
 
 function testwarn()
 {
  alertMsg('title','warnmsg','warning');
 
 confirmMsg('title','warnmsg',function a(t){
        alert(t);
 
 })
 }

</script>
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
      <img src="../resource/blue/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.orgregauditing.prodofferonlinecheck')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.prodofferinfo')}"/>
    	</div>
    </div>
    
    <div>
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.pardmixname')}"/>
    				</td>	
    				<td class="item-content">${prodOffer.prodOfferName}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.pardmixcode')}"/>
    				</td>	
    				<td class="item-content">${prodOffer.extProdOfferId}
    				</td>	
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.regtime')}"/>:
    				</td>	
    				<td class="item-content">${prodOffer.createDt}
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.onlinetime')}"/>:
    				</td>	
    				<td class="item-content">
    				<ui:date id="btime" name="prodOffer.formatEffDate"   disabled="true" value="${prodOffer.formatEffDate}" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
               			 ~ 
               	    <ui:date id="etime" name="prodOffer.formatExpDate"   disabled="true" value="${prodOffer.formatExpDate}" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
               	
    				</td>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.salearea')}"/>
    				</td>
    				<td class="item-content">
    				 <c:forEach var="prodChannel" items="${prodChannelMap}" step="1"> 
						           <% int i=0; %>
						           <c:forEach var="prodOfferChannelType" items="${prodOfferChannelTypeList}" step="1"> 
						                     <c:if test="${prodOfferChannelType.channelType==prodChannel.key}">
						                     <% i++ ; %>
						                     </c:if>
						           </c:forEach>
						           <% if(i>0){ %>
						         <input type="checkbox" name="channelType" checked  disabled value="${prodChannel.key}"/>${prodChannel.value} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				                 <% }else{ %>
				                 <input type="checkbox" name="channelType" disabled value="${prodChannel.key}"/>${prodChannel.value} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				                 <% } %>
				    </c:forEach>
    				</td>
    				<td class="item">&nbsp;
    				</td>
    				<td class="item-content">&nbsp;
    				</td>
    			</tr>
    			 
    			 <tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.pardmixdesc')}"/>
    				</td>
    				<td colspan="6" class="item-content">
    				                <c:choose>  
					                    <c:when test="${prodOffer.prodOfferDesc==''||prodOffer.prodOfferDesc==null}">  
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
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.pardmixgood')}"/>
    				</td>
    				<td colspan="6" class="item-content">
    				                  <c:choose>  
					                    <c:when test="${prodOffer.prodOfferTrait==''||prodOffer.prodOfferTrait==null}">  
									       <s:property value="%{getText('eaap.op2.conf.orgregauditing.intro')}"/>......
									    </c:when>
									    <c:when test="${fn:length(prodOffer.prodOfferTrait)>50}">  
									        ${fn:substring(prodOffer.prodOfferTrait, 0, 50)}......
									    </c:when>  
									   <c:otherwise>  
									     ${prodOffer.prodOfferTrait}
									    </c:otherwise>  
									</c:choose>  
    				 
    				</td>
    			</tr>
    			
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.proffer')}"/>
    				</td>	
    				<td colspan="6" class="item-content">
	    			  <c:if test="${fn:length(chooseProdOardList)>=1}">
		               <br/>
		               <c:forEach var="chooseProdPrad" items="${chooseProdOardList}" step="1"> 
		                <input  type="hidden"  id="mychooseProdPardId" name="chooseProdPardId" value="${chooseProdPrad.productId}"/>
		                <table border='1' width="100%">
		                <tr><td>
		                 <s:property value="%{getText('eaap.op2.conf.pardmix.prodname')}"/>${chooseProdPrad.productName }
		                 <br/>
		                 <s:property value="%{getText('eaap.op2.conf.pardmix.proddesc')}"/>${chooseProdPrad.productDesc }
		                 </td></tr>
		                 </table>
		                </c:forEach>
		               </c:if>
    				</td>
    			</tr>
    			
    		<tr>
                <td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.proyys')}"/></td>
                <td  colspan="6" class="item-content">
                <c:if test="${fn:length(productAttrList)>=1}">
	               <br/>
	               <c:forEach var="myProduct" items="${productAttrList}" step="1"> 
	                 <table border='1' width="100%">
	                <tr><td>
	                 <s:property value="%{getText('eaap.op2.conf.pardmix.prodname')}"/>${myProduct.prodyys.productName }
	                 <br/>
	                 <s:property value="%{getText('eaap.op2.conf.pardmix.proddesc')}"/>${myProduct.prodyys.productDesc }
	                 
	                 <c:if test="${myProduct.prodattr!=null}">
	                 <table border='1' width="98%">
						           <thead>
							          <tr bgcolor="#F2F2F2">
									  	<th class="middle" ><s:property value="%{getText('eaap.op2.conf.pardmix.attrname')}"/></th>
									  	<th class="middle" ><s:property value="%{getText('eaap.op2.conf.pardmix.attrdesc')}"/></th>
									    <th class="middle" ><s:property value="%{getText('eaap.op2.conf.pardmix.attrvalue')}"/></th>
							         </tr>
						          </thead>
						          <tbody>
						           <c:if test="${fn:length(myProduct.prodattr)>=1}">
						               <c:forEach var="myproductAttr" items="${myProduct.prodattr}" step="1">
						                 <tr>
							                 <td>${myproductAttr.ATTR_SPEC_NAME}</td>
							                 <td>${myproductAttr.ATTR_SPEC_DESC}</td>
							                 <td>
							                 
							                 
							                 <c:choose>
							                   <c:when test="${myproductAttr.DISPLAY_TYPE=='11'}">
							                     <c:if test="${fn:length(myProduct.myAttrValueList)>=1}">
			       							      <c:forEach var="myAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
									                 <c:if test="${myAttrValue.ATTR_VALUE_ID==myproductAttr.DEFAULT_VALUE}">
									                  <select disabled>
									                  <option>${myAttrValue.ATTR_VALUE_NAME}</option>
									                  </select>
									                  
									                 </c:if>
							                     </c:forEach>
							                     </c:if>
							                   </c:when>
							                  
							                  
							                   <c:when test="${myproductAttr.DISPLAY_TYPE=='12'}">
							                     <c:forEach var="prodeAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
							                        <% int j=0; %>
							                           <c:if test="${prodeAttrValue.PRODUCT_ATTR_ID==myproductAttr.PRODUCT_ATTR_ID}">
							                              
							                              <c:forEach var="CheckBoxValue" items="${myProduct.checkBoxValueList}" step="1">
							                                <c:if test="${CheckBoxValue.DEFAULT_VALUE==prodeAttrValue.ATTR_VALUE_ID}">
								                              <% j++; %>
								                              </c:if>
							                              </c:forEach>
												            <% if(j>0){ %>
												            <input type="checkbox" name="mycheckvalue" checked  disabled/>${prodeAttrValue.ATTR_VALUE_NAME}<br/>
												            <% }else{ %>
												            <input type="checkbox" name="mycheckvalue"   disabled/>${prodeAttrValue.ATTR_VALUE_NAME}<br/>
												            <% } %>
						                                  
						                                </c:if>
					                                 </c:forEach>
					                         </c:when>
							                  
							                  
							                  <c:when test="${myproductAttr.DISPLAY_TYPE=='14'}">                          
							                  <table>
							                     <tr>
							                      <td>
							                          <a  target="_blank" onclick="openWindows('${contextPath}/common/moreMap_show.jsp?defaultId=${myproductAttr.DEFAULT_VALUE}','<s:property value="%{getText('eaap.op2.portal.doc.select')}" />',820,640);"  title="<s:property value="%{getText('eaap.op2.conf.pardmix.showmap')}"/>">
													   <span class="button-text">${myproductAttr.DEFAULT_VALUE}</span>
												      </a>
												      <input type="hidden" value="${myproductAttr.DEFAULT_VALUE}"  name="myPapId" id="myPapId"/>
								                  </td>
							                     </tr>
							                  </table>
								             </c:when>
								               <c:when test="${myproductAttr.DISPLAY_TYPE=='16'}">
								                <select disabled>
							                        <c:if test="${fn:length(provServiceList)<1}">
							                        <option value=""></option>
							                        </c:if>
											        <c:forEach var="provService" items="${provServiceList}" step="1"> 
					                                  <option <c:if test="${provService.SERVICE_ID==myproductAttr.DEFAULT_VALUE}">selected</c:if> value="${provService.SERVICE_ID}">${provService.SERVICE_CN_NAME}</option>
											        </c:forEach>
											       </select>
											     </c:when>  
											     <c:when test="${myproductAttr.DISPLAY_TYPE=='17'}">
							                     <c:if test="${fn:length(myProduct.myAttrValueList)>=1}">
			       							      <c:forEach var="myAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
									                 <c:if test="${myAttrValue.ATTR_VALUE_ID== fn:split(myproductAttr.DEFAULT_VALUE,',')[0]}">
									                  <select disabled>
									                  <option>${myAttrValue.ATTR_VALUE_NAME}</option>
									                  </select>
									                 </c:if>
							                     </c:forEach>
							                     --
							                     <c:forEach var="myAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
									                 <c:if test="${myAttrValue.ATTR_VALUE_ID==fn:split(myproductAttr.DEFAULT_VALUE,',')[1]}">
									                  <select disabled>
									                  <option>${myAttrValue.ATTR_VALUE_NAME}</option>
									                  </select>
									                  
									                 </c:if>
							                     </c:forEach>
							                    </c:if>
							                   </c:when>
							                   
							                   
							                  <c:otherwise>
							                  ${myproductAttr.DEFAULT_VALUE}
							                  </c:otherwise>
							                 </c:choose>
							                </td>
						                 </tr> 
				                     </c:forEach>
				                     </c:if>
						          </tbody>
						          
						           <c:forEach var="groupInfo" items="${myProduct.groupList}" step="1">
						                  <tbody id="group${groupInfo.GROUP_ID}">
						                       <tr bgcolor="#F9F9F9">
						                         <td colspan="3" > 
								                 ${groupInfo.GROUP_NAME} 
								                 </td>
								               </tr>
						                  <c:forEach var="myproductAttr" items="${myProduct.attrInGroupList}" step="1">
						                     <c:if test="${myproductAttr.GROUP_ID==groupInfo.GROUP_ID}">
						                         <tr>
									                 <td>${myproductAttr.ATTR_SPEC_NAME}</td>
									                 <td>${myproductAttr.ATTR_SPEC_DESC}</td>
									                 <td>
									                  <c:choose>
									                   <c:when test="${myproductAttr.DISPLAY_TYPE=='11'}">
									                     <c:if test="${fn:length(myProduct.myAttrValueList)>=1}">
					       							      <c:forEach var="myAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
											                 <c:if test="${myAttrValue.ATTR_VALUE_ID==myproductAttr.DEFAULT_VALUE&&myAttrValue.PRODUCT_ATTR_ID==myproductAttr.PRODUCT_ATTR_ID}">
											                  <select disabled>
											                  <option>${myAttrValue.ATTR_VALUE_NAME}</option>
											                  </select>
											                  
											                 </c:if>
									                     </c:forEach>
									                     </c:if>
									                   </c:when>
									                  
									                  
									                   <c:when test="${myproductAttr.DISPLAY_TYPE=='12'}">
									                     <c:forEach var="prodeAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
									                        <% int k=0; %>
									                           <c:if test="${prodeAttrValue.PRODUCT_ATTR_ID==myproductAttr.PRODUCT_ATTR_ID}">
									                              
									                              <c:forEach var="CheckBoxValue" items="${myProduct.checkBoxValueList}" step="1">
									                                <c:if test="${CheckBoxValue.PRODUCT_ATTR_ID==myproductAttr.PRODUCT_ATTR_ID&&CheckBoxValue.DEFAULT_VALUE==prodeAttrValue.ATTR_VALUE_ID}">
										                              <% k++; %>
										                              </c:if>
									                              </c:forEach>
														            <% if(k>0){ %>
														            <input type="checkbox" name="mycheckvalue" checked  disabled/>${prodeAttrValue.ATTR_VALUE_NAME}<br/>
														            <% }else{ %>
														            <input type="checkbox" name="mycheckvalue"   disabled/>${prodeAttrValue.ATTR_VALUE_NAME}<br/>
														            <% } %>
								                                  
								                                </c:if>
							                                 </c:forEach>
							                         </c:when>
									                  
									                  
									                  <c:when test="${myproductAttr.DISPLAY_TYPE=='14'}">
									                  <table>
									                     <tr>
									                      <td> 
									                          <a  target="_blank"  onclick="openWindows('${contextPath}/common/moreMap_show.jsp?defaultId=${myproductAttr.DEFAULT_VALUE}','<s:property value="%{getText('eaap.op2.portal.doc.select')}" />',820,640);"  title="<s:property value="%{getText('eaap.op2.conf.pardmix.showmap')}"/>">
															   <span class="button-text">${myproductAttr.DEFAULT_VALUE}</span>
														      </a>
														      <input type="hidden" value="${myproductAttr.DEFAULT_VALUE}"  name="myPapId" id="myPapId"/>
										                  </td>
									                     </tr>
									                  </table>
										             </c:when>
										               <c:when test="${myproductAttr.DISPLAY_TYPE=='16'}">
										                <select disabled>
									                        <c:if test="${fn:length(provServiceList)<1}">
									                        <option value=""></option>
									                        </c:if>
													        <c:forEach var="provService" items="${provServiceList}" step="1"> 
							                                  <option <c:if test="${provService.SERVICE_ID==myproductAttr.DEFAULT_VALUE}">selected</c:if> value="${provService.SERVICE_ID}">${provService.SERVICE_CN_NAME}</option>
													        </c:forEach>
													       </select>
													     </c:when>  
													     <c:when test="${myproductAttr.DISPLAY_TYPE=='17'}">
									                     <c:if test="${fn:length(myProduct.myAttrValueList)>=1}">
					       							      <c:forEach var="myAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
											                 <c:if test="${myAttrValue.PRODUCT_ATTR_ID==myproductAttr.PRODUCT_ATTR_ID&&myAttrValue.ATTR_VALUE_ID== fn:split(myproductAttr.DEFAULT_VALUE,',')[0]}">
											                  <select disabled>
											                  <option>${myAttrValue.ATTR_VALUE_NAME}</option>
											                  </select>
											                 </c:if>
									                     </c:forEach>
									                     --
									                     <c:forEach var="myAttrValue" items="${myProduct.myAttrValueList}" step="1"> 
											                 <c:if test="${myAttrValue.PRODUCT_ATTR_ID==myproductAttr.PRODUCT_ATTR_ID&&myAttrValue.ATTR_VALUE_ID==fn:split(myproductAttr.DEFAULT_VALUE,',')[1]}">
											                  <select disabled>
											                  <option>${myAttrValue.ATTR_VALUE_NAME}</option>
											                  </select>
											                  
											                 </c:if>
									                     </c:forEach>
									                    </c:if>
									                   </c:when>
									                   
									                   
									                  <c:otherwise>
									                  ${myproductAttr.DEFAULT_VALUE}
									                  </c:otherwise>
									                 </c:choose>
									                </td>
								                 </tr> 
						                     
						                     </c:if>
						                  </c:forEach>
						                  
						                  </tbody>
						           </c:forEach>
						          
						          
			                     </table>     
			                       </c:if>
			                     
			                     
	                 </td></tr></table>
	               </c:forEach>
	               </c:if>
                </td>
              </tr>
    			
    			
    			
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.pordOfferLog')}"/>
    				</td>	
    				<td colspan="5" class="item-content">
	    				                 <c:choose>
							             <c:when test="${prodOffer.logoFileId!=null and prodOffer.logoFileId!=''}">
							              <img src="${contextPath}/fileShare/readImg.shtml?fileShare.sFileId=${prodOffer.logoFileId}" width="200" height="200"/> 
							              </c:when>
							              <c:otherwise>
							              <span class="fromred"><s:property value="%{getText('eaap.op2.conf.pardmix.havenophoto')}"/></span>  
							              </c:otherwise>
							            </c:choose>
    				</td>
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.pardmix.odrPrice')}"/>
    				</td>
    				<td colspan="5">
    				       <table border='1' width="98%">
       						<tbody>
       							 <tr bgcolor="#F2F2F2">
       								<th width="33%" ><s:property value="%{getText('eaap.op2.conf.pardmix.feeType')}" /></th>
       								<th width="33%" ><s:property value="%{getText('eaap.op2.conf.pardmix.feeContent')}" /></th>
       								<th width="33%" ><s:property value="%{getText('eaap.op2.conf.pardmix.beyondFee')}" /></th>
       							 </tr>
       							  <c:if test="${fn:length(pricingList)>=1}">
       							      <c:forEach var="pricingBean" items="${pricingList}" step="1"> 
						                 <tr>
							                 <td align="center">${pricingBean.NAME}</td>
							                 <td align="center">${pricingBean.PRICING_DESC}</td>
							                 <td align="center">${pricingBean.BEYOND_DESC}</td>
							             </tr> 
				                     </c:forEach>
       							  
       							  </c:if>
       						</tbody>
       					 </table>
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
           <form action="${contextPath}/orgAndApp/checkPardMix.shtml" name="checkPardMix">
            <input type="hidden" name ="content_Id" value="${content_Id}" />
            <input type="hidden" name ="activity_Id" value="${activity_Id}" />
            
    		<table class="mgr-table">
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>
    				</td>	
    				<td colspan="5">
    				<select name="checkState">
    				<option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
    				<option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option>
    				</select>
    				</td>	
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>
    				</td>
    				<td colspan="5">
    					<textarea name="checkDesc" style="WIDTH: 70%; HEIGHT: 66px" ></textarea> 
    				</td>
    			</tr>
    		 
    			<tr>
    				<td  colspan="6"   align="center">
    				    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="checkPardMix.submit();"  id="submitId"></ui:button>
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
 <ui:warn/> 
 <ui:iframe divId="opendialog" iframeHeight="500"   iframeWidth="896"  divTitle="%{getText('eaap.op2.conf.pardmix.choosemap')}" iframeId="iframe_map" iframeSrc="" iframeScrolling="no" frameborder="10" />
</body>
 </html>
 
