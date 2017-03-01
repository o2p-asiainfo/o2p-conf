<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	isELIgnored="false"%>
<html>
<head>
<title><s:property
		value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
<s:property
	value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}"
	escape="false" />
<s:property
	value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')"
	escape="false" />
<s:property
	value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')"
	escape="false" />
</head>
<script type="text/javascript">
		var title = [];   
		   title[0]='<s:property value="%{getText('eaap.op2.conf.process.type')}" />';
		   title[1]='<s:property value="%{getText('eaap.op2.conf.process.alternativeSymbols')}" />';
		   title[2]='<s:property value="%{getText('eaap.op2.conf.process.startingPosition')}" />';
		   title[3]='<s:property value="%{getText('eaap.op2.conf.process.endPosition')}" />';
		   title[4]='<s:property value="%{getText('eaap.op2.conf.proof.createTime')}" />';
		   title[5]='<s:property value="%{getText('eaap.op2.conf.proof.Operation')}" />';
		   
</script>
<body>
	<!--  
	<div id="compWin" class="easyui-window" data-options="modal:true,closed:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false" title="<s:property value="%{getText('eaap.op2.conf.server.manager.protocolVersionSelect')}" />" style="width:650px;height:500px;padding:5px;">
    </div>-->
<input id="rowIndex" name="rowIndex" value="${rowIndex}" type="hidden">
<input id="reqRspFlag" name="reqRspFlag" value="${reqRspFlag}" type="hidden">
	<div class="contentWarp">
		<div class="module-path">
			<div class="module-path-content">
				<img
					src="${contextPath}/resource/${contextStyleTheme}/images/search.png" />
				<s:property
					value="%{getText('eaap.op2.conf.server.supplier.openManager')}" />
				<img
					src="${contextPath}/resource/${contextStyleTheme}/images/module-path.png" />
				<s:property
					value="%{getText('eaap.op2.conf.process.fuzzyConfiguration')}" />

			</div>
		</div>
		<div class="accordion-header">
			<div class="accordion-header-text">
				<span><span class="accordion-header-icon">
						&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<s:property value="%{getText('eaap.op2.conf.techimpl.queryArea')}" /></span>
			</div>
		</div>
		<div id="queryBlock">
			<div class="formLayout" style="padding: 5px 0; clear: both;">
				<form id="serviceSupplierRegister" method="post">
					<dl>
						<dt>
							<s:property value="%{getText('eaap.op2.conf.process.type')}" />
							:
						</dt>
						<dd>
							<ui:select skin="${contextStyleTheme}" name="fuzzyType"
								id="fuzzyType" list="type" width="157" emptyOption="true"
								headerValue=" " listKey="id" listValue="val"></ui:select>
						</dd>
					</dl>
					<dl>
						<dt>
							<s:property
								value="%{getText('eaap.op2.conf.process.alternativeSymbols')}" />
							:
						</dt>
						<dd style="width: 260px;">
							<ui:inputText skin="${contextStyleTheme}" name="fuzzySymbols"
								id="fuzzySymbols" textSize="25" style="float:left;"></ui:inputText>
						</dd>
					</dl>
					<dl>
						<dt>
							<s:property
								value="%{getText('eaap.op2.conf.process.startingPosition')}" />
							:
						</dt>
						<dd style="width: 260px;">
							<ui:inputText skin="${contextStyleTheme}" name="fuzzyStart"
								id="fuzzyStart" textSize="25" style="float:left;"></ui:inputText>
						</dd>
					</dl>
					<dl>
						<dt>
							<s:property
								value="%{getText('eaap.op2.conf.process.endPosition')}" />
							:
						</dt>
						<dd style="width: 260px;">
							<ui:inputText skin="${contextStyleTheme}" name="fuzzyEnd"
								id="fuzzyEnd" textSize="25" style="float:left;"></ui:inputText>
						</dd>
					</dl>
					<div style="text-align: right; float: right; margin-bottom: 5px;">
						<ui:button skin="${contextStyleTheme}"
							text="%{getText('eaap.op2.conf.orgregauditing.query')}"
							id="chaxun" onclick="searchFunc();" />
					</div>
				</form>
			</div>
			<div style="clear: both;">
				<ui:gridEasy columns="cols" iconCls="icon-save" sortName="code"
					skin="${contextStyleTheme}" singleSelect="true" id="table"
					pageInfo="true" sortOrder="desc" fit="true" collapsible="false"
					title="" striped="true" pageList="10" pagination="true"
					frozenColumns="true" rownumbers="true" toolbar="true"
					method="eaap-op2-conf-operatorlog-HideProcessAction.showProcessGrid">
					<ui:gridEasyColumn width="100" index="0" title="0"
						field="FUZZY_ENCRYPTION_TYPE" hidden="false" align="center"
						formatter="true" formatterMethod="fomat"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="100" index="1" title="1"
						field="FUZZY_ALTERNATIVE" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="100" index="2" title="2"
						field="FUZZY_START" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="100" index="3" title="3"
						field="FUZZY_END" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="100" index="4" title="4"
						field="CREATE_DATE" hidden="false" align="center"></ui:gridEasyColumn>
					<ui:gridEasyColumn width="100" index="5" title="5"
						field="FUZZY_ENCRYPTION_ID" hidden="true" align="center"></ui:gridEasyColumn>
					
				</ui:gridEasy>
			</div>
		</div>
		<table class="mgr-table" id="confirm">
			<tr>
				<td colspan="4" align="center"><ui:button
						skin="${contextStyleTheme}"
						text="%{getText('eaap.op2.conf.server.manager.confirm')}"
						onclick="chooseSerTechImplId();"></ui:button> <ui:button
						skin="${contextStyleTheme}"
						text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"
						onclick="art.dialog.close();"></ui:button></td>
			</tr>
		</table>
	</div>
	<ui:iframe skin="${contextStyleTheme}" iframeWidth="1100"
		iframeHeight="450" divId="opendialog" divTitle="choose org"
		iframeId="iframe_org" iframeSrc="" iframeScrolling="no"
		frameborder="10" />
