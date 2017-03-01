<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/icon.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.easyui.min.js"></script>
</head>
<body>
<!--body start -->
<form method="post" name="techAddForm" action="${contextPath}/techimpl/saveTechImplAndSvc.shtml">
	<input type="hidden" name="type" value="add" />
	<input type="hidden" id="techImplId" name="serTechImpl.techImplId" value="" />
	<div class="contentWarp">
	   <div>
		   <div class="accordion-header" >
		    	<div class="accordion-header-text">
		    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.cfgAdd')}" /></span>
		    	</div>
	    	</div>
		 	<table class="mgr-table" >
		 		<tr>
		 			<td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</td>
		  			<td >
		  				<select name="techImpl.componentId" id="component_id" style="width:185px" onchange="loadSvcByCompId(this.value)">
		  					<c:forEach items="${selectComponentList}" var="components" step="1">
		  						<option value="${components.componentId}">${components.name}</option>
		  					</c:forEach>
		  				</select>
		  				<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" />" target="_blank"  onclick="$('#cfgWin').window('open')">
				  			<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.selectBtn')}" /></span>
						</a>
		   			</td>
		   			<td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.techimpl.svcName')}" />:</td>
		   			<td >
		   				<select name="serTechImpl.serviceId" id="service_id">
		   				    <option value="">-----<s:property value="%{getText('eaap.op2.conf.techimpl.pelaseSelect')}" />-----</option>
		  					
		  				</select>
		   			</td>
		   			<td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" />:</td>
		   			<td >
		  				<input type="text" size="25" name="techImpl.techImplName" id="techImplName" readonly/>
		   			</td>
		   		</tr>
		   		
		   		<tr>
		   			<td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.techimpl.controlMethod')}" />:</td>
		   			<td >
		  				<select name="ctlCounterms2Tech.ccCd" id="cc_cd" disabled>
		  					<c:forEach var="ctlCounterms" items="${ctlCountermsList}" step="1">
		  						<option value="${ctlCounterms.ccCd}">${ctlCounterms.name}</option>
		  					</c:forEach>
		  				</select>
		   			</td>
		   			
		   			<td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.techimpl.controlVal')}" />:</td>
		   			<td >
		  				<input type="text" size="15" name="ctlCounterms2Tech.cutmsValue" id="cutmsValue" readonly/>
		  				<span id="span_unit">(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:<s:property value="%{getText('eaap.op2.conf.techimpl.ci')}" />)</span>
		   			</td>
		   			<td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.techimpl.cycleVal')}" />:</td>
		   			<td>
		  				<input type="text" size="15" name="ctlCounterms2Tech.cycleValue" id="cycleValue" readonly/>
		  				<select name="ctlCounterms2Tech.cycleType" id="cycle_unit" disabled>
		  					<option value="1"><s:property value="%{getText('eaap.op2.conf.techimpl.minitue')}" /></option>
		  					<option value="2"><s:property value="%{getText('eaap.op2.conf.techimpl.hour')}" /></option>
		  					<option value="3"><s:property value="%{getText('eaap.op2.conf.techimpl.day')}" /></option>
		  					<option value="4"><s:property value="%{getText('eaap.op2.conf.techimpl.week')}" /></option>
		  					<option value="5"><s:property value="%{getText('eaap.op2.conf.techimpl.month')}" /></option>
		  					<option value="6"><s:property value="%{getText('eaap.op2.conf.techimpl.quarter')}" /></option>
		  				</select>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.protocol')}" />:</td>
		   			<td class="item-content">
		   				<select name="techImpl.commProCd" id="commProCd" onchange="changeProtocal(this.value);" disabled>
		   					<c:forEach items="${commProtocalList}" var="commProtocal" step="1">
		   						<option value="${commProtocal.commProCd}">${commProtocal.commProName}</option>
		   					</c:forEach>
		   				</select>
		   			</td>
		   			<td class="item">&nbsp;</td>
		   			<td class="item-content">&nbsp;</td>
		   			<td class="item">&nbsp;</td>
		   			<td class="item-content">&nbsp;</td>
		   		</tr>
		   		<tbody id="cfgTable"></tbody>
		   		<tr>
		   			<td colspan=7 style="TEXT-ALIGN: center;">
		   				<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.ok')}" />" target="_blank" onclick="do_submit();">
							<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.ok')}" /></span>
						</a>
		   			</td>
		   		</tr>
		    </table>
	  	</div>
	</div>
