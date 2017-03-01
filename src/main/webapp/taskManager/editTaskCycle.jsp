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
	
    <style type="text/css">
        .line
        {
            height: 22px;
            line-height: 22px;
            margin: 3px;
        }
        .imp
        {
            padding-left: 25px;
        }
        
       .tabs-wrap ul.tabs{width:100% !important;overflow:hidden}
       #tt div.tabs-panels{width:800px !important}
    </style>
    
	<script>		
	function updateTask(){		
			var form = document.getElementById("taskCycleForm");	
		  	if(comm_validators_check('group1'))
	       	{
	       		form.submit();				
	       	}	
		}
	
	function generate() {
       
            var expStr = "";
            var expDesc = "";
            
            var secondObj = document.getElementsByName("second");
            var secondLength = secondObj.length;
            var secondStr = "";
            var secondDesc = "";
            for (i=0;i<secondLength;i++) {
                if (secondObj[i].checked) {
                	if (i == 0) {
                	  secondStr = "*";
                	}
                	if (i == 1) {
                	  secondStr = document.getElementById("secondStart_0").value + "-" + document.getElementById("secondEnd_0").value;
                	  secondDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	             + secondStr
                	             + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />";
                	}
                	if (i == 2) {
                	  secondStr = document.getElementById("secondStart_1").value + "/" + document.getElementById("secondEnd_1").value;
                	  secondDesc = "<s:property value="%{getText('eaap.op2.conf.task.from')}" /> " 
                	             + " " + document.getElementById("secondStart_1").value
                	             + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" /> "  
                	             + "<s:property value="%{getText('eaap.op2.conf.task.toStart')}" /> "
                	             + document.getElementById("secondEnd_1").value
                	             + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />";
                	}
                	if (i == 3) {
                	  var str=document.getElementsByName("secondBox");
			          var objarray=str.length;
					  var chestr="";
					  for (i=0;i<objarray;i++)
						{ 
						  if(str[i].checked == true)
						  {
						    secondStr+=str[i].value+",";
						  }
						}
					  if (secondStr.length > 0) {
					  	secondStr = secondStr.substr(0,secondStr.length-1);
					  	secondDesc = secondStr + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />";
					  } else {
					    secondStr = "*";
					  } 
                	}
                }
            }
            
            var minObj = document.getElementsByName("min");
            var minLength = minObj.length;
            var minStr = "";
            var minDesc = "";
            for (i=0;i<minLength;i++) {
                if (minObj[i].checked) {
                	if (i == 0) {
                	  minStr = "*";
                	}
                	if (i == 1) {
                	  minStr = document.getElementById("minStart_0").value + "-" + document.getElementById("minEnd_0").value;
                	  minDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	          + minStr
                	          + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />";
                	}
                	if (i == 2) {
                	  minStr = document.getElementById("minStart_1").value + "/" + document.getElementById("minEnd_1").value;
                	  minDesc = "<s:property value="%{getText('eaap.op2.conf.task.from')}" /> " 
                	          + " " + document.getElementById("minStart_1").value
                	          + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" /> "  
                	          + "<s:property value="%{getText('eaap.op2.conf.task.toStart')}" /> "
                	          + document.getElementById("minEnd_1").value
                	          + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />";
                	}
                	if (i == 3) {
                	  var str=document.getElementsByName("minBox");
			          var objarray=str.length;
					  var chestr="";
					  for (i=0;i<objarray;i++)
						{ 
						  if(str[i].checked == true)
						  {
						    minStr+=str[i].value+",";
						  }
						}
					  if (minStr.length > 0) {
					  	minStr = minStr.substr(0,minStr.length-1);
					  	minDesc = minStr + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />";
					  } else {
					    minStr = "*";
					  } 
                	}
                }
            }
            
            var hourObj = document.getElementsByName("hour");
            var hourLength = hourObj.length;
            var hourStr = "";
            var hourDesc = "";
            for (i=0;i<hourLength;i++) {
                if (hourObj[i].checked) {
                	if (i == 0) {
                	  hourStr = "*";
                	}
                	if (i == 1) {
                	  hourStr = document.getElementById("hourStart_0").value + "-" + document.getElementById("hourEnd_0").value;
                	  hourDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	           + hourStr
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" />";
                	}
                	if (i == 2) {
                	  hourStr = document.getElementById("hourStart_1").value + "/" + document.getElementById("hourEnd_1").value;
                	  hourDesc = "<s:property value="%{getText('eaap.op2.conf.task.from')}" /> " 
                	           + " " + document.getElementById("hourStart_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" /> "  
                	           + "<s:property value="%{getText('eaap.op2.conf.task.toStart')}" /> "
                	           + document.getElementById("hourEnd_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" />";
                	}
                	if (i == 3) {
                	  var str=document.getElementsByName("hourBox");
			          var objarray=str.length;
					  var chestr="";
					  for (i=0;i<objarray;i++)
						{ 
						  if(str[i].checked == true)
						  {
						    hourStr+=str[i].value+",";
						  }
						}
					  if (hourStr.length > 0) {
					  	hourStr = hourStr.substr(0,hourStr.length-1);
					  	hourDesc = hourStr + " <s:property value="%{getText('eaap.op2.conf.task.clock')}" />";
					  } else {
					    hourStr = "*";
					  } 
                	}
                }
            }
            
            var dayObj = document.getElementsByName("day");
            var dayLength = dayObj.length;
            var dayStr = "";
            var dayDesc = "";
            for (i=0;i<dayLength;i++) {
                if (dayObj[i].checked) {
                	if (i == 0) {
                	  dayStr = "*";
                	}
                	if (i == 1) {
                	  dayStr = "?";
                	}
                	if (i == 2) {
                	  dayStr = document.getElementById("dayStart_0").value + "-" + document.getElementById("dayEnd_0").value;
                	  dayDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	           + dayStr
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />";
                	}
                	if (i == 3) {
                	  dayStr = document.getElementById("dayStart_1").value + "/" + document.getElementById("dayEnd_1").value;
                	  dayDesc = "<s:property value="%{getText('eaap.op2.conf.task.from')}" /> " 
                	           + " " + document.getElementById("dayStart_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" /> "  
                	           + "<s:property value="%{getText('eaap.op2.conf.task.toStart')}" /> "
                	           + document.getElementById("dayEnd_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />";
                	}
                	if (i == 4) {
                	  dayStr = document.getElementById("dayStart_2").value + "W";
                	  dayDesc = "<s:property value="%{getText('eaap.op2.conf.task.perMonth')}" /> "
                	          + document.getElementById("dayStart_2").value
                	          + " <s:property value="%{getText('eaap.op2.conf.task.recentWorkday')}" /> "
                	}
                	if (i == 5) {
                	  dayStr = "L";
                	  dayDesc = "<s:property value="%{getText('eaap.op2.conf.task.lastMonthDay')}" />";
                	}
                	if (i == 6) {
                	  var str=document.getElementsByName("dayBox");
			          var objarray=str.length;
					  var chestr="";
					  for (i=0;i<objarray;i++)
						{ 
						  if(str[i].checked == true)
						  {
						    dayStr+=str[i].value+",";
						  }
						}
					  if (dayStr.length > 0) {
					  	dayStr = dayStr.substr(0,dayStr.length-1);
					  	dayDesc = dayStr + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />";
					  } else {
					    dayStr = "?";
					  } 
                	}
                }
            }
            
            var monthObj = document.getElementsByName("month");
            var monthLength = monthObj.length;
            var monthStr = "";
            var monthDesc = "";
            for (i=0;i<monthLength;i++) {
                if (monthObj[i].checked) {
                	if (i == 0) {
                	  monthStr = "*";
                	}
                	if (i == 1) {
                	  monthStr = "?";
                	}
                	if (i == 2) {
                	  monthStr = document.getElementById("monthStart_0").value + "-" + document.getElementById("monthEnd_0").value;
                	  monthDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	           + monthStr
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMonth')}" />";
                	}
                	if (i == 3) {
                	  monthStr = document.getElementById("monthStart_1").value + "/" + document.getElementById("monthEnd_1").value;
                	  monthDesc = "<s:property value="%{getText('eaap.op2.conf.task.from')}" /> " 
                	           + " " + document.getElementById("monthStart_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMonth')}" /> "  
                	           + "<s:property value="%{getText('eaap.op2.conf.task.toStart')}" /> "
                	           + document.getElementById("monthEnd_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMonth')}" />";
                	}
                	if (i == 4) {
                	  var str=document.getElementsByName("monthBox");
			          var objarray=str.length;
					  var chestr="";
					  for (i=0;i<objarray;i++)
						{ 
						  if(str[i].checked == true)
						  {
						    monthStr+=str[i].value+",";
						  }
						}
					  if (monthStr.length > 0) {
					  	monthStr = monthStr.substr(0,monthStr.length-1);
					  	monthDesc = monthStr + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleMonth')}" />";
					  } else {
					    monthStr = "?";
					  } 
                	}
                }
            }
            
            var weekObj = document.getElementsByName("week");
            var weekLength = weekObj.length;
            var weekStr = "";
            var weekDesc = "";
            for (i=0;i<weekLength;i++) {
                if (weekObj[i].checked) {
                	if (i == 0) {
                	  weekStr = "*";
                	}
                	if (i == 1) {
                	  weekStr = "?";
                	}
                	if (i == 2) {
                	  weekStr = document.getElementById("weekStart_0").value + "-" + document.getElementById("weekEnd_0").value;
                	  weekDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	           + weekStr;
                	}
                	if (i == 3) {
                	  weekStr = document.getElementById("weekStart_1").value + "#" + document.getElementById("weekEnd_1").value;
                	  weekDesc = document.getElementById("weekStart_1").value
                	           + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleWeek')}" /> "  
                	           + document.getElementById("weekEnd_1").value;
                	}
                	if (i == 4) {
                	  weekStr = document.getElementById("weekStart_2").value + "L";
                	  weekDesc = "<s:property value="%{getText('eaap.op2.conf.task.lastMonthDay')}" /> " + document.getElementById("weekStart_2").value;
                	}
                	if (i == 5) {
                	  var str=document.getElementsByName("weekBox");
			          var objarray=str.length;
					  var chestr="";
					  for (i=0;i<objarray;i++)
						{ 
						  if(str[i].checked == true)
						  {
						    weekStr+=str[i].value+",";
						  }
						}
					  if (weekStr.length > 0) {
					  	weekStr = weekStr.substr(0,weekStr.length-1);
					  	weekDesc = weekStr + " <s:property value="%{getText('eaap.op2.conf.task.taskCycleWeek')}" />";
					  } else {
					    weekStr = "?";
					  } 
                	}
                }
            }
            
            var yearObj = document.getElementsByName("year");
            var yearLength = yearObj.length;
            var yearStr = "";
            var yearDesc = "";
            for (i=0;i<yearLength;i++) {
                if (yearObj[i].checked) {
                	if (i == 0) {
                	  yearStr = "";
                	}
                	if (i == 1) {
                	  yearStr = "*";
                	}
                	if (i == 2) {
                	  yearStr = document.getElementById("yearStart_0").value + "-" + document.getElementById("yearEnd_0").value;
                	  yearDesc = "<s:property value="%{getText('eaap.op2.conf.task.cycle')}" /> <s:property value="%{getText('eaap.op2.conf.task.from')}" />"
                	           + yearStr;
                	}
                }
            }
            
            expStr = secondStr + " " + minStr + " " + hourStr + " " + dayStr + " " + monthStr + " " + weekStr + " " + yearStr;
			document.getElementById('gcSEExp').value = expStr.trim();
			expDesc = yearDesc + " " + weekDesc + " " + monthDesc + " " + dayDesc + " " + hourDesc + " " + minDesc + " " + secondDesc
			        + " " + "<s:property value="%{getText('eaap.op2.conf.task.tigger')}" />";
			document.getElementById('gcDesc').value = expDesc.trim();
       }
       
       function secondChange_2(){
       		document.getElementById("second_1").checked = "";
       		document.getElementById("second_2").checked = "checked";
       		document.getElementById("second_3").checked = "";
       		document.getElementById("sencond_appoint").checked = "";
       }
       function secondChange_3(){
       		document.getElementById("second_1").checked = "";
       		document.getElementById("second_2").checked = "";
       		document.getElementById("second_3").checked = "checked";
       		document.getElementById("sencond_appoint").checked = "";
       }
       function secondChange_4(){
       		document.getElementById("second_1").checked = "";
       		document.getElementById("second_2").checked = "";
       		document.getElementById("second_3").checked = "";
       		document.getElementById("sencond_appoint").checked = "checked";
       }
       
       function minChange_2(){
       		document.getElementById("min_1").checked = "";
       		document.getElementById("min_2").checked = "checked";
       		document.getElementById("min_3").checked = "";
       		document.getElementById("min_appoint").checked = "";
       }
       function minChange_3(){
       		document.getElementById("min_1").checked = "";
       		document.getElementById("min_2").checked = "";
       		document.getElementById("min_3").checked = "checked";
       		document.getElementById("min_appoint").checked = "";
       }
       function minChange_4(){
       		document.getElementById("min_1").checked = "";
       		document.getElementById("min_2").checked = "";
       		document.getElementById("min_3").checked = "";
       		document.getElementById("min_appoint").checked = "checked";
       }
       
       function hourChange_2(){
       		document.getElementById("hour_1").checked = "";
       		document.getElementById("hour_2").checked = "checked";
       		document.getElementById("hour_3").checked = "";
       		document.getElementById("hour_appoint").checked = "";
       }
       function hourChange_3(){
       		document.getElementById("hour_1").checked = "";
       		document.getElementById("hour_2").checked = "";
       		document.getElementById("hour_3").checked = "checked";
       		document.getElementById("hour_appoint").checked = "";
       }
       function hourChange_4(){
       		document.getElementById("hour_1").checked = "";
       		document.getElementById("hour_2").checked = "";
       		document.getElementById("hour_3").checked = "";
       		document.getElementById("hour_appoint").checked = "checked";
       }
       
       function dayChange_3(){
       		document.getElementById("day_1").checked = "";
       		document.getElementById("day_2").checked = "";
       		document.getElementById("day_3").checked = "checked";
       		document.getElementById("day_4").checked = "";
       		document.getElementById("day_5").checked = "";
       		document.getElementById("day_6").checked = "";
       		document.getElementById("day_appoint").checked = "";
       }
       function dayChange_4(){
       		document.getElementById("day_1").checked = "";
       		document.getElementById("day_2").checked = "";
       		document.getElementById("day_3").checked = "";
       		document.getElementById("day_4").checked = "checked";
       		document.getElementById("day_5").checked = "";
       		document.getElementById("day_6").checked = "";
       		document.getElementById("day_appoint").checked = "";
       }
       function dayChange_5(){
       		document.getElementById("day_1").checked = "";
       		document.getElementById("day_2").checked = "";
       		document.getElementById("day_3").checked = "";
       		document.getElementById("day_4").checked = "";
       		document.getElementById("day_5").checked = "checked";
       		document.getElementById("day_6").checked = "";
       		document.getElementById("day_appoint").checked = "";
       }
       function dayChange_7(){
       		document.getElementById("day_1").checked = "";
       		document.getElementById("day_2").checked = "";
       		document.getElementById("day_3").checked = "";
       		document.getElementById("day_4").checked = "";
       		document.getElementById("day_5").checked = "";
       		document.getElementById("day_6").checked = "";
       		document.getElementById("day_appoint").checked = "checked";
       }
       
       function monthChange_3(){
       		document.getElementById("month_1").checked = "";
       		document.getElementById("month_2").checked = "";
       		document.getElementById("month_3").checked = "checked";
       		document.getElementById("month_4").checked = "";
       		document.getElementById("month_appoint").checked = "";
       }
       function monthChange_4(){
       		document.getElementById("month_1").checked = "";
       		document.getElementById("month_2").checked = "";
       		document.getElementById("month_3").checked = "";
       		document.getElementById("month_4").checked = "checked";
       		document.getElementById("month_appoint").checked = "";
       }
       function monthChange_5(){
       		document.getElementById("month_1").checked = "";
       		document.getElementById("month_2").checked = "";
       		document.getElementById("month_3").checked = "";
       		document.getElementById("month_4").checked = "";
       		document.getElementById("month_appoint").checked = "checked";
       }
       
      function weekChange_3(){
       		document.getElementById("week_1").checked = "";
       		document.getElementById("week_2").checked = "";
       		document.getElementById("week_3").checked = "checked";
       		document.getElementById("week_4").checked = "";
       		document.getElementById("week_5").checked = "";
       		document.getElementById("week_appoint").checked = "";
       }
       function weekChange_4(){
       		document.getElementById("week_1").checked = "";
       		document.getElementById("week_2").checked = "";
       		document.getElementById("week_3").checked = "";
       		document.getElementById("week_4").checked = "checked";
       		document.getElementById("week_5").checked = "";
       		document.getElementById("week_appoint").checked = "";
       }
       function weekChange_5(){
       		document.getElementById("week_1").checked = "";
       		document.getElementById("week_2").checked = "";
       		document.getElementById("week_3").checked = "";
       		document.getElementById("week_4").checked = "";
       		document.getElementById("week_5").checked = "checked";
       		document.getElementById("week_appoint").checked = "";
       }
       function weekChange_6(){
       		document.getElementById("week_1").checked = "";
       		document.getElementById("week_2").checked = "";
       		document.getElementById("week_3").checked = "";
       		document.getElementById("week_4").checked = "";
       		document.getElementById("week_5").checked = "";
       		document.getElementById("week_appoint").checked = "checked";
       }
       
       function yearChange_3(){
       		document.getElementById("year_1").checked = "";
       		document.getElementById("year_2").checked = "";
       		document.getElementById("year_3").checked = "checked";
       }
	</script>
</head>
<!--body start -->
<body >
<div class="contentWarp">
	  	<div class="module-path">	
	  		<div class="module-path-content">
		      <img src="${contextPath}/resource/blue/images/edit.png" />   
		      		<s:property value="%{getText('eaap.op2.conf.task.taskCycle')}" />
		      <img src="${contextPath}/resource/blue/images/module-path.png" />
		      <c:if test="${gatherCycleBean.gcCd>0}">
		     	    <s:property value="%{getText('eaap.op2.conf.task.updateTaskCycle')}" />
		   	  </c:if>
		   	  <c:if test="${gatherCycleBean.gcCd == null || gatherCycleBean.gcCd == 0}">
					<s:property value="%{getText('eaap.op2.conf.task.addTaskCycle')}" />		   		  
			  </c:if>		      		
	      	</div>
	    </div> 
<ui:form method="post" id="taskCycleForm" action="editTaskCycle.shtml">	
<ui:validators validateAlert="word" validatorGroup="group1"> 
<ui:validator fieldId="gcDesc" validatorType="stringlength" minLength="0" maxLength="249" message="%{getText('eaap.op2.conf.prov.notexceed249char')}"/>	
<ui:validator fieldId="gcSEExp" validatorType="ajax" ajaxMethods="eaap-op2-conf-task-action-taskCycleAction.verifyCron(gcSEExp)"  message="%{getText('eaap.op2.conf.task.gcExpError')}"></ui:validator>	
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
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.taskCycleName')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="gatherCycleBean.name" id="taskCycleName" value="${gatherCycleBean.name}" skin="${contextStyleTheme}"/>
	  				<input type="hidden" name="gatherCycleBean.gcCd" id="gcCd" value="${gatherCycleBean.gcCd}"/>
	  				<input id="taskCycleFlag" name="taskCycleFlag" type="hidden" value="${taskCycleFlag}" />
	   			</td>
		   	</tr>	
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.expression')}" />&nbsp;<s:property value="%{getText('eaap.op2.conf.task.generate')}" />:</td>
	   			<td width="40%">
	   			    <ui:tabpage id="tt"  height="250px" width="500px" loadMode="ajax" skin="${contextStyleTheme}">
				       <ui:tabpagediv id="tab_second" title="Second">
				            <div class="line">
                            	<input type="radio" checked="checked" name="second" id="second_1">
                             	<s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />&nbsp;
                             	<s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * /]
                            </div>
                            
                            <div class="line">
	                            <input type="radio" name="second" id="second_2">
	                            <s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
                                <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:58" value="1" id="secondStart_0" onclick="secondChange_2();">
                            	-
                            	<input class="easyui-numberspinner" style="width: 60px;" data-options="min:2,max:59" value="2" id="secondEnd_0" onclick="secondChange_2();">
                            	<s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />
                            </div>
                            
                            <div class="line">
	                            <input type="radio" name="second" id="second_3">
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />&nbsp;
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:0,max:59" value="0"  onclick="secondChange_3();"
	                                id="secondStart_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.toStart')}" />,
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:59" value="1"  onclick="secondChange_3();"
	                                id="secondEnd_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.performedOnce')}" />   
                            </div>
                            
                            <div class="line">
	                            <input type="radio" name="second" id="sencond_appoint">
	                         	<s:property value="%{getText('eaap.op2.conf.task.specified')}" />    
	                        </div>
	                        
                            <div class="imp secondList" onclick="secondChange_4();">
	                            <input type="checkbox" name="secondBox" value="1">01
	                            <input type="checkbox" name="secondBox" value="2">02
	                            <input type="checkbox" name="secondBox" value="3">03
	                            <input type="checkbox" name="secondBox" value="4">04
	                            <input type="checkbox" name="secondBox" value="5">05
	                            <input type="checkbox" name="secondBox" value="6">06
	                            <input type="checkbox" name="secondBox" value="7">07
	                            <input type="checkbox" name="secondBox" value="8">08
	                            <input type="checkbox" name="secondBox" value="9">09
	                            <input type="checkbox" name="secondBox" value="10">10
	                        </div>
                            <div class="imp secondList" onclick="secondChange_4();">
	                            <input type="checkbox" name="secondBox" value="11">11
	                            <input type="checkbox" name="secondBox" value="12">12
	                            <input type="checkbox" name="secondBox" value="13">13
	                            <input type="checkbox" name="secondBox" value="14">14
	                            <input type="checkbox" name="secondBox" value="15">15
	                            <input type="checkbox" name="secondBox" value="16">16
	                            <input type="checkbox" name="secondBox" value="17">17
	                            <input type="checkbox" name="secondBox" value="18">18
	                            <input type="checkbox" name="secondBox" value="19">19
	                            <input type="checkbox" name="secondBox" value="20">20
                            </div>
                            <div class="imp secondList" onclick="secondChange_4();">
	                            <input type="checkbox" name="secondBox" value="21">21
	                            <input type="checkbox" name="secondBox" value="22">22
	                            <input type="checkbox" name="secondBox" value="23">23
	                            <input type="checkbox" name="secondBox" value="24">24
	                            <input type="checkbox" name="secondBox" value="25">25
	                            <input type="checkbox" name="secondBox" value="26">26
	                            <input type="checkbox" name="secondBox" value="27">27
	                            <input type="checkbox" name="secondBox" value="28">28
	                            <input type="checkbox" name="secondBox" value="29">29
	                            <input type="checkbox" name="secondBox" value="30">30
                            </div>
                            <div class="imp secondList" onclick="secondChange_4();">
	                            <input type="checkbox" name="secondBox" value="31">31
	                            <input type="checkbox" name="secondBox" value="32">32
	                            <input type="checkbox" name="secondBox" value="33">33
	                            <input type="checkbox" name="secondBox" value="34">34
	                            <input type="checkbox" name="secondBox" value="35">35
	                            <input type="checkbox" name="secondBox" value="36">36
	                            <input type="checkbox" name="secondBox" value="37">37
	                            <input type="checkbox" name="secondBox" value="38">38
	                            <input type="checkbox" name="secondBox" value="39">39
	                            <input type="checkbox" name="secondBox" value="40">40
                            </div>
	                        <div class="imp secondList" onclick="secondChange_4();">
	                            <input type="checkbox" name="secondBox" value="41">41
	                            <input type="checkbox" name="secondBox" value="42">42
	                            <input type="checkbox" name="secondBox" value="43">43
	                            <input type="checkbox" name="secondBox" value="44">44
	                            <input type="checkbox" name="secondBox" value="45">45
	                            <input type="checkbox" name="secondBox" value="46">46
	                            <input type="checkbox" name="secondBox" value="47">47
	                            <input type="checkbox" name="secondBox" value="48">48
	                            <input type="checkbox" name="secondBox" value="49">49
	                            <input type="checkbox" name="secondBox" value="50">50
	                        </div>
	                        <div class="imp secondList" onclick="secondChange_4();">
	                            <input type="checkbox" name="secondBox" value="51">51
	                            <input type="checkbox" name="secondBox" value="52">52
	                            <input type="checkbox" name="secondBox" value="53">53
	                            <input type="checkbox" name="secondBox" value="54">54
	                            <input type="checkbox" name="secondBox" value="55">55
	                            <input type="checkbox" name="secondBox" value="56">56
	                            <input type="checkbox" name="secondBox" value="57">57
	                            <input type="checkbox" name="secondBox" value="58">58
	                            <input type="checkbox" name="secondBox" value="59">59
	                        </div>
				       </ui:tabpagediv>
				       
				       <ui:tabpagediv id="tab_minute" title="Minute">
				     	    <div class="line">
	                            <input type="radio" checked="checked" name="min" id="min_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * /]
                            </div>
                            
                        	<div class="line">
                            	<input type="radio" name="min" id="min_2">
                             	<s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:58" value="1" onclick="minChange_2();"
	                                id="minStart_0">
	                            -
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:2,max:59" value="2" onclick="minChange_2();"
	                                id="minEnd_0">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />
                             </div>
                             
	                         <div class="line">
	                            <input type="radio" name="min" id="min_3">
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:0,max:59" value="0" onclick="minChange_3();"
	                                id="minStart_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.toStart')}" />,
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:59" value="1" onclick="minChange_3();"
	                                id="minEnd_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleMinute')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.performedOnce')}" /> 
                             </div>
                             
	                         <div class="line">
	                             <input type="radio" name="min" id="min_appoint">
	                             <s:property value="%{getText('eaap.op2.conf.task.specified')}" />
	                         </div>
	                        <div class="imp minList" onclick="minChange_4();">
	                            <input type="checkbox" name="minBox" value="1">01
	                            <input type="checkbox" name="minBox" value="2">02
	                            <input type="checkbox" name="minBox" value="3">03
	                            <input type="checkbox" name="minBox" value="4">04
	                            <input type="checkbox" name="minBox" value="5">05
	                            <input type="checkbox" name="minBox" value="6">06
	                            <input type="checkbox" name="minBox" value="7">07
	                            <input type="checkbox" name="minBox" value="8">08
	                            <input type="checkbox" name="minBox" value="9">09
	                            <input type="checkbox" name="minBox" value="10">10
	                        </div>
	                        <div class="imp minList" onclick="minChange_4();">
	                            <input type="checkbox" name="minBox" value="11">11
	                            <input type="checkbox" name="minBox" value="12">12
	                            <input type="checkbox" name="minBox" value="13">13
	                            <input type="checkbox" name="minBox" value="14">14
	                            <input type="checkbox" name="minBox" value="15">15
	                            <input type="checkbox" name="minBox" value="16">16
	                            <input type="checkbox" name="minBox" value="17">17
	                            <input type="checkbox" name="minBox" value="18">18
	                            <input type="checkbox" name="minBox" value="19">19
	                            <input type="checkbox" name="minBox" value="20">20
	                        </div>
	                        <div class="imp minList" onclick="minChange_4();">
	                            <input type="checkbox" name="minBox" value="21">21
	                            <input type="checkbox" name="minBox" value="22">22
	                            <input type="checkbox" name="minBox" value="23">23
	                            <input type="checkbox" name="minBox" value="24">24
	                            <input type="checkbox" name="minBox" value="25">25
	                            <input type="checkbox" name="minBox" value="26">26
	                            <input type="checkbox" name="minBox" value="27">27
	                            <input type="checkbox" name="minBox" value="28">28
	                            <input type="checkbox" name="minBox" value="29">29
	                            <input type="checkbox" name="minBox" value="30">30
	                        </div>
	                        <div class="imp minList" onclick="minChange_4();">
	                            <input type="checkbox" name="minBox" value="31">31
	                            <input type="checkbox" name="minBox" value="32">32
	                            <input type="checkbox" name="minBox" value="33">33
	                            <input type="checkbox" name="minBox" value="34">34
	                            <input type="checkbox" name="minBox" value="35">35
	                            <input type="checkbox" name="minBox" value="36">36
	                            <input type="checkbox" name="minBox" value="37">37
	                            <input type="checkbox" name="minBox" value="38">38
	                            <input type="checkbox" name="minBox" value="39">39
	                            <input type="checkbox" name="minBox" value="40">40
	                        </div>
	                        <div class="imp minList" onclick="minChange_4();">
	                            <input type="checkbox" name="minBox" value="41">41
	                            <input type="checkbox" name="minBox" value="42">42
	                            <input type="checkbox" name="minBox" value="43">43
	                            <input type="checkbox" name="minBox" value="44">44
	                            <input type="checkbox" name="minBox" value="45">45
	                            <input type="checkbox" name="minBox" value="46">46
	                            <input type="checkbox" name="minBox" value="47">47
	                            <input type="checkbox" name="minBox" value="48">48
	                            <input type="checkbox" name="minBox" value="49">49
	                            <input type="checkbox" name="minBox" value="50">50
	                        </div>
	                        <div class="imp minList" onclick="minChange_4();">
	                            <input type="checkbox" name="minBox" value="51">51
	                            <input type="checkbox" name="minBox" value="52">52
	                            <input type="checkbox" name="minBox" value="53">53
	                            <input type="checkbox" name="minBox" value="54">54
	                            <input type="checkbox" name="minBox" value="55">55
	                            <input type="checkbox" name="minBox" value="56">56
	                            <input type="checkbox" name="minBox" value="57">57
	                            <input type="checkbox" name="minBox" value="58">58
	                            <input type="checkbox" name="minBox" value="59">59
	                        </div>
				       </ui:tabpagediv>
				       
				       <ui:tabpagediv id="tab_hour" title="Hour">
				     	 	<div class="line">
                            	<input type="radio" checked="checked" name="hour" id="hour_1">
                                <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" />&nbsp;
                                <s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * /]</div>
                       	 	<div class="line">
	                            <input type="radio" name="hour" id="hour_2">
	                            <s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:0,max:23" value="0" onclick="hourChange_2();"
	                                id="hourStart_0">
	                            -
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:2,max:23" value="2" onclick="hourChange_2();"
	                                id="hourEnd_0">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" />
                             </div>
                             
	                         <div class="line">
	                            <input type="radio" name="hour" id="hour_3">
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />&nbsp;
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:0,max:23" value="0" onclick="hourChange_3();"
	                                id="hourStart_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.toStart')}" />,
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:23" value="1" onclick="hourChange_3();"
	                                id="hourEnd_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleHour')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.performedOnce')}" />
                             </div>
                             
	                         <div class="line">
	                            <input type="radio" name="hour" id="hour_appoint">
	                            <s:property value="%{getText('eaap.op2.conf.task.specified')}" />
                             </div>
	                         <div class="imp hourList" onclick="hourChange_4();">
	                            AM:
	                            <input type="checkbox" name="hourBox" value="0">00
	                            <input type="checkbox" name="hourBox" value="1">01
	                            <input type="checkbox" name="hourBox" value="2">02
	                            <input type="checkbox" name="hourBox" value="3">03
	                            <input type="checkbox" name="hourBox" value="4">04
	                            <input type="checkbox" name="hourBox" value="5">05
	                            <input type="checkbox" name="hourBox" value="6">06
	                            <input type="checkbox" name="hourBox" value="7">07
	                            <input type="checkbox" name="hourBox" value="8">08
	                            <input type="checkbox" name="hourBox" value="9">09
	                            <input type="checkbox" name="hourBox" value="10">10
	                            <input type="checkbox" name="hourBox" value="11">11
	                         </div>
	                         <div class="imp hourList" onclick="hourChange_4();">
	                            PM:
	                            <input type="checkbox" name="hourBox" value="12">12
	                            <input type="checkbox" name="hourBox" value="13">13
	                            <input type="checkbox" name="hourBox" value="14">14
	                            <input type="checkbox" name="hourBox" value="15">15
	                            <input type="checkbox" name="hourBox" value="16">16
	                            <input type="checkbox" name="hourBox" value="17">17
	                            <input type="checkbox" name="hourBox" value="18">18
	                            <input type="checkbox" name="hourBox" value="19">19
	                            <input type="checkbox" name="hourBox" value="20">20
	                            <input type="checkbox" name="hourBox" value="21">21
	                            <input type="checkbox" name="hourBox" value="22">22
	                            <input type="checkbox" name="hourBox" value="23">23
	                         </div>
	                         
				       </ui:tabpagediv>
				       
				       <ui:tabpagediv id="tab_day" title="Day">
	                        <div class="line">
	                            <input type="radio" checked="checked" name="day" id="day_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * / L W]
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="day" id="day_2">
	                            <s:property value="%{getText('eaap.op2.conf.task.notSpecified')}" />
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="day" id="day_3">
	                            <s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:31" value="1" onclick="dayChange_3();"
	                                id="dayStart_0">
	                            -
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:2,max:31" value="2" onclick="dayChange_3();"
	                                id="dayEnd_0">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="day" id="day_4">
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />&nbsp;
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:31" value="1" onclick="dayChange_4();"
	                                id="dayStart_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.toStart')}" />,
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:31" value="1" onclick="dayChange_4();"
	                                id="dayEnd_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.performedOnce')}" />
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="day" id="day_5">
	                            <s:property value="%{getText('eaap.op2.conf.task.perMonth')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:31" value="1" onclick="dayChange_5();"
	                                id="dayStart_2">
	                            <s:property value="%{getText('eaap.op2.conf.task.recentWorkday')}" />
                            </div>
                            
	                        <div class="line" >
	                            <input type="radio" name="day" id="day_6">
	                            <s:property value="%{getText('eaap.op2.conf.task.lastMonthDay')}" />
                            </div>
                            
                        	<div class="line">
                           	 	<input type="radio" name="day" id="day_appoint">
                           	 	<s:property value="%{getText('eaap.op2.conf.task.specified')}" />
                            </div>
                            
	                        <div class="imp dayList" onclick="dayChange_7();">
	                            <input type="checkbox" name="dayBox" value="1">1
	                            <input type="checkbox" name="dayBox" value="2">2
	                            <input type="checkbox" name="dayBox" value="3">3
	                            <input type="checkbox" name="dayBox" value="4">4
	                            <input type="checkbox" name="dayBox" value="5">5
	                            <input type="checkbox" name="dayBox" value="6">6
	                            <input type="checkbox" name="dayBox" value="7">7
	                            <input type="checkbox" name="dayBox" value="8">8
	                            <input type="checkbox" name="dayBox" value="9">9
	                            <input type="checkbox" name="dayBox" value="10">10
	                            <input type="checkbox" name="dayBox" value="11">11
	                            <input type="checkbox" name="dayBox" value="12">12
	                            <input type="checkbox" name="dayBox" value="13">13
	                            <input type="checkbox" name="dayBox" value="14">14
	                            <input type="checkbox" name="dayBox" value="15">15
	                            <input type="checkbox" name="dayBox" value="16">16
	                        </div>
	                        <div class="imp dayList" onclick="dayChange_7();">
	                            <input type="checkbox" name="dayBox" value="17">17
	                            <input type="checkbox" name="dayBox" value="18">18
	                            <input type="checkbox" name="dayBox" value="19">19
	                            <input type="checkbox" name="dayBox" value="20">20
	                            <input type="checkbox" name="dayBox" value="21">21
	                            <input type="checkbox" name="dayBox" value="22">22
	                            <input type="checkbox" name="dayBox" value="23">23
	                            <input type="checkbox" name="dayBox" value="24">24
	                            <input type="checkbox" name="dayBox" value="25">25
	                            <input type="checkbox" name="dayBox" value="26">26
	                            <input type="checkbox" name="dayBox" value="27">27
	                            <input type="checkbox" name="dayBox" value="28">28
	                            <input type="checkbox" name="dayBox" value="29">29
	                            <input type="checkbox" name="dayBox" value="30">30
	                            <input type="checkbox" name="dayBox" value="31">31
	                        </div>
                       
				    	</ui:tabpagediv>
				       
				        <ui:tabpagediv id="tab_month" title="Month">
				    
				    		<div class="line">
                            	<input type="radio" checked="checked" name="month" id="month_1">
                             	<s:property value="%{getText('eaap.op2.conf.task.taskCycleMonth')}" />&nbsp;
                             	<s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * /]
                            </div>
                            
                        	<div class="line">
                            	<input type="radio" name="month" id="month_2">
                            	<s:property value="%{getText('eaap.op2.conf.task.notSpecified')}" />
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="month" id="month_3">
	                            <s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:12" value="1" onclick="monthChange_3();"
	                                id="monthStart_0">
	                            -
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:2,max:12" value="2" onclick="monthChange_3();"
	                                id="monthEnd_0">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleMonth')}" />
                             </div>
                             
	                        <div class="line">
	                            <input type="radio" name="month" id="month_4">
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:12" value="1" onclick="monthChange_4();"
	                                id="monthStart_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleDay')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.toStart')}" />,
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:12" value="1" onclick="monthChange_4();"
	                                id="monthEnd_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.perMonth')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.performedOnce')}" />
                             </div>
                             
	                         <div class="line">
	                            <input type="radio" name="month" id="month_appoint">
	                            <s:property value="%{getText('eaap.op2.conf.task.specified')}" />
                             </div>
                             
	                         <div class="imp monthList" onclick="monthChange_5();">
	                            <input type="checkbox" name="monthBox" value="1">1
	                            <input type="checkbox" name="monthBox" value="2">2
	                            <input type="checkbox" name="monthBox" value="3">3
	                            <input type="checkbox" name="monthBox" value="4">4
	                            <input type="checkbox" name="monthBox" value="5">5
	                            <input type="checkbox" name="monthBox" value="6">6
	                            <input type="checkbox" name="monthBox" value="7">7
	                            <input type="checkbox" name="monthBox" value="8">8
	                            <input type="checkbox" name="monthBox" value="9">9
	                            <input type="checkbox" name="monthBox" value="10">10
	                            <input type="checkbox" name="monthBox" value="11">11
	                            <input type="checkbox" name="monthBox" value="12">12
	                        </div>
	                        
					    </ui:tabpagediv>
					    
					    <ui:tabpagediv id="tab_week" title="Week">
				    
				   			<div class="line">
                            	<input type="radio" name="week" id="week_1">
                                <s:property value="%{getText('eaap.op2.conf.task.taskCycleSecond')}" />&nbsp;
                                <s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * / L #]
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" checked="checked" name="week" id="week_2">
	                            <s:property value="%{getText('eaap.op2.conf.task.notSpecified')}" />
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="week" id="week_3">
	                            <s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />&nbsp;
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:7"  onclick="weekChange_3();"
	                                id="weekStart_0" value="1">
	                            -
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:2,max:7" value="2"  onclick="weekChange_3();"
	                                id="weekEnd_0">
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="week" id="week_4">
	                          	<input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:4" value="1" onclick="weekChange_4();"
	                                id="weekStart_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleWeek')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:7" onclick="weekChange_4();"
	                                id="weekEnd_1" value="1">
                            </div>
                            
	                        <div class="line">
	                            <input type="radio" name="week" id="week_5">
	                            <s:property value="%{getText('eaap.op2.conf.task.lastMonthDay')}" />
	                            <input class="easyui-numberspinner" style="width: 60px;" data-options="min:1,max:7" onclick="weekChange_5();"
	                                id="weekStart_2" value="1">
                            </div>
                             
	                        <div class="line">
	                            <input type="radio" name="week" id="week_appoint">
	                            <s:property value="%{getText('eaap.op2.conf.task.specified')}" />
                            </div>
                             
	                        <div class="imp weekList" onclick="weekChange_6();">
	                            <input type="checkbox" name="weekBox" value="1">1
	                            <input type="checkbox" name="weekBox" value="2">2
	                            <input type="checkbox" name="weekBox" value="3">3
	                            <input type="checkbox" name="weekBox" value="4">4
	                            <input type="checkbox" name="weekBox" value="5">5
	                            <input type="checkbox" name="weekBox" value="6">6
	                            <input type="checkbox" name="weekBox" value="7">7
	                        </div>
				    	</ui:tabpagediv>
				    
				    	<ui:tabpagediv id="tab_year" title="Year">
						    <div class="line">
	                            <input type="radio" checked="checked" name="year" id="year_1">
	                            <s:property value="%{getText('eaap.op2.conf.task.taskCycleYear')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.allowWildcard')}" />&nbsp;[, - * /]  
		                    </div>
		                     
	                        <div class="line">
	                            <input type="radio" name="year" id="year_2">
	                            <s:property value="%{getText('eaap.op2.conf.task.perYear')}" />
                            </div>
                            
                        	<div class="line">
	                            <input type="radio" name="year" id="year_3"> 
	                            <s:property value="%{getText('eaap.op2.conf.task.cycle')}" />&nbsp;
	                            <s:property value="%{getText('eaap.op2.conf.task.from')}" />
	                            <input class="easyui-numberspinner" style="width: 90px;" data-options="min:2013,max:3000" onclick="yearChange_3();"
	                                id="yearStart_0" value="2013">
	                            -
	                            <input class="easyui-numberspinner" style="width: 90px;" data-options="min:2014,max:3000" onclick="yearChange_3();"
	                                id="yearEnd_0" value="2014">
	                        </div>
				   	 </ui:tabpagediv>
				       
				    </ui:tabpage>
	   				<div style="float:left;">
		             	<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.task.generate')}" shape="s" onclick="generate();"></ui:button>
		            </div>
	   			</td>
		   	</tr>			  
		   	<tr>
	   			<td align="right" width="15%"><s:property value="%{getText('eaap.op2.conf.task.expression')}" />:</td>
	   			<td width="40%">
	   				<ui:inputText name="gatherCycleBean.gcSEExp" id="gcSEExp" value="${gatherCycleBean.gcSEExp}" skin="${contextStyleTheme}"/>
	   			</td>
		   	</tr>
		   	<tr>
	   			<td align="right" ><s:property value="%{getText('eaap.op2.conf.prov.descriptor')}" />:</td>
	   			<td colspan=3>
	   				<ui:textarea id="gcDesc" name="gatherCycleBean.gcDesc" value="${gatherCycleBean.gcDesc}" width="800" height="200" skin="${contextStyleTheme}"/> 																				
	   			</td>
		   	</tr>
		   		<tr>	
		   		  <td  colspan="4"  align="center">
		   		  <c:if test="${gatherCycleBean.gcCd>0}">
		   		  		<ui:button text="%{getText('eaap.op2.conf.prov.update')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="updateTask();"></ui:button>
		   		  </c:if>
		   		  <c:if test="${gatherCycleBean.gcCd == null || gatherCycleBean.gcCd == 0}">
		   		  		<ui:button text="%{getText('eaap.op2.conf.prov.add')}" skin="${contextStyleTheme}" id="checksubmitId" onclick="updateTask();"></ui:button>
		   		  </c:if>   					  
						<ui:button text="%{getText('eaap.op2.conf.prov.cancel')}" skin="${contextStyleTheme}" id="cancelId" onclick="history.go(-1);"></ui:button>   				       
    				</td>
		   		</tr>
		    </table>
	</div>
</ui:form>
</div>
</body> 
<%@ include file="/common/ssoCommon.jsp"%>
</html>