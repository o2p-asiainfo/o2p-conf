<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/icon.css" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/uploadify.css" /> 
    <link rel="stylesheet" type="text/css" href="${contextPath}/resource/comm/css/docUpload.css" />  
    
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>		 
	<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/> 
	<script type="text/javascript" src="${contextPath}/resource/comm/js/swfobject.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.uploadify.v2.1.0.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/wsdl_upload.js"></script>	
	 <script type="text/javascript" src="${contextPath}/resource/comm/adapter/json2.js" ></script>
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
<input type="hidden" id="jsessionid" value="${pageContext.session.id}"/>
<input type="hidden" id="USER_TENANT_ID" value="${sessionScope.USER_TENANT_ID}"/>
<div class="contentWarp"  id="addBox">    
	<div class="module-path">
		<div class="module-path-content">
	    <img src="../resource/blue/images/search.png"  align="top"/>
	   	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	    	<img src="../resource/blue/images/module-path.png"  align="top"/>
	    	<s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/>
	   	</div>
	</div>
    <div id="queryBlock">
		<div class="selectList" style="display:block;">	
		 <ui:form id="myForm" name="myForm" action="wsdlParse.shtml" method="post"> 
		 	<table class="mgr-table"  width="100%">
				<tr>
		  			<td class="item" style="width:25%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.wsdlImport.enterResourceAlias')}" />:</td>
		  			<td class="item-content" style="width:75%;"> 
		  				<div style="width:100%; clear:both">
			  		    		<ui:inputText skin="${contextStyleTheme}"  name="resourceAlias"  id="resourceAlias" value=""  style="width:420px; float:left;"></ui:inputText>
			  		    		<span id="resourceAliasImg" style="float:left;"></span>
			  		    </div>
			  		    <div id="resourceAliasIsHasMsg"  style="display:none; width:100%;font-size:14px; color:#FF0000; line-height:22px; clear:both; height:auto;"></div>
		   			</td>
		   		</tr>
		    </table>
		    
			<table class="mgr-table"   width="100%"  style="display:none;">
				<tr>
		  			<td class="item" style="width:25%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.wsdlImport.enterDocVersion')}" />:</td>
		  			<td class="item-content" style="width:75%;">
	  					<div style="width:100%; clear:both">
				  		    <ui:inputText skin="${contextStyleTheme}"  name="docVersion"  id="docVersion" value=""  style="width:420px; float:left;"></ui:inputText>
		  		    		<span id="docVersionImg" style="float:left;"></span>
	  					</div>
		  		    	<div id="resourceAliasVersionIsHasMsg"  style="display:none; width:100%;font-size:14px; color:#FF0000; line-height:22px;clear:both;"></div>
		   			</td>
		   		</tr>
		    </table>
			
			<table class="mgr-table" width="100%">
				<tr>
		  			<td class="item" style="width:25%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.wsdlImport.importObjectType')}" />:</td>
		  			<td class="item-content" style="width:75%;">
                    	<ui:select skin="${contextStyleTheme}"  emptyOption="true" name="importObjectType" id="importObjectType" onchange="objTypeOnchange()"
    			       		list="importObjectTypeList" listKey="key" listValue="value" style="width:70px;" value="1"></ui:select>
		   			</td>
		   		</tr>
		    </table>
			
		    <div  id="objTypeFile_tr"  style="display:none;">
			<table class="mgr-table"  width="100%">
				<tr>
		  			<td class="item" style="width:25%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.wsdlImport.enterWsdlFile')}" />:</td>
		  			<td class="item-content" style="width:75%;">
					  		    <ui:inputText skin="${contextStyleTheme}"  name="importFile"  id="importFile"  type="hidden"></ui:inputText>
					  			<div style="float:left;">
					  					<div id="fileQueue" ></div>
									    <div id="div_filecontainer"  class="clearfix"></div>
		            					<p id="p_allcomplete" class="error-inform"></p>
					  			</div>
					  			<div style="float:left;">
							  		    <input id="attach_id"  name="attach_id"  type="hidden" />
					                    <input type="file" name="uploadify" id="uploadify" />
									    <a href="javascript:jQuery('#uploadify').uploadifyUpload()"  style="display:none;">
									    	<s:property value="%{getText('eaap.op2.conf.reseller.contract.beginUpload')}" />
									    </a>
					  			</div>
					  			<div style="float:left; padding-left:15px; padding-top:8px; color:#AAA;">  ( *.zip / *.wsdl )</div>
		   			</td>
		   		</tr>
		    </table>
			</div>
			
		    <div  id="objTypeURL_tr" >
			<table class="mgr-table"  width="100%">
				<tr>
		  			<td class="item" style="width:25%;"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.wsdlImport.enterWsdlURL')}" />:</td>
		  			<td class="item-content" style="width:75%;">
			  		    <ui:inputText skin="${contextStyleTheme}"  name="importURL"  id="importURL" value=""  style="width:730px"></ui:inputText>
		   			</td>
		   		</tr>
		    </table>
			</div>
		 </ui:form>
	</div>
	</div>
	<div style="text-align:center;padding-top:10px;">
		<table align="center" >
		    <tr>
		    	<td id="parseLoadImg" style="display:none;">
				  		<div style="width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.wsdlImport.parsing')}" /></div>
				</td>
		    	<td id="parseBut">
				  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.next')}" id="sureBut" onclick="importParse()"></ui:button>
				</td>
		    	<td style="padding-left:20px;">
				  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.cancel')}" id="returnBut" onclick="location='${contextPath}/wsdlImport/wsdlImportList.shtml'"></ui:button>
				</td>
			</tr>
		</table>
	</div>
	<!--body end --> 
</div>








