<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
</head>
<script type="text/javascript">
		var title = [];   
		   title[0]='<s:property value="%{getText('eaap.op2.conf.proof.proofeId')}" />';
		   title[1]='<s:property value="%{getText('eaap.op2.conf.proof.pt_cd')}" />';
		   title[2]='<s:property value="%{getText('eaap.op2.conf.proof.pt_name')}" />';
		   title[3]='<s:property value="%{getText('eaap.op2.conf.proof.createTime')}" />';
		  
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
					属性规格名称<%-- <s:property value="%{getText('eaap.op2.conf.proof.proofeId')}" />--%>:
				</dt>
				<dd style="width:260px;">
				  	<ui:inputText  skin="${contextStyleTheme}" name="attr_spec_name" id="attr_spec_name"  textSize="25" style="float:left;"></ui:inputText>
				</dd>
		</dl>
	
       <dl>
        	<dt>属性规格编码<%-- <s:property value="%{getText('eaap.op2.conf.proof.pt_name')}" />--%>:</dt>
			<dd>
			  <ui:inputText  skin="${contextStyleTheme}" name="attr_spec_code" id="attr_spec_code"  textSize="25" style="float:left;"></ui:inputText>
	  	    </dd>
	  </dl>
	   
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true"  id="table"  pageInfo="true" sortOrder="desc" 
		fit="true" collapsible="false"   title="" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true"  method="eaap-op2-conf-proofeffect-ProofEffectAction.getAttrSpecValue">
		<ui:gridEasyColumn width="100" index="0" title="0" field="ATTRSPECID" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="ATTRSPECNAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="ATTRSPECCODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="3" title="3" field="ATTRSPECDESC" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="4" title="4" field="CREATEDATE" hidden="false" align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>

<table class="mgr-table" style="display:inline" id="confirm" >
   <tr>
     <td  colspan="4"  align="center">
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.manager.confirm')}"  onclick="chooseSerTechImplId();"></ui:button>
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
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
		  function searchFunc() {
	      var form = $("#serviceSupplierRegister").form();
          $('#table').datagrid("load", sy.serializeObject(form));
          }			 

          function closeWin(){
          $('#opendialog').window('close');
          }
    function chooseSerTechImplId()
   { 
    var vOpener=art.dialog.opener;
    var operationObj = $('#table').datagrid('getSelections')[0];
    if(null != operationObj){
        var attr_spec_id = $('#table').datagrid('getSelections')[0].ATTRSPECID+'';
        var attr_spec_name = $('#table').datagrid('getSelections')[0].ATTRSPECNAME+'';
        var parent_attr_spec_id = vOpener.document.getElementById("hidden_attr_spec_id");
        var parent_attr_spec_name = vOpener.document.getElementById("attr_spec_name");
        $(parent_attr_spec_id).val(attr_spec_id);
        $(parent_attr_spec_name).val(attr_spec_name);
        art.dialog.close();
    }else{
    	art.dialog.alert('操作提示','请选择一条记录!');
    }
   }
 
   $(document).ready(function(){
   var  choosePageState=$("#choosePageState").attr('value');
      if(choosePageState!="")
     {
      document.getElementById("confirm").style.display= ""; 
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
