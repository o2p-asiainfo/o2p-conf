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

	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>
	<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
		
	<script>		
	function updateTask(){		
			var form = document.getElementById("taskForm");
			var serInvokeInsId = document.getElementById("serInvokeInsId").value;
			if ($("#serInvokeInsName").val() == ""){
			    alert("<s:property value="%{getText('eaap.op2.conf.task.serInvokeInsName')}" />" 
			          + " " + "<s:property value="%{getText('eaap.op2.conf.task.notEmpty')}" />" 
			          + "," + "<s:property value="%{getText('eaap.op2.conf.task.pleaseChoose')}" />" + ".");
	 	        return false;
	 	    }
		  	if(comm_validators_check('group1'))
	       	{
	       	    form.action="editTask.shtml?serInvokeInsId=" + serInvokeInsId;
	       		form.submit();				
	       	}	
		}
		
    function reSearch() {
   		var taskId = $('#taskId').val();
		window.location="gotoAddTask.shtml?taskId=" + taskId;
    }
	
    function returnPage() {
		window.location="showTask.shtml";
    }
		
    function check_num(obj){
        obj.value = obj.value.replace(/[^\d]/g,'');
    }
    function check_num2(obj){
		obj.value = jQuery.trim(obj.value);
    }
    function changeObj(value){
    //	openWindows('','Select Service Invoker')
    	$.ajax({
            type: "POST",
            url: "../taskManager/getObjNameAndUrlByTaskTypeId .shtml",
            data: {taskTypeId:value},
            dataType: "json",
            success: function(data){
            			if(data[0].msg==1){
            				$("#objName").html(data[0].NAME);
            				$("#openButton").attr("onclick",'openWindows("'+data[0].URL+'")');
            			}else{
            				$("#objName").html(data[0].msg);
            				$("#openButton").attr("onclick",'');
            			}
                     }
        });
    	
    }
    
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.conf.task.ftpTask')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      <c:if test="${bean.taskId>0}">
		     	    <s:property value="%{getText('eaap.op2.conf.task.updateTask')}" />
		   	  </c:if>
		   	  <c:if test="${bean.taskId == null || bean.taskId == 0}">
					<s:property value="%{getText('eaap.op2.conf.task.addTask')}" />		   		  
			  </c:if>		      		
	      	</div>
	    </div> 
<ui:form method="post" id="taskForm" action="editTask.shtml">	
<ui:validators validateAlert="word" validatorGroup="group1"> 
	<ui:validator fieldId="taskDesc" validatorType="stringlength" minLength="0" maxLength="249" message="%{getText('eaap.op2.conf.prov.notexceed249char')}"/>
