<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    
    <link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
    <s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/> 
	<script type="text/javascript" src="${contextPath}/struts/simple/report/resource/js/base.js"></script>
	
	<style type="text/css">
		.tabClass{width:auto;height:27px;line-height:27px;cursor:pointer;border-bottom:2px solid #6EA6D1;border-left:1px solid #6EA6D1; margin-top:3px; background-color:#F3F7FA;}
		.qryTab_sel{width:115px;height:27px;line-height:27px;color:#FFFFFF;float:left;text-align:center;cursor:pointer;border-top:1px solid #6EA6D1;border-right:1px solid #6EA6D1; background-image:url(${contextPath}/resource/${contextStyleTheme}/images/tab-icon-sel.png);}
		.qryTab_def{width:115px;height:27px;line-height:27px;color:#000000;float:left;text-align:center;cursor:pointer;border-top:1px solid #6EA6D1;border-right:1px solid #6EA6D1; background-image:url(${contextPath}/resource/${contextStyleTheme}/images/tab-icon-def.png); }
		.noBorder table td{border-left-width:0;border-right-width:0;}
	</style>
</head>
<body>
<ui:form name="form1" id="form1" method="post" cssStyle="margin:0px" target="reportResult" action="../monitorReport/loadReportData.shtml">
	<input type="hidden" name="format" id="format" value="html" />
	<input type="hidden" name="paraMap.showBias" value="true" />
	<input type="hidden" name="paraMap.scrolling" value="true" />
	<input type="hidden" id="targetType" name="paraMap.targetType" value=""/>
	<input type="hidden" id="dateType" name="paraMap.dateType" value="1"/>
		
	<div class="contentWarp">
		<!--<div class="module-path">
	  		<div class="module-path-content">
	      		<img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" /><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" />
	      		<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.monitor.report.monitorReport')}"/>
	      	</div>
	    </div>
	    -->  
	    <div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.monitor.report.queryArea')}"/>
	    	</div>
	    </div>
	    
	    <!-- query area start -->
	    <div class="dateTab">
			<div id="bg" class="tabClass">
				<div id="font1" class="qryTab_sel" onclick="setTab03Syn(1);"><s:property value="%{getText('eaap.op2.conf.monitor.report.dateTab')}" /></div>
				<div id="font2" class="qryTab_def" onclick="setTab03Syn(2);"><s:property value="%{getText('eaap.op2.conf.monitor.report.monthTab')}" /></div>
				<div id="font3" class="qryTab_def" onclick="setTab03Syn(3);"><s:property value="%{getText('eaap.op2.conf.monitor.report.quarterTab')}" /></div>
			</div>
		</div>
	    <div>
		    <table class="mgr-table" style="">
	    		<tr>
	    			<td class="item" style="width:3%;font-size:12px;">
	    				<s:property value="%{getText('eaap.op2.conf.monitor.report.org')}" />
	    			</td>
	    			<td class="item-content" style="width:10%">
	   					<ui:multiSelectBox skin="${contextStyleTheme}" name="paraMap.ORG_CODE" id="org_box" list="selectOrgList" listKey="orgId" listValue="name" layerWidth="145" width="140" ></ui:multiSelectBox>
	    			</td>
	    			<td class="item" style="width:3%;font-size:12px;">
	    				<s:property value="%{getText('eaap.op2.conf.monitor.report.component')}" />
	    			</td>
	    			<td class="item-content" style="width:10%">
	   					<ui:multiSelectBox skin="${contextStyleTheme}" id="component_box" name="paraMap.COMPONENT_CODE" list="selectComponentList" listKey="code" listValue="name" layerWidth="160" width="140"></ui:multiSelectBox>
	    			</td>
	    			<td class="item" style="width:3%;font-size:12px;">
	    				<s:property value="%{getText('eaap.op2.conf.monitor.report.service')}" />
	    			</td>
	    			<td class="item-content" style="width:10%">
	   					<ui:multiSelectBox skin="${contextStyleTheme}" id="service_box" name="paraMap.SERVICE_CODE" list="serviceList" listKey="serviceCode" listValue="serviceCnName" layerWidth="145" width="140" ></ui:multiSelectBox>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td class="item" style="width:3%;font-size:12px;">
	    				<s:property value="%{getText('eaap.op2.conf.monitor.report.biz')}" />
	    			</td>
	    			<td class="item-content" style="width:10%">
	   					<ui:multiSelectBox skin="${contextStyleTheme}" id="bizFunc_box" name="paraMap.CODE" list="bizFunctionList" listKey="code" listValue="name" layerWidth="145" width="140"></ui:multiSelectBox>
	    			</td>
	    			<td class="item" style="width:3%;font-size:12px;">
	    				<s:property value="%{getText('eaap.op2.conf.monitor.report.date')}" />
	    			</td>
	    			
	    			<td id="dateDiv1" class="item-content" style="width:17%">
	   					<ui:date skin="${contextStyleTheme}" id="btime" name="paraMap.beginTime"  value="${btime}" width="107" dateFmt="yyyy-MM-dd" isShowWeek="true"  lang="${fn:substring(localeName, 1, 3)}"></ui:date>
	    			    ~
	    				<ui:date skin="${contextStyleTheme}" id="etime" name="paraMap.endTime"  value="${etime}" width="107" dateFmt="yyyy-MM-dd" isShowWeek="true"  lang="${fn:substring(localeName, 1, 3)}"></ui:date>
	    			</td>
	    			
	    			<td class="item" style="width:5%;font-size:12px;">
	    				<s:property value="%{getText('eaap.op2.conf.monitor.report.showChart')}" />
	    			</td>
	    			<td class="item-content" style="width:4%;font-size:12px;">
	    				<ui:select skin="${contextStyleTheme}" name="paraMap.showChart" value="" id="chart_sltBox" list="%{{#{'ID':'false','NAME':showChartList[1]},#{'ID':'true','NAME':showChartList[0]}}}"  listKey="ID" listValue="NAME" width="132" layerWidth="138" layerHeight="50"></ui:select>
	    		</td>
	    	</tr>
			<tr>
				<td colspan="6"  style="margin:0;padding:0;">
			<table border="0" height="120px" align="center" style="width:100%; margin:0;padding:0;">
				<tr>
					<td style="width:50%; border-width:0;margin:0;padding:0;">
						<script language="javascript" type="text/javascript">
							var selectedField = "" ;
						  	var orderField = "" ;
						  	var groupField = "" ;
						  	var countField = "" ;
						  	var countField2 = "";
						  	var orderStr = "" ;
						  	var countStr = "" ;
						</script>	
						<table width="100%" height="120px" align="center"  border="0"  style="border-width:0;margin:0;padding:0;">
							<tr width="100%" height="120px">
								<td width="50%"  style="border-width:0;margin:0;padding:0;">
									<div style="width:100%; height:120px;border:1px solid #99CCFF;">
										<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px; ">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.optDimension')}" /></div>
										<select id="dimenSelect" multiple style="height:102px;width:100%;text-align:center;font:small-caps 600 9pts/18pts;"
										  ondblclick ="rightSelected('dimenSelect',orderField,'rowDimenDiv',2,'${contextPath}','rowGroups')">
											<s:iterator id="dimen" value="%{dimensionality}">
												<OPTION value="${dimen.ID}">${dimen.NAME}</OPTION>
											</s:iterator>
										</select>
										<s:iterator id="dimen" value="%{dimensionality}"> 
											<hidden name="IS_SUM_${dimen.ID}" id="IS_SUM_${dimen.ID}" value="${dimen.IS_SUM}" />
										</s:iterator>
									</div>
								</td>
										
								<td width="20"  style="border-width:0;margin:0;padding:0;">
									 <div style="height:50%;width:100%; padding-top:20px;">
						   		   			<IMG style="cursor:hand" src="${contextPath}/struts/simple/report/resource/images/right.gif" title="<s:property value="%{getText('eaap.op2.conf.monitor.report.addRowDim')}"/>" onClick="rightSelected('dimenSelect',orderField,'rowDimenDiv',2,'${contextPath}','rowGroups')">
									 </div>
									 <div style="height:50%;width:100%;padding-top:20px;">
						   		   			<IMG style="cursor:hand" src="${contextPath}/struts/simple/report/resource/images/right.gif" title="<s:property value="%{getText('eaap.op2.conf.monitor.report.addColumnDim')}"/>" onClick="rightSelected('dimenSelect',groupField,'colDimenDiv',4,'${contextPath}','colGroups')">
						   		   	</div>
								</td>
										
								<td width="50%"  style="border-width:0;margin:0;padding:0;">
									<table width="100%" height="58px" cellpadding='1' border='0' cellspacing='0'  style="border-width:0;margin:0;padding:0;">
										<tr width="100%" height="58px" valign="top">
											<td valign="top" style="border-width:0;margin:0;padding:0;">
									  			<div style="height:58px;width:100%;border:1px solid #99CCFF;">
													<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px;">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.rowDimension')}" /></div>
											   		<div id="rowDimenDiv" style="height:41px;width:100%;overflow:auto;" class="noBorder">
													</div>
												</div>
											</td>
										</tr>
										
										<tr width="100%" height="58px" valign="top">
											<td valign="top" style="border-width:0;margin:0;padding:0;">
												<div style="height:58px;width:100%;border:1px solid #99CCFF;">
													<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px;">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.columnDimension')}" /></div>
													<div id="colDimenDiv" style="height:41px;width:100%;overflow:auto;"class="noBorder">
													</div>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td style="border-width:0;"></td>
					<td style="width:50%; border-width:0;margin:0;padding:0;">
						<ui:tabpage id="statTab" height="126px" width="700px">
						<ui:tabpagediv title="%{getText('eaap.op2.conf.monitor.report.svcSupply')}" id="tab1" >
							<table width="100%" height="126px" align="center" border="0"  style="border-width:0;margin:0;padding:0;">
								<tr>
									<td width="50%"  style="border-width:0;margin:0;padding:0;">
								  		<div style="width:100%; height:120px;border:1px solid #99CCFF;">
									  		<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px; ">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.optTarget')}" /></div>
											<SELECT id="statSelect" multiple ondblclick="rightSelected('statSelect',countField,'statDiv',3,'${contextPath}','statItem')" style="height:70px;width:100%;text-align:center;font:small-caps 600 9pts/18pts;">
												<s:iterator id="dimen" value="%{statItemListAll}">
													<OPTION value="${dimen.ID}">${dimen.NAME}</OPTION>
												</s:iterator>
											</SELECT>
										</div>
									</td>
									
									<td width="20"  style="border-width:0;margin:0;padding:0;">
							   		   		<IMG style="cursor:hand" src="${contextPath}/struts/simple/report/resource/images/right.gif"  title="<s:property value="%{getText('eaap.op2.conf.monitor.report.addCounttarget')}"/>" onClick="rightSelected('statSelect',countField,'statDiv',3,'${contextPath}','statItem')">
							    	</td>
							    	
							    	<td width="50%" style="border-width:0;margin:0;padding:0;">
								  			<div style="height:120px;width:100%;border:1px solid #99CCFF;">
												<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px;">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.countTarget')}" /></div>
										   		<div id="statDiv" style="height:70px;width:100%;OVERFLOW:auto;" class="noBorder"></div>
											</div>
									</td>
								</tr>
							</table>
						</ui:tabpagediv>
						
						<ui:tabpagediv title="%{getText('eaap.op2.conf.monitor.report.svcUse')}" id="tab2">
							<table width="100%" height="125px" align="center"  style="border-width:0;margin:0;padding:0;">
								<tr>
									<td width="50%"  style="border-width:0;margin:0;padding:0;">
								  		<div style="width:100%; height:120px;border:1px solid #99CCFF;">
									  		<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px; ">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.optTarget')}" /></div>
											<SELECT id="statSelect2" multiple ondblclick="rightSelected('statSelect2',countField2,'statDiv2',6,'${contextPath}','statItem')" style="height:70px;width:100%;text-align:center;font:small-caps 600 9pts/18pts;">
												<s:iterator id="dimen2" value="%{performanceStatList}">
													<OPTION value="${dimen2.ID}">${dimen2.NAME}</OPTION>
												</s:iterator>
											</SELECT>
										</div>
									</td>
									
									<td width="20"   style="border-width:0;margin:0;padding:0;">
							   		   		<IMG style="cursor:hand" src="${contextPath}/struts/simple/report/resource/images/right.gif"  title="<s:property value="%{getText('eaap.op2.conf.monitor.report.addCounttarget')}"/>" onClick="rightSelected('statSelect2',countField2,'statDiv2',6,'${contextPath}','statItem')">
							    	</td>
							    	
							    	<td width="50%"  style="border-width:0;margin:0;padding:0;">
								  			<div style="height:120px;width:100%;border:1px solid #99CCFF;">
												<div style="height:15px;line-height:15px;vertical-align:middle;background-color:rgb(230,238,245);border-bottom:1px dashed rgb(150,238,245);font:small-caps 600 10pts;color:#0066CC;padding:2px;">&nbsp;<s:property value="%{getText('eaap.op2.conf.monitor.report.countTarget')}" /></div>
										   		<div id="statDiv2" style="height:70px;width:98%;overflow:auto;"class="noBorder"></div>
											</div>
									</td>
								</tr>
							</table>
						</ui:tabpagediv>
						</ui:tabpage>
						<script language="javascript">
			     	<%
			     	String rowGroupNamesStr = (String)request.getAttribute("rowGroupNames");
			     	if(rowGroupNamesStr != null && rowGroupNamesStr.trim().length()>0){
				     	String rowGroupNamesStrArray[] = rowGroupNamesStr.split(",");
				     	for(int i=0;i<rowGroupNamesStrArray.length;i++){
			     	%>
			     		$("#dimenSelect option[value='<%=rowGroupNamesStrArray[i].trim()%>']").attr("selected","selected");
			     	<%
			     		}
			     	}
			     	%>
			     	rightSelected('dimenSelect',orderField,'rowDimenDiv',2,'${contextPath}','rowGroups');
			     	
			     	<%
			     	String colGroupNamesStr = (String)request.getAttribute("colGroupNames");
			     	if(colGroupNamesStr != null && colGroupNamesStr.trim().length()>0){
				     	String colGroupNamesStrArray[] = colGroupNamesStr.split(",");
				     	for(int i=0;i<colGroupNamesStrArray.length;i++){
			     	%>
			     		$("#dimenSelect option[value='<%=colGroupNamesStrArray[i].trim()%>']").attr("selected","selected");
			     	<%
			     		}
			     	}
			     	%>
			     	rightSelected('dimenSelect',groupField,'colDimenDiv',4,'${contextPath}','colGroups');
			     	
			     	<%
			     	String statItemStr = (String)request.getAttribute("statItem");
			     	if(statItemStr != null && statItemStr.trim().length()>0){
				     	String statItemStrArray[] = statItemStr.split(",");
				     	for(int i=0;i<statItemStrArray.length;i++){
			     	%>
			     			$("#statSelect option[value='<%=statItemStrArray[i].trim()%>']").attr("selected","selected");
			     	<%
			     		}
			     	}
			     	%>
			     	rightSelected('statSelect',countField,'statDiv',3,'${contextPath}','statItem');
			     	
			     	<%
			     	String statItemStr2 = (String)request.getAttribute("statItem");
			     	if(statItemStr2 != null && statItemStr2.trim().length()>0){
				     	String statItemStrArray2[] = statItemStr2.split(",");
				     	for(int k=0;k<statItemStrArray2.length;k++){
			     	%>
			     			$("#statSelect2 option[value='<%=statItemStrArray2[k].trim()%>']").attr("selected","selected");
			     	<%
			     		}
			     	}
			     	%>
			     	rightSelected('statSelect2',countField2,'statDiv2',6,'${contextPath}','statItem');
			     </script>
				</td>
			</tr>
			</table>	
				 </td>
	    	</tr>
			<tr>
				<td colspan="6" style="TEXT-ALIGN:center; margin:0;padding:5;">
   					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.monitor.report.queryBtn')}"/>" target="_blank" onclick="query();">
					  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.monitor.report.queryBtn')}"/></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.monitor.report.excelBtn')}"/>" target="_blank"  onclick="expExcelResult();">
					  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.monitor.report.excelBtn')}"/></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.monitor.report.wordBtn')}"/>" target="_blank" onclick="expWord();" >
					  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.monitor.report.wordBtn')}"/></span>
					</a>
					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.monitor.report.pdfBtn')}"/>" target="_blank" onclick="expPDF();">
					  	<span class="button-text"><s:property value="%{getText('eaap.op2.conf.monitor.report.pdfBtn')}"/></span>
					</a>
   				</td>	
			</tr>
		</table>	
			<ui:validators formId="form1">
				<ui:validator fieldId="btime" validatorType="requiredstring" trim="true" message="%{getText('eaap.op2.conf.monitor.report.beginTimeIsNull')}"></ui:validator>
				<ui:validator fieldId="etime" validatorType="requiredstring" trim="true" message="%{getText('eaap.op2.conf.monitor.report.endTimeIsNull')}"></ui:validator>
			</ui:validators>
	   </div>
	   <br>
	   <!-- show chart area -->
		<ui:loadmask id="reportMask">
			<IFRAME name="reportResult" id="reportResult" frameborder="0" src="" style="border:0px;height:100%;width:99%;"></IFRAME>
		</ui:loadmask>
	</div>
