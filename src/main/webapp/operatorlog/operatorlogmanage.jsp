<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
</head>
<script type="text/javascript">
		var title = [];   
		   title[0]='<s:property value="%{getText('eaap.op2.conf.logaudit.username')}" />';
		   title[1]='<s:property value="%{getText('eaap.op2.conf.logaudit.operationDate')}" />';
		   title[2]='<s:property value="%{getText('eaap.op2.conf.logaudit.operatingcategory')}" />';
		   title[3]='<s:property value="%{getText('eaap.op2.conf.logaudit.operatingtable')}" />';
		   title[4]='<s:property value="%{getText('eaap.op2.conf.proof.Operation')}" />';
</script>
<body> 
<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	    <img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.logaudit.logaudit')}" />
	     	</div>
	    </div>
	   	<div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
<div id="queryBlock">    
<div class="formLayout" style="padding:5px 0; clear:both;">
	<form id="serviceSupplierRegister" method="post">
		<dl>
				<dt>
					<s:property value="%{getText('eaap.op2.conf.logaudit.username')}" />:
				</dt>
				<dd style="width:260px;">
				  	<ui:inputText  skin="${contextStyleTheme}" name="username" id="username"  textSize="25" style="float:left;"></ui:inputText>
				</dd>
		</dl>
	
       <dl>
        	<dt><s:property value="%{getText('eaap.op2.conf.logaudit.operatingcategory')}" />:</dt>
			<dd>
			  <ui:select skin="${contextStyleTheme}" name="optType" id="optType" list="optType" width="157"  emptyOption="true" headerValue=" "	 listKey="id" listValue="val"></ui:select>
	  	    </dd>
	  </dl>
	   <dl>
    	<dt><s:property value="%{getText('eaap.op2.conf.logaudit.operatingtable')}" />:</dt>
    		<dd >
    		<ui:inputText skin="${contextStyleTheme}"  id="optTable" name="optTable" style="float:left;"/>
			</dd>	
    	</dl>
    	<dl  style="width:450px">
   	    <dt><s:property value="%{getText('eaap.op2.conf.logaudit.operationDate')}" />:</dt>
    		<dd >
    		<ui:date id="startTime" name="startTime"  width="83px"  disabled="false"  dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
    		~
    		<ui:date id="endTime" name="endTime"  width="83px"  disabled="false"  dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
			</dd>
    	</dl>
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true"  id="table"  remoteSort="false" sortOrder="desc" onClickCell="false"
		fit="true" collapsible="true"   title="" striped="true" pageList="10" pagination="true" rownumbers="true"  method="eaap-op2-conf-operatorlog-OperatorlogAction.showOptLogGrid">
		<ui:gridEasyColumn width="100" index="0" title="0" field="USER_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="CREATE_DATE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="3" title="3" field="TABLE_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="OPT_TYPE" hidden="false" align="center" formatter="true" formatterMethod="fomat"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="0" index="5" title="5" field="LOG_ID" hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="4" title="4" field="operator" hidden="false" align="center" formatter="true" formatterMethod="fomatComm"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>
</div>
<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
</body>
 <script type="text/javascript" src="${contextPath}/resource/comm/js/jqueryui/jquery.autocomplete.js"></script>
 <link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/jquery.autocomplete.css" />
 <script type="text/javascript">  

		
    		$(function(){
    		   $('#btncut').remove();
    		   $('#btnadd').remove();
    		   $('#btnsave').remove();
    		   $('.datagrid-btn-separator').remove();
    		   
    		   changeTopScrollHeight();
    		});
       var checkout = "<s:property value="%{getText('eaap.op2.conf.proof.checkout')}" />";
           
		    
		  function searchFunc() {
	      var form = $("#serviceSupplierRegister").form();
          $('#table').datagrid("load", sy.serializeObject(form));
          }			 
          
          
    	   function fomat(value,row,index){
    		  if(value=='I'){
				   return "<s:property value="%{getText('eaap.op2.conf.logaudit.typeinsert')}" />"
			    }
			  if(value=='U'){
				   return "<s:property value="%{getText('eaap.op2.conf.logaudit.typeupdate')}" />"
				}    
			  if(value=='D'){
				   return "<s:property value="%{getText('eaap.op2.conf.logaudit.typedelete')}" />"
				} 
			  if(value=='Q'){
				   return "<s:property value="%{getText('eaap.op2.conf.logaudit.typequery')}" />"
				}  
    	   }
    	   
    	  function	fomatComm(value,row,index){
    		  return "<a href=\"javascript:showMessage("+row.LOG_ID+");\">"+checkout+"</a>";
    		  }
    	function showMessage(logId){
    		window.location.href="../operatorlog/detailOperatorLog.shtml?logId="+logId;
    	}
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
    </script>       
    <%@ include file="/common/ssoCommon.jsp"%>     	
</html>
