<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
  tr.datagrid-row-selected{color:#000}
</style>
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
	title[0]='<s:property value="%{getText('eaap.op2.conf.task.taskCycleCd')}"/>';
	title[1]='<s:property value="%{getText('eaap.op2.conf.task.taskCycleName')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.task.expression')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.task.taskCycleDesc')}" />';
	
	   //search Function
	function searchTaskCycle(){		
		 var form = $("#showTaskCycleForm").form();
	      $('#taskCycleList').datagrid("load", sy.serializeObject(form));		    			
	}
    
	function deleteMethod(){ 					   
     if($('#taskCycleList').datagrid('getSelections')[0]==null||$('#taskCycleList').datagrid('getSelections')[0].gcCd==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
     }
     else{
    	if(confirm("<s:property value="%{getText('eaap.op2.conf.prov.systemConfirmDel')}" />"))
			{			
				var gcCd = $('#taskCycleList').datagrid('getSelections')[0].gcCd ;
				$.ajax({
		            type:"post",
		            async:false,
		            url:"../taskManager/deleteTaskCycle.shtml",
		            dataType:"json",
		            data:{gcCd:gcCd},
		            success:function(msg){
			            if(msg){
			            	alert("<s:property value="%{getText('eaap.op2.conf.task.notDelete')}" />");
			            }else {
			                $('#taskCycleList').datagrid('reload');
		            }
		        }
		        });
				
		   	//	window.location="deleteTaskCycle.shtml?gcCd=" + gcCd;
			}	
     	}  
   }
   		 
   function addMehtod(){	  
        var taskCycleFlag = $("#taskCycleFlag").val();
  		window.location = "gotoAddTaskCycle.shtml?taskCycleFlag=" + taskCycleFlag;
   } 
             
  function updateMethod(){      
	if($('#taskCycleList').datagrid('getSelections')[0]==null||$('#taskCycleList').datagrid('getSelections')[0].gcCd==""){
     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
    	}
    	else{
    	    var taskCycleFlag = $("#taskCycleFlag").val();    				
			var gcCd = $('#taskCycleList').datagrid('getSelections')[0].gcCd ;
			window.location="gotoAddTaskCycle.shtml?gcCd=" + gcCd + "&taskCycleFlag=" + taskCycleFlag;		
    	} 	
    }	 
    
  function clickMethod(index,field,value){   
/*    if($('#taskCycleList').datagrid('getSelections')[0]!=null)
    	{
         var gcCd = $('#taskCycleList').datagrid('getSelections')[0].gcCd ;
         if(gcCd=="")
		  {
		    alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		  }else{
		    var taskCycleFlag = $("#taskCycleFlag").val();
			window.location="gotoAddTaskCycle.shtml?gcCd=" + gcCd + "&taskCycleFlag=" + taskCycleFlag;
		 }
   		} 
*/
	} 
   
    function check_num(obj){
        obj.value = obj.value.replace(/[^\d]/g,'');
    }
    function check_num2(obj){
		obj.value = jQuery.trim(obj.value);
    }
    
    function parentResearch(){
	    var vOpener=art.dialog.opener;
	    vOpener.reSearch();
	    art.dialog.close();
    }
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.portal.prov.openFlatbed')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      		<s:property value="%{getText('eaap.op2.conf.task.taskCycle')}" />      
	      	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
    	
    <div id="queryBlock">    
	<div class="selectList" style="display:block;">
	<ui:form id="showTaskCycleForm" method="post" action="showTaskCycle.shtml">					
			<input id="taskCycleFlag" name="taskCycleFlag" type="hidden" value="${taskCycleFlag}" />
    		<dl class="noBorder">	
    				<dt><s:property value="%{getText('eaap.op2.conf.task.taskCycleName')}" />:</dt>	
    				<dt><ui:inputText id="taskCycleName"  name="taskCycleName"  readonly="false" skin="${contextStyleTheme}" style="float:left;"/></dt>	
    				<dt><s:property value="%{getText('eaap.op2.conf.task.taskCycleCd')}" />:</dt>	
    				<dt><ui:inputText id="taskCycleCd"  name="taskCycleCd"  readonly="false" skin="${contextStyleTheme}" style="float:left;" onkeyup="check_num(this)" onblur="check_num2(this)"/></dt>	  				
    				<dt></dt>
    				<dd></dd>
    			<dt>				
					<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchTaskCycle();" skin="${contextStyleTheme}"/>
				</dt>
			</dl>
	
	<br/>
	<dl class="noBorder">	
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="taskCycleList" remoteSort="false" sortOrder="desc"  onClickCell="true" toolbar="true"
		skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.conf.task.taskCycle')}" 
		striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
		method="eaap-op2-conf-task-action-taskCycleAction.getTaskCycleList">
		<ui:gridEasyColumn width="200" index="0" title="0" field="gcCd" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="1" title="1" field="name" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="gcSEExp" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="3" title="3" field="gcDesc" hidden="false"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
	  </dl>
	 </div>
   </div>
</div>
<c:if test="${taskCycleFlag=='1'}">
  <table class="mgr-table">
     <tr>
      <td  colspan="4"  align="center">
		 <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.prov.close')}"  onclick="parentResearch();"></ui:button>
      </td>	
     </tr>
  </table>
</c:if>
</body>
</ui:form>
<%@ include file="/common/ssoCommon.jsp"%>
</html>