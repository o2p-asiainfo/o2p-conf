<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title><s:property value="%{getText('eaap.op2.conf.message.page.title')}" /></title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<link href="${contextPath}/resource/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/bootstrap-datepicker/datepicker.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/bootstrap-switch/bootstrap-switch.min.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/plugins/select2/select2.min.css" />
<link href="${contextPath}/resource/css/style-template.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/css/style.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/css/themes/orange.css" rel="stylesheet" type="text/css" id="style_color" />
<link href="${contextPath}/resource/css/style-responsive.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/css/custom.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/select2-4.0.0-rc.2/dist/css/select2.min.css" rel="stylesheet" />

<script src="${contextPath}/resource/plugins/jquery-1.10.2.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/back-to-top.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/bootbox/bootbox.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/bootstrap-modal/js/bootstrap-modalmanager.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/bootstrap-modal/js/bootstrap-modal.js" type="text/javascript"></script> 

<script src="${contextPath}/resource/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/data-tables/jquery.dataTables.min.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/plugins/data-tables/DT_bootstrap.js" type="text/javascript"></script> 
<script src="${contextPath}/resource/scripts/app.js"></script> 
<script type="text/javascript" src="${contextPath}/resource/plugins/select2/select2.min.js"></script> 
<script src="${contextPath}/resource/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="${contextPath}/resources/select2-4.0.0-rc.2/distjs/select2.min.js"></script>
<script src="${contextPath}/message/messageList.js"></script> 
<script src="${contextPath}/message/message${localeName}.js"></script> 

<script type="text/javascript">
 jQuery(document).ready(function() {
  App.init();
  messageInfo.init();
 });
 </script> 
 <script>
 $(document).ready(function() {
	  $(".js-example-basic-single").select2();
	  $(".js-example-basic-multiple").select2();
	});
	
 </script>
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico" ></link>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body class="page-header-fixed">
<!-- BEGIN HEADER --><!-- END HEADER --> 
<!-- BEGIN PAGE CONTAINER -->
  <!-- BEGIN BREADCRUMBS -->
  <div class="row breadcrumbs">
    <div class="container">
      <div class="col-md-4 col-sm-4">
        <h4>Message</h4>
      </div>
      <div class="col-md-8 col-sm-8">
        <ul class="pull-right breadcrumb">
          <li><a href="index.shtml">Home</a> </li>
          <li><a href="myApplication1.shtml"><s:property value="%{getText('eaap.op2.conf.message.page.title')}" /></a> </li>
          <li class="active"><s:property value="%{getText('eaap.op2.conf.message.list')}" /></li>
        </ul>
      </div>
    </div>
  </div>
  <!-- END BREADCRUMBS --> 
<div class="container">
  <div class="panel-body">
	<form class="form-horizontal" role="form">
      <div class="form-body">
       <div class="form-group">
        <label class="col-md-2 control-label"><s:property value="%{getText('eaap.op2.conf.message.title')}" /></label>
        <div class="col-md-4" ><input type="text" class="form-control" placeholder="Message Title" name='msgTitle' id="msgTitleSearch"></input></div>
         <label class="col-md-2 control-label"><s:property value="%{getText('eaap.op2.conf.message.msgType')}" /></label>
         <div class="col-md-4">
           <div><select class="js-example-basic-single"  style="width:100%;" id="msgTypeSearch" name="msgType">
            <optgroup><option value=""> </option>
            <c:forEach var="msgType" items="${msgTypeList }">
            	 <option value="${msgType.key }">${msgType.value }</option>
            </c:forEach>
            </optgroup>
            </select>
          </div>
        </div>
       </div>
      </div>
       <div class="form-group">
        <label class="col-md-2 control-label">
         <s:property value="%{getText('eaap.op2.conf.message.recType')}"/></label>
        <div class="col-md-4">
         <div><select class="js-example-basic-single"  style="width:100%;" id="msgRecTypeSearch" name="msgRecTypeSearch">
            <optgroup><option value=""> </option>
            <c:forEach var="msgRecType" items="${msgRecTypelist }">
            	 <option value="${msgRecType.key }">${msgRecType.value }</option>
            </c:forEach>
            </optgroup>
            </select>
          </div>
         </div>
         <label class="col-md-2 control-label"><s:property value="%{getText('eaap.op2.conf.message.msgWay')}"/></label>
            <div class="col-md-4">
               <select class="js-example-basic-single" style="width:100%" name="msgWay" id="msgWaySearch"><optgroup>
               		<option value=""> </option>
                    <c:forEach var="msgWay" items="${msgWayList }">
            	        <option value="${msgWay.key }">${msgWay.value }</option>
                     </c:forEach>
                </optgroup></select>
         </div>
       </div>
      <div class="form-group">
        <label class="col-md-2 control-label"> <s:property value="%{getText('eaap.op2.conf.message.msgState')}"/></label> 
        <div class="col-md-4">
        	<div class="input-icon"> <select class="js-example-basic-single" style="width:100%" id="statusCdSearch" name="statusCd">
            <optgroup>
            	<option value=""> </option>
                <c:forEach var="msgStatus" items="${msgStatusList }">
          	        <option value="${msgStatus.key }">${msgStatus.value }</option>
                 </c:forEach>
            </optgroup>
            </select>
          </div>
        </div>
     </div>
