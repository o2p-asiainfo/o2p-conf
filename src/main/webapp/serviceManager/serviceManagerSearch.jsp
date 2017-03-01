	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
  <head>
    <title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
</head>
<script type="text/javascript">
	var title = [];
	title[0]='<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionId')}" />';
	title[1]='<s:property value="%{getText('eaap.op2.conf.server.manager.serverVersion')}" />';
	title[2]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />';
	title[3]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnName')}" />';
	title[4]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />';
	title[5]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />';
	title[6]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />';
	title[8]='<s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}" />';
	
	$(document).ready(function() {
		 $('#SelectMenuData').val('A'); 
    });
</script>
<body>
<div class="contentWarp">
  	<div class="module-path">	
  		<div class="module-path-content">
  			<img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
  			<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.serverManager')}" />
     	</div>
    </div>
   	<div class="accordion-header" >
    	<div class="accordion-header-text">
    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
    	</div> 
   	</div>
	<div class="formLayout" style="padding:5px 0;">
	<form id="searchServiceManager" method="post">
		<input id="ChooseServiceId" name="ChooseServiceId" type="hidden" value="${serviceId}" />
	 	<input id="ChooseServiceName" name="ChooseServiceName" type="hidden" value="${serviceName}" />
	 	<input id="ChooseServiceCode" name="ChooseServiceCode" type="hidden" value="${serviceCode}" />
	 	<input id="ChooseServiceMsgFlowId" name="ChooseServiceMsgFlowId" type="hidden" value="${ServiceMsgFlowId}" />
	 	<input id="ChooseServiceMsgFlowName" name="ChooseServiceMsgFlowName" type="hidden" value="${ServiceMsgFlowName}" />
	 	<input id="ChooseSerInvokeInsId" name="ChooseSerInvokeInsId"  type="hidden" value="${serInvokeInsId}" />
	 	<input id="ChooseSerInvokeInsName" name="ChooseSerInvokeInsName" type="hidden" value="${serInvokeInsName}" />
	 	<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
		<dl>
			<dt><s:property value="%{getText('eaap.op2.conf.server.manager.serviceName')}" />: </dt>
			<dd>
			  	<ui:inputText skin="${contextStyleTheme}" name="serviceCnName" id="serviceCnName"  onfocus="changeService();"></ui:inputText>  		
			</dd>
		</dl>
		<dl>	
			<dt><s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionId')}" />: </dt>
			<dd>
			    <ui:inputText skin="${contextStyleTheme}" name="contractVersion" id="contractVersion" onfocus="changeProtocolVersion();" ></ui:inputText>
			    <ui:inputText skin="${contextStyleTheme}" name="contractVersionId" id="contractVersionId" type="hidden"></ui:inputText>
			</dd>
        </dl>
		<dl>
			<dt><s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />: </dt>
			<dd>
			    <ui:select skin="${contextStyleTheme}" name="state" id="SelectMenuData" list="resultList"  emptyOption="true" headerValue=" "	 listKey="componentId" listValue="name" onchange="getChangeData(this.value);"></ui:select>
			</dd>
		</dl>
		<dl>
			<dt><s:property value="%{getText('eaap.op2.conf.adapter.contractName')}" />: </dt>
			<dd>
			    <ui:inputText skin="${contextStyleTheme}" name="contractName" id="contractName" onfocus="changeContractName();" ></ui:inputText>
			</dd>
		</dl>
		<dl>
			<dt><s:property value="%{getText('eaap.op2.conf.adapter.contractCode')}" />: </dt>
			<dd>
			    <ui:inputText skin="${contextStyleTheme}" name="contractCode" id="contractCode" onfocus="changeContractCode();" ></ui:inputText>
			</dd>
		</dl>
   	    <div style="text-align:right;float:right; margin-bottom:5px ;">
   	    		<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/> 
				<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
		 </div>
	</form>
	</div>
	
	<div style=" clear:both;">
		<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" pageInfo="true" singleSelect="true"  id="table"  sortOrder="desc" remoteSort="false"
			fit="true" collapsible="false"   title="" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true" toolbar="true" 
			method="eaap-op2-conf-server-ServerManagerAction.showGrid">
			<ui:gridEasyColumn width="250" index="0" title="0" field="VERSION" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="250" index="1" title="1" field="SERVICE_CODE" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="250" index="2" title="2" field="SERVICE_CN_NAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="250" index="3" title="3" field="SERVICE_EN_NAME" hidden="true" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="4" title="4" field="STATE" hidden="false" align="center" formatter="true" formatterMethod="fomat"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="5" title="5" field="SERVICE_ID" hidden="true" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="6" title="6" field="CONTRACT_VERSION_ID" hidden="true" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="1" index="7" title="7" field="DEFAULT_MSG_FLOW" hidden="true" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="200" index="8" title="8" field="MESSAGE_FLOW_NAME" hidden="false"  formatter="true" formatterMethod="formatterForOp"   align="center"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
  <table class="mgr-table" style="display:none;" id="confirm">
   <tr>
     <td  colspan="4"  align="center">    
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.sure')}" id="chooseCompId" onclick="javascript:chooseServiceId()"></ui:button>
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
     </td>	
     </tr>
  </table>
