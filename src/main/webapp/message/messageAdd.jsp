<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
<title>messageAdd</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY script -->
<script type="text/javascript" src="${contextPath}/resource/new/scripts/jqueryselect.min.js"></script>
<script src="${contextPath}/resource/new/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script> 
<!--END GLOBAL MANDATORY script -->
  
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="${contextPath}/resource/new/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resource/new/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->

<!--select2-->
<link href="${contextPath}/resource/new/select2-4.0.0-rc.2/dist/css/select2.min.css" rel="stylesheet" type="text/css"/>
<script src="${contextPath}/resource/new/select2-4.0.0-rc.2/dist/js/select2.js" type="text/javascript"></script>


<!--BEGIN DATEPICKER -->
<link  href="${contextPath}/resource/new/datepicker/css/datepicker.css" style="text/css" rel="stylesheet"></link>
<script src="${contextPath}/resource/new/datepicker/js/bootstrap-datepicker.js" type="text/javascript"></script>


<script type="text/javascript">
	$(document).ready(function(){
		$("#msgType").select2().on("click",(function(){
			var msgTypeV = $("#msgType").val();
			if(msgTypeV==1){
				$("#personaleObject").show();
				$("#roleObject").hide();
				$("#time").hide();
			}else if(msgTypeV==2){
				$("#personaleObject").hide();
				$("#roleObject").show();
				$("#time").show();
		}
		}));
	});
	function switchHide(msgTypeV){alert(msgTypeV);
		if(msgTypeV==1){
			$("#personaleObject").show();
			$("#roleObject").hide();
			$("#time").hide();
		}else if(msgTypeV==2){
			$("#personaleObject").hide();
			$("#roleObject").show();
			$("#time").show();
		}
	}
</script>
</head>
<!-- END HEAD -->
<body class='contrast-orange '>
<!-- BEGIN HEADER --><!-- END HEADER --> 

<!-- BEGIN PAGE CONTAINER -->
  <!-- BEGIN CONTAINER -->
  <div class="panel-body">
  	<ol class="breadcrumb">
    <li><a href="#">Home</a></li>
    <li><a href="#">Message</a></li>
    <li class="active" >Add Message</li>
   </ol>
  </div>
   <div class="panel-body">
     <form class="form-horizontal" role="form" action="${contextPath}/message/addOrUpdateMessage.shtml">
      <div id="hideDiv">
      	<input type="hidden" value="${message.msgId }" name="message.msgId" id="msgId"/>
      </div>
      <div class="form-body">
       <div class="form-group">
        <label class="col-md-2 control-label"><font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.title')}"/></label>
        <div class="col-md-4"><div>
            <input type="text" class="form-control" placeholder="Message headlines" id="msgTitle" name="message.msgTitle" value="${message.msgTitle }"></input>
         </div></div>
         <label class="col-md-2 control-label">
         <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.subTitle')}"/></label>
        <div class="col-md-4">
        	<div>
            <input type="text" class="form-control" placeholder="Message the subtitles" id="msgSubtitle" name="message.msgSubtitle" value="${message.msgSubtitle }"></input>
          </div>
        </div>
       </div>
       <div class="form-group">
        <label class="col-md-2 control-label">
         <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.msgWay')}"/></label>
        <div class="col-md-4">
         <div class="input-icon"><select class="js-example-basic-single form-control" id="msgWay" name="message.msgWay">
            <optgroup>
            <option value="1">News Station</option>
            <option value="2">SMS </option>
            <option value="3">E-mail</option>
            </optgroup>
            </select>
          </div>
         </div>
         <label class="col-md-2 control-label">
         <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.recType')}"/></label>
        <div class="col-md-4">
         <div class="input-icon"> <select class="form-control" id="msgType" name="message.msgType">
            <optgroup>
            <option value="1" onclick="switchHide(1)">Personal</option>
            <option value="2" onclick="switchHide(2)">Role</option>
            </optgroup>
            </select>
          </div>
         </div>
       </div>
	</div>
      <div class="form-group">
      <div>
      <div id='roleObject'>
        <label class="col-md-2 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.msgObject')}"/></label>
        <div class="col-md-4">
          <div>
            <select class="js-example-basic-multiple" id="msgType" name="msgType" multiple="multiple">
	            <optgroup>
		            <option value="1">Developers</option>
		            <option value="2">API Suppliers </option>
		            <option value="3">Partners</option>
		            <option value="4">Internals</option>
		            <option value="5">Administrator</option>
	            </optgroup>
            </select>
          </div>
        </div>
         </div>
         <div id='personaleObject' style="display:none" >
        	  <label class="col-md-2 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.msgObject')}"/></label>
        <div class=" col-sm-2">
            <input type="text" class="form-control" placeholder="Enter text"></input>
        </div>
        <div class="col-md-2"><button type="button" class="btn btn-warning" >query</button></div>
        </div>
        </div>
        
        <label class="col-md-2 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.adddress')}"/></label>
        <div class="col-md-4">
          <div class="input-icon">
            <input type="text" class="form-control" placeholder="Enter text"></input>
          </div>
        </div>
      </div>
      <div class="form-group" id='time'>
        <label class="col-md-2 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.startDate')}"/></label>
        <div class="col-md-3">
          <div  id="sandbox-container"> 
			<div class="form-control">
			  <input type="text"  value="The start  time" style="border:0;"></input>
			  <span class="add-on"><i class="fa fa-calendar"></i></span>
