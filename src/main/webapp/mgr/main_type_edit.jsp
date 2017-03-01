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
title[0]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatacode')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataname')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatavalue')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatadesc')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatastate')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.manager.auth.createtime')}" />';
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
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatemanger')}"/>
       <img src="../resource/blue/images/module-path.png" />
       <c:if test="${editOrAdd=='add'}">
        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeadd')}"/>
       </c:if>
       <c:if test="${editOrAdd=='edit'}">
        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeedit')}"/>
       </c:if>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
           <c:if test="${editOrAdd=='add'}">
	        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeadd')}"/>
	       </c:if>
	       <c:if test="${editOrAdd=='edit'}">
	        <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeedit')}"/>
	       </c:if>
         </div>
         
    </div>
    
    <div>
   
            
            <table align="center" class="mgr-table">
             <input type="hidden" id="myMdtCd"  name="mainDataType.mdtCd" value="${mainDataType.mdtCd}"/>
             
    		 <tr>
    		 
    		  <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypesign')}"/>:</td>
              <td>${mainDataType.mdtSign}
              </td>
              
              
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypename')}"/>:</td>
              <td>${mainDataType.mdtName}
               </td>
             
            </tr>
             
            <tr>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypedesc')}"/>:</td>
              <td colspan="3">
              ${mainDataType.mdtDesc }
              </td>
            </tr>
               
    		 </table>
    		 
        </div>
    
    <ui:gridEasy skin="${contextStyleTheme}" columns="cols" iconCls="icon-save" sortName="code" singleSelect="true"  id="mdlistid"  remoteSort="false" sortOrder="desc"  queryParams="true" onClickCell="true" toolbar="true" queryParamsData="${mainDataType.mdtCd}"
		fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true"   method="eaap-op2-conf-manager-ConfManagerAction.getMainDataListByTypeId">
		<ui:gridEasyColumn width="100" index="0" title="0" field="CEP_CODE" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="200" index="1" title="1" field="CEP_NAME" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="180" index="2" title="2" field="CEP_VALUES" hidden="false" align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="300" index="3" title="3" field="CEP_DES" hidden="false"    align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="80"  index="4" title="4" field="STATE" hidden="false"  formatter="true" formatterMethod="formatterForState"  align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="5" title="5" field="LASTEST_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="100" index="6" title="6" field="CREATE_TIME" hidden="false"   align="center"></ui:gridEasyColumn>
		<ui:gridEasyColumn width="1" index="7" title="7" field="MAIND_ID" hidden="true"   align="center"></ui:gridEasyColumn>
	  </ui:gridEasy>
		  
	
	
	  <ui:form id="myForm" name="myForm" action="insertMainData.shtml" method="post"> 
            <table align="center" class="mgr-table" id="myMaindata" style="display:none">
             <input type="hidden"  name="mainData.mdtCd" value="${mainDataType.mdtCd}"/>
             <input type="hidden" id="cmaindataid" name="mainData.maindId" value=""/>
             <input type="hidden" id="editOrAdd" name="editOrAdd" value=""/>
    		 <input type="hidden" id="showflag" name="showflag" value="${showflag}"/>
              <tr>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataname')}"/>:</td>
              <td>
                <ui:inputText skin="${contextStyleTheme}"  name="mainData.cepName" id="mycepName" value="${mainData.cepName}"></ui:inputText>
              </td>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatacode')}"/>:</td>
              <td><ui:inputText skin="${contextStyleTheme}"  name="mainData.cepCode" id="mycepCode" value="${mainData.cepCode}"></ui:inputText>
              </td>
            </tr>
            
            <tr>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatavalue')}"/>:</td>
              <td ><ui:inputText skin="${contextStyleTheme}"  name="mainData.cepValues" id="mycepValues" value="${mainData.cepValues}"></ui:inputText></td>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatastate')}"/>:</td>
              <td>
              <select id="mystate" name="mainData.state" >
                <c:forEach var="obj" items="${selectMainTypeStateList}">
                  <option value="${obj.mainTypeStateCode}">${obj.mainTypeStateName}</option>
                </c:forEach>
              </select>
              <%--<ui:select skin="${contextStyleTheme}"  id="mystate" name="mainData.state" list="selectMainTypeStateList" listKey="mainTypeStateCode" listValue="mainTypeStateName" style="width:70px;" ></ui:select> --%>
              </td>
            </tr>
             <tr>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatadesc')}"/>:</td>
              <td colspan="3">
               <ui:textarea skin="${contextStyleTheme}" name="mainData.cepDes" id="mycepDes"   value="${mainData.cepDes}" width="194" height="66"></ui:textarea></td>
            </tr>
              <tr>
    				 <td  colspan="4" class="item-content" align="center">
    					  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  shape="s" id="checksubmitId" onclick="myForm.submit();"></ui:button>
					 </td>	
    				
    				 
    			</tr>
    		 </table>
    		 <table  class="mgr-table">
    		  <tr>
    				<td  colspan="4"  align="center">
 
						  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="location='${contextPath}/mgr/showMainDataTypeList.shtml'"></ui:button>
    				     
    				</td>	
    				
    				 
    			</tr>
    		 </table>
    	</ui:form>
			   
	 <ui:iframe  skin="${contextStyleTheme}"   iframeWidth="896" iframeHeight="450" iframeScrolling="auto" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" frameborder="10" />