</form>
<!-- open window -->
<div id="cfgWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle1')}" />" style="width:850px;height:470px;padding:5px;">
	<iframe id="cfg_iframe" scrolling="no" frameborder="0" src="" style="border:0;width:100%;height:100%"></iframe>
</div>
<!--body end --> 
<script type="text/javascript">
	$(function(){
	    var componentId = $("#component_id").val();
	    $("#cfg_iframe").attr("src","${contextPath}/techimpl/loadHasCfgIndex.shtml?componentId="+componentId);
	    
	    loadSvcByCompId(componentId);
	});
	
	function do_submit(){
		var service_id = $("#service_id").val();
		if(service_id==""){
			jQuery.messager.alert('<s:property value="%{getText('eaap.op2.conf.monitor.view.alertTitle')}" />','<s:property value="%{getText('eaap.op2.conf.techimpl.selectSvc')}" />!','warning');
	        return false;
		}
		document.techAddForm.submit();
	}
	
	function doSelectCallBack(returnStr) {
		var returnStr = returnStr.split(',');
		$("#techImplName").val(returnStr[0]);
		$("#component_id").val(returnStr[1]);
		$("#cutmsValue").val(returnStr[2]);
		$("#cycle_unit").val(returnStr[3]);
		$("#cycleValue").val(returnStr[4]);
		$("#commProCd").val(returnStr[5]);
		$("#techImplId").val(returnStr[6]);
		$("#cc_cd").val(returnStr[7]);
		changeUnit(returnStr[7]);
		loadCfgedAttr(returnStr[6]);
	}
	
	function loadSvcByCompId(componentId){
		//onchange 
		$("#cfg_iframe").attr("src","${contextPath}/techimpl/loadHasCfgIndex.shtml?componentId="+componentId);
		
		$.ajax({
			type:'post',
			url:'${contextPath}/techimpl/loadServiceByCompId.shtml?t='+Math.random(),
			data:{componentId:componentId},
			dataType:'json',
			success:function(msg){
				var svc = $("#service_id") ;
				$("#service_id option:not(:first)").remove();
				for(var i=0;i<msg.serviceList.length;i++){
					svc.append("<option value='"+msg.serviceList[i].SERVICE_ID+"'>"+msg.serviceList[i].SERVICE_CN_NAME+"</option>");
				}
			}
		});
	}
	
	function changeUnit(ccCd){
		if(ccCd == "1"){
			$("#span_unit").html("(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:<s:property value="%{getText('eaap.op2.conf.techimpl.ci')}" />)");
		}else if (ccCd == "2"){
			$("#span_unit").html("(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:M)");
		}else if (ccCd == "3"){
			$("#span_unit").html("(<s:property value="%{getText('eaap.op2.conf.techimpl.unit')}" />:<s:property value="%{getText('eaap.op2.conf.techimpl.ge')}" />)");
		}
	}

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
						cfgTd += "<td class='item'>" +rows[i].ATTR_SPEC_NAME+ "<input type='hidden' name='attrSpecIdStr' value='"+rows[i].ATTR_SPEC_ID+"' /></td><td class='item-content'><input type='text' size='28' readonly name='attrSpecValueStr' value='"+rows[i].ATTR_SPEC_VALUE+"'/></td>";
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
	 function closeWin(){
	  	$('#cfgWin').window('close');
	 }
</script>
</body>
</html>