</div>
</form>	
<button class="btn blue" style="float:right;" id="bntMsgSearch"> <s:property value="%{getText('eaap.op2.conf.message.search')}"/></button>

  </div>
  <!-- BEGIN CONTAINER -->
  <div class="container margin-bottom-40 margin-top-20" id='td'>
    <div class="portlet box s-protlet-theme">
      <div class="portlet-title">
        <div class="caption"> <s:property value="%{getText('eaap.op2.conf.message.list')}"/></div>
        <div class="actions">
          <button class="btn blue" id="btn-add" data-toggle="modal" data-target="#messageModal"><i class="fa fa-plus"></i>  <s:property value="%{getText('eaap.op2.conf.message.add')}"/> </button>
          <button class="btn blue" id="btn-del"><i class="fa fa-trash-o"></i>  <s:property value="%{getText('eaap.op2.conf.message.delete')}"/> </button>
          <button class="btn blue" id="btn-detail"><i class="fa fa-edit"></i>  Detail </button>
        </div>
      </div>
      <div class="portlet-body">
        <table class="table table-bordered table-striped table-hover text-center nowrap-ingore group-check" id="messageDT" width="1000px">
          <thead>
            <tr>
              <th> <input type="checkbox" class="group-checkable" data-set=".group-check .checkboxes"></input></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.msgId')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.title')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.subTitle')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.msgType')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.msgType')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.recType')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.recType')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.msgWay')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.msgWay')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.startDate')}"/></th>
              <th> <s:property value="%{getText('eaap.op2.conf.message.adddress')}"/></th>
      		  <th style="white-space:normal; word-break:break-all;"> <s:property value="%{getText('eaap.op2.conf.message.msgState')}"/></th>
      		  <th> <s:property value="%{getText('eaap.op2.conf.message.msgState')}"/></th>
            </tr>
          </thead>
          <tbody >
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <!-- END CONTENT --> 
</div>
</div>
</div>
<!-- END CONTAINER -->
</div>
<!-- END PAGE CONTAINER --> 
<!-- Load javascripts at bottom, this will reduce page load time --> 
<!-- BEGIN CORE PLUGINS(REQUIRED FOR ALL PAGES) --> 
<!--[if lt IE 9]>
<!--<script src="${contextPath}/resource/plugins/respond.min.js"></script>  -->
    <![endif]--> 

<!-- END PAGE LEVEL JAVASCRIPTS -->


</body>
<!-- END BODY -->