<div class="contentWarp"  id="contentBox"  style="display:none;">
	<div class="module-path">
		<div class="module-path-content">
	    <img src="../resource/blue/images/search.png"  align="top"/>
	   	<s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	    	<img src="../resource/blue/images/module-path.png"  align="top"/>
	    	<s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlImport')}"/>
	   	</div>
	</div>
	<table cellpadding="0" cellspacing="0" class="tableHasBorderCss"  style="width:100%; height:400px; margin-top:1px;" >
		<tr>
			<td width="190" valign="top" style="width:190px; margin:0; padding:0;">
				<!-- Left Tree: -->
			    <div id="serTree" style="width:190px;"></div>
			</td>
			<td style="padding:10px;">
				<!-- Main start: -->
		 		<ui:form id="myForm2" name="myForm2" action="wsdlParseSave.shtml" method="post"> 
				<input id="contractObjType"  name="contractObjType"   type="hidden"/>
				<input id="funcRowId"  name="funcRowId"   type="hidden"/>
				<input id="wsdlJson"  name="wsdlJson"  type="hidden"/>
				
				<input id="resourceAlias2"  name="resourceAlias2"  type="hidden"/>
				<input id="docVersion2"  name="docVersion2" type="hidden"/>
				<input id="importObjectType2"  name="importObjectType2"  type="hidden"/>
				<input id="importFile2"  name="importFile2"  type="hidden"/>
				<input id="importURL2"  name="importURL2"  type="hidden"/>
				<input id="fileAttachId2"  name="fileAttachId2"  type="hidden"/>
				
				<div id="chooseBaseContractDiv"  style="display:none; margin-bottom:7px;">
					<table id="chooseBaseTable" class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0">
						<tr>
				  			<th style="width:30%;"><s:property value="%{getText('eaap.op2.conf.wsdlImport.baseContratCreateMode')}" /></th>
				  			<td  style="width:70%;">
		                    	<select id="baseContratCreateMode"  name="baseContratCreateMode"  onchange="baseContratCreateModeChange()"  style="width:288px">
									<option value="1"><s:property value="%{getText('eaap.op2.conf.wsdlImport.chooseExistingBaseContrat')}" /></option>
									<option value="2"><s:property value="%{getText('eaap.op2.conf.wsdlImport.createBaseContrat')}" /></option>
								</select>
					  		</td>
				   		</tr>
						<tr  id="chooseTr" >
				  			<th><s:property value="%{getText('eaap.op2.conf.wsdlImport.chooseBaseContrat')}" /></th>
				  			<td  >
					  		    	<div class="ui-widget">
						  				<input id="baseContractId"  name="baseContractId"  type="hidden" />
						  			    <ui:inputText skin="${contextStyleTheme}" name="baseContractName" id="baseContractName"  style="width:280px;" readonly="true" ></ui:inputText>
					                    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/contractManager/chooseContractBase.shtml?baseContractId=baseContractId&baseContractName=baseContractName&&pageState=pageState','Choose base Contract')" shape="s"></ui:button>
					  				</div>
					  		</td>
				   		</tr>
			   		</table>
					<div style="text-align:center; padding:20px;">
							<table align="center"  border="0"  style="border-width:0;">
							    <tr>
							    	<td id="loadBaseImg" style="display:none;border-width:0;">
									  		<div style="width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.wsdlImport.loading')}" /></div>
									</td>
							    	<td id="loadBaseBut" style="border-width:0;">
											<ui:button text="%{getText('eaap.op2.conf.wsdlImport.next')}"  skin="${contextStyleTheme}"  onclick="chooseBaseToNext()"/>									
									</td>
								</tr>
							</table>
					</div>
					<div id="loadchooseBaseErrorInfo"  style="text-align:left; padding:20px;"></div>
				</div>		
				
				<!--0. URL: -->
				<div id="serviceUrlDiv"  style="display:none; margin-bottom:7px;">
					<table class="table_onePxBorder"  border="0" cellspacing="0" cellpadding="0"  style="width:100%;">
						<tr>
				  			<th>URL</th>
				  			<td id="serviceUrl" style="line-height:24px;"></td>
				   		</tr>
			   		</table>
				</div>				
		   		
				<!--1. 服务基本信息: -->
				<div id="serviceBasicInfoDiv"  style="display:none;">
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
					<!-- >tr>
					  <th><s:property value="%{getText('eaap.op2.conf.server.manager.serviceCategory')}" /></th>
					  <td><ui:inputText skin="${contextStyleTheme}"  id="serviceType"  name="serviceType"  style="width:540px;"/></td>
					</tr -->
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
					  <td><ui:inputText skin="${contextStyleTheme}"  id="contractName"  name="contractName"  style="width:540px;"/><font style="color:#FF0000;font-size:16px;">*</font></td>
					</tr>
					<tr>
					  <th><s:property value="%{getText('eaap.op2.portal.prov.contractNode')}" /></th>
					  <td>
			   				<div style="width:100%; clear:both">
							  		<ui:inputText skin="${contextStyleTheme}"  id="contractCode"  name="contractCode"  style="width:540px;"/><font style="color:#FF0000;font-size:16px;">*</font>
				   					<span id="holdImg" ></span>
			   				</div>
			   				<div id ="isHasMsg" style="display:none; width:100%;color:#FF0000; font-size:14px;clear:both"></div>		
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
					  <td><ui:inputText skin="${contextStyleTheme}"  id="contractVersion"  name="contractVersion"  style="width:540px;"/><font style="color:#FF0000;font-size:16px;">*</font></td>
					</tr>
					<tr>
					  <th><s:property value="%{getText('eaap.op2.conf.prov.isNeedCheck')}" /></th>
					  <td>
					  		<ui:select  
			    				name="isNeedCheckVersion" 
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
				<div id="contractFormatReqDiv"  style="display:none;">
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
				<table class="table_base"    border="0" cellspacing="0" cellpadding="0"  style="margin-top:-1px; width:100%;">
					<tr>
			   			<th>
			   					<span style="float:left;"><s:property value="%{getText('eaap.op2.conf.prov.reqNodeDesc')}" /></span>
			   					<span style="float:right; width:19px; height:18px; margin-right:3px; cursor:pointer; border:1px solid #FBFBFB;" onmouseover="this.style.borderColor='#FF0000';" onmouseout="this.style.borderColor='#FBFBFB';">
									<img style="cursor:hand;" src="${contextPath}/resource/comm/images/down.png"  id="reqNodeListDownOrUpBut"  onclick="listTelescopic($('#reqNodeDescListDiv'), this)"/>
								</span>
			   			</th>
					</tr>
					<tr>
						<td style="padding:0; margin:0;">
							<div id="reqNodeDescListDiv"  style="padding:0; margin:0; height:120px; width:800px; overflow:auto;">
									<table border="1" id="reqNodeDesc" class="t1" style="width:100%;padding:0; margin:0;"> 
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
											  <th class="middle"  colspan='2' style="white-space:nowrap;"><font id="reqOperator" ><s:property value="%{getText('eaap.op2.conf.prov.operator')}" /></font></th>  					    
										  </tr>   
									    </thead>
									</table>
									<button  id="reqNodeDescAddBut"  type="button" onclick="addReqNode()" style="margin:3px; padding:0 5px;"><s:property value="%{getText('eaap.op2.conf.prov.add')}" /></button>
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
						<td style="padding:0; margin:0;">
							<div  id="rspNodeDescListDiv"  style="padding:0; margin:0; height:120px; width:800px; overflow:auto;">
									<table border="1" id="rspNodeDesc" class="t1" style="width:100%;padding:0; margin:0;"> 
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
									<button  id="rspNodeDescAddBut"  type="button" onclick="addRspNode()" style="margin:3px; padding:0 5px;"><s:property value="%{getText('eaap.op2.conf.prov.add')}" /></button>
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
	<div id="butTable"  style="display:none; text-align:center;padding-top:10px;">
		<table align="center" >
		    <tr>
		    	<td id="saveLoadImg" style="display:none;">
				  		<div style="width:auto; height:30px; line-height:30px; border:1px solid #CCCCCC; padding:0 15px;"><img src='../resource/comm/images/loading.gif'  align="absmiddle"  style="margin-right:10px;"/><s:property value="%{getText('eaap.op2.conf.wsdlImport.importing')}" /></div>
				</td>
		    	<td id="saveBut">
			  		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.importSubmit')}"  id="import"  onclick="wsdlParseSave()"></ui:button>&nbsp;&nbsp;
				</td>
		    	<td style="padding-left:20px;">
					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.return')}" id="returnBut" onclick="returnImp()" ></ui:button>&nbsp;&nbsp;
				</td>
		    	<td style="padding-left:20px;">
					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.cancel')}" id="cancelBut" onclick="location='${contextPath}/wsdlImport/wsdlImportList.shtml'"></ui:button>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>
	<table id="returnbutTable"  style="display:none;" class="mgr-table" >
	    <tr>
			<td  colspan="4"  align="center">
					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.return')}" id="returnBut" onclick="history.go(-1)" ></ui:button>&nbsp;&nbsp;
					<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.cancel')}" id="returnBut" onclick="location='${contextPath}/wsdlImport/wsdlImportList.shtml'"></ui:button>&nbsp;&nbsp;
			</td>
		</tr>
	</table>
