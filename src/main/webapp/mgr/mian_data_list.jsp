<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/blue/css/console.css" />
 
 
 
</head>
<body>
 
	
<div class="contentWarp">
  	  	<div class="module-path">
  		<div class="module-path-content">
      <img src="../resource/blue/images/search.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
      <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatemanger')}"/>
       <img src="../resource/blue/images/module-path.png" />
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatelist')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text" style="TEXT-ALIGN: center;">
    	 
    	 <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatatypeinfo')}"/>
          </div>
     </div>
    <table class="list-table" cellpadding="1"   cellspacing="0">
    <tr>
       <td width="20%" align="right"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypesign')}"/>:</td>
       <td width="20%" align="left">${mainDataType.mdtCd}</td>
       <td width="20%" align="right"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypename')}"/>:</td>
       <td width="20%" align="left">${mainDataType.mdtName}</td>
    </tr>
    <tr>
       <td align="right"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypedesc')}"/>:</td>
       <td colspan="3" align="left" style="HEIGHT: 66px" >
       <c:choose>  
           <c:when test="${mainDataType.mdtDesc==''||mainDataType.mdtDesc==null}">  
	         <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatadesc')}"/>......
	       </c:when>
		    <c:when test="${fn:length(mainDataType.mdtDesc)>50}">  
		        ${fn:substring(mainDataType.mdtDesc, 0, 50)}......
		    </c:when>  
		   <c:otherwise>  
		     ${mainDataType.mdtDesc}
		    </c:otherwise>  
		</c:choose>   
       </td>
    </tr>
    
    </table>
    <div>
    <ui:form id="myForm" name="myForm" action="insertOrgInfo.shtml" method="post"> 
               <table class="list-table" cellpadding="1" cellspacing="0">
					<tr class="tab-header">
					<td class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.dosomtthing')}"/></td>
    				<td class="middle" width="10%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindataname')}"/></td>	
    				<td class="middle" width="5%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatacode')}"/></td>	
    				<td class="middle" width="5%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatavalue')}"/></td>
    				<td class="middle" width="45%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatadesc')}"/></td>
    				<td class="middle" width="5%"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatastate')}"/></td>	
    				
    			</tr>
    			
    			 <c:forEach var="mainData" items="${mainDataList}" step="1"> 
					               <tr class="even">
					               <td align="center">
					                <input type="radio" name="mymaindid" value="${mainData.maindId}" />
					               </td>  
					              <td align="center">${mainData.cepName}</td>
					              <td align="center">${mainData.cepCode}</td>
					              <td align="center">${mainData.cepValues}</td>
					              <td align="center" title='${mainData.cepDes }'>
					              <c:choose>  
					                    <c:when test="${mainData.cepDes==''||mainData.cepDes==null}">  
									       <s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatadesc')}"/>......
									    </c:when>
									    <c:when test="${fn:length(mainData.cepDes)>50}">  
									        ${fn:substring(mainData.cepDes, 0, 50)}......
									    </c:when>  
									   <c:otherwise>  
									     ${mainData.cepDes}
									    </c:otherwise>  
									</c:choose>   
					              
					              </td>  
					              <td align="center">
                                   <c:if test="${mainData.state=='A' }"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateA')}"/></c:if>
                                   <c:if test="${mainData.state=='R' }"><s:property value="%{getText('eaap.op2.conf.orgregauditing.maindatetypestateR')}"/></c:if>
                                   </td>
					              
				 </tr>
			    </c:forEach>
			     </table> 
				                 <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.maindataadd')}"  onclick="location='${contextPath}/mgr/preAddMainData.shtml?mainDataType.mdtCd=${mainDataType.mdtCd}'"></ui:button>
			                  
                                 <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.update')}"   onclick="toeditmaintype()"></ui:button>   
				                  
				                 <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.delete')}"   onclick="todeletemaintype()"></ui:button>   
			               <div align="center">        
    					    <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"   onclick="location='${contextPath}/mgr/showMainDataTypeList.shtml'"></ui:button>   
			              </div>
    				
    				 
    		 
            
    	</ui:form>
    		
    </div>
</div>
 <form name="domaindataForm" method="post"   action="">
					 <input  type="hidden"  id="maindid"     name="mainData.maindId"/>
					 <input  type="hidden"  id="maindstate"  name="mainData.state"/> 
					 <input  type="hidden"   name="mainDataType.mdtCd" value="${mainDataType.mdtCd}" /> 
					 <input  type="hidden"  id="editOrAdd"  name="editOrAdd"/> 
 </form>

<!--body end --> 

</body>
 <script>
 
function toeditmaintype()
{
 if(getRadioValue()=="")
 {
 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
 }else{
    
	    $("#maindid").val(getRadioValue()) ;
		$("#editOrAdd").val('edit') ;
		domaindataForm.action="${contextPath}/mgr/preAddMainData.shtml" ;
		domaindataForm.submit();
	  
 }
}


function showmaindatalist()
{
 if(getRadioValue()=="")
 {
 alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
 }else
 { 
  $("#maintypeid").val(getRadioValue()) ;
  domaindataForm.action="${contextPath}/mgr/queryMainDataListByTypeId.shtml" ;
  domaindataForm.submit();
 }

}
function  todeletemaintype()
{
 if(getRadioValue()=="")
 {
   alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
 }else{
    if(confirm("<s:property value="%{getText('eaap.op2.conf.orgregauditing.suredelete')}" />"))
		{
		 $("#maindid").val(getRadioValue()) ;
		 $("#maindstate").val('R') ;
		 domaindataForm.action="${contextPath}/mgr/updateMainData.shtml" ;
		 domaindataForm.submit();
	 }
  }
}

function getRadioValue()
{
 var mymdtcd=document.getElementsByName("mymaindid");   
 var strNew="";   
 for(var i=0;i<mymdtcd.length;i++)   
 {     
    if(mymdtcd[i].checked){    
    strNew=mymdtcd[i].value;    
    break; 
 }
}
 return strNew ;
}
</script>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