</div>
<script>
 $(function(){
	 var flag_value = $('#showflag').val();
	 if('detail' == flag_value){
		 $('.datagrid-btn-separator').remove();
		 $('#btnadd').remove();
		 $('#btncut').remove();
		 $('#btnsave').remove();
	 }
 });
function clickMethod(index,field,value)
 {
    if($('#mdlistid').datagrid('getSelections')[0]!=null)
    {
      var maindataid = $('#mdlistid').datagrid('getSelections')[0].MAIND_ID ;
      if(maindataid!=null&&maindataid!='')
      {
          $("#cmaindataid").val(maindataid);
          $("#mycepName").val($('#mdlistid').datagrid('getSelections')[0].CEP_NAME);
          $("#mycepCode").val($('#mdlistid').datagrid('getSelections')[0].CEP_CODE);
          $("#mycepValues").val($('#mdlistid').datagrid('getSelections')[0].CEP_VALUES);
		  $("#mycepDes").val($('#mdlistid').datagrid('getSelections')[0].CEP_DES);
		  $("#mystate").val($('#mdlistid').datagrid('getSelections')[0].STATE);
		 
  
		  $("#editOrAdd").val("edit");
		  $('#myMaindata').show();
	  }
     }
 }   	
   function deleteMethod(){ 					
	   					
	 
		 if($('#mdlistid').datagrid('getSelections')[0]==null)
		 {
		   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
		 }else{
			  if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
				{
				  var maindataid = $('#mdlistid').datagrid('getSelections')[0].MAIND_ID ;
				   window.location="${contextPath}/mgr/insertMainData.shtml?editOrAdd=edit&mainData.state=R&mainData.maindId="+maindataid+"&mainData.mdtCd="+$('#myMdtCd').attr('value');
				}
		 }
    		
     }
    		
    function addMehtod(){
 	     
          $("#mycepName").val(null);
          $("#mycepCode").val(null);
          $("#mycepValues").val(null);
		  $("#mycepDes").val(null);
		  $("#mystate").val(null);
		  $("#editOrAdd").val("add");
		  
		  $('#myMaindata').show();
		  changeTopScrollHeight();
    } 
              
   function updateMethod(){
	if($('#mdlistid').datagrid('getSelections')[0]!=null)
    {
      var maindataid = $('#mdlistid').datagrid('getSelections')[0].MAIND_ID ;
      if(maindataid!=null&&maindataid!='')
      {
          $("#cmaindataid").val(maindataid);
          $("#mycepName").val($('#mdlistid').datagrid('getSelections')[0].CEP_NAME);
          $("#mycepCode").val($('#mdlistid').datagrid('getSelections')[0].CEP_CODE);
          $("#mycepValues").val($('#mdlistid').datagrid('getSelections')[0].CEP_VALUES);
		  $("#mycepDes").val($('#mdlistid').datagrid('getSelections')[0].CEP_DES);
		  $("#mystate").val($('#mdlistid').datagrid('getSelections')[0].STATE);
		  $("#editOrAdd").val("edit");
		  $('#myMaindata').show();
		  changeTopScrollHeight();
	  }
     }else
     {
       alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
     }
    }
    
   function formatterForState(value,row,index){
    if(value=='A'){
      return "<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateA')}" />"  ;
    }else if(value=='R'){
      return "<s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateR')}" />"  ;
    } 
   
 }
 
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
