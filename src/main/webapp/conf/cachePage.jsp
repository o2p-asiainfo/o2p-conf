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
  <%@ include file="./resources/includes/global-css1.shtml"%>
  <!-- END GLOBAL MANDATORY STYLES -->

  <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
  <link href="${APP_PATH}/conf/resources/plugins/bootstrap-datepicker/datepicker.css" rel="stylesheet" />
  <link href="${APP_PATH}/conf/resources/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
  <link href="${APP_PATH}/conf/resources/plugins/select2/select2.min.css" rel="stylesheet" />
  <link href="${APP_PATH}/conf/resources/css/process.css" rel="stylesheet" />
  <!-- END PAGE LEVEL PLUGIN STYLES -->

  <!-- BEGIN THEME STYLES -->
  <%@ include file="./resources/includes/global-css2.shtml"%>
  <!-- END THEME STYLES -->
 
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<div class="page-container" id="cacheListpage">
	<div class="row breadcrumbs">
      <div class="container">
        <div class="col-md-4 col-sm-4">
          <h1>Sync Offer</h1>
        </div>
      </div>
    </div>
    
    <div class="container margin-bottom-20 margin-top-20">
      <form id="searchBarForm">
        <div class="row">
        <div class="col-md-2">
          <div class="form-group">
            <label class="control-label text-right">Cache Strategy Name:</label>            
          </div>
        </div>
        <div class="col-md-3">
          <div class="form-group">
            <input type="text" value="" name="CacheStrategyName" class="form-control" placeholder="None">
          </div>
        </div>
        
        </div>
        <div class="row">
        <div class="col-md-12 text-right">          
          <button class="btn theme-btn i18n" id="search" type="button"  i18n-set="data-loading-text" data-loading-text="CNF00000011" autocomplete="off">CNF00000012</button>
        </div>
        </div>
      </form>
    </div>
    
</div>
<div>
	<div>

    </div> 
    <div class="container margin-bottom-40 margin-top-20">
      <div class="portlet box s-protlet-theme">
        <div class="portlet-title">
          <div class="actions" style="float:left; padding:5px 0">
          <button data-target="#myModal" data-toggle="modal" id="btn-add" class="btn default"><i class="fa fa-plus"></i> Add </button>
          <button id="btn-edit" class="btn default"><i class="fa fa-edit"></i> Edit </button>
          <button id="btn-del" class="btn default"><i class="fa fa-trash-o"></i> Del </button>
        </div>
        </div>
        <div class="portlet-body">
          <div class="table-scrollable">
            <table class="table table-sl table-bordered table-nowrap text-middle" id="dt">
              <thead>
                <tr>
                  <th style="width:5%"></th>
                  <th>Name </th>
                  <th>CacheType</th>
                  <th>ForceRefresh</th>
                  <th>ExpireTime</th>
                </tr>
              </thead>
              <tbody>
              <tr><td colspan="8" class="i18n">CNF00000024</td></tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class=" text-right">
    	<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
    	<button id="cacheOk" data-dismiss="modal" class="btn btn-primary" type="button">OK</button>
  	   </div>
    </div>
</div>
<!--cache OBJ list -->
<div id="addObjList" class="container" style="width:860px">
  <div>
    <div class="form-body">
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label class="control-label">Name </label>
            <input id="cacheName" type="text" placeholder="Name" class="form-control" validtde="true">
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label">Cache Type </label>
            <select class="form-control" id="cacheType">
              <option value="0">REMOTE</option>			
			  <option value="1" selected>LOCAL</option>					
            </select>
          </div>
        </div>
        <!--/span-->
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label">Force Refresh </label>
            <select class="form-control" id="forceRefresh">
              <option value="1" selected>Y</option>			
			  <option value="2">N</option>					
            </select>
          </div>
        </div>
        <!--/span-->
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label">Expire Time</label>
            <input type="text" placeholder="Expire Time" class="form-control" id="expireTime"  validtde="true">
          </div>
        </div>
        <!--/span-->
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label">Expire Time Path</label>
            <div class="clearfix"><input type="text" placeholder="Expire Time Path" class="form-control" id="expireTimeParth" style="display:inline-block; width:340px; float:left"  validtde="true"><span class="input-group-btn left" data-target="variable" style="float:left"> <button class="btn btn-default" type="button"><i class="glyphicon glyphicon-pencil"></i></button> </span></div>
            
          </div>
        </div>
        <!--/span-->
      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label class="control-label">Cache Obj</label>
            <div>
            	<p style="padding-bottom:10px"><input id="addCache" type="button" class="btn  btn-primary" value="Add">&nbsp;<input id="removeCache" type="button" class="btn  btn-primary" value="Delete"></p>
                <!--<table id="cacheObjList" class="table table-bordered margin-top-10">-->
                <table class="table table-sl table-bordered table-nowrap text-middle" id="cacheObjList">
          			<thead>
            			<tr>
                        	<th width="4%"><input type="checkbox" class="checkall"></th>
                            <th width="48%">Key Rule</th>
                            <th width="48%">Value Path</th>
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
  <div class=" text-right">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    <button type="button" class="btn btn-primary" data-dismiss="modal" id="cacheObjOk">OK</button>
  </div>
</div>
<!-- END FOOTER --> 
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) --> 
<!-- BEGIN CORE PLUGINS --> 
<!--[if lt IE 9]>
<script src="resources/plugins/respond.min.js"></script>
<script src="resources/plugins/excanvas.min.js"></script> 
<![endif]--> 
   <%@ include file="./resources/includes/global-js.shtml"%>
  <!-- END CORE PLUGINS -->
  <!-- BEGIN PAGE LEVEL JAVASCRIPTS(REQUIRED ONLY FOR CURRENT PAGE) -->
  <script src="${APP_PATH}/conf/resources/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
  <script src="${APP_PATH}/conf/resources/plugins/data-tables/jquery.dataTables.min.js"></script>
  <script src="${APP_PATH}/conf/resources/plugins/data-tables/DT_bootstrap.js"></script>
  <script src="${APP_PATH}/conf/resources/plugins/select2/select2.min.js"></script>
  <script src="${APP_PATH}/conf/resources/scripts/cacheList.js"></script>  
  <script src="resources/scripts/cacheIinstall.js"></script> 
<!-- END PAGE LEVEL SCRIPTS --> 
<script>
jQuery(document).ready(function() {    
   App.init();
   cacheList.init();
   setInstall.init(); 
});

</script> 
<!-- END JAVASCRIPTS -->
</body>
</html>