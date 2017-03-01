<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>

<title>addTechImplInfoToNext.jsp</title>
<s:property
	value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}"
	escape="false" />
<s:property
	value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')"
	escape="false" />
</head>

<body>
	<div class="contentWarp">
		<div class="module-path">
			<div class="module-path-content">
				<img
					src="${contextPath}/resource/${contextStyleTheme}/images/edit.png" />
				<s:property
					value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
				<img
					src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />
				<s:property value="%{getText('eaap.op2.conf.techimpl.cfgTitle2')}" />
			</div>
		</div>

		<div>
			<ui:form id="addproof" action=""
				method="post">
				<div class="module-path">
					<div class="module-path-content" align="center">
						<s:property
							value="%{getText('eaap.op2.conf.server.supplier.supplierInfor')}" />
					</div>
				</div>
				<table class="mgr-table">
					<tr>
						<td class="item" style="width: 20%;"><font color="red">*</font>
							<s:property value="%{getText('eaap.op2.conf.proof.pt_name')}" />:</td>
						<td class="item-content" style="width: 80%;">
							<div class="ui-widget">
								<div class="ui-widget">
									<intput type="hidden" id="hide_proofe_id"> <ui:select
										skin="${contextStyleTheme}" name="proofType.pt_cd" id="pt_cd"
										list="listProofType" width="157" headerValue=" "
										listKey="PT_CD" listValue="PT_NAME"></ui:select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="item-center" colspan="4"><ui:button
								skin="${contextStyleTheme}" id="show_button"
								text="%{getText('eaap.op2.conf.server.supplier.save')}"
								onclick="javascript:changeOperation();"></ui:button></td>
					</tr>
				</table>
			</ui:form>
			<script type="text/javascript">
        var title = [];
          title[0]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cc2cname')}"/>';
          title[1]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cyclevalue')}" />';
          title[2]='<s:property value="%{getText('eaap.op2.conf.manager.auth.cutmsvalue')}" />';
          title[3]='<s:property value="%{getText('eaap.op2.conf.manager.auth.state')}" />';
          title[4]='<s:property value="%{getText('eaap.op2.conf.compregauditing.regtime')}" />';
          title[5]='<s:property value="%{getText('eaap.op2.conf.manager.auth.statetime')}" />';
         </script>
			<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code"
				skin="${contextStyleTheme}" singleSelect="true" fitHeight="200"
				id="table" remoteSort="false" sortOrder="desc" fit="true"
				collapsible="false"
				title="%{getText('eaap.op2.conf.server.supplier.controlStrategy')}"
				striped="true" pageList="10" pagination="true" frozenColumns="true"
				rownumbers="true" toolbar="true"
				method="eaap-op2-conf-proofeffect-ProofEffectAction.getAttrValue">
				<ui:gridEasyColumn width="180" index="0" title="0" field="PR_ATR_SPEC_CD"
					hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="180" index="1" title="1"
					field="ATTR_SPEC_NAME" hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="280" index="2" title="2" field="ATTR_SPEC_CODE"
					hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="80" index="3" title="3" field="ATTR_VALUE"
					hidden="false" align="center"></ui:gridEasyColumn>
				<ui:gridEasyColumn width="1" index="4" title="4" field="PV_ID"
					hidden="true" align="center"></ui:gridEasyColumn>
			</ui:gridEasy>
			<!-- 添加验证规则数据 -->
			<div id="show_add_table" style="display: none">
				<ui:form id="myForm" method="post" name="myForm">
					<ui:validators validateAlert="div" validatorGroup="group2">
						<ui:validator fieldId="pr_attr_spec_name"
							validatorType="requiredstring" required="true" message="属性规格不能为空" />
						<ui:validator fieldId="attr_value" validatorType="requiredstring"
							required="true" message="属性值不能为空" />
					</ui:validators>
					<div class="module-path">
						<div class="module-path-content" align="center">
							添加有效验证规则
							<%-- <s:property value="%{getText('eaap.op2.conf.server.supplier.supplierInfor')}" />--%>
						</div>
					</div>
					<table class="mgr-table" id="cc2cinfo">
						<tr>
							<td class="item"><font color="red">*</font>认证类型属性规格:</td>
							<input type="hidden" name="hidden_pr_attr_spec_id"
								id="hidden_pr_attr_spec_id"> <input type="hidden"
								name="hide_attr_proofe_id" id="hide_attr_proofe_id">
							<td><ui:inputText skin="${contextStyleTheme}"
									id="pr_attr_spec_name" textSize="30" readonly="true"
									name="pr_attr_spec_name" /> <ui:button
									skin="${contextStyleTheme}"
									text="%{getText('eaap.op2.conf.manager.auth.choose')}"
									onclick="openWindows('${contextPath}/proofeffect/selectProofAttrType.shtml','选择认证类型属性规格')"
									shape="s"></ui:button></td>
                            <%--openWindows('${contextPath}/proofeffect/selectattr.shtml --%>
							<td class="item"><font color="red">*</font>认证属性值:</td>
							<td><ui:inputText skin="${contextStyleTheme}"
									id="attr_value" textSize="30" name="attr_value" /></td>
							<td class="item">操作</td>
							<td><ui:button skin="${contextStyleTheme}"
									text="%{getText('eaap.op2.conf.orgregauditing.checksubmit')}"
									id="checksubmitId"
									onclick="if(comm_validators_check('group2')){xx();}"></ui:button>
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
			<div align="center">
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.supplier.save')}"
					onclick="javascript:saveDate();"></ui:button>
				<ui:button skin="${contextStyleTheme}"
					text="%{getText('eaap.op2.conf.server.manager.serviceCancel')}"
					onclick="history.go(-1);"></ui:button>
			</div>
		</div>
	</div>
	<ui:iframe skin="${contextStyleTheme}" iframeWidth="900"
		iframeHeight="450" divId="opendialog" divTitle="choose org"
		iframeId="iframe_org" iframeSrc="" iframeScrolling="no"
		frameborder="10" />
</body>
<script>
var techImplId ="";
 function addMehtod(index,field,value)
 {
  if("" != techImplId){
	  $("#hidden_pr_attr_spec_id").val(null);
	  $("#pr_attr_spec_name").val(null);
	  $("#attr_value").val(null);
	  $('#show_add_table').show();
  }else{
	  //art.dialog.tips('请先添加验证数据!');
	  art.dialog.alert('操作提示','请先添加验证数据!');
  }
 }
 function saveDate(){
	 var hide_proofe_id = $('#hide_proofe_id').val();
	 if(null == hide_proofe_id || '' == hide_proofe_id){
		 art.dialog.alert('操作提示','操作不正确!');
		 return false;
	 }
	 var table_date =  $('#table').datagrid('getData').rows.length;
	 if(0 == table_date){
		 art.dialog.alert('操作提示','操作不正确!');
		 return false;
	 }
	 history.go(-1);
 }
 function changeOperation(){
	 art.dialog.confirm('操作提示','你确定要添加这掉记录吗？', function () {
		 var hide_proofe_id = $("#hide_proofe_id").val();
		 if(null != hide_proofe_id && ''!= hide_proofe_id){
			 art.dialog.alert('操作提示','你已经添加了该数据!');
		 }else{
			 var ajax_data = $("#addproof").serialize();
			 $.ajax({
		      type:"post",
		      async:false,
		      url:"../proofeffect/addProofEffectType.shtml",
		      dataType:"json",
		      data:ajax_data,
		      success:function(msg,data){
		      techImplId = msg[0].data;
		      $("#hide_proofe_id").val(techImplId);
		      $("#hide_attr_proofe_id").val(techImplId);
		      if(msg=="failure"){
		    	  art.dialog.tips('添加验证数据失败!');
		      }else{
		    	  art.dialog.tips('添加成功!');
		    	  //art.dialog.alert('添加成功!');
		      }
		      //$('#table').datagrid('load', {  
		       //techImplId: techImplId  
		      //}); 
		      }
		    });
		 }
		}, function () {
		   // art.dialog.tips('执行取消操作');
		});
 }
 
 function clickMethod(index,field,value)
 {
 
     if(field=='NAME')
     {
      var cc2cId = $('#cc2clist').datagrid('getSelections')[0].CTL_C_2_COMP_ID ;
      if(cc2cId!=null&&cc2cId!='')
      {
      
          $("#cc2cctlC2CompId").val(cc2cId);
		  $("#cc2cccCd").val($('#cc2clist').datagrid('getSelections')[0].CC_CD);
		  $("#cc2ccycleValue").val($('#cc2clist').datagrid('getSelections')[0].CYCLE_VALUE);
		  $("#cc2ccycleType").val($('#cc2clist').datagrid('getSelections')[0].CYCLE_TYPE);
		  $("#cc2ccutmsValue").val($('#cc2clist').datagrid('getSelections')[0].CUTMS_VALUE);
		  $("#cc2ceffectState").val($('#cc2clist').datagrid('getSelections')[0].EFFECT_STATE);
		  $("#editOrAdd").val("edit");
		  $('#show_add_table').show();
	  }
     } 
 }   
function xx(){
	art.dialog.confirm('操作提示','你确定要添加这条记录吗？', function () {
	var attr_proofe_id = '';
    var ajax_data = $("#myForm").serialize();
    	 $.ajax({
          type:"post",
          async:false,
          url:"../proofeffect/addAttrValues.shtml",
          dataType:"json",
          data:ajax_data,
          success:function(msg,data){
        	  attr_proofe_id = msg[0].data;
        	  if(msg=="failure"){
		    	  art.dialog.tips('添加失败!');
		      }else{
		    	  art.dialog.tips('添加成功!');
		    	  //art.dialog.alert('添加成功!');
		      }
          $('#table').datagrid('load', {  
        	  attr_proofe_id: attr_proofe_id  
          }); 
          $('#show_add_table').hide();
          }
        });
	},function (){});
}

 function deleteMethod(index,field,value)
 {
  var rows = $('#table').datagrid('getSelections');
  if(rows.length==0){
	  art.dialog.alert('操作提示','请选择一条记录!');
	return false; 
  }
  art.dialog.confirm('操作提示','你确定要删除这条记录吗？', function () {
  var pv_id = $('#table').datagrid('getSelections')[0].PV_ID ;
  $.ajax({
      type:"post",
      async:false,
      url:"../proofeffect/delProofValues.shtml",
      dataType:"json",
      data:{pv_id:pv_id},
      success:function(msg,data){
      if(msg=="failure"){
    	  art.dialog.tips('添加失败!');
      }else{
    	  art.dialog.tips('添加成功!');
      }
      $('#table').datagrid('reload');
    }
    });
  },function(){});
 }
       
	  function goTechImplIndex(){
	  window.location.href="../techimpl/showTechImplIndex.shtml";
	  }
 
 
 	  
</script>
</html>

