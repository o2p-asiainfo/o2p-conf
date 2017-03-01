<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src="../resource/resources/scripts/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		function docMag(){
			var returnText = showModalDialog('docManager.shtml','_blank','dialogWidth=868px;dialogHeight=560px;dialogLeft=188px;dialogTop=120px;status=yes;scroll=no;resizable=no');
			alert(returnText);
			$("#s1").html(returnText);
		}
	</script>


  </head>
  
  <body>
    <input type="button" value="Click me" id="btn" onclick="docMag()"> <br>
    <select id="s1"></select>
  </body>
</html>