</div> 
<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
</body>
<script type="text/javascript" src="${contextPath}/resource/comm/js/jqueryui/jquery-ui-v1.10.3.js"></script>
<style type="text/css">  
	.ui-autocomplete {max-height: 120px;overflow-y: auto; overflow-x:hidden;}
	.ui-autocomplete-loading {background: white url('${contextPath}/resource/${contextStyleTheme}/images/loading.gif') right center no-repeat;}
	* html .ui-autocomplete {height: 120px;}  
	</style>
     <script type="text/javascript">  
     $(document).ready(function(){
	      var choosePageState=$("#choosePageState").attr('value');
	      if(choosePageState!="") {
		      document.getElementById("confirm").style.display= ""; 
		      $(".datagrid-toolbar").hide();
	       }
    })
    
    
function formatterForOp(value,row,index){
   if(value==null){
		return "";
   }else{
		return '<a href="${msgFlowUrl}?messageFlowId='+row.DEFAULT_MSG_FLOW+'" target="_blank">'+value+'</a>' ;
   }
}
     
     
    		 var svcCache = {};
	 function changeService(){	 	
	    $("#serviceCnName").autocomplete({  
	    	minLength:1,
            autoFocus:true,
	    	source: function(request,response){
	    		 var term = request.term;
            	 if (term in svcCache){
            	 	response($.map(svcCache[term],function(item){
                   		return {
                             label:item.name,
                             value:item.name
                         };
                    }));
                    return;
            	 }
            	 
    		 	lastXhr = $.ajax({
    		 		type:"POST",
    		 		url:"../serviceManager/showServiceName.shtml",
                    dataType:"json",
                    data:{serviceCnName:$("#serviceCnName").val()},
                    success:function(data){
                    	svcCache[term] = data;
                    	response($.map(data,function(item){
                    		return {
                                 label:item.serviceCnName,
                                 value:item.serviceCnName
                            };
                    	}));
                    }
    		 	});
	    	},
	    	select:function(event,ui){
	    	} 
	     });
	 }

		 function changeProtocolVersion(){ 	
			 $("#contractVersionId").val("");
	    $("#contractVersion").autocomplete({  
	    	minLength:1,
            autoFocus:true,
	    	source: function(request,response){
	    		 var term = request.term;
            	 if (term in svcCache){
            	 	response($.map(svcCache[term],function(item){
                   		return {
                   			label:item.version,
                   			value:item.version,
                            id:item.contractVersionId
                         };
                    }));
                    return;
            	 }
            	 
    		 	lastXhr = $.ajax({
    		 		type:"POST",
    		 		url:"../serviceManager/queryContractVersionList.shtml",
                    dataType:"json",
                    data:{contractVersion:$("#contractVersion").val()},
                    success:function(data){
                    	svcCache[term] = data;
                    	response($.map(data,function(item){
                    		return {
                                 label:item.version,
                                 value:item.version,
                                 id:item.contractVersionId
                            };
                    	}));
                    }
    		 	});
	    	},
	    	select:function(event,ui){
	    		$("#contractVersionId").val(ui.item.id);
	    	} 
	     });
	 }
            
	 function changeContractName(){	 	
		    $("#contractName").autocomplete({  
		    	minLength:1,
	            autoFocus:true,
		    	source: function(request,response){
		    		 var term = request.term;
	            	 if (term in svcCache){
	            	 	response($.map(svcCache[term],function(item){
	                   		return {
	                             label:item.NAME,
	                             value:item.NAME
	                         };
	                    }));
	                    return;
	            	 }
	            	 
	    		 	lastXhr = $.ajax({
	    		 		type:"POST",
	    		 		url:"../contractManager/queryContractList.shtml",
	                    dataType:"json",
	                    data:{name:$("#contractName").val()},
	                    success:function(data){
	                    	svcCache[term] = data;
	                    	response($.map(data,function(item){
	                    		return {
	                                 label:item.NAME,
	                                 value:item.NAME
	                            };
	                    	}));
	                    }
	    		 	});
		    	},
		    	select:function(event,ui){
		    	} 
		     });
		 }
	 function changeContractCode(){	 	
		    $("#contractCode").autocomplete({  
		    	minLength:1,
	            autoFocus:true,
		    	source: function(request,response){
		    		 var term = request.term;
	            	 if (term in svcCache){
	            	 	response($.map(svcCache[term],function(item){
	                   		return {
	                             label:item.CODE,
	                             value:item.CODE
	                         };
	                    }));
	                    return;
	            	 }
	            	 
	    		 	lastXhr = $.ajax({
	    		 		type:"POST",
	    		 		url:"../contractManager/queryContractList.shtml",
	                    dataType:"json",
	                    data:{code:$("#contractCode").val()},
	                    success:function(data){
	                    	svcCache[term] = data;
	                    	response($.map(data,function(item){
	                    		return {
	                                 label:item.CODE,
	                                 value:item.CODE
	                            };
	                    	}));
	                    }
	    		 	});
		    	},
		    	select:function(event,ui){
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

          function searchFunc() {
        	  $("#isInit").val("false");
	      	  var form = $("#searchServiceManager").form();
          	  $('#table').datagrid("load", sy.serializeObject(form));
          }			
	
	      function closeWin(){
	  	  $('#compWin').window('close');
	      }
	      function closeSvcWin(){
	 	  $('#svcWin').window('close');
	      }
	      
	function chooseServiceId(){
	    var vOpener=art.dialog.opener;
	    var chooseServiceId = $('#table').datagrid('getSelections')[0].SERVICE_ID ;
	    var chooseServiceName = $('#table').datagrid('getSelections')[0].SERVICE_CN_NAME ;
	    var chooseServiceCode = $('#table').datagrid('getSelections')[0].SERVICE_CODE ;
	    var chooseServiceMsgFlowId = $('#table').datagrid('getSelections')[0].DEFAULT_MSG_FLOW ;
	    var ChooseServiceMsgFlowName = $('#table').datagrid('getSelections')[0].MESSAGE_FLOW_NAME ;
	    if(chooseServiceId==""){
			alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
	    }else{
			if($("#ChooseServiceId").attr('value')!=""){
				vOpener.document.getElementById($("#ChooseServiceId").attr('value')).value=chooseServiceId;
			}
			if($("#ChooseServiceName").attr('value')!=""){
				vOpener.document.getElementById($("#ChooseServiceName").attr('value')).value=chooseServiceName;
			}
			if($("#ChooseServiceCode").attr('value')!=""){
				vOpener.document.getElementById($("#ChooseServiceCode").attr('value')).value=chooseServiceCode;
			}
			if($("#ChooseServiceMsgFlowId").attr('value')!=""){
				vOpener.document.getElementById($("#ChooseServiceMsgFlowId").attr('value')).value=chooseServiceMsgFlowId;
			}
			if($("#ChooseServiceMsgFlowName").attr('value')!=""){
				vOpener.document.getElementById($("#ChooseServiceMsgFlowName").attr('value')).innerHTML=ChooseServiceMsgFlowName;
			}
			if($("#ChooseSerInvokeInsId").attr('value')!=""){
				//OTT WorkFlow Choose API:
				var chooseSerInvokeInsId = "";
				var chooseSerInvokeInsName = "";
				var SIIInfoJson = getSerInvokeInsInfoByServiceId(chooseServiceId);
				if(SIIInfoJson!=null && SIIInfoJson!=""){
					chooseSerInvokeInsId		= SIIInfoJson.SER_INVOKE_INS_ID;
					chooseSerInvokeInsName	= SIIInfoJson.SER_INVOKE_INS_NAME;
					//vOpener.document.getElementById($("#ChooseSerInvokeInsId").attr('value')).value = chooseSerInvokeInsId;
					window.opener.document.all($("#ChooseSerInvokeInsId").attr('value')).value =chooseSerInvokeInsId;
					if($("#ChooseSerInvokeInsName").attr('value')!=""){
						//vOpener.document.getElementById($("#ChooseSerInvokeInsName").attr('value')).value = chooseSerInvokeInsName;
						window.opener.document.all($("#ChooseSerInvokeInsName").attr('value')).value =chooseSerInvokeInsName;
					}
					window.close();
				}
			}
			if(null!= vOpener.document.getElementById("serviceCkt")){
				vOpener.addTab1(chooseServiceId,chooseServiceCode,chooseServiceName,1);
			}
			art.dialog.close(); 
		 }
	 }
	 
	 function getSerInvokeInsInfoByServiceId(serviceId){
	 	var SIIInfoJson = null;
 		$.ajax({
		     type:"post",
		     async:false,
		     url:"../serviceManager/getSerInvokeInsInfoByServiceId.shtml",
		     dataType:"text",
		     data:"serviceId="+serviceId,
		     success:function(msg,data){
				try {
		      		var jsonObj = eval('(' + msg + ')');
		      		if(jsonObj[0] != null &&  jsonObj[0].msg=="ok"){
		      			SIIInfoJson = jsonObj[0].SIIInfo;
		      		}else if(jsonObj[0] != null &&  jsonObj[0].FailureInfo !=null){
		      			alert(jsonObj[0].FailureInfo);
		      		}
				} catch (e) {
			      	alert("<s:property value="%{getText('eaap.op2.conf.server.manager.getSIIFailed')}" />");
				}
	   	  	}
		});	
	 	return SIIInfoJson;
	 }
    
      function addMehtod(){
        window.location.href="../serviceManager/serviceAdd.shtml"; 
      }
      function updateMethod(){
        var rows = $('#table').datagrid('getSelections');
         if(rows.length==0){
            $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
	        return false; 
            } 
        var serviceId = rows[0].SERVICE_ID;
        window.location.href="../serviceManager/showUpdateServiceData.shtml?serviceId="+serviceId; 
      }  
      function deleteMethod(){
        var rows = $('#table').datagrid('getSelections');
            if(rows.length==0){
            $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
	        return false; 
            } 
        var serviceId = rows[0].SERVICE_ID;
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
         $(document).ready(function(){
   var  choosePageState=$("#choosePageState").attr('value');
      if(choosePageState!="")
     {
      document.getElementById("confirm").style.display= ""; 
     }
    })
    
   </script>   
   <%@ include file="/common/ssoCommon.jsp"%>
</html>