<!--messags Modal-->
<div class="modal modal-lg panel" id='messageModal' style="display:none;"  >
  <div class="panel-body">
	<form id='form-add' role="messageform" class="form-horizontal form-wizard" action="../message/addOrUpdate.shtml">
    <div class="form-body" >
    	<div class="modal-header">
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        	<h4><s:property value="%{getText('eaap.op2.conf.message.page.title')}"/></h4>
      </div>
      <div style="display:none;">
      	<input id="msgId" name="msgId" value=""/>
      </div>
      <div class="modal-body">
        	  <div class="form-group row">
                <label class="col-md-3 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.title')}"/></label> 
                <div class="col-md-6">
                    <input type="text" class="form-control" placeholder="Message Title" name='msgTitle' id="msgTitle">
                </div>
            </div>
            <div class='form-group row'>
                  <label class="col-md-3 control-label"><s:property value="%{getText('eaap.op2.conf.message.subTitle')}"/></label></label>
                  <div class="col-md-6"> 
                        <input type="text" class="form-control" placeholder="Subtitles" name='msgSubtitle' id="msgSubtitle">
                  </div>
            </div>   
             <div class="form-group row">
                <label class="col-md-3 control-label"><s:property value="%{getText('eaap.op2.conf.message.msgWay')}"/></label> 
                  <div class="col-md-6">
                  <select class="js-example-basic-single" style="width:100%" name="msgWay" id="msgWay">
                      <c:forEach var="msgType" items="${msgTypeList }">
            		     <option value="${msgType.key }">${msgType.value }</option>
                      </c:forEach>
                   </select>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-md-3 control-label"><s:property value="%{getText('eaap.op2.conf.message.recType')}"/></label>
                <div class="col-md-6">
                	<select class="js-example-basic-single" style="width:100%"  name="msgRecType" id="msgRecType" onchange="receiveTypeChange(this.value)">
                        <c:forEach var="msgRecType" items="${msgRecTypelist }">
            	          <option value="${msgRecType.key }">${msgRecType.value }</option>
                        </c:forEach>
                  </select>
                </div>
            </div>
            <div class="form-group row">
            	<div id="objectDiv">
                <label class="col-md-3 control-label"><font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.msgObject')}"/></label> 
                  <div class="col-md-6">
                  <input style="display:none;" id="msgRecRelRoleId" name="msgRecRelRoleId" value=""></input>
                  <select class="js-example-basic-multiple" multiple="multiple" style="width:100%" name="msgRecRelRoleIdArr" id="msgRecRelRoleIdArr">
                      <c:forEach var="role" items="${msgRoleList }">
            		     <option value="${role.key }">${role.value }</option>
            		     alert(${role.value });
                      </c:forEach>
                   </select>
                </div>
              </div>
            </div>
            <div id="IndividualsReceivingDiv" class="form-group row" style="display:none;">
                  	<label class="col-md-3 control-label"><s:property value="%{getText('eaap.op2.conf.message.msgObject')}"/></label>
                      <div class=" col-sm-6">
                          <input type="hidden" class="form-control" placeholder="Enter text" name="msgRecRelPersonalId" id="msgRecRelPersonalId"/>
                          <input type="text" class="form-control" placeholder="Enter text" name="" id="personRecName" disabled="disabled"/>
                      </div>
                      <div class="col-md-2"><button type="button" class="btn btn-blue" id="orgSearchBtn" data-toggle='modal' data-target="#SeachModal" ><s:property value="%{getText('eaap.op2.conf.message.search')}"/></button></div>
                      </div>
            </div>
            <div class="form-group row">
                  <label class="col-md-3 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.adddress')}"/></label>
                  <div class="col-md-6">
                      <input type="text" class="form-control" placeholder="Enter text" name='msgHandleAddress' id="msgHandleAddress">
                  </div>
            </div>
            <div class="form-group row" id="timeDiv">
                <label class="col-md-3 control-label"><font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.startDate')}"/></label> 
                <div class="col-md-6">
                  <div data-date-format="yyyy/mm/dd" data-date="10/11/2012" class="input-group input-medium date-picker input-daterange" data-error-container="#error-container">
                  <input type="text" name="formatBeginDate" class="form-control od" id="formatBeginDate">
                  <span class="input-group-addon"> to </span>
                  <input type="text" name="formatEndDate" class="form-control od" id="formatEndDate">
                </div>
                <div id="error-container"></div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-md-3 control-label"><font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.msgContend')}"/></label> 
                <div class="col-md-9">
                    <textarea rows="6" class="form-control" style="width:80%" id="msgContent" name="msgContent"></textarea>
                </div>
            </div>
      </div>
      <div class="modal-footer">
    	      <div class="col-lg-12 text-center form-actions">
                  <button type="submit" class="btn blue" id="btn-addMsg"><s:property value="%{getText('eaap.op2.conf.message.add')}"/></button>
                  <button type="button" class="btn " id="btn-cancle"><s:property value="%{getText('eaap.op2.conf.message.cancel')}"/></button>
                  <button type="button" class="btn " id="btn-preview"><s:property value="%{getText('eaap.op2.conf.message.preview')}"/></button>
            </div>
      </div>
    </div>
  </form>
  </div>
</div>
<!--BING SeachModal-->
<div class="modal modal-lg panel col-md-12" id='SeachModal' style="display:none;  ">
    <div class="panel-body">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
          <h4><s:property value="%{getText('eaap.op2.conf.message.msgObject')}"/></h4>
      </div>
      <div class="modal-body">
        <div class="panel-body">
          <input id="isReady" type="hidden" value="0"/>
        </div>
          <div class="margin-bottom-10 margin-top-20" >
            <div class="portlet box s-protlet-theme">
              <div class="portlet-title">
                <div class="caption">org List</div>
              </div>
              <div class="portlet-body">
                <table class="table table-bordered table-striped table-hover text-center nowrap-ingore group-check" id="listDt">
                  <thead>
                    <tr style="white-space:nowrap">
                      <th> <input type="checkbox" class="group-checkable" data-set=".group-check .checkboxes">
                      </th>
                      <th>ID</th>
                      <th>Name</th>
                      <th>Code</th>
                      <th>User Name</th>
                      <th>phone</th>
                      <th>email</th>
                      <th>descriptor</th>
                    </tr>
                  </thead>
                  <tbody style="white-space:nowrap">
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        <!-- END CONTAINER -->
         
      </div>
      <div class="modal-footer">
                <div class="col-lg-12 text-center form-actions">
                      <button type="button" class="btn green" id="btn-org-add">Submit</button>
                      <button type="button" class="btn green" id="btn-org-cancle"><s:property value="%{getText('eaap.op2.conf.message.cancel')}"/></button>
                </div>
      </div>
<!--END SeachModal-->
</html>