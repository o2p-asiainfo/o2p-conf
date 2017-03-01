<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/easyui/default/easyui.css" />
	<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>		

	<script>
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.task.taskName')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.task.ServiceObjectId')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.task.threadNum')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.task.taskCycle')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.task.taskType')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.task.taskStyle')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.task.startTime')}" />';
	title[7]='<s:property value="%{getText('eaap.op2.conf.task.stopTime')}" />';
	title[8]='<s:property value="%{getText('eaap.op2.conf.task.latestTime')}" />';
	title[9]='<s:property value="%{getText('eaap.op2.conf.prov.state')}" />';
	title[10]='<s:property value="%{getText('eaap.op2.conf.task.serviceStatus')}" />';
	
	   //search Function
	function searchTask(){
		 var text = $("#taskName").val();
		 if(text!=null && text!=""){
			 var reg =new RegExp("(<script[^>]*>[\s\S]*?<\/script[^>]*>|<script[^>]*>[\s\S]*?<\/script[[\s\S]]*[\s\S]|<script[^>]*>[\s\S]*?<\/script[\s]*[\s]|<script[^>]*>[\s\S]*?<\/script|<script[^>|*]+>[\s\S]*|</script[^>]*>?)");
			 if(reg.test(text)){
				 alert("invalid request!");
				 return;
			 }
			 reg =new RegExp("([\s\"'`;\/0-9\=]+on\w+\s*=)");
			 if(reg.test(text)){
				 alert("invalid request!");
				 return;
			 }
			 reg =new RegExp("(?:=|U\s*R\s*L\s*\()\s*[^>]*\s*S\s*C\s*R\s*I\s*P\s*T\s*:|&colon;|[\s\S]allowscriptaccess[\s\S]|[\s\"'`;\/0-9\=]+src\s*=|[\s\S]data:text\/html[\s\S]|[\s\S]xlink:href[\s\S]|[\s\S]base64[\s\S]|[\s\S]xmlns[\s\S]|[\s\S]xhtml[\s\S]|[\s\"'`;\/0-9\=]+style\s*=|<style[^>]*>[\s\S]*?|[\s\S]@import[\s\S]|<applet[^>]*>[\s\S]*?|<meta[^>]*>[\s\S]*?|<object[^>]*>[\s\S]*?)");
			 if(reg.test(text)){
				 alert("invalid request!");
				 return;
			 }
			 reg =new RegExp("((?:\W|^)(?:eval|alert|setTimeout)\(.*\)|(?:\W|^)(?:document|window)\.\w+\(.*\))");
			 if(reg.test(text)){
				 alert("invalid request!");
				 return;
			 }
		 }
		 var form = $("#showTaskForm").form();
	      $('#taskList').datagrid("load", sy.serializeObject(form));
	      $('.datagrid-header-check :checkbox').removeAttr("checked");	    			
	}
	   
	function runTask(){
  		var taskIdStr = "";
        $.each($('#taskList').datagrid('getSelections'),function(){
            taskIdStr += this.taskId + ',';
        });
        if (taskIdStr != ""){
        	taskIdStr = taskIdStr.substr(0,taskIdStr.length-1);
        }
        
		if(($('#taskList').datagrid('getSelections')[0]==null||$('#taskList').datagrid('getSelections')[0].taskId=="")){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
	    }
	    else{   mask();
		    	$.ajax({
					type: "POST",
					async:true,
				    url: "../taskManager/operatorTask.shtml",
				    dataType:'json',
				    data:{taskIdStr:taskIdStr,operator:"run"},
					success:function(msg){ 
					   unmask();	
					  if (msg[0].data[0] != '') {
						  var last=JSON.stringify(msg[0].data);
						  var re = new RegExp("},{", "g");
						  alert(last.replace(re, "}\n{"));
						  window.location="showTask.shtml";
					  } 
					  window.location="showTask.shtml";
	                }
               });
	    	} 	
    }

  	function startTask(){
  		var taskIdStr = "";
        $.each($('#taskList').datagrid('getSelections'),function(){
            taskIdStr += this.taskId + ',';
        });
        if (taskIdStr != ""){
        	taskIdStr = taskIdStr.substr(0,taskIdStr.length-1);
        }
        
		if(($('#taskList').datagrid('getSelections')[0]==null||$('#taskList').datagrid('getSelections')[0].taskId=="")){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
	    }
	    else{   mask();
		    	$.ajax({
					type: "POST",
					async:true,
				    url: "../taskManager/operatorTask.shtml",
				    dataType:'json',
				    data:{taskIdStr:taskIdStr,operator:"start"},
					success:function(msg){ 
					   unmask();	
					  if (msg[0].data[0] != '') {
						  var last=JSON.stringify(msg[0].data);
						  var re = new RegExp("},{", "g");
						  alert(last.replace(re, "}\n{"));
						  window.location="showTask.shtml";
					  } 
					  window.location="showTask.shtml";
	                }
               });
	    	} 	
    }
    
    function stopTask(){
        
        var taskIdStr = "";
         $.each($('#taskList').datagrid('getSelections'),function(){
            taskIdStr += this.taskId + ',';
         });
         if (taskIdStr != ""){
        	taskIdStr = taskIdStr.substr(0,taskIdStr.length-1);
         }
        
		if(($('#taskList').datagrid('getSelections')[0]==null||$('#taskList').datagrid('getSelections')[0].taskId=="")){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
	    }
	    else{  mask();
	    	   $.ajax({
					type: "POST",
					async:true,
				    url: "../taskManager/operatorTask.shtml",
				    dataType:'json',
				    data:{taskIdStr:taskIdStr,operator:"stop"},
					success:function(msg){
						  unmask();
						  if (msg[0].data[0] != '') {
							  var last=JSON.stringify(msg[0].data);
							  var re = new RegExp("},{", "g");
							  alert(last.replace(re, "}\n{"));
							  window.location="showTask.shtml";
						  } 
					  window.location="showTask.shtml";
	                }
               });
          }
    }
    
	function deleteMethod(){
		 var taskIdStr = "";
         $.each($('#taskList').datagrid('getSelections'),function(){
            taskIdStr += this.taskId + ',';
         });
         if (taskIdStr != ""){
        	taskIdStr = taskIdStr.substr(0,taskIdStr.length-1);
         }
	     if($('#taskList').datagrid('getSelections')[0]==null||$('#taskList').datagrid('getSelections')[0].taskId==""){
	     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
	     }
	     else{
	     	
	     	var taskState = $('#taskList').datagrid('getSelections')[0].taskState ;
			
				if(taskState=='I'){
					alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseStopTask')}" />");
					return;
				}
			
	    	if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmDel')}" />")){   
	    		    mask();
			   		$.ajax({
						type: "POST",
						async:true,
					    url: "../taskManager/deleteTask.shtml",
					    dataType:'json',
					    data:{taskIdStr:taskIdStr},
					    success:function(msg){ 
							  unmask();
							  if (msg[0].data[0] != '') {
								  var last=JSON.stringify(msg[0].data);
								  var re = new RegExp("},{", "g");
								  //alert(last.replace(re, "}\n{"));
							  } 
						  window.location="showTask.shtml";
		                }
	                });
				}	
     	}  
   }
   		 
   function addMehtod(){	  
       // alert(window.parent.$('#login').text());
  		window.location = "gotoAddTask.shtml";
   } 
             
  function updateMethod(){
    
      	var count=0;
        $("input[name='ck']:checkbox").each(function(){ 
            if($(this).attr("checked")){
                count++;
            }
        })
         
		if(($('#taskList').datagrid('getSelections')[0]==null||$('#taskList').datagrid('getSelections')[0].taskId=="") || count>1){
     		alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
    	}
    	else{    				
			var taskState = $('#taskList').datagrid('getSelections')[0].taskState ;
			
			if(taskState=='I'){
				alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseStopTask')}" />");
				return;
			}
			var taskId = $('#taskList').datagrid('getSelections')[0].taskId ;
			
			
			window.location="gotoAddTask.shtml?taskId=" + taskId;		
    	} 	
    }	 
    
  function clickMethod(index,field,value){   
/*    if($('#taskList').datagrid('getSelections')[0]!=null)
    	{
         var taskId = $('#taskList').datagrid('getSelections')[0].taskId ;
         if(taskId=="")
		  {
		    alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		  }else{
			window.location="gotoAddTask.shtml?taskId=" + taskId;
		 }
   		} 
 */
	} 
  
 function formatterForService(value,row,index){
	   if(value == 'A'){
	        return "<s:property value="%{getText('eaap.op2.conf.task.usable')}" />"  ;
	   }else if(value == 'D'){
	    	return "<s:property value="%{getText('eaap.op2.conf.task.disable')}" />"  ;
	   }
 }
  