</ui:validators>
	<div class="contentWarp">
	       <div class="accordion-header" >
    			<div class="accordion-header-text">
    				<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
          			<!--<s:property value="%{getText('eaap.op2.conf.task.addTask')}" /> -->
         		</div>       
    	   </div>
	   <div>
		 	<table align="center" class="mgr-table">
		 	<tr>
	   			<td align="right" id="objName"width="15%"><s:property value="%{getText('eaap.op2.conf.task.ServiceRelationObject')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="serInvokeInsName" id="serInvokeInsName"   value="${serviceObjName}" skin="${contextStyleTheme}" readonly="true"/>
	   				<ui:inputText name="bean.taskRelaObj.objId" id="serInvokeInsId" type="hidden" value="${bean.taskRelaObj.objId}" skin="${contextStyleTheme}"/>
	   				<c:if test="${bean.taskId == null || bean.taskId == 0}">
	   					&nbsp;<ui:button id="openButton"  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/selectSerInvokeInsList.shtml?pageState=pageState&serInvokeInsId=serInvokeInsId&&serInvokeInsName=serInvokeInsName','Select Service Invoker')" shape="s"></ui:button>
	   				</c:if>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.taskType')}" />:</td>
	   			<c:if test="${bean.taskId == null || bean.taskId == 0}">
		   				<td width="40%">
		  			    <ui:select  
	    				name="bean.taskType" 
	    				id="taskType"   
	    				emptyOption="true" 
	    			    list="attrSpecValueList" 
	    			    listKey="ID" 
	    			    listValue="NAME" 
	    			    value=""
		    			layerWidth="151px" 
		    			skin="${contextStyleTheme}"
		    			onchange="changeObj(value)"
		    			/>
		   				</td>
	   			</c:if>
	   			<c:if test="${bean.taskId > 0}">
		   				<td width="40%">
		  			  	 	<ui:inputText name="" id="taskType"   value="${bean.taskTypeObj.queueName}" skin="${contextStyleTheme}" readonly="true"/>
		   					<ui:inputText type="hidden" name="bean.taskType" id="taskType"   value="${bean.taskTypeObj.taskTypeId}" skin="${contextStyleTheme}" />
		   				</td>
	   			</c:if>
	  			
	   			 
		   	</tr>
		   	
		   	<!-- 
		   	<tr>
	   			<c:if test="${fn:length(attrSpecValueList)>=1}">
		   			<c:forEach var="tmpListVar" items="${attrSpecValueList}" step="1" varStatus="vs">
		   				 <td align="right" width="15%">
				   		     ${tmpListVar.NAME}
			   		     </td>
			   		     <td width="40%">
				   		   		  <ui:inputText skin="${contextStyleTheme}" id="${tmpListVar.NAME}" name="${tmpListVar.NAME}" value="" textSize="23" />
			   		     </td>
			   		     <c:if test="${vs.index%2==1}">
			   		     </tr><tr>
			   		     </c:if>
		   			</c:forEach>
	   			</c:if>
	   		</tr>
		   	 -->
	   		
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.taskName')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="bean.taskName" id="taskName" value="${bean.taskName}" skin="${contextStyleTheme}"/>
	  				<input type="hidden" name="bean.taskId" id="taskId" value="${bean.taskId}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.taskCode')}" />:</td>
	  			<td width="40%">
	  				<ui:inputText name="bean.taskCode" id="taskCode" value="${bean.taskCode}" skin="${contextStyleTheme}"/>	  			  	  				
	   			</td>
		   	</tr>				  
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.taskCycle')}" />:</td>
	   			<td width="40%">
		   			<div>
		                  <div style="float:left">
		               	        <ui:select  
			    				name="bean.gcCd" 
			    				id="gcCd"   
			    				emptyOption="true" 
			    				headerValue=""
			    			    list="cycleList" 
			    			    listKey="GCCD" 
			    			    listValue="NAME" 
			    			    value="${bean.gcCd}"
				    			layerWidth="330px" 
				    			width="330px"
				    			skin="${contextStyleTheme}"
				    			/>
		                  </div>
		                  <div style="float:left;">&nbsp;&nbsp;&nbsp;</div>
		                  <div style="float:left;">
		             		<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.task.config')}" onclick="openWindows('${contextPath}/taskManager/showTaskCycle.shtml?taskCycleFlag=1','Task Cycle')" shape="s"></ui:button>
		                  </div>
		              </div>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.threadNum')}" />:</td>
	  			<td >
	  			    <c:if test="${!(bean.taskId == null || bean.taskId == 0)}">
	  				    <ui:inputText name="bean.threadNumber" id="threadNumber"  value="${bean.threadNumber}" skin="${contextStyleTheme}" onkeyup="check_num(this)" onblur="check_num2(this)"/>	
	  				</c:if>
                    <c:if test="${bean.taskId == null || bean.taskId == 0}">
                        <ui:inputText name="bean.threadNumber" id="threadNumber"  value="1" skin="${contextStyleTheme}" onkeyup="check_num(this)" onblur="check_num2(this)"/>
                    </c:if> 	  				
	   			</td>
		   	</tr>
		   	
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.task.taskStyle')}" />:</td>
	   			<td>
				  			<ui:select  
			    				name="bean.taskStyle" 
			    				id="taskStyle"   
			    				emptyOption="false" 
					    		headerValue=""
			    			    list="taskStyleList" 
			    			    listKey="TASK_STYLE" 
			    			    listValue="TASK_STYLE_DESC" 
			    			    value="${bean.taskStyleObj.taskStyle}"
				    			layerWidth="151px" 
				    			skin="${contextStyleTheme}"
				    		/>
	   			</td>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.task.serviceStatus')}" />:</td>
	   			<td>
	   				<c:if test="${bean.taskId == null || bean.taskId == 0}">
	   					<ui:inputText name="" id="serviceStatusName"   skin="${contextStyleTheme}" readonly="true"/>
		   				<ui:inputText type="hidden" name="bean.serviceStatus" id="serviceStatusInput"  skin="${contextStyleTheme}" />
	   				</c:if>
	   				<c:if test="${bean.taskId > 0}">
	   					<ui:select skin="${contextStyleTheme}"  emptyOption="false" headerValue="" name="bean.serviceStatus" id="serviceStatus" 
		       			list="serviceStatusList" listKey="cepCode" listValue="cepName" style="width:150px;" ></ui:select>
	   				</c:if>
	   			</td>
		   	</tr>
		   	
		   	<c:if test="${!(bean.taskId == null || bean.taskId == 0)}">
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.startTime')}" />:</td>
	   			<td>
	   			    <ui:inputText name="bean.startDate" id="startDate" readonly="true" value="${bean.startDate}" skin="${contextStyleTheme}"/>
	   			</td>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.stopTime')}" />:</td>
	  			<td>
	  			    <ui:inputText name="bean.stopDate" id="stopDate" readonly="true" value="${bean.stopDate}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
			<tr>
			    <td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.prov.state')}" />:</td>
	   			<td colspan="4"  >
	   			    <ui:inputText name="taskState" id="taskState" readonly="true" value="${taskState}" skin="${contextStyleTheme}"/>
   					<div style="display:none">
	   					<ui:select  
	    				name="bean.taskState" 
	    				id="taskState1"   
	    				emptyOption="true" 
	    				headerValue=""
	    			    list="selectStateList" 
	    			    listKey="code" 
	    			    listValue="name" 
		    			layerWidth="200px" 
		    			skin="${contextStyleTheme}"
		    			/>
	    			</div>	
	   			</td>
		   	</tr>
		   	</c:if>
		   			   	
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan=3>
	   			<ui:textarea id="taskDesc" name="bean.taskDesc" value="${bean.taskDesc}" width="800" height="200" skin="${contextStyleTheme}"/> 																				
	   			</td>
		   		</tr>
		   		<tr>	
		   		  <td  colspan="4"  align="center">
		   		  <c:if test="${bean.taskId>0}">
		   		  	<ui:button text="%{getText('eaap.op2.conf.prov.update')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="updateTask();"></ui:button>
		   		  </c:if>
		   		  <c:if test="${bean.taskId == null || bean.taskId == 0}">
		   		  	<ui:button text="%{getText('eaap.op2.conf.prov.add')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="updateTask();"></ui:button>
		   		  </c:if>   					  
						  <ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="returnPage();"></ui:button>   				       
    				</td>
		   		</tr>
		    </table>
	</div>
</ui:form>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>