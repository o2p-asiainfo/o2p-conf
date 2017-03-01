<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
 <script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.reqorrsp')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.authobj')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.optype')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.manager.auth.opvalue')}" />'; 
title[4]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
</script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.manager.auth.serumanager')}"/>
       <img src="../resource/blue/images/module-path.png" />
        <s:property value="%{getText('eaap.op2.conf.manager.auth.seruserreg')}"/>
        <img src="../resource/blue/images/module-path.png" />
        <s:property value="%{getText('eaap.op2.conf.manager.auth.auth')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
	        <s:property value="%{getText('eaap.op2.conf.manager.auth.seruserinfo')}"/>
         </div>
    </div>
    <div>
          <input type="hidden" name="serInvokeIns.serInvokeInsId" id="mySerInvokeInsId" value="${serInvokeInsMap.SER_INVOKE_INS_ID}"/>
          <table align="center" class="mgr-table">
    		 <tr>
    		  <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}"/>:</td>
              <td>${serInvokeInsMap.SER_INVOKE_INS_NAME}
              </td>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sercode')}"/>:</td>
              <td>${serInvokeInsMap.SERNAME}
               </td>
            </tr>
            <tr>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</td>
              <td>
               ${serInvokeInsMap.ORGNAME}
              </td>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}"/>:</td>
              <td>
              ${serInvokeInsMap.COMPNAME}
              </td>
            </tr>
             <tr>
                <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
    				<td  colspan="3">
    					${serInvokeInsMap.SER_INVOKE_INS_DESC} 
    				</td>	
    			</tr>
    			<tr>
                    <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}"/>:</td>
    				<td  colspan="3" >
    					${serInvokeInsMap.MFNAME} 
    				</td>	
    		   </tr>
    		 </table>
    </div>
  
	 <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
         <s:property value="%{getText('eaap.op2.conf.manager.auth.auth')}"/>
         </div>
     </div>  
     <ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true" onClickCell="true"  id="authlist"  remoteSort="false" sortOrder="desc"  queryParams="true" queryParamsData="${serInvokeInsMap.SER_INVOKE_INS_ID}"
		fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true" toolbar="true"   method="eaap-op2-conf-manager-ConfManagerAction.getAuthListById">
		<ui:gridEasyColumn width="180" index="0" title="0" field="REQRSPNAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="380" index="1" title="1" field="AUTH_PATH" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="280" index="2" title="2" field="AUTHOPNAME" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="240"  index="3" title="3" field="ATTR_VALUE" hidden="false"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="40"  index="4" title="4" field="STATENAME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1"  index="5" title="5" field="ATTR_SPEC_ID" hidden="true"   align="center"></ui:gridEasyColumn>  
		<ui:gridEasyColumn width="1"  index="6" title="6" field="REQ_OR_RSP" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="7" title="7" field="AUTHOBJTYPE" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="8" title="8" field="AUTH_FORMULA" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="9" title="9" field="AUTH_OBJ_OP" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="10" title="10" field="STATE" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="11" title="11" field="AUTH_BASE_ID" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="12" title="12" field="AUTH_ID" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1"  index="13" title="13" field="AUTH_OBJ_ID" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1"  index="14" title="14" field="character" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1"  index="15" title="15" field="range" hidden="true"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1"  index="16" title="16" field="sublength" hidden="true"   align="center"></ui:gridEasyColumn> 
		<ui:gridEasyColumn width="1"  index="17" title="17" field="AUTHOBJTYPENAME" hidden="true"   align="center"></ui:gridEasyColumn> 
	 </ui:gridEasy>                               
	      
	 		 <ui:form id="myForm" name="myForm" action="insertAuthInfo.shtml" method="post"> 
	        <table class="mgr-table" id="authinfo"  style="display:none">
	         <input type="hidden" name="reqFrom" value="${reqFrom}"/>
	         <input type="hidden" name="authBase.serInvokeInsId"  id="abserInvokeInsId"  value="${serInvokeInsMap.SER_INVOKE_INS_ID}"/>
	         <input type="hidden" name="authBase.authBaseId"  id="abauthBaseId"  value=""/>
	         <input type="hidden" name="auth.authId"  id="authauthId"  value=""/>
	         <input type="hidden" name="authObj.authObjId"  id="authObjauthObjId"  value=""/>                                                                    
	         <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
	          
            <tr>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.authobj')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  id="aoauthPath" name="authObj.authPath"/> 
              </td>
              
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.reqorrsp')}"/>:</td>
              <td>
              <ui:select skin="${contextStyleTheme}"  id="authreqOrRsp" name="auth.reqOrRsp" list="reqOrRspList" listKey="rerpCode" listValue="rerpName" style="width:70px;" ></ui:select> 
              </td>                                                    
            </tr>
               <tr>
               <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.authobjtype')}"/>:</td>
              <td>
              <ui:select skin="${contextStyleTheme}"  id="authauthObjType" name="auth.authObjType" list="authObjTypeList" listKey="objTypeCode" listValue="objTypeName" style="width:70px;" ></ui:select> 
              </td> 
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.authformula')}"/>:</td>
              <td>
              <ui:inputText skin="${contextStyleTheme}"  id="authauthFormula" name="auth.authFormula"/> 
              </td>
             </tr>
            
             <tr>
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.optype')}"/>:</td>
              <td>
              <ui:select skin="${contextStyleTheme}"  id="authauthObjOp" name="auth.authObjOp" list="authObjOpList" listKey="opCode" listValue="opName" style="width:70px;" ></ui:select>
              </td>
              
              <td  align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.state')}"/>:</td>
              <td>
              <ui:select skin="${contextStyleTheme}"  id="authstate" name="auth.state" list="cc2cStatelist" listKey="stateCode" listValue="stateName" style="width:70px;" ></ui:select> 
              </td>                                                    
            </tr>
    		
    		<tr>
    		  <td  align="right" width="150"><font color="red">*</font>
                  <c:forEach var="atrrSpeBo" items="${atrrSpecList}" step="1"> 
	    		        <c:if test="${atrrSpeBo.attrSpecCode=='sublength'}">
	                          ${atrrSpeBo.attrSpecName}
	                     </c:if>
	    		   </c:forEach>
                :</td>
              <td>
                 <ui:inputText skin="${contextStyleTheme}"  id="sublength"     name="sublength"/>	 
                 <input type="hidden" id="myAttrSpecIds" name="myAttrSpecIds"  value="sublength,${atrrSpecMap['sublength']}"/>
              </td>
              
              
              <td  align="right" width="150"><font color="red">*</font>
                 <c:forEach var="atrrSpeBo" items="${atrrSpecList}" step="1"> 
	    		        <c:if test="${atrrSpeBo.attrSpecCode=='range'}">
	                          ${atrrSpeBo.attrSpecName}
	                     </c:if>
	    		   </c:forEach>  
                 :</td>
              <td><ui:inputText skin="${contextStyleTheme}"  id="range"    name="range"/>
              <input type="hidden" id="myAttrSpecIds" name="myAttrSpecIds"  value="range,${atrrSpecMap['range']}"/>
              </td>
             
            </tr>
            
            
            
    		<tr>
    		  <td  align="right" width="150"><font color="red">*</font>
                  <c:forEach var="atrrSpeBo" items="${atrrSpecList}" step="1"> 
	    		        <c:if test="${atrrSpeBo.attrSpecCode=='character'}">
	                          ${atrrSpeBo.attrSpecName}
	                     </c:if>
	    		   </c:forEach>   
                  :</td>
              <td>
                 <ui:inputText skin="${contextStyleTheme}"  id="character"    name="character"/> 
                 <input type="hidden" id="myAttrSpecIds" name="myAttrSpecIds"  value="character,${atrrSpecMap['character']}"/>
              </td>
              
              
              <td  align="right" width="150">
              </td>
              <td> 
              </td>
             
            </tr>
            
    			
              <tr>
    				<td  colspan="4"  align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}" id="checksubmitId"  shape="s" onclick="myForm.submit();"></ui:button>
				 	     
    				</td>	
    				
    				 
    			</tr>
    		 </table>
    		 <c:if test="${reqFrom!='fromMegFlowMgr'}">
    		 <table  class="mgr-table">
    		  <tr>
    				<td  colspan="4"  align="center">
 
						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.regOver')}" id="cancelId" onclick="location='${contextPath}/mgr/selectSerInvokeInsList.shtml'"></ui:button>
    				     
    				</td>	
    				
    				 
    			</tr>
    		 </table>
    		 </c:if>
 	</ui:form>   	 
