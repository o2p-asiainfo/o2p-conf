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
					认证属性规格名称<%-- <s:property value="%{getText('eaap.op2.conf.proof.proofeId')}" />--%>:
				</dt>
				<dd style="width:260px;">
				  	<ui:inputText  skin="${contextStyleTheme}" name="pr_attr_spec_name" id="pr_attr_spec_name"  textSize="25" style="float:left;"></ui:inputText>
				</dd>
		</dl>
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true"  id="table"  toolbar="true" pageInfo="true" sortOrder="desc" 
		fit="true" collapsible="false"   title="" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true"  method="eaap-op2-conf-proofeffect-ProofEffectAction.getPrAttrSpecValue">
		<ui:gridEasyColumn width="100" index="0" title="0" field="PR_ATR_SPEC_CD" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="PR_ATR_SPEC_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="ATTR_SPEC_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="3" title="3" field="ATTR_SPEC_CODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="4" title="4" field="PT_NAME" hidden="false" align="center"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>
			<!-- 添加认证类型属性规格 -->
			<div id="show_add_table" style="display: none">
				<ui:form id="myForm" method="post" name="myForm">
					<div class="module-path">
						<div class="module-path-content" align="center">
							添加认证类型属性规格
							<%-- <s:property value="%{getText('eaap.op2.conf.server.supplier.supplierInfor')}" />--%>
						</div>
					</div>
					<table class="mgr-table" id="cc2cinfo">
						<tr>
						<td class="item"><font color="red">*</font>认证属性规则名称</td>
						<td>
						<ui:inputText skin="${contextStyleTheme}"
									id="pr_attr_spec_name" textSize="30" name="pr_attr_spec_name" />
							</td>
							<td class="item"><font color="red">*</font>属性规格选取:</td>
							<input type="hidden" name="hidden_attr_spec_id"
								id="hidden_attr_spec_id">
							<td><ui:inputText skin="${contextStyleTheme}"
									id="attr_spec_name" textSize="30" readonly="true"
									name="attr_spec_name" /> <ui:button
									skin="${contextStyleTheme}"
									text="%{getText('eaap.op2.conf.manager.auth.choose')}"
									onclick="openWindows('${contextPath}/proofeffect/selectattr.shtml','Choose Attr_Spec')"
									shape="s"></ui:button></td>
							<td class="item"><font color="red">*</font> 认证类型选取:</td>
							<td><ui:select
										skin="${contextStyleTheme}" name="pt_cd" id="pt_cd"
										list="listProofType" width="157"
										listKey="PT_CD" listValue="PT_NAME"></ui:select></td>
						</tr>
						<tr>
						  <td colspan="6"  align="center">
						  <ui:button skin="${contextStyleTheme}"
									text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"
									id="checksubmitId"
									onclick="javascript:xx();"></ui:button>
						  </td>
						</tr>
						<%--<tr>
    		   <td  colspan="4"  align="center">
    			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" id="checksubmitId" onclick="javascript:xx();"></ui:button>
			   </td>	
    		  </tr> --%>
					</table>
				</ui:form>
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
        var attr_spec_id = $('#table').datagrid('getSelections')[0].PR_ATR_SPEC_CD+'';
        var attr_spec_name = $('#table').datagrid('getSelections')[0].PR_ATR_SPEC_NAME+'';
        var parent_attr_spec_id = vOpener.document.getElementById("hidden_pr_attr_spec_id");
        var parent_attr_spec_name = vOpener.document.getElementById("pr_attr_spec_name");
        $(parent_attr_spec_id).val(attr_spec_id);
        $(parent_attr_spec_name).val(attr_spec_name);
        art.dialog.close();
    }else{
    	art.dialog.alert('操作提示','请选择一条记录!');
    }
   }
 function xx(){
	 art.dialog.confirm('操作提示','你确定要添加这掉消息吗？', function () {
	    var ajax_data = $("#myForm").serialize();
	    	 $.ajax({
	          type:"post",
	          async:false,
	          url:"../proofeffect/addPrAttrValues.shtml",
	          dataType:"json",
	          data:ajax_data,
	          success:function(msg,data){
	        	  if(msg=="failure"){
			    	  art.dialog.tips('添加失败!');
			      }else{
			    	  art.dialog.tips('添加成功!');
			      }
	          $('#table').datagrid('reload');
	          $('#show_add_table').hide();
	          }
	        });
	},function(){
		
	});
 }
 function deleteMethod(index,field,value)
 {
	 var operationObj = $('#table').datagrid('getSelections')[0];
	 if(null != operationObj){
		 art.dialog.confirm('操作提示','你确定要添加这掉消息吗？', function () {
		 var pr_attr_spec_cd = $('#table').datagrid('getSelections')[0].PR_ATR_SPEC_CD ;
		 $.ajax({
	          type:"post",
	          async:false,
	          url:"../proofeffect/delPrAttrSpec.shtml",
	          dataType:"json",
	          data:{pr_attr_spec_cd:pr_attr_spec_cd},
	          success:function(msg,data){
	          if(msg=="failure"){
	        	  art.dialog.tips('删除失败!');
	          }else{
	        	  art.dialog.tips('删除成功!');
	          }
	          $('#table').datagrid('reload');
	        }
	        });
		 },function(){
			 
		 });
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
 function addMehtod(index,field,value)
 {
	   $("#hidden_attr_spec_id").val(null);
		  $("#attr_spec_name").val(null);
		  $("#pr_attr_spec_name").val(null);
		  $('#show_add_table').show();
 }
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
    </script>       
    <%@ include file="/common/ssoCommon.jsp"%>     	
</html>
