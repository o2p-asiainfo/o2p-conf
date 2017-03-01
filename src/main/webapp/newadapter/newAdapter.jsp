<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<meta charset="utf-8" />
<title>Telenor Open Operational Platform</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
	<link rel="stylesheet" type="text/css"  href="${contextPath}/resource/bootstrap/css/GooFlow.css">
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="${contextPath}/resource/bootstrap/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/bootstrap/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/bootstrap/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
<link href="${contextPath}/resource/bootstrap/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/bootstrap/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/bootstrap/plugins/bootstrap-datepicker/datepicker.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/bootstrap/plugins/bootstrap-switch/bootstrap-switch.min.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/bootstrap/plugins/select2/select2.min.css" />
<!-- END PAGE LEVEL PLUGIN STYLES -->

<!-- BEGIN THEME STYLES -->
<link href="${contextPath}/resource/bootstrap/css/style-template.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/bootstrap/css/style.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/bootstrap/css/themes/orange.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="${contextPath}/resource/bootstrap/css/style-responsive.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/bootstrap/css/custom.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript"  src="${contextPath}/resource/bootstrap/scripts/Math.uuid.js"></script>
	<script type="text/javascript"  src="${contextPath}/resource/bootstrap/scripts/GooFlow.js"></script>
    <script src="${contextPath}/resource/bootstrap/plugins/jquery-1.10.2.min.js" type="text/javascript"></script> 
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <script >
    var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.adapter.sourceNode')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.adapter.targetNode')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.adapter.operation')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.adapter.operationValue')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.adapter.stillNode')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.adapter.sureDelete')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.adapter.moveIsExit')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.adapter.updateTomove')}" />';
	title[8]='<s:property value="%{getText('eaap.op2.conf.adapter.updateIsExit')}" />';
	title[9]='<s:property value="%{getText('eaap.op2.conf.adapter.sureUpdate')}" />';
	title[10]='<s:property value="%{getText('eaap.op2.conf.adapter.otherIsExit')}" />';
	title[11]='<s:property value="%{getText('eaap.op2.conf.adapter.updateToOther')}" />';
	title[12]='<s:property value="%{getText('eaap.op2.conf.adapter.assignIsExit')}" />';
	title[13]='<s:property value="%{getText('eaap.op2.conf.adapter.updateToAssign')}" />';
	title[14]='<s:property value="%{getText('eaap.op2.conf.adapter.rowToColumnIsExit')}" />';
	title[15]='<s:property value="%{getText('eaap.op2.conf.adapter.rowToColumnSure')}" />';
	title[16]='<s:property value="%{getText('eaap.op2.conf.adapter.columnToRowIsExit')}" />';
	title[17]='<s:property value="%{getText('eaap.op2.conf.adapter.columnToRowSure')}" />';
	var dataError = '<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}" />';
	var risExist = '<s:property value="%{getText('eaap.op2.conf.protocol.RisExit')}" />';
	var intoProExist = '<s:property value="%{getText('eaap.op2.conf.protocol.IntoisExit')}" />';
	var notDelSrc = '<s:property value="%{getText('eaap.op2.conf.protocol.error.notDel')}" />';
	var nodeUsed = '<s:property value="%{getText('eaap.op2.conf.protocol.error.nodeused')}" />';
	var srcDel = '<s:property value="%{getText('eaap.op2.conf.protocol.error.srcDel')}" />';
	var chooseRecords = '<s:property value="%{getText('eaap.op2.conf.protocol.error.chooseRecords')}" />';
	var notchooseTar = '<s:property value="%{getText('eaap.op2.conf.protocol.error.canotSelectTar')}" />';
	var addFirst = '<s:property value="%{getText('eaap.op2.conf.protocol.error.addfirst')}" />';
	var keyExpnotnull = '<s:property value="%{getText('eaap.op2.conf.protocol.error.keyexpnotnull')}" />';
	var canotbeempty = '<s:property value="%{getText('eaap.op2.conf.protocol.error.canotbeempty')}" />';
	var toolong = '<s:property value="%{getText('eaap.op2.conf.protocol.error.toolong')}" />';
	var nodeBeUsed='<s:property value="%{getText('eaap.op2.conf.protocol.error.nodeBeused')}" />';
	var notchooseSrc = '<s:property value="%{getText('eaap.op2.conf.protocol.error.canotSelectSrc')}" />';
	var dataDoerror = '<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>';
	
	var globalCondition='<s:property value="%{getText('eaap.op2.conf.adapter.globalCondition')}" />';
	var addSegment='<s:property value="%{getText('eaap.op2.conf.adapter.addSegment')}" />';
	var condition='<s:property value="%{getText('eaap.op2.conf.adapter.condition')}" />';
	var expression='<s:property value="%{getText('eaap.op2.conf.adapter.expression')}" />';
	var finalValue='<s:property value="%{getText('eaap.op2.conf.adapter.finalValue')}" />';
	var segment='<s:property value="%{getText('eaap.op2.conf.adapter.segment')}" />';
	var variable='<s:property value="%{getText('eaap.op2.conf.adapter.variable')}" />';
    </script>
</head>
<body>
<!-- 隐藏域区间 -->
<!-- 是选源还是选目标节点的动作类型 -->
<input type="hidden" id="selectActioin">
<!-- 协议转化ID -->
<input  type="hidden" name="pageContractAdapterId" id="pageContractAdapterId" value="${pageContractAdapterId}"/>
<!-- 源协议ID -->
<input  type="hidden" name="pageSrcTcpCtrFId" id="pageSrcTcpCtrFId" value="${pageSrcTcpCtrFId}"/>
<!-- 目标协议ID -->
<input  type="hidden" name="pageTarTcpCtrFId" id="pageTarTcpCtrFId" value="${pageTarTcpCtrFId}"/>
<!-- 端点ID -->
<input  type="hidden" name="pageEndpointId" id="pageEndpointId" value="${pageEndpointId}"/>
<!-- 源节点ID -->
<input  type="hidden" name="pageSrcNodeDescId" id="pageSrcNodeDescId"/>
<!-- 目标节点ID -->
<input  type="hidden" name="pageTarNodeDescId" id="pageTarNodeDescId"/>
<!-- 节点取值要求ID -->
<input  type="hidden" name="pageNodeReqId" id="pageNodeReqId"/>
<!-- 常量映射类型编码 -->
<input  type="hidden" name="pageConsMapCDFinal" id="pageConsMapCDFinal"/>
<!-- 变量映射表ID-->
<input  type="hidden" name="pageVarMappingId" id="pageVarMappingId"/>
<!-- 添加或者修改标记位-->
<input  type="hidden" name="saveOrUpdateFlag" id="saveOrUpdateFlag"/>
<!-- 消息流参数 -->
<input  type="hidden" name="pageState" id="pageState" value="${pageState}"/>
<input  type="hidden" name="attrName" id="attrName" value="${attrName}"/>
<input  type="hidden" name="objectId" id="objectId" value="${objectId}"/>
<input  type="hidden" name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" value="${endpoint_Spec_Attr_Id}"/>
<input type="hidden" name="newState" id="newState" value="${newState}">
<input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
<!--body start -->
<div class="Content">
<ul id="myTab" class="nav nav-tabs">
   <li class="active">
      <a href="#commonAdapter" onclick="javascript:onclickTab(1);" data-toggle="tab">
         <s:property value="%{getText('eaap.op2.conf.adapter.universalAdapter')}" />
      </a>
   </li>
   <li><a href="#scriptAdapter" onclick="javascript:onclickTab(2);" data-toggle="tab">
   <s:property value="%{getText('eaap.op2.conf.adapter.scriptAdapter')}" />
   </a></li>