</div>
 <ui:iframe  skin="${contextStyleTheme}"    iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc=""  frameborder="10" />
<script>
  
 function clickMethod(index,field,value)
 {
 
    if($('#authlist').datagrid('getSelections')[0]!=null)
    {
      var authBaseId = $('#authlist').datagrid('getSelections')[0].AUTH_BASE_ID ;
      if(authBaseId!=null&&authBaseId!='')
      {
          $("#abauthBaseId").val(authBaseId);
          $("#authauthId").val($('#authlist').datagrid('getSelections')[0].AUTH_ID);
          $("#authObjauthObjId").val($('#authlist').datagrid('getSelections')[0].AUTH_OBJ_ID);
          $("#aoauthPath").val($('#authlist').datagrid('getSelections')[0].AUTH_PATH);
          
          $("#authreqOrRsp").find('option[value=' + $('#authlist').datagrid('getSelections')[0].REQ_OR_RSP + ']').attr("selected",true);
          $('#authreqOrRsp[class=tag_select]').text($('#authreqOrRsp').find('option:selected').text());
          
          $("#authauthObjType").find('option[value=' + $('#authlist').datagrid('getSelections')[0].AUTHOBJTYPE + ']').attr("selected",true);
          $('#authauthObjType[class=tag_select]').text($('#authauthObjType').find('option:selected').text());
          
		  $("#authauthFormula").val($('#authlist').datagrid('getSelections')[0].AUTH_FORMULA);
		  
		  $("#authauthObjOp").find('option[value=' + $('#authlist').datagrid('getSelections')[0].AUTH_OBJ_OP + ']').attr("selected",true);
          $('#authauthObjOp[class=tag_select]').text($('#authauthObjOp').find('option:selected').text());
          
          $("#authstate").find('option[value=' + $('#authlist').datagrid('getSelections')[0].STATE + ']').attr("selected",true);
          $('#authstate[class=tag_select]').text($('#authstate').find('option:selected').text());

		  $("#range").val($('#authlist').datagrid('getSelections')[0].range);
		  $("#character").val($('#authlist').datagrid('getSelections')[0].character);
		  $("#sublength").val($('#authlist').datagrid('getSelections')[0].sublength);
  
  
		  $("#editOrAdd").val("edit");
		  $('#authinfo').show();
		  changeTopScrollHeight();
	  }
     }
 }   	
 
 	  
 	  
 	  
    function deleteMethod(){ 					
	   					
	 
		 if($('#authlist').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
				{
				  var authId = $('#authlist').datagrid('getSelections')[0].AUTH_ID ;
				   window.location="${contextPath}/mgr/insertAuthInfo.shtml?editOrAdd=edit&auth.state=R&auth.authId="+authId+"&authBase.serInvokeInsId="+$('#mySerInvokeInsId').attr('value');
				}
		 }
    		
     }
    		
    function addMehtod(){
 	      $("#aoauthPath").val(null);
		  $("#authreqOrRsp").val("REQ");
		  $("#authauthObjType").val("A");
		  $("#authauthFormula").val(null);
		  $("#authauthObjOp").val("A");
		  $("#authstate").val("A");
		  $("#range").val(null);
		  $("#character").val(null);
		  $("#sublength").val(null);
		  $("#editOrAdd").val("add");
		  
		  $('#authinfo').show();
		  changeTopScrollHeight();
    } 
              
   function updateMethod(){
	
        if($('#authlist').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else
		 {
		  var authBaseId = $('#authlist').datagrid('getSelections')[0].AUTH_BASE_ID ;
          $("#abauthBaseId").val(authBaseId);
          $("#authauthId").val($('#authlist').datagrid('getSelections')[0].AUTH_ID);
          $("#authObjauthObjId").val($('#authlist').datagrid('getSelections')[0].AUTH_OBJ_ID);
          $("#aoauthPath").val($('#authlist').datagrid('getSelections')[0].AUTH_PATH);
          $("#authreqOrRsp").find('option[value=' + $('#authlist').datagrid('getSelections')[0].REQ_OR_RSP + ']').attr("selected",true);
          $('#authreqOrRsp[class=tag_select]').text($('#authreqOrRsp').find('option:selected').text());
          $("#authauthObjType").find('option[value=' + $('#authlist').datagrid('getSelections')[0].AUTHOBJTYPE + ']').attr("selected",true);
          $('#authauthObjType[class=tag_select]').text($('#authauthObjType').find('option:selected').text());
		  $("#authauthFormula").val($('#authlist').datagrid('getSelections')[0].AUTH_FORMULA);
		  $("#authauthObjOp").find('option[value=' + $('#authlist').datagrid('getSelections')[0].AUTH_OBJ_OP + ']').attr("selected",true);
          $('#authauthObjOp[class=tag_select]').text($('#authauthObjOp').find('option:selected').text());
          $("#authstate").find('option[value=' + $('#authlist').datagrid('getSelections')[0].STATE + ']').attr("selected",true);
          $('#authstate[class=tag_select]').text($('#authstate').find('option:selected').text());
		  $("#range").val($('#authlist').datagrid('getSelections')[0].range);
		  $("#character").val($('#authlist').datagrid('getSelections')[0].character); 
		  $("#sublength").val($('#authlist').datagrid('getSelections')[0].sublength);
  
  
		  $("#editOrAdd").val("edit");
		  $('#authinfo').show();
		  changeTopScrollHeight();
	  }
   }
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
