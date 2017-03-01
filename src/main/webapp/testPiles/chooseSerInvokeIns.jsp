<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<html>
<head>
	<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
    <s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
    <s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
</head>
<body>
<!--body start -->

	<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	  		    <img src="${contextPath}/resource/${contextStyleTheme}/images/search.png" /><s:property value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
		    	<img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" /><s:property value="%{getText('eaap.op2.conf.techimpl.title')}" />
	     	</div>
	    </div>
	    <div class="accordion-header" >
	    	<div class="accordion-header-text">
	    		<span><span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
	    	</div>
    	</div>
	  
	   <div id="queryBlock">    
	<div class="selectList" style="display:block;">
	<ui:form method="post" id="myform" name="myform" >
	 	<input id="ChoooseTechImplId" name="ChoooseTechImplId" type="hidden" value="${techImplId}" />
	 	<input id="ChooseTechImplName" name="ChooseTechImplName" type="hidden" value="${techImplName}" />
	 	<input name="choosePageState" id="choosePageState" type="hidden" value="${pageState}" />
	    <dl class="noBorder">
	    </dl>
		<dl class="noBorder">
			<dt><s:property value="%{getText('eaap.op2.conf.techimpl.orgName')}" />:</dt>
    		<dd style="width:210px;">
			  	<input type="hidden" name="orgId" id="orgId" value="" />
                <ui:inputText skin="${contextStyleTheme}" name="orgName" id="orgName"  textSize="18" readonly="true" style="float:left;"></ui:inputText>
                <input class="inputClearBtn" onclick="javascript:cleardata('orgId','orgName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
			    <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/mgr/chooseOrgInfo.shtml?chooseOrgName=orgName&&chooseOrgCode=orgId','Choose Org')" shape="s"></ui:button>
			</db>
			<dt><s:property value="%{getText('eaap.op2.conf.techimpl.component')}" />:</dt>
    		<dd style="width:210px;">
			  <input type="hidden" name="componentCode" id="componentCode" value="" />
			  <ui:inputText skin="${contextStyleTheme}" name="componentName" id="componentName"  textSize="18" readonly="true" style="float:left;"></ui:inputText>
	  		  <input class="inputClearBtn" onclick="javascript:cleardata('componentCode','componentName');" title="<s:property value="%{getText('eaap.op2.conf.manager.auth.clear')}"/>"  type="button"/>
			  <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.manager.auth.choose')}" onclick="openWindows('${contextPath}/component/chooseCompInfo.shtml?chooseCompName=componentName&&chooseCompCode=componentCode','Choose Component')" shape="s"></ui:button>
			</db>
			<dd>
			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.techimpl.queryBtn')}" onclick="searchFunc();" ></ui:button>
			</db>
		</dl>
	   <!-- show record area -->
	   <dl class="noBorder">
	 <script type="text/javascript">
		var title = [];
		   title[0]='<s:property value="%{getText('eaap.op2.conf.techimpl.techImplName')}" />';
		   title[1]='<s:property value="%{getText('eaap.op2.conf.server.supplier.componentCode')}" />';
		   title[2]='<s:property value="%{getText('eaap.op2.conf.server.supplier.componentName')}" />';
		   title[3]='<s:property value="%{getText('eaap.op2.conf.server.supplier.CommunicationProtocol')}" />';
		   title[4]='<s:property value="%{getText('eaap.op2.conf.server.supplier.state')}" />';
		   title[5]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamName')}" />';
		   title[6]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceReturnParamName')}" />';
		   title[7]='<s:property value="%{getText('eaap.op2.conf.techimpl.callUrl')}" />';
		   title[8]='<s:property value="%{getText('eaap.op2.conf.techimpl.overtime')}" />';
		   title[9]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceParamNameSpace')}" />';
		   title[10]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />';
		   title[11]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />';
		   title[12]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />';
		   title[13]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />';
		   title[14]='<s:property value="%{getText('eaap.op2.conf.techimpl.webserviceMethodName')}" />';
         </script>