</ul>
<div id="myTabContent" class="tab-content">
   <div class="tab-pane fade in active" id="commonAdapter">
	<div class="choose">
    	<span><s:property value="%{getText('eaap.op2.conf.adapter.srcContract')}" /></span>
    	<input   type="hidden" name="srcContractName" id="srcContractName" readonly="readonly"/>
    	<input   type="hidden" name="srcContractVersionName" id="srcContractVersionName" readonly="readonly"/>
    	<input   type="hidden" name="srcContractType" id="srcContractType" readonly="readonly"/>
    	<input type="button"  value="<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.choose')}" />"  id="chooseLeft" class="submit"  data-toggle="modal" data-target="#myModal">
    	<span style="margin-left:500px"><s:property value="%{getText('eaap.op2.conf.adapter.tarContract')}" /></span>
    	<input   type="hidden" name="tarContractName" id="tarContractName" readonly="readonly"/>
    	<input   type="hidden" name="tarContractVersionName" id="tarContractVersionName" readonly="readonly"/>
    	<input   type="hidden" name="tarContractType" id="tarContractType" readonly="readonly"/>
    	<input type="button" value="<s:property value="%{getText('eaap.op2.conf.remoteCallInfo.choose')}" />"  id="chooseRight" class="submit"  data-toggle="modal"/>
    </div>
	<div id="Adapter">
	    <!-- 拉线操作区 -->
		<div id="UniversalAdapterDemo" class="GooFlow">
		<!-- 色彩说明区 
		<div class='colorillustrate'>
			<span class='sp1'></span><s:property value="%{getText('eaap.op2.conf.protocol.intoprotocol')}" />
			<span class='sp2'></span><s:property value="%{getText('eaap.op2.conf.protocol.TAction')}" />
			<span class='sp3'></span><s:property value="%{getText('eaap.op2.conf.protocol.RAction')}" />
		</div>
		-->
		</div>	 
		<!-- 表格展示区 -->
		<div id="FlowTable"></div>  
	</div>
	<!-- 适配提交按钮 -->
   <p class="text-center">
   <input type="button" class="btn green" value="<s:property value="%{getText('eaap.op2.conf.prov.define')}" />" id="adapterButton">
   <input type="button" data-dismiss="modal" id="adapterMissButton" class="btn green margin-left-10" value="<s:property value="%{getText('eaap.op2.conf.prov.close')}" />">
   </p>
   </div>
   <!-- 脚本转化配置区 -->
      <div class="tab-pane fade" id="scriptAdapter">
   		<div  class="adaptip">
    		<s:property value="%{getText('eaap.op2.conf.adapter.contractMaping')}" />
    	</div>
        <div>
        	<table width="100%"  class="table table-bordered">
  				<tr>
    				<td width="20%"><s:property value="%{getText('eaap.op2.conf.adapter.scriptType')}" /></td>
    				<td width="80%"><div class="input-group" style="padding:0; margin:0">
 
          <select class="js-example-placeholder-single form-control" id="adapterType" placeholder="name" style="width:150px">
            <c:forEach var="obj" items="${scriptL}" varStatus="scriptList">
			    <option value="${obj.id}" <c:if test="${obj.id == pageAdapterType}">selected</c:if>>${obj.val}</option>
			</c:forEach>
          </select>
        </div></td>
  				</tr>
  				<tr>
    				<td><s:property value="%{getText('eaap.op2.conf.adapter.scriptUpload')}" /></td>
    				<td><input type="file" name="scriptFileUpload" id="scriptFileUpload" size="30" value=""class="sys-text-area" ></td>
  				</tr>
  				<tr>
    				<td><s:property value="%{getText('eaap.op2.conf.adapter.contractScript')}" /></td>
    				<td><textarea class="box2" onmouseover="this.className='box2'" onmouseout="this.className='box1'" type="text" style="WIDTH: 850px; HEIGHT:280px;" id="scriptFileText" name="scriptFileText">${pageScriptFileText}</textarea></td>
  				</tr>
                
			</table>

        </div>
        <!-- 脚本提交按钮 -->
        <p class="text-center">
        <input type="button" class="btn green" value="<s:property value="%{getText('eaap.op2.conf.prov.define')}" />" id="scritpButton">
        <input type="button" class="btn green margin-left-10" value="<s:property value="%{getText('eaap.op2.conf.prov.close')}" />" onclick="javascript:closeAdapterWindow();">
        </p>
   </div>
</div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:1000px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               <s:property value="%{getText('eaap.op2.conf.protocol.chooseProtocol')}"/>
            </h4>
         </div>
         <div class="contionfilter clearfix">
         
         	<div class="input-group1 mr20">
          <label for=""><span class="input-group-text"><s:property value="%{getText('eaap.op2.conf.adapter.contractName')}"/>:</span> </label>
          <input type="text" name="pageProtocolName" id="pageProtocolName"/>
          
        </div>
        <div class="input-group1 mr20">
           <label for=""><span class="input-group-text"><s:property value="%{getText('eaap.op2.conf.adapter.contractVersion')}" />:</span> </label>
           <input type="text" name="pageContractVersion" id="pageContractVersion"/>
        </div>
        <div class="input-group1 mr20">
          <label for=""><span class="input-group-text"><s:property value="%{getText('eaap.op2.conf.adapter.contractType')}" />:</span></label>
          <select name="pageProtocolType" id="pageProtocolType" class="js-example-placeholder-single form-control mr20" placeholder="name" style="width:150px">
            <option value="">ALL</option>
            <c:forEach var="obj" items="${contractTypeList}" varStatus="listcontractTypeList">
			    <option value="${obj.key}">${obj.value}</option>
			</c:forEach>
          </select>
        </div>
        <div class="input-group1 mr20">
          <label for=""><span class="input-group-text"><s:property value="%{getText('eaap.op2.conf.adapter.httpType')}" />:</span></label>
          <select name="pageReqRsp" id="pageReqRsp" class="js-example-placeholder-single form-control mr20" placeholder="name" style="width:150px">
            <option value="">ALL</option>
            <c:forEach var="obj" items="${httpTypeList}" varStatus="listhttpTypeList">
			    <option value="${obj.key}">${obj.value}</option>
			</c:forEach>
          </select>
        </div>
        <input type="button" class="btn btn-primary query" id="queryContract" value='<s:property value="%{getText('eaap.op2.conf.logaudit.typequery')}" />'>
         </div>
         <div class="modal-body" style="padding-bottom:0;">
            <div class="container" style="width:100%; padding-bottom:0">
    <div class="portlet box s-protlet-theme">
      <div class="portlet-title">
        <div class="caption"><s:property value="%{getText('eaap.op2.conf.protocol.contractMessage')}" /></div>
        
      </div>
      <div class="portlet-body">
        <table class="table table-bordered table-striped table-hover text-center nowrap-ingore group-check" id="dt">
          <thead>
            <tr>
              <th>
              </th>
              <th> <s:property value="%{getText('eaap.op2.conf.adapter.contractName')}"/> </th>
              <th> <s:property value="%{getText('eaap.op2.conf.adapter.contractVersion')}" /></th>
              <th> <s:property value="%{getText('eaap.op2.conf.adapter.contractType')}" /></th>
              <th> <s:property value="%{getText('eaap.op2.conf.adapter.httpType')}" /></th>
              <th> <s:property value="%{getText('eaap.op2.conf.protocol.TCP_CTR_F_ID')}" /></th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
  </div>
         </div>
         <div class="modal-footer" style="margin-top:10px;">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">
               <s:property value="%{getText('eaap.op2.conf.prov.close')}" />
            </button>
            <button type="button" id="chooseContract" class="btn btn-primary">
              <s:property value="%{getText('eaap.op2.conf.prov.define')}" />
            </button>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
