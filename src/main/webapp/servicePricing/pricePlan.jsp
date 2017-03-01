<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Add price Plan</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta http-equiv="Access-Control-Allow-Origin" content="*">
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
  	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
	
		
</head>
<body>


<!--body start -->
	
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png"  align="top"/>
	     	<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionId')}" />
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.techimpl.title')}" /> 
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.pricing.manager.addServicePrice')}" />
	      	
      	</div>
    </div>
    
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.pricing.manager.addServicePrice')}" />	      	
		</div>
    </div>
    
    
    <div>
    <form id = "addpp" action="${contextPath}/pricing/addPricePlan.shtml"></form>
    <ui:form id="myForm" name="myForm" action="" method="post">  
    	  <ui:inputText skin="${contextStyleTheme}"  id="prodOfferId" name="prodOfferId" type="hidden" value ="${prodOffer.prodOfferId }"/>
          <ui:inputText skin="${contextStyleTheme}"  id="prodOfferName" name="prodOfferName" type="hidden" value ="${prodOffer.prodOfferName }"/>
           
          <table class="mgr-table">
            
            <tr>
              <td class="item" style="width:30%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.pricing.manager.packageName')}" />:</td>
              <td>${prodOffer.prodOfferName }</td>
            </tr>
            
            <tr>
             <td class="item"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.pricing.manager.serviceSelection')}" /> : </td>	
    		 <td>${serviceNames }
    		  <c:forEach items="${serviceList}" var="apis" varStatus="vs"> 
				  <c:if test="${!vs.last}" >
					<input type="hidden" value="${apis.SERVICEID}"/>${apis.CNNAME },
				  </c:if>
                  <c:if test="${vs.last}">
					<input type="hidden" value="${apis.SERVICEID}"/>${apis.CNNAME }
				  </c:if>
				</c:forEach>
    		  </td>   
           </tr>  

		   <tr>
    		       <td  colspan="2" class="item-content" align="left">
    		            <c:if test="${ordType == 'add' ||ordType == 'modify'}">			    
	    					<a class="button-base button-small" onclick="pricePlan();">
							<span class="button-text"><s:property value="%{getText('eaap.op2.conf.pricing.manager.addPricePlan')}" /></span>
							</a>
						</c:if>
						<div style="width:80%; margin:0 auto; border:1px solid  #CCC;">
						<table width="100%" id = "tab4">
						 <thead>
						  <tr>
						    <td class="item" style="text-align:left;"><s:property value="%{getText('eaap.op2.conf.pricing.manager.code')}" /></td>
						    <td class="item" style="text-align:left;"><s:property value="%{getText('eaap.op2.conf.pricing.manager.name')}" /></td>
						    <td class="item" style="text-align:left;"><s:property value="%{getText('eaap.op2.conf.pricing.manager.remarks')}" /></td>
						    <td class="item" style="text-align:left;"><s:property value="%{getText('eaap.op2.conf.pricing.manager.operation')}" /></td>
						  </tr>
						   </thead>
       						<tbody>
        					  <c:forEach items="${pricePlanList}" var="pricePlan" varStatus="vs"> 
       									<tr>
       									 	<td><input type="hidden" value="${pricePlan.PRICINGINFOID}"/><input type='hidden' value="${pricePlan.PRICINGTARGETID }"/><span>${vs.count }</span></td>
       									 	<td>${pricePlan.PRICINGNAME }<input type="hidden" id="billingPriority" value="${pricePlan.BILLINGPRIORITY }"/></td>
       									 	<td>${pricePlan.PRICINGDESC }</td>
       									 	<td><ui:button text="%{getText('eaap.op2.conf.pricing.manager.detail')}" shape="s" skin="${contextStyleTheme}"
											title="%{getText('aap.op2.conf.pricing.manager.detail')}" onclick="goPricePlan(${prodOffer.prodOfferId},${pricePlan.PRICINGINFOID },${pricePlan.PRICINGTARGETID },'detail')"></ui:button>
											    <c:if test="${ordType == 'add' ||ordType == 'modify'}">	
											    <ui:button text="Modify" shape="s" skin="${contextStyleTheme}"
													title="%{getText('eaap.op2.conf.pricing.manager.pricePlan')}" onclick="goPricePlan(${prodOffer.prodOfferId}, ${pricePlan.PRICINGINFOID },${pricePlan.PRICINGTARGETID },'update')"></ui:button>
												
												<span  onclick="delPricePlan('${pricePlan.PRICINGINFOID }','${pricePlan.PRICINGTARGETID }',this,'${prodOffer.prodOfferId}')"><img src='${contextPath}/resource/${contextStyleTheme}/images/icon-delete.png' width='16' height='16'/></span>
											    </c:if>
									      </td>
       									</tr>
       						 </c:forEach>
       						 
       						</tbody>
						</table>
						</div>
    				</td>
    			 
    	
		 </tr>
		 </table>
		 <p style='text-align:center;padding-top:50px'> 
			<a class="button-base button-middle" id="" onclick="history.go(-1);">
  				<span class="button-text">Cancel</span></a>
		 </p>	
    	</ui:form>
    		
    </div>
