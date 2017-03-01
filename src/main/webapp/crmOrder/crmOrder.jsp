<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@page import="com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer"%>
<%@page import="com.linkage.rainbow.util.DateUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String processWebPath = CustomPropertyConfigurer.getProperty("work_flow_pro_url"); 
%>
<html>
<head>
	<title>
		<s:property value="%{getText('eaap.op2.conf.prov.SysName')}" />
	</title>
    <s:property value="tagUtil.writeStyle('/struts/simple/resource/skin/'+#attr.contextStyleTheme+'/queryBlock.css')" escape="false"/>
	<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/contractDoc_files/contractDiv.css" />
	<script type="text/javascript" src="${contextPath}/resource/comm/js/json2.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
	
	<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
	<script src="../resource/jqueryDatetime/jquery.datetimepicker.js"></script>	
    <link rel="stylesheet" type="text/css" href="../resource/jqueryDatetime/jquery.datetimepicker.css"/>
 </head>
<script>
var title = [];
title[0]='<s:property value="%{getText('eaap.op2.conf.crmott.orderId')}"/>';
title[1]='<s:property value="%{getText('eaap.op2.conf.crmott.crmOrderId')}" />';
title[2]='<s:property value="%{getText('eaap.op2.conf.crmott.orderNumber')}" />';
title[3]='<s:property value="%{getText('eaap.op2.conf.crmott.orderType')}" />';
title[4]='<s:property value="%{getText('eaap.op2.conf.crmott.acceptDate')}" />';
title[5]='<s:property value="%{getText('eaap.op2.conf.crmott.countryCode')}" />';
title[6]='<s:property value="%{getText('eaap.op2.conf.crmott.locality')}" />';
title[7]='<s:property value="%{getText('eaap.op2.conf.crmott.mainServiceId')}" />';
title[8]='<s:property value="%{getText('eaap.op2.conf.crmott.tradeTypeCode')}" />';
title[9]='<s:property value="%{getText('eaap.op2.conf.crmott.orderState')}" />';
title[10]='<s:property value="%{getText('eaap.op2.conf.crmott.crmResult')}" />';
title[11]='<s:property value="%{getText('eaap.op2.conf.crmott.flow')}" />';
</script>
<body>
<!--body start -->
<div class="contentWarp">
  	<div class="module-path">
  		<div class="module-path-content">
	      <img src="../resource/blue/images/search.png" />
	      <s:property value="%{getText('eaap.op2.conf.orgregauditing.eaapplafrom')}"/>
	      <img src="../resource/blue/images/module-path.png" />
	      <s:property value="%{getText('eaap.op2.conf.crmott.crmOrder')}"/>
      </div>
    </div>
    <div class="accordion-header" >
    	<div class="accordion-header-text">
			<span class="accordion-header-icon" > &nbsp;&nbsp;&nbsp;&nbsp;</span>
			<s:property value="%{getText('eaap.op2.conf.orgregauditing.querytype')}"/>
         </div>
    </div>
    
    <div id="queryBlock">    
		<div class="formLayout" style="padding:5px 0;">
		<ui:form name="myForm" id="myForm" method="post">
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.crmott.acceptDate')}" />:
				</dt>	
				<dd >
					<table>
						<tr>
							<td>
								<input type="text" id="startAcceptDate" name="startAcceptDate" style="width:123px; height:30px; border:1px solid #ccc; cursor:pointer;"/> 
							</td>
							<td>
								<s:property value="%{getText('eaap.op2.conf.crmott.to')}"/>:
							</td>
							<td>
								<input type="text" i id="endAcceptDate" name="endAcceptDate" style="width:123px; height:30px; border:1px solid #ccc; cursor:pointer;"/> 
							</td>
						</tr>
					</table>
				</dd>
			</dl>
			
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.crmott.orderType')}" />:
				</dt>	
				<dd >
					<ui:select skin="${contextStyleTheme}"  emptyOption="true" headerValue="" name="soType" id="soType" 
		       		list="selectOrderTypeList" listKey="cepCode" listValue="cepName" style="width:150px;" ></ui:select>
				</dd>
			</dl>
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.crmott.orderNumber')}" />:
				</dt>	
				<dd >
				    <ui:inputText skin="${contextStyleTheme}"  name="soNbr" id="soNbr" value="${soNbr}" style="width:150px;"/>
				</dd>
			</dl>
			<dl>	
				<dt>
					<s:property value="%{getText('eaap.op2.conf.crmott.crmOrderId')}" />:
				</dt>	
				<dd >
				    <ui:inputText skin="${contextStyleTheme}"  name="orderNbr" id="orderNbr" value="${orderNbr}" style="width:150px;"/>
				</dd>
			</dl>
			<div style="text-align:right; float:right; margin-bottom:5px;">
				<ui:button skin="${contextStyleTheme}"  text="%{getText('eaap.op2.conf.crmott.query')}" id="chaxun" onclick="searchFunc();"/>
			</div>
			</ui:form>
		</div>
	</div>
	<div style="clear:both;overflow:hide;">
		<ui:gridEasy skin="${contextStyleTheme}" columns="cols" sortName="code" singleSelect="true"   id="table"  remoteSort="false" sortOrder="desc" onClickCell="true"
			fit="true" collapsible="true"   title="" striped="true" pageSize="10" pagination="true" frozenColumns="true" rownumbers="true" fitHeight="200" 
			method="eaap-op2-conf-crmorder-crmOrderAction.getOrderList">
			<ui:gridEasyColumn width="60"  index="0" title="0" field="ORDERID" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="135" index="1" title="1" field="ORDERNBR" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="135" index="2" title="2" field="SONBR" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="135" index="3" title="3" field="CEPNAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="135" index="4" title="4" field="ACCEPTDATE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="135" index="5" title="5" field="COUNTRYCODE" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="6" title="6" field="LOCALITY" hidden="true"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="7" title="7" field="MAINSERVERID" hidden="false"   align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="140" index="8" title="8" field="TRADETYPECODE" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="140" index="9" title="9" field="ORDERSTATUSNAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="100" index="10" title="10" field="CRMRESULTNAME" hidden="false" align="center"></ui:gridEasyColumn>
			<ui:gridEasyColumn width="140" index="10" title="10" field="PROCID" hidden="false" align="center" formatter="true" formatterMethod="formatterForView"></ui:gridEasyColumn>
		</ui:gridEasy>
	</div>
	<div>
	<ui:loadmask id="contentDiv" skin="${contextStyleTheme}">
		<ui:tabpage  skin="${contextStyleTheme}" id="orderTabs"  loadMode="ajax"  onSelect="true">
			<ui:tabpagediv  id="detailInfoTab"  title="%{getText('eaap.op2.conf.crmott.detail')}"  closable="false">
				<div class="formLayout" style="padding:15px 0;width: 100%;height: 250px">
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.orderId')}" />:
						</dt>	
						<dd >
				    		<input id="orderId" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.orderNumber')}" />:
						</dt>	
						<dd >
							<input id="orderNumber" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.orderType')}" />:
						</dt>	
						<dd >
							<input id="orderType" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.acceptDate')}" />:
						</dt>	
						<dd>
							<input id="acceptDate" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.countryCode')}" />:
						</dt>	
						<dd>
							<input id="countryCode" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.locality')}" />:
						</dt>	
						<dd>
							<input id="locality" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.mainServiceId')}" />:
						</dt>	
						<dd>
							<input id="mainServiceId" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.orderState')}" />:
						</dt>	
						<dd>
							<input id="orderState" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.tradeTypeCode')}" />:
						</dt>	
						<dd>
							<input id="tradeTypeCode" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.originalOrderNumber')}" />:
						</dt>	
						<dd>
							<input id="originalOrderNumber" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
					
					<dl>	
						<dt>
							<s:property value="%{getText('eaap.op2.conf.crmott.bPMProcessId')}" />:
						</dt>	
						<dd>
							<input id="bPMProcessId" class="box1" readonly="readonly" type="text" size="23"></input>
						</dd>
					</dl>
				</div>
			</ui:tabpagediv>
			<ui:tabpagediv  id="userInfo"  title="%{getText('eaap.op2.conf.crmott.user')}"  closable="false">
				<div style="overflow:auto;width: 100%;height: 280px">
					<table class="t1" style="table-layout: fixed; word-break: break-all; word-wrap: break-word; width: 100%;"  border="1">
						<thead>
							<tr class="a1" style="height: 30px">
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.orderNumber')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.userId')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.userType')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.companyName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.firstName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.middleName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.lastName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.address')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.phone')}"/></td>
							</tr>
						</thead>
						<tbody id="userInfoBody">
						</tbody>
					</table>
				</div>
			</ui:tabpagediv>
			<ui:tabpagediv  id="addressInfo"  title="%{getText('eaap.op2.conf.crmott.address')}"  closable="false">
				<div style="overflow:auto;width: 100%;height: 280px">
					<table class="t1" style="table-layout: fixed; word-break: break-all; word-wrap: break-word; width: 100%;"  border="1">
						<thead>
							<tr class="a1" style="height: 30px">
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.userId')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.city')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.zipCode')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.street')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.building')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.stairway')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.floor')}"/></td>
								<td class="middle" width="12%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.door')}"/></td>
							</tr>
						</thead>
						<tbody id="addressBody">
						</tbody>
					</table>
				</div>
			</ui:tabpagediv>
			<ui:tabpagediv  id="customerInfo"  title="%{getText('eaap.op2.conf.crmott.customer')}"  closable="false">
				<div style="overflow:auto;width: 100%;height: 280px">
					<table class="t1" style="table-layout: fixed; word-break: break-all; word-wrap: break-word; width: 100%;"  border="1">
						<thead>
							<tr class="a1" style="height: 30px">
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.orderNumber')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.customerId')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.companyName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.firstName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.middleName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.lastName')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.state')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.customerType')}"/></td>
								<td class="middle" width="10%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.country')}"/></td>
							</tr>
						</thead>
						<tbody id="customerBody">
						</tbody>
					</table>
				</div>
			</ui:tabpagediv>
			<ui:tabpagediv  id="productInfo"  title="%{getText('eaap.op2.conf.crmott.product')}"  closable="false">
				<div style="overflow:auto;width: 100%;height: 280px">
					<table class="t1" style="table-layout: fixed; word-break: break-all; word-wrap: break-word; width: 100%;"  border="1">
						<thead>
							<tr class="a1" style="height: 30px">
								<td class="middle" width="15%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.orderNumber')}"/></td>
								<td class="middle" width="15%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.mainFlag')}"/></td>
								<td class="middle" width="15%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.productId')}"/></td>
								<td class="middle" width="15%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.productName')}"/></td>
								<td class="middle" width="15%" align="center"><s:property value="%{getText('eaap.op2.conf.crmott.actionType')}"/></td>
							</tr>
						</thead>
						<tbody id="productBody">
						</tbody>
					</table>
				</div>
			</ui:tabpagediv>
		</ui:tabpage>
	</div>
	</ui:loadmask>
