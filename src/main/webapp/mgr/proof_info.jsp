<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
</head>
<style>
.itemCss{background-color:#F9F9F9;}
</style>
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
        <s:property value="%{getText('eaap.op2.conf.manager.auth.proof')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
             <s:property value="%{getText('eaap.op2.conf.manager.auth.seruserinfo')}"/>
	     </div>
         
    </div>
    
    <div>
    <ui:form id="myForm" name="myForm" action="insertProof.shtml" method="post"> 
             <input type="hidden" name="serInvokeIns.serInvokeInsId" value="${serInvokeInsMap.SER_INVOKE_INS_ID}"/>
             <input type="hidden" name="reqFrom" value="${reqFrom}"/>
             
             <table align="center" class="mgr-table">
    		 <tr>
    		  <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.serinvokeinsname')}"/>:</td>
              <td>${serInvokeInsMap.SER_INVOKE_INS_NAME}
              </td>
              
              
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sercode')}"/>:</td>
              <td>${serInvokeInsMap.SERNAME}
               </td>
             </tr>
             
            <tr>
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.orgName')}"/>:</td>
              <td>
               ${serInvokeInsMap.ORGNAME}
              </td>
              
              <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.compregauditing.forcomName')}"/>:</td>
              <td>
              ${serInvokeInsMap.COMPNAME}
              </td>
            </tr>
             <tr>
                <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.orgdesc')}"/>:</td>
    				<td  colspan="3">
    					${serInvokeInsMap.SER_INVOKE_INS_DESC} 
    				</td>	
    			</tr>
    			
    			<tr>
                    <td align="right" width="150"><font color="red">*</font><s:property value="%{getText('eaap.op2.conf.manager.auth.sermessflow')}"/>:</td>
    				<td  colspan="3" >
    					${serInvokeInsMap.MFNAME} 
    				</td>	
    		   </tr>
    		 </table>
    		 
  			 <div class="accordion-header" >
			    	<div class="accordion-header-text">
			    	<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			         <s:property value="%{getText('eaap.op2.conf.manager.auth.proof')}"/>
			         </div>
		     </div>  
    		 <table align="center" class="mgr-table">
	    		 <tr>
	    		     <td>
	    		     
			    		  <div class="accordion-header-text">
						         <div style="float:left;"><s:property value="%{getText('eaap.op2.conf.process.authCondition')}"/></div>
						         <div style="float:left; margin-left:20px;">
								        <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.proof.addeffect')}" id="" onclick="javascript:toProofPage();"  shape="s"></ui:button>
						         </div>
				         </div>
			    		 <table align="center" class="mgr-table" >
					    		 <s:iterator value="proofList" id="prooef" status="status">
					    		    <tr id="del${prooef.PROOFE_ID}"  class="itemCss">
					    		      <td  colspan='4'>
					    		      <input type='hidden' name='page_proofe_id' value="${prooef.PROOFE_ID}"/>
					    		      <input type='hidden' name='page_type' id='page${prooef.PT_CD }' value='${prooef.PROOFE_ID}'/>
					    		      <input type='hidden' name='page_code'  id='page_code'  value="${prooef.PT_CODE}"/>
					    		      <B>${prooef.PT_NAME}</B>
					    		      &nbsp;&nbsp;&nbsp;<a href='javascript:delSelf("${prooef.PROOFE_ID}");'   title="Delete"><img src='../resource/orange/images/tmp/3g_style_2_pop_1_03.gif' width='14' height='14'  align="absmiddle"/></a>
					    		       </td>
					    		    </tr>
					    		    <c:set var="proofe_id" value="${prooef.PROOFE_ID}" scope="request"/>
					    		    <c:set var="pt_cd" value="${prooef.PT_CD}" scope="request"/>
					    		    <s:iterator value="%{getActionAttrValue(#request.proofe_id,#request.pt_cd)}" id="pageAttrValue" status="sunstatus">
					    		       <tr id="del${prooef.PROOFE_ID}">
					    		          <td align='right' width='150'>${pageAttrValue.PR_ATR_SPEC_NAME}:</td>
					    		          <td  colspan='3'>
					    		          <s:if test="#pageAttrValue.DISPLAY_TYPE == '10' ">
					    		             <label>${pageAttrValue.ATTR_VALUE}</label>
					    		          </s:if>
					    		          <s:if test="#pageAttrValue.DISPLAY_TYPE == '12' ">
					    		             <label>******</label>
					    		          </s:if>
					    		          <s:elseif test="#pageAttrValue.DISPLAY_TYPE == '11' ">
					    		             <ui:select skin="${contextStyleTheme}" name="attrValues" id="selectMenuIdss" disabled="true"  value="${pageAttrValue.ATTR_VALUE}"
					    			      list="attrValuesList" listKey="ATTR_VALUE" listValue="ATTR_VALUE_NAME" params="ATTR_SPEC_ID:${pageAttrValue.ATTR_SPEC_ID}"></ui:select>
					    		          </s:elseif>
					    		          <s:elseif test="#pageAttrValue.DISPLAY_TYPE == '15' ">
					    		             <label>${pageAttrValue.ATTR_VALUE}</label>
					    		          </s:elseif>
					    		          </td>
					    		       </tr>
					    		    </s:iterator>
					    		 </s:iterator>
			    		 		 <tr id="show_attr_value_table"  style="display:none;"><td></td><td colspan="3"></td></tr>
			    		  </table>
			    		  
			    		  <div class="accordion-header-text">
						        <s:property value="%{getText('eaap.op2.conf.process.authExpressions')}"/>
				         </div>
			    		 <table align="center" class="mgr-table">
					    		 <tr id="show_attr_value_table">
					    		     <td align="right" width="150"><s:property value="%{getText('eaap.op2.conf.process.authExpressions')}"/></td>
					    		     <td  colspan="3">
											<ui:inputText skin="${contextStyleTheme}"  id="authExpress" name="serInvokeIns.authExpress"  value="${serInvokeInsMap.AUTH_EXPRESS}" style="width:60%"  readonly="true" />
											<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.process.configuration')}" id="" onclick="javascript:authExpressConfig();"  shape="s"></ui:button>
					    		     </td>
					    		 </tr>
			    		  </table>
				    		  
    		          </td>
    		       </tr>
    		  </table>
    		  
    		 <table align="center" class="mgr-table">
    		   <tr>
    				 <td  colspan="4"  align="center">
    				     <c:choose>
				                <c:when test="${reqFrom!=null and reqFrom=='fromMegFlowMgr'}">
				                      <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.sure')}" id="checksubmitId" onclick="myForm.submit();"></ui:button>
				                </c:when>
				                <c:otherwise>
				                      <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.next')}" id="checksubmitId" onclick="myForm.submit();"></ui:button>
									  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.return')}" id="cancelId" onclick="history.go(-1);"></ui:button>
			    				      <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.manager.auth.ignore')}" id="returnid" onclick="location='${contextPath}/mgr/showCC2C.shtml?serInvokeIns.serInvokeInsId=${serInvokeInsMap.SER_INVOKE_INS_ID}'"></ui:button>
								</c:otherwise>
			              </c:choose>
    				</td>	
    			 </tr>
    		  </table>
    	</ui:form>
    </div>
</div>
<script>
function nextSubmit(){
	var inputAll = $(":input");
  	if(inputAll.length >0){
  		var hasNull = false;
  		var nullObj;
  		for(var i=0; inputAll.length>i; i++){
  			var inputObj = inputAll[i];
  			if(inputObj.type=="text" && inputObj.value==""){
  				hasNull = true;
  				nullObj = inputObj;
  				break;
  			}
  		}
  		if(hasNull){
  			alert("<s:property value="%{getText('eaap.op2.conf.manager.auth.notNull')}"/>");
  			nullObj.focus();
			return;	
  		}
	}

	var textareaAll = document.getElementsByTagName("textarea");
  	if(textareaAll.length >0){
  		var hasNull = false;
  		var nullObj;
  		for(var i=0; textareaAll.length>i; i++){
  			var textareaObj = textareaAll[i];
  			if(textareaObj.value==""){
  				hasNull = true;
  				nullObj = textareaObj;
  				break;
  			}
  		}
  		if(hasNull){
  			alert("<s:property value="%{getText('eaap.op2.conf.manager.auth.notNull')}"/>");
  			nullObj.focus();
			return;	
  		}
	}
	
	$("#myForm").submit();
}

function toaddoredit()
{
  if($("#editOrAdd").val()!=null && $("#editOrAdd").val()=='edit')
  {
   myForm.action="insertMainDataType.shtml" ;
  }else
  {
  myForm.action="insertMainDataType.shtml" ;
  }
  
  myForm.submit();

}
function toProofPage(){
	var title= "<s:property value="%{getText('eaap.op2.conf.proof.rules')}"/>";
	openWindows('${contextPath}/proofeffect/showProofEffect.shtml?flag='+123,title);
}
function delSelf(value){
	   $('#del'+value).nextAll('#del'+value).replaceWith("");
	   $('#del'+value).replaceWith(""); 
	   changeTopScrollHeight();
}

function openWindows(url,title,width,height){
	art.dialog.open(url,{
		lock: false,
		title:title,
		background: '#000',
		window:'top',
		top:50,
		width:width==null?1210:width,
		height:height==null?500:height,
		resize:true,
		drag:true
	});
}

function authExpressConfig(){
	openWindows_lock("${contextPath}/mgr/authExpressConfig.shtml","<s:property value="%{getText('eaap.op2.conf.process.authExpConfiguration')}"/>",650,230,true);
}

function openWindows_lock(url,title,width,height,lockType){
	art.dialog.open(url,{
		lock: lockType==true?true:false,
		title:title,
		background: '#000',
		window:'top',
		top:50,
		width:width==null?1210:width,
		height:height==null?500:height,
		resize:true,
		drag:true
	});
}
function setObjValue(objId,val){
	$("#"+objId).val(val);
}
function addAuthExpressVal(ptCode){
	var authExpress = $("#authExpress");
	if(authExpress.val()==""){
		var expVal="";
		var codeObjs = $(this.document).find("input[id=page_code]");
		codeObjs.each(function(){
			if(expVal==""){
				expVal = $(this).val();
			}else{
				expVal += "&&"+$(this).val();
			}
		})
		authExpress.val(expVal);
	}else{
		authExpress.val(authExpress.val()+"&&"+ptCode);
	}
}
</script>

<!--body end --> 

</body>
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
