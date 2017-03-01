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
		   title[5]='<s:property value="%{getText('eaap.op2.conf.proof.Operation')}" />';
		   title[4]='<s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />';
		  
</script>
<body> 
	<!--  
	<div id="compWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionSelect')}" />" style="width:650px;height:500px;padding:5px;">
    </div>-->
<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	    <img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.proof.CertificationManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.proof.Addingauthenticationtype')}" />
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
					<s:property value="%{getText('eaap.op2.conf.proof.proofeId')}" />:
				</dt>
				<dd style="width:260px;">
				  	<ui:inputText  skin="${contextStyleTheme}" name="prooffId" id="prooffId"  textSize="25" style="float:left;"></ui:inputText>
				</dd>
		</dl>
	
       <dl>
        	<dt><s:property value="%{getText('eaap.op2.conf.proof.pt_name')}" />:</dt>
			<dd>
			  <ui:select skin="${contextStyleTheme}" name="proofType.pt_cd" id="pt_cd" list="listProofType" width="157"  emptyOption="true" headerValue=" "	 listKey="PT_CD" listValue="PT_NAME"></ui:select>
	  	    </dd>
	  </dl>
	     <dl>
    				<dt><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}" />:</dt>
    				<dd >
    				    <ui:inputText skin="${contextStyleTheme}"  id="myComponentName" name="myComponentName" readonly="true" style="float:left;"/>
    				    <input class="inputClearBtn" onclick="javascript:cleardata('myComponentName','myComponentId');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
    				    <input type="hidden" id="myComponentId" name="componentId"/>                                   
			     		<ui:button  skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=myComponentName&chooseCompCode=myComponentId','Choose Component')" shape="s"></ui:button>
					</dd>	
    		</dl>
   	<div style="text-align:right;float:right; margin-bottom:5px ;">
			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.query')}" id="chaxun" onclick="searchFunc();"/>
	 </div>
</form>
</div>
<div style=" clear:both;">
	<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true"  id="table"  pageInfo="true" sortOrder="desc" 
		fit="true" collapsible="false"   title="" striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true" method="eaap-op2-conf-proofeffect-ProofEffectAction.showProofEffectGrid">
		<ui:gridEasyColumn width="100" index="0" title="0" field="PROOFE_ID" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="4" title="4" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="1" title="1" field="PT_CD" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="2" title="2" field="PT_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="3" title="3" field="CREATE_TIME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="5" title="5" field="operator" hidden="false" align="center" formatter="true" formatterMethod="fomatComm"></ui:gridEasyColumn>
	</ui:gridEasy>
</div>
</div>

<table class="mgr-table" style="display:none" id="confirm" >
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
    		
    		
    	
       function deleteMethod(){
            var rows = $('#table').datagrid('getSelections');
            if(rows.length==0){
            	art.dialog.alert('操作提示','请选择一条记录!');
	        return false; 
            } 
            art.dialog.confirm('操作提示','你确定要删除这条记录吗？', function () {
            var proofe_id = rows[0].PROOFE_ID;
            $.ajax({
            type:"post",
            async:false,
            url:"../proofeffect/delProofEffect.shtml",
            dataType:"json",
            data:{proofe_id:proofe_id},
            success:function(msg,data){
            if(msg=="failure"){
            	art.dialog.tips('删除失败!');
            }else{
            	art.dialog.tips('删除成功!');
            }
            $('#table').datagrid('reload');
        }
        });
            },function(){});
        }
    		
    		  function addMehtod(){
    		  window.location.href="../proofeffect/addProofEffect.shtml"; 
              }
    		  /*function updateMethod(){
              var rows=$('#table').datagrid('getSelections');
              if(rows.length==0)
			    {
				   $.messager.alert("<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlert')}" />","<s:property value="%{getText('eaap.op2.conf.server.manager.serviceAlertUpdate')}" />");
		           return false;  
				}else
				{ 
				   var ser_tech_impl_id = rows[0].SER_TECH_IMPL_ID;
				  window.location.href="../serviceManager/showSupRegUpdate.shtml?serTechImplId="+ser_tech_impl_id;      
				}
              
              }*/
           
		    
		  function searchFunc() {
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
					  if(value=='A'){
					   return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnable')}" />"
					   }    
					
    		  }
    	   var checkout = "<s:property value="%{getText('eaap.op2.conf.proof.checkout')}" />";
    	  function	fomatComm(value,row,index){
    		  return "<a href='javascript:showMessage("+row.PROOFE_ID+","+row.PT_CD+");'>"+checkout+"</a>";
    		  }
    	function showMessage(prooffId,pt_cd){
    		window.location.href="../proofeffect/show_ProofEffectPage.shtml?pt_cd="+pt_cd+"&prooffId="+prooffId;
    	}
    var operationTip = "<s:property value="%{getText('eaap.op2.conf.proof.OperationTips')}" />";
    var havedo = "<s:property value="%{getText('eaap.op2.conf.proof.havedo')}" />";
    function chooseSerTechImplId()
   { 
    var vOpener=art.dialog.opener;
    var proofe_id = $('#table').datagrid('getSelections')[0].PROOFE_ID+'';
    var pt_cd = $('#table').datagrid('getSelections')[0].PT_CD+'';
    var page_type = vOpener.document.getElementById("page"+pt_cd);
    var page_type_value = $(page_type).val();
    if(typeof(page_type_value) != "undefined"){
    	art.dialog.alert(operationTip,havedo);
    	return false;
    }
    $.ajax({
        type:"post",
        async:false,
        url:"../proofeffect/showSelectedMes.shtml",
        dataType:"json",
        data:{proofe_id:proofe_id,pt_cd:pt_cd},
        success:function(msg,data){
        var innerHtml = msg[0].data;
        var show_attr_value_table = vOpener.document.getElementById("show_attr_value_table");
        $(show_attr_value_table).after(innerHtml);
        vOpener.changeTopScrollHeight();
    }
    });
    /*var htmlValue = "<tr><td style='width:15%'>"+"<s:property value="%{getText('eaap.op2.conf.contract.doc.technologyImplName')}" />:"
    +"</td><td style='width:85%' colspan='5'><div id='tec_TechnologyImplName'><input type='text' id='' name='' style='width:80%;' value='"+TECH_IMPL_NAME+"' readOnly='true' disabled='true'>"
    +" <input type='button' id='newEvent' value='查看详情'"
	+" onclick=\"jumpPage("+chooseSerTechImplId+");\" style='width:10%;'/></div>";
    +"</td></tr>";

    var inputValue = "<div id='tec_TechnologyImplName'><input type='text' id='tec_TechnologyImplName' name='' style='width:80%;' value='"+TECH_IMPL_NAME+"' readOnly='true' disabled='true'>"
    +" <input type='button' id='newEvent' value='查看详情'"
	+" onclick=\"jumpPage("+chooseSerTechImplId+");\" style='width:10%;'/></div>";
    art.dialog.opener.editDynamicAttrFromSpecPage(document.getElementById("attrName").value,chooseSerTechImplId,
    document.getElementById("objectId").value,
    document.getElementById("endpoint_Spec_Attr_Id").value);
    var tec_name = vOpener.document.getElementById("tec_TechnologyImplName");
    if(null != tec_name){
    	$(tec_name).replaceWith(inputValue); 
    }else{
    	$(vOpener.document.getElementById("endpoint_Atr_ValueTable")).append(htmlValue);
    }*/
   //parent.closeSelectValueSpecWin(); 
    	art.dialog.close();
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
