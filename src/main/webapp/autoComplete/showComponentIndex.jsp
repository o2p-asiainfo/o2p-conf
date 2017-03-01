<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/console.css" />
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jqueryui/jquery-ui-v1.10.3.js"></script>
	<style type="text/css">  
	.ui-autocomplete {max-height: 120px;overflow-y: auto; overflow-x:hidden;}
	.ui-autocomplete-loading {background: white url('${contextPath}/resource/${contextStyleTheme}/images/loading.gif') right center no-repeat;}
	* html .ui-autocomplete {height: 120px;}  
	</style>
</head>
<body>
<!--body start -->
<ui:form method="post" id="form1" name="myform" action="../autocomplete/loadAllComponent.shtml">
	<div class="contentWarp">
	    <div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
	   
	   <div>
	 	<table class="mgr-table">
			<tr>
	  			<td class="item"><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</td>
	  			<td class="item-content">
	  				<div class="ui-widget">
	  					<input type="hidden" name="component.componentId" id="component_id" value="" />
	  					<input type="text" id="component_name" name="component_name" title="Search" size="25" value="" onfocus="changeComponent();" />
	  				</div>
	   			</td>
	   			<td  style="width:10%;TEXT-ALIGN: right;PADDING-RIGHT:30px; ">
  					<a class="button-base button-small" title="<s:property value="%{getText('eaap.op2.conf.techimpl.queryBtn')}" />" target="_blank" onclick="do_qry();">
				  		<span class="button-text"><s:property value="%{getText('eaap.op2.conf.techimpl.queryBtn')}" /></span>
					</a>
	    		</td>
	   		</tr>
	    </table>
	  </div>
	  
	  <br/>
	   <!-- show record area -->
		<iframe name="comptRecord_iframe" id="comptRecord_iframe" frameborder="0" src="" style="border:0px;height:500px;width:100%;"></iframe>
   </div>
</ui:form>
<!--body end --> 
<script type="text/javascript">
	 $(document).ready(function(){
	    do_qry();
	 });
	 
	 var cache = {};
	 function changeComponent(){
	    $("#component_id").val("");
	 	
	    $("#component_name").autocomplete({  
	    	minLength:1,
            autoFocus:true,
	    	source: function(request,response){
	    		 var term = request.term;
            	 if (term in cache){
            	 	response($.map(cache[term],function(item){
                   		return {
                             label:item.label,
                             value:item.value,
                             id:item.id
                         };
                    }));
                    return;
            	 }
            	 
    		 	lastXhr = $.ajax({
    		 		type:"POST",
    		 		url:"../autocomplete/cmptAutoComplete.shtml",
                    dataType:"json",
                    data:{component_name:$("#component_name").val()},
                    success:function(data){
                    	cache[term] = data;
                    	response($.map(data,function(item){
                    		return {
                                 label:item.label,
                                 value:item.label,
                                 id:item.id
                            };
                    	}));
                    }
    		 	});
	    	},
	    	select:function(event,ui){
	    		$("#component_id").val(ui.item.id);
	    	} 
	     });
	 }
	 
	 function do_qry(){
	 	$("#form1").attr("target","comptRecord_iframe");
	 	$("#comptRecord_iframe").attr("src","${contextPath}/autocomplete/loadAllComponent.shtml");
	 	$('#form1').submit();
	 }
	 
</script>
</body>
</html>
