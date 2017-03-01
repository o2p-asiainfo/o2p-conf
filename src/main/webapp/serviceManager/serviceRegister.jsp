<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>

<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=${contextStyleTheme}" ></script> 
<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script>
</head>

    <body class="easyui-layout" style="height:550px;">  

       <script type="text/javascript">
		var title = [];
		   title[0]='<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionId')}" />';
		   title[1]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceId')}" />';
		   title[2]='<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />';
		   title[3]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />';
		   title[4]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCnName')}" />';
		   title[5]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />';
        </script>
        
         <div data-options="region:'east',iconCls:'icon-reload',title:'East',split:true,noheader:true" style="width:800px;height:525px">
            <ui:gridEasy columns="cols" fitHeight="525" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true" pageInfo="true" id="table"  sortOrder="desc" remoteSort="false"
            fit="true" collapsible="false"   title="%{getText('eaap.op2.conf.server.manager.serverManager')}" striped="true" pageList="15" pagination="true" toolbar="true" frozenColumns="true" rownumbers="true"  method="eaap-op2-conf-server-ServerManagerAction.showServiceGrid">
             <ui:gridEasyColumn width="100" index="0" title="0" field="contractVersionId" hidden="false" align="center"></ui:gridEasyColumn>
             <ui:gridEasyColumn width="100" index="1" title="1" field="serviceId" hidden="false" align="center"></ui:gridEasyColumn>
             <ui:gridEasyColumn width="100" index="2" title="2" field="serviceVersion" hidden="false" align="center"></ui:gridEasyColumn>
             <ui:gridEasyColumn width="100" index="3" title="3" field="serviceCnName" hidden="false" align="center"></ui:gridEasyColumn>
             <ui:gridEasyColumn width="100" index="4" title="4" field="serviceEnName" hidden="false" align="center"></ui:gridEasyColumn>
             <ui:gridEasyColumn width="100" index="5" title="5" field="state" hidden="false" align="center" formatter="true" formatterMethod="fomat"></ui:gridEasyColumn>
            </ui:gridEasy>
          </div>  
          
         <div data-options="region:'center',title:'center title',noheader:true,split:true,border:true" style="width:290px;height:525px" >
		     <form id="searchServiceManager" method="post">
			     <ui:tabpage  skin="${contextStyleTheme}" id="tt" height="525px"  width="290px" loadMode="ajax" fit="true" onSelect="true">
			       <ui:tabpagediv closable="false" id="test1" title="%{getText('eaap.op2.conf.server.manager.serviceMenu')}">
			        <ui:tree skin="${contextStyleTheme}" method="eaap-op2-conf-server-ServerManagerAction.showServiceDirTree" id="ServiceDirTree"  
						 attrId="nodeDirId" attrPid="qwepId" textName="dirTreeNode" textId="dirTreeNode" callBackMethod="getNodeDir" attrName="qwepName" attrIsParent="qweIsParent"  divclass="qwe" >
						 </ui:tree>	  
				  <%-- <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceAdd')}" onclick="openWindows('${contextPath}/directoryManager/showAddDirNodeData.shtml','Add Directory',1000,360)" shape="s"></ui:button> --%>
				   <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceAdd')}" onclick="addDirNode()" shape="s"></ui:button>
				   <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDelete')}" onclick="deleDirNode()" shape="s"></ui:button>
				   <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="updateDirNode()" shape="s"></ui:button>
			       </ui:tabpagediv>
			       
			       <ui:tabpagediv id="test2" title="%{getText('eaap.op2.conf.server.manager.workflow')}" closable="false" >
			        <ui:tree skin="${contextStyleTheme}" method="eaap-op2-conf-server-ServerManagerAction.showWorkFlowTree" id="WorkFlowTree"  
						 attrId="nodeWorkFlowId" attrPid="qwepId" textName="workFlowTreeNode" textId="workFlowTreeNode" callBackMethod="getNodeWorkFlow" attrName="qwepName" attrIsParent="qweIsParent"  divclass="qwe" >
						 </ui:tree>
					<%-- <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceAdd')}"  onclick="openWindows('${contextPath}/workFlowManager/openAddWorkFlow.shtml','Add Business Process',1000,400)" shape="s"></ui:button> --%>
					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceAdd')}"  onclick="openAddWorkFlowNode()" shape="s"></ui:button>
				   	<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceDelete')}" onclick="deleWorkFlowNode()" shape="s"></ui:button>
				   	<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="updateWorkFlowNode()" shape="s"></ui:button> 
			       </ui:tabpagediv>
			       
			        <ui:tabpagediv id="test2" title="%{getText('eaap.op2.conf.server.otherService')}" closable="false"  >
				  	 <ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.listOther')}" onclick="getExceptService()" shape="s"></ui:button>	 
				  	 <!--<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.serviceUpdate')}" onclick="updateExceptService()" shape="s"></ui:button>--> 
			       	</ui:tabpagediv>
			     </ui:tabpage>
		      </form> 
        </div> 
        <ui:iframe skin="${contextStyleTheme}" iframeWidth="910" iframeHeight="500" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" /> 
