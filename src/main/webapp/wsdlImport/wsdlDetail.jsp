<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/> 	
<script type="text/javascript" src="../resource/comm/adapter/json2.js"></script>
</head>
<style>
.tableHasBorderCss{
	border-collapse:collapse;
	border-spacing:0;
	border:1px solid #ccc;
}
.tableHasBorderCss td{
	border:1px solid #ccc;
	vertical-align:top;
}

.table_onePxBorder{
	width:99%;
	border-collapse:collapse;
	border:1px #CCCCCC solid;
	margin:1px 0 0 0;
	padding:0;
}
.table_onePxBorder th{
	border: 1px #CCCCCC solid;
	width: 17%;
	height: 25px;
	background-color: #FBFBFB;
	margin: 0;
	padding: 0 5px 0 0;
	text-align: right;
	font-family: '微软雅黑'';
	font-weight: normal;
	font-size: 13px;
}
.table_onePxBorder td{
	border:1px #CCCCCC solid;
	font-family: '微软雅黑'';
	width:33%;
	height:25px;
	margin:0;
	padding:1px;
}

.table_base{
	border-collapse:collapse;
	border:1px #CCCCCC solid;
	margin:0;
	padding:0;
}
.table_base th{
	border: 1px #CCCCCC solid;
	height: 25px;
	background-color: #FBFBFB;
	margin: 0;
	padding: 0;
	font-family: '微软雅黑'';
	font-weight: normal;
	font-size: 13px;
}
.table_base td{
	border:1px #CCCCCC solid;
	font-family: '微软雅黑'';
	margin:0;
	padding:0;
}

.div_bgAndOnePxBorder {
	font-family: '微软雅黑'';
	font-weight: normal;
	font-size: 14px;
	line-height: 25px;
	padding-left: 10px;
	border: 1px #CCCCCC solid;
	background-color: #E6E6E6;
}

