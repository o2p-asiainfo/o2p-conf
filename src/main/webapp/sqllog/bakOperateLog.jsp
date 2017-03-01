<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/contractDoc_files/contractDiv.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/json2.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
 </head>
<body>
<!--body start -->
<div class="contentWarp">
  	<input type="button" value="Backup" id="backup" onclick="backup();"></input>
</div>
</body>
<script>

	function backup(){
		$.ajax({
			type: "POST",
			async:true,
			url: "${contextPath}/sqllog/saveBakOperateLog.shtml",
			dataType:'json',
			beforeSend: function(){
				jQuery("#backup").attr('disabled','disabled');
		    },
		    success: function(data){
		    	jQuery("#backup").removeAttr("disabled");
		    	alert('backup finish');
             }
	    });
	}

</script>
</html>