</div>
</body>
<script>
var processWebPath = '<%=processWebPath%>';

function searchFunc(){
	var form = $("#myForm").form();
    $('#table').datagrid("load", sy.serializeObject(form));
}

function clickMethod(rowIndex,field,value){
}

window.onload = function(){
	$(".datagrid-toolbar").hide();
	$(".datagrid-cell-check").hide();
	unmask();
	$('#table').datagrid({
		onClickRow: function(rowIndex,rowData){
			$.ajax({
				type: "POST",
				async:true,
				url: "${contextPath}/crmOrder/getOrderInfoById.shtml",
				dataType:'json',
				data:{orderId:rowData.ORDERID},
				beforeSend: function(){
				    mask();
			    },
			    success: function(data){
			        unmask();
			        showInfo(data);
	             }
		    }); 
		}
	});
	
	  $('#startAcceptDate').datetimepicker({
			value:'${startAcceptDate}',
			step:10,
			format:'Y-m-d'
		});
		$('#endAcceptDate').datetimepicker({
			value:'${endAcceptDate}',
			step:10,
			format:'Y-m-d'
		});
}

function showInfo(data){
	if(data){
//    	console.info(showObj(data));
    	var orderInfo = data['orderInfo'];
//    	console.info(showObj(orderInfo));
    	
    	showOrderInfo(orderInfo);
		var orderUserList = data['orderUserList'];
		showUserInfo(orderUserList);
		
		var orderCustomerList = data['orderCustomerList'];
		showCustomerInfo(orderCustomerList);
		
		var orderProductList = data['orderProductList'];
		showProductInfo(orderProductList); 
		
		var addressList = data['userAddressList'];
		showAddressInfo(addressList); 
	}
}