</div>
<!--body end --> 

</body>
<script> 

 $(document).on('mousedown','.aui_close',function(event){
 		event.preventDefault();
 		event.stopPropagation();
 		 var prodOfferId = +$("#prodOfferId").val();
 		 window.location.href = "${contextPath}/pricing/servicePkgDetail.shtml?offerId="+prodOfferId+"&ordType=modify";
 })
 
   function pricePlan(){
	   
	   var prodOfferName = $("#prodOfferName").val();
		
	 
	var para = "&defaultName="+prodOfferName+"&";
	 
		para += "applicType=1";
	 
		 
		openWindows('${contextPath}/pricing/addPricePlan.shtml?prodIds='+$("#prodOfferId").val()+"&actionType=add"+para,'Price Plan',1000,500,false);
   }
   
   function insertRow(prodOfferId,priceInfoId,pricingTargetId,pricingName,pricingDesc,billingPriority){
	   if($("#tab4").find("input[value="+priceInfoId+"]").length>0){
			$("#tab4").find("input[value="+priceInfoId+"]").parent().parent().remove();
		}
	   var len = $("#tab4>tbody>tr").length+1;
		var newTr = "";
		 
		newTr = "<tr id='"+priceInfoId+"'>"  
		     +"<td><input type='hidden' value='"+priceInfoId+"'/><input type='hidden' value='"+pricingTargetId+"'/><span>"+len+"<span></td>"
		    +"<td>"+pricingName+"<input type='hidden' id='billingPriority' value='"+billingPriority+"'/></td>"
		    +"<td>"+pricingDesc+"</td>"
		    +"<td><a id='opener_odrPrice' class='button-base button-small' onclick=\"goPricePlan('"+prodOfferId+"','"+priceInfoId+"','"+pricingTargetId+"','detail');\" title='%{getText('eaap.op2.conf.pricing.manager.pricePlan')}'>"
			+"<span class='button-text'>"+"<s:property value="%{getText('eaap.op2.conf.pricing.manager.detail')}" />"+"</span></a>&nbsp;"
			+"<a id='opener_odrPrice' class='button-base button-small' onclick=\"goPricePlan('"+prodOfferId+"','"+priceInfoId+"','"+pricingTargetId+"','update');\" title='%{getText('eaap.op2.conf.pricing.manager.pricePlan')}'>"
			+"<span class='button-text'>"+"<s:property value="%{getText('eaap.op2.conf.pricing.manager.modify')}" />"+"</span></a>"
			+"<span onclick=\"delPricePlan('"+priceInfoId+"','"+pricingTargetId+"',this,'"+prodOfferId+"')\"><img src='${contextPath}/resource/${contextStyleTheme}/images/icon-delete.png' width='16' height='16'/></span></td></tr>";
		
			 
		  $('#tab4').append(newTr);  
    }
   
   function goPricePlan(ofrId,pricingInfoId,pricingTargetId,type){
       
       var params = "&defaultName="+"${prodOffer.prodOfferName}";
       params +="&prodType=2";
       openWindows_lock("${contextPath}/pricing/goPricePlan.shtml?prodIds="+ofrId +"&pricingPlan.pricingInfoId="+pricingInfoId+"&actionType="+type+"&pricingTargetId="+pricingTargetId+"&pricingPlan.applicType=2"+params,'Price Plan',1000,500,true);
 
    }
   
   function delPricePlan(id,pricingTargetIdv,obj,prodOfferIds){
 
		  
		 $.ajax({
				type: "POST",
				async:false,
			    url: "${contextPath}/pricing/delPricePlan.shtml",
			    dataType:'json',
			    data:{priceInfoId:id,prodOfferId:prodOfferIds,pricingTargetId:pricingTargetIdv},
				success:function(msg){
					
					$(obj).closest('tr').remove();
					var i = 1;
					$("#tab4>tbody>tr").each(function(){
							$(this).find("td").eq(0).text(i++);
						});
	          }
	     });
	}

  
</script>

</html>