</body>
<script type="text/javascript"
	src="${contextPath}/resource/comm/js/jqueryui/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css"
	href="${contextPath}/resource/${contextStyleTheme}/css/easyui/default/jquery.autocomplete.css" />
<script type="text/javascript">  

		
    		$(function(){
    		   //$('#btncut').remove();//去掉表格的修改按扭
    		   changeTopScrollHeight();
    		});
    		
       var operationTip = "<s:property value="%{getText('eaap.op2.conf.proof.OperationTips')}" />";
       var selected_record = "<s:property value="%{getText('eaap.op2.conf.proof.PleaseselectArecord')}" />";
       var sureDel = "<s:property value="%{getText('eaap.op2.conf.proof.sureDel')}" />";
       var failureDel = "<s:property value="%{getText('eaap.op2.conf.proof.deleteFailed')}" />";
       var successDel = "<s:property value="%{getText('eaap.op2.conf.proof.deleteSuccess')}" />";
       var checkout = "<s:property value="%{getText('eaap.op2.conf.proof.checkout')}" />";
       function deleteMethod(){
            var rows = $('#table').datagrid('getSelections');
            if(rows.length==0){
            	art.dialog.alert(operationTip,selected_record);
	        return false; 
            } 
            art.dialog.confirm(operationTip,sureDel, function () {
            var fuzzyId = rows[0].FUZZY_ENCRYPTION_ID;
            $.ajax({
            type:"post",
            async:false,
            url:"../operatorlog/delHideProcess.shtml",
            dataType:"text",
            data:{fuzzyId:fuzzyId},
            success:function(msg){
            if(msg=="ok"){
            	art.dialog.tips(successDel);
            }else if(msg=="fail"){
            	art.dialog.tips(failureDel);
            }else{
            	art.dialog.tips(msg);
            }
            $('#table').datagrid('reload');
        }
        });
            },function(){});
        }
    		
    		  function addMehtod(){
    			  var rowIndex = $('#rowIndex').val();
    			  var reqRspFlag = $('#reqRspFlag').val();
    		  window.location.href="../operatorlog/addHideProcess.shtml?rowIndex="+rowIndex+"&reqRspFlag="+reqRspFlag; 
              }
    		  
    		  function updateMethod(){
    			  var rowIndex = $('#rowIndex').val();
    			  var reqRspFlag = $('#reqRspFlag').val();
              var rows=$('#table').datagrid('getSelections');
              if(rows.length==0)
			    {
            	  art.dialog.alert(operationTip,selected_record);
		           return false;  
				}else
				{ 
				   var fuzzyId = rows[0].FUZZY_ENCRYPTION_ID;
				   var type = rows[0].FUZZY_ENCRYPTION_TYPE;
				   var fuzzySymbols = rows[0].FUZZY_ALTERNATIVE;
				   var fuzzyStart = rows[0].FUZZY_START;
				   var fuzzyEnd = rows[0].FUZZY_END;
				   window.location.href="../operatorlog/updateHideProcess.shtml?fuzzyModel.fuzzyId="
						   +fuzzyId+"&fuzzyModel.fuzzyType="
						   +type+"&fuzzyModel.fuzzySymbols="
						   +fuzzySymbols+"&fuzzyModel.fuzzyStart="
						   +fuzzyStart+"&fuzzyModel.fuzzyEnd="+fuzzyEnd+"&rowIndex="+rowIndex+"&reqRspFlag="+reqRspFlag;   
				}
              
              }
           
		    
		  function searchFunc() {
	      var form = $("#serviceSupplierRegister").form();
          $('#table').datagrid("load", sy.serializeObject(form));
          }
    	   function fomat(value,row,index){
    		  if(value=='1'){
					   return "<s:property value="%{getText('eaap.op2.conf.process.typefuzzy')}" />";
					   }
			  if(value=='2'){
					   return "<s:property value="%{getText('eaap.op2.conf.process.typeencryption')}" />";
					   }    
			  if(value=='3'){
				   return "<s:property value="%{getText('eaap.op2.conf.process.fuzzyEncryption')}" />";
				   }  
					
    		  }
    	   
        var havedo = "<s:property value="%{getText('eaap.op2.conf.proof.havedo')}" />";
        function chooseSerTechImplId()
       { 
        var vOpener=art.dialog.opener;
        var showValue = '';
        var fuzzyId = $('#table').datagrid('getSelections')[0].FUZZY_ENCRYPTION_ID+'';
        var type = $('#table').datagrid('getSelections')[0].FUZZY_ENCRYPTION_TYPE+'';
        var fuzzyType = fomat($('#table').datagrid('getSelections')[0].FUZZY_ENCRYPTION_TYPE+'','','');
        var fuzzySymbols  = $('#table').datagrid('getSelections')[0].FUZZY_ALTERNATIVE+'';
        var fuzzyStart = $('#table').datagrid('getSelections')[0].FUZZY_START+'';
        var fuzzyEnd = $('#table').datagrid('getSelections')[0].FUZZY_END+'';
        var showType = "<s:property value="%{getText('eaap.op2.conf.process.type')}" />";
        var showFuzzyAlternative = "<s:property value="%{getText('eaap.op2.conf.process.alternativeSymbols')}" />";
        var showFuzzyStart = "<s:property value="%{getText('eaap.op2.conf.process.startingPosition')}" />";
        var showFuzzyEnd = "<s:property value="%{getText('eaap.op2.conf.process.endPosition')}" />";
        if('2' == type){
        	showValue = showType+':'+fuzzyType;
        }else{
        	showValue = showType+':'+fuzzyType+", "+showFuzzyAlternative+":"+fuzzySymbols+", "+showFuzzyStart+":"+fuzzyStart+", "+showFuzzyEnd+":"+fuzzyEnd;
        }
        if('' == fuzzyId){
        	alert("<s:property value="%{getText('eaap.op2.conf.orgregauditing.pleasechoose')}" />");
        }else{
        	vOpener.setFuzzyDate($('#rowIndex').val(),showValue,fuzzyId,$('#reqRspFlag').val());
            art.dialog.close();
        }
       }
 
function cleardata(str1,str2)
{

$("#"+str1).val(null);
$("#"+str2).val(null);
}
    </script>
<%@ include file="/common/ssoCommon.jsp"%>
</html>