</div>

<div id="parseResultErr"  style="padding:10px;display:none;">
	<div style='color:#FF0000; font-size:14px;'><s:property value="%{getText('eaap.op2.conf.wsdlImport.wsdlParseFailed')}" />:</div>
	<div id="parseResultErrInfo"  style="margin:5px 0 15px 0; padding:10px; border:1px solid #ccc;"></div>
	<div style="text-align:center;">
		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.wsdlImport.return')}" id="returnBut" onclick="returnImport()" ></ui:button>
	</div>
</div>

</body>
<script type="text/javascript">
var resourceAliasIsHas = true;
var resourceAliasVersionIsHas = true;

var parseResult= true;
var WsdlJson = null;
var baseIsNew = false;
var isOperatBase = false;
var dWidth=800;
var opReqContractFormatId="";
var opRspContractFormatId="";
	
$(document).ready(function(){
		initUploadify();
		objTypeOnchange();
})

$("#resourceAlias").keyup(function(){
	$("#resourceAliasIsHasMsg").html("");
	$("#resourceAliasIsHasMsg").css('display','none'); 
	$("#resourceAliasImg").html("");
	checkAliasLength();
});
$("#resourceAlias").blur(function(){
	resourceAliasCheck();
	//resourceAliasVersionCheck();
});

// $("#docVersion").keyup(function(){
// 	$("#docVersionImg").html("");
	//$("#resourceAliasImg").html("");
// 	checkVersionLength();
// });
// $("#docVersion").blur(function(){
// 		resourceAliasVersionCheck();
// });

function objTypeOnchange(){
	  var objType =  $('#importObjectType').find('option:selected').val();
	  if (objType == "1") {
		  $('#objTypeFile_tr').removeAttr('style');
		  $('#objTypeURL_tr').attr('style','display:none');
	  } else {
		  $('#objTypeFile_tr').attr('style','display:none');
		  $('#objTypeURL_tr').removeAttr('style');
	  }
}

function resourceAliasCheck(){ 
	$("#resourceAlias").val(jQuery.trim($("#resourceAlias").val())); 
	if(jQuery.trim($("#resourceAlias").val()) == ""){ 
		return; 
	}
	if(!checkAliasLength()){ 
		return;
	}
	$("#resourceAliasImg").html("<img src='../resource/comm/images/loading.gif'/>");
	var resourceAlias = jQuery.trim($("#resourceAlias").val());
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../wsdlImport/resourceAliasCheck.shtml",
	     dataType:"text",
	     data:"resourceAlias="+resourceAlias,
	     success:function(msg,data){
				$("#resourceAliasImg").html("");
				try {
		      		var jsonObj = eval('(' + msg + ')'); 
		      		var isHas = jsonObj[0].isHas;
			      	if(isHas=="false"){
			      		//New:
						resourceAliasIsHas = false;
						$("#resourceAliasIsHasMsg").html("");
						$("#resourceAliasIsHasMsg").css('display','none'); 
						$("#resourceAliasImg").html("<img src='../resource/comm/images/onCorrect.gif'/>");
			      	}else{
			      		//exist:
						resourceAliasIsHas = true;
						var resourceAliasIsHasMsg = "<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAliasIsHasMsg')}" />";
						$("#resourceAliasIsHasMsg").html(resourceAliasIsHasMsg);
						$("#resourceAliasIsHasMsg").css('display','block'); 
						$("#resourceAliasImg").html("<img src='../resource/comm/images/onError.gif'/>");
						changeTopScrollHeight();
			      	}
				} catch (e) {
					resourceAliasIsHas = true;
			      	alert("<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAliasCheck')}" />");
				}
   	  	}
	});	
}

