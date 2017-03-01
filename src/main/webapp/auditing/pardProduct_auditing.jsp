<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><s:property value="%{getText('eaap.op2.conf.orgregauditing.SysName')}"/></title>
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/> 
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

<link rel="stylesheet" type="text/css" href="../resource/blue/css/console.css" />
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<script type="text/javascript">
function doSubmit(){
  var content_Id  = $("#content_Id").val();
   var activity_Id  = $("#activity_Id").val();
   var checkState = $("select[name=checkState]").val();
   var checkDesc  = $("#checkDesc").val();
   var pushMessageType="";
   $("input[name='pushMessageType']:checkbox").each(function(){ 
         if($(this).attr("checked")){
        	 pushMessageType += $(this).val()+",";
         }
     })
  if(checkState != "1"){
    if(!checkDesc){
      art.dialog.alert("operation","if you reject,the comment is not empty!");
      return;
    }
  }
  if(checkDesc){
     if(checkDesc.length > 512){
      art.dialog.alert("operation","Comment the length cannot exceed 512 characters!");
      return;
    }
   }
  
   $.ajax({
      async : false,
      type : "POST",
      url :  "${contextPath}/prodAndOffer/checkPardProduct.shtml",
      dataType : "json",
      data : {content_Id:content_Id,
        activity_Id:activity_Id,
        checkState:checkState,
        checkDesc:checkDesc,
        pushMessageType:pushMessageType},
      success : function(data) {
        try {
              var retCode = data.retCode;
              var retMsg  = data.retMsg;
              if(retCode=="0000"){    //Success
                art.dialog.alert("operation",retMsg);
                var vOpener = art.dialog.opener;
                vOpener.reloadList();
              	art.dialog.close(); 
              }else{
                $("#retMsgDiv").show();
                $("#retMsg").html(retMsg);
              }
        } catch (e) {
              $("#retMsgDiv").show();
        }
      }
  });
}
</script>
<style>
.text-left{ text-align: left!important;}
.text-right{ text-align: right!important;}
    .table {
    border-collapse: collapse !important;
    width:100%;
  }
  .table td,
  .table th {
    background-color: #fff !important;
    padding: 8px!important;
  }
  .table-bordered th,
  .table-bordered td {
    border: 1px solid #ddd !important;
  }
.form-control {
  box-sizing:border-box;
  display: block;
  width: 100%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.form-control:focus {
  border-color: #66afe9;
  outline: 0;
  -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
          box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 175, 233, .6);
}
.form-control::-moz-placeholder {
  color: #999;
  opacity: 1;
}
.form-control:-ms-input-placeholder {
  color: #999;
}
.form-control::-webkit-input-placeholder {
  color: #999;
}
</style>
</head>
<body>