</body>
        
    <script type="text/javascript">
    
              var NodeDirId = "";
              var NodeWorkFlowId = "";
              function do_operate(){
              $("input[type='hidden']").val(""); 
              }
    		  function addMehtod(){
    		  window.location.href="../serviceManager/serviceAdd.shtml?serviceFlag=dir"; 
              }
              function updateMethod(){
              var rowData = $('#table').datagrid('getSelections');
              var serviceId = rowData[0].serviceId;
    		  window.location.href="../serviceManager/showUpdateServiceData.shtml?serviceFlag=dir&serviceId="+serviceId; 
              }  
            function deleteMethod(){
            var rows = $('#table').datagrid('getSelections');
            if(rows.length==0){
            $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
	        return false; 
            } 
            var serviceId = rows[0].serviceId;
            $.ajax({
            type:"post",
            async:false,
            url:"../serviceManager/deleteServiceManager.shtml",
            dataType:"json",
            data:{deleteIDs:serviceId},
            success:function(msg){
            if(msg=="failure"){
            alert("<s:property value="%{getText('eaap.op2.portal.pardProd.prodOfferunique')}" />");
            }
             $('#table').datagrid('reload');
         }
          });
        }
              function fomat(value,row,index){
    		     if(value=='N'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisable')}" />"
					   }
					  if(value=='A'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnable')}" />"
					   }    
					
    		  }
    		  function getNodeDir(nodeDirId){
    		      NodeDirId=nodeDirId;
    		      var form = $("#searchServiceManager").form();
                  $('#table').datagrid("load", sy.serializeObject(form));
    		  }
    		  function getNodeWorkFlow(nodeWorkFlowId){
    		       NodeWorkFlowId=nodeWorkFlowId;
    		       var form = $("#searchServiceManager").form();
                  $('#table').datagrid("load", sy.serializeObject(form));
    		  }
    		  function getExceptService(){
    		       var form = $("#searchServiceManager").form();
                  $('#table').datagrid("load", sy.serializeObject(form));
    		  }
    		  function deleWorkFlowNode(){
	    		  $.ajax({
	    		     type:"post",
	                 async:false,
	                 url:"../workFlowManager/deleWorkFlowNode.shtml",
	                 dataType:"json",
	                 data:{value:NodeWorkFlowId},
	                 success:function(msg){
	                 if(msg.message=="OK"){
	                 window.location.reload();
	                 }else{
	                 alert('<s:property value="%{getText('eaap.op2.conf.server.manager.deleWarn')}" />');
	                 }
	                 }
	    		  });
    		  }
    		  function openAddWorkFlowNode(){
    			  //onclick="openWindows('${contextPath}/workFlowManager/openAddWorkFlow.shtml','Add Business Process',1000,400)"
    			  openWindows('${contextPath}/workFlowManager/openAddWorkFlow.shtml?NodeWorkFlowId='+NodeWorkFlowId,'Add Business Process',1000,400);
    		  }
    		  function updateWorkFlowNode(){
    			  if(NodeWorkFlowId==null || NodeWorkFlowId==""){
    				  alert('<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />');
    				  return;
    			  }
    			  openWindows('${contextPath}/workFlowManager/getWorkFlow.shtml?NodeWorkFlowId='+NodeWorkFlowId,'Modify Business Process',1000,400)
    		  }
    		  function deleDirNode(){
    		  $.ajax({
    		     type:"post",
                 async:false,
                 url:"../directoryManager/deleDirNode.shtml",
                 dataType:"json",
                 data:{value:NodeDirId},
                 success:function(msg){
                 if(msg.message=="OK"){
                 window.location.reload();
                 }else{
                 alert('<s:property value="%{getText('eaap.op2.conf.server.manager.deleWarn')}" />');
                 }
                 }
    		  });
    		  }
    		  
    		  //openWindows('${contextPath}/directoryManager/showAddDirNodeData.shtml','Add Directory',1000,360)
    		  function addDirNode(){
    			  openWindows('${contextPath}/directoryManager/showAddDirNodeData.shtml?nodeDirId='+NodeDirId,'Add Directory',1000,360)
    		  }
    		  function updateDirNode(){
    			  if(NodeDirId==null || NodeDirId==""){
    				  alert('<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />');
    				  return;
    			  }
    			  openWindows('${contextPath}/directoryManager/getDirById.shtml?nodeDirId='+NodeDirId,'update Dir',1000,360)
    		  }
    		function closeWin(){
	        $('#opendialog').window('close');
	       }
	       
			function reSearch() {
				window.location="../serviceManager/serviceRegister.shtml";
		    }
	  
    </script> 
    <%@ include file="/common/ssoCommon.jsp"%> 
</html>