</style>
<style>
  ul,li{
    list-style: none;
    padding:0px;
  }
  #menuTree{
    padding:0; margin:0;
  }
  #menuTree ul{
    line-height:22px;
    padding-left:20px;
  }
  #menuTree li{
    line-height:22px;
    background:url(../resource/comm/images/dhtmlxTree/imgs/bluefolders/iconText.gif) no-repeat 0  2px;
  }
  #menuTree li a{
    line-height:22px;
    margin-left: 20px; 
    padding:0  3px;
  }
   #menuTree li.menuItem{
      background:url(../resource/comm/images/dhtmlxTree/imgs/plus.gif) no-repeat  0  2px;  
   }
   .linkDef {background-color:#FFF;}
   .linkSel {background-color:#EEE;}
</style>
<body>
<!--body start -->
<div class="contentWarp" id="contentBox">
  	<div class="module-path">
  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png"  align="top"/>
	     	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/>
	      	<img src="../resource/blue/images/module-path.png"  align="top"/>
	      	<s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlDetail')}"/>
      	</div>
    </div>
    
	<table id="loadingImgCon" cellpadding="0" cellspacing="0" class="tableHasBorderCss"  style="width:100%; height:100px; margin-top:1px;" >
		<tr>
			<td id="errorInfo" width="190" valign="top" style="width:190px; margin:0; padding:0; text-align:center;">
				<div style="width:150px; height:30px; line-height:30px; margin:30px 0 0 50px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.wsdlImport.loading')}" /></div>
			</td>
		</tr>
	</table>

	<table id="infoCon" cellpadding="0" cellspacing="0" class="tableHasBorderCss"  style="display:none;width:100%; height:400px; margin-top:1px;" >
		<tr>
			<td width="190" valign="top" style="width:190px; margin:0; padding:0;">
				<!-- Left Tree: -->
			    <div id="serTree" style="width:190px;"></div>
			</td>
			<td style="padding:10px;">
				<!-- Main start: -->
		 		<ui:form id="myForm" name="myForm" action="wsdlParseSave.shtml" method="post"> 
				<input id="contractObjType"  name="contractObjType"   type="hidden"/>
				<input id="funcRowId"  name="funcRowId"   type="hidden"/>
				<input id="wsdlJson"  name="wsdlJson"  type="hidden"/>
				
				<input id="resourceAlias"  name="resourceAlias"  value="${resourceAlias}"   type="hidden"/>
				<input id="docVersion"  name="docVersion"  value="${docVersion}" type="hidden"/>
				<input id="importObjectType"  name="importObjectType"  value="${importObjectType}" type="hidden"/>
				<input id="importFile"  name="importFile"  value="${importFile}"  type="hidden"/>
				<input id="importURL"  name="importURL"  value="${importURL}"  type="hidden"/>
				<input id="fileAttachId"  name="fileAttachId"  value="${fileAttachId}"  type="hidden"/>
				<input id="fileType"  name="fileType"  value="${fileType}"  type="hidden"/>

				<div id="serviceUrlDiv"  style=" margin-bottom:7px; display:none;">
				<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0"  style="width:100%;">
					<tr>
			  			<th>URL</th>
			  			<td id="serviceUrl" style="line-height:24px;"></td>
			   		</tr>
		   		</table>
				</div>				
		   		
				<!--1. 服务基本信息: -->
				<div id="serviceBasicInfoDiv" style="display:none;">
    			<div class="div_bgAndOnePxBorder" >
          			<s:property value="%{getText('eaap.op2.conf.server.manager.serviceBasicInfor')}" />
         		</div>
				<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0" style="width:100%;">
					<tr>
					  <th ><s:property value="%{getText('eaap.op2.conf.server.manager.serviceName')}" /></th>
					  <td><ui:inputText skin="${contextStyleTheme}"  id="serviceCnName"  name="serviceCnName"  style="width:540px;"/></td>
					</tr>
					<tr>
					  <th><s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" /></th>
					  <td><ui:inputText skin="${contextStyleTheme}"  id="serviceCode"  name="serviceCode"  style="width:540px;"/></td>
					</tr>
					<tr>
					  <th><s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" /></th>
					  <td><ui:inputText skin="${contextStyleTheme}"  id="serviceVersion"  name="serviceVersion"  style="width:540px;"/></td>
					</tr>
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.server.manager.serviceDesc')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="serviceDesc" id="serviceDesc" value=""  width="540"></ui:textarea></td>
					</tr>		   		
				</table>
				</div>

				<!--2. 协议基本信息: -->
				<div id="contractInfoDiv"  style="display:none;">
    			<div class="div_bgAndOnePxBorder" style="margin-top:8px;">
          			<s:property value="%{getText('eaap.op2.conf.prov.contractInfo')}" />
         		</div>
				<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0" style="width:100%;">
					<tr>
					  <th><s:property value="%{getText('eaap.op2.portal.prov.contractName')}" /></th>
					  <td><ui:inputText skin="${contextStyleTheme}"  id="contractName"  name="contractName"  style="width:540px;"/></td>
					</tr>
					<tr>
					  <th><s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" /></th>
					  <td>
			   				<div style="width:100%; clear:both">
							  		<ui:inputText skin="${contextStyleTheme}"  id="contractCode"  name="contractCode"  style="width:540px;"/>
			   				</div>
					  </td>
					</tr>
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="contractDescriptor" id="contractDescriptor" value=""  width="540"></ui:textarea></td>
					</tr>		   		
				</table>
				</div>
				
				<!--3. 协议版本基本信息: -->
				<div id="contractVersionInfoDiv"  style="display:none;">
    			<div class="div_bgAndOnePxBorder" style="margin-top:8px;">
          			<s:property value="%{getText('eaap.op2.conf.prov.contractVersionInfo')}" />
         		</div>
				<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0" style="width:100%;">
					<tr>
					  <th><s:property value="%{getText('eaap.op2.conf.prov.contractVersionCode')}" /></th>
					  <td><ui:inputText skin="${contextStyleTheme}"  id="contractVersion"  name="contractVersion"  style="width:540px;"/></td>
					</tr>
					<tr>
					  <th><s:property value="%{getText('eaap.op2.conf.prov.isNeedCheck')}" /></th>
					  <td>
					  		<ui:select  
			    				name="contractDefined.isNeedCheckVersion" 
			    				id="isNeedCheck"   
			    				emptyOption="false" 
			    				headerValue=""
			    			    list="selectStateList" 
			    			    listKey="code" 
			    			    listValue="name" 
			    			    value="" 
			    			    skin="${contextStyleTheme}" >
		    			    </ui:select>
					  </td>
					</tr>
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="contractVersionDescriptor" id="contractVersionDescriptor" value=""  width="540"></ui:textarea></td>
					</tr>		   		
				</table>
				</div>
			    
				<!--4. 协议版本请求定义: -->
				<div id="contractFormatReqDiv" style="display:none;">
    			<div class="div_bgAndOnePxBorder" style="margin-top:8px;">
          			<s:property value="%{getText('eaap.op2.conf.prov.contractVersionReq')}" />
         		</div>
				<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0" style="width:100%;">
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.contractFormatType')}" /></th>
			   			<td colspan=3  >
			   				<ui:select name="reqConType"  id="reqConType"  emptyOption="false"  headerValue=""  
			   					list="conTypeList"  listKey="CEPVALUES"   listValue="CEPNAME"  value=""  skin="${contextStyleTheme}">
		    			    </ui:select>
			   			</td>
					</tr>	
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.contractBodyFormat')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="reqXsdFormat" id="reqXsdFormat" value=""  width="540"></ui:textarea></td>
					</tr>	
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="reqDescriptor" id="reqDescriptor" value=""  width="540"></ui:textarea></td>
					</tr>		   		
				</table>
				<table id="reqNodeDescListTable" class="table_base"    border="0" cellspacing="0" cellpadding="0"  style="margin-top:-1px; width:100%;">
					<tr>
			   			<th>
			   					<span style="float:left;"><s:property value="%{getText('eaap.op2.conf.prov.reqNodeDesc')}" /></span>
			   					<span style="float:right; width:19px; height:18px; margin-right:3px; cursor:pointer; border:1px solid #FBFBFB;" onmouseover="this.style.borderColor='#FF0000';" onmouseout="this.style.borderColor='#FBFBFB';">
									<img style="cursor:hand;" src="${contextPath}/resource/comm/images/down.png"  id="reqNodeListDownOrUpBut"  onclick="listTelescopic($('#reqNodeDescListDiv'), this)"/>
								</span>
			   			</th>
					</tr>
					<tr>
						<td style="padding:0;">
							<div  id="reqNodeDescListDiv"  style="padding:0; margin:0; height:120px; width:800px; overflow:auto;">
									<table border="1" id="reqNodeDesc" class="t1" style="width:100%;"> 
										  <tr class="a1" >  
											  <th class="middle" width="11%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeName')}" /></th>  
											  <th class="middle" width="11%"  style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodePath')}" /></th>
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeLengthCons')}" /></th>  
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeNumberCons')}" /></th>
											  <th class="middle" width="7%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeTypeCons')}" /></th> 
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeType')}" /></th>
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedSign')}" /></th> 
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedCheck')}" /></th>
											  <th class="middle" width="10%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nevlConsType')}" /></th>  
											  <th class="middle"  style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nevlConsValue')}" /></th> 
											  <th class="middle" width="6%" style="white-space:nowrap;">javaField</th>
											  <th class="middle"  colspan='2' style="white-space:nowrap;"><font id="reqOperator" ><s:property value="%{getText('eaap.op2.conf.prov.operator')}" /></font></th>  					    
										  </tr>   
									</table>
							</div>
						</td>
					</tr>
				</table>
				</div>
				
			    
				<!--5. 协议版本响应定义: -->
				<div id="contractFormatRspDiv"  style="display:none;">
    			<div class="div_bgAndOnePxBorder" style="margin-top:8px;">
          			<s:property value="%{getText('eaap.op2.conf.prov.contractVersionRsp')}" />
         		</div>
				<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0"  style="width:100%;">
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.contractFormatType')}" /></th>
			   			<td colspan=3  >
			   				<ui:select   name="rspConType"   id="rspConType"  emptyOption="false"  headerValue=""
			    			    list="conTypeList"  listKey="CEPVALUES"  listValue="CEPNAME"  value=""  skin="${contextStyleTheme}">
		    			    </ui:select>
			   			</td>
					</tr>	
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.contractBodyFormat')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="rspXsdFormat" id="rspXsdFormat"  value=""  width="540"></ui:textarea></td>
					</tr>	
					<tr>
			   			<th><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" /></th>
			   			<td colspan=3  ><ui:textarea  skin="${contextStyleTheme}" name="rspDescriptor" id="rspDescriptor"  value=""  width="540"></ui:textarea></td>
					</tr>		   		
				</table>
				<table class="table_base"    border="0" cellspacing="0" cellpadding="0"  style="margin-top:-1px; width:100%;">
					<tr>
			   			<th>
			   					<span style="float:left;"><s:property value="%{getText('eaap.op2.conf.prov.rspNodeDesc')}" /></span>
			   					<span style="float:right; width:19px; height:18px; margin-right:3px; cursor:pointer; border:1px solid #FBFBFB;" onmouseover="this.style.borderColor='#FF0000';" onmouseout="this.style.borderColor='#FBFBFB';">
									<img style="cursor:hand;" src="${contextPath}/resource/comm/images/down.png"  id="rsqNodeListDownOrUpBut"  onclick="listTelescopic($('#rspNodeDescListDiv'), this)"/>
								</span>
			   			</th>
					</tr>
					<tr>
						<td style="padding:0;">
							<div  id="rspNodeDescListDiv"  style="padding:0; margin:0; height:120px; width:800px; overflow:auto;">
									<table border="1" id="rspNodeDesc" class="t1" style="width:100%;"> 
									    <thead>
										  <tr class="a1" >
											  <th class="middle" width="11%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeName')}" /></th>  
											  <th class="middle" width="11%"  style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodePath')}" /></th>
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeLengthCons')}" /></th>  
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeNumberCons')}" /></th>
											  <th class="middle" width="7%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeTypeCons')}" /></th> 
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nodeType')}" /></th>
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedSign')}" /></th> 
											  <th class="middle" width="6%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.IsNeedCheck')}" /></th>
											  <th class="middle" width="10%" style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nevlConsType')}" /></th>  
											  <th class="middle"  style="white-space:nowrap;"><s:property value="%{getText('eaap.op2.conf.prov.nevlConsValue')}" /></th> 
											  <th class="middle" width="6%" style="white-space:nowrap;">javaField</th>
											  <th class="middle"  colspan='2' style="white-space:nowrap;"><font id="rspOperator" ><s:property value="%{getText('eaap.op2.conf.prov.operator')}" /></font></th>  					    
										  </tr>
										</thead>
									</table>
							</div>
						</td>
					</tr>
				</table>
				</div>
			    
			    </ui:form>
				<!-- Main end -->		 	
			</td>
		</tr>
	</table>
	<div id="butTable"  style="text-align:center;padding-top:10px;">
		<table align="center" >
		    <tr>
		    	<td>
					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.return')}" id="returnBut" onclick="location='${contextPath}/wsdlImport/wsdlImportList.shtml'"></ui:button>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
</div>

<!--body end --> 
</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>

<script type="text/javascript">
var importId="${importId}";
var parseResult= true;
var WsdlJson=null;
var baseIsNew = false;
var isOperatBase = false;
var dWidth=800;
var opReqContractFormatId="";
var opRspContractFormatId="";

$(document).ready(function(){
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../wsdlImport/getWsdlDetail.shtml",
	     dataType:"text",
	     data:"importId="+importId,
	     success:function(msg,data){
			try {
			    var retJson = JSON.parse(msg);
				WsdlJson = retJson.WsdlInfo;	//{"WsdlInfo":{...}}
		 		var isjson = typeof(WsdlJson)=="object" && Object.prototype.toString.call(WsdlJson).toLowerCase() == "[object object]" && !WsdlJson.length; 
				if(isjson){
					if(WsdlJson.RespDesc !=null && WsdlJson.RespDesc !=undefined && WsdlJson.RespDesc !="" && WsdlJson.RespCode !=null && WsdlJson.RespCode !=undefined && WsdlJson.RespCode !=""){
						//解析有问题{"RespCode":"400","RespDesc":"data is null"}
						$("#errorInfo").html(WsdlJson.RespDesc);
					}else{
						//正常
						$("#loadingImgCon").hide();
						$("#infoCon").show();
						loadSerTree();	
						loadBaseContract();
						$("input").blur(function(){
							  changeNodeValue();
						});
						$("textarea").blur(function(){
							  changeNodeValue();
						});
						$("select").blur(function(){
							  changeNodeValue();
						});
					}
				}
			} catch (e) {
				//解析有问题
				$("#errorInfo").html(msg);
		      	return;
			}
		}
	});		
});