</div>
          </div>
        </div>
        <label class="col-md-3 control-label"> <font color='FF0000'>*</font><s:property value="%{getText('eaap.op2.conf.message.endDate')}"/></label>
        <div class="col-md-3">
          <div class="form-control" id="sandbox-container"> 
   			 <input type="text"  value="The end of time" style="border:0;"></input>
    <span class="add-on"><i class="fa fa-calendar"></i></span>
          </div>
        </div>
        </div>
      <div class="form-group">
        <label class="col-md-2 control-label"><s:property value="%{getText('eaap.op2.conf.message.msgContend')}"/></label>
        <div class="col-md-10" >
         <div class="input-icon">
         <textarea class="form-control" rows="5"></textarea>
         </div>
        </div>
       </div>
      <!-- BEGIN PAGE CONTAINER -->
      <div class=" col-lg-12 text-center">
                  <button type="submit" class="btn green"><s:property value="%{getText('eaap.op2.conf.message.add')}"/></button>
                  <button type="button" class="btn default"><s:property value="%{getText('eaap.op2.conf.message.cancel')}"/></button>
                  <button type="button" class="btn default"><s:property value="%{getText('eaap.op2.conf.message.preview')}"/></button>
      </div>
<!-- END TAB CONTENT --> 
<!-- END COPYRIGHT --> 
<!-- Load javascripts at bottom, this will reduce page load time --> 
<!-- BEGIN CORE PLUGINS(REQUIRED FOR ALL PAGES) --> 
<!-- END CORE PLUGINS --> 
<!-- BEGIN PAGE LEVEL JAVASCRIPTS(REQUIRED ONLY FOR CURRENT PAGE) --> 

 <script>
$(document).ready(function() {
  $(".js-example-basic-multiple").select2({
  placeholder: "Select role"});
});
</script>

<!--BEGIN datepicker js-->
<script type="text/javascript">
$('#sandbox-container input').datepicker({
});
</script>
<script>
function switchHide(n)
{alert(n);
if(n==1)
{
document.getElementById('personaleObject').style.display = '';
document.getElementById('roleObject').style.display = 'none';
document.getElementById('time').style.display = 'none';
}
if(n==2)
{
document.getElementById('personaleObject').style.display = 'none';
document.getElementById('roleObject').style.display = '';
document.getElementById('time').style.display = '';
}
}
//
</script>
<!--END datepicker js-->
</form>
</div>
<!-- END PAGE LEVEL JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