function formatterForState(value,row,index){
	    if(value=='A'){
	      return "<s:property value="%{getText('eaap.op2.portal.prov.effective')}" />"  ;
	    }
	    else if(value=='R'){
	      return "<s:property value="%{getText('eaap.op2.conf.prov.effectiveLoss')}" />"  ;
	    } 
	    else if(value=='Y'){
	      return "<s:property value="%{getText('eaap.op2.conf.prov.yes')}" />"  ;
	    } 
	    else if(value=='F'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.notRunNomal')}" />"  ;
	    }
	    else if(value=='I'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.running')}" />"  ;
	    } 
	    else if(value=='E'){
	      return "<s:property value="%{getText('eaap.op2.conf.task.notRunError')}" />"  ;
	    }
	    else{
	    }
   }
   
    function startAllTask(){
       mask();
   	   $.ajax({
			type: "POST",
			async:true,
		    url: "../taskManager/operatorTask.shtml",
		    dataType:'json',
		    data:{allFlag:"1",operator:"start"},
			success:function(msg){ 
				unmask();
				if (msg[0].data[0] != '') {
					  var last=JSON.stringify(msg[0].data);
					  var re = new RegExp("},{", "g");
					  alert(last.replace(re, "}\n{"));
					  window.location="showTask.shtml";
				  } 
			  	window.location="showTask.shtml";
              }
         });
    }
    
    function stopAllTask(){
    	mask();
   	   $.ajax({
			type: "POST",
			async:true,
		    url: "../taskManager/operatorTask.shtml",
		    dataType:'json',
		    data:{allFlag:"1",operator:"stop"},
			success:function(msg){ 
				unmask();
				if (msg[0].data[0] != '') {
					  var last=JSON.stringify(msg[0].data);
					  var re = new RegExp("},{", "g");
					  alert(last.replace(re, "}\n{"));
					  window.location="showTask.shtml";
				  } 
			  	window.location="showTask.shtml";
              }
         });
    }