function changeNodeValue(){
	obj = event.srcElement;
	var nodePathAtt = obj.attributes['nodePath'];
	if(nodePathAtt != undefined){
		var nodePath = obj.attributes['nodePath'].value;
		var objValue 	= obj.value;
		try {
			eval(nodePath+"=\""+objValue+"\"");
		} catch (e) { 
		}
	}
}

function loadSerTree(){
	var resourceAliss = WsdlJson.dataFlow.wsdlFileShare.contractDoc.resourceAliss;
	var treeHtml = "";
	treeHtml +="<ul id='menuTree'>";
	treeHtml +="	<li class='menuItem'><A href='#' onclick='loadBaseContract(this)' class='linkSel'  id='resourceAlissNode' style='word-break: break-all; word-wrap : break-word;'>"+resourceAliss+"</A>";
	var contracts = WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts;
	if(contracts!=null && contracts.length>0){
		treeHtml +="<ul>";
		for (var i=0; contracts.length>i; i++){
			var contract = contracts[i].contract;
			var contractName = contract.name;
			if(contractName.indexOf(resourceAliss)>-1){
				contractName = contractName.substr(resourceAliss.length+1);
			}
			treeHtml +="<li><A href='#' onclick='loadContract("+i+",this)' style='word-break: break-all; word-wrap : break-word;'>"+contractName+"</A></li>";
		}
		treeHtml +="</ul>";
		
		parseResult = true;
		$("#chooseBaseContractDiv").show();
	}else{
		treeHtml += "<div style='color:#FF0000'><s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlParseFailed')}" /></div>";
		$("#chooseBaseContractDiv").hide();
		$("#returnbutTable").show();
		parseResult = false;
	}
	treeHtml +="	</li>";
	treeHtml +="</ul>";
	$("#serTree").html(treeHtml);
}