</ui:form>
<script type="text/javascript">
	function query(){
			if(comm_validators_check()&& validatorDimen() && validatorStat()){
				mask();
				if(document.getElementById("statDiv").innerHTML.trim().length!=0){
					document.getElementById("targetType").value = "1";
				}else if(document.getElementById("statDiv2").innerHTML.trim().length!=0){
					document.getElementById("targetType").value = "2";
				}
				document.getElementById('format').value='html'; 
				document.getElementById('form1').target="reportResult";
				document.getElementById('reportResult').src="${contextPath}/monitorReport/loadReportData.shtml";
				document.getElementById('form1').submit();
				unmask();
			}
		}
	
	
	function setTab03Syn(i){
		selectTab03Syn(i);
	}
	
	function selectTab03Syn(i)
	{
		switch(i){
			case 1:
				document.getElementById("font1").className="qryTab_sel";
				document.getElementById("font2").className="qryTab_def";
				document.getElementById("font3").className="qryTab_def";
				
				$("#dateDiv1").html("");
				$("#dateDiv1").load("../monitorReport/loadDateDiv.shtml?type=1");
				$("#dateType").val("1");
			
			break;
			case 2:
				document.getElementById("font1").className="qryTab_def";
				document.getElementById("font2").className="qryTab_sel";
				document.getElementById("font3").className="qryTab_def";
			
				$("#dateDiv1").html("");
				$("#dateDiv1").load("../monitorReport/loadDateDiv.shtml?type=2");
				$("#dateType").val("2");
			
			break;
			case 3:
				document.getElementById("font1").className="qryTab_def";
				document.getElementById("font2").className="qryTab_def";
				document.getElementById("font3").className="qryTab_sel";
			
				$("#dateDiv1").html("");
				$("#dateDiv1").load("../monitorReport/loadDateDiv.shtml?type=3");
				$("#dateType").val("3");
			break;
		}
	}
	
		function expExcel(){
			if(comm_validators_check()&& validatorDimen() && validatorStat()){
				document.getElementById('format').value='xls';
				document.getElementById('form1').target="_blank";
				document.getElementById('form1').submit();
			}
		}
		function expWord(){
			if(comm_validators_check()&& validatorDimen() && validatorStat()){
				document.getElementById('format').value='doc';
				document.getElementById('form1').target="_blank"; 
				document.getElementById('form1').submit();
			}			
		}			
		function expPDF(){
			if(comm_validators_check()&& validatorDimen() && validatorStat()){
				document.getElementById('format').value='pdf';
				document.getElementById('form1').target="_blank";
				document.getElementById('form1').submit();
			}			
		}

		function expExcelResult(){
			if(comm_validators_check()&& validatorDimen() && validatorStat()){
				if(document.getElementById("statDiv").innerHTML.trim().length!=0){
					document.getElementById("targetType").value = "1";
				}else if(document.getElementById("statDiv2").innerHTML.trim().length!=0){
					document.getElementById("targetType").value = "2";
				}
				var reportid = "agilityReport";
				if(reportResult.document.getElementById(reportid+'_form')){
					if( !reportResult.document.getElementById(reportid+'_format')) {
						var aElement=reportResult.document.createElement("<input type=hidden id=\""+reportid+"_format\" name=\"format\" value=\"xls\">"); 
					   	reportResult.document.getElementById(reportid+'_span').appendChild(aElement); 
					}else{
						reportResult.document.getElementById(reportid+'_format').value='xls';
					}
					
					reportResult.document.getElementById(reportid+'_form').target="_blank";
					reportResult.document.getElementById(reportid+'_form').submit();
					
					reportResult.document.getElementById(reportid+'_format').value='html';
					reportResult.document.getElementById(reportid+'_form').target="_self";
				} else{
					document.getElementById('format').value='xls';
					document.getElementById('form1').target="_blank";
					document.getElementById('form1').submit();
				}
			}
		}
		
		function validatorDimen(){
			if(document.getElementById("rowDimenDiv").innerHTML.trim().length==0){
				commShowAlert(document.getElementById("rowDimenDiv"),"<s:property value="%{getText('eaap.op2.conf.monitor.report.rowDimenIsNull')}"/>");
				return false;
			}else {
				return true;
			}
		}
		
		function validatorStat(){
			if(document.getElementById("statDiv").innerHTML.trim().length==0 && document.getElementById("statDiv2").innerHTML.trim().length==0){
				commShowAlert(document.getElementById("statDiv"),"<s:property value="%{getText('eaap.op2.conf.monitor.report.totalTargetIsNull')}"/>");
				return false;
			}
			return true;
		}
		
		window.onload = function(){
			$('#statTab').tabs({
				onSelect:function(title,id){
					if (document.getElementById("statDiv").innerHTML.trim().length!=0 && document.getElementById("statDiv2").innerHTML.trim().length==0){
						$("#statSelect2").attr("disabled","disabled");
					}else if (document.getElementById("statDiv").innerHTML.trim().length==0 && document.getElementById("statDiv2").innerHTML.trim().length!=0){
						$("#statSelect").attr("disabled","disabled");
					}else if (document.getElementById("statDiv").innerHTML.trim().length==0 && document.getElementById("statDiv2").innerHTML.trim().length==0){
						$("#statSelect").removeAttr("disabled"); 
						$("#statSelect2").removeAttr("disabled");
					}
				}
			});
		}
</script>
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>
