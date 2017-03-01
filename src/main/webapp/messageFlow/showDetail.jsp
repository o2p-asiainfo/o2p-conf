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
  <link href="../conf/resources/plugins/bootstrap-datepicker/datepicker.css" rel="stylesheet" />
  <link href="../conf/resources/plugins/data-tables/DT_bootstrap.css" rel="stylesheet" />
  <link href="../conf/resources/plugins/select2/select2.min.css" rel="stylesheet" />
  <link href="../conf/resources/css/process.css" rel="stylesheet" />
  <link href="../conf/resources/css/process.css" rel="stylesheet" />
  <!-- END PAGE LEVEL PLUGIN STYLES -->

  <!-- BEGIN THEME STYLES -->
  <%@ include file="../conf/resources/includes/global-css2.jsp"%>
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
<div id="cacheObjhtml"  class="container">
    <div class="form-body">
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label class="control-label i18n"><span class="red">*</span><span class="i18n">CNF20000007</span> </label>
            <input id="cacheName" type="text" placeholder="Name" class="form-control" validtde="true">
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000008</label>
            <input id="cacheType" type="text" placeholder="Name" class="form-control" disabled="true"  value="REMOTE">
          </div>
        </div>
        <!--/span-->
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000009</label>
            <select class="form-control" id="forceRefresh">
              <option value="1">Y</option>			
			  <option value="2">N</option>					
            </select>
          </div>
        </div>
        <!--/span-->
      </div>
      <div class="row">
      	<div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000011</label>
            <input type="text" placeholder="Expire Time Path" class="form-control" id="expireTimeParth">
            <p style="margin-top:5px;color:#999" class="i18n">CNF20000023</p>
            
          </div>
        </div>
        <div class="col-md-6">
          <div class="form-group">
            <label class="control-label i18n">CNF20000010</label>
            <input type="text" placeholder="Expire Time" class="form-control" id="expireTime"  validtde="true">
          </div>
        </div>

      </div>
      <div class="row">
        <div class="col-md-12">
          <div class="form-group">
            <label class="control-label i18n">CNF20000014</label>
            <div>
                <!--<table id="cacheObjList" class="table table-bordered margin-top-10">-->
                <table class="table table-sl table-bordered table-nowrap text-middle" id="cacheObjList">
          			<thead>
            			<tr>
                        	<th style="width:36px"></th>
                            <th  class="i18n"  style="width:150px">CNF20000022</th>
                            <th  class="i18n">CNF20000015</th>
                            <th  class="i18n">CNF20000019</th>
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
    <button type="button" class="btn btn-default i18n" data-dismiss="modal" id="cacheDetailClose">CNF20000013</button>
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
  <script src="../conf/resources/plugins/bootstrap-datepicker/bootstrap-datepicker.js"></script>
  <script src="../conf/resources/plugins/data-tables/jquery.dataTables.min.js"></script>
  <script src="../conf/resources/plugins/data-tables/DT_bootstrap.js"></script>
  <script src="../conf/resources/plugins/select2/select2.min.js"></script>
  <script src="../conf/resources/scripts/syncOffer.js"></script>  
  <script src="../conf/resources/scripts/cacheIinstall.js"></script> 
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
         theRequest[strs[i].split("=")[0]]=(strs[i].split("=")[1]);
      }
   }
   var id=theRequest['cacheStrategyId'];
   setInstall.init(id); 
   $("#cacheDetailClose").on("click",function(){
	   $(window.parent.document).find('.aui_state_focus').remove();
	   //$(window.parent.document).find('#closeButtonCacheStrategy').click();
	   $(window.parent.document).find('#closeButton').click();
   });
});

</script> 
<!-- END JAVASCRIPTS -->
</body>


</html>