<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
   <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" >
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
    <script type="text/javascript" src="${contextPath}/resource/comm/adapter/json2.js" ></script>
</head>
<script type="text/javascript">
		var title = [];   
		   title[0]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceName')}" />';
		   title[1]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceCode')}" />';
		   title[2]='<s:property value="%{getText('eaap.op2.conf.server.supplier.componentCode')}" />';
		   title[3]='<s:property value="%{getText('eaap.op2.conf.server.supplier.componentName')}" />';
		   title[4]='<s:property value="%{getText('eaap.op2.conf.server.supplier.state')}" />';
		   title[5]='<s:property value="%{getText('eaap.op2.conf.server.supplier.createTime')}" />';
		   title[6]='<s:property value="%{getText('eaap.op2.conf.server.supplier.stateTime')}" />';
		   title[7]='<s:property value="%{getText('eaap.op2.conf.server.supplier.address')}" />';
		   title[8]='<s:property value="%{getText('eaap.op2.conf.server.supplier.CommunicationProtocol')}" />';
		   title[9]='<s:property value="%{getText('eaap.op2.conf.server.supplier.CommunicationProtocol')}" />';
		   title[10]='<s:property value="%{getText('eaap.op2.conf.server.supplier.CommunicationProtocol')}" />';
		   title[11]='<s:property value="%{getText('eaap.op2.conf.server.supplier.CommunicationProtocol')}" />';
		   title[12]='<s:property value="%{getText('eaap.op2.conf.server.supplier.techImplName')}" />';
		   title[13]='<s:property value="%{getText('eaap.op2.conf.server.manager.serviceMsgFlow')}" />';
		   $(document).ready(function() {
				 $('#SelectMenuData').val('D'); 
		   });
</script>
<body> 
	<!--  
	<div id="compWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionSelect')}" />" style="width:650px;height:500px;padding:5px;">
    </div>-->
