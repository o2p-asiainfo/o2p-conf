<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
</head>
<body>
<!--body start -->
<form method="post" name="techAddForm" action="">
	<input type="hidden" id="tech_impl_id"  value="${techImpl.techImplId}" />
	<div class="contentWarp">
	   <div>
		   <div class="accordion-header" >
		    	<div class="accordion-header-text">
		    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.techImplDetail')}" /></span>
		    	</div>
	    	</div>
		 	<table class="mgr-table" >
		 		<tr>
		 			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" />:</td>
		   			<td class="item-content">
		  				<input type="text" size="25" name="techImpl.techImplName" id="techImplName" value="${techImpl.techImplName}" readonly/>
		   			</td>	
		 			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</td>
		  			<td class="item-content">
		  				<select name="techImpl.componentId" id="component_id" disabled>
		  					<option value="${component.componentId}">${component.name}</option>
		  				</select>
		   			</td>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.svcName')}" />:</td>
		   			<td class="item-content">
		   				<select name="serTechImpl.serviceId" id="service_id" disabled>
		  					<option value="${service.serviceId}">${service.serviceCnName}</option>
		  				</select>
		   			</td>
		   		</tr>
		   		
		   		<tr>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.controlMethod')}" />:</td>
		   			<td class="item-content">
		  				<select name="ctlCounterms2Tech.ccCd" id="cc_cd" disabled>
		  					<c:forEach var="ctlCounterms" items="${ctlCountermsList}" step="1">
		  						<option <c:if test="${ctlCounterms2Tech.ccCd==ctlCounterms.ccCd}">selected</c:if> value="${ctlCounterms.ccCd}">${ctlCounterms.name}</option>
		  					</c:forEach>
		  				</select>
		   			</td>
		   			
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.controlVal')}" />:</td>
		   			<td class="item-content">
		  				<input type="text" size="15" name="ctlCounterms2Tech.cutmsValue" value="${ctlCounterms2Tech.cutmsValue}" id="cutmsValue" readonly/>
		  				<c:choose>
		  					<c:when test="${ctlCounterms2Tech.ccCd==1}">
		    					(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:<s:property value="%{getText('eaap.op2.conf.techimpl.ci')}" />)
		    				</c:when>
    						<c:when test="${ctlCounterms2Tech.ccCd==2}">
    							(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:M)
    						</c:when>
    						<c:when test="${ctlCounterms2Tech.ccCd==3}">
    							(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:<s:property value="%{getText('eaap.op2.conf.techimpl.ge')}" />)
    						</c:when>
		  				</c:choose>
		  			</td>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.cycleVal')}" />:</td>
		   			<td class="item-content">
		  				<input type="text" size="15" name="ctlCounterms2Tech.cycleValue" value="${ctlCounterms2Tech.cycleValue}" id="cycleValue" readonly/>
		  				<select name="ctlCounterms2Tech.cycleType" disabled>
		  					<option <c:if test="${ctlCounterms2Tech.cycleType==1}">selected</c:if> value="1"><s:property value="%{getText('eaap.op2.conf.techimpl.minitue')}" /></option>
		  					<option <c:if test="${ctlCounterms2Tech.cycleType==2}">selected</c:if> value="2"><s:property value="%{getText('eaap.op2.conf.techimpl.hour')}" /></option>
		  					<option <c:if test="${ctlCounterms2Tech.cycleType==3}">selected</c:if> value="3"><s:property value="%{getText('eaap.op2.conf.techimpl.day')}" /></option>
		  					<option <c:if test="${ctlCounterms2Tech.cycleType==4}">selected</c:if> value="4"><s:property value="%{getText('eaap.op2.conf.techimpl.week')}" /></option>
		  					<option <c:if test="${ctlCounterms2Tech.cycleType==5}">selected</c:if> value="5"><s:property value="%{getText('eaap.op2.conf.techimpl.month')}" /></option>
		  					<option <c:if test="${ctlCounterms2Tech.cycleType==6}">selected</c:if> value="6"><s:property value="%{getText('eaap.op2.conf.techimpl.quarter')}" /></option>
		  				</select>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</td>
		   			<td class="item-content">
		   				<select name="techImpl.commProCd" id="commProCd" disabled>
		   					<c:forEach items="${commProtocalList}" var="commProtocal" step="1">
		   						<option <c:if test="${techImpl.commProCd==commProtocal.commProCd}">selected</c:if> value="${commProtocal.commProCd}">${commProtocal.commProName}</option>
		   					</c:forEach>
		   				</select>
		   			</td>
		   			<td class="item">&nbsp;</td>
		   			<td class="item-content">&nbsp;</td>
		   			<td class="item">&nbsp;</td>
		   			<td class="item-content">&nbsp;</td>
		   		</tr>
		   		<tbody id="cfgTable"></tbody>
		    </table>
	  	</div>
	</div>
</form>
<!--body end --> 
<script type="text/javascript">
	$(function(){
		var tech_impl_id = $("#tech_impl_id").val();
		loadCfgedAttr(tech_impl_id);
	});
	
	function loadCfgedAttr(tech_impl_id){
		var cfgTable = $("#cfgTable");
		var cfgTr = "";
		var cfgTd = "";
		var divHtml = "";
		$.ajax({
			url : '${contextPath}/techimpl/loadCfgedTechImplAttr.shtml?t='+Math.random(),
			cache : false,
			async : false,
			dataType : "json",
			type  : 'POST',
			data  : {techImplId:tech_impl_id},
			success : function(response) {
				if(response && response.rows){
					var rows = response.rows;
					for ( var i = 0; i < rows.length; i++) {
						cfgTd += "<td class='item'>" +rows[i].ATTR_SPEC_NAME+ "<input type='hidden' name='attrSpecIdStr' value='"+rows[i].ATTR_SPEC_ID+"' /></td><td class='item-content'><input type='text' size='30' readonly name='attrSpecValueStr' value='"+rows[i].ATTR_SPEC_VALUE+"'/></td>";
						 if ((i+1) % 3 == 0){
							cfgTr += "<tr>"+ cfgTd + "</tr>";
							cfgTd = "";
							divHtml += cfgTr;
						 }
					}
					if (cfgTd != ""){
						var tdLength =3-(rows.length%3);
						var blankTd = "";
						for (var k=0;k<tdLength;k++){
							blankTd += "<td class='item'>&nbsp;</td><td class='item-content'>&nbsp</td>";
						}
						cfgTr = "<tr>"+ cfgTd +blankTd+ "</tr>";
						divHtml += cfgTr;
					}
					cfgTable.html(divHtml);
				}
			}
		});
	}
</script>
</body>
</html>