function resourceAliasCheck_bak(){
	$("#resourceAlias").val(jQuery.trim($("#resourceAlias").val()));
	if(jQuery.trim($("#resourceAlias").val()) == ""){
		return;
	}
	if(!checkAliasLength()){
		return;
	}
	
	$("#docVersion").val(jQuery.trim($("#docVersion").val()));
	if(jQuery.trim($("#docVersion").val()) != ""){
		resourceAliasVersionCheck();
		return;
	}
	
	$("#resourceAliasImg").html("<img src='../resource/comm/images/loading.gif'/>");
	var resourceAlias = jQuery.trim($("#resourceAlias").val());
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../wsdlImport/resourceAliasCheck.shtml",
	     dataType:"text",
	     data:"resourceAlias="+resourceAlias,
	     success:function(msg,data){
				$("#resourceAliasImg").html("");
				try {
		      		var jsonObj = eval('(' + msg + ')'); 
		      		var isHas = jsonObj[0].isHas;
		      		var docVersions = jsonObj[0].docVersions;
			      	if(isHas=="false"){
			      		//New:
						resourceAliasIsHas = false;
						$("#resourceAliasIsHasMsg").html("");
						$("#resourceAliasIsHasMsg").css('display','none'); 
						$("#resourceAliasImg").html("<img src='../resource/comm/images/onCorrect.gif'/>");
			      	}else{
			      		//exist:
						resourceAliasIsHas = true;
						var resourceAliasIsHasMsg = "<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAliasIsHasMsg')}" />";
						var hasDocVersionMsg = "<s:property value="%{getText('eaap.op2.conf.wsdlImport.hasDocVersionMsg')}" />" +" "+docVersions;
						var opMsg = "<s:property value="%{getText('eaap.op2.conf.wsdlImport.opMsg')}" />";
						$("#resourceAliasIsHasMsg").html(resourceAliasIsHasMsg +"<br/>"+hasDocVersionMsg +"<br/>"+opMsg);
						$("#resourceAliasIsHasMsg").css('display','block'); 
						$("#resourceAliasImg").html("<img src='../resource/comm/images/onFocus.gif'/>");
						changeTopScrollHeight();
			      	}
				} catch (e) { 
			      	alert("<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAliasCheck')}" />");
				}
   	  	}
	});	
}

function resourceAliasVersionCheck_bak(){
	$("#resourceAlias").val(jQuery.trim($("#resourceAlias").val()));
	$("#docVersion").val(jQuery.trim($("#docVersion").val()));
	if(jQuery.trim($("#resourceAlias").val()) == ""){
		return;
	}
	if(jQuery.trim($("#docVersion").val()) == ""){
		return;
	}
	if(!checkVersionLength()){
		return;
	}
	$("#docVersionImg").html("<img src='../resource/comm/images/loading.gif'/>");
	var resourceAlias = jQuery.trim($("#resourceAlias").val());
	var docVersion = jQuery.trim($("#docVersion").val());
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../wsdlImport/resourceAliasVersionCheck.shtml",
	     dataType:"text",
	     data:"resourceAlias="+resourceAlias+"&docVersion="+docVersion,
	     success:function(msg,data){
				$("#docVersionImg").html("");
				try {
		      		var jsonObj = eval('(' + msg + ')'); 
		      		var isHas = jsonObj[0].isHas;
			      	if(isHas=="false"){
			      		//New:
						resourceAliasVersionIsHas = false;
						resourceAliasIsHas = false;
						$("#resourceAliasVersionIsHasMsg").html("");
						$("#resourceAliasVersionIsHasMsg").css('display','none'); 
						$("#docVersionImg").html("<img src='../resource/comm/images/onCorrect.gif'/>");
						$("#resourceAliasImg").html("<img src='../resource/comm/images/onCorrect.gif'/>");
			      	}else{
			      		//exist:
						resourceAliasVersionIsHas = true;
						$("#resourceAliasVersionIsHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.versionIsHasMsg')}" />");
						$("#resourceAliasVersionIsHasMsg").css('display','block'); 
						$("#docVersionImg").html("<img src='../resource/comm/images/onError.gif'/>");
			      	}
				} catch (e) {
			      	alert("<s:property value="%{getText('eaap.op2.conf.wsdlImport.resourceAliasCheck')}" />");
				}
   	  	}
	});	
}

