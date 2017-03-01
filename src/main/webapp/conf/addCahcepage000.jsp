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
  <link href="${APP_PATH}/conf/resources/css/process.css" rel="stylesheet" />
  <!-- END PAGE LEVEL PLUGIN STYLES -->

  <!-- BEGIN THEME STYLES -->
  <%@ include file="./resources/includes/global-css2.shtml"%>
  <!-- END THEME STYLES -->
  <style>
  	ul.xquerymethord{border:2px solid #dfdfdf; border-radius:3px ; padding:1px; background:#FFF}
  	.xquerymethord li{ height:26px; line-height:26px;padding-left:15px;cursor:pointer; background:#eee; margin-top:1px}
	.xquerymethord li:hover{background:#dfdfdf;}
  </style>
 
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
<div id="addCacheModal" class="container" style="width:860px">
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
  <script src="${APP_PATH}/conf/resources/scripts/syncOffer.js"></script>  
  <script src="resources/scripts/cacheIinstall.js"></script> 
<!-- END PAGE LEVEL SCRIPTS --> 
<script>
jQuery(document).ready(function() {    
   App.init();
   setInstall.init(); 

   //cc;
});

</script> 
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->


<!-- nodedetail -->

<!--node end-->
<!-- 模态框（Modal） -->
<div class="modal  cachecontent fade" id="listLoad" tabindex="-1" style="width:100%; z-index:9999">
    <div>
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="myModalLabel">
               模态框（Modal）标题
            </h4>
         </div>
         <div class="contionfilter clearfix">
         	<div class="input-group2 mr20"> <label for=""><span class="input-group-text">Protocol Name:</span><input type="text"></label></div>
        	<div class="input-group2 mr20"> <label for=""><span class="input-group-text">Application:</span><input type="text"></label></div>
        
        
        <input id="filterButton" type="button" class="btn btn-primary query" value="Query">
         </div>
         <div class="modal-body" style="padding-bottom:0">
            <div class="container " style="width:100%; padding-bottom:0 ">
    <div class="portlet box s-protlet-theme">
      <div class="portlet-body">
        <table class="table table-bordered table-striped table-hover text-center nowrap-ingore group-check" id="dtm">
        

          <thead>
            <tr>
              <th> <input type="checkbox" class="group-checkable" data-set=".group-check .checkboxes"></th>
              <th> ID </th>
              <th> Code</th>
              <th> Name</th>
              <th> Specification Value</th>
              <th> Remarks </th>
              <th> Customized </th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
  </div>
         </div>
         <div class="modal-footer" style="margin-top:10px">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary"  id="ProtocolMChoose">
               提交更改
            </button>
         </div>
      </div><!-- /.modal-content -->
   </div>
</div><!-- /.modal -->
<!-- 模态框（Modal） -->
<!-- -->
<div class="modal fade cachecontent" id="variableModal" style="width:100%; z-index:9999">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">模态框（Modal）标题</h4>
         </div>
         <div class="margin-top-10 clearfix" style="padding:10px">
         	<div class="col-md-8"  style="border:1px solid #dfdfdf; padding:0; height:260px">
                <textarea class="form-control" style="height:260px;resize:none" id="variAE2" type="data-area"></textarea>
            </div>
         	<div class="col-md-4">
            	<ul id="nodepathTab3" class="nav nav-tabs">
   					<!--<li class="active"><a href="#pathmain2" data-toggle="tab">Nodelist</a> </li>-->
                	<li class="active"><a href="#varipathfix2" data-toggle="tab">function</a> </li>
		 		</ul> 
         		<div class="tab-content" style="height:220px">
       			  <div class="tab-pane fade in active  tab-content-m" id="varipathfix2">
                  	   <ul id="xqueryVarity" class="xquerymethord functionOp" function-target="variAE2"><li type="conact">conact</li><li type="substring">substring</li><li type="lower">lower</li><li type="upper">upper</li></ul>
         			</div>
                    <div class="tab-pane fade in  tab-content-m" id="pathmain2">
                    	<div class="modal-body GooFlow stolist" style="padding: 0px; height: 310px;" id="pathmain2">
                        	<div class="pathList" style="width: 260px; height: 310px;"><ul class="l" id="baseVersion1"><div class="head"><span class="title" tip="xyname">xyname</span><em id="choselist" class="glyphicon glyphicon-import"><em style="padding-left:5px">Select</em></em></div><li id="T1L1" class="par" name="soapenv:Envelope5" nodetype="12" nodenum="12" dept="1" path="/soapenv:Envelope6/penv:En/odeDesc/" nodedescidpath="/48639" childcount="2" nodedescid="48639"><span class="d-t"><em style="margin-left:5px">soapenv:Envelope5</em></span><div class="tips">soapenv:Envelope5</div></li></ul></div>
                        </div>
   			  		</div>
                </div>
            </div>
          </div>
          <div class="modal-foot margin-bottom-15 clearfix margin-top-10">
         <input class="btn btn-default margin-left-10"  type="button" value="取消"  data-dismiss="modal" aria-hidden="true"> <input type="button" value="提交" class="btn theme-btn"  id="pathOk"></div> 	
      	</div>
                <!-- /.modal-content -->
</div>



<!--etvalueexprwin end-->

</html>