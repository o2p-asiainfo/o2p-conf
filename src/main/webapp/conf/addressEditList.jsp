<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->

<head>
  <meta charset="utf-8" />
  <title>Telenor Open Operational Platform</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="" name="description" />
  <meta content="" name="author" />
  <!-- BEGIN GLOBAL MANDATORY STYLES -->
  <%@ include file="../conf/resources/includes/global-css1.jsp"%>
  <!-- END GLOBAL MANDATORY STYLES -->

  <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
  <link href="${APP_PATH}/conf/conf/resources/plugins/bootstrap-datepicker/datepicker.css" rel="stylesheet" />
  <link href="${APP_PATH}/conf/conf/resources/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
  <link href="${APP_PATH}/conf/conf/resources/plugins/select2/select2.min.css" rel="stylesheet" />
  <link href="${APP_PATH}/conf/conf/resources/css/process.css" rel="stylesheet" />
  <!-- END PAGE LEVEL PLUGIN STYLES -->

  <!-- BEGIN THEME STYLES -->
  <%@ include file="../conf/resources/includes/global-css2.jsp"%>
  <!-- END THEME STYLES -->
 
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>

  <div id="techRoutehtml" class="container">
    <div class="row breadcrumbs">
      <div class="container">
        <div class="col-md-4 col-sm-4">
          <h1 >Address List</h1>
        </div>
      </div>
    </div>
    <div class="form-body margin-top-20">
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <div  class="portlet box s-protlet-theme">
                <div class="portlet-title">
          			<div class="actions" style="float:left; padding:5px 0">
          				<button id="addRoute" class="btn default"><i class="fa fa-plus"></i> <span class="i18n">CNF20000004</span></button>
          				<button id="removeRoute" class="btn default"><i class="fa fa-trash-o"></i> <span class="i18n">CNF20000006</span> </button>
          			</div>
        		</div>
        		<div class="portlet-body">
          			<div class="table-scrollable">
          			<input type="hidden"  id="techImplId" value=${techImplId}>
                <!--<table id="cacheObjList" class="table table-bordered margin-top-10">-->
                <table class="table table-sl table-bordered" id="techNodeList">
                	
          			<thead>
            			<tr>
                  	<th style="width:36px"></th>
                  		<th  class="i18n"  style="width:20%">NODE_HOST</th>
                      <th  class="i18n"  style="width:20%">NODE_IP</th>
                      <th  class="i18n"  style="width:10%">NODE_PORT</th>
                      <th  class="i18n"  style="width:70%">TECH_ROUTE_EXPR</th>
                  </tr>
          			</thead>
          			<tbody> 	
        		</table>
        		</div>
        		</div>
            </div>
          </div>
        </div>
      </div>
     </div>
  <div class=" text-right">
    <button type="button" class="btn btn-default i18n" data-dismiss="modal" id="routeObjClose">CNF20000013</button>
    <button type="button" class="btn btn-primary i18n" data-dismiss="modal" id="routeObjOk">CNF20000012</button>
  </div>
 </div>



</div>
 
<!-- END FOOTER --> 
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) --> 
<!-- BEGIN CORE PLUGINS --> 
<!--[if lt IE 9]>
<script src="resources/plugins/respond.min.js"></script>
<script src="resources/plugins/excanvas.min.js"></script> 
<![endif]--> 
   <%@ include file="../conf/resources/includes/global-js.jsp"%>
  <!-- END CORE PLUGINS -->
  <!-- BEGIN PAGE LEVEL JAVASCRIPTS(REQUIRED ONLY FOR CURRENT PAGE) -->
  <script src="${APP_PATH}/conf/conf/resources/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
  <script src="${APP_PATH}/conf/conf/resources/plugins/data-tables/jquery.dataTables.min.js"></script>
  <script src="${APP_PATH}/conf/conf/resources/plugins/data-tables/DT_bootstrap.js"></script>
  <script src="${APP_PATH}/conf/conf/resources/plugins/select2/select2.min.js"></script> 
  <script src="${APP_PATH}/conf/conf/resources/scripts/addressIinstall.js"></script> 
<!-- END PAGE LEVEL SCRIPTS --> 
<script>
jQuery(document).ready(function() {  
	App.init();
	var url = location.search; //获取url中"?"符后的字串 
	var theRequest = new Object(); 
	if (url.indexOf("?") != -1) { 
		var str = url.substr(1); 
		strs = str.split("&"); 
		for(var i = 0; i < strs.length; i ++) { 
			theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]); 
		}
		var attrName=theRequest['attrName'];
		//var id=$("#dt tbody tr").find(":checked").attr("id");
		//var objId=theRequest['objectId'];
		//var espaId=theRequest['endpoint_Spec_Attr_Id'];
		//window.parent.editDynamicAttrFromSpecPage(attrName,id,objId,espaId);
		//$(window.parent.document).find('.aui_state_focus').remove();
		
		//art.dialog.close();
	}
	setInstall.init();
});

</script> 
 
</body>
</html>