<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code" skin="${contextStyleTheme}" singleSelect="true" pageInfo="true" id="table"  sortOrder="desc" 
fit="true" collapsible="false"   title=""  striped="true" pageList="10" pagination="true" frozenColumns="true" rownumbers="true"  fitHeight="309"  method="eaap-op2-conf-techimpl-TechImplAction.showServiceSupRegisterGrid">
<ui:gridEasyColumn width="100" index="0" title="0" field="TECH_IMPL_NAME" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="1" title="1" field="CODE" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="2" title="2" field="NAME" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="3" title="3" field="COMM_PRO_CD" hidden="false" align="center" formatter="true" formatterMethod="fomatComm"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="4" title="4" field="USEALBE_STATE" hidden="false" align="center" formatter="true" formatterMethod="fomat"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="5" title="5" field="webserviceParamName" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="6" title="6" field="webserviceReturnParamName" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="7" title="7" field="callUrl" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="8" title="8" field="overtime" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="9" title="9" field="webserviceParamNameSpace" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="10" title="10" field="webserviceMethodName" hidden="false" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="11" title="11" field="ORGNAME" hidden="true" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="12" title="12" field="ORG_ID" hidden="true" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="13" title="13" field="tech_impl_id" hidden="true" align="center"></ui:gridEasyColumn>
<ui:gridEasyColumn width="100" index="14" title="14" field="COMPONENT_ID" hidden="true" align="center"></ui:gridEasyColumn>

</ui:gridEasy> 
</dl>
  <table class="mgr-table" style="" id="confirm">
   <tr>
     <td  colspan="4"  align="center">    
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.server.supplier.next')}"  onclick="chooseSerII();"></ui:button>
        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"  onclick="art.dialog.close();"></ui:button>
     </td>	
     </tr>
  </table>
</ui:form>
</div>
</div>
</div>
<!-- open window -->
<ui:iframe  skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
</body>
<!--body end --> 
<script type="text/javascript">
function fomat(value,row,index){
 	 if(value=='R'){
	   		return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceDisable')}" />"
	 }
	 if(value=='A'){
	   		return "<s:property value="%{getText('eaap.op2.conf.server.manager.serviceEnable')}" />"
	 }
}
    		  
function searchFunc() {
 	var form = $("#myform").form();
    $('#table').datagrid("load", sy.serializeObject(form));
}		
          
function	fomatComm(value,row,index){
	 if(value=='1'){
	 	return "http-get"
	 }
	 if(value=='2'){
	 	return "http-post"
	 }    
	 if(value=='3'){
	 	return "http-get-post"
	 }
	 if(value=='4'){
	 	return "sftp"
	 }
	 if(value=='5'){
	 	return "ftp"
	 }
	 if(value=='6'){
	 	return "webservice"
	 }
}

function chooseSerII() {
           var vOpener=art.dialog.opener; 
           var choooseTechImplId = $('#table').datagrid('getSelections')[0].TECH_IMPL_ID ;
           var chooseTechImplName = $('#table').datagrid('getSelections')[0].TECH_IMPL_NAME ;

          if(choooseTechImplId==""){
           		alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
          }else{
	          if($("#ChoooseTechImplId").attr('value')!=""){
		      		vOpener.document.getElementById($("#ChoooseTechImplId").attr('value')).value=choooseTechImplId;
		      }
		      if($("#ChooseTechImplName").attr('value')!="") {
		      		vOpener.document.getElementById($("#ChooseTechImplName").attr('value')).value=chooseTechImplName;
		      }
	          art.dialog.close(); 
	          parent.reload();
	    }
}  

$(document).ready(function(){
      var  choosePageState=$("#choosePageState").attr('value');
      if(choosePageState!="") {
      		document.getElementById("confirm").style.display= ""; 
     }
})

function cleardata(str1,str2){
	$("#"+str1).val(null);
	$("#"+str2).val(null);
}
</script>

</html>