function checkAliasLength(){
	var aLength = $("#resourceAlias").val().length;
	if(aLength>60){
		$("#resourceAliasIsHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.notexceed60char')}" />");
		$("#resourceAliasIsHasMsg").css('display','block'); 
		$("#resourceAliasImg").html("<img src='../resource/comm/images/onError.gif'/>");
		$("#resourceAlias").focus();
		return false;
	}else{
		$("#resourceAliasIsHasMsg").html("");
		$("#resourceAliasIsHasMsg").css('display','none'); 
		$("#resourceAliasImg").html("");
		return true;
	}
}

function checkVersionLength(){
	var vLength = $("#docVersion").val().length;
	if(vLength>20){
		$("#resourceAliasVersionIsHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.notexceed20char')}" />");
		$("#resourceAliasVersionIsHasMsg").css('display','block'); 
		$("#docVersionImg").html("<img src='../resource/comm/images/onError.gif'/>");
		$("#docVersion").focus();
		return false;
	}else{
		$("#resourceAliasVersionIsHasMsg").html("");
		$("#resourceAliasVersionIsHasMsg").css('display','none'); 
		$("#docVersionImg").html("");
		return true;
	}
}

//提交到解析：
function importParse(){
	if(jQuery.trim($("#resourceAlias").val()) == ""){
		$("#resourceAliasIsHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.pleaseEnterResourceAlias')}" />");
		$("#resourceAliasIsHasMsg").css('display','block'); 
		$("#resourceAliasImg").html("<img src='../resource/comm/images/onError.gif'/>");
		$("#resourceAlias").focus();
		return;
	}
	if(resourceAliasIsHas){
		return;
	}
// 	if(jQuery.trim($("#docVersion").val()) == ""){
// 		$("#resourceAliasVersionIsHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.enterDocVersion')}" />");
// 		$("#resourceAliasVersionIsHasMsg").css('display','block'); 
// 		$("#docVersionImg").html("<img src='../resource/comm/images/onError.gif'/>");
// 		$("#docVersion").focus();
// 		return;
// 	}
	var objType =  $('#importObjectType').find('option:selected').val();
	if (objType == "1") {
		$("#importFile").val($("#div_filecontainer").text());
		$('#objTypeFile_tr').removeAttr('style');
		$('#objTypeURL_tr').attr('style','display:none');
		if(jQuery.trim($("#importFile").val()) == ""){
			//$("#importFile").focus();
			return;
		}
	} else {
		$('#objTypeFile_tr').attr('style','display:none');
		$('#objTypeURL_tr').removeAttr('style');
		if(jQuery.trim($("#importURL").val()) == ""){
			$("#importURL").focus();
			return;
		}
	}
	
	$("#parseLoadImg").show();
	$("#parseBut").hide();	
	var resourceAlias = $("#resourceAlias").val();
// 	var docVersion = $("#docVersion").val();
	var importObjectType =  $("#importObjectType").val();
	var importFile = $("#importFile").val();
	var importURL = $("#importURL").val();
	var fileAttachId = $("#attach_id").val();

	$.ajax({
	     type:"post",
	     async:true,
	     url:"../wsdlImport/wsdlToParse.shtml",
	     dataType:"text",
	     //data:"resourceAlias="+resourceAlias+"&docVersion="+docVersion+"&importObjectType="+importObjectType+"&importFile="+importFile+"&importURL="+importURL+"&fileAttachId="+fileAttachId,
	     data:"resourceAlias="+resourceAlias+"&importObjectType="+importObjectType+"&importFile="+importFile+"&importURL="+importURL+"&fileAttachId="+fileAttachId,
	     success:function(msg,data){
			try {
				var getJson = JSON.parse(msg);
				WsdlJson = getJson.WsdlInfo;	//{"WsdlInfo":{...}}
		 		var isjson = typeof(WsdlJson)=="object" && Object.prototype.toString.call(WsdlJson).toLowerCase() == "[object object]" && !WsdlJson.length; 
				if(isjson){
					if(WsdlJson.RespDesc !=null && WsdlJson.RespDesc !=undefined && WsdlJson.RespDesc !="" && WsdlJson.RespCode !=null && WsdlJson.RespCode !=undefined && WsdlJson.RespCode !=""){
						//解析有问题{"RespCode":"400","RespDesc":"data is null"}
						$("#contentBox").hide();
						$("#addBox").hide();
						$("#parseResultErrInfo").html("");
						$("#parseResultErr").show();
					}else{
						//解析正常
						$("#contentBox").show();
						$("#addBox").hide();
						loadSerTree();			//加载左边树
						setForm2Info();
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
		      	$("#contentBox").hide();
				$("#addBox").hide();
				$("#parseResultErrInfo").html("");
				$("#parseResultErr").show();
		      	return;
			}
   	  	}
	});	
}

function returnImport(){
   	$("#contentBox").hide();
	$("#parseLoadImg").hide();
	$("#parseBut").show();
	$("#addBox").show();
	$("#parseResultErrInfo").html("");
	$("#parseResultErr").hide();
}

function setForm2Info(){
	$("#resourceAlias2").val($("#resourceAlias").val());
	$("#docVersion2").val($("#docVersion").val());
	$("#importObjectType2").val($("#importObjectType").val());
	$("#importFile2").val($("#importFile").val());
	$("#importURL2").val($("#importURL").val());
	$("#fileAttachId2").val($("#attach_id").val());
}





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
		//aList[i].attr("class","linkDef");
		aList[i].className = "linkDef";
	}
	selObj.className = "linkSel";
}

//加载协议基类：
function loadBaseContract(selObj){
	if(!parseResult){
		return;
	}
	isOperatBase = true;
	$("#contractObjType").val("BASE");
	var baseContractJson = WsdlJson.dataFlow.baseContract;  //协议基类
	if(baseContractJson != null){
		$("#serviceBasicInfoDiv").hide();
		$("#contractInfoDiv").show();
		$("#contractVersionInfoDiv").show();
		$("#contractFormatReqDiv").show();
		$("#contractFormatRspDiv").show();	
		$("#chooseBaseContractDiv").hide();
		$("#butTable").show();
		loadContractInfo(baseContractJson, "WsdlJson.dataFlow.baseContract");  		//2.协议基本信息
		loadContractVersion(baseContractJson.contractVersion, "WsdlJson.dataFlow.baseContract.contractVersion");   //3.协议版本基本信息
		loadContractFormats(baseContractJson.contractVersion.contractFormats, "WsdlJson.dataFlow.baseContract.contractVersion.contractFormats");				//4/5.协议版本请求/响应定义
		loadServiceUrl();  //加载URL

		if(selObj!=null && selObj!=undefined){
			setSelCss(selObj);
		}
	}else{
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
	setContractCodeBlur();
	changeTopScrollHeight();  //重新设置页面框架高度
}

//加载协议：
function loadContract(rowId, selObj){
	isOperatBase = false;
	if(WsdlJson.dataFlow.baseContract == null){
		return;
	}
	$("#contractObjType").val("FUNCTION");
	$("#funcRowId").val(rowId);
	$("#serviceBasicInfoDiv").show();
	$("#contractInfoDiv").show();
	$("#contractVersionInfoDiv").show();
	$("#contractFormatReqDiv").show();
	$("#contractFormatRspDiv").show();	

	$("#reqOperator").hide();
	$("#rspOperator").hide();
	$("#reqNodeDescAddBut").show();
	$("#rspNodeDescAddBut").show();
	var contractObj = WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts[rowId].contract;
	loadService(contractObj.contractVersion.service, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion.service");   //1.服务基本信息
	loadContractInfo(contractObj, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract");  		//2.协议基本信息
	loadContractVersion(contractObj.contractVersion, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion");   //3.协议版本基本信息
	loadContractFormats(contractObj.contractVersion.contractFormats, "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion.contractFormats");				//4/5.协议版本请求/响应定义
	
	if(selObj!=null && selObj!=undefined){
		setSelCss(selObj);
	}
	setContractCodeBlur();
	changeTopScrollHeight();  //重新设置页面框架高度
}

//1.服务基本信息：
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

//2.协议基本信息：
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

//3.协议版本基本信息：
function loadContractVersion(contractVersion, nodePath){
	var version				= contractVersion.version;
	var isNeedCheck	= contractVersion.isNeedCheck;
	var descriptor			= contractVersion.descriptor;
	$("#contractVersion").val(version);
	$("#contractVersion").attr("nodePath",nodePath+".version");
	$("#isNeedCheck").val(isNeedCheck);
	$("#isNeedCheck").attr("nodePath",nodePath+".isNeedCheck");
	$("#contractVersionDescriptor").val(descriptor);
	$("#contractVersionDescriptor").attr("nodePath",nodePath+".descriptor");
}


//4/5.协议版本请求/响应定义：  contractFormats
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
	//先删除已有的行
	 var tableObj = document.getElementById(tbname);  
	 if(tbname=="reqNodeDesc"){
			$("#reqNodeDesc tr:not(:eq(0))").remove();	
			//加载行
			if(nodeDescs !=null){
				for(var i=0; nodeDescs.length>i; i++){
					  var nodeDesc = nodeDescs[i];
					  loadReqNode(tableObj, nodeDesc, nodePath+"["+i+"]");
				}
			}
	 		$("#reqNodeDescListDiv").width(dWidth);
	 }else{
			$("#rspNodeDesc tr:not(:eq(0))").remove();
			//加载行
			if(nodeDescs !=null){
				for(var i=0; nodeDescs.length>i; i++){
					  var nodeDesc = nodeDescs[i];
					  loadRspNode(tableObj, nodeDesc, nodePath+"["+i+"]");
				}
			}
	 		$("#rspNodeDescListDiv").width(dWidth);
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
// 		  if(isOperatBase){
// 			  if(baseIsNew){
// 				  tdInnerHTML += operatBut;  
// 			  }		  
// 		  }else{
				  tdInnerHTML += operatBut;  
// 		  }
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
// 		  if(isOperatBase){
// 			  if(baseIsNew){
// 				  tdInnerHTML += operatBut;  
// 			  }		  
// 		  }else{
 				  tdInnerHTML += operatBut;  
// 		  }
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

function wsdlParseSave(){
	var saveWsdlJson = null;
	if(!baseIsNew){
		WsdlJson = checkContractNodeDesc();
		//基类协议选择已有的，保存时去掉基类协议内容
		var saveJsonStr = '{"dataFlow": {}}';
		saveWsdlJson = jQuery.parseJSON(saveJsonStr);
		saveWsdlJson.dataFlow.wsdlFileShare = WsdlJson.dataFlow.wsdlFileShare; 
		saveWsdlJson.relaPath = WsdlJson.relaPath;
	}else{
		//基类协议为新增
		WsdlJson = checkBaseContractNodeDesc();
		saveWsdlJson = WsdlJson;
	}
	var saveWsdlJsonStr = JSON.stringify(saveWsdlJson);
	$("#wsdlJson").val(saveWsdlJsonStr);
	var form = document.getElementById("myForm2");
	form.action="wsdlParseSave.shtml";
	form.submit();	
	$("#saveLoadImg").show();
	$("#saveBut").hide();
}

//基类协议: 新增的节点，节点描述的nodeCode不能为空，其值设置为跟节点名称nodeName相同：
function checkBaseContractNodeDesc(){
	var contractFormats = WsdlJson.dataFlow.baseContract.contractVersion.contractFormats;
	if(contractFormats!=null && contractFormats.length>0){
		for (var f=0; contractFormats.length>f; f++){
			var contractFormatObj = contractFormats[f];
			var nodeDescs = contractFormatObj.nodeDescs;
			for(var n=0; nodeDescs.length>n; n++){
				  var nodeDesc = nodeDescs[n];
				  var nodeNameValue = nodeDesc.nodeName;
				  if(nodeDesc.nodeCode==""){
				  		WsdlJson.dataFlow.baseContract.contractVersion.contractFormats[f].nodeDescs[n].nodeCode=nodeNameValue;
				  }
			}
		}
	}
	return WsdlJson;
}

//协议: 新增的节点，节点描述的nodeCode不能为空，其值设置为跟节点名称nodeName相同：
function checkContractNodeDesc(){
	var contractsList = WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts;
	if(contractsList!=null && contractsList.length>0){
		for (var c=0; contractsList.length>c; c++){
			var contractObj = contractsList[c];
			var contractFormatsList = contractObj.contract.contractVersion.contractFormats;
			if(contractFormatsList!=null && contractFormatsList.length>0){
				for (var f=0; contractFormatsList.length>f; f++){
					var contractFormatObj = contractFormatsList[f];
					var nodeDescs = contractFormatObj.nodeDescs;
					for(var n=0; nodeDescs.length>n; n++){
						  var nodeDesc = nodeDescs[n];
						  var nodeNameValue = nodeDesc.nodeName;
						  if(nodeDesc.nodeCode==""){
						  		WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts[c].contract.contractVersion.contractFormats[f].nodeDescs[n].nodeCode=nodeNameValue;
						  }
					}
				}
			}
		}
	}
	return WsdlJson;
}

function chooseBaseToNext(){
	dWidth=$("#chooseBaseTable").width();
	var mode =  $("#baseContratCreateMode").val();
	if (mode == "1") {
		//选择已有的：
		baseIsNew = false;
		isOperatBase = true;
		if(jQuery.trim($("#baseContractId").val()) == ""){
			alert('<s:property value="%{getText('eaap.op2.conf.wsdlImport.chooseBaseContrat')}" />');
			return;
		}
		$("#reqNodeDescAddBut").hide();
		$("#rspNodeDescAddBut").hide();
		getBaseContractInfo($("#baseContractId").val());
	} else {
		//新增：
		baseIsNew = true;
		isOperatBase = true;
		createBaseContractJson();
		
		$("#reqNodeDescAddBut").show();
		$("#rspNodeDescAddBut").show();
		$("#contractObjType").val("BASE");
		$("#chooseBaseContractDiv").hide();
		$("#contractInfoDiv").show();
		$("#contractVersionInfoDiv").show();
		$("#contractFormatReqDiv").show();
		$("#contractFormatRspDiv").show();
		$("#butTable").show();
	}
}

function loadServiceUrl(){
	var host = window.location.host;
	var serviceAgentUrl = "${serviceAgentUrl}";			//在公共配置文件（eaap_common.properties）中配置的服务引擎地址
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

function baseContratCreateModeChange(){
	  var mode =  $('#baseContratCreateMode').val();
	  if (mode == "1") {
		  $("#chooseTr").show();
	  } else {
		  $("#chooseTr").hide();
	  }
}

//生成协议基类Json
function createBaseContractJson(){
	var baseContractId = getSeq("SEQ_CONTRACT");
	var contractVersionId = getSeq("SEQ_CONTRACT_VERSION");
	var reqContractFormatId = getSeq("SEQ_CONTRACT_FORMAT");
	var rspContractFormatId = getSeq("SEQ_CONTRACT_FORMAT");
	var baseContractStr = '{"contractId": '+baseContractId+', "name": "", "code": "", "state": "A", "createTime": "", "descriptor": "", "contractVersion": {"contractVersionId": '+contractVersionId+',"contractId": '+baseContractId+',"version": "","createTime": "","isNeedCkeck": "","state": "A","effDate": "","expDate": "","descriptor": "","contractFormats": [{"contractFormatId": '+reqContractFormatId+',"contractVersionId": '+contractVersionId+',"reqRsp": "REQ", "conType": "", "xsdHeaderFor": "", "xsdFormat": "", "xsdDemo": "", "state": "A", "descriptor": "", "nodeDescs": []}, {"contractFormatId": '+rspContractFormatId+',"contractVersionId": '+contractVersionId+',"reqRsp": "RSP", "conType": "", "xsdHeaderFor": "", "xsdFormat": "", "xsdDemo": "", "state": "A", "descriptor": "", "nodeDescs": []}],"contractVersionRela": {"contractVersionRelaId": "","relaContractVersionId": "","relaTypeCd": "","state": "A","createTime": ""}}}'; 
	var baseContractJson = JSON.parse(baseContractStr); 							//由JSON字符串转换为JSON对象
	WsdlJson.dataFlow.baseContract=baseContractJson;
	setBaseContractIdValue(baseContractId);
	loadBaseContract();   //加载协议基类到页面
}

//根据ContractId获取协议基类信息
function getBaseContractInfo(baseContractId){
	$("#loadBaseImg").show();
	$("#loadBaseBut").hide();
	$("#loadchooseBaseErrorInfo").html("");
	$.ajax({
	     type:"post",
	     async:true,
	     url:"../wsdlImport/getBaseContractInfo.shtml",
	     dataType:"text",
	     data:"baseContractId="+baseContractId,
	     success:function(msg,data){
			try {
	      		//var jsonObj = eval('(' + msg + ')'); 
	      		var baseContractJson = JSON.parse(msg);
	      		if(baseContractJson.ResultCode!=null && baseContractJson.ResultCode=="Failure"){
	      			//失败
					$("#loadchooseBaseErrorInfo").show();
					$("#loadchooseBaseErrorInfo").html("<font style='color:#FF0000; font-size:16px;'>Load Protocol Base Failure ! </font><br>"+baseContractJson.ResultDesc);
	      		}else{
	      			//成功
					WsdlJson.dataFlow.baseContract=baseContractJson;
					setBaseContractIdValue(baseContractId);
		      		loadBaseContract();   //加载协议基类到页面
	      		}
			} catch (e) {
				//失败
				$("#loadchooseBaseErrorInfo").show();
				$("#loadchooseBaseErrorInfo").html("<font style='color:#FF0000; font-size:16px;'>Load Protocol Base Failure ! </font><br>"+baseContractJson);
			}
			$("#loadBaseImg").hide();
			$("#loadBaseBut").show();
  	  	}
	});	
}

//修改JSON中BaseContractId节点的值：
function setBaseContractIdValue(baseContractId){
	var contracts = WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts;
	if(contracts!=null && contracts.length>0){
		for (var i=0; contracts.length>i; i++){
			WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts[i].contract.baseContractId = baseContractId;
		}
	}
}

function addReqNode() {
	var value = decideNull('reqNodeDescName');
	if(value == 1){
		return;
	}
	var nodeDescId =  getSeq("SEQ_NODE_DESC");
	var nodeDescStr = '{"nodeDescId": "'+nodeDescId+'", "parentNodeId":"", "contractFormatId": "'+opReqContractFormatId+'", "nodeName": "", "nodeCode": "", "nodePath": "", "nodeType": "1", "nodeLengthCons": "", "nodeTypeCons": "1", "nodeNumberCons": "1", "nevlConsType": "1", "nevlConsValue": "", "nevlConsDesc": "", "isNeedCheck": "Y", "isNeedSign": "Y", "state": "A", "createTime": "", "javaField": "", "description": ""}'
	var nodeJson = JSON.parse(nodeDescStr); 
	var nodePath =getNodeDescsPath("REQ", nodeJson);
	loadReqNode(document.getElementById("reqNodeDesc"), nodeJson, nodePath);
}
function addRspNode() {
	var value = decideNull('rspNodeDescName');
	if(value == 1){
		return;
	}
	var nodeDescId =  getSeq("SEQ_NODE_DESC");
	var nodeDescStr = '{"nodeDescId": '+nodeDescId+', "parentNodeId":"", "contractFormatId": "'+opRspContractFormatId+'", "nodeName": "", "nodeCode": "", "nodePath": "", "nodeType": "1", "nodeLengthCons": "", "nodeTypeCons": "1", "nodeNumberCons": "1", "nevlConsType": "1", "nevlConsValue": "", "nevlConsDesc": "", "isNeedCheck": "Y", "isNeedSign": "Y", "state": "A", "createTime": "", "javaField": "", "description": ""}'
	var nodeJson = JSON.parse(nodeDescStr); 
	var nodePath =getNodeDescsPath("RSP", nodeJson);
	loadRspNode(document.getElementById("rspNodeDesc"), nodeJson, nodePath);
}

function getNodeDescsPath(rReqRsp, nodeJson){
	var nodePath = "";
	if(isOperatBase){
		//基类协议
		var contractFormats = WsdlJson.dataFlow.baseContract.contractVersion.contractFormats;
		if(contractFormats!=null && contractFormats.length>0){
			for (var i=0; contractFormats.length>i; i++){
				var contractFormatObj = contractFormats[i];
				var reqRsp			= contractFormatObj.reqRsp;
				if(reqRsp==rReqRsp){
					var nodeDescs	= contractFormatObj.nodeDescs;
					var n = nodeDescs.length;
					WsdlJson.dataFlow.baseContract.contractVersion.contractFormats[i].nodeDescs.push(nodeJson);
					nodePath = "WsdlJson.dataFlow.baseContract.contractVersion.contractFormats["+i+"].nodeDescs["+n+"]";
					break;
				}
			}
		}
	}else{
		//方法
		var rowId = $("#funcRowId").val();
		var contractFormats = eval("WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion.contractFormats");
		if(contractFormats!=null && contractFormats.length>0){
			for (var i=0; contractFormats.length>i; i++){
				var contractFormatObj = contractFormats[i];
				var reqRsp			= contractFormatObj.reqRsp;
				if(reqRsp==rReqRsp){
					var nodeDescs	= contractFormatObj.nodeDescs;
					var n = nodeDescs.length;
					WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts[rowId].contract.contractVersion.contractFormats[i].nodeDescs.push(nodeJson);
					nodePath = "WsdlJson.dataFlow.wsdlFileShare.contractDoc.contracts["+rowId+"].contract.contractVersion.contractFormats["+i+"].nodeDescs["+n+"]";
					break;
				}
			}
		}
	}
	return nodePath;
}

function getSeq(seqName){
	var seqValue ="";
	$.ajax({
	     type:"post",
	     async:false,
	     url:"../wsdlImport/getSeq.shtml",
	     dataType:"text",
	     data:"seqName="+seqName,
	     success:function(msg,data){
			try {
				var jsonObj = eval('(' + msg + ')'); 
				seqValue = jsonObj[0].seqValue;
			} catch (e) {
				//失败
			}
   	  	}
	});	
	return seqValue;
}

//新增协议基类时验证输入的协议编号（Protocol Code）号是否已存在
function setContractCodeBlur(){
	if(isOperatBase && baseIsNew){
		$("#contractCode").keyup(function(){
			$("#holdImg").html("");
			$("#isHasMsg").html("");
			$("#isHasMsg").css('display','none'); 
		});
		$("#contractCode").blur(function(){
			hasContractByCode();
		});
	}else{
		$("#holdImg").html("");
		$("#isHasMsg").html("");
		$("#isHasMsg").css('display','none'); 
	}
}
function hasContractByCode(){
	if(isOperatBase && baseIsNew){
			$("#contractCode").val(jQuery.trim($("#contractCode").val()));
			if(jQuery.trim($("#contractCode").val()) == ""){
				return;
			}
			$("#holdImg").html("<img src='../resource/comm/images/loading.gif' align='absmidden'/>");
			var contractCode = jQuery.trim($("#contractCode").val());
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../wsdlImport/hasContractByCode.shtml",
			     dataType:"text",
			     data:"contractCode="+contractCode,
			     success:function(msg,data){
						$("#holdImg").html("");
						try {
				      		var jsonObj = eval(msg); 
				      		var isHas = jsonObj[0].isHas;
				      		var docVersions = jsonObj[0].docVersions;
					      	if(isHas=="false"){
					      		//New:
								contractVersionIsHas = false;
								$("#holdImg").html("<img src='../resource/comm/images/onCorrect.gif'/>");
								$("#isHasMsg").html("");
								$("#isHasMsg").css('display','none'); 
					      	}else{
					      		//exist:
								contractVersionIsHas = true;
								$("#holdImg").html("<img src='../resource/comm/images/onFocus.gif'/>");
								$("#isHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.contractCodeIsHas')}" />");
								$("#isHasMsg").css('display','block'); 
					      	}
						} catch (e) { 
								$("#holdImg").html("<img src='../resource/comm/images/onFocus.gif'/>");
								$("#isHasMsg").html("<s:property value="%{getText('eaap.op2.conf.wsdlImport.contractCodeCheckFailed')}" />");
								$("#isHasMsg").css('display','block'); 
						}
		   	  	}
			});	
	}
}

function returnImp(){
	WsdlJson = null;
	$("#contentBox").hide();
	$("#addBox").show();
	$("#serTree").html("");
	
	$("#serviceUrlDiv").hide();
	$("#serviceBasicInfoDiv").hide();
	$("#contractInfoDiv").hide();
	$("#contractVersionInfoDiv").hide();
	$("#contractFormatReqDiv").hide();
	$("#contractFormatRspDiv").hide();	
	$("#chooseBaseContractDiv").hide();
	$("#butTable").hide();
	$("#returnbutTable").hide();
		
	$("#parseLoadImg").hide();
	$("#parseBut").show();	
}

</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