<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	    <img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.manager.serverManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.register')}" />
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
					<s:property value="%{getText('eaap.op2.conf.server.supplier.service')}" />:
				</dt>
				<dd style="width:260px;">
				  	<ui:inputText  skin="${contextStyleTheme}" name="serviceName" id="serviceName"  textSize="25"  readonly="true" style="float:left;"></ui:inputText>
		  		    <input class="inputClearBtn" onclick="javascript:cleardata('serviceId','serviceName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/> 					
		  			<input name="serviceId" id="serviceId" type="hidden" />
		  			<input name="serviceCode" id="serviceCode" type="hidden"  />
		  			<input name="attrName" id="attrName" type="hidden" value="${attrName}"/>
		  			<input name="objectId" id="objectId" type="hidden" value="${objectId}"/>
		  			<input name="endpoint_Spec_Attr_Id" id="endpoint_Spec_Attr_Id" type="hidden" value="${endpoint_Spec_Attr_Id}"/>
		  			<input name="chooseSerTechImplId" id="chooseSerTechImplId" type="hidden" value="${serTechImplId}" />
		  			<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
                    <input type="hidden" name="newState" id="newState" value="${newState}">
                    <input type="hidden" name="attrSpecCode" id="attrSpecCode" value="${attrSpecCode}">
				 	<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/serviceManager/showMainInfo.shtml?serviceId=serviceId&&serviceName=serviceName&&serviceCode=serviceCode&&pageState=pageState','Select Service')" shape="s"></ui:button>
				</dd>
		</dl>

		<dl>
				<dt><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryOrgan')}" />:</dt>
				<dd style="width:260px;">
				  <input id="orgId" name="orgId" type="hidden" />
				  <ui:inputText skin="${contextStyleTheme}" name="orgName" id="orgName"  textSize="25" readonly="true" style="float:left;"></ui:inputText>
				  <input class="inputClearBtn" onclick="javascript:cleardata('orgId','orgName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>

					<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&&chooseOrgCode=orgId','Choose Org')" shape="s"></ui:button>
				</dd>
		</dl>
			
		<dl>
				<dt><s:property value="%{getText('eaap.op2.conf.server.supplier.subsidiaryComponent')}" />:</dt>
				<dd style="width:260px;">
					<input id="componentId" name="componentId" type="hidden" />
					<ui:inputText skin="${contextStyleTheme}" name="componentName" id="componentName"  textSize="25"  readonly="true" style="float:left;"></ui:inputText>
					<input class="inputClearBtn" onclick="javascript:cleardata('componentId','componentName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>

			 		<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=componentName&&chooseCompCode=componentId','Select Component')" shape="s"></ui:button>
				</dd>
		</dl>
	
       <dl>
        	<dt><s:property value="%{getText('eaap.op2.conf.server.supplier.CommunicationProtocol')}" />:</dt>
			<dd>
			  <ui:select skin="${contextStyleTheme}" name="commProCd" id="commProCd" list="commProtocalResultList" width="157"  emptyOption="true" headerValue=" "	 listKey="commProtocalId" listValue="commProtocalName" onchange="getChangeData(this.value);"></ui:select>
	  	    </dd>
	  </dl>
	  
	  <dl>
       		<dt style="line-height:16px;"><s:property value="%{getText('eaap.op2.conf.server.supplier.techcologicalRealization')}" />:</dt>
			<dd>
			  <input id="techImplId" name="techImplId" type="hidden"  />
	  		  <ui:inputText skin="${contextStyleTheme}" name="techImplName" id="techImplName"  textSize="25" readonly="true" style="float:left;"></ui:inputText> 
	  		  <input class="inputClearBtn" onclick="javascript:cleardata('techImplId','techImplName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>

			 <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.choose')}" onclick="openWindows('${contextPath}/techimpl/showTechImplIndex.shtml?techImplId=techImplId&&techImplName=techImplName&&pageState=pageState','Select Technology Implementation')" shape="s"></ui:button>
			</dd>
	 </dl>
		
	 <dl style="width:390px;">
	   		<dt><s:property value="%{getText('eaap.op2.conf.server.manager.serviceStatus')}" />:</dt>
			<dd style="width:235px;">
			  <ui:select skin="${contextStyleTheme}" name="state" id="SelectMenuData" list="resultList" width="157"  emptyOption="true" headerValue=" "	 listKey="componentId" listValue="name" onchange="getChangeData(this.value);"></ui:select>
	  	    </dd>
	 </dl>
	   
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
   			<ui:inputText skin="${contextStyleTheme}" name="isInit" id="isInit" value="" style="display:none"/>
			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true"  id="table"  pageInfo="true" sortOrder="desc" remoteSort="false"
		fit="true" collapsible="false"   title="" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true" toolbar="true"   fitHeight="358" 
		method="eaap-op2-conf-server-ServerManagerAction.showServiceSupRegisterGrid">
		<ui:gridEasyColumn width="100" index="0" title="0" field="SERVICE_CN_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="SERVICE_CODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="CODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="3" title="3" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="4" title="4" field="STATE" hidden="false" align="center" formatter="true" formatterMethod="fomat" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="5" title="5" field="CREATE_TIME" hidden="false" align="center" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80" index="6" title="6" field="LASTEST_TIME" hidden="false" align="center" ></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="7" title="7" field="ATTR_SPEC_VALUE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="8" title="8" field="COMM_PRO_CD" hidden="false" align="center" formatter="true" formatterMethod="fomatComm"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="0" index="9" title="9" field="SERVICE_ID" hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="0" index="10" title="10" field="TECH_IMPL_ID" hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="0" index="11" title="11" field="ORG_ID" hidden="true" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="12" title="12" field="TECH_IMPL_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="0" index="13" title="13" field="SER_TECH_IMPL_ID" hidden="true" align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>

<table class="mgr-table" style="display:none" id="confirm" >
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseSerTechImplId();"></ui:button>
	  	<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="$(window.parent.document).find('#closeButton').click();"></ui:button>
      </td>	
     </tr>
</table>