function setSelCss(selObj){
	var aList = $("#menuTree a");
	for(var i=0; aList.length >i; i++){
		aList[i].className = "linkDef";
	}
	selObj.className = "linkSel";
}

//加载协议基类：
function loadBaseContract(selObj){
	isOperatBase = true;
	$("#contractObjType").val("BASE");
	var baseContractJson = WsdlJson.dataFlow.baseContract;  //协议基类
	if(baseContractJson != null){
		$("#serviceUrlDiv").show();
		$("#serviceBasicInfoDiv").hide();
		$("#contractInfoDiv").show();
		$("#contractVersionInfoDiv").show();
		$("#contractFormatReqDiv").show();
		$("#contractFormatRspDiv").show();	
		$("#chooseBaseContractDiv").hide();
		$("#butTable").show();
		loadContractInfo(baseContractJson, "WsdlJson.dataFlow.baseContract");  		//2.协议基本信息
		loadContractVersion(baseContractJson.contractVersion, "WsdlJson.dataFlow.baseContract.contractVersion");   //3.协议版本基本信息
		loadContractFormats(baseContractJson.contractVersion.contractFormats, "WsdlJson.dataFlow.baseContract.contractVersion.contractFormats");				//4/5.协议版本请求/响应定义
		loadServiceUrl();  //加载URL

		if(selObj!=null && selObj!=undefined){
			setSelCss(selObj);
		}
	}else{
		$("#serviceUrlDiv").hide();
		$("#serviceBasicInfoDiv").hide();
		$("#contractInfoDiv").hide();
		$("#contractVersionInfoDiv").hide();
		$("#contractFormatReqDiv").hide();
		$("#contractFormatRspDiv").hide();	
		$("#chooseBaseContractDiv").show();
	}
	if(baseIsNew){
		$("#reqOperator").show();
		$("#rspOperator").show();
		$("#reqNodeDescAddBut").show();
		$("#rspNodeDescAddBut").show();
	}else{
		$("#reqOperator").hide();
		$("#rspOperator").hide();
		$("#reqNodeDescAddBut").hide();
		$("#rspNodeDescAddBut").hide();
	}
	changeTopScrollHeight();  //重新设置页面框架高度
}