</script>
	<script language="javascript">	
	<s:iterator value="actionScripts">
		<s:property escape="false"/>
	</s:iterator>
	</script>
</head>
<body>
<ui:loadmask id="contentDiv" skin="${contextStyleTheme}">
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.task.ftpTask')}" />      
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="formLayout" style="padding:5px 0;">
	<ui:form id="showTaskForm" method="post" action="showTask.shtml">					
    	<ui:inputText id="allFlag"  name="allFlag"  type="hidden" skin="${contextStyleTheme}" style="float:left;"/>
    			<dl>
    				<dt><s:property value="%{getText('eaap.op2.conf.task.taskName')}" />:</dt>	
    				<dd><ui:inputText id="taskName"  name="taskName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    			</dl>
    			<!-- 
    			<dl>
    				<dt><s:property value="%{getText('eaap.op2.conf.task.serInvokeInsName')}" />:</dt>	
    				<dd><ui:inputText id="serInvokeInsName"  name="serInvokeInsName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dd>	
    			</dl>
    			 -->
    			<dl style="width:320px;">
    				<dt><s:property value="%{getText('eaap.op2.conf.prov.state')}" />:</dt>
    				<dd style="width:160px;">
	    				<ui:select  
	    				name="statu" 
	    				id="statu"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="selectStateList" 
	    			    listKey="code" 
	    			    listValue="name" 
	    			    style="width:70px;" 
	    			    skin="${contextStyleTheme}"/>
    				</dd>	
    			</dl>
				<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchTask();" skin="${contextStyleTheme}"/>
	</ui:form>
	</div>
	<div style="clear:both;">   
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="false" id="taskList" remoteSort="false" sortOrder="desc"  onClickCell="true" toolbar="true"
		skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.task.taskName')}" 
		striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
		method="eaap-op2-conf-task-action-taskAction.getTaskList">
		<ui:gridEasyColumn width="200" index="0" title="0" field="taskName" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="1" title="1" field="serviceObjectId" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="threadNumber" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="3" title="3" field="name" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="4" title="4" field="taskTypeName" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="5" title="5" field="taskStyleName" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="6" title="6" field="startDate" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="7" title="7" field="stopDate" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="8" title="8" field="stateLastDate" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="9" title="9" field="taskState" hidden="false"   align="center" formatter="true" formatterMethod="formatterForState"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="10" title="10" field="serviceStatus" hidden="false"   align="center" formatter="true" formatterMethod="formatterForService"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="10" index="11" title="11" field="taskId" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="10" index="12" title="12" field="gcExp" hidden="true"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
   </div>
   
	<table class="mgr-table" >
	   <tr>
	     <td align="center">
	     			<!--<ui:button text="%{getText('eaap.op2.conf.task.run)}" id="run" onclick="runTask();" skin="${contextStyleTheme}"/>-->
					<ui:button text="%{getText('eaap.op2.conf.task.start')}" id="start" onclick="startTask();" skin="${contextStyleTheme}"/>
					<ui:button text="%{getText('eaap.op2.conf.task.stop')}" id="stop" onclick="stopTask();" skin="${contextStyleTheme}"/> 
					<!--<ui:button text="%{getText('eaap.op2.conf.task.startAll')}" id="start" onclick="startAllTask();" skin="${contextStyleTheme}"/>-->
					<!--<ui:button text="%{getText('eaap.op2.conf.task.stopAll')}" id="stop" onclick="stopAllTask();" skin="${contextStyleTheme}"/>-->
					<c:if test="${reqFrom=='from'}">
						<ui:button text="%{getText('eaap.op2.conf.prov.close')}" id="chooseCompId" onclick="closecurry()" skin="${contextStyleTheme}"></ui:button>
					</c:if >
	      </td>	
	     </tr>
	</table>
   </div>
</div>
<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
<script>
	$(document).ready(function(){
/*	  $('.datagrid-header-check :checkbox').attr("onmouseup","checkHead();");
	  $('.datagrid-header-check :checkbox').click(function(){
	        var str=true;
            $("input[name='ck']:checkbox").each(function(){ 
                if(!$(this).attr("checked")){
                    str=false;
                }
            })
	  		if (str) {
	  		    $("[name='ck']").removeAttr("checked");
	  		} else {
	  			$("[name='ck']").attr("checked",'true');
	  		}
	  }); 
	  */	
	  
	  $('.datagrid-header-row .datagrid-cell').click(function(){
	        $('.datagrid-header-check :checkbox').removeAttr("checked");
	  });
	});
	
	function checkHead(){
	   if ($('.datagrid-header-check :checkbox').attr("checked")) {
	   		$('.datagrid-header-check :checkbox').removeAttr("checked");
	   } else {
	   		$('.datagrid-header-check :checkbox').attr("checked",'true');
	   }
	}

</script>
</ui:loadmask>
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>