</div>
<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
</body>
 <script type="text/javascript" src="${contextPath}/resource/comm/js/jqueryui/jquery.autocomplete.js"></script>
 <link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/jquery.autocomplete.css" />
 <script type="text/javascript">  
		
		
    		$(function(){   
    		   $("#productName").autocomplete("serviceManager/showServiceManager.shtml", { 
                minChars: 1,    
                max: 12,   
                autoFill: false,  
                dataType : "json", 
                extraParams: {
                     productName: function()   
                      {   
                       return $("#productName").val();   
                      }     
                   },  
                 parse: function(data)   
                    {  
                     var rows = [];  
                       for(var i=0; i<data.length; i++)  
                         {    
                             rows[rows.length] = {  
                               data:data[i].contractVersionId,  
                               value:data[i].contractVersionId,   
                               result:data[i].contractVersionId  
                             };  
                       }             
                    return rows;  
                },  
                formatItem: function(item) {  
                        return item;  
                }  
            });  
            $("#contractVersionId").autocomplete("serviceManager/showServiceManager.shtml", { 
                minChars: 1,    
                max: 12,   
                autoFill: false,  
                dataType : "json", 
                 extraParams:   
                {     
                     productName: function()   
                      {   
                       return $("#contractVersionId").val();   
                      }     
                   },  
                 parse: function(data)   
                    {  
                     var rows = [];  
                       for(var i=0; i<data.length; i++)  
                         {    
                             rows[rows.length] = {  
                               data:data[i].contractVersionId,  
                               value:data[i].contractVersionId,   
                               result:data[i].contractVersionId  
                             };  
                       }             
                    return rows;  
                },  
                formatItem: function(item) {  
                        return item;  
                }  
            });
    		});
    		
    		
    	
       function deleteMethod(){
            var rows = $('#table').datagrid('getSelections');
            if(rows.length==0){
            alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
            //$.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
	        return false; 
            } 
            var serTechImplId = rows[0].SER_TECH_IMPL_ID;
            $.ajax({
            type:"post",
            async:false,
            url:"../serviceManager/serviceSupplierResgisterDelete.shtml",
            dataType:"json",
            data:{deleteIDs:serTechImplId},
            success:function(msg,data){
            if(msg=="failure"){
            alert("<s:property value="%{getText('eaap.op2.portal.pardProd.prodOfferunique')}" />");
            }
            $('#table').datagrid('reload');
        }
        });
        }
    		
    		  function addMehtod(){
    		  window.location.href="../serviceManager/serviceSupplierResgisterAdd.shtml"; 
              }
              function updateMethod(){
              var rows=$('#table').datagrid('getSelections');
              if(rows.length==0)
			    {
            	  alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
				   //$.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
		           return false;  
				}else
				{ 
				   var ser_tech_impl_id = rows[0].SER_TECH_IMPL_ID;
				  window.location.href="../serviceManager/showSupRegUpdate.shtml?serTechImplId="+ser_tech_impl_id;      
				}
              
              }
           
		    
		  function searchFunc() {
			  $("#isInit").val("false");
	      	  var form = $("#serviceSupplierRegister").form();
          	  $('#table').datagrid("load", sy.serializeObject(form));
          }			 

          function closeWin(){
          $('#opendialog').window('close');
          }
          
          
		function fomat(value,row,index){
    		  if(value=='N'){
			   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisable')}" />"
			   }
			  if(value=='D'){
			   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnable')}" />"
			   } 
		}

		function	fomatMessageFlow(value,row,index){
    		if(value != null && value != '' && value!="[]"){
				var host = window.location.host;
    			var retHtml="";
 				var MessageFlowJson = JSON.parse(value);			// [{"MESSAGE_FLOW_ID":"476","MESSAGE_FLOW_NAME":"TDC-MessageFlow"},{"MESSAGE_FLOW_ID":"627","MESSAGE_FLOW_NAME":"ColumbinApi_MsgFlow"}]
				for(var i=0; MessageFlowJson.length>i; i++){
					var MessageFlowObj = MessageFlowJson[i];
					var messageFlowId 		= MessageFlowObj.MESSAGE_FLOW_ID;
					var messageFlowName = MessageFlowObj.MESSAGE_FLOW_NAME;
					if(i>0){
						retHtml += ", <br>"
					}
					retHtml += "<a href='http://"+host+"${msgFlowUrl}?messageFlowId="+messageFlowId+"'  target='_blank ' title='"+messageFlowName+"'>"+messageFlowName+"</a>";
				}
				return retHtml;
			}else{
				return "<a href='#' ><span onclick='createMessageFlow(\""+row.SER_TECH_IMPL_ID+"\",\""+row.TECH_IMPL_NAME+"\",this.parentNode)' style=\"border-right:1px solid #A2B7DD;border-bottom:1px solid #A2B7DD;background-color:#E0EBFF;\">&nbsp;Create&nbsp;</span></a>";
			}
		}
		
		function createMessageFlow(serTechImplId, techImplName,createObj){
			$(createObj).html("<img src='../resource/comm/images/loading.gif'/>");
			$.ajax({
			     type:"post",
			     async:true,
			     url:"../serviceManager/createDirectMessageFlow.shtml",
			     dataType:"text",
			     data:"serTechImplId="+serTechImplId+"&techImplName="+techImplName,
			     success:function(msg,data){
					try {
						//成功
			      		var msgJson = JSON.parse(msg);
			      		var result = msgJson[0].msg;
				      	if(result=="ok"){
				      		alert("Create Success");
					   		$('#table').datagrid('reload');
					    }else{
							//失败
							$(createObj).html("<span onclick='createMessageFlow(\""+serTechImplId+"\",\""+techImplName+"\",this.parentNode)' style=\"border-right:1px solid #A2B7DD;border-bottom:1px solid #A2B7DD;background-color:#E0EBFF;\">&nbsp;Create&nbsp;</span>");
					      	alert("Create Failure !");
						}
					} catch (e) {
						//失败
						$(createObj).html("<span onclick='createMessageFlow(\""+serTechImplId+"\",\""+techImplName+"\",this.parentNode)' style=\"border-right:1px solid #A2B7DD;border-bottom:1px solid #A2B7DD;background-color:#E0EBFF;\">&nbsp;Create&nbsp;</span>");
				      	alert("Create Failure !");
					}
		  	  	}
			});	
		}
		
	function	fomatComm(value,row,index){
		var retText ="";
		var optionList = $("#commProCd").find("option");
		optionList.each(function(index){
			if(value == $(this).val()){
				retText = $(this).text();
			}
		});
		return retText;
	}
    		  
    function chooseSerTechImplId()
   { 
    var detail = "<s:property value="%{getText('eaap.op2.conf.proof.checkout')}" />";
    var vOpener=art.dialog.opener;
    var chooseSerTechImplId = $('#table').datagrid('getSelections')[0].SER_TECH_IMPL_ID+'';
    var TECH_IMPL_NAME = $('#table').datagrid('getSelections')[0].TECH_IMPL_NAME+'';
    var newState = document.getElementById("newState").value;
    if('new' == newState){
		window.parent.editorPropertyValue(document.getElementById("objectId").value,
				document.getElementById("endpoint_Spec_Attr_Id").value,
				document.getElementById("attrSpecCode").value,chooseSerTechImplId);
		$(window.parent.document).find("#closeButton").click();
	}else{
		art.dialog.opener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,chooseSerTechImplId,
			    document.getElementById("objectId").value,
			    document.getElementById("endpoint_Spec_Attr_Id").value);
		art.dialog.close();
	}
    //art.dialog.opener.setTechValue(chooseSerTechImplId);
    //alert(222);
    //alert($(art.dialog.opener).find('input[flag]').attr('name'));
   // var tec_name = vOpener.document.getElementById("tec_TechnologyImplName");
   // if(null != tec_name){
    	//$(tec_name).replaceWith(inputValue); 
   // }else{
    	//$(vOpener.document.getElementById("endpoint_Atr_ValueTable")).append(htmlValue);
    //}
   //parent.closeSelectValueSpecWin(); 
    	
   }
 
   $(document).ready(function(){
   var  choosePageState=$("#choosePageState").attr('value');
      if(choosePageState!="")
     {
      document.getElementById("confirm").style.display= ""; 
      $(".datagrid-toolbar").hide();
     }

})
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
    </script>       
    <%@ include file="/common/ssoCommon.jsp"%>     	
</html>
