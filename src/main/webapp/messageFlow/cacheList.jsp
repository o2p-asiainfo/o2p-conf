
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
                        	<th width="4%"></th>
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
    <button type="button" class="btn btn-default" data-dismiss="modal" id="cacheObjClose">Close</button>
    <button type="button" class="btn btn-primary" data-dismiss="modal" id="cacheObjOk">OK</button>
  </div>