//加载协议：
function loadContract(rowId, selObj){
	isOperatBase = false;
// 	if(WsdlJson.dataFlow.baseContract == null){
// 		return;
// 	}
	$("#contractObjType").val("FUNCTION");
	$("#funcRowId").val(rowId);
	$("#serviceUrlDiv").hide();
	$("#serviceBasicInfoDiv").show();
	$("#contractInfoDiv").show();
	$("#contractVersionInfoDiv").show();
	$("#contractFormatReqDiv").show();
	$("#contractFormatRspDiv").show();	

	$("#reqOperator").hide();
	$("#rspOperator").hide();
	$("#reqNodeDescAddBut").hide();
	$("#rspNodeDescAddBut").hide();
	var contractObj = WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts[rowId].contract;
	loadService(contractObj.contractVersion.service, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion.service");	//1.服务基本信息
	loadContractInfo(contractObj, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract");		//2.协议基本信息
	loadContractVersion(contractObj.contractVersion, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion");		//3.协议版本基本信息
	loadContractFormats(contractObj.contractVersion.contractFormats, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion.contractFormats");		//4/5.协议版本请求/响应定义 
	if(selObj!=null && selObj!=undefined){
		setSelCss(selObj);
	}
}

//1.服务基本信息：
function loadService(serviceObj, nodePath){
	var serviceCnName= serviceObj.serviceCnName;
	var serviceCode		= serviceObj.serviceCode;
	var serviceType		= serviceObj.serviceType;
	var serviceVersion	= serviceObj.serviceVersion;
	var serviceDesc		= serviceObj.serviceDesc;
	$("#serviceCnName").val(serviceCnName);
	$("#serviceCnName").attr("nodePath",nodePath+".serviceCnName");
	$("#serviceCode").val(serviceCode);
	$("#serviceCode").attr("nodePath",nodePath+".serviceCode");
	$("#serviceType").val(serviceType);
	$("#serviceType").attr("nodePath",nodePath+".serviceType");
	$("#serviceVersion").val(serviceVersion);
	$("#serviceVersion").attr("nodePath",nodePath+".serviceVersion");
	$("#serviceDesc").val(serviceDesc);
	$("#serviceDesc").attr("nodePath",nodePath+".serviceDesc");
	
}

//2.协议基本信息：
function loadContractInfo(contractObj, nodePath){
	var contractName			= contractObj.name;
	var contractCode			= contractObj.code;
	var contractDescriptor	= contractObj.descriptor;
	$("#contractName").val(contractName);
	$("#contractName").attr("nodePath",nodePath+".name");
	$("#contractCode").val(contractCode);
	$("#contractCode").attr("nodePath",nodePath+".code");
	$("#contractDescriptor").val(contractDescriptor);
	$("#contractDescriptor").attr("nodePath",nodePath+".descriptor");
}

//3.协议版本基本信息：
function loadContractVersion(contractVersion, nodePath){
	var version				= contractVersion.version;
	var isNeedCheck	= contractVersion.isNeedCheck;
	var descriptor			= contractVersion.descriptor;
	$("#contractVersion").val(version);
	$("#contractVersion").attr("nodePath",nodePath+".version");
	$("#isNeedCheck").attr("nodePath",nodePath+".isNeedCheck");
	$("#contractVersionDescriptor").val(descriptor);
	$("#contractVersionDescriptor").attr("nodePath",nodePath+".descriptor");
}


//4/5.协议版本请求/响应定义：
function loadContractFormats(contractFormats, nodePath){
	if(contractFormats!=null && contractFormats.length>0){
		for (var i=0; contractFormats.length>i; i++){
			var contractFormatObj = contractFormats[i];
			var reqRsp		= contractFormatObj.reqRsp;
			var conType	= contractFormatObj.conType;
			var xsdFormat	= contractFormatObj.xsdFormat;
			var descriptor	= contractFormatObj.descriptor;
			var contractFormatId = contractFormatObj.contractFormatId;
			if(reqRsp=="REQ"){
				opReqContractFormatId=contractFormatId;
				$("#reqConType").val(conType);
				$("#reqConType").attr("nodePath",nodePath+"["+i+"]"+".conType");
				$("#reqXsdFormat").val(xsdFormat);
				$("#reqXsdFormat").attr("nodePath",nodePath+"["+i+"]"+".xsdFormat");
				$("#reqDescriptor").val(descriptor);
				$("#reqDescriptor").attr("nodePath",nodePath+"["+i+"]"+".descriptor");
				loadNodeDescs("reqNodeDesc", contractFormats[i].nodeDescs, nodePath+"["+i+"].nodeDescs");
			}else{
				opRspContractFormatId=contractFormatId;
				$("#rspConType").val(conType);
				$("#rspConType").attr("nodePath",nodePath+"["+i+"]"+".conType");
				$("#rspXsdFormat").val(xsdFormat);
				$("#rspXsdFormat").attr("nodePath",nodePath+"["+i+"]"+".xsdFormat");
				$("#rspDescriptor").val(descriptor);
				$("#rspDescriptor").attr("nodePath",nodePath+"["+i+"]"+".descriptor");
				loadNodeDescs("rspNodeDesc", contractFormats[i].nodeDescs, nodePath+"["+i+"].nodeDescs");
			}
		}
	}
	changeTopScrollHeight();  //重新设置页面框架高度
}
	
function loadNodeDescs(tbname, nodeDescs, nodePath) {
	//先删除已有的行
	 var tableObj = document.getElementById(tbname);  
	 if(tbname=="reqNodeDesc"){
			$("#reqNodeDesc tr:not(:eq(0))").remove();	
			//加载行
			if(nodeDescs !=null){
				for(var i=0; nodeDescs.length>i; i++){
					  var nodeDesc = nodeDescs[i];
					  loadReqNode(tableObj, nodeDesc, nodePath+"["+i+"]");
				}
			}
	 		$("#reqNodeDescListDiv").width($("#reqNodeDescListTable").width());
	 }else{
			$("#rspNodeDesc tr:not(:eq(0))").remove();
			//加载行
			if(nodeDescs !=null){
				for(var i=0; nodeDescs.length>i; i++){
					  var nodeDesc = nodeDescs[i];
					  loadRspNode(tableObj, nodeDesc, nodePath+"["+i+"]");
				}
			}
	 		$("#rspNodeDescListDiv").width($("#reqNodeDescListTable").width());
	 }
}

function loadReqNode(tableObj, nodeDesc, nodePath){
		  var rows = tableObj.rows.length;  
		  var tr = tableObj.insertRow(rows);
		    
		  var name = tr.insertCell(0);  
		  name.innerHTML = '<td class="middle"><input type="text" name="reqNodeDescName" id="reqNodeDescName" value="'+ nodeDesc.nodeName+'"  nodePath="'+nodePath+'.nodeName" onblur="changeNodeValue()" onkeyup="changeNodeValue()" class="box1" /><input id="reqNodeDescId" name="reqNodeDescId" type="hidden" /></td>';  
		  
		  var path = tr.insertCell(1);  
		  path.innerHTML = '<td class="middle"><input type="text" name="reqNodePath" id="reqNodePath" value="'+ nodeDesc.nodePath+'"  nodePath="'+nodePath+'.nodePath" onblur="changeNodeValue()"  onkeyup="changeNodeValue()"  class="box1" /></td>';  		  
		  
		  var lengthCons = tr.insertCell(2);  		  
		  lengthCons.innerHTML = '<td class="middle"><input type="text" name="reqNodeLengthCons" id="reqNodeLengthCons"  value="'+ nodeDesc.nodeLengthCons+'"  nodePath="'+nodePath+'.nodeLengthCons" onblur="changeNodeValue()"  onkeyup="changeNodeValue()" class="box1" size="9" style="width:100%;"/></td>';  		  

		  var nodeNumber = tr.insertCell(3);  
		  var tdInnerHTML = '<td class="middle">';
			tdInnerHTML += '<select name="reqNodeNumberCons" id="reqNodeNumberCons"  style="width:100%; height:24px;" nodePath="'+nodePath+'.nodeNumberCons" onblur="changeNodeValue()" onchange="changeNodeValue()">';
		  	tdInnerHTML += '<option value="1" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==1) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>1</option>';
			tdInnerHTML +=  '<option value="2" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==2) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>1-N</option>';
		  	tdInnerHTML += '<option value="3" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==3) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>0-1</option>';
		  	tdInnerHTML += '<option value="4" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==4) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>0-N</option>';
		  	tdInnerHTML += '</select>';
		  	tdInnerHTML += '</td>';
		  nodeNumber.innerHTML = tdInnerHTML;
		  
		  var nodeTypeCons = tr.insertCell(4);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="reqNodeTypeCons" id="reqNodeTypeCons"  style="width:100%; height:24px;"   nodePath="'+nodePath+'.nodeTypeCons" onblur="changeNodeValue()"> '; 
		  tdInnerHTML += '<option value="1" '; 
			 if(nodeDesc.nodeTypeCons && nodeDesc.nodeTypeCons ==1) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>String</option> '; 
		  tdInnerHTML += '<option value="2" '; 
			 if(nodeDesc.nodeTypeCons && nodeDesc.nodeTypeCons ==2) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>Number</option> '; 
		  tdInnerHTML += '<option value="3" '; 
			 if(nodeDesc.nodeTypeCons && nodeDesc.nodeTypeCons ==3) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>Object</option> '; 
		  tdInnerHTML += '</select> '; 
		  tdInnerHTML += '</td>';  		
		  nodeTypeCons.innerHTML = tdInnerHTML;   
		  
		  var nodeType = tr.insertCell(5);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="reqNodeType" id="reqNodeType"  style="width:100%; height:24px;"   nodePath="'+nodePath+'.nodeType" onblur="changeNodeValue()" onchange="changeNodeValue()">'; 
		  tdInnerHTML += '<option value=1  '; 
			 if(nodeDesc.nodeType && nodeDesc.nodeType ==1) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>HEADER</option>';
		  tdInnerHTML += '<option value=2  '; 
			 if(nodeDesc.nodeType && nodeDesc.nodeType ==2) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>BODY</option>'; 
		  tdInnerHTML += '</select>'; 
		  tdInnerHTML += '</td>';  
		  nodeType.innerHTML = tdInnerHTML; 
		  
		  var isNeedSign = tr.insertCell(6);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="reqIsNeedSign" id="reqIsNeedSign"  style="width:100%; height:24px;"   nodePath="'+nodePath+'.isNeedSign" onblur="changeNodeValue()"  onchange="changeNodeValue()">';
		  tdInnerHTML += '<option value="Y"  '; 
			 if(nodeDesc.isNeedSign && nodeDesc.isNeedSign=='Y') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>';
		  tdInnerHTML += '<option value="N"  '; 
			 if(nodeDesc.isNeedSign && nodeDesc.isNeedSign=='N') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>';
		  tdInnerHTML += '</select>';
		  tdInnerHTML += '</td>';  
		  isNeedSign.innerHTML =tdInnerHTML;
		  
		  var isNeedCheck = tr.insertCell(7);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="reqIsNeedCheck" id="reqIsNeedCheck" style="width:100%; height:24px;"   nodePath="'+nodePath+'.isNeedCheck" onblur="changeNodeValue()" onchange="changeNodeValue()">';
		  tdInnerHTML += '<option value="Y"  '; 
			 if(nodeDesc.isNeedCheck && nodeDesc.isNeedCheck=='Y') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>';
		  tdInnerHTML += '<option value="N"  '; 
			 if(nodeDesc.isNeedCheck && nodeDesc.isNeedCheck=='N') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>';
		  tdInnerHTML += '</select></td>';  
		  isNeedCheck.innerHTML =tdInnerHTML;

		  var nevlConsType = tr.insertCell(8);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="reqNevlConsType" id="reqNevlConsType" style="width:100%; height:24px;"   nodePath="'+nodePath+'.nevlConsType" onblur="changeNodeValue()" onchange="changeNodeValue()">';
			  <c:forEach var="obj" items="${nevlConsTypeList}" varStatus="n">
				  tdInnerHTML += '<option value="${obj.CEPVALUES}"  '; 
					 if(nodeDesc.nevlConsType && nodeDesc.nevlConsType=='${obj.CEPVALUES}') tdInnerHTML += 'selected';  
				  tdInnerHTML += '>${obj.CEPNAME}</option>';
			  </c:forEach>
		  tdInnerHTML += '</select></td>';  
		  nevlConsType.innerHTML = tdInnerHTML;
		  
		  var nevlConsValue = tr.insertCell(9);  
		  nevlConsValue.innerHTML = '<td class="middle"><input type="text" name="reqNevlConsValue" id="reqNevlConsValue"   value="'+ nodeDesc.nevlConsValue+'"  nodePath="'+nodePath+'.nevlConsValue" onblur="changeNodeValue()"  onkeyup="changeNodeValue()"  class="box1" size="40"/></td>';
		  
		  var javafieldStr = tr.insertCell(10);
		  javafieldStr.innerHTML = '<td class="middle"><input type="text" name="reqJavaField" id="reqJavaField" value="'+ nodeDesc.javaField+'"  nodePath="'+nodePath+'.javaField" onblur="changeNodeValue()"  onkeyup="changeNodeValue()"  class="box1" size="9"/></td>';

		  var delBtn = tr.insertCell(11);
		  var tdInnerHTML = '<td class="middle">';
		  var  operatBut = '<a onclick="delReqNode(this)"  style="cursor:pointer" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.delete')}" /></a>';  
		  if(isOperatBase){
			  if(baseIsNew){
				  tdInnerHTML += operatBut;  
			  }		  
		  }else{
// 				  tdInnerHTML += operatBut;  
		  }
		  tdInnerHTML += '</td>';
		  delBtn.innerHTML = tdInnerHTML; 
}

function delReqNode(btn) {
	var tr = btn.parentElement.parentElement;  
	var tbl = tr.parentElement;
	if ("${contractVersionId}" == "") {
		tbl.deleteRow(tr.rowIndex); 
	} else {
		tbl.deleteRow(tr.rowIndex - 1);
	}
}

function loadRspNode(tableObj, nodeDesc, nodePath){
		  var rows = tableObj.rows.length;  
		  var tr = tableObj.insertRow(rows);
		    
		  var name = tr.insertCell(0);  
		  name.innerHTML = '<td class="middle"><input type="text" name="rspNodeDescName" id="rspNodeDescName" value="'+ nodeDesc.nodeName+'"  nodePath="'+nodePath+'.nodeName" onblur="changeNodeValue()"  onkeyup="changeNodeValue()" class="box1" /><input id="rspNodeDescId" name="rspNodeDescId" type="hidden" /></td>';  
		  
		  var path = tr.insertCell(1);  
		  path.innerHTML = '<td class="middle"><input type="text" name="rspNodePath" id="rspNodePath" value="'+ nodeDesc.nodePath+'"  nodePath="'+nodePath+'.nodePath" onblur="changeNodeValue()" onkeyup="changeNodeValue()" class="box1" /></td>';  		  
		  
		  var lengthCons = tr.insertCell(2);  		  
		  lengthCons.innerHTML = '<td class="middle"><input type="text" name="rspNodeLengthCons" id="rspNodeLengthCons"  value="'+ nodeDesc.nodeLengthCons+'"  nodePath="'+nodePath+'.nodeLengthCons" onblur="changeNodeValue()" onkeyup="changeNodeValue()" class="box1" size="9"/></td>';  		  

		  var nodeNumber = tr.insertCell(3);  
		  var tdInnerHTML = '<td class="middle">';
			tdInnerHTML += '<select name="rspNodeNumberCons" id="rspNodeNumberCons"  style="width:100%; height:24px;"  nodePath="'+nodePath+'.nodeNumberCons" onblur="changeNodeValue()" onchange="changeNodeValue()">';
		  	tdInnerHTML += '<option value="1" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==1) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>1</option>';
			tdInnerHTML +=  '<option value="2" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==2) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>1-N</option>';
		  	tdInnerHTML += '<option value="3" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==3) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>0-1</option>';
		  	tdInnerHTML += '<option value="4" '; 
		  		if(nodeDesc.nodeNumberCons && nodeDesc.nodeNumberCons ==4) tdInnerHTML += 'selected';  
		  	tdInnerHTML += '>0-N</option>';
		  	tdInnerHTML += '</select>';
		  	tdInnerHTML += '</td>';
		  nodeNumber.innerHTML = tdInnerHTML;
		  
		  var nodeTypeCons = tr.insertCell(4);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="rspNodeTypeCons" id="rspNodeTypeCons"  style="width:100%; height:24px;"   nodePath="'+nodePath+'.nodeTypeCons" onblur="changeNodeValue()" onchange="changeNodeValue()"> '; 
		  tdInnerHTML += '<option value="1" '; 
			 if(nodeDesc.nodeTypeCons && nodeDesc.nodeTypeCons ==1) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>String</option> '; 
		  tdInnerHTML += '<option value="2" '; 
			 if(nodeDesc.nodeTypeCons && nodeDesc.nodeTypeCons ==2) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>Number</option> '; 
		  tdInnerHTML += '<option value="3" '; 
			 if(nodeDesc.nodeTypeCons && nodeDesc.nodeTypeCons ==3) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>Object</option> '; 
		  tdInnerHTML += '</select> '; 
		  tdInnerHTML += '</td>';  		
		  nodeTypeCons.innerHTML = tdInnerHTML;   
		  
		  var nodeType = tr.insertCell(5);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="rspNodeType" id="rspNodeType"  style="width:100%; height:24px;"  nodePath="'+nodePath+'.nodeType" onblur="changeNodeValue()"  onchange="changeNodeValue()">'; 
		  tdInnerHTML += '<option value=1  '; 
			 if(nodeDesc.nodeType && nodeDesc.nodeType ==1) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>HEADER</option>';
		  tdInnerHTML += '<option value=2  '; 
			 if(nodeDesc.nodeType && nodeDesc.nodeType ==2) tdInnerHTML += 'selected';  
		  tdInnerHTML += '>BODY</option>'; 
		  tdInnerHTML += '</select>'; 
		  tdInnerHTML += '</td>';  
		  nodeType.innerHTML = tdInnerHTML; 
		  
		  var isNeedSign = tr.insertCell(6);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="rspIsNeedSign" id="rspIsNeedSign"  style="width:100%; height:24px;"  nodePath="'+nodePath+'.isNeedSign" onblur="changeNodeValue()"  onchange="changeNodeValue()">';
		  tdInnerHTML += '<option value="Y"  '; 
			 if(nodeDesc.isNeedSign && nodeDesc.isNeedSign=='Y') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>';
		  tdInnerHTML += '<option value="N"  '; 
			 if(nodeDesc.isNeedSign && nodeDesc.isNeedSign=='N') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>';
		  tdInnerHTML += '</select>';
		  tdInnerHTML += '</td>';  
		  isNeedSign.innerHTML =tdInnerHTML;
		  
		  var isNeedCheck = tr.insertCell(7);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="rspIsNeedCheck" id="rspIsNeedCheck" style="width:100%; height:24px;"  nodePath="'+nodePath+'.isNeedCheck" onblur="changeNodeValue()"  onchange="changeNodeValue()">';
		  tdInnerHTML += '<option value="Y"  '; 
			 if(nodeDesc.isNeedCheck && nodeDesc.isNeedCheck=='Y') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.yes')}" /></option>';
		  tdInnerHTML += '<option value="N"  '; 
			 if(nodeDesc.isNeedCheck && nodeDesc.isNeedCheck=='N') tdInnerHTML += 'selected';  
		  tdInnerHTML += '><s:property value="%{getText('eaap.op2.conf.prov.no')}" /></option>';
		  tdInnerHTML += '</select></td>';  
		  isNeedCheck.innerHTML =tdInnerHTML;

		  var nevlConsType = tr.insertCell(8);  
		  var tdInnerHTML = '<td class="middle">';
		  tdInnerHTML += '<select name="rspNevlConsType" id="rspNevlConsType" style="width:100%; height:24px;"  nodePath="'+nodePath+'.nevlConsType" onblur="changeNodeValue()"  onchange="changeNodeValue()">';
			  <c:forEach var="obj" items="${nevlConsTypeList}" varStatus="n">
				  tdInnerHTML += '<option value="${obj.CEPVALUES}"  '; 
					 if(nodeDesc.nevlConsType && nodeDesc.nevlConsType=='${obj.CEPVALUES}') tdInnerHTML += 'selected';  
				  tdInnerHTML += '>${obj.CEPNAME}</option>';
			  </c:forEach>
		  tdInnerHTML += '</select></td>';  
		  nevlConsType.innerHTML = tdInnerHTML;
		  
		  var nevlConsValue = tr.insertCell(9);  
		  nevlConsValue.innerHTML = '<td class="middle"><input type="text" name="rspNevlConsValue" id="rspNevlConsValue"   value="'+ nodeDesc.nevlConsValue+'"  nodePath="'+nodePath+'.nevlConsValue" onblur="changeNodeValue()" onkeyup="changeNodeValue()"  class="box1" size="40"/></td>';
		  
		  var javafieldStr = tr.insertCell(10);
		  javafieldStr.innerHTML = '<td class="middle"><input type="text" name="rspJavaField" id="rspJavaField" value="'+ nodeDesc.javaField+'"  nodePath="'+nodePath+'.javaField" onblur="changeNodeValue()" onkeyup="changeNodeValue()"  class="box1" size="9"/></td>';
		  
		  var delBtn = tr.insertCell(11);
		  var tdInnerHTML = '<td class="middle">';
		  var  operatBut = '<a onclick="delRspNode(this)"  style="cursor:pointer" onmouseover="this.style.color=\'#FF0000\'" onmouseout="this.style.color=\'\'"><s:property value="%{getText('eaap.op2.conf.prov.delete')}" /></a>';  
		  if(isOperatBase){
			  if(baseIsNew){
				  tdInnerHTML += operatBut;  
			  }		  
		  }else{
// 				  tdInnerHTML += operatBut;  
		  }
		  tdInnerHTML += '</td>';
		  delBtn.innerHTML = tdInnerHTML; 
}

function delRspNode(btn) {  
	var tr = btn.parentElement.parentElement;  
	var tbl = tr.parentElement;
	if ("${contractVersionId}" == "") {
	 	tbl.deleteRow(tr.rowIndex); 
	} else {
		tbl.deleteRow(tr.rowIndex - 1);
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

//加载URL
function loadServiceUrl(){
	var host = window.location.host;
	var serviceAgentUrl = "${serviceAgentUrl}";		//在公共配置文件（eaap_common.properties）中配置的服务引擎地址
	var resourceAliss = WsdlJson.dataFlow.wsdlFileShare.contractDoc.resourceAliss;
	var version = WsdlJson.dataFlow.baseContract.contractVersion.version;
	if(jQuery.trim(version) != ""){
		var serviceUrl = serviceAgentUrl+"/webservice/"+version+"/"+resourceAliss;
		$("#serviceUrl").html(serviceUrl);
		$("#serviceUrlDiv").show();
	}
}

function listTelescopic(divObj,imgButObj){
	if (divObj.height() == "120") {
		divObj.css('height','100%');
		imgButObj.src = "../resource/comm/images/up.png";
	}else{
		divObj.css('height','120px');
		imgButObj.src = "../resource/comm/images/down.png";
	}
	changeTopScrollHeight();  //重新设置页面框架高度
}

</script>