function showAddressInfo(addressList){
	$("#addressBody").html('');
	if(addressList){
		var html = '';
		for(var i = 0; i < addressList.length; i++){
			console.info(showObj(addressList[i]));
			html += "<tr>";
			html += "<td>"+addressList[i].USERID+"</td>";
			html += "<td>"+getText(addressList[i].CITY)+"</td>";
			html += "<td>"+getText(addressList[i].ZIPCODE)+"</td>";
			html += "<td>"+getText(addressList[i].STREET)+"</td>";
			html += "<td>"+getText(addressList[i].BUILDING)+"</td>";
			html += "<td>"+getText(addressList[i].STAIRWAY)+"</td>";
			html += "<td>"+getText(addressList[i].FLOOR)+"</td>";
			html += "<td>"+getText(addressList[i].DOOR)+"</td>";
			html += "</tr>";
		}
		$("#addressBody").html(html);
	}
}

function showProductInfo(orderProductList){
	$("#productBody").html('');
	if(orderProductList){
		var html = '';
		for(var i = 0; i < orderProductList.length; i++){
//			console.info(showObj(orderProductList[i]));
			html += "<tr>";
			html += "<td>"+orderProductList[i].SONBR+"</td>"; 
			html += "<td>"+getText(orderProductList[i].MAINFLAG)+"</td>";
			html += "<td>"+getText(orderProductList[i].PRODID)+"</td>";
			html += "<td>"+getText(orderProductList[i].PRODNAME)+"</td>";
			html += "<td>"+getText(orderProductList[i].ACTTYPE)+"</td>";
			html += "</tr>";
		}
		$("#productBody").html(html);
	}
}

