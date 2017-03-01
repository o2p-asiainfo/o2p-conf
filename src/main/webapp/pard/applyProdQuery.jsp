<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>

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
      <img src="../resource/blue/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.prodsellauditing.productcheck')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.prodsellauditing.applyproduct')}"/>
    	</div>
    </div>
    
    <div>
    		<table class="mgr-table">
    			<tr>
    				<td class="item" style="width:30%"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.applyName')}"/>:</td>
    				<td class="item-content" style="width:70%">${applyName}</td>
    			</tr>
    			<tr>
    				<td class="item" style="width:30%"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.applyDesc')}"/>:</td>
    				<td class="item-content" style="width:70%">${applyDesc}</td>
    			</tr>
    		</table>
    		<table class="mgr-table">
    			<tr>
						<td class="item" style="width:15%;text-align:center;padding-left: 15px;"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.productProvider')}" />
						</td>
						<td class="item" style="width:15%;text-align:center;padding-left: 15px;"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.productCode')}" />
						</td>
						<td class="item" style="width:20%;text-align:center;padding-left: 15px;"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.productName')}" />
						</td>
						<td class="item" style="width:20%;text-align:center;padding-left: 15px;"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.productDescription')}" />
						</td>
						<td class="item" style="width:15%;text-align:center;padding-left: 15px;"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.model')}" />
						</td>
						<td class="item" style="width:15%;text-align:center;padding-left: 15px;"><s:property value="%{getText('eaap.op2.conf.prodsellauditing.canSupplyQuantity')}" />
						</td>
					</tr>
					<c:forEach var="prodInfo" items="${applyInfoList}" step="1">
						<tr>
							<td class="item-content" style="width:15%;text-align:center">${prodInfo.NAME}</td>
							<td class="item-content" style="width:15%;text-align:center">${prodInfo.OFFER_NBR}</td>
							<td class="item-content" style="width:20%;text-align:center">${prodInfo.PROD_OFFER_NAME}</td>
							<td class="item-content" style="width:20%;text-align:center">${prodInfo.PROD_OFFER_DESC}</td>
							<td class="item-content" style="width:15%;text-align:center">${prodInfo.PROD_OFFER_DESC}</td>
							<td class="item-content" style="width:15%;text-align:center">${prodInfo.PROD_OFFER_DESC}</td>
						</tr>
					</c:forEach>
    		</table>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.check')}"/>
    	</div>
    </div>
    <div>
           <form action="${contextPath}/prodSell/prodAudit.shtml" name="prodAudit" id="prodAudit">
            <input type="hidden" name ="processId" value="${processId}" />
            <input type="hidden" name ="activityId" value="${activityId}" />
            
    		<table class="mgr-table">
    			<tr>
    				<td class="item" style="width:30%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>:
    				</td>	
    				<td class="item-content" style="width:70%">
    				<select name="auditState">
    				<option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
    				<option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option>
    				</select>
    				</td>	
    			</tr>
    			<tr>
    				<td class="item"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>:
    				</td>
    				<td class="item-content">
    					<textarea name="auditDesc" style="WIDTH: 70%; HEIGHT: 66px" ></textarea> 
    				</td>
    			</tr>
    			<tr>
    				<td  colspan="2" class="item-content" align="center">
    				    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" onclick="$('#prodAudit').submit();" ></ui:button>
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
