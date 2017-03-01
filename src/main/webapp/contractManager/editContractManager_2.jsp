<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />		
	
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
	<script type="text/javascript" src="${contextPath}/resource/contractDoc_files/contractDiv.js" ></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/contractDoc_files/contractDiv.css" />
	<script type="text/javascript" src="../resource/comm/adapter/jquery.min.js"></script>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>	
	<script type="text/javascript" src="../resource/comm/adapter/json2.js"></script>
	<script>	
	    var optionReqStr = '';
	    var optionRspStr = '';
	    var chooseText ='<s:property value="%{getText('eaap.op2.conf.prov.choose')}" />';
		var ContractAttrSpecJson = null;
		
		function updateContractManager(){
			//先保存节点描述列表信息：
			saveAll('REQ',false);
			saveAll('RSP',false);
			
			$("#contractAttrSpec").val(JSON.stringify(ContractAttrSpecJson));
			//保存前先异常响应模板Mock:
			$("#submitLoadImg").show();
			$("#submitBut").hide();
			if($("#templateDefMode").val() == "0"){
				setTemplateHeader();
				$("#submitInfoDiv").html("");
				var mockMsg = "<b>Exception Template of Protocol Response Definition mock failed !</b>";
				var templateHeader = jQuery.trim($("#templateHeader").val());
				var templateBody	   = jQuery.trim($("#templateBody").val());
				if(templateBody == ""){
					$("#submitLoadImg").hide();
					$("#submitBut").show();	
					mockMsg = "<b>Exception Template of Protocol Response Definition is required !</b>";
					$("#submitInfoDiv").html(mockMsg);
					return; 
				}
				$.ajax({
				     type:"post",
				     async:true,
				     url:"${contextPath}/contractManager/templateMock.shtml",
				     dataType:"json",
				     data:{templateHeader:templateHeader,templateBody:templateBody},
				     success:function(msg,data){
							try {
					      		var resCode = msg.ResultCode;
						      	if(resCode=="0"){
							      	//mock Success:
							      	var headCode = msg.HeadResult.RespCode;
							      	var bodyCode = msg.BodyResult.RespCode;
							      	if(headCode =="0" && bodyCode =="0"){
							      		//Mock验证通过后保存：
										var form = document.getElementById("contractManagerForm");
									  	var url = "${contextPath}/contractManager/addNextContractManager.shtml?contractId=" + ${contractDefined.contractId}; 
									  	form.action = url;
								       	form.submit();		
							      	}else{
								      	if(headCode !="0"){
								      		//mock head Failure
								      		mockMsg += "<br>Please confirm the ''HEADER'' is correct.";
								      		mockMsg += "<br>"+ msg.HeadResult.RespDesc;
											$("#submitLoadImg").hide();
											$("#submitBut").show();	
								      	}
								      	if(bodyCode !="0"){
								      		//mock body Failure
								      		mockMsg += "<br>Please confirm the ''BODY'' is correct.";
								      		mockMsg += "<br>"+ msg.BodyResult.RespDesc;
											$("#submitLoadImg").hide();
											$("#submitBut").show();								      		
								      	}
										$("#submitInfoDiv").html(mockMsg);
							      	}
						      	}else{
							      	//mock Failure:
							      	mockMsg += "<br>"+ msg.ResultDesc;
									$("#submitLoadImg").hide();
									$("#submitBut").show();	
									$("#submitInfoDiv").html(mockMsg);
						      	}
							} catch (e) {
								//mock Failure!
								$("#submitLoadImg").hide();
								$("#submitBut").show();	
								$("#submitInfoDiv").html(mockMsg);
							}
			   	  	}
				});	
			}else{
				var form = document.getElementById("contractManagerForm");
			  	var url = "${contextPath}/contractManager/addNextContractManager.shtml?contractId=" + ${contractDefined.contractId}; 
			  	form.action = url;
		       	form.submit();	
			}
		}		 
		
		function decideNull(name){
			var descNode = document.getElementsByName(name);		
			if(descNode.length > 0){
				for( i = 0; i < descNode.length; i++) {
					if(descNode[i].value == ''){
						alert('<s:property value="%{getText('eaap.op2.conf.prov.nodeNotNull')}" />');
						descNode[i].focus();
						return 1;
					}
				}
			}
		}			  
		function addReqNode(tbname) { 
	//	 var value = decideNull('reqNodeDescName');
	//	  if(value == 1){
	//	  	return;
	//	  }	 
		  var tbl = document.getElementById(tbname);  
		  var rows = tbl.rows.length;  
		  var tr = tbl.insertRow(rows);
		  var opTitle= '<s:property value="%{getText('eaap.op2.conf.prov.choose')}" />';
		  		     
		  var name = tr.insertCell(0);  
		  name.innerHTML = '<td class="middle"><input type="text" name="reqNodeDescName" id="reqNodeDescName" class="box1" /><input id="reqNodeDescId" name="reqNodeDescId" type="hidden" value=""/><input id="reqNodeFuzzyId" name="reqNodeFuzzyId" type="hidden" value=""/></td>';  
		  
		  var code = tr.insertCell(1);  
		  code.innerHTML = '<td class="middle"><input type="text" name="reqNodeDescCode" id="reqNodeDescCode" class="box1" /></td>';  
		  
		  var styleContext = "cursor:pointer;";
		  if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0)
				styleContext = "cursor:pointer;margin-left: 5px;";
		  var parentName = tr.insertCell(2);  
		  parentName.innerHTML = '<td class="middle"><div  style="margin:0;padding:0;width:140px;"><input type="text" name="reqParentNodeName" id="reqParentNodeName" class="box1" disabled="true" style="margin-right:3px;width:90px;"/><input id="reqParentNodeId" name="reqParentNodeId" type="hidden" value="" /><a style="' + styleContext + '"  onclick="openChooseNode(this,\'req\');"  onmouseover="this.style.color=\'#FF0000\';"  onmouseout="this.style.color=\'\';" >' + opTitle +'</a></div></td>';
		  
		  var path = tr.insertCell(3);  
		  path.innerHTML = '<td class="middle"><input type="text" name="reqNodePath" id="reqNodePath" class="box1" /></td>';  		  
		  
		  var lengthCons = tr.insertCell(4);  		  
		  lengthCons.innerHTML = '<td class="middle"><input type="text" name="reqNodeLengthCons" id="reqNodeLengthCons" value="${o.NODELENGTHCONS}" class="box1" size="9"/></td>';  		  
		  
		  var nodeNumber = tr.insertCell(5);  
		  nodeNumber.innerHTML = '<td class="middle"><select name="reqNodeNumberCons" id="reqNodeNumberCons" ><option value="1" <c:if test="${o.NODENUMBERCONS == 1}">selected</c:if>>1</option><option value="2" <c:if test="${o.NODENUMBERCONS == 2}">selected</c:if>>1-N</option><option value="3" <c:if test="${o.NODENUMBERCONS == 3}">selected</c:if>>0-1</option><option value="4" <c:if test="${o.NODENUMBERCONS == 4}">selected</c:if>>0-N</option></select></td>';  		  
		  
		  var nodeTypeCons = tr.insertCell(6);  
		  nodeTypeCons.innerHTML = '<td class="middle"><select name="reqNodeTypeCons" id="reqNodeTypeCons" ><option value="1" <c:if test="${o.NODETYPECONS == 1}">selected</c:if>>String</option><option value="2" <c:if test="${o.NODETYPECONS == 2}">selected</c:if>>Number</option><option value="3" <c:if test="${o.NODETYPECONS == 3}">selected</c:if>>Object</option><option value="4" <c:if test="${o.NODETYPECONS == 4}">selected</c:if>>DATE</option><option value="7" <c:if test="${o.NODETYPECONS == 7}">selected</c:if>>JsonArry</option><option value="8" <c:if test="${o.NODETYPECONS == 8}">selected</c:if>>JSON</option><option value="9" <c:if test="${o.NODETYPECONS == 9}">selected</c:if>>XML</option></select></td>';  		  
		  
		  var nodeType = tr.insertCell(7);  
		  nodeType.innerHTML = '<td class="middle"><select name="reqNodeType" id="reqNodeType" ><option value=1>Header</option><option value=2>Body</option><option value=3>TAIL</option><option value=4>URL</option><option value=6>XML NameSpace</option><option value=7>Property</option><option value=8>Child Nodes NameSpace</option></select></td>';  
		  
		  var isNeedSign = tr.insertCell(8);  
		  isNeedSign.innerHTML = '<td class="middle"><select name="reqIsNeedSign" id="reqIsNeedSign" ><option value="Y" <c:if test="${o.ISNEEDSIGN == Y}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option><option value="N" <c:if test="${o.ISNEEDSIGN == N}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option></select></td>';  
		  
		  var isNeedCheck = tr.insertCell(9);  
		  isNeedCheck.innerHTML = '<td class="middle"><select name="reqIsNeedCheck" id="reqIsNeedCheck" ><option value="Y" <c:if test="${o.ISNEEDCHECK == Y}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option><option value="N" <c:if test="${o.ISNEEDCHECK == N}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option></select></td>';  
		  
		  var nevlConsType = tr.insertCell(10);  
		  nevlConsType.innerHTML = '<td class="middle" style="margin:0;padding:0;"><select name="reqNevlConsType" id="reqNevlConsType" onchange="selectReqMainData(this)" style="margin:0;padding:0;"><c:forEach var="obj" items="${nevlConsTypeList}" varStatus="n"><option value="${obj.CEPVALUES}" >${obj.CEPNAME}</option></c:forEach></select></td>';  
		  
		  		  
		  var nevlConsValue = tr.insertCell(11);  
		  nevlConsValue.innerHTML = '<td class="middle"><input type="text" name="reqNevlConsValue" id="reqNevlConsValue" class="box1" size="40"/></td>';
		  
		  var javafieldStr = tr.insertCell(12);
		  javafieldStr.innerHTML = '<td class="middle"><select name="reqJavaField" id="reqJavaField">'+optionReqStr+'</select></td>';
		  
		  
		  
		  var fuzzy = tr.insertCell(13);
		  fuzzy.innerHTML = '<td class="middle"><div style="width:290px;"><input type="text" name="reqFuzzy" id="reqFuzzy" value="" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/>'
		  +'<input id="reqFuzzyId" name="reqFuzzyId" type="hidden" value="" />'
		  +'<a style="cursor:pointer"  onclick="javascript:selectFuzzy(this,\'req\');"  onmouseover="this.style.color=\'#FF0000\'"  onmouseout="this.style.color=\'\'" ><s:property value="%{getText('eaap.op2.conf.prov.choose')}" /></a>&nbsp;&nbsp;&nbsp;'
		  +'<a style="cursor:pointer"  onclick="javascript:clearFuzzy(this,\'req\');"  onmouseover="this.style.color=\'#FF0000\'"  onmouseout="this.style.color=\'\'" ><s:property value="%{getText('eaap.op2.conf.process.fuzzyClear')}" /></a>'
		  +'</div></td>';
		  
		  var desStr = tr.insertCell(14);
		  desStr.innerHTML = '<td class="middle"><input type="text" name="reqDescValue" id="reqDescValue" class="box1" size="40"/></td>';
		  
		  var delBtn = tr.insertCell(15);
		  delBtn.innerHTML = '<td class="middle"><div style="width:90px; text-align:center;"><a onclick="saveReqNode(this)"  style="cursor:pointer" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.save')}" /></a>&nbsp;&nbsp;&nbsp;'
		                   + '<a onclick="delReqNode(this)"  style="cursor:pointer" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.delete')}" /></a></div></td>';
		 
		  //var mainBtn = tr.insertCell(14);
		  //mainBtn.innerHTML = '<td class="middle"><div id="reqMain" ><a onclick="javascript:selectReqWin()"  style="cursor:hand" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.mainData')}" /></a></div></td>';	
		  
		  changeTopScrollHeight();
		  
		  //selectReqMainData();
		}  
		function delReqNode(btn) {
			if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />")) {
				  var tr = btn.parentElement.parentElement.parentElement;  
				  var tbl = tr.parentElement;
				  var reqNodeDescId = "";
				  for (var i=0; i < tr.cells[0].children.length; i++) {
					  if (tr.cells[0].children[i].id == "reqNodeDescId") {
						  reqNodeDescId = tr.cells[0].children[i].value;
					  }
				  }
				  $.ajax({
						type: "POST",
						async:true,
					    url: "../contractManager/delContract.shtml",
					    dataType:'json',
					    data:{nodeDescId: reqNodeDescId},
						success:function(msg){
							if(msg.success == 0) {
								alert('<s:property value="%{getText('eaap.op2.conf.prov.delNodeSuccess')}" />');
								if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0)
									tbl.deleteRow(tr.rowIndex-1);
								else if(navigator.userAgent.toUpperCase().indexOf("FIREFOX") >0 ||
										window.navigator.userAgent.toUpperCase().indexOf("CHROME")>0) tr.remove();
								else tr.removeNode(true);
								//tr.remove();
							} else {
								alert('<s:property value="%{getText('eaap.op2.conf.prov.isMapperExit')}" />');
							}
			              }
			         });
				 // tbl.deleteRow(tr.rowIndex-1);  
			}
		}
		function saveAll(type,isAlert){
			if('REQ' == type){
				$('#reqSaveAll').hide();
				$('#reqLoadSaveAll').show();
				$('#reqNodeDesc>tbody>tr').each(function(){
					var tr = this;
					if (checkReqNodeDesc(tr)) {
					    var reqNodeDescName = "", reqNodeDescCode = "", reqNodeDescId = "", reqNodePath = "", reqNodeLengthCons = "";
					    var reqNodeNumberCons = "", reqNodeTypeCons = "", reqNodeType = "", reqIsNeedSign = "";
					    var reqIsNeedCheck = "", reqNevlConsType = "", reqNevlConsValue = "", reqJavaField = "",reqParentNodeId ="";
					    var reqDescValue = "", reqNodeFuzzyId = "",reqFuzzyId = "";
						var json = [];
						for (var i=0; i < tr.cells.length;i++) {
							for (var j=0; j < tr.cells[i].children.length; j++) {
								var tdId = tr.cells[i].children[j].name;
								switch (tdId)
								{
								case "reqNodeDescName":
									reqNodeDescName=tr.cells[i].children[j].value;
									json.push({"nodeName":reqNodeDescName});
								  	break;
								case "reqNodeDescCode":
									reqNodeDescCode=tr.cells[i].children[j].value;
									json.push({"nodeCode":reqNodeDescCode});
								  	break;
								case "reqNodeDescId":
									reqNodeDescId=tr.cells[i].children[j].value;
									json.push({"nodeDescId":reqNodeDescId});
								  	break;
								case "reqNodeFuzzyId":
									reqNodeFuzzyId=tr.cells[i].children[j].value;
									json.push({"reqNodeFuzzyId":reqNodeFuzzyId});
								  	break;
								case "reqNodePath":
									reqNodePath=tr.cells[i].children[j].value;
									json.push({"nodePath":reqNodePath});
								  	break;
								case "reqNodeLengthCons":
									reqNodeLengthCons=tr.cells[i].children[j].value;
									json.push({"nodeLengthCons":reqNodeLengthCons});
								 	break;
								case "reqNodeNumberCons":
									reqNodeNumberCons=tr.cells[i].children[j].value;
									json.push({"nodeNumberCons":reqNodeNumberCons});
								 	break;
								case "reqNodeTypeCons":
									reqNodeTypeCons=tr.cells[i].children[j].value;
									json.push({"nodeTypeCons":reqNodeTypeCons});
								 	break;
								case "reqNodeType":
									reqNodeType=tr.cells[i].children[j].value;
									json.push({"nodeType":reqNodeType});
								  	break;
								case "reqIsNeedSign":
									reqIsNeedSign=tr.cells[i].children[j].value;
									json.push({"isNeedSign":reqIsNeedSign});
									break;
								case "reqIsNeedCheck":
									reqIsNeedCheck=tr.cells[i].children[j].value;
									json.push({"isNeedCheck":reqIsNeedCheck});
								  	break;
								case "reqNevlConsType":
									reqNevlConsType=tr.cells[i].children[j].value;
									json.push({"nevlConsType":reqNevlConsType});
								  	break;
								case "reqNevlConsValue":
									reqNevlConsValue=tr.cells[i].children[j].value;
									json.push({"nevlConsValue":reqNevlConsValue});
								  	break;
								case "reqJavaField":
									reqJavaField=tr.cells[i].children[j].value;
									json.push({"javaField":reqJavaField});
								  	break;
								case "reqDescValue":
									 reqDescValue=tr.cells[i].children[j].value;
									 json.push({"descValue":reqDescValue});
									 break;
								}
								if(tr.cells[i].children[0].children.length >0){
									for (var k=0; k < tr.cells[i].children[0].children.length; k++) {
										var cTdId = tr.cells[i].children[0].children[k].name;
										switch (cTdId){
											case "reqParentNodeId":
												reqParentNodeId=tr.cells[i].children[0].children[k].value;
												json.push({"parentNodeId":reqParentNodeId});
											  	break;
											case "reqNevlConsValue":
												reqNevlConsValue=tr.cells[i].children[0].children[k].value;
												json.push({"nevlConsValue":reqNevlConsValue});
											  	break;
											case "reqFuzzyId":
												reqFuzzyId=tr.cells[i].children[0].children[k].value;
												json.push({"reqFuzzyId":reqFuzzyId});
											  	break;
										}
									}
								}
								
							}
						}
						
						json.push({"tcpCtrFId" : $('#reqContractFormatId').val()});
						json.push({"contractVersionId" : $('#contractVersionId').val()});
						json.push({"conType" : $('#reqConType').val()});
						json.push({"xsdHeaderFor" : $('#reqXsdHeaderFor').val()});
						json.push({"xsdFormat" : $('#reqXsdFormat').val()});
						json.push({"descriptor" : $('#reqDescriptor').val()});
					  	$.ajax({
							type: "POST",
							async:true,
						    url: "${contextPath}/contractManager/saveContract.shtml",
						    dataType:'json',
						    data:{jsonString: JSON.stringify(json)},
							success:function(msg){
								$('#reqContractFormatId').val(msg.tcpCtrFId);
								tr.cells[0].children[1].value=msg.nodeDescId;
								tr.cells[0].children[2].value=msg.reqNodeFuzzyId;
				              }
				         });
					}
				});
				if(isAlert){
					alert('<s:property value="%{getText('eaap.op2.conf.prov.saveNodeSuccess')}" />');
				}
				$('#reqSaveAll').show();
				$('#reqLoadSaveAll').hide();
			}else{
				$('#rspSaveAll').hide();
				$('#rspLoadSaveAll').show();
				$('#rspNodeDesc>tbody>tr').each(function(){
					var tr = this;
					if (checkRspNodeDesc(tr)) {
					    var rspNodeDescName = "", rspNodeDescCode = "", rspNodeDescId = "", rspNodePath = "", rspNodeLengthCons = "";
					    var rspNodeNumberCons = "", rspNodeTypeCons = "", rspNodeType = "", rspIsNeedSign = "";
					    var rspIsNeedCheck = "", rspNevlConsType = "", rspNevlConsValue = "", rspJavaField = "",rspParentNodeId ="";
					    var rspNodeFuzzyId = "",rspFuzzyId = "";
						var json = [];
						for (var i=0; i < tr.cells.length;i++) {
							for (var j=0; j < tr.cells[i].children.length; j++) {
								var tdId = tr.cells[i].children[j].name;
								switch (tdId)
								{
								case "rspNodeDescName":
									rspNodeDescName=tr.cells[i].children[j].value;
									json.push({"nodeName":rspNodeDescName});
								  	break;
								case "rspNodeDescCode":
									rspNodeDescCode=tr.cells[i].children[j].value;
									json.push({"nodeCode":rspNodeDescCode});
								  	break;
								case "rspNodeDescId":
									rspNodeDescId=tr.cells[i].children[j].value;
									json.push({"nodeDescId":rspNodeDescId});
								  	break;
								case "rspNodeFuzzyId":
									rspNodeFuzzyId=tr.cells[i].children[j].value;
									json.push({"reqNodeFuzzyId":rspNodeFuzzyId});
								  	break;
								case "rspNodePath":
									rspNodePath=tr.cells[i].children[j].value;
									json.push({"nodePath":rspNodePath});
								  	break;
								case "rspNodeLengthCons":
									rspNodeLengthCons=tr.cells[i].children[j].value;
									json.push({"nodeLengthCons":rspNodeLengthCons});
								 	break;
								case "rspNodeNumberCons":
									rspNodeNumberCons=tr.cells[i].children[j].value;
									json.push({"nodeNumberCons":rspNodeNumberCons});
								 	break;
								case "rspNodeTypeCons":
									rspNodeTypeCons=tr.cells[i].children[j].value;
									json.push({"nodeTypeCons":rspNodeTypeCons});
								 	break;
								case "rspNodeType":
									rspNodeType=tr.cells[i].children[j].value;
									json.push({"nodeType":rspNodeType});
								  	break;
								case "rspIsNeedSign":
									rspIsNeedSign=tr.cells[i].children[j].value;
									json.push({"isNeedSign":rspIsNeedSign});
									break;
								case "rspIsNeedCheck":
									rspIsNeedCheck=tr.cells[i].children[j].value;
									json.push({"isNeedCheck":rspIsNeedCheck});
								  	break;
								case "rspNevlConsType":
									rspNevlConsType=tr.cells[i].children[j].value;
									json.push({"nevlConsType":rspNevlConsType});
								  	break;
								case "rspNevlConsValue":
									rspNevlConsValue=tr.cells[i].children[j].value;
									json.push({"nevlConsValue":rspNevlConsValue});
								  	break;
								case "rspJavaField":
									rspJavaField=tr.cells[i].children[j].value;
									json.push({"javaField":rspJavaField});
								  	break;
								case "rspDescValue":
									 rspDescValue=tr.cells[i].children[j].value;
									 json.push({"descValue":rspDescValue});
									 break;
								}

								if(tr.cells[i].children[0].children.length > 0){
									for (var k=0; k < tr.cells[i].children[0].children.length; k++) {
										var cTdId = tr.cells[i].children[0].children[k].name;
										switch (cTdId){
											case "rspParentNodeId":
												rspParentNodeId=tr.cells[i].children[0].children[k].value;
												json.push({"parentNodeId":rspParentNodeId});
											  	break;
											case "rspNevlConsValue":
												rspNevlConsValue=tr.cells[i].children[0].children[k].value;
												json.push({"nevlConsValue":rspNevlConsValue});
											  	break;
											case "rspFuzzyId":
												rspFuzzyId=tr.cells[i].children[0].children[k].value;
												json.push({"reqFuzzyId":rspFuzzyId});
											  	break;
										}
									}
								}
							}
						}
						
						json.push({"tcpCtrFId" : $('#rspContractFormatId').val()});
						json.push({"contractVersionId" : $('#contractVersionId').val()});
						json.push({"conType" : $('#rspConType').val()});
						json.push({"xsdHeaderFor" : $('#rspXsdHeaderFor').val()});
						json.push({"xsdFormat" : $('#rspXsdFormat').val()});
						json.push({"descriptor" : $('#rspDescriptor').val()});
					  	$.ajax({
							type: "POST",
							async:true,
						    url: "../contractManager/saveContract.shtml",
						    dataType:'json',
						    data:{jsonString: JSON.stringify(json)},
							success:function(msg){
								$('#rspContractFormatId').val(msg.tcpCtrFId);
								tr.cells[0].children[1].value=msg.nodeDescId;
								tr.cells[0].children[2].value=msg.reqNodeFuzzyId;
				              }
				         });
					}
				});
				if(isAlert){
					alert('<s:property value="%{getText('eaap.op2.conf.prov.saveNodeSuccess')}" />');
				}
				$('#rspSaveAll').show();
				$('#rspLoadSaveAll').hide();
			}
		}
		
		function saveReqNode(btn) {  
		//	debugger;
		//	if ("${contractDefined.reqContractFormatId}" == "") {
		//		if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmDel')}" />"))
		//	}
			var tr = btn.parentElement.parentElement.parentElement;
			if (checkReqNodeDesc(tr)) {
			    var reqNodeDescName = "", reqNodeDescCode = "", reqNodeDescId = "", reqNodePath = "", reqNodeLengthCons = "";
			    var reqNodeNumberCons = "", reqNodeTypeCons = "", reqNodeType = "", reqIsNeedSign = "";
			    var reqIsNeedCheck = "", reqNevlConsType = "", reqNevlConsValue = "", reqJavaField = "",reqParentNodeId ="";
			    var reqDescValue = "", reqNodeFuzzyId = "",reqFuzzyId = "";
				var json = [];
				for (var i=0; i < tr.cells.length;i++) {
					for (var j=0; j < tr.cells[i].children.length; j++) {
						var tdId = tr.cells[i].children[j].name;
						switch (tdId)
						{
						case "reqNodeDescName":
							reqNodeDescName=tr.cells[i].children[j].value;
							json.push({"nodeName":reqNodeDescName});
						  	break;
						case "reqNodeDescCode":
							reqNodeDescCode=tr.cells[i].children[j].value;
							json.push({"nodeCode":reqNodeDescCode});
						  	break;
						case "reqNodeDescId":
							reqNodeDescId=tr.cells[i].children[j].value;
							json.push({"nodeDescId":reqNodeDescId});
						  	break;
						case "reqNodeFuzzyId":
							reqNodeFuzzyId=tr.cells[i].children[j].value;
							json.push({"reqNodeFuzzyId":reqNodeFuzzyId});
						  	break;
						case "reqNodePath":
							reqNodePath=tr.cells[i].children[j].value;
							json.push({"nodePath":reqNodePath});
						  	break;
						case "reqNodeLengthCons":
							reqNodeLengthCons=tr.cells[i].children[j].value;
							json.push({"nodeLengthCons":reqNodeLengthCons});
						 	break;
						case "reqNodeNumberCons":
							reqNodeNumberCons=tr.cells[i].children[j].value;
							json.push({"nodeNumberCons":reqNodeNumberCons});
						 	break;
						case "reqNodeTypeCons":
							reqNodeTypeCons=tr.cells[i].children[j].value;
							json.push({"nodeTypeCons":reqNodeTypeCons});
						 	break;
						case "reqNodeType":
							reqNodeType=tr.cells[i].children[j].value;
							json.push({"nodeType":reqNodeType});
						  	break;
						case "reqIsNeedSign":
							reqIsNeedSign=tr.cells[i].children[j].value;
							json.push({"isNeedSign":reqIsNeedSign});
							break;
						case "reqIsNeedCheck":
							reqIsNeedCheck=tr.cells[i].children[j].value;
							json.push({"isNeedCheck":reqIsNeedCheck});
						  	break;
						case "reqNevlConsType":
							reqNevlConsType=tr.cells[i].children[j].value;
							json.push({"nevlConsType":reqNevlConsType});
						  	break;
						case "reqNevlConsValue":
							reqNevlConsValue=tr.cells[i].children[j].value;
							json.push({"nevlConsValue":reqNevlConsValue});
						  	break;
						case "reqJavaField":
							reqJavaField=tr.cells[i].children[j].value;
							json.push({"javaField":reqJavaField});
						  	break;
						  	/*
						case "reqParentNodeId":
							reqParentNodeId=tr.cells[i].children[j].value;
							json.push({"parentNodeId":reqParentNodeId});
						  	break;
						  	*/
						case "reqDescValue":
							 reqDescValue=tr.cells[i].children[j].value;
							 json.push({"descValue":reqDescValue});
							 break;
						}
						if(tr.cells[i].children[0].children.length >0){
							for (var k=0; k < tr.cells[i].children[0].children.length; k++) {
								var cTdId = tr.cells[i].children[0].children[k].name;
								switch (cTdId){
									case "reqParentNodeId":
										reqParentNodeId=tr.cells[i].children[0].children[k].value;
										json.push({"parentNodeId":reqParentNodeId});
									  	break;
									case "reqNevlConsValue":
										reqNevlConsValue=tr.cells[i].children[0].children[k].value;
										json.push({"nevlConsValue":reqNevlConsValue});
									  	break;
									case "reqFuzzyId":
										reqFuzzyId=tr.cells[i].children[0].children[k].value;
										json.push({"reqFuzzyId":reqFuzzyId});
									  	break;
								}
							}
						}
						
					}
				}
				
				json.push({"tcpCtrFId" : $('#reqContractFormatId').val()});
				json.push({"contractVersionId" : $('#contractVersionId').val()});
				json.push({"conType" : $('#reqConType').val()});
				json.push({"xsdHeaderFor" : $('#reqXsdHeaderFor').val()});
				json.push({"xsdFormat" : $('#reqXsdFormat').val()});
				json.push({"descriptor" : $('#reqDescriptor').val()});
			  	$.ajax({
					type: "POST",
					async:true,
				    url: "${contextPath}/contractManager/saveContract.shtml",
				    dataType:'json',
				    data:{jsonString: JSON.stringify(json)},
					success:function(msg){
						alert('<s:property value="%{getText('eaap.op2.conf.prov.saveNodeSuccess')}" />');
						$('#reqContractFormatId').val(msg.tcpCtrFId);
						tr.cells[0].children[1].value=msg.nodeDescId;
						tr.cells[0].children[2].value=msg.reqNodeFuzzyId;
		              }
		         });
			}
		}
		function addRspNode(tbname) {
			// å¤æ­ä¸ä¸æ¡æ¯å¦å·²å¡«		
		//  var value = decideNull('rspNodeDescName');
		//  if(value == 1){
		//  	return;
		//  }		  
		  var tbl = document.getElementById(tbname);  
		  var rows = tbl.rows.length;  
		  var tr = tbl.insertRow(rows);
		  var opTitle = '<s:property value="%{getText('eaap.op2.conf.prov.choose')}" />';
		  
		  var name = tr.insertCell(0);  
		  name.innerHTML = '<td class="middle"><input type="text" name="rspNodeDescName" id="rspNodeDescName" class="box1" /><input id="rspNodeDescId" name="rspNodeDescId" type="hidden" value=""/><input id="rspNodeFuzzyId" name="rspNodeFuzzyId" type="hidden" value=""/></td>'; 
		  
		  var code = tr.insertCell(1);  
		  code.innerHTML = '<td class="middle"><input type="text" name="rspNodeDescCode" id="rspNodeDescCode" class="box1" /></td>'; 
		  
		  var styleContext = "cursor:pointer;";
		  if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0)
				styleContext = "cursor:pointer;margin-left: 5px;";
		  var parentName = tr.insertCell(2);  
		  parentName.innerHTML = '<td class="middle"><div  style="margin:0;padding:0;width:140px;"><input type="text" name="rspParentNodeName" id="rspParentNodeName" class="box1" disabled="true" style="margin-right: 3px;width:90px;"/><input id="rspParentNodeId" name="rspParentNodeId" type="hidden" value="" /><a style="' + styleContext + '"  onclick="openChooseNode(this,\'rsp\');"  onmouseover="this.style.color=\'#FF0000\';"  onmouseout="this.style.color=\'\';" >' + opTitle +'</a></div></td>';
		  
		  var path = tr.insertCell(3);  
		  path.innerHTML = '<td class="middle"><input type="text" name="rspNodePath" id="rspNodePath" class="box1" /></td>';  		  
		  
		  var lengthCons = tr.insertCell(4);  		  
		  lengthCons.innerHTML = '<td class="middle"><input type="text" name="rspNodeLengthCons" id="rspNodeLengthCons" value="${o.NODELENGTHCONS}" class="box1" size="9"/></td>';  		  
		  
		  var nodeNumber = tr.insertCell(5);  
		  nodeNumber.innerHTML = '<td class="middle"><select name="rspNodeNumberCons" id="rspNodeNumberCons" ><option value="1" <c:if test="${o.NODENUMBERCONS == 1}">selected</c:if>>1</option><option value="2" <c:if test="${o.NODENUMBERCONS == 2}">selected</c:if>>1-N</option><option value="3" <c:if test="${o.NODENUMBERCONS == 3}">selected</c:if>>0-1</option><option value="4" <c:if test="${o.NODENUMBERCONS == 4}">selected</c:if>>0-N</option></select></td>';  		  
		  
		  var nodeTypeCons = tr.insertCell(6);  
		  nodeTypeCons.innerHTML = '<td class="middle"><select name="rspNodeTypeCons" id="rspNodeTypeCons" ><option value="1" <c:if test="${o.NODETYPECONS == 1}">selected</c:if>>String</option><option value="2" <c:if test="${o.NODETYPECONS == 2}">selected</c:if>>Number</option><option value="3" <c:if test="${o.NODETYPECONS == 3}">selected</c:if>>Object</option><option value="4" <c:if test="${o.NODETYPECONS == 4}">selected</c:if>>DATE</option><option value="7" <c:if test="${o.NODETYPECONS == 7}">selected</c:if>>JsonArry</option><option value="8" <c:if test="${o.NODETYPECONS == 8}">selected</c:if>>JSON</option><option value="9" <c:if test="${o.NODETYPECONS == 9}">selected</c:if>>XML</option></select></td>';  		  
		  
		  var nodeType = tr.insertCell(7);  
		  nodeType.innerHTML = '<td class="middle"><select name="rspNodeType" id="rspNodeType" ><option value=1>HEADER</option><option value=2>BODY</option><option value=3>TAIL</option><option value=4>URL</option><option value=6>XML NameSpace</option><option value=7>Property</option><option value=8>Child Nodes NameSpace</option></select></td>';  
		  
		  var isNeedSign = tr.insertCell(8);  
		  isNeedSign.innerHTML = '<td class="middle"><select name="rspIsNeedSign" id="rspIsNeedSign" ><option value="Y" <c:if test="${o.ISNEEDSIGN == Y}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option><option value="N" <c:if test="${o.ISNEEDSIGN == N}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option></select></td>';  
		  
		  var isNeedCheck = tr.insertCell(9);  
		  isNeedCheck.innerHTML = '<td class="middle"><select name="rspIsNeedCheck" id="rspIsNeedCheck" ><option value="Y" <c:if test="${o.ISNEEDCHECK == Y}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option><option value="N" <c:if test="${o.ISNEEDCHECK == N}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option></select></td>';  
		  
		  var nevlConsType = tr.insertCell(10);  
		  nevlConsType.innerHTML = '<td class="middle" style="margin:0;padding:0;"><select name="rspNevlConsType" id="rspNevlConsType" onchange="selectRspMainData(this)"><c:forEach var="obj" items="${nevlConsTypeList}" varStatus="n"><option value="${obj.CEPVALUES}" >${obj.CEPNAME}</option></c:forEach></select></td>';  
		  
		  var nevlConsValue = tr.insertCell(11);  
		  nevlConsValue.innerHTML = '<td class="middle"><input type="text" name="rspNevlConsValue" id="rspNevlConsValue" class="box1" size="40"/></td>';
		  
		  var javafieldStr = tr.insertCell(12);//optionReqStr
		  javafieldStr.innerHTML = '<td class="middle"><select name="rspJavaField" id="rspJavaField">'+optionRspStr+'</select></td>';
		  
		  var fuzzy = tr.insertCell(13);
		  fuzzy.innerHTML = '<td class="middle"><div style="width:290px;"><input type="text" name="rspFuzzy" id="rspFuzzy" value="" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/>'
		  +'<input id="rspFuzzyId" name="rspFuzzyId" type="hidden" value="" />'
		  +'<a style="cursor:pointer"  onclick="javascript:selectFuzzy(this,\'rsp\');"  onmouseover="this.style.color=\'#FF0000\'"  onmouseout="this.style.color=\'\'" ><s:property value="%{getText('eaap.op2.conf.prov.choose')}" /></a>&nbsp;&nbsp;&nbsp;'
		  +'<a style="cursor:pointer"  onclick="javascript:clearFuzzy(this,\'rsp\');"  onmouseover="this.style.color=\'#FF0000\'"  onmouseout="this.style.color=\'\'" ><s:property value="%{getText('eaap.op2.conf.process.fuzzyClear')}" /></a>'
		  +'</div></td>';
		  
		  var desStr = tr.insertCell(14);
		  desStr.innerHTML = '<td class="middle"><input type="text" name="rspDescValue" id="rspDescValue" class="box1" size="40"/></td>';
		  
		  var delBtn = tr.insertCell(15);
		  delBtn.innerHTML = '<td class="middle"><div style="width:90px; text-align:center;"><a herf="#" onclick="saveRspNode(this)" style="cursor:pointer" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.save')}" /></a>&nbsp;&nbsp;&nbsp;'
		                   + '<a herf="#" onclick="delRspNode(this)" style="cursor:pointer" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.delete')}" /></a></div></td>';
		  //var mainBtn = tr.insertCell(14);
		 //mainBtn.innerHTML = '<td class="middle"><div id="rspMain" ><a onclick="javascript:selectRspWin()"  style="cursor:hand" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.mainData')}" /></a></div></td>';	
		  
		  changeTopScrollHeight();
		  
		 // selectRspMainData();
		}  
		
		function saveRspNode(btn) {  
			var tr = btn.parentElement.parentElement.parentElement;
			if (checkRspNodeDesc(tr)) {
			    var rspNodeDescName = "", rspNodeDescCode = "", rspNodeDescId = "", rspNodePath = "", rspNodeLengthCons = "";
			    var rspNodeNumberCons = "", rspNodeTypeCons = "", rspNodeType = "", rspIsNeedSign = "";
			    var rspIsNeedCheck = "", rspNevlConsType = "", rspNevlConsValue = "", rspJavaField = "",rspParentNodeId ="";
			    var rspNodeFuzzyId = "",rspFuzzyId = "";
				var json = [];
				for (var i=0; i < tr.cells.length;i++) {
					for (var j=0; j < tr.cells[i].children.length; j++) {
						var tdId = tr.cells[i].children[j].name;
						switch (tdId)
						{
						case "rspNodeDescName":
							rspNodeDescName=tr.cells[i].children[j].value;
							json.push({"nodeName":rspNodeDescName});
						  	break;
						case "rspNodeDescCode":
							rspNodeDescCode=tr.cells[i].children[j].value;
							json.push({"nodeCode":rspNodeDescCode});
						  	break;
						case "rspNodeDescId":
							rspNodeDescId=tr.cells[i].children[j].value;
							json.push({"nodeDescId":rspNodeDescId});
						  	break;
						case "rspNodeFuzzyId":
							rspNodeFuzzyId=tr.cells[i].children[j].value;
							json.push({"reqNodeFuzzyId":rspNodeFuzzyId});
						  	break;
						case "rspNodePath":
							rspNodePath=tr.cells[i].children[j].value;
							json.push({"nodePath":rspNodePath});
						  	break;
						case "rspNodeLengthCons":
							rspNodeLengthCons=tr.cells[i].children[j].value;
							json.push({"nodeLengthCons":rspNodeLengthCons});
						 	break;
						case "rspNodeNumberCons":
							rspNodeNumberCons=tr.cells[i].children[j].value;
							json.push({"nodeNumberCons":rspNodeNumberCons});
						 	break;
						case "rspNodeTypeCons":
							rspNodeTypeCons=tr.cells[i].children[j].value;
							json.push({"nodeTypeCons":rspNodeTypeCons});
						 	break;
						case "rspNodeType":
							rspNodeType=tr.cells[i].children[j].value;
							json.push({"nodeType":rspNodeType});
						  	break;
						case "rspIsNeedSign":
							rspIsNeedSign=tr.cells[i].children[j].value;
							json.push({"isNeedSign":rspIsNeedSign});
							break;
						case "rspIsNeedCheck":
							rspIsNeedCheck=tr.cells[i].children[j].value;
							json.push({"isNeedCheck":rspIsNeedCheck});
						  	break;
						case "rspNevlConsType":
							rspNevlConsType=tr.cells[i].children[j].value;
							json.push({"nevlConsType":rspNevlConsType});
						  	break;
						case "rspNevlConsValue":
							rspNevlConsValue=tr.cells[i].children[j].value;
							json.push({"nevlConsValue":rspNevlConsValue});
						  	break;
						case "rspJavaField":
							rspJavaField=tr.cells[i].children[j].value;
							json.push({"javaField":rspJavaField});
						  	break;
						  	/*
						case "rspParentNodeId":
							rspParentNodeId=tr.cells[i].children[j].value;
							json.push({"parentNodeId":rspParentNodeId});
						  	break;
						  	*/
						case "rspDescValue":
							 rspDescValue=tr.cells[i].children[j].value;
							 json.push({"descValue":rspDescValue});
							 break;
						}

						if(tr.cells[i].children[0].children.length > 0){
							for (var k=0; k < tr.cells[i].children[0].children.length; k++) {
								var cTdId = tr.cells[i].children[0].children[k].name;
								switch (cTdId){
									case "rspParentNodeId":
										rspParentNodeId=tr.cells[i].children[0].children[k].value;
										json.push({"parentNodeId":rspParentNodeId});
									  	break;
									case "rspNevlConsValue":
										rspNevlConsValue=tr.cells[i].children[0].children[k].value;
										json.push({"nevlConsValue":rspNevlConsValue});
									  	break;
									case "rspFuzzyId":
										rspFuzzyId=tr.cells[i].children[0].children[k].value;
										json.push({"reqFuzzyId":rspFuzzyId});
									  	break;
								}
							}
						}
					}
				}
				
				json.push({"tcpCtrFId" : $('#rspContractFormatId').val()});
				json.push({"contractVersionId" : $('#contractVersionId').val()});
				json.push({"conType" : $('#rspConType').val()});
				json.push({"xsdHeaderFor" : $('#rspXsdHeaderFor').val()});
				json.push({"xsdFormat" : $('#rspXsdFormat').val()});
				json.push({"descriptor" : $('#rspDescriptor').val()});
			  	$.ajax({
					type: "POST",
					async:true,
				    url: "../contractManager/saveContract.shtml",
				    dataType:'json',
				    data:{jsonString: JSON.stringify(json)},
					success:function(msg){
						alert('<s:property value="%{getText('eaap.op2.conf.prov.saveNodeSuccess')}" />');
						$('#rspContractFormatId').val(msg.tcpCtrFId);
						tr.cells[0].children[1].value=msg.nodeDescId;
						tr.cells[0].children[2].value=msg.reqNodeFuzzyId;
		              }
		         });
			}
		}
		
		function delRspNode(btn) {  
			if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />")) {
				  var tr = btn.parentElement.parentElement.parentElement;  
				  var tbl = tr.parentElement;
				  var rspNodeDescId = "";
				  for (var i=0; i < tr.cells[0].children.length; i++) {
					  if (tr.cells[0].children[i].id == "rspNodeDescId") {
						  rspNodeDescId = tr.cells[0].children[i].value;
					  }
				  }
				  $.ajax({
						type: "POST",
						async:true,
					    url: "../contractManager/delContract.shtml",
					    dataType:'json',
					    data:{nodeDescId: rspNodeDescId},
						success:function(msg){
							if(msg.success == 0) {
								alert('<s:property value="%{getText('eaap.op2.conf.prov.delNodeSuccess')}" />');
								if (navigator.userAgent.indexOf("MSIE 8.0")>0||navigator.userAgent.indexOf("MSIE 7.0")>0||navigator.userAgent.indexOf("MSIE 6.0")>0)
									tbl.deleteRow(tr.rowIndex-1);
								else if(navigator.userAgent.toUpperCase().indexOf("FIREFOX") >0 ||
										window.navigator.userAgent.toUpperCase().indexOf("CHROME")>0) tr.remove();
								else tr.removeNode(true);
							} else {
								alert('<s:property value="%{getText('eaap.op2.conf.prov.isMapperExit')}" />');
							}
			              }
			         });
				 // tbl.deleteRow(tr.rowIndex-1);  
			}
		}	
		
		function selectReqMainData(selObj){
	         if(selObj.value == 3 ){	//ä¸»æ°æ®
 				var tr = selObj.parentElement.parentElement;
				var nevlConsValue = tr.cells[11];  
		  		nevlConsValue.innerHTML = '<td class="middle"><div style="width:250px;"><input type="text" name="reqMdtName" id="reqMdtName" value="" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/><input id="reqNevlConsValue" name="reqNevlConsValue" type="hidden" value="" /><a style="cursor:pointer"  onclick="chooseMasterData(this,\'req\');"  onmouseover="this.style.color=\'#FF0000\';"  onmouseout="this.style.color=\'\';" >'+chooseText+'</a></div></td>';
	     	 }else{
	     	 	var tr = selObj.parentElement.parentElement;
				var nevlConsValue = tr.cells[11];
		  		nevlConsValue.innerHTML = '<td class="middle"><input type="text" name="reqNevlConsValue" id="reqNevlConsValue" value="" class="box1" size="40"/></td>';
	     	 }
		}
		
		function selectReqWin(){
 			openWindows('${contextPath}/mgr/showMainDataTypeList.shtml?reqRsp=req','');
 		}
 		
		function selectRspMainData(selObj){
	         if(selObj.value == 3 ){	//ä¸»æ°æ®
 				var tr = selObj.parentElement.parentElement;
				var nevlConsValue = tr.cells[11];  
		  		nevlConsValue.innerHTML = '<td class="middle"><div style="width:250px;"><input type="text" name="rspMdtName" id="rspMdtName" value="" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/><input id="rspNevlConsValue" name="rspNevlConsValue" type="hidden" value="" /><a style="cursor:pointer"  onclick="chooseMasterData(this,\'rsp\');"  onmouseover="this.style.color=\'#FF0000\';"  onmouseout="this.style.color=\'\';" >'+chooseText+'</a></div></td>';
	     	 }else{
	     	 	var tr = selObj.parentElement.parentElement;
				var nevlConsValue = tr.cells[11];
		  		nevlConsValue.innerHTML = '<td class="middle"><input type="text" name="rspNevlConsValue" id="rspNevlConsValue" value="" class="box1" size="40"/></td>';
	     	 }
		}
		
 		function selectRspMainData_bak(){
		   var rsp = document.getElementsByName('rspNevlConsType');
		   var rspMain = document.getElementsByName('rspMain');
		   var consValue = document.getElementsByName('rspNevlConsValue');
		       for( i = 0; i < rsp.length; i++) {
		         if(rsp[i].value == 3){
					rspMain[i].style.display = "block";
					//consValue[i].disabled=true;
		     	 }
		     	 else{
		     	 	rspMain[i].style.display = "none";
		     	 	//consValue[i].disabled=false;
		     	 } 	  
			   }
		  	}
		function selectRspWin(){
 			//document.getElementById('iframe_contract').src="../mgr/showMainDataTypeList.shtml?reqRsp=rsp";$('#opendialog').window('open');
 			openWindows('${contextPath}/mgr/showMainDataTypeList.shtml?reqRsp=rsp','');
 		}
		//Close the window is called,This a Function is not This Page
		function closeWin(){
 			$('#opendialog').window('close');
 		}		

 		
 		function downDoc(){
 			var docid =document.getElementById("DocId").value;
 			window.location="${contextPath}/fileShare/downloadFile.shtml?contentType=doc&fileShare.sFileId="+docid;
 		}
 		
 		function listTelescopic(listObj){
	 		if (listObj.height() == "200") {
 				listObj.css('height','100%');
	        }else{
 				listObj.css('height','200px');
	        }
 		}
		
 		function addOnclick(){
 			$('ul[class=tabs]>li').attr("onclick","resetHight();");
 		}
 		
 		function resetHight(){
 			changeTopScrollHeight();
 		}
 		function openChooseNode(obtn,reqRspFlag){
 			var tr = obtn.parentElement.parentElement.parentElement;
 			var tcpCtrFId = $('#' + reqRspFlag + 'ContractFormatId').val()
 			var opTitle = '<s:property value="%{getText('eaap.op2.conf.prov.chooseNode')}" />';
 			openWindows_lock('${contextPath}/contractManager/showNodeDesc.shtml?tcpCtrFId=' + tcpCtrFId + '&nodeDescId=' + tr.cells[0].children[1].value + '&rowIndex=' + tr.rowIndex + '&reqRspFlag=' + reqRspFlag, opTitle, 900,550,false);
 		}
 		
 		function setParentNodeInfo(rowIndex,nodeDescName,nodeDescId,reqRspFlag){
 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[2].children[0].children[0].value=nodeDescName;
 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[2].children[0].children[1].value=nodeDescId;
 			changeTopScrollHeight();
 		}
 		 		
 		function checkReqNodeDesc(tr) {
 			for (var i=0; i < tr.cells.length;i++) {
				for (var j=0; j < tr.cells[i].children.length; j++) {
					var tdId = tr.cells[i].children[j].name;
					switch (tdId)
					{
					case "reqNodeDescName":
						//if (tr.cells[i].children[j].value.length > 50 || tr.cells[i].children[j].value.length < 1){
							//alert('<s:property value="%{getText('eaap.op2.conf.prov.char1to50')}" />');
							//tr.cells[i].children[0].focus();
							//return false;
						//}
					  	break;
					case "reqNodePath":
						if (tr.cells[i].children[j].value.length > 500){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char200')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					  	break;
					case "reqNodeLengthCons":
						if (tr.cells[i].children[j].value.length > 20){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char20')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					 	break;
					case "reqNevlConsValue":
						if (tr.cells[i].children[j].value.length > 500){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char500')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					  	break;
					case "reqJavaField":
						if (tr.cells[i].children[j].value.length > 30){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char30')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					  	break;
					}
				}
			}
 		  return true;
 		}
 		
 		function checkRspNodeDesc(tr) {
 			for (var i=0; i < tr.cells.length;i++) {
				for (var j=0; j < tr.cells[i].children.length; j++) {
					var tdId = tr.cells[i].children[j].name;
					switch (tdId)
					{
					case "rspNodeDescName":
						//if (tr.cells[i].children[j].value.length > 50 || tr.cells[i].children[j].value.length < 1){
							//alert('<s:property value="%{getText('eaap.op2.conf.prov.char1to50')}" />');
							//tr.cells[i].children[0].focus();
							//return false;
						//}
					  	break;
					case "rspNodePath":
						if (tr.cells[i].children[j].value.length > 200){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char200')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					  	break;
					case "rspNodeLengthCons":
						if (tr.cells[i].children[j].value.length > 20){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char20')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					 	break;
					case "rspNevlConsValue":
						if (tr.cells[i].children[j].value.length > 500){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char500')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					  	break;
					case "rspJavaField":
						if (tr.cells[i].children[j].value.length > 30){
							alert('<s:property value="%{getText('eaap.op2.conf.prov.char30')}" />');
							tr.cells[i].children[0].focus();
							return false;
						}
					  	break;
					}
				}
			}
 		  return true;
 		}
 		function importBodyXml(value){
 			var sure = '<s:property value="%{getText('eaap.op2.conf.contract.doc.sureImport')}" />';
 			if(confirm(sure)){
 				var reqXsdFormat = '';
 				var formatType = '';
 				var headerFor = '';
 				var demo = '';
 				if('REQ'==value){
 					reqXsdFormat  =  $('#reqXsdFormat').val();
 					formatType = $('#reqConType').val();
 					headerFor = $('#reqXsdHeaderFor').val();
 					demo = $('#reqDescriptor').val(); 
 				}else if('RSP'==value){
 					reqXsdFormat  =  $('#rspXsdFormat').val();
 					formatType = $('#rspConType').val();
 					headerFor = $('#rspXsdHeaderFor').val();
 					demo = $('#rspDescriptor').val(); 
 				}
 				var name = '<s:property value="%{getText('eaap.op2.conf.prov.contractBodyFormat')}" />';
 				if(''  ==  reqXsdFormat){
 					alert(name +'<s:property value="%{getText('eaap.op2.conf.contract.doc.isNotNull')}" />');
 					return;
 				}else{
 					var url = "${contextPath}/contractManager/importDate.shtml";//xml
 					if("2" == formatType){//json
 						url = "${contextPath}/contractManager/importJsonDate.shtml";
 					}
 					if('REQ'==value){
 						$('#importReq').hide();
 						$('#importReqWaite').show();
 					}else{
 						$('#importRsp').hide();
 						$('#importRspWaite').show();
 					}
 					//import date   
 	 				$.ajax({
 	 					type: "POST",
 	 					async:true,
 	 				    url: url,
 	 				    dataType:'json',
 	 				    data:{contractVersionId:${contractDefined.contractVersionId},reqXsdFormat:reqXsdFormat,req_rsp:value,formatType:formatType,headerFor:headerFor,demo:demo},
 	 					success:function(msg){ 
 	 					     if("success"== msg.message){
 	 					    	reflashPage();
 	 					     }else{
 	 					    	 alert('<s:property value="%{getText('eaap.op2.conf.contract.doc.importFail')}" />'+":"+msg.message);
 	 					     }
 	 		              }
 	 		         });
 				}
 			}	
		}
 		function reflashPage(){
 			var form = document.getElementById("contractManagerForm");
 			form.action="${contextPath}/contractManager/jumpThisPage.shtml?contractVersionId=" + ${contractDefined.contractVersionId} + '&contractId=' + ${contractDefined.contractId};
		    form.submit();
 		}
 		
 		function chooseMasterData(obtn,reqRspFlag){
 			var mdtNameObj = obtn.previousSibling.previousSibling;
 			//var mdtNameObj = $(obtn).
 			if(mdtNameObj !=null && mdtNameObj.id == reqRspFlag+"MdtName"){
     				$(mdtNameObj).attr("isSelect","true");
     		}
 			//var tr = obtn.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement;
 			var tr = obtn.parentElement.parentElement.parentElement;
 			var opTitle = 'Choose Master Data';
 			openWindows_lock('${contextPath}/mgr/showMainDataTypeList.shtml?isChoosePage=true&rowIndex=' + tr.rowIndex + '&reqRspFlag=' + reqRspFlag, opTitle,1100,500,false);
 		}
 		
 		function selectFuzzy(obtn,reqRspFlag){
 			var opTitle = 'Choose Fuzzy Configuration';
 			var tr = obtn.parentElement.parentElement.parentElement;
 			openWindows_lock('${contextPath}/operatorlog/showhideprocess.shtml?rowIndex=' + tr.rowIndex + '&reqRspFlag=' + reqRspFlag, opTitle,1100,500,false);
 		}
 		function clearFuzzy(obtn,reqRspFlag){
 			var tr = obtn.parentElement.parentElement.parentElement;
 			var rowIndex = tr.rowIndex;
 			if($('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1] != undefined){
	 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[13].children[0].children[0].value='';
	 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[13].children[0].children[1].value='';
			}
 		}
 		function setFuzzyDate(rowIndex,fuzzyValue,fuzzyId,reqRspFlag){
 			if($('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1] != undefined){
	 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[13].children[0].children[0].value=fuzzyValue;
	 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[13].children[0].children[1].value=fuzzyId;
			}
 		}
 		function setMasterData(rowIndex,nodeDescName,nodeDescId,reqRspFlag){
 			if($('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1] != undefined){
		 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[11].children[0].children[0].value=nodeDescName;
		 			$('table[id=' + reqRspFlag + 'NodeDesc]>tbody>tr')[rowIndex-1].cells[11].children[0].children[1].value=nodeDescId;
 			}else{
					var mdtNames = document.getElementsByName(reqRspFlag+'MdtName');
	         		for( m = 0; m < mdtNames.length; m++) {
	         			var mdtNameObj = mdtNames[m];
		         		if($(mdtNameObj).attr("isSelect")=="true"){
		           			mdtNameObj.value=nodeDescName;
		           			var vObj = mdtNameObj.nextElementSibling;
		           			if(vObj !=null && vObj.id==reqRspFlag+"NevlConsValue"){
		           				vObj.value = nodeDescId;
		           			}
		           			$(mdtNameObj).attr("isSelect","false");
		         		}
	         		}
	         }	
 		}
 		
 		$(document).ready(function(){
 			setTimeout('addOnclick()', 1000);
 			setTimeout('changeTopScrollHeight()', 1000);
 			//request javafield
 			optionReqStr = '<option value""></option><c:forEach var="obj" items="${listJavaFieldReq}" varStatus="listfield"><option value="${obj.CEP_VALUES}">${obj.CEP_VALUES}</option></c:forEach>';
 			optionRspStr = '<option value""></option><c:forEach var="obj" items="${listJavaFieldRsp}" varStatus="listfield"><option value="${obj.CEP_VALUES}">${obj.CEP_VALUES}</option></c:forEach>';
			
			var jsonStr = ${contractAttrSpec};
			ContractAttrSpecJson = eval(jsonStr);
			loadContractAttrSpec("REQ", "${contractDefined.reqConType}");
			loadContractAttrSpec("RSP", "${contractDefined.rspConType}");
			loadTemplateHeader();
		});
		
		function loadContractAttrSpec(_reqRsp, conType){
			var divObj = $("#"+_reqRsp+"_ContractAttrSpec");
			divObj.html("");
			for(var i=0; ContractAttrSpecJson.length>i; i++){
				var reqRsp = ContractAttrSpecJson[i].REQ_RSP;
				var contractAttrSpecList = ContractAttrSpecJson[i].CONTRACT_ATTR_SPEC;
				if(reqRsp==_reqRsp){
					for(var j=0; contractAttrSpecList.length>j; j++){
						var maindId 	= contractAttrSpecList[j].MAIND_ID;
						var cepValues	= contractAttrSpecList[j].CEP_VALUES;
						var specMainDataList = contractAttrSpecList[j].MAIN_DATA;
						if(cepValues ==conType){
							loadContractAttrSpecHtml(specMainDataList, divObj, maindId, reqRsp,"ContractAttrSpecJson["+i+"].CONTRACT_ATTR_SPEC["+j+"].MAIN_DATA");
							break;
						}
					}
				}
			}
		  	changeTopScrollHeight();
		}
		
		function loadContractAttrSpecHtml(specMainDataList, divObj, maindId, reqRsp, nodePath){
			var tableHtml="<table class=\"mgr-table\" >";
			for(var i=0; specMainDataList.length>i; i++){
				var attr_spec_id 		= specMainDataList[i].ATTR_SPEC_ID;
				var attr_spec_name= specMainDataList[i].ATTR_SPEC_NAME;
				var attr_spec_code = specMainDataList[i].ATTR_SPEC_CODE;
				var nullable 			= specMainDataList[i].NULLABLE;
				var value 				= specMainDataList[i].VALUE;
				tableHtml+="<tr>";
				tableHtml+="<td align=\"right\" width=\"15%\">"+attr_spec_name+":</td>";
				tableHtml+="<td><input type=\"text\" name=\""+reqRsp+"_"+attr_spec_name+"\"  id=\""+reqRsp+"_"+attr_spec_name+"\" nodePath=\""+nodePath+"["+i+"]\"   code=\""+attr_spec_code+"\"  maindId=\""+maindId+"\"  reqRsp=\""+reqRsp+"\"  value=\""+value+"\" onblur=\"changeNodeValue()\"  class=\"box1\" style=\"width:800px;\"/>";
				if(nullable=="N"){ 
					//æ¯å¦å¯ç©ºãY/N
					tableHtml+="<font color=\"red\">*</font>";
				}
				tableHtml+="</td></tr>";
			}
			tableHtml+="</table>";
			divObj.html(tableHtml);
		}
		
		function changeNodeValue(){
			obj = event.srcElement;
			var nodePathAtt = obj.attributes['nodePath'];
			if(nodePathAtt != undefined){
				var vNodePath 	= obj.attributes['nodePath'].value+".VALUE";
				var dvNodePath	= obj.attributes['nodePath'].value+".DEFAULT_VALUE";
				var objValue 	= obj.value;
				try {
					eval(vNodePath+"=\""+objValue+"\"");
					eval(dvNodePath+"=\""+objValue+"\"");
				} catch (e) { 
				}
			}
		}				
		
		function templateDefModeChange(){
			if($("#templateDefMode").val() =="0"){
				//Default
				$("#defaultDiv").show();
				$("#referencesTemplateBut").show();
				$("#rspXsdExceptionDiv").hide();
				$("#oldModDesc").hide();
			}else{
				$("#defaultDiv").hide();
				$("#referencesTemplateBut").hide();
				$("#rspXsdExceptionDiv").show();
				$("#oldModDesc").show();
			}
		}
		
		function delExpHead(headObj){
			$(headObj).parent().remove();
	  		//var expList = $("input[id=headName]");
	  		//if(expList.length==0){
	  		//	addExpHead($("#addExpHeadBut"));
	  		//}
		}
		
		function addExpHead(addBut,nameVal,valueVal){
		  var inHtml   ="<div  class=\"headRow\" style=\"float:left; width:700px; height:26px; border-bottom:1px dashed #E5E5E5; margin:0; padding: 1px 0;\">";
  				inHtml +="<div style=\"float:left; width:85px; line-height:25px; text-align:center;\"><font color=\"red\">*</font>Name:</div>";
  				inHtml +="<div style=\"float:left; width:250px; line-height:25px; border:1px solid #ccc;\">";
	  		    inHtml +="		<input name=\"headName\"  id=\"headName\" value=\""+nameVal+"\" style=\"width:100%; height:24px;  line-height:25px; border-width:0;\"/>";
	  		    inHtml +="</div>";
  				inHtml +="<div style=\"float:left; width:80px; line-height:25px; text-align:center;\"><font color=\"red\">*</font>Value:</div>";
  				inHtml +="<div style=\"float:left; width:250px; line-height:25px; border:1px solid #ccc;\">";
	  		    inHtml +="		<input name=\"headValue\"  id=\"headValue\" value=\""+valueVal+"\" style=\"width:100%; height:24px;  line-height:25px; border-width:0;\"/>";
	  		    inHtml +="</div>";
	  		    inHtml +="<div title=\"Delete\" onclick=\"delExpHead(this)\"  style=\"float:left; width:25px; height:24px; line-height:21px; text-align:center; border:1px solid #ccc; font-size:17px; cursor:pointer; color:#2A66F5; margin-left:3px; background-color:#F6FBFD;\"  onmouseover=\"this.style.color='#FF0000';this.style.borderColor='#FF0000';\"  onmouseout=\"this.style.color='#2A66F5';this.style.borderColor='#ccc';\">x</div>";
	  		    inHtml +="</div>";
	  		$(addBut).before(inHtml);
		}
		
		function setTemplateHeader(){
			if($("#templateDefMode").val() == "0"){
				var headList = $("#expHeadDiv").find(".headRow");
				var nv = "";
	            headList.each(function(){
					var hName ="";
					var hValue ="";
	            	if($(this).find("#headName") != null){
	    				hName = $(this).find("#headName").val();
	    				if(hName==""){
	    					//$(this).find("#headName").focus();
	    					return;
	    				}
	            	}
	            	if($(this).find("#headValue") != null){
	            		hValue = $(this).find("#headValue").val();
	    				if(hValue==""){
	    					//$(this).find("#headValue").focus();
	    					return;
	    				}
	            	}
					if(nv==""){
			            nv +='"'+hName+'":"'+hValue+'"';
					}else{
			            nv +=',"'+hName+'":"'+hValue+'"';
					}
	            });
				if(nv !==""){
					var headJson="[{"+nv+"}]";
					$("#templateHeader").val(headJson);
				}else{
					$("#templateHeader").val("");
				}
			}
		}
		
		function loadTemplateHeader(){
			$("#expHeadDiv").html("<div title=\"Add\"  id=\"addExpHeadBut\"  onclick=\"addExpHead(this,'','')\" style=\"float:left; width:25px; height:24px; line-height:22px; margin:1px 0 0 3px; text-align:center; border:1px solid #ccc; font-size:17px; cursor:pointer; color:#2A66F5; background-color:#F6FBFD;\"  onmouseover=\"this.style.color='#FF0000';this.style.borderColor='#FF0000';\"  onmouseout=\"this.style.color='#2A66F5';this.style.borderColor='#ccc';\">+</div>");  
			var tHead	= $("#templateHeader").val();
			if(tHead !=""){
				var tHeadJson=JSON.parse(tHead);
				var obj = tHeadJson[0];
				var size = 0
				var key;
				for (key in obj) {
				 	if (obj.hasOwnProperty(key)){
				 		var val = eval("obj."+key);
				 		addExpHead($("#addExpHeadBut"),key,val)
				 	}
				}
			}
		}
		
		function referencesTemplate(){
			$("#expHeadDiv").html("<div title=\"Add\"  id=\"addExpHeadBut\"  onclick=\"addExpHead(this,'','')\" style=\"float:left; width:25px; height:24px; line-height:22px; margin:1px 0 0 3px; text-align:center; border:1px solid #ccc; font-size:17px; cursor:pointer; color:#2A66F5; background-color:#F6FBFD;\"  onmouseover=\"this.style.color='#FF0000';this.style.borderColor='#FF0000';\"  onmouseout=\"this.style.color='#2A66F5';this.style.borderColor='#ccc';\">+</div>");  
			var gHead	= $("#globalTemplateHeader").val();
			var gBody	= $("#globalTemplateBody").val();
			if(gBody !=""){
				$("#templateBody").val(gBody);
			}
			if(gHead !=""){
				var gHeadJson=JSON.parse(gHead);
				var obj = gHeadJson[0];
				var size = 0
				var key;
				for (key in obj) {
				 	if (obj.hasOwnProperty(key)){
				 		var val = eval("obj."+key);
				 		addExpHead($("#addExpHeadBut"),key,val)
				 	}
				}
				$("#templateHeader").val(gHead);
			}
		}
		
		function openExpTempHelp(){
 			openWindows('${contextPath}/contractManager/expTempHelp.html','HELP');
		}
		
		function do_operate(title){		
		}
	</script>
</head>
<style>
.tableCss{border-collapse:collapse; border-width:0; margin:0; padding:0;}
.tableCss td{border-collapse:collapse; border-width:0; margin:0; padding:0;}
</style>
<!--body start -->
<body>
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.contractManage')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.prov.addContract')}" />
	      	</div>
	    </div> 

<ui:form method="post" id="contractManagerForm" action="addNextContractManager.shtml" >	
<%--
	<c:forEach items="${reqNodeDescList}" var="o" varStatus="n">
		<ui:validators validateAlert="div" validatorGroup="group_req_${n.index+1}">
 			<ui:validator fieldId="reqNodeDescName_${n.index+1}" validatorType="stringlength" required="true" minLength="1" maxLength="25" trim="true" message="%{getText('eaap.op2.conf.prov.char1to50')}"/>	
 			<ui:validator fieldId="reqNodePath_${n.index+1}" validatorType="stringlength" required="false" minLength="0" maxLength="200" trim="true" message="%{getText('eaap.op2.conf.prov.char200')}"/>
 			<ui:validator fieldId="reqNodeLengthCons_${n.index+1}" validatorType="stringlength" required="false" minLength="0" maxLength="20" trim="true" message="%{getText('eaap.op2.conf.prov.char20')}"/>
 			<ui:validator fieldId="reqNevlConsValue_${n.index+1}" validatorType="stringlength" required="false" minLength="0" maxLength="500" trim="true" message="%{getText('eaap.op2.conf.prov.char500')}"/>
 			<ui:validator fieldId="reqJavaField_${n.index+1}" validatorType="stringlength" required="false" minLength="0" maxLength="30" trim="true" message="%{getText('eaap.op2.conf.prov.char30')}"/>
		</ui:validators>	
	</c:forEach>
--%>
	<div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.contractInfo')}" />
         		</div>       
    	   </div>
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.portal.prov.contractName')}" />:</td>
	   			<td width="40%">
	  			  ${contractDefined.name}
	  				<input type="hidden" name="contractDefined.contractId" id="contractId" value="${contractDefined.contractId}" />
	  				<input type="hidden" name="contractDefined.contractVersionId" id="contractVersionId" value="${contractDefined.contractVersionId}"/>	
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" />:</td>
	  			<td >
	  			  ${contractDefined.code}	  				
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.portal.prov.contractBasic')}" />:</td>
	   			<td >
	  			  ${contractDefined.baseContractName}	
	   			</td>
	   			<td align="right" ></td>
	   			<td ></td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan=3>
	  				${contractDefined.contractDescriptor}																					
	   			</td>
		   		</tr>		   		
		    </table>
	  	</div>
	  	
<ui:tabpage  skin="${contextStyleTheme}" id="contractManagerTab"  loadMode="ajax"  onSelect="true" >
	
	 
	<ui:tabpagediv  id="contractInfo"  title="%{getText('eaap.op2.conf.prov.contractVersionReq')}"  closable="false" >
	  		<div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.contractVersionReq')}" />
         		</div>       
    	    </div>
		 	<table class="mgr-table" >
			<tr>
	   			<td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prov.contractFormatType')}" />:</td>
	   			<td >
	   			 <span style="display:none;"><ui:select name="temp"  id="temp"  emptyOption="false"   list="conTypeList"   listKey="CEPVALUES"  listValue="CEPNAME"  skin="${contextStyleTheme}"></ui:select></span> 
	   			 <ui:select  
	    				name="contractDefined.reqConType" 
	    				id="reqConType"   
	    				emptyOption="false" 
	    				headerValue=""
	    			    list="conTypeList" 
	    			    listKey="CEPVALUES" 
	    			    listValue="CEPNAME" 
	    			    value="${contractDefined.reqConType}" 
	    			    skin="${contextStyleTheme}"
	    			    onchange="loadContractAttrSpec('REQ', this.value)"
	    			  >
    			    </ui:select> 
    			    <input type="hidden" name="contractDefined.reqContractFormatId" id="reqContractFormatId" value="${contractDefined.reqContractFormatId}"/>  			
				</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.contractHeaderFormat')}" />:</td>
	   			<td >
	   				<ui:textarea id="reqXsdHeaderFor" name="contractDefined.reqXsdHeaderFor" skin="${contextStyleTheme}" width="800" height="80" value="${contractDefined.reqXsdHeaderFor}"/>																					
	   			</td>
		   	</tr>	
		   		<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.contractBodyFormat')}" />:</td>
	   			<td >
	  				<ui:textarea id="reqXsdFormat" name="contractDefined.reqXsdFormat" skin="${contextStyleTheme}" width="800" height="80" value="${contractDefined.reqXsdFormat}"/>	
	  				<div align="center" id="importReq">
	  				<ui:button text="Import" skin="${contextStyleTheme}" id="checksubmitId" shape="s" onclick="javascript:importBodyXml('REQ');"/>
	  				</div>
	  				<div align="center" id="importReqWaite" style="display:none;">
	  				   <img src="${contextPath}/resource/img/load.gif" alt="" />
	  				</div>																			   			
	   			</td>
		   	</tr>
		   		<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td >
	   			<ui:textarea id="reqDescriptor" name="contractDefined.reqDescriptor" skin="${contextStyleTheme}" width="800" height="50" value="${contractDefined.reqDescriptor}"/>																						
	   			</td>
		   	</tr>
		    </table>
		    <div id="REQ_ContractAttrSpec"></div>
		   <div class="accordion-header" >
	   			<div class="accordion-header-text">
	   				<span style="float:left;">
	   					<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
	         			<s:property value="%{getText('eaap.op2.conf.prov.reqNodeDesc')}" />
	   				</span>
	         		<span style="float:right;">
						<img style="cursor:hand;" src="${contextPath}/resource/blue/images/zTree/2.gif"  onclick="listTelescopic($('#reqNodeDescListDiv'))"/>
					</span>
	        	</div>       
   	    	</div>  
   	    	<div id="reqNodeDescListDiv"  style="overflow:scroll; height:200px; ">   	
		    <table border="1" id="reqNodeDesc" class="t1"> 
		    <thead>  
			  <tr class="a1" >  
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.nodeName')}" /></th>
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.nodeCode')}" /></th>
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.parentNode')}" /></th>  
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.nodePath')}" /></th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.nodeLengthCons')}" /></th>  
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.nodeNumberCons')}" /></th>
				  <th class="middle" width="7%"><s:property value="%{getText('eaap.op2.conf.prov.nodeTypeCons')}" /></th> 
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.nodeType')}" /></th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedSign')}" /></th> 
				  <th class="middle" width="5%"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedCheck')}" /></th>
				  <th class="middle" width="8%"><s:property value="%{getText('eaap.op2.conf.prov.nevlConsType')}" /></th>  
				  <th class="middle" ><s:property value="%{getText('eaap.op2.conf.prov.nevlConsValue')}" /></th> 
				  <th class="middle" width="6%">Java Field</th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.process.fuzzyConf')}" /></th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.description')}" /></th>
				  <th class="middle" width="7%" colspan='2'><s:property value="%{getText('eaap.op2.conf.prov.operator')}" /></th>  					    
			  </tr>   
			</thead>  
	   		<tbody>
			<c:forEach items="${reqNodeDescList}" var="o" varStatus="n">
			  <tr>
			    <td class="middle" >
			    		<input type="text" name="reqNodeDescName" id="reqNodeDescName" value="${o.NODENAME}"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"/>
			    		<input id="reqNodeDescId" name="reqNodeDescId" type="hidden" value="${o.NODEDESCID}"/>
			    		<input id="reqNodeFuzzyId" name="reqNodeFuzzyId" type="hidden" value="${o.NODEFUZZYID}"/>
			    </td>
			    <td class="middle" >
			    		<input type="text" name="reqNodeDescCode" id="reqNodeDescCode" value="${o.NODECODE}"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"/>
			    </td>
			    <td class="middle" >
			    	<div  style="margin:0;padding:0;width:140px;">
	           	        <input type="text" name="reqParentNodeName" id="reqParentNodeName" value="${o.PARENTNODENAME}" disabled="true"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"  style="width:90px;"/>
					    <input id="reqParentNodeId" name="reqParentNodeId" type="hidden" value="${o.PARENTNODEDESCID}"/>
					    <a style="cursor:pointer"  onclick="openChooseNode(this,'req');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" >
					    		<s:property value="%{getText('eaap.op2.conf.prov.choose')}" />
					    </a>
				    </div>
			    </td>
			    <td class="middle"><input type="text" name="reqNodePath" id="reqNodePath" value="${o.NODEPATH}" 
			    class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"/>
			    </td>
			    <td class="middle"><input type="text" name="reqNodeLengthCons" id="reqNodeLengthCons" value="${o.NODELENGTHCONS}" 
			    class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" size="9"/>
			    </td>
			    <td class="middle">
			    <select name="reqNodeNumberCons" id="reqNodeNumberCons" >
			    <option value="1" <c:if test="${o.NODENUMBERCONS == '1'}">selected</c:if>>1</option>
			    <option value="2" <c:if test="${o.NODENUMBERCONS == '2'}">selected</c:if>>1-N</option>
			    <option value="3" <c:if test="${o.NODENUMBERCONS == '3'}">selected</c:if>>0-1</option>
			    <option value="4" <c:if test="${o.NODENUMBERCONS == '4'}">selected</c:if>>0-N</option>
			    </select>
			    </td>
			    <td class="middle">
			    <select name="reqNodeTypeCons" id="reqNodeTypeCons" >
			    <option value="1" <c:if test="${o.NODETYPECONS == '1'}">selected</c:if>>String</option>
			    <option value="2" <c:if test="${o.NODETYPECONS == '2'}">selected</c:if>>Number</option>
			    <option value="3" <c:if test="${o.NODETYPECONS == '3'}">selected</c:if>>Object</option>
			    <option value="4" <c:if test="${o.NODETYPECONS == '4'}">selected</c:if>>DATE</option>
			    <option value="7" <c:if test="${o.NODETYPECONS == '7'}">selected</c:if>>JsonArry</option>
				<option value="8" <c:if test="${o.NODETYPECONS == '8'}">selected</c:if>>JSON</option>
			    <option value="9" <c:if test="${o.NODETYPECONS == '9'}">selected</c:if>>XML</option>
			    </select>
			    </td>
			    <td class="middle">
			    <select name="reqNodeType" id="reqNodeType" >
			    <option value="1" <c:if test="${o.NODETYPE == '1'}">selected</c:if>>Header</option>
			    <option value="2" <c:if test="${o.NODETYPE == '2'}">selected</c:if>>Body</option>
			    <option value="3" <c:if test="${o.NODETYPE == '3'}">selected</c:if>>TAIL</option>
	            <option value="4" <c:if test="${o.NODETYPE == '4'}">selected</c:if>>URL</option>
	            <option value="6" <c:if test="${o.NODETYPE == '6'}">selected</c:if>>XML NameSpace</option>
	            <option value="7" <c:if test="${o.NODETYPE == '7'}">selected</c:if>>Property</option>
	            <option value="8" <c:if test="${o.NODETYPE == '8'}">selected</c:if>>Child Nodes NameSpace</option>
			    </select>
			    </td>
			    <td class="middle">
			    <select name="reqIsNeedSign" id="reqIsNeedSign" >
			    <option value="Y" <c:if test="${o.ISNEEDSIGN == 'Y'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>
			    <option value="N" <c:if test="${o.ISNEEDSIGN == 'N'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>
			    </select>
			    </td>
			    <td class="middle">
			    <select name="reqIsNeedCheck" id="reqIsNeedCheck" >
			    <option value="Y" <c:if test="${o.ISNEEDCHECK == 'Y'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>
			    <option value="N" <c:if test="${o.ISNEEDCHECK == 'N'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>
			    </select>
			    </td>
			    <td class="middle"  style="margin:0;padding:0;">
				    <select name="reqNevlConsType" id="reqNevlConsType" onchange="selectReqMainData(this)"  style="margin:0;padding:0;">
				    <c:forEach var="obj" items="${nevlConsTypeList}" varStatus="vs">
				    <option value="${obj.CEPVALUES}" <c:if test="${obj.CEPVALUES == o.NEVLCONSTYPE}">selected</c:if>>${obj.CEPNAME}</option>
				    </c:forEach>
				    </select>
			    </td>
		  		<td class="middle">
		  			<c:if test="${o.NEVLCONSTYPE != '3'}">
		  				<input type="text" name="reqNevlConsValue" id="reqNevlConsValue" value="${o.NEVLCONSVALUE}"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" size="40"/>
		  			</c:if>
		  			<c:if test="${o.NEVLCONSTYPE == '3'}">
			  			<div style="width:250px;">
				  			<input type="text" name="reqMdtName" id="reqMdtName" value="${o.MDTNAME}" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/>
				  			<input id="reqNevlConsValue" name="reqNevlConsValue" type="hidden" value="${o.NEVLCONSVALUE}" />
				  			<a style="cursor:pointer"  onclick="chooseMasterData(this,'req');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.prov.choose')}" /></a>
			  			</div>
		  			</c:if>
		  		</td>
		  		<td class="middle">
		  			<!-- <input type="text" name="reqJavaField" id="reqJavaField" value="${o.JAVAFIELD}" 
		  			class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" size="11"/> -->
		  			
		  	    <select name="reqJavaField" id="reqJavaField">
		  	    <option value""></option>
			    <c:forEach var="obj" items="${listJavaFieldReq}" varStatus="listfield">
			    <option value="${obj.CEP_VALUES}" <c:if test="${obj.CEP_VALUES == o.JAVAFIELD}">selected</c:if>>${obj.CEP_VALUES}</option>
			    </c:forEach>
			    </select>
		  		</td>
		  		<td class="middle">
		  		   <div style="margin:0;padding:0;width:290px;">
				  			<input type="text" name="reqFuzzy" id="reqFuzzy" value="${o.SHOWVALUE}" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/>
				  			<input id="reqFuzzyId" name="reqFuzzyId" type="hidden" value="${o.REQFUZZYID}" />
				  			<a style="cursor:pointer"  onclick="javascript:selectFuzzy(this,'req');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.prov.choose')}" /></a>
				  			&nbsp;
				  			<a style="cursor:pointer"  onclick="javascript:clearFuzzy(this,'req');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.process.fuzzyClear')}" /></a>
			  	   </div>
		  		</td>
				<td class="middle"><input type="text" name="reqDescValue" id="reqDescValue" value="${o.DESCRIPTION}" class="box1" size="40"/></td>
		  		<td class="middle" size="10">
		  			<div style="width:90px; text-align:center;">
					 	<a style="cursor:pointer"  onclick="saveReqNode(this)"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" >
					    		<s:property value="%{getText('eaap.op2.conf.prov.save')}" />
					    </a>
					    &nbsp;
					    <a style="cursor:pointer"  onclick="delReqNode(this)"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';"  >
					    		<s:property value="%{getText('eaap.op2.conf.prov.delete')}" />
					    </a>
				  	</div>
				</td>
				<%-- 
				<td class="middle">
					<div id="reqMain" >  
				  		<a style="cursor:hand"  onclick="javascript:selectReqWin()"   onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';">
					    		<s:property value="%{getText('eaap.op2.conf.prov.mainData')}" />
					    </a>
				    </div>	 	 
				</td>
				--%>						   
			  </tr>
		    </c:forEach> 
	   		</tbody>
		</table>
			<table  class="t1" style="width: 1953px;">
			<tr>
			    <td class="middle">
			        
			    	<a style="cursor:pointer;"  onclick="addReqNode('reqNodeDesc')"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';"  >
				    		<s:property value="%{getText('eaap.op2.conf.prov.add')}" />
				    </a>
				    &nbsp;&nbsp;&nbsp;&nbsp;
				    <span id="reqSaveAll">
			        <a style="cursor:pointer;"  onclick="javascript:saveAll('REQ',true);"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';"  >
				    		<s:property value="%{getText('eaap.op2.conf.contract.message.savaall')}" />
				    		
				    </a>
				    </span>
				    <span style="display:none;" id="reqLoadSaveAll">
					<img src="${contextPath}/resource/img/load2.gif" alt="" />
					</span>
		  		</td> 	  			   
			</tr>       
			</table>  
		</div>
	</ui:tabpagediv>
	
	<ui:tabpagediv  id="contractVersionRsp"  title="%{getText('eaap.op2.conf.prov.contractVersionRsp')}"  closable="false" >
	  	   <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.contractVersionRsp')}" />
         		</div>       
    	   </div>
		 	<table class="mgr-table" >
		 	<tr>
	   			<td align="right" width="15%"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prov.contractFormatType')}" />:</td>
	   			<td >	
	   				<ui:select  
	    				name="contractDefined.rspConType" 
	    				id="rspConType"   
	    				emptyOption="false" 
	    				headerValue=""
	    			    list="conTypeList" 
	    			    listKey="CEPVALUES" 
	    			    listValue="CEPNAME" 
	    			    value="${contractDefined.rspConType}" 
	    			    skin="${contextStyleTheme}"
	    			    onchange="loadContractAttrSpec('RSP', this.value)"
	    			  >
    			    </ui:select>     			
				<input type="hidden" name="contractDefined.rspContractFormatId" id="rspContractFormatId" value="${contractDefined.rspContractFormatId}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.contractHeaderFormat')}" />:</td>
	   			<td >
	   				<ui:textarea id="rspXsdHeaderFor" skin="${contextStyleTheme}" name="contractDefined.rspXsdHeaderFor" width="800" height="80" value="${contractDefined.rspXsdHeaderFor}"/>	  																								
	   			</td>
		   	</tr>	
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.contractBodyFormat')}" />:</td>
	   			<td >
	   				<ui:textarea id="rspXsdFormat" skin="${contextStyleTheme}" name="contractDefined.rspXsdFormat" width="800" height="80" value="${contractDefined.rspXsdFormat}"/>	
	   				<div align="center" id="importRsp">
	   				<ui:button text="Import" skin="${contextStyleTheme}" id="rspsubmitId" shape="s" onclick="javascript:importBodyXml('RSP');"/>
	   				</div>			
	   				<div align="center" id="importRspWaite" style="display:none;">
	  				   <img src="${contextPath}/resource/img/load.gif" alt="" />
	  				</div>																		
	   			</td>
		   	</tr>
		   		   		
		   	<tr >
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.template')}" />:</td>
	   			<td >
	   				<div  id="configureTempDiv" style="display:ne;">
					 	<table width="820px"  style="border:0px solid #FFFFFF;">
							<tr>
					  			<td style="width:70px;border:0px solid #FFFFFF; background-color:#F5F5F5; text-align:right;"><s:property value="%{getText('eaap.op2.conf.prov.excTempDefMode')}" />:</td>
					  			<td style="border:0px solid #FFFFFF; ">
									<select name="contractDefined.templateDefMode"  id="templateDefMode"  onchange="templateDefModeChange()">
				   				  		<option value="0"  <c:if test="${contractDefined.templateDefMode == null || contractDefined.templateDefMode == '0'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.templateDefModeDef')}" /></option>
				   				  		<option value="1"  <c:if test="${contractDefined.templateDefMode == '1'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.templateDefModeOld')}" /></option>
				   				  	</select>
					   				<a id="referencesTemplateBut"  style="cursor:pointer; <c:if test="${contractDefined.templateDefMode == '1'}">display:none;</c:if>"  onclick="referencesTemplate();"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.prov.referencesTemplate')}" /></a>
					   				<i id="oldModDesc"  style="color:#ccc; <c:if test="${contractDefined.templateDefMode == '0'}">display:none;</c:if>"><s:property value="%{getText('eaap.op2.conf.prov.oldModDesc')}" /></i>
					   				<textarea style="display:none;" name="globalTemplateHeader"  id="globalTemplateHeader">${globalTemplate.templateHeader}</textarea>
					   				<textarea style="display:none;" name="globalTemplateBody"  id="globalTemplateBody">${globalTemplate.templateBody}</textarea>
					   			</td>
					   		</tr>
					    </table>
						<div style=" border-top:1px dashed #E5E5E5; height:0px; line-height:0px; margin:1px 0;"></div>
					   	<div id="defaultDiv"  <c:if test="${contractDefined.templateDefMode == '1'}">style="display:none;"</c:if>>
						 	<table width="820px" >
								<tr>
						  			<td style="width:70px; height:auto; background-color:#F5F5F5;  text-align:right; border-width:0;">HEADER:</td>
						  			<td  style="width:auto; height:auto; border-width:0;" id="headerCon">
					  		    			<div id="expHeadDiv" style="width:730px; height:25px;">
					  		    				<!-- div class="headRow" style="float:left; width:700px; height:26px; border-bottom:1px dashed #E5E5E5; margin:0; padding: 1px 0;">
								  					<div style="float:left; width:85px; line-height:25px; text-align:center;">Name:</div>
								  					<div style="float:left; width:250px; line-height:25px; border:1px solid #ccc;">
									  		    			<input name="headName"  id="headName" value="" style="width:100%; height:24px;  line-height:25px; border-width:0;"/>
									  		    	</div>
								  					<div style="float:left; width:80px; line-height:25px; text-align:center;">Value:</div>
								  					<div style="float:left; width:250px; line-height:25px; border:1px solid #ccc;">
									  		    			<input name="headValue"  id="headValue" value="" style="width:100%; height:24px;  line-height:25px; border-width:0;"/>
									  		    	</div>
									  		    	<div title="Delete" onclick="delExpHead(this)"  style="float:left; width:25px; height:24px; line-height:21px; text-align:center; border:1px solid #ccc; font-size:17px; cursor:pointer; color:#2A66F5; margin-left:3px;"  onmouseover="this.style.color='#FF0000';this.style.borderColor='#FF0000';" onmouseout="this.style.color='#2A66F5';this.style.borderColor='#ccc';">x</div>
									  		    </div -->
									  		    <div title="Add"  id="addExpHeadBut"  onclick="addExpHead(this,'','')" style="float:left; width:25px; height:24px; line-height:22px; margin:1px 0 0 3px; text-align:center; border:1px solid #ccc; font-size:17px; cursor:pointer; color:#2A66F5; background-color:#F6FBFD;"  onmouseover="this.style.color='#FF0000';this.style.borderColor='#FF0000';"  onmouseout="this.style.color='#2A66F5';this.style.borderColor='#ccc';">+</div>
								   			</div>
										   	<textarea style="display:none;" name="contractDefined.templateHeader"  id="templateHeader">${contractDefined.templateHeader}</textarea>
						   			</td>
						   		</tr>
						   	</table>
						   	<div style=" border-top:1px dashed #E5E5E5; height:0px; line-height:0px; margin:1px 0;"></div>
						 	<table width="850px"  style="border:0px solid #FFFFFF;">
								<tr>
						  			<td style="width:70px;border:0px solid #FFFFFF; background-color:#F5F5F5; text-align:right;"><font color="red">*</font>BODY:</td>
						  			<td style="width:722px; border:0px solid #FFFFFF; "> 
							  		    	<ui:textarea name="contractDefined.templateBody"  id="templateBody"  width="722" height="100"  value="${contractDefined.templateBody}" skin="${contextStyleTheme}"/>	
						   			</td>
						   			<td style="border-width:0;" valign="top">
						   				<a  style="cursor:pointer;"  onclick="openExpTempHelp()"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.prov.expTemplateHelp')}" /></a>
						   				<br/><br/>
						   			</td>
						   		</tr>
						    </table>
						   	<div style=" border-top:1px dashed #E5E5E5; height:0px; line-height:0px; margin:1px 0;"></div>
						</div>
					   	<div id="rspXsdExceptionDiv"  <c:if test="${contractDefined.templateDefMode == null || contractDefined.templateDefMode == '0'}">style="display:none;"</c:if>>
						 	<table width="820px"  style="border:0px solid #FFFFFF;">
								<tr>
						  			<td style="width:70px;border:0px solid #FFFFFF; background-color:#F5F5F5; text-align:right;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.prov.template')}" />:</td>
						  			<td style="border:0px solid #FFFFFF; "> 
							  		    	<ui:textarea id="rspXsdException"  name="contractDefined.rspXsdException"  value="${contractDefined.rspXsdException}" width="722" height="100"  skin="${contextStyleTheme}"/>	
						   			</td>
						   		</tr>
						    </table>
							<div style=" border-top:1px dashed #E5E5E5; height:0px; line-height:0px; margin:1px 0;"></div>
						</div>
	   				</div>
	   			</td>
		   	</tr>
	   		
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td >
	   			<ui:textarea id="rspDescriptor" skin="${contextStyleTheme}" name="contractDefined.rspDescriptor" width="800" height="50" value="${contractDefined.rspDescriptor}"/>																					
	   			</td>
		   	</tr>
		</table>
		<div id="RSP_ContractAttrSpec"></div>
		<div class="accordion-header" >
   			<div class="accordion-header-text">
	   				<span style="float:left;">
	   					<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
	         			<s:property value="%{getText('eaap.op2.conf.prov.rspNodeDesc')}" />
	   				</span>
	         		<span style="float:right;">
						<img style="cursor:hand;" src="${contextPath}/resource/blue/images/zTree/2.gif"  onclick="listTelescopic($('#rsqNodeDescListDiv'))"/>
					</span>
        	</div>       
   	    </div>
   	    <div id="rsqNodeDescListDiv" style="overflow:scroll; height:200px; ">
		<table  id="rspNodeDesc" class="t1">
		<thead> 
			  <tr class="a1" >  
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.nodeName')}" /></th>
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.nodeCode')}" /></th>
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.parentNode')}" /></th>  
				  <th class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.prov.nodePath')}" /></th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.nodeLengthCons')}" /></th>  
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.nodeNumberCons')}" /></th>
				  <th class="middle" width="7%"><s:property value="%{getText('eaap.op2.conf.prov.nodeTypeCons')}" /></th> 
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.nodeType')}" /></th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedSign')}" /></th> 
				  <th class="middle" width="5%"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedCheck')}" /></th>
				  <th class="middle" width="8%"><s:property value="%{getText('eaap.op2.conf.prov.nevlConsType')}" /></th>  
				  <th class="middle" ><s:property value="%{getText('eaap.op2.conf.prov.nevlConsValue')}" /></th> 
				  <th class="middle" width="6%">Java Field</th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.process.fuzzyConf')}" /></th>
				  <th class="middle" width="6%"><s:property value="%{getText('eaap.op2.conf.prov.description')}" /></th>
				  <th class="middle" width="7%" colspan='2'><s:property value="%{getText('eaap.op2.conf.prov.operator')}" /></th>  					    
			  </tr>   
	   </thead> 
	   <tbody>
	<c:forEach items="${rspNodeDescList}" var="o" varStatus="n">
	  <tr>
	    <td class="middle" >
		    <input type="text" name="rspNodeDescName" id="rspNodeDescName" value="${o.NODENAME}" onclick="edit('${o.NODENAME}');"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"/>
		    <input id="rspNodeDescId" name="rspNodeDescId" type="hidden" value="${o.NODEDESCID}"/>
		    <input id="rspNodeFuzzyId" name="rspNodeFuzzyId" type="hidden" value="${o.NODEFUZZYID}"/>
	    </td>
	    <td class="middle" >
		    <input type="text" name="rspNodeDescCode" id="rspNodeDescCode" value="${o.NODECODE}" onclick="edit('${o.NODECODE}');"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"/>
	    </td>
		<td class="middle">
			 <div  style="margin:0;padding:0;width:140px;">
	        	<input type="text" name="rspParentNodeName" id="rspParentNodeName" value="${o.PARENTNODENAME}" disabled="true"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" style="width:90px;"/>
			    <input id="rspParentNodeId" name="rspParentNodeId" type="hidden" value="${o.PARENTNODEDESCID}"/>
				<a style="cursor:pointer;"  onclick="openChooseNode(this,'rsp');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" >
					  <s:property value="%{getText('eaap.op2.conf.prov.choose')}" />
				</a>
			</div>
	    </td>
	    <td class="middle"><input type="text" name="rspNodePath" id="rspNodePath" value="${o.NODEPATH}" 
	    class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'"/></td>
   		<td class="middle"><input type="text" name="rspNodeLengthCons" id="rspNodeLengthCons" value="${o.NODELENGTHCONS}" 
	    class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" size="9"/>
	    </td>
	    <td class="middle">
	    <select name="rspNodeNumberCons" id="rspNodeNumberCons" >
	    <option value="1" <c:if test="${o.NODENUMBERCONS == '1'}">selected</c:if>>1</option>
	    <option value="2" <c:if test="${o.NODENUMBERCONS == '2'}">selected</c:if>>1-N</option>
	    <option value="3" <c:if test="${o.NODENUMBERCONS == '3'}">selected</c:if>>0-1</option>
	    <option value="4" <c:if test="${o.NODENUMBERCONS == '4'}">selected</c:if>>0-N</option>
	    </select>
	    </td>
	    <td class="middle">
	    <select name="rspNodeTypeCons" id="rspNodeTypeCons" >
	    <option value="1" <c:if test="${o.NODETYPECONS == '1'}">selected</c:if>>String</option>
	    <option value="2" <c:if test="${o.NODETYPECONS == '2'}">selected</c:if>>Number</option>
	    <option value="3" <c:if test="${o.NODETYPECONS == '3'}">selected</c:if>>Object</option>
	    <option value="4" <c:if test="${o.NODETYPECONS == '4'}">selected</c:if>>DATE</option>
	    <option value="7" <c:if test="${o.NODETYPECONS == '7'}">selected</c:if>>JsonArry</option>
		<option value="8" <c:if test="${o.NODETYPECONS == '8'}">selected</c:if>>JSON</option>
		<option value="9" <c:if test="${o.NODETYPECONS == '9'}">selected</c:if>>XML</option>
	    </select>
	    </td>
	    <td class="middle">
	    <select name="rspNodeType" id="rspNodeType" >
	    <option value="1" <c:if test="${o.NODETYPE == '1'}">selected</c:if>>HEADER</option>
	    <option value="2" <c:if test="${o.NODETYPE == '2'}">selected</c:if>>BODY</option>
	    <option value="3" <c:if test="${o.NODETYPE == '3'}">selected</c:if>>TAIL</option>
	    <option value="4" <c:if test="${o.NODETYPE == '4'}">selected</c:if>>URL</option>
	    <option value="6" <c:if test="${o.NODETYPE == '6'}">selected</c:if>>XML NameSpace</option>
	    <option value="7" <c:if test="${o.NODETYPE == '7'}">selected</c:if>>Property</option>
	    <option value="8" <c:if test="${o.NODETYPE == '8'}">selected</c:if>>Child Nodes NameSpace</option>
	    </select>
	    </td>
	    <td class="middle">
	    <select name="rspIsNeedSign" id="rspIsNeedSign" >
	    <option value="Y" <c:if test="${o.ISNEEDSIGN == 'Y'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>
	    <option value="N" <c:if test="${o.ISNEEDSIGN == 'N'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>
	    </select>
	    </td>
	    <td class="middle">
	    <select name="rspIsNeedCheck" id="rspIsNeedCheck" >
	    <option value="Y" <c:if test="${o.ISNEEDCHECK == 'Y'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>
	    <option value="N" <c:if test="${o.ISNEEDCHECK == 'N'}">selected</c:if>><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>
	    </select>
	    </td>
		<td class="middle"  style="margin:0;padding:0;">
		    <select name="rspNevlConsType" id="rspNevlConsType" onchange="selectRspMainData(this)"  style="margin:0;padding:0;">
		    <c:forEach var="obj" items="${nevlConsTypeList}" varStatus="n">
		    <option value="${obj.CEPVALUES}"  <c:if test="${obj.CEPVALUES == o.NEVLCONSTYPE}">selected</c:if>>${obj.CEPNAME}</option>
		    </c:forEach>
		    </select>
	    </td>
  		<td class="middle">
  			<c:if test="${o.NEVLCONSTYPE != '3'}">
				<input type="text" name="rspNevlConsValue" id="rspNevlConsValue" value="${o.NEVLCONSVALUE}"  class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" size="40"/>
  			</c:if>
  			<c:if test="${o.NEVLCONSTYPE == '3'}">
	  			<div style="width:250px;">
		  			<input type="text" name="rspMdtName" id="rspMdtName" value="${o.MDTNAME}" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/>
		  			<input id="rspNevlConsValue" name="rspNevlConsValue" type="hidden" value="${o.NEVLCONSVALUE}" />
		  			<a style="cursor:pointer"  onclick="chooseMasterData(this,'rsp');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.prov.choose')}" /></a>
	  			</div>
  			</c:if>
  		</td> 
  		<td class="middle">
  			<!-- <input type="text" name="rspJavaField" id="rspJavaField" value="${o.JAVAFIELD}" 
  			class="box1" onmouseover="this.className='box2'" onMouseOut="this.className='box1'" size="9"/> -->
  			
  			<select name="rspJavaField" id="rspJavaField">
  			   <option value""></option>
			    <c:forEach var="obj" items="${listJavaFieldRsp}" varStatus="listrspfield">
			    <option value="${obj.CEP_VALUES}" <c:if test="${obj.CEP_VALUES == o.JAVAFIELD}">selected</c:if>>${obj.CEP_VALUES}</option>
			    </c:forEach>
			    </select>
  		</td>
  		<td class="middle">
		  		   <div style="width:290px;">
				  			<input type="text" name="rspFuzzy" id="rspFuzzy" value="${o.SHOWVALUE }" class="box1" size="40" readonly style="width:200px;background-color:#F8F8F8;"/>
				  			<input id="rspFuzzyId" name="rspFuzzyId" type="hidden" value="${o.REQFUZZYID}" />
				  			<a style="cursor:pointer"  onclick="javascript:selectFuzzy(this,'rsp');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.prov.choose')}" /></a>
				  			&nbsp;
				  			<a style="cursor:pointer"  onclick="javascript:clearFuzzy(this,'rsp');"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';" ><s:property value="%{getText('eaap.op2.conf.process.fuzzyClear')}" /></a>
			  	   </div>
		</td>
		<td class="middle"><input type="text" name="rspDescValue" id="rspDescValue" value="${o.DESCRIPTION}" class="box1" size="40"/></td>
  		<td class="middle">
		  	<div style="width:90px; text-align:center;">
			 	<a onclick="saveRspNode(this)" style="cursor:pointer" onmouseover="this.style.color='#FF0000'" onmouseout="this.style.color=''">
			    		<s:property value="%{getText('eaap.op2.conf.prov.save')}" />
			    </a>
			    &nbsp;
			    <a onclick="delRspNode(this)" style="cursor:pointer" onmouseover="this.style.color='#FF0000'" onmouseout="this.style.color=''">
			    		<s:property value="%{getText('eaap.op2.conf.prov.delete')}" />
			    </a>
		    </div>
		</td>
	    <%-- 
		<td class="middle">
			<div id="rspMain" >  
		  		<a onclick="javascript:selectRspWin()"  style="cursor:hand"  onmouseover="this.style.color='#FF0000'"  onmouseout="this.style.color=''">
			    		<s:property value="%{getText('eaap.op2.conf.prov.mainData')}" />
			    </a>
		    </div>	 	 
		</td>
		--%>	
	 </tr>
	</c:forEach> 
	</tbody>  
	</table>
	<table  class="t1" style="width: 1900px;">
		<tr>
		    <td class="middle" colspan="11">
		        
		    	<a style="cursor:pointer;"  onclick="addRspNode('rspNodeDesc')"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';"  >
			    		<s:property value="%{getText('eaap.op2.conf.prov.add')}" />
			    </a>
			    &nbsp;&nbsp;&nbsp;&nbsp;
			    <span id="rspSaveAll">
		        <a style="cursor:pointer;"  onclick="javascript:saveAll('RSP',true);"  onmouseover="this.style.color='#FF0000';"  onmouseout="this.style.color='';"  >
				    		<s:property value="%{getText('eaap.op2.conf.contract.message.savaall')}" />
				</a>
				</span>
				<span style="display:none;" id="rspLoadSaveAll">
				<img src="${contextPath}/resource/img/load2.gif" alt="" />
				</span>
	  		</td> 	  			   
		</tr>       
	</table>
	</div>	 
	</ui:tabpagediv>
	
			<%-- --%>
	<ui:tabpagediv  id="docVersion"  title="%{getText('eaap.op2.conf.prov.docVersion')}"  closable="false" >
	  <div>
	  	  <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<s:property value="%{getText('eaap.op2.conf.prov.docVersion')}" />
         		</div>       
    	   </div>
		 	<table class="mgr-table" >
		 	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.contractDoc')}" />:</td>
	   			<td >
	    			<input type="hidden" name="contractDefined.contractDocId" id="contractDocId" value="${contractDefined.contractDocId}"/>
	    			<input type="hidden"  id="DocId" value="${contractDefined.docPath}"/>
    			    <a href="#" id="contractHrefId" onclick="downDoc()">${contractDefined.docName}</a>  
    			   
	    			<ui:inputText type="hidden" name="contractDefined.docName" id="docName" value="${contractDefined.docName}" skin="${contextStyleTheme}"/> 
	    			<ui:button text="%{getText('eaap.op2.conf.prov.docManager')}" skin="${contextStyleTheme}"
	    				 onclick="openWindows('${contextPath}/docManager/docManager.shtml?reqFrom=from','')"  
	    				 shape="s"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td >
	   			<input type="hidden" name="contractDefined.docContrId" id="docContrId" value="${contractDefined.docContrId}"/>  
	   				<ui:textarea id="docContractDescriptor" name="contractDefined.docContractDescriptor" skin="${contextStyleTheme}" width="800" height="100" value="${contractDefined.docContractDescriptor}"/>																					
	   			</td>
		   	</tr>	
		    </table>
	  	</div>
	</ui:tabpagediv>
</ui:tabpage>
<div id="submitInfoDiv"  style="color:#FF0000; line-height:26px; padding:10px;"></div>
<table width="100%" style="width:100%;">
	<tr>
   		<td style="text-align: center;" align="center">
		  	<table align="center">
	    		<tr>
			    	<td id="submitLoadImg" style="display:none;">
					  		<div style="width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/>Loading...</div>
					</td>
			    	<td id="submitBut">
	   					<ui:button text="%{getText('eaap.op2.conf.prov.complete')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="updateContractManager()"/>
	   				</td>
	   				<td>
	   					<ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="window.location='${contextPath}/contractManager/editContractManager.shtml?contractVersionId=' + ${contractVersionId};"></ui:button>												
	   				</td>
	   			</tr>
	   		</table> 
		</td>
	</tr>
</table> 		  	
</div>
<input type="hidden" name="contractAttrSpec" id="contractAttrSpec" value="${contractAttrSpec}" />
</ui:form>
</div>
<!--body end -->
</body> 
<%@ include file="/common/ssoCommon.jsp"%>

</html>