function showCustomerInfo(orderCustomerList){
	$("#customerBody").html('');
	if(orderCustomerList){
		var html = '';
	    for(var i = 0; i < orderCustomerList.length; i++){
//			console.info(showObj(orderCustomerList[i]));
			html += "<tr>";
			html += "<td>"+orderCustomerList[i].SONBER+"</td>";
			html += "<td>"+getText(orderCustomerList[i].CUSTID)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].COMPANYNAME)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].FIRSTNAME)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].MIDNAME)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].LASTNAME)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].STATE)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].USERTYPE)+"</td>";
			html += "<td>"+getText(orderCustomerList[i].COUNTRY)+"</td>";
			html += "</tr>";
		}
		$("#customerBody").html(html);
	}
}

function showUserInfo(orderUserList){
	$("#userInfoBody").html('');
	if(orderUserList){
		var html = '';
		for(var i = 0; i < orderUserList.length; i++){
//			console.info(showObj(orderUserList[i]));
			html += "<tr>";
			html += "<td>"+orderUserList[i].SONBR+"</td>";
			html += "<td>"+orderUserList[i].USERID+"</td>";
			html += "<td>"+getText(orderUserList[i].USERTYPE)+"</td>";
			html += "<td>"+getText(orderUserList[i].COMPANYNAME)+"</td>";
			html += "<td>"+getText(orderUserList[i].FIRSTNAME)+"</td>";
			html += "<td>"+getText(orderUserList[i].MIDDLENAME)+"</td>";
			html += "<td>"+getText(orderUserList[i].LASTNAME)+"</td>";
			html += "<td>"+getText(orderUserList[i].ADDRESSINFO)+"</td>";
			html += "<td>"+getText(orderUserList[i].PHONE)+"</td>";
			html += "</tr>";
		}
		$("#userInfoBody").html(html); 
	}
}

function formatterForView(value,row,index){
	return "<a href='" + processWebPath + "/historyService/toHistoryProcess.shtml?processInstanceId="+ value +"' target='_blank'><s:property value="%{getText('eaap.op2.conf.crmott.processImage')}"/></a>" ;
}

function getText(value){
	return value ? value : ""; 
}

function showOrderInfo(orderInfo){
	//ORDERNBR
	$("#orderId").val(orderInfo.ORDERID);
	$("#orderNumber").val(orderInfo.SONBR);
	$("#orderType").val(orderInfo.CEPNAME);
	$("#acceptDate").val(orderInfo.ACCEPTDATE);
	$("#countryCode").val(orderInfo.COUNTRYCODE);
	$("#locality").val(orderInfo.LOCALITY);
	$("#mainServiceId").val(orderInfo.MAINSERVERID);
	$("#orderState").val(orderInfo.ORDERSTATUS);
	$("#tradeTypeCode").val(orderInfo.TRADETYPECODE);
	$("#originalOrderNumber").val(orderInfo.ORIGNALSONBR);
	$("#bPMProcessId").val(orderInfo.PROCID);
}

function showObj(obj){
	var objStr="";
	for(items in obj){
		var str="objStr+=items+'='+obj."+items+"+'\\n';";
		eval(str);
	}
	return objStr;
}


</script>
	
<%@ include file="/common/ssoCommon.jsp"%> 
</html>
