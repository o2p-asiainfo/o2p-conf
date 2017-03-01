<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/> 
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>

<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypesign')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypename')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypedesc')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestate')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
title[6]=' ';
</script>
<style>

</style>
</head>
<body>
<!--body start -->
<div class="contentWarp">
<c:if test="${isChoosePage != 'true'}">
  	<div class="module-path">
  		<div class="module-path-content">
	      <img src="${contextPath}/resource/blue/images/search.png" />
	     <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      <img src="${contextPath}/resource/blue/images/module-path.png" />
	      <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatemanger')}"/>
      </div>
    </div>
    <div class="accordion-header">
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.compregauditing.queryCondition')}"/>
         </div>
    </div>
</c:if>
<div id="queryBlock">
<div class="formLayout" style="padding:5px 0;">
<form name="myForm"   id="myForm"   method="post" > 
	<dl>	
		<dt>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypesign')}" />:
		</dt>	
		<dd >
		   <ui:inputText skin="${contextStyleTheme}"  name="mainDataType.mdtSign" value="${mainDataType.mdtSign}" ></ui:inputText>
		</dd>
	</dl>
	<dl>		
		<dt>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypename')}" />:
		</dt>
		<dd >
			<ui:inputText skin="${contextStyleTheme}"  name="mainDataType.mdtName" value="${mainDataType.mdtName}" ></ui:inputText>
		</dd>
	</dl>
	<dl>
		<dt>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestate')}" />:
		</dt>
		<dd >
		    <ui:multiSelectBox name="mainDataType.state" id="selectStateId" skin="${contextStyleTheme}"
		    list="selectMainTypeStateList" listKey="mainTypeStateCode" listValue="mainTypeStateName">
		</ui:multiSelectBox>
		</dd>	
	</dl>  
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
			<c:if test="${reqRsp!=null}">
				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.prov.define')}" id="chooseCompId" onclick="javascript:chooseContractName()"></ui:button>	                                		  					   				
				<input type="hidden" name="reqRsp" id="reqRsp" value="${reqRsp}"/>
			</c:if>
			<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/> 
			<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
	</div>
</form>
</div>
<div style="clear:both;">  
	<ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"   id="mdtypelistid"  remoteSort="false" sortOrder="desc" 
		fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"  toolbar="true"  method="eaap-op2-conf-manager-ConfManagerAction.getMdTypeList">
		<ui:gridEasyColumn width="180" index="0" title="0" field="MDT_SIGN" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="1" title="1" field="MDT_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="280" index="2" title="2" field="MDT_DESC" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="3" title="3" field="STATE" hidden="false" formatter="true" formatterMethod="formatterForState"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="4" title="4" field="LASTEST_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="5" title="5" field="CREATE_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="50" index="6" title="6" field="MTID" hidden="false" formatter="true" formatterMethod="formatterForOp"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="7" title="7" field="MDT_CD" hidden="true"   align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
<c:if test="${isChoosePage == 'true'}">
	 <table class="mgr-table" id="confirm">
		  <tr>
		    <td  colspan="4"  align="center">
		       <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseMasterData();"></ui:button>
		       <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();art.dialog.opener.changeTopScrollHeight();"></ui:button>
			</td>	
	     </tr>
	  </table>
</c:if>
</div>
<input id="rowIndex" name="rowIndex" value="${rowIndex}" type="hidden">
<input id="reqRspFlag" name="reqRspFlag" value="${reqRspFlag}" type="hidden">
<ui:iframe  skin="${contextStyleTheme}"  iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" frameborder="10" />
</body>
<script>

$(document).ready(function() {
  $("#selectStateId").multiselect("widget").find(":checkbox").get(0).click();
});

function searchFunc() {
   $("#isInit").val("false");
   var form = $("#myForm").form();
   $('#mdtypelistid').datagrid("load", sy.serializeObject(form));
}	

   function deleteMethod(){ 					
	    if($('#mdtypelistid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
		   if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
				{
				 var tmpmdtypeid =  $('#mdtypelistid').datagrid('getSelections')[0].MDT_CD ;
				 if(checkOperation(tmpmdtypeid)){
					 window.location='${contextPath}/mgr/updateMainDataType.shtml?mainDataType.state=R&mainDataType.mdtCd='+tmpmdtypeid;
				 }else{
					 alert("<s:property value="%{getText('eaap.op2.conf.maindata.notdelete')}" />");
				 }
			 }
		 }
     }
    		
    function addMehtod(){
       window.location="${contextPath}/mgr/preAddMainDataType.shtml";
 	 } 
              
   function updateMethod(){
	     if($('#mdtypelistid').datagrid('getSelections')[0]==null)
		 {
		 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
		    var tmpmdtypeid =  $('#mdtypelistid').datagrid('getSelections')[0].MDT_CD ;
		    if(checkOperation(tmpmdtypeid)){
		    	window.location='${contextPath}/mgr/preAddMainDataType.shtml?editOrAdd=edit&mainDataType.mdtCd='+tmpmdtypeid;
		    }else{
		    	alert("<s:property value="%{getText('eaap.op2.conf.maindata.notupdate')}" />");
		    }
		 }
   }
   function checkOperation(mdt_cd){
	   var flag = false;
	   $.ajax({
	        type:"post",
	        async:false,
	        url:"../mgr/checkOperation.shtml",
	        dataType:"text",
	        data:{mdt_cd:mdt_cd},
	        success:function(msg){
	            if("ok" ==  msg){
	            	flag = true;
	            }
	        }
	    });
	   return flag;
   }
   
    function clickMethod(index,field,value)
     { 
    	
        if($('#mdtypelistid').datagrid('getSelections')[0]!=null)
		 { 
		    var tmpmdtypeid =  $('#mdtypelistid').datagrid('getSelections')[0].MDT_CD ;
		    window.location='${contextPath}/mgr/preAddMainDataType.shtml?editOrAdd=edit&mainDataType.mdtCd='+tmpmdtypeid;
			   
		 }
  }   	
  
     function formatterForState(value,row,index){
    if(value=='A'){
      return "<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateA')}" />"  ;
    }else if(value=='R'){
      return "<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateR')}" />"  ;
    } 
   }
   
   
   function formatterForOp(value,row,index)
   {
    return "<a href='${contextPath}/mgr/preAddMainDataByMtCd.shtml?showflag=detail&mainDataType.mdtCd="+value+"'><s:property value="%{getText('eaap.op2.conf.orgregauditing.xiangqing')}" /></a>" ;
   
   }
   function chooseContractName()
	{	
	 var vOpener=art.dialog.opener; 
	 	if($('#mdtypelistid').datagrid('getSelections')[0]==null||$('#mdtypelistid').datagrid('getSelections')[0].MDT_NAME==""){
		     	alert("<s:property value="%{getText('eaap.op2.conf.prov.pleaseSelectOneData')}" />");
		}
	    else{    									
		    var id = $('#mdtypelistid').datagrid('getSelections')[0].MDT_NAME;
		    var reqRsp = document.getElementById("reqRsp");
		    if(reqRsp.value == 'rsp'){	    
	    		var type = vOpener.document.getElementsByName('rspNevlConsType');	    
				var consValue = vOpener.document.getElementsByName('rspNevlConsValue');	    
		    	for( i = 0; i < type.length; i++) {
		         if(type[i].value == 3){
		           	if(consValue[i].value == ''){
		           		consValue[i].value=id;
		           		}	
		  	 		}
		  	 	}	
			}	    
		    else{
	    		var type = vOpener.document.getElementsByName('reqNevlConsType');	    
				var consValue = vOpener.document.getElementsByName('reqNevlConsValue');	    
		    	for( i = 0; i < type.length; i++) {
		         if(type[i].value == 3){
		           	if(consValue[i].value == ''){
		           		consValue[i].value=id;
		           		}	
		  	 		}
		  	 	}	
			}	    	    
		 }	 	
	    //This a Function is not This Page,view addContractManager_1.jsp and editContractManager_1.jsp   
		//parent.closeWin(); 	
		art.dialog.close() ; 					 
	}	 

	function chooseMasterData() {
	    var vOpener=art.dialog.opener;
	    var chooseNodeName	= $('#mdtypelistid').datagrid('getSelections')[0].MDT_NAME ;
	    var chooseNodeId			= $('#mdtypelistid').datagrid('getSelections')[0].MDT_CD ;
	    if(chooseNodeName=="") {
      		alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	     }else{
    	 	vOpener.setMasterData($('#rowIndex').val(),chooseNodeName,chooseNodeId,$('#reqRspFlag').val());
	 	 	art.dialog.close(); 
		 }
 	}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