<div class="contentWarp">
    <div class="module-path">
      <div class="module-path-content">
      <img src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" />
     
      <s:property value="%{getText('eaap.op2.conf.orgregauditing.waitingtask')}"/>
      <img src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />Product Check
      </div>
    </div>
    <div class="accordion-header" >
      <div class="accordion-header-text">
      <span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>Product Check
      </div>
    </div>
    
    <div>
        <table class="table table-bordered" cellpadding="0" cellspacing="0">
          <tr>
            <td class="text-right" width="225"><s:property value="%{getText('eaap.op2.conf.pardpord.prodOfferId')}"/>:
            </td> 
            <td class="item-content">${product.productId}
            </td> 
            <td class="text-right" width="225"><s:property value="%{getText('eaap.op2.conf.pardpord.prodOfferName')}"/>:
            </td> 
            <td class="item-content">${product.productName}
            </td>
          </tr>
          <tr>  
            <td class="text-right"><s:property value="%{getText('eaap.op2.portal.pardProd.prodDetail.prodCode')}"/>:
            </td> 
            <td class="item-content">${product.extProdId}
            </td>
            
            <td class="text-right">Service Module:
            </td> 
            <td class="item-content">${serviceName}
            </td>
            <!-- 
            <td class="item"><s:property value="%{getText('eaap.op2.conf.pardpord.effDate')}"/>:
            </td>
            <td class="item-content">
              <ui:date id="btime" name="product.formatEffDate" disabled="true" value="${product.formatEffDate}" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
                       ~ 
                      <ui:date id="etime" name="product.formatExpDate" disabled="true" value="${product.formatExpDate}" dateFmt="yyyy-MM-dd" isShowWeek="true" skin="${contextStyleTheme}" lang="${fn:substring(localeName, 1, 3)}"></ui:date>
            </td> 
            
            <td class="item"><s:property value="%{getText('eaap.op2.conf.pardProd.prodDetail.prodSvc')}"/>:
            </td> 
            <td class="item-content">
                   <c:forEach var="prodDealSvc" items="${prodDealSvcList}" step="1">
                    ${prodDealSvc.SERVICE_CN_NAME }
                   </c:forEach>
            </td>
             -->
          </tr> 
          <tr>
            <td class="text-right"><s:property value="%{getText('eaap.op2.portal.pardProd.prodDetail.prodDesc')}"/>
            </td>
            <td colspan="5" class="item-content">
            ${product.productDesc}        
            </td>
          </tr>
          <!-- 
          <tr>
          <td class="item"><s:property value="%{getText('eaap.op2.conf.pardSpec.subBusiness')}"/></td>
          <td colspan="5" class="item-content">
            <table class="inline" style="width:75%">
                <tbody>
                  <tr>
                  <th><s:property value="%{getText('eaap.op2.conf.pardporduct.subBusinessCode')}" /></th>
                  </tr>
                    <c:if test="${fn:length(subBusinessCodes)>=1}">
                    <c:forEach var="subBusiness" items="${subBusinessCodes}" step="1"> 
                       <tr>
                         <td style="TEXT-ALIGN:left;">${subBusiness.DEFAULT_VALUE}</td>
                     </tr> 
                        </c:forEach>
                                        </c:if>     
                </tbody>
               </table>
          </td>
          </tr>
           -->
           <tr>
           <td class="text-right">Service Attribute:</td>
           <td colspan="5" class="item-content">
            <table class="table table-bordered text-left">
                  <thead>
                    <tr>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.customer')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.code')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.name')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.note')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.type')}" /></th>
                      <th><s:property value="%{getText('eaap.op2.conf.pardSpec.default')}" /></th>
                    </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${serviceSpecAttrList}" var="servAttr">
                        <tr>
                             <td>${attrSpecIsCustomizedMap[servAttr.IS_CUSTOMIZED]}  </td>
                             <td>${servAttr.CODE }</td>
                             <td>${servAttr.CHAR_SPEC_NAME }</td>
                             <td>${servAttr.DESCRIPTION }</td>
                             <td>${attrSpecPageInTypeMap[servAttr.VALUE_TYPE]} </td>
                             <td>${servAttr.DEFAULT_VALUE }</td>
                         </tr> 
                      </c:forEach>
                    </tbody>
                 </table>
           </td>
           </tr>
           <tr>
                  <td class="text-right"><s:property value="%{getText('eaap.op2.portal.pardProd.prodAdd.define')}"/></td>
                  <td colspan="5" class="item-content">
                     <table class="table table-bordered text-left">
                  <thead>
                    <tr>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.customer')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.code')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.name')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.note')}" /></th>
                      <th width="16%"><s:property value="%{getText('eaap.op2.conf.pardSpec.type')}" /></th>
                      <th><s:property value="%{getText('eaap.op2.conf.pardSpec.default')}" /></th>
                    </tr>
                    </thead><tbody>
                     <s:iterator value="%{#request.prodAttrList}" id="prodAttr">
                      <tr>
                         <td> ${attrSpecIsCustomizedMap[prodAttr.IS_CUSTOMIZED]}  </td>
                         <td><s:property value="#prodAttr.ATTR_SPEC_CODE" /></td>
                         <td><s:property value="#prodAttr.ATTR_SPEC_NAME" /></td>
                         <td><s:property value="#prodAttr.ATTR_SPEC_DESC" /></td>
                         <td>${attrSpecPageInTypeMap[prodAttr.PAGE_IN_TYPE]} </td>
                         <td><s:property value="#prodAttr.DEFAULT_VALUE" /></td>
                     </tr> 
                     </s:iterator>  
                  </tbody>
                 </table>
                  </td>
            </tr>
        </table>
        
    </div>
    <div class="accordion-header" >
      <div class="accordion-header-text">
      <span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span><s:property value="%{getText('eaap.op2.conf.orgregauditing.check')}"/>
      </div>
    </div>
    <div>
        <form action="${contextPath}/prodAndOffer/checkPardProduct.shtml" name="checkPardProduct" method="post">
              <input type="hidden" name ="content_Id" id="content_Id" value="${content_Id}" />
              <input type="hidden" name ="activity_Id" id="activity_Id" value="${activity_Id}" />
              
          <table class="table table-bordered">
            <tr>
              <td class="text-right" width="225"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkresult')}"/>
              </td> 
              <td >
              <select name="checkState">
              <option value="1"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkpass')}"/></option>
              <option value="2"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checknotpass')}"/></option>
              </select>
              </td> 
            </tr>
            <tr>
              <td class="text-right"><s:property value="%{getText('eaap.op2.conf.orgregauditing.checkdesc')}"/>
              </td>
              <td >
                <textarea name="checkDesc" id="checkDesc" class="form-control" rows="3"></textarea> 
              </td>
            </tr>
        <c:if test="${not empty pushc_url}">
          <tr>
            <td class="text-right"><s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageType')}"/>:
            </td> 
            <td colspan="5">
              <input type="checkbox" name="pushMessageType" id="pushMessageType" value="1" />&nbsp;<s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageTypeByEmail')}"/>
              <input type="checkbox" name="pushMessageType" id="pushMessageType" value="2" />&nbsp;<s:property value="%{getText('eaap.op2.conf.orgregauditing.pushMessageTypeBySms')}"/>
            </td> 
             </tr>
        </c:if> 
            <tr>
              <td  colspan="2"   align="center">
                  <ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"  onclick="doSubmit();"  id="submitId"></ui:button>
                  <div id="retMsgDiv" style="display:none;color:#FF0000; text-align:left;">
                    <div style="color:#FF0000; text-align:left; font-weight:bold;">
                      <s:property value="%{getText('eaap.op2.conf.orgregauditing.auditingFailure')}" />
                    </div>
                    <div id="retMsg" style="color:#FF0000; text-align:left;"></div>
                  </div>
              </td> 
            </tr>
          </table>
        </form> 
    </div>

</div>

</body>

</html>
