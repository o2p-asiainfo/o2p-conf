<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<title><s:property value="%{getText('contract version')}" /></title>
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
	title[0]='<s:property value="%{getText('contractAdapterID')}"/>';
	title[1]='<s:property value="%{getText('srcCtrFID')}" />';
	title[2]='<s:property value="%{getText('tarCtrFID')}" />';
	title[3]='<s:property value="%{getText('name')}" />';
	title[4]='<s:property value="%{getText('type')}" />';
	title[5]='<s:property value="%{getText('script')}" />';
	title[6]='<s:property value="%{getText('createDate')}" />';
	title[7]='<s:property value="%{getText('state')}" />';
	
	   //search Function
	function searchContract(){
		 var form = $("#showContractForm").form();
	     $('#contractList').datagrid("load", sy.serializeObject(form));		    			
	}

	function deleteMethod(){ 	
		 var rowData = $('#contractList').datagrid('getSelections')[0];
		  if(!rowData){
			  alert("no selected!!");
			  return;
		  }
		  $.ajax({
				type: "POST",
				async:true,
			    url: "${contextPath}/adapter/delContractAdapter.shtml",
			    dataType:'json',
			    data:{contractAdapterID:rowData.CONTRACT_ADAPTER_ID},
				success:function(msg){ 
					var form = $("#showContractForm").form();
				     $('#contractList').datagrid("reload", sy.serializeObject(form));
	          }
	     });
   }
   		 
   function addMehtod(){	
	   openWindows('${contextPath}/adapter/show.shtml','Contract Adapter',1100,900);
   } 
             
  function updateMethod(){    
	  var rowData = $('#contractList').datagrid('getSelections')[0];
	  if(!rowData){
		  alert("no selected!!");
		  return;
	  }
	  
  }	 
    
  function clickMethod(index,field,value){   
	} 
  
function formatter4Type(value,row,index){
    if(value=='1'){
      return "<s:property value="%{getText('Universal Adapter')}" />"  ;
    }
    else if(value=='2'){
      return "<s:property value="%{getText('jsScript')}" />"  ;
    } 
    else if(value=='3'){
      return "<s:property value="%{getText('bshScript')}" />"  ;
    } 
    else if(value=='4'){
      return "<s:property value="%{getText('PythonScript')}" />"  ;
    }
    else if(value=='5'){
      return "<s:property value="%{getText('XSLAdapter')}" />"  ;
    } 
    else if(value=='6'){
      return "<s:property value="%{getText('STD_XML2JSON')}" />"  ;
    }else if(value=='7'){
    	return "<s:property value="%{getText('STD_JSON2XML')}" />"  ;
    }else if(value=='8'){
    	return "<s:property value="%{getText('STD_CSV2XLS')}" />"  ;
    }else if(value=='8'){
    	return "<s:property value="%{getText('STD_FILE2BYTE')}" />"  ;
    }
  }
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
    <div id="queryBlock">    
	<div class="selectList" style="display:block;">
	<ui:form id="showContractForm" method="post" action="chooseVersion.shtml">
   		<dl class="noBorder">
   			<dl>	
    				<dt>
    					<s:property value="%{getText('srcCtrFID')}" />:
    				</dt>	
    				<dd >
    				   <ui:inputText id="sfid"  name="sfid" skin="${contextStyleTheme}" style="float:left;" value=""/>
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('tarCtrFID')}" />:
    				</dt>
    				<dd >
    					<ui:inputText id="tfid"  name="tfid" skin="${contextStyleTheme}" value=""/>
    				</dd>
    		</dl>
    		<dl>		
    				<dt>
    					<s:property value="%{getText('type')}" />:
    				</dt>
    				<dd >
    					<ui:select  name="type" id="type"   emptyOption="true"  headerValue="" list="typeL" 
    						listKey="key" listValue="value" style="width:70px;" skin="${contextStyleTheme}">
    			        </ui:select>
    				</dd>
    		</dl>
   	      	<div style="text-align:right;float:right; margin-bottom:5px ;">
					<ui:button text="%{getText('eaap.op2.conf.prov.query')}" id="chaxun" onclick="searchContract();" skin="${contextStyleTheme}"/>  
		 	</div>
   		
   		</dl>
	</ui:form>
	<br/>
	<dl class="noBorder">	
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" id="contractList" remoteSort="false" sortOrder="desc"  onClickCell="false" toolbar="true" fitHeight="380"
			skin="${contextStyleTheme}" fit="true" collapsible="true"   title="%{getText('eaap.op2.portal.prov.contractManage')}" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   
			method="eaap-op2-conf-adapterAction.getContractAdapterList">
			<ui:gridEasyColumn width="100" index="0" title="0" field="CONTRACT_ADAPTER_ID" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="1" title="1" field="SRC_CTR_F_ID" hidden="false"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="2" title="2" field="TAR_CTR_F_ID" hidden="false"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="3" title="3" field="APAPTER_NAME" hidden="false"   align="center" ></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="4" title="4" field="ADAPTER_TYPE" hidden="false"   align="center" formatter="true" formatterMethod="formatter4Type"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="5" title="5" field="SCRIPT_SRC" hidden="false"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="6" title="6" field="CREATE_DT" hidden="true"   align="center"></ui:gridEasyColumn>
		    <ui:gridEasyColumn width="100" index="7" title="7" field="STATE" hidden="false"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy> 
	</dl>
	 </div>
	 <table class="mgr-table" id="confirm">
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" shape="M"  text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseContractId();"></ui:button>
        <ui:button skin="${contextStyleTheme}" shape="M" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
      </td>	
     </tr>
  </table>
   </div>
</div>
</body>
<%@ include file="/common/ssoCommon.jsp"%>
</html>