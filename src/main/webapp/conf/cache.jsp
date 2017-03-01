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
<div class="container" id="cacheListpage">
  <div id="cacheListhtml">
	<div class="row breadcrumbs">
      <div class="container">
        <div class="col-md-4 col-sm-4">
          <h1 class="i18n">CNF20000001</h1>
        </div>
      </div>
    </div>
    
    <div class="container margin-bottom-20 margin-top-20">
      <form id="searchBarForm">
        <div class="row">
        <div class="col-md-2">
          <div class="form-group">
            <label class="control-label text-right i18n"  >CNF20000002</label>            
          </div>
        </div>
        <div class="col-md-3">
          <div class="form-group">
            <input type="text" value="" id="CacheStrategyName" class="form-control" placeholder="None">
          </div>
        </div>
        
        </div>
        <div class="row">
        <div class="col-md-12 text-right">          
          <button class="btn theme-btn i18n" id="search" type="button"  i18n-set="data-loading-text" data-loading-text="CNF20000003" autocomplete="off">CNF20000003</button>
        </div>
        </div>
      </form>
    </div>
    <div class="container margin-bottom-40 margin-top-20">
      <div class="portlet box s-protlet-theme">
        <div class="portlet-title">
          <div class="actions" style="float:left; padding:5px 0">
          <button data-target="#myModal" data-toggle="modal" id="btn-add" class="btn default"><i class="fa fa-plus"></i> <span class="i18n">CNF20000004</span></button>
          <button id="btn-edit" class="btn default"><i class="fa fa-edit"></i> <span class="i18n">CNF20000005</span> </button>
          <button id="btn-del" class="btn default"><i class="fa fa-trash-o"></i> <span class="i18n">CNF20000006</span> </button>
          </div>
        </div>
        <div class="portlet-body">
          <div class="table-scrollable">
            <table class="table table-sl table-bordered table-nowrap text-middle" id="dt">
              <thead>
                <tr>
                  <th style="width:5%"></th>
                  <th  class="i18n">CNF20000007 </th>
                  <th  class="i18n">CNF20000008</th>
                  <th  class="i18n">CNF20000009</th>
                  <th  class="i18n">CNF20000010</th>
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
    	<button data-dismiss="modal" class="btn btn-default i18n" type="button" id="cacheClose" >CNF20000013</button>
    	<button id="cacheOk" data-dismiss="modal" class="btn btn-primary i18n" type="button" >CNF20000012</button>
  	   </div>
    </div>
</div>

  <div id="cacheObjhtml" style="display:none">
    <div class="form-body">
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label class="control-label i18n">CNF20000007 </label>
            <input id="cacheName" type="text" placeholder="Name" class="form-control" validtde="true">
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000008 </label>
            <select class="form-control" id="cacheType">
              <option value="0">REMOTE</option>			
			  <option value="1" selected>LOCAL</option>					
            </select>
          </div>
        </div>
        <!--/span-->
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000009 </label>
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
            <label class="control-label i18n">CNF20000010</label>
            <input type="text" placeholder="Expire Time" class="form-control" id="expireTime"  validtde="true">
          </div>
        </div>
        <!--/span-->
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000011</label>
            <div class="clearfix"><input type="text" placeholder="Expire Time Path" class="form-control" id="expireTimeParth" style="display:inline-block;float:left"  validtde="true"></div>
            
          </div>
        </div>
        <!--/span-->
      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label class="control-label i18n">CNF20000014</label>
            <div>
            	<p style="padding-bottom:10px"><button id="addCache" type="button" class="btn  btn-primary i18n">CNF20000004</button>&nbsp;<button id="removeCache" type="button" class="btn  btn-primary i18n">CNF20000006</button></p>
                <!--<table id="cacheObjList" class="table table-bordered margin-top-10">-->
                <table class="table table-sl table-bordered table-nowrap text-middle" id="cacheObjList">
          			<thead>
            			<tr>
                        	<th width="4%"></th>
                            <th width="48%" class="i18n">CNF20000015</th>
                            <th width="48%" class="i18n">CNF20000016</th>
                        </tr>
          			</thead>
          			<tbody> 	
        		</table>
            </div>
          </div>
        </div>
      </div>
     </div>
  <div class=" text-right">
    <button type="button" class="btn btn-default i18n" data-dismiss="modal" id="cacheObjClose">CNF20000013</button>
    <button type="button" class="btn btn-primary i18n" data-dismiss="modal" id="cacheObjOk">CNF20000012</button>
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
    //$("#cacheListpage").load("p2.jsp",function(){});
    //$("#cacheListpage").html("").load("p1.jsp",function(){App.init();setInstall.init();});
    $("#cacheClose").click(function(){
    	//$('#id', window.parent.document).find("")
    	$(window.parent.document).find('#closeButton').click();
    })
});

</script> 
<!-- END JAVASCRIPTS -->

<!-- 模态框（Modal） -->
<div class="modal  cachecontent fade" id="listLoad" tabindex="-1" style="width:100%; z-index:9999">
    
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
         <input class="btn btn-default margin-left-10"  type="button" value="取消"  data-dismiss="modal" aria-hidden="true"> <input type="button" value="提交" class="btn  btn-primary"  id="pathOk"></div> 	
      	</div>
                <!-- /.modal-content -->
</div>

<!-- -->
	
 
</body>
</html>