<!-- 条件值配置区 -->
<div class="modal fade" id="chooseTemplate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:1020px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel2">
               	<s:property value="%{getText('eaap.op2.conf.protocol.chooseProtocol')}"/>
            </h4>
         </div>
         
         <ul id="chooseTab2" class="nav nav-tabs margin-top-10">
   				<li class="active"><a href="#fixedA" data-toggle="tab"><s:property value="%{getText('eaap.op2.conf.adapter.fixAssign')}" /></a> </li>
   				<!-- <li><a href="#JavaBeanA" data-toggle="tab"><s:property value="%{getText('eaap.op2.conf.adapter.javaAssign')}" /></a></li> -->
                <li><a href="#metaData" data-toggle="tab"><s:property value="%{getText('eaap.op2.conf.adapter.metaDataMatch')}" /></a></li>
                <li><a href="#asignfix2" data-toggle="tab"><s:property value="%{getText('eaap.op2.conf.adapter.assignmentCondition')}" /></a> </li>
		 </ul> 
         <div class="tab-content clearfix" style="padding:0 10px 10px 10px" c>
         	<div id="fixedA" class="tab-pane fade in active tab-content-m">
            	<p><label class="col-md-2 text-right" style="padding-top:5px"><s:property value="%{getText('eaap.op2.conf.adapter.nodePath')}" />:</label><input class="form-control" style="width:300px" type="text" name="pageNodePath" id="pageNodePath" readonly></p>
                <p><label class="col-md-2 text-right" style="padding-top:5px"><s:property value="%{getText('eaap.op2.conf.adapter.nodeValue')}" />:</label><input type="text" class="form-control" style="width:300px" name="pageNodeValue" id="pageNodeValue"></p>
                <div class="modal-footer margin-top-10">
       				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText('eaap.op2.conf.prov.close')}" /></button>
        			<button type="button" class="btn btn-primary" id="pageTypeOneSubmit"><s:property value="%{getText('eaap.op2.conf.prov.define')}" /></button>
     			</div>
            </div>
            <!--
         	<div id="JavaBeanA" class="tab-pane fade  tab-content-m">
	        	<p><s:property value="%{getText('eaap.op2.conf.adapter.codeFrag')}" /></p>
	            <textarea name="pageJavaBean" id="pageJavaBean" style="width:100%; HEIGHT:90px;"></textarea>
	            <div class="modal-footer">
	   				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText('eaap.op2.conf.prov.close')}" /></button>
	    			<button type="button" class="btn btn-primary" id="pageTypeTwoSubmit"><s:property value="%{getText('eaap.op2.conf.prov.define')}" /></button>
	 			</div>
	         </div>
	         -->
         	<div id="metaData" class="tab-pane fade">
	        	<div class="tab-pane-p">
	        	<label><s:property value="%{getText('eaap.op2.conf.adapter.varMapType')}" />:</label><input type="text" id="pageConsMapCD" name="pageConsMapCD">
	        	<label><s:property value="%{getText('eaap.op2.conf.adapter.name')}" />:</label><input type="text" id="pageConsMapName" name="pageConsMapName">
	        	<button class="btn btn-primary"  id="pageWinSelect" data-toggle="modal" data-target="#MetaData"><s:property value="%{getText('eaap.op2.conf.remoteCallInfo.choose')}" /></button>
	        	<button class="btn btn-primary" id="ConsMapButton"><s:property value="%{getText('eaap.op2.conf.prov.submit')}" /></button></div>
	            <div class="container  margin-top-10" style="width:100%; ">
				<div class="portlet box s-protlet-theme">
					<div class="portlet-title">
	
							<div class="caption"> <s:property value="%{getText('eaap.op2.conf.protocol.variables')}" /> </div>
								<div class="actions">
	 						 	<button class="btn green" id="btn-add2" data-toggle="modal">
	 						 	<i class="fa fa-plus"></i> <s:property value="%{getText('eaap.op2.conf.protocol.Add')}" /> </button>
	  							<button class="btn blue" id="btn-edit2"><i class="fa fa-edit"></i> <s:property value="%{getText('eaap.op2.conf.protocol.Edit')}" /> </button>
	  							<button class="btn red" id="btn-del2"><i class="fa fa-trash-o"></i> <s:property value="%{getText('eaap.op2.conf.protocol.Del')}" /> </button>
								</div>
						</div>
						<div class="portlet-body">
								<table class="table table-bordered table-striped table-hover text-center nowrap-ingore group-check" id="dt2">
	  							<thead>
	    						<tr>
	      							<th></th>
	      							<th> <s:property value="%{getText('eaap.op2.conf.adapter.varMapingId')}"/> </th>
	      							<th> <s:property value="%{getText('eaap.op2.conf.adapter.dataSource')}"/></th>
	      							<th> <s:property value="%{getText('eaap.op2.conf.adapter.keyExpress')}"/></th>
	      							<th> <s:property value="%{getText('eaap.op2.conf.adapter.valExpress')}"/></th>
	     							<th> <s:property value="%{getText('eaap.op2.conf.adapter.state')}"/> </th>
	    						</tr>
	 							 </thead>
	 							<tbody>
	  							</tbody>
								</table>
						</div>
					</div>
				</div>
	            <div class="modal-footer">
   				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText('eaap.op2.conf.prov.close')}" /></button>
    			<button type="button" class="btn btn-primary" id="pageTypeThreeSubmit"><s:property value="%{getText('eaap.op2.conf.prov.define')}" /></button>
 			</div>
        	</div>
         	<div id="asignfix2" class="tab-pane fade tab-content-m adaper-transform"  >
            	<div class="col-md-12 margin-top-10 partcontain">
                	<div style="padding:10px; border:1px solid #dfdfdf"><label class="control-label" style="width:auto"><s:property value="%{getText('eaap.op2.conf.adapter.globalCondition')}" />:</label><div class="input-group margin-left-10" style="display:inline-block"> <input class="form-control" id="globalCondition" style="width:410px; display:none" type="text" readonly placeholder="XPath"> <span class="input-group-btn"   data-target="none" style="display:none"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-remove"></i></button> </span><span class="input-group-btn"   data-target="condition" style="display:inline-block;"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-plus"></i></button> </span> </div>
                    </div>
    			<div class="col-md-12 margin-top-10 partcontain"  id="transformMain">
                	<div class="btn-group">
                    	<button data-add="case" class="btn btn-success" type="button"> <i class="glyphicon glyphicon-plus"></i> <s:property value="%{getText('eaap.op2.conf.adapter.addSegment')}" /> </button>
                    </div>
                 </div>
             </div>
             <div class="col-md-12 margin-top-10  partcontain" style="border:1px solid #ccc; padding:10px" id="FinalValpress">
                 <label class="control-label"><span class="red">*</span></span><s:property value="%{getText('eaap.op2.conf.adapter.finalValue')}" />:</label><div class="input-group" style="display:inline-block"> <input class="form-control" style="width:410px;" type="text" readonly placeholder="XPath"> <span class="input-group-btn"   data-target="final" style="display:inline-block"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button> </span> </div>
             </div>
              <div class="modal-footer clearfix" style="padding-top:15px;margin-top:10px;">
              	<input class="btn btn-default"  type="button" value='<s:property value="%{getText('eaap.op2.conf.prov.close')}" />'  data-dismiss="modal" aria-hidden="true">
              	<input type="button" id="subConditionReqVal" value='<s:property value="%{getText('eaap.op2.conf.prov.define')}" />' class="btn btn-primary">
              </div> 
         </div>
         </div>    
            
         </div>
         </div>
		</div>
<!-- /.modal -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="dataMatch" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:400px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
                <s:property value="%{getText('eaap.op2.conf.adapter.metaDataMatch')}"/>
            </h4>
         </div>
         <div class="modal-body" style="padding-bottom:0">
           <div class="container " style="width:100%; padding-bottom:0 ">
       <table  class="table  table-bordered">
         <tr>
           <td class="text-right line-h34"><s:property value="%{getText('eaap.op2.conf.adapter.dataSource')}"/></td>
           <td>
          <div class="input-group" style="padding-bottom:0">
          <select class="js-example-placeholder-single form-control mr20" id="pageDataSource" placeholder="name" style="width:150px">
            <c:forEach var="obj" items="${metaDataMachingL}" varStatus="metaDataMachingList">
			    <option value="${obj.id}">${obj.val}</option>
			</c:forEach>
          </select>
        </div></td>
         </tr>
         <tr>
           <td class="text-right line-h34"><s:property value="%{getText('eaap.op2.conf.adapter.keyExpress')}"/></td>
           <td><div class="input-group3"><input type="text" id="pageKeyExp"></div></td>
         </tr>
         <tr>
           <td class="text-right line-h34"><s:property value="%{getText('eaap.op2.conf.adapter.valExpress')}"/></td>
           <td><div class="input-group3"><input type="text" id="pageValExp"></div></td>
         </tr>
       </table>
           </div>
         <div class="modal-footer" style="margin-top:10px">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal"><s:property value="%{getText('eaap.op2.conf.prov.close')}" />
            </button>
            <button type="button" class="btn btn-primary"  id="ProtocolMChoose">
               <s:property value="%{getText('eaap.op2.conf.prov.define')}" />
            </button>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="dataidienty" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
  <div class="modal-dialog"  style="width:360px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
                <s:property value="%{getText('eaap.op2.conf.protocol.error.Relatedendpoint')}" />  
            </h4>
         </div>
         <div class="modal-body" style="padding-bottom:0">
           <div class="container " style="width:100%; padding-bottom:0 ">
       <table  class="table  table-bordered">
         <tr>
           <td class="text-right line-h34"><s:property value="%{getText('eaap.op2.conf.protocol.error.endpointId')}" /></td>
           <td>
           <!-- 
           <div class="input-group3"><input type="text" id="ProtocolId"></div> -->
           <div class="input-group" style="padding-bottom:0">
          <select class="js-example-placeholder-single form-control mr20" id="ProtocolId" placeholder="name" style="width:150px">
            <c:forEach var="obj" items="${moreSourceList}" varStatus="metaDataMachingList">
			    <option value="${obj.id}">${obj.val}</option>
			</c:forEach>
          </select>
        </div>
           </td>
         </tr>
       </table>
           </div>
         <div class="modal-footer" style="margin-top:10px">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal"><s:property value="%{getText('eaap.op2.conf.prov.close')}" />
            </button>
            <button type="button" class="btn btn-primary"  id="pageMessageButton">
               <s:property value="%{getText('eaap.op2.conf.prov.define')}" />
            </button>
         </div>
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="MetaData" tabindex="-1" role="dialog" 
  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:660px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel2">
            <s:property value="%{getText('eaap.op2.conf.protocol.msg.chooseTemplate')}" />
            </h4>
         </div>
         <div class="modal-body">
            <div class="tab-content">
            	<div id="MetaDM">
                	<div class="tab-pane-p">
                	<label><s:property value="%{getText('eaap.op2.conf.adapter.varMapType')}" />:</label><input type="text" id="pageWinVarType">
                	<label><s:property value="%{getText('eaap.op2.conf.adapter.name')}" />:</label><input type="text" id="pageWinName">
                	<button class="btn btn-primary" id="pageWinQuery"><s:property value="%{getText('eaap.op2.conf.logaudit.typequery')}" /></button>
                	</div>
                    <div class="container  margin-top-10" style="width:100%; ">
    					<div class="portlet box s-protlet-theme">
      						<div class="portlet-title">

        						<div class="caption"> <s:property value="%{getText('eaap.op2.conf.adapter.varMapType')}" /> </div>
        							<div class="actions" style="padding-top:5px;">
          							<button class="btn red" id="pageWinDel"><i class="fa fa-trash-o"></i> <s:property value="%{getText('eaap.op2.conf.protocol.Del')}" /> </button>
        							</div>
      							</div>
      							<div class="portlet-body">
        							<table class="table table-bordered table-striped table-hover text-center nowrap-ingore group-check" id="dt3">
          							<thead>
            						<tr>
              							<th></th>
              							<th> ID </th>
              							<th> <s:property value="%{getText('eaap.op2.conf.adapter.varMapType')}" /></th>
              							<th> <s:property value="%{getText('eaap.op2.conf.adapter.name')}" /></th>
            						</tr>
         							 </thead>
         							<tbody>
          							</tbody>
       								</table>
      							</div>
      							<div class="tab-pane-p">
                	<label><s:property value="%{getText('eaap.op2.conf.adapter.varMapType')}" />:</label><input type="text" id="addVarType">
                	<label><s:property value="%{getText('eaap.op2.conf.adapter.name')}" />:</label><input type="text" id="addTypeName">
                	<button class="btn btn-primary" id="addType"><s:property value="%{getText('eaap.op2.conf.protocol.Add')}" /></button>
                	</div>
    						</div>
  						</div>
         			
                    <div class="modal-footer">
           				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText('eaap.op2.conf.prov.close')}" /></button>
            			<button type="button" class="btn btn-primary" id="pageWinOK"><s:property value="%{getText('eaap.op2.conf.prov.define')}" /></button>
         			</div>
                    </div>
                   
                </div>
            </div>
            	
      			</div><!-- /.modal-content -->
</div><!-- /.modal -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="ExtractModal" tabindex="-1" role="dialog" 
  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:660px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel2">
               模态框（Modal）标题
            </h4>
         </div>
         <div class="modal-body">
            <div class="tab-content">
           	  <div id="MetaDM">
              		<div class="ddd" style="width:200px">
                    <p class="extractradio"><label><input type="radio" checked="checked" name="ct">String类型截取</label></p>
                    <p class="extractradio"><label><input type="radio" name="ct">数组获取</label></p>
                    </div>
                	<div class="extractRemarks">
                    	<div class="RemarksDetail">
                        	<dl><dt>配置说明：</dt><dd>'nodeDescId'.substring(start, end)。nodeDescId源节点ID，start字符开始位置，end字符结束位置。</dd></dl>
                            <dl><dt>配置效果：</dt><dd>假设源节点值为“中国福建福州”，源节点ID为500100。那么表达式'500100'.substring(0, 2)的输出结果为“中国”。</dd></dl>
                            <dl class="espld"><dt>参考配置：</dt><dd><span>'500100'.substring(<font color="red">start</font>, <font color="red">end</font>)</span>，其中字体红色为需要修改的地方。<input type="button" value="使用表达式"/></dd></dl>
                        </div>
                        <div class="RemarksDetail" style="display:none">
                        	<dl><dt>配置说明：</dt><dd>{nodeDescId}[index]，nodeDescId源节点ID,index是数组的索引值。</dd></dl>
                            <dl><dt>配置效果：</dt><dd>假设原节点值为“500105,500106,500107”，（注：节点的值信息必须是英文半角逗号分隔）源节点ID值为500100。那么表达式{500100}[0]的输出结果为“500105”</dd></dl>
                            <dl  class="espld"><dt>参考配置：</dt><dd><span>{500100}[<font color="red">index</font>]</span>，其中字体红色为需要修改的地方。<input type="button" value="使用表达式"/></dd></dl>
                        </div>
                    </div>
                    <div class="tab-pane-p" id="extractList"></div>
                    <div class="margin-top-10" style="width:100%; ">
         			<textarea style="width:100%; height:80px;border:1px solid #dfdfdf"></textarea>
                    <p class="text-right"><input value="clear" type="button" class="margin-top-10 extractClear"></p>
                    <div class="modal-footer">
       				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            		<button type="button" class="btn btn-primary">提交更改</button>
         			</div>
                    </div>
                   
                </div>
            </div>
            	
      			</div><!-- /.modal-content -->
</div><!-- /.modal -->
<!-- 模态框（Modal） -->
<div class="modal fade" id="JoinModal" tabindex="-1" role="dialog" 
  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:660px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel2">
               模态框（Modal）标题
            </h4>
         </div>
         <div class="modal-body">
            <div class="tab-content">
           	  <div id="MetaJM">
                    <div class="JionRemarks clearfix">
                        	<dl><dt>配置说明：</dt><dd>[nodeDescId] + '分隔符(可选)' + [nodeDescId]。nodeDescId源节点ID。</dd></dl>
                            <dl><dt>配置效果：</dt><dd>假设源节点值分别为“中国”、“福建”、“福州”。ID值为别为“500100”、“500101”、“500102”。那么表达式[500100] + ',' + [500101] + '.' + [500102]的输出结果为“中国,福建.福州”。</dd></dl>
                            <dl class="joinexample"><dt>参考配置：</dt><dd><span></span>，其中字体红色为色为需要修改的地方。<input type="button" value="使用表达式"/></dd></dl>
                        </div>
                    <div class="tab-pane-p" id="joinList"></div>
                    <div class="margin-top-10" style="width:100%; ">
         			<textarea style="width:100%; height:80px;border:1px solid #dfdfdf"></textarea>
                    <p class="text-right"><input value="clear" type="button" class="margin-top-10 extractClear"></p>
                    <div class="modal-footer">
       				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            		<button type="button" class="btn btn-primary">提交更改</button>
         			</div>
                    </div>
                   
                </div>
            </div>
            	
      			</div><!-- /.modal-content -->
</div><!-- /.modal -->
<div class="modal fade" id="pathModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:1060px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title">
            <s:property value="%{getText('eaap.op2.conf.adapter.conditionModal')}" />
            </h4>
         </div>
         <div class="col-md-12 margin-top-10">
         	<div class="col-md-8"  style="border:1px solid #dfdfdf; padding:0">
         		<div  class="col-md-5">
                	<p class="opmap">operand</p>
                    <textarea class="form-control" style="height:100px;resize:none" id="nodeOperand" type="data-area"></textarea>
                </div>
                <div  class="col-md-2">
                	<p class="opmap">operator</p>
                    <select class="form-control margin-top-40" id="nodeOperator">
                    	<option>></option>
                        <option><</option>
                        <option>=</option>
                        <option>>=</option>
                        <option><=</option>
                        <option>!=</option>
                    </select>
                </div>
                <div  class="col-md-3">
                	<p class="opmap">Value</p>
                    <input type="text" class="form-control  margin-top-40" id="nodeValue">
                </div>
                <div  class="col-md-2">
                	<p class="opmap">conjunction</p>
                    <ul>  
                    	<li><label><input type="radio" name="conjunction" checked="checked" id="nodeAnd" value="and">And</label></li>
                        <li><label><input type="radio" name="conjunction" id="nodeOr" value="or">Or</label></li>
                        <li><input type="button"  id="nodeAdd" class=" btn-sm btn theme-btn" value="Add"></li>
                        <!--<li><input type="button" disabled="true" id="nodeUpdate" value="Update"></li>-->
                    </ul>
                </div>
                <div  class="col-md-10">
                	<p class="opmap margin-top-20">condition Expression</p>
                    <div style="border:1px solid #dfdfdf; height:160px; margin-bottom:20px" id="conditionAE"></div>
                </div>
                <div  class="col-md-2">
                	<input type="button" value="delete" id="deleteCondition" class="btn  btn-sm theme-btn" style="margin-top:100px;width:70%; visibility:hidden">
                    <input type="button" value="clear" id="clearCondition"  class="btn  btn-sm theme-btn margin-top-10" style="width:70%;">
                </div>
            </div>
         	<div class="col-md-4">
            	<ul id="nodepathTab2" class="nav nav-tabs">
   					<li class="active"><a href="#nodepathfix1" data-toggle="tab">nodeList</a> </li>
                	<li><a href="#nodepathfix2" data-toggle="tab">function</a> </li>
		 		</ul> 
         		<div class="tab-content" style="height:360px">
       			    <div class="tab-pane fade  tab-content-m"  id="nodepathfix2">
         				<ul id="xqueryCondition" class="xquerymethord functionOp" function-target="nodeOperand">
                        </ul>
         			</div>
                    <div class="tab-pane fade in active tab-content-m"  id="nodepathfix1" >
                    	<div  class="modal-body GooFlow stolist"  style="overflow:scroll; padding:0" id="pathmain">
                        	<div class="pathList" style="width:320px"></div>
                        </div>
         				
   			  </div>
         			
                </div>
            </div>
          </div>
          <div style="margin-top:10px;" class="modal-footer clearfix">
          	<input class="btn btn-default"  type="button" value='<s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" />'  data-dismiss="modal" aria-hidden="true">
          	<input type="button" value='<s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" />' class="btn btn-primary"  id="conditionOk">
          </div> 	
      	</div>
    </div>
                <!-- /.modal-content -->
</div>
<!-- /.modal -->
<!-- /.modal -->
<div class="modal fade" id="variableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:1060px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title">
               <s:property value="%{getText('eaap.op2.conf.adapter.valueModal')}" />
            </h4>
         </div>
         <div class="col-md-12 margin-top-10">
            <div class="col-md-8">
            	<textarea id="variAE2" type="data-area"></textarea> 
            </div>
         	<div class="col-md-4">
            	<ul id="nodepathTab3" class="nav nav-tabs">
   					<li class="active"><a href="#varipathfix1" data-toggle="tab">Nodelist</a> </li>
                	<li><a href="#varipathfix2" data-toggle="tab">function</a> </li>
		 		</ul> 
         		<div class="tab-content" style="height:320px">
       			  <div class="tab-pane fade  tab-content-m"  id="varipathfix2">
                  	   <ul id="xqueryVarity"  class="xquerymethord functionOp" function-target="variAE2">
                       </ul>
         			</div>
                    <div class="tab-pane fade in active tab-content-m"  id="varipathfix1" >
                    	<div  class="modal-body GooFlow stolist"  style="overflow:scroll; padding:0" id="pathmain2">
                        	<div class="pathList" style="width:320px"></div>
                        </div>
   			  		</div>
                </div>
            </div>
          </div>
          <div style="margin-top:10px;" class="modal-footer clearfix">
          	<input class="btn btn-default"  type="button" value="<s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" />"  data-dismiss="modal" aria-hidden="true">
          	<input type="button" value="<s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" />" class="btn btn-primary"  id="variOk">
          </div> 	
      	</div>
    </div>
                <!-- /.modal-content -->
</div>
<!-- /.modal -->
<!-- /.modal -->
<div class="modal fade" id="finalvariableModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:1060px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title">
               <s:property value="%{getText('eaap.op2.conf.adapter.finalValueModal')}" />
            </h4>
         </div>
         <div class="col-md-12 margin-top-10">
         	<div class="col-md-8"  style="border:1px solid #dfdfdf; padding:0; height:200px">
         		
                <textarea class="form-control" style="height:200px;resize:none" id="finalvariablevalue" type="data-area"></textarea>
            </div>
         	<div class="col-md-4">
            	<ul id="nodepathTab3" class="nav nav-tabs">
   					<li class="active"><a href="#variablefix1" data-toggle="tab">variable</a> </li>
                	<li><a href="#variablefix2" data-toggle="tab">function</a> </li>
		 		</ul> 
         		<div class="tab-content varitab">
       			   <div class="tab-pane fade  tab-content-m"  id="variablefix2">
                  	   <ul id="Varifunctionlist"  class="xquerymethord functionOp"  function-target="finalvariablevalue"></ul>
         			</div>
                    <div class="tab-pane fade in active tab-content-m"  id="variablefix1" >
                    	<ul id="varilist"  class="xquerymethord"></ul>
   			  		</div>
                </div>
            </div>
          </div>
          <div style="margin-top:10px;" class="modal-footer clearfix">
          	  <input class="btn btn-default"  type="button" value="<s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" />"  data-dismiss="modal" aria-hidden="true">
	          <input type="button" value="<s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" />" class="btn btn-primary"  id="finalOk">
	      </div> 	
      	</div>
    </div>
                <!-- /.modal-content -->
<div class="modal fade" id="rToCConfigModal"  tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:750px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel2">
            	<s:property value="%{getText(\'eaap.op2.conf.adapter.rToCConversionConfiguration\')}" />
            </h4>
         </div>
         <div class="modal-body">
      			<div class="panel-body">
      				<div style="height:100px;">
	      			<div class="modal-body GooFlow ctrlist "  style="width:690px;height:70px;margin:0;padding:0;overflow-y:auto;border:2px solid #bbb; padding:20px 8px; margin:0 0 20px 0; ">
			            <ul>
	           	    			<li class="child checked act" style="-moz-user-select: text  !important; -khtml-user-select: text  !important; -ms-user-select:text !important;-webkit-user-select:text !important;">
	            	    			<span class="d-t"><em style="margin-left: 5px;line-height:20px;" id="leftNodeName">CCCC</em></span>
	           	    			</li>
	           	    			<li style="background-color:#FFFFFF; border-top:1px solid #FFFFFF; ">
	           	    					<div>
	           	    						<div class="right" style="width:215px; border-top: 2px solid #ffd202; position: absolute; margin-top:9px;"></div>
		           	    					<div style="border: 1px solid #f99c00;height: 20px; line-height:20px; text-align:center;position: absolute;width: 72px; margin-left:80px; background-color:#FFFFFF;">
		           	    							R to C
		           	    					</div>
	           	    					</div>
	           	    			</li>
	           	    			<li class="child checked act"  style="-moz-user-select: text  !important; -khtml-user-select: text  !important; -ms-user-select:text !important;-webkit-user-select:text !important;">
		           	    			<span class="d-t" ><em style="margin-left: 5px;line-height:20px;" id="rightNodeName" >AAAAA</em></span>
	           	    			</li>
			            </ul>
		            </div>
           	    	</div>
            	    <div class="form-group">
	                  <label class="col-md-3 control-label"><s:property value="%{getText(\'eaap.op2.conf.adapter.assignmentCondition\')}" />:</label>
	                  <div class="col-md-8">
	                  		<div class="form-control"  onclick="showCon()" style="width:400px; height:34px; border:1px solid #E5E5E5; padding:0; background-color:#F8F8F8; line-height:30px; color:#AAAAAA;">
	                  			<table id="conTable" cellspacing="0" cellpadding="0"  style="display:none;width:auto; border:0; margin:0;padding:0;">
		                  			<tr>
			                  			<td style="padding-left:10px; font-family: 'Open Sans', Arial, sans-serif!important;">src_node_val=="</td>
			                  			<td>
			                  				<span id="conAssignmentConditionText" name="conAssignmentConditionText" style="width:auto !important; line-height:24px; font-family: 'Open Sans', Arial, sans-serif!important;"></span>
			                  				<input type="text" onblur="conOnblur(this)" onkeyup="$('#conAssignmentConditionText').text($(this).val())" id="conAssignmentCondition" name="conAssignmentCondition" style="width:200px; height:26px; line-height:24px;  margin:3px 0; border:0; background-color:#FFFFFF; padding-left:2px; font-family: 'Open Sans', Arial, sans-serif!important;"   value=""/>
			                  			</td>
			                  			<td style="font-family: 'Open Sans', Arial, sans-serif!important;">"</td>
		                  			</tr>
	                  			</table>
							</div>
					  </div>
	                </div>
	                <div class="form-group"   style="padding-top:25px;">
	                  <label class="col-md-3 control-label"><font style="color:#FF0000;">*</font> <s:property value="%{getText(\'eaap.op2.conf.adapter.nodeValue\')}" />:</label>
	                  <div class="col-md-8 form-inline">
	                  		<input type="text" class="form-control"  style="width:400px; padding-left:10px; font-family: 'Open Sans', Arial, sans-serif!important;" id="conNodeValue" name="conNodeValue" value=""  disabled="disabled" />
							<button class="btn theme-btn" type="button"  onclick="chooseSrcBrothersNodePathNode()" title="Choose"><i class="fa fa-plus"></i></button> 
					  </div>
	                </div>
         		</div>
            	<div class="tab-pane fade in active tab-content-m">
                    <div class="modal-footer">
           				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" /></button>
            			<button type="button" class="btn btn-primary" id="pageCRSubmit"><s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" /></button>
         			</div>
                </div>
         </div>
      	</div>
	</div>
</div>

<div class="modal fade" id="lChooseBrothersNodePathModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:750px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel2">
            	<s:property value="%{getText(\'eaap.op2.conf.adapter.chooseValueNode\')}" />
            </h4>
         </div>
         <div class="modal-body">
      			<div class="modal-body GooFlow stolist stolistL"  style="height:330px !important;margin:0;padding:0;">
      				<div style="height:325px;margin:0;padding:0;overflow-y:auto !important;">
		            	<ul id="sTolistL"></ul>
		            </div>
	            </div>
            	<div class="tab-pane fade in active tab-content-m"  style="margin:0; padding:0;">
                    <div class="modal-footer"   style="margin-top:10px; padding-top:10px;">
           				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" /></button>
            			<button type="button" class="btn btn-primary" id="getLNodePathBut"><s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" /></button>
         			</div>
                </div>
         </div>
      	</div>
	</div>
</div>

<div class="modal fade" id="cToRConfigModal"  tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:1050px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel2">
            	<s:property value="%{getText(\'eaap.op2.conf.adapter.cToRConversionConfiguration\')}" />
            </h4>
         </div>
         <div class="modal-body">
      			<div class="panel-body">
						<table class="table table-bordered table-hover"  id="cToRLinesTable">
							<thead>
								<tr class="thead"><th colspan="7"  style="text-align:left;"><span class="d-slide"></span><span style="float:left;">Configuration  List</span></th></tr>
								<tr><th width="5%"> # </th><th width="15%">Source Node </th><th width="20%">Source Node Path </th><th width="15%">Target Node </th><th width="20%">Target Node Path </th><th width="20%" style="border-right-width:0;"><font style="color:#FF0000">*</font> Node Value </th><th width="5%"  style="border-left-width:0;"></th></tr>
							</thead>
							<tbody>
								<!-- tr><td>1</td><td>open:systemId</td><td></td><td>open:cvr</td><td></td><td style="border-right-width:0;">11</td><td  style="border-left-width:0;"><button type="button"  onclick="chooseTarBrothersNodePathNode()" class="btn btn-primary"  style="height:22px; line-height:22px; padding:0 6px;">Select</button></td></tr-->
							</tbody>
						</table>
         		</div>
            	<div class="tab-pane fade in active tab-content-m">
                    <div class="modal-footer">
           				<button type="button" class="btn btn-default"  data-dismiss="modal"><s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" /></button>
            			<button type="button" class="btn btn-primary"  data-dismiss="modal"><s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" /></button>
         			</div>
                </div>
         </div>
      	</div>
	</div>
</div>

<div class="modal fade" id="rChooseBrothersNodePathModal" tabindex="-1" role="dialog"  aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:750px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel2">
            	<s:property value="%{getText(\'eaap.op2.conf.adapter.chooseValueNode\')}" />
            </h4>
         </div>
         <div class="modal-body">
      			<div class="modal-body GooFlow stolist stolistR"  style="height:330px !important;margin:0;padding:0;">
      				<div style="height:325px;margin:0;padding:0;overflow-y:auto !important;">
		            	<ul id="sTolistR"></ul>
		            </div>
	            </div>
            	<div class="tab-pane fade in active tab-content-m"  style="margin:0; padding:0;">
                    <div class="modal-footer"   style="margin-top:10px; padding-top:10px;">
           				<button type="button" class="btn btn-default" data-dismiss="modal"><s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" /></button>
            			<button type="button" class="btn btn-primary" id="setNodeValueBut"><s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" /></button>
         			</div>
                </div>
         </div>
      	</div>
	</div>
</div>

<!-- /.modal -->
<div class="modal fade" id="RtoCarray" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:860px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title">
               <s:property value="%{getText(\'eaap.op2.conf.adapter.beanReflect\')}" />
            </h4>
         </div>
         <div class="col-md-12 margin-top-10" style="padding-bottom:10px">
         	<div class="col-md-12 margin-top-10 partcontain">
         		<p><span data-toggle="tooltip" title="<s:property value="%{getText(\'eaap.op2.conf.adapter.sourceNodeTip\')}" />"><span class="glyphicon glyphicon-map-marker"></span><s:property value="%{getText(\'eaap.op2.conf.adapter.sourceNodes\')}" />：<span id="relfectSourcenode" class="margin-left-10"></span></span></p>
            	<div class="col-md-12 partcontain">
                    <div class="col-md-12">
                    	<label style=" width:auto" class="control-label">Name:</label><div style="display:inline-block" class="input-group"> <input type="text" placeholder="Name" readonly style="width: 610px; display: block;" class="form-control" id="reflectSourcenode"><span style="display:inline-block;" data-target="sourcelist" class="input-group-btn" data-modal="true"> <button type="button" class="btn btn-default"><i class="glyphicon  glyphicon-pencil"></i></button> </span></div>
                    </div>
          		</div>
          	</div>
            <div class="col-md-12 margin-top-10 partcontain" id="targetNodelist">
            	<p><span data-toggle="tooltip" title="<s:property value="%{getText(\'eaap.op2.conf.adapter.targetNodeTip\')}" />"><span class="glyphicon glyphicon-map-marker"></span><s:property value="%{getText(\'eaap.op2.conf.adapter.targetNodes\')}" />：<span id="relfectTargetnode" class="margin-left-10"></span></span></p>
            	<div class="modal-body GooFlow TEctrlist">
		            <ul>
           	    			<li class="child checked act">
            	    			<span class="d-t"><em>open:systemId</em></span>
           	    			</li>
           	    			<li class="allwhite">
           	    					<div>
           	    						<div class="right"></div>
	           	    					<div class="text">
	           	    							Reflect
	           	    					</div>
           	    					</div>
           	    			</li>
           	    			<li class="child checked act cput">
	           	    			<span class="d-t"><em>&nbsp;</em></span><input type="text" readonly  style="float:left"><span style="display:inline-block;" data-target="variable2" class="input-group-btn" data-modal="true" > <button type="button" class="btn btn-default"><i class="glyphicon  glyphicon-pencil"></i></button> </span>
           	    			</li>
		            </ul>
	            </div>
          	</div>
          </div>
          <div style="margin-top:10px;" class="modal-footer clearfix"> <button data-dismiss="modal" class="btn btn-default" type="button"><s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" /></button> <button id="arrayConfirm" class="btn btn-primary" type="button"> <s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" /></button>
          </div> 
      	</div>
    </div>
                <!-- /.modal-content -->
</div>
<!-- /.modal -->


<div class="modal fade" id="itemNodeop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"  style="width:100%; z-index:9999">
   <div class="modal-dialog"  style="width:860px">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title">
               Field choice
            </h4>
         </div>
         <div class="col-md-12 margin-top-10 clearfix" style=" padding-bottom:10px">
         	<div  class="col-md-5 margin-top-10 itemnodelist" id="itemNLleft">
            	<ul>
                </ul>
            </div>	
            <div  class="col-md-2 margin-top-10 itemoperatelist"  id="itemNLmiddle">
            	<span optype="add" class="itemoperatebtn margin-top-10">Add <span class="glyphicon glyphicon-step-forward"></span></span>
                <span optype="remove" class="itemoperatebtn"><span class="glyphicon glyphicon-step-backward"></span> Remove</span>
                <span optype="addall" class="itemoperatebtn margin-top-20">Add all <span class="glyphicon glyphicon-fast-forward"></span></span>
                <span optype="removeall" class="itemoperatebtn"><span class="glyphicon glyphicon-fast-backward"></span> Remove all</span>
            </div>	
            <div  class="col-md-5 margin-top-10 itemnodelist"  id="itemNLright">
            	<ul>
                </ul>
            </div>	
         </div>
         <div  class="modal-footer clearfix"> <button data-dismiss="modal" class="btn btn-default" type="button"><s:property value="%{getText(\'eaap.op2.conf.prov.close\')}" /></button> <button id="nodenameOk" class="btn btn-primary" type="button"  data-dismiss="modal"> <s:property value="%{getText(\'eaap.op2.conf.prov.define\')}" /></button>
         </div>
      </div>
   </div>
</div>
</body>
<script src="${contextPath}/resource/bootstrap/plugins/jquery-1.10.2.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/back-to-top.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/bootbox/bootbox.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/bootstrap-modal/js/bootstrap-modalmanager.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/bootstrap-switch/bootstrap-switch.min.js" type="text/javascript"></script>
<script src="${contextPath}/resource/bootstrap/plugins/bootstrap-modal/js/bootstrap-modal.js" type="text/javascript"></script> 
 
<!-- END CORE PLUGINS --> 
<!-- BEGIN PAGE LEVEL JAVASCRIPTS(REQUIRED ONLY FOR CURRENT PAGE) --> 
<script src="${contextPath}/resource/bootstrap/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/data-tables/jquery.dataTables.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/bootstrap/plugins/data-tables/DT_bootstrap.js" type="text/javascript"></script> 
<script type="text/javascript" src="${contextPath}/resource/bootstrap/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script> 
<script type="text/javascript" src="${contextPath}/resource/bootstrap/plugins/select2/select2.min.js"></script> 
<script src="${contextPath}/resource/bootstrap/scripts/app.js"></script> 
<script src="${contextPath}/resource/bootstrap/scripts/assign.js"></script> 
<script src="${contextPath}/resource/bootstrap/scripts/productAttribute.js"></script>
<script src="${contextPath}/resource/bootstrap/scripts/productAttribute3.js"></script> 
<script src="${contextPath}/resource/bootstrap/scripts/variableMap.js"></script>
<script type="text/javascript" src="${contextPath}/resource/comm/js/ajaxfileupload.js"></script>
<script type="text/javascript">
 function isEmpty(value) {
	  return value == null || value == '' || value == undefined || value == "undefined";
 }

 $(function() {
  //拉线图形初使化操作
  var scriptDemo = "UniversalAdapterDemo";
  function newGooflow(){ demo=new GooFlow($("#" + scriptDemo),{width:1047,height:300,haveTool:true}); }
  newGooflow();
  //表格属性初使化操作
  App.init();
  ProductAttribute.init();
  VariableMap.init();
  ProductAttribute3.init();
  //表格显示隐藏操作
  $(".table-hover tbody tr").live('click',function(){
			$(".table-hover tbody tr.cur").removeClass("cur");$(this).addClass("cur");
			});
  $(".table-hover tr.thead").live('click',function(){
		if($(this).next().is(":visible")){
			$(this).find(".d-slide").addClass("d-withdraw");
			$(this).next().slideUp(200);
			$(this).parent().next().find("td").slideUp(200);
			}
		else{
			$(this).find(".d-slide").removeClass("d-withdraw");
			$(this).next().slideDown(200);
			$(this).parent().next().find("td").slideDown(200);
			}
		});
		$(".tablist li").live('click',function(){
			var ind=$(this).index();
			$(this).addClass("cur").siblings().removeClass("cur");
			$(".tabContent").hide();
			$(".tabContent:eq("+ind+")").show();
			});
		$("ul.l .head .title , ul.l .head .check , ul.l .head label,ul.l .basicid").live('mouseover',function(e){
			var tipleft=e.pageX-$("#UniversalAdapterDemo").offset().left;
			var tiptop=e.pageY-$("#UniversalAdapterDemo").offset().top+10;
			$tip=$("<div class='gooFlow-tip' id='tip'></div>");
			$tip.css({"top":tiptop+"px","left":tipleft+"px"}).html($(this).attr("tip"));
			$("#UniversalAdapterDemo").append($tip);
			})
		$("ul.l .head .title , ul.l .head .check , ul.l .head label,ul.l .basicid").live('mouseout',function(e){
			$("#tip").remove();
		});
		//新添加部分
		$("#ExtractModal span.nodespan,#joinList span.nodespan").live("mouseover",(function(e){
		$("#tip").remove();
		var tipleft=e.pageX-$("#UniversalAdapterDemo").offset().left;
		var tiptop=e.pageY-$("#UniversalAdapterDemo").offset().top+10;
		$tip=$("<div class='gooFlow-tip' id='tip'></div>");
		$tip.css({"top":tiptop+"px","left":tipleft+"px"}).html($(this).attr("objectid")+"<br>"+$(this).attr("name"));
		$("#UniversalAdapterDemo").append($tip);
		}));
	$("#ExtractModal span.nodespan,#joinList span.nodespan").live("mouseout",(function(e){
		$("#tip").remove();
	}));
	$("#adapterMissButton").click(function(){
		var newState = document.getElementById("newState").value;
		if('new' == newState){
			$(window.parent.document).find('#closeButton').click();
		}else{
		    art.dialog.close();	
		}
	});
	$("#MetaDM .extractradio").click(function(){
		if($(this).index()==0){
			
			$(".extractRemarks .RemarksDetail:first").find(".espld span").html("'"+$("#extractList span").attr("objectid")+"'"+"."+"substring(<span class='red'>start</span> , <span class='red'>end</span>)")
		}
		else if($(this).index()==1){
			$(".extractRemarks .RemarksDetail:last").find(".espld span").html("{"+$("#extractList span").attr("objectid")+"}"+"[<span class='red'>"+"index"+"</span>]")
			}
		$(".extractRemarks .RemarksDetail").hide();
		$(".extractRemarks .RemarksDetail:eq('"+$(this).index()+"')").show();
		});
	$(".extractRemarks .RemarksDetail:first input").click(function(){
		$("#extractList").next().find("textarea ").val("'"+$("#extractList span").attr("objectid")+"'"+"."+"substring(start, end)");
		});
	$(".extractRemarks .RemarksDetail:last input").click(function(){
		$("#extractList").next().find("textarea ").val("{"+$("#extractList span").attr("objectid")+"}"+"["+"index"+"]");
		});
	$(".extractClear").click(function(){
		$(this).parent().prev().val("");
		});
		//新添加部分
		//初使化树数据
		  var adapterType = '${pageAdapterType}';
			if ($('#pageContractAdapterId').val() > 0) {
				if(adapterType > 1){//说明是脚本配置 
					$('#myTab').find('li').eq(1).find('a').click();//设置Tab选中
				}else{
					if('' == pageSrcTcpCtrFId || ''== pageTarTcpCtrFId || '0' == pageSrcTcpCtrFId || '0' == pageTarTcpCtrFId){
						alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataerror')}"/>');
					}else{
						loadAllData();//加载所有数据
					}
				}
			}
  $('#pageTypeTwoSubmit').click(function(){
	  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	  var pageTarNodeDescId = $('#pageTarNodeDescId').val();//源节点ID
	  var condition = $('#pageAssignmentCondition').val();
	  var pageScript = $('#pageJavaBean').val();
	  if(!pageScript){
  		alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
  		return;
  	  }else{
  		$.ajax({
			type: "POST",
			async:true,
		    url: "../newadapter/addNodeValAdapterRes.shtml",
		    dataType:'json',
		    data:{pageContractAdapterId:pageContractAdapterId,type:'4',pageTarNodeDescId:pageTarNodeDescId,pageCondition:condition,pageScript:pageScript},
			success:function(msg){
				 if('success' == msg.result){
					 $('#chooseTemplate').modal('hide');//隐藏窗口
				 }else{
					 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>');
				 }
            }
       });
  	  }
  });
  $('#subConditionReqVal').live("click", function(){
	  if(emptyValidate()) {
		  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
		  var pageTarNodeDescId = $('#pageTarNodeDescId').val();//源节点ID
		  var conditionObj = {};
		  var globalCondition = $("#globalCondition").val();
		  conditionObj.finalValue = $('#FinalValpress input[type=text]').val();
		  if(!isEmpty(globalCondition)) {
			  conditionObj.globalCondition = globalCondition;
		  }
		  conditionObj.condition = [];
		  $('#transformMain div[data-type="segment"]').each(function(){
			 var condition = $(this).find('input[data-type="condition"]').val();
			 var expression = $(this).find("input[data-type='expression']").val();
			 var varitable = $(this).find("input[data-type='varitable']").val();
			 if(isEmpty(varitable)) {
				 return;
			 }
			 var conditionSubObj = {};
			 conditionSubObj.expression = expression;
			 conditionSubObj.variable = varitable;
			 if(!isEmpty(condition)) {
				 conditionSubObj.condition = condition;
			 }
			 conditionObj.condition.push(conditionSubObj);
		  });
		  $.ajax({
				type: "POST",
				async:true,
			    url: "../newadapter/addNodeValAdapterRes.shtml",
			    dataType:'json',
			    data:{pageContractAdapterId:pageContractAdapterId,type:'8',pageTarNodeDescId:pageTarNodeDescId,pageComplexCondition:JSON.stringify(conditionObj)},
				success:function(msg){
					 if('success' == msg.result){
						 clearCondition();
						 $('#chooseTemplate').modal('hide');//隐藏窗口
					 }else{
						 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>');
					 }
	          }
	     });
	  } 
  })
  $('#pageTypeOneSubmit').click(function(){
	  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	  var pageTarNodeDescId = $('#pageTarNodeDescId').val();//源节点ID
	  var condition = $('#pageAssignmentCondition').val();
	  var nodeValue = $('#pageNodeValue').val();
	  if(!nodeValue){
  		alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
  		return;
  	  }else{
  		$.ajax({
			type: "POST",
			async:true,
		    url: "../newadapter/addNodeValAdapterRes.shtml",
		    dataType:'json',
		    data:{pageContractAdapterId:pageContractAdapterId,type:'2',pageTarNodeDescId:pageTarNodeDescId,pageCondition:condition,pageNodeValue:nodeValue},
			success:function(msg){
				 if('success' == msg.result){
					 $('#chooseTemplate').modal('hide');//隐藏窗口
				 }else{
					 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>');
				 }
            }
       });
  	  }
  });
  $('#pageTypeThreeSubmit').click(function(){
	  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	  var pageTarNodeDescId = $('#pageTarNodeDescId').val();//源节点ID
	  var condition = $('#pageAssignmentCondition').val();
	  var nodeValue = $('#pageConsMapCDFinal').val();
	  if(!nodeValue){
  		alert('<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}"/>');
  		return;
  	  }else{
  		$.ajax({
			type: "POST",
			async:true,
		    url: "../newadapter/addNodeValAdapterRes.shtml",
		    dataType:'json',
		    data:{pageContractAdapterId:pageContractAdapterId,type:'3',pageTarNodeDescId:pageTarNodeDescId,pageCondition:condition,pageNodeValue:nodeValue},
			success:function(msg){
				 if('success' == msg.result){
					 $('#chooseTemplate').modal('hide');//隐藏窗口
				 }else{
					 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>');
				 }
            }
       });
  	  }
  });
  $('#scriptFileUpload').change(function(){
	  var fname = this.value;
	  alert(fname);
	  var i,j;
	  var fileExt=fname.substr(fname.lastIndexOf(".")).toLowerCase();    
	  var allowImgExt=".py|.js|.java|.txt|" ;
	  
	  i=fname.lastIndexOf("\\",fname.length);
	  j=fname.lastIndexOf(".",fname.length);
	  if((j<0)||(j<i)) j=fname.length;
	  fname=fname.substring(i+1,j);
	  
     if(allowImgExt!=0 && allowImgExt.indexOf(fileExt+"|")==-1) {
   	  alert("<s:property value="%{getText('eaap.op2.conf.adapter.fileError')}" />");
   	  return false;
     }
     $.ajaxFileUpload({
         url: "../adapter/uploadFile.shtml",
         secureuri:false,
         fileElementId:'scriptFileUpload',
         dataType: 'text',
         type : "post" ,
         success: function (msg) {
       	  $("#scriptFileText").val(msg);
         }
     });
  });
  $("#arrayConfirm").click(function(){
	 if($("#reflectSourcenode").val()) {
		 var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
		 var pageTarNodeDescId = $('#pageTarNodeDescId').val();//源节点ID
		 var pageSrcNodeDescId = $('#pageSrcNodeDescId').val();	//源节点ID
		 var sourceNodes = $("#reflectSourcenode").val();
		 var tarNodes = [];
		 $.each($("#targetNodelist ul").children('div'),function(){
			 var divObj = $(this);
			 var node = divObj.find("li:first em").text();
			 var nodeExp = divObj.find("li:last input[type='text']").val();
			 var subNode = {};
			 subNode.node = node;
			 subNode.valueExpress = nodeExp;
			 tarNodes.push(subNode);
		 });
		 var pageRlectExpress = {};
		 pageRlectExpress.sourceNodes = sourceNodes;
		 pageRlectExpress.tarNodes = tarNodes;
		 $.ajax({
				type: "POST",
				async:true,
			    url: "../newadapter/addNodeValAdapterRes.shtml",
			    dataType:'json',
			    data:{pageContractAdapterId:pageContractAdapterId,type:'9',pageTarNodeDescId:pageTarNodeDescId,pageRelectExpress:JSON.stringify(pageRlectExpress)},
			    success: function(msg) {
			    	if('success' == msg.result){
						 $('#RtoCarray').modal('hide');//隐藏窗口
					 }else{
						 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>');
					 }
			    }
		 }); 
	 } else {
		 $("#reflectSourcenode").addClass("emptyvalidate").attr("placeholder","<s:property value="%{getText('eaap.op2.conf.adapter.sourceNodeNotNull')}" />");
	 }
  })
  
  //脚本提交操作
  $('#scritpButton').click(function(){
	  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	  var type = $('#adapterType').val();
	  if(12 != type &&  14 != type){
		  if ($('#scriptFileText').val() == "") {
			  alert("<s:property value="%{getText('eaap.op2.conf.adapter.contractScriptNotNull')}" />");
	          return false;		  
		  }
	  }
	  	$.ajax({
			type: "POST",
			async:true,
		    url: "../newadapter/saveScriptAdapter.shtml",
		    dataType:'json',
		    data:{pageScriptFileText:$('#scriptFileText').val(),pageAdapterType:type,pageContractAdapterId:pageContractAdapterId},
			success:function(msg){ 
				var o = msg;
				if (o.msg == 'save'){
					alert("<s:property value="%{getText('eaap.op2.conf.adapter.saveSuccess')}" />");
				}else {
					alert("<s:property value="%{getText('eaap.op2.conf.adapter.updateSuccess')}" />");
				}
				var newState = document.getElementById("newState").value;
				if('new' == newState){
					window.parent.editorPropertyValue(document.getElementById("objectId").value,
							document.getElementById("endpoint_Spec_Attr_Id").value,
							document.getElementById("attrSpecCode").value,o.contractAdapterId);
					$(window.parent.document).find('#closeButton').click();
				}else{
					var vOpener=art.dialog.opener;
				    vOpener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,o.contractAdapterId,
				    document.getElementById("objectId").value,
				    document.getElementById("endpoint_Spec_Attr_Id").value);
				    art.dialog.close();
				}
				
          }
     });
  });
  //协议适配提交操作
  $('#adapterButton').click(function(){
	  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	  if(isOrNotSubmit(pageContractAdapterId)){
		  $.ajax({
				type: "POST",
				async:true,
			    url: "../adapter/saveUniversalAdapter.shtml",
			    dataType:'json',
			    data:{transformerRuleId:pageContractAdapterId},
				success:function(msg){ 
					var o = msg;
					if (o.msg == 'save'){
						alert("<s:property value="%{getText('eaap.op2.conf.adapter.saveSuccess')}" />");
					}else{
						alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}"/>');
					}
					var newState = document.getElementById("newState").value;
					if('new' == newState){
						window.parent.editorPropertyValue(document.getElementById("objectId").value,
								document.getElementById("endpoint_Spec_Attr_Id").value,
								document.getElementById("attrSpecCode").value,pageContractAdapterId);
						$(window.parent.document).find('#closeButton').click();
					}else{
						var vOpener=art.dialog.opener;
					    vOpener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,pageContractAdapterId,
					    document.getElementById("objectId").value,
					    document.getElementById("endpoint_Spec_Attr_Id").value);
					    art.dialog.close();	
					}
					
	        }
	   });
	  }else{
		  alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.notsave')}" />');
	  }
  });
  //消息流Id修改提交
  $('#pageMessageButton').click(function(){
	 var messageFlowId = $('#ProtocolId').val();
	 if("" == messageFlowId){
		 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.messageFlowId')}" />');
		 return;
	 }else{
		 var r = /^\+?[1-9][0-9]*$/;//正整数 
	     if(!r.test(messageFlowId)){
	    	 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.mustnum')}" />');
	    	 return ;
	     }else{
	    	 var contractId = $('#ProtocolId').attr('releId');
	    	 var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	    	 $.ajax({
	 			type: "POST",
	 			async:false,
	 		    url: "../newadapter/updateResult.shtml",
	 		    dataType:'json',
	 		    data:{pageContractAdapterId:pageContractAdapterId,pageSrcTcpCtrFId:contractId,pageEndpointId:messageFlowId},
	 			success:function(msg){ 
	 				if (msg.result == 'success'){
	 					$('#dataidienty').modal('hide');
	 				}else{
	 					alert('data error');
	 				}
	             }
	           });
	     }
	 }
  });
 });
 //判断是否可以提交
 function isOrNotSubmit(pageContractAdapterId){
	 var flag = false;
	 $.ajax({
			type: "POST",
			async:false,
		    url: "../newadapter/isOrNotSubmit.shtml",
		    dataType:'json',
		    data:{pageContractAdapterId:pageContractAdapterId},
			success:function(msg){ 
				if (msg.result == 'success'){
					flag = true;
				}
            }
          });
	 return flag;
 }
 function closeAdapterWindow(){
	 $(window.parent.document).find('#closeButton').click();
 }
 //**初使化加载所有数据
 function loadAllData(){
	 var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
	 $.ajax({
			type: "POST",
			async:false,
		    url: "../newadapter/loadAllData.shtml",
		    dataType:'json',
		    data:{pageContractAdapterId:pageContractAdapterId},
			success:function(msg){ 
				loadData(msg.all);
				$.each(msg.all.tables,function(key,val) {
					addTable(val.name,val.id,val.action);
				});//加载表格
				loadLine(msg.all);//加载线功能
				if(msg.all.lines) {
					$.each(msg.all.lines,function(key,val) {
						addTableTr(val.from,val.to,val.operate);
					});//加载表格记录
				}
				reHeight();
				
           }
      });
 }
 //响应tab的点击事件
 function onclickTab(num){
	  var type = '${pageAdapterType}';
	  if($('#pageContractAdapterId').val() > 0){
		  if(1 == num){//第一个TAB
			  if(type > 1){//说明在做变换配置
				  if(!confirm('<s:property value="%{getText('eaap.op2.conf.protocol.sureToModidy')}" />')){
					  $('#myTab').find('li').eq(1).find('a').click();//设置Tab选中
				  }
			  }
		  }else if(2 == num){//第二个TAB
             if(type <=1){//说明在做变换配置
           	  if(!confirm('<s:property value="%{getText('eaap.op2.conf.protocol.sureToModidy')}" />')){
					  $('#myTab').find('li').eq(0).find('a').click();//设置Tab选中
				  }
			  }
		  }
	  }
 }
 
 $("#getLNodePathBut").click(function(){
		var nodeName="";
		var selNode = $(".stolistL .act");
		if(selNode.length>0){
			nodeName = selNode.attr("name")
		}else{
		  	 alert('<s:property value="%{getText('eaap.op2.conf.adapter.selectOne')}" />');
			 return;
		}	
		$("#conNodeValue").val("//"+nodeName);
		$("#lChooseBrothersNodePathModal").modal("hide");
	});

	$("#setNodeValueBut").click(function(){
			var nodeName="";
			var selNode = $(".stolistR .act");
			if(selNode.length>0){
				nodeName = selNode.attr("name")
			}else{
			  	 alert('<s:property value="%{getText('eaap.op2.conf.adapter.selectOne')}" />');
				 return;
			}	

		  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
		  var pageSrcNodeDescId = $('#pageSrcNodeDescId').val();	//源节点ID
	      var nodeValue = "//"+nodeName;
		  var condition ="";
		  if(!nodeValue){
			alert('<s:property value="%{getText('eaap.op2.conf.adapter.nodeValue')}" /> '+'<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}" />');
			return;
		  }else{
				$.ajax({
					type: "POST",
					async:true,
				    url: "../newadapter/addNodeValAdapterRes.shtml",
				    dataType:'json',
				    data:{pageContractAdapterId:pageContractAdapterId,type:'1',pageTarNodeDescId:pageSrcNodeDescId,pageCondition:condition,pageNodeValue:nodeValue},
					success:function(msg){
						 if('success' == msg.result){
							$("#rChooseBrothersNodePathModal").modal("hide");
							 loadCToRLinesData();
						 }else{
							 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}" />');
						 }
		          }
		     });
		 }	
	});

	$("#pageCRSubmit").click(function(){
		  var pageContractAdapterId = $('#pageContractAdapterId').val();//协议转化ID
		  var pageTarNodeDescId = $('#pageTarNodeDescId').val();	//目标节点ID
		  var condition = $('#conAssignmentCondition').val();
		  if(condition!=""){
			  condition = "src_node_val==\""+condition+"\"";
		  }
		  var nodeValue = $('#conNodeValue').val();
		  if(!nodeValue){
	  		alert('<s:property value="%{getText('eaap.op2.conf.adapter.nodeValue')}" /> '+'<s:property value="%{getText('eaap.op2.conf.adapter.notEmpty')}" />');
	  		return;
	  	  }else{
	  		$.ajax({
				type: "POST",
				async:true,
			    url: "../newadapter/addNodeValAdapterRes.shtml",
			    dataType:'json',
			    data:{pageContractAdapterId:pageContractAdapterId,type:'1',pageTarNodeDescId:pageTarNodeDescId,pageCondition:condition,pageNodeValue:nodeValue},
				success:function(msg){
					 if('success' == msg.result){
						 $('#rToCConfigModal').modal('hide');//隐藏窗口
					 }else{
						 alert('<s:property value="%{getText('eaap.op2.conf.protocol.error.dataDoerror')}" />');
					 }
	            }
	       });
	  	  }
	});

	function showCon(){
		$("#conTable").show();
		$("#conAssignmentConditionText").hide();
		$("#conAssignmentCondition").show();
		$("#conAssignmentCondition").focus();
	}

	function conOnblur(cObj){
		$(cObj).val($(cObj).val().replace(/(^\s*)|(\s*$)/g,''));
		if(cObj.value==""){
			$("#conTable").hide()
		}else{
			$("#conAssignmentCondition").hide()
			$("#conAssignmentConditionText").show()
		}
	}
 
 //处理文件上传
 function setUploadFile(selectedfile){
	  var fname = selectedfile.value;
	  var i,j;
	  var fileExt=fname.substr(fname.lastIndexOf(".")).toLowerCase();    
	  var allowImgExt=".py|.js|.java|.txt|" ;
	  
	  i=fname.lastIndexOf("\\",fname.length);
	  j=fname.lastIndexOf(".",fname.length);
	  if((j<0)||(j<i)) j=fname.length;
	  fname=fname.substring(i+1,j);
	  
     if(allowImgExt!=0 && allowImgExt.indexOf(fileExt+"|")==-1) {
   	  alert("<s:property value="%{getText('eaap.op2.conf.adapter.fileError')}" />");
   	  return false;
     }
     $.ajaxFileUpload({
         url: "../adapter/uploadFile.shtml",
         secureuri:false,
         fileElementId:'scriptFileUpload',
         dataType: 'text',
         type : "post" ,
         success: function (msg) {
       	  $("#scriptFileText").val(msg);
         }
     });
	 
	 }
 </script>
</html>
