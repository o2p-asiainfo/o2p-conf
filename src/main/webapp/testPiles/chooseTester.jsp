<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
<title>choose Tester</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/artDialog.js?skin=${contextStyleTheme}" ></script> 
<script type="text/javascript" src="${contextPath}/struts/simple/resource/plugins/airDialog/iframeTools.js" ></script>
</head>
<body>
<!--body start -->
<div class="contentWarp">
	  	<div class="module-path">
	  		<div class="module-path-content">
	      	<img src="../resource/blue/images/search.png" />
	     	<s:property value="%{getText('eaap.op2.conf.testPiles.eaapplafrom')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.testPiles')}"/>
	      	<img src="../resource/blue/images/module-path.png" />
	      	<s:property value="%{getText('eaap.op2.conf.testPiles.chooseTester')}"/>
	     	</div>
	    </div>
	    	  
		<div id="queryBlock">
		<ui:form method="post" id="myform" name="myform" >
		 	<input id="testUserIdInput"  name="testUserIdInput" type="hidden" value="${testUserIdInput}" />
		 	<input id="testUserNameInput"  name="testUserNameInput" type="hidden" value="${testUserNameInput}" />
	   		<input type="hidden" id="selNodeValue" value=""/>
	   		<input type="hidden" id="selNodeText" value=""/>

			<table style="width:100%; margin:0; padding:0;">
				<tr>
					<td align="center" style="width:45%; margin:0; padding:0;">
					    	<table class="mgr-table" >
					    		<tr>
					    			<td class="accordion-header accordion-header-text" style="text-align:center;"><s:property value="%{getText('eaap.op2.conf.testPiles.canChoose')}" /></td>
					    		</tr>
							   <tr>
							     <td align="center" style="height:330px;" valign="top" onDblClick="selectByOnDblClick()">
										
							        <ui:tree skin="${contextStyleTheme}" method="eaap-op2-conf-testPiles-TestPilesAction.getProcessDesignUserTree"  id="WorkFlowTree"  
										 attrId="nodeId"  attrName="nodeName"  attrPid="p_nodeId"  attrIsParent="isParent"  
										 textName="workFlowTreeNode" textId="workFlowTreeNode" 
										 callBackMethod="getNodeInfo"  divclass="qwe">
									</ui:tree>	

							     </td>	
							     </tr>
							</table>
					</td>	
					<td align="center" style="width:10%;">
				  			<ui:button skin="${contextStyleTheme}"  text=">>" onclick="selUser()" shape="s"></ui:button><br/><br/><br/><ui:button skin="${contextStyleTheme}"  text="<<" onclick="unSelUser()" shape="s"></ui:button>
					</td>	
					<td align="center" style="width:45%; margin:0; padding:0;">
					    	<table class="mgr-table" >
					    		<tr>
					    			<td class="accordion-header accordion-header-text" style="text-align:center;"><s:property value="%{getText('eaap.op2.conf.testPiles.haveChosen')}" /></td>
					    		</tr>
							   <tr>
							     <td align="center" style="height:330px;padding:0;" valign="top">
									  <select id="haveChosenUserList" multiple="multiple" style="width:100%;height:330px;" onDblClick="unSelUser()">
											<c:forEach items="${testUserList}" var="dataSet" varStatus="status"  step="1" >
												<option value="${dataSet.UserId}">${dataSet.UserName}</option>
											</c:forEach>
									  </select>
							     </td>	
							     </tr>
							</table>
					</td>	
				</tr>
			</table>
			
			<table class="mgr-table" style="" id="confirm">
			   <tr>
			     <td  colspan="4"  align="center">    
			        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.sure')}"  onclick="chooseSerII();"></ui:button>
			        <ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.testPiles.cancel')}"  onclick="art.dialog.close();"></ui:button>
			     </td>	
			     </tr>
			</table>
		</ui:form>
		</div>
</div>
<!-- open window -->
<ui:iframe  skin="${contextStyleTheme}" iframeWidth="900" iframeHeight="450" divId="opendialog" divTitle="choose org" iframeId="iframe_org" iframeSrc="" iframeScrolling="no" frameborder="10" />
</body>
<!--body end --> 
<script type="text/javascript">
function chooseSerII() {
	var vOpener=art.dialog.opener; 
	var objSelect = document.getElementById("haveChosenUserList");
	var userIds="";
	var userNames = ""; 
    for (var i = 0; i < objSelect.options.length; i++) {
    	var userId = objSelect.options[i].value;
    	var userName = objSelect.options[i].text; 
        if (userId != "" && userName != "") {
        	if (userIds != "") {
        		userIds = userIds+","+userId;
        		userNames = userNames+","+userName;
            }else{
        		userIds = userId;
        		userNames = userName;
            }
        }
    }
    
	if($("#testUserIdInput").attr('value')!=""){
		vOpener.document.getElementById($("#testUserIdInput").attr('value')).value=userIds;
	}
	if($("#testUserNameInput").attr('value')!="") {
		vOpener.document.getElementById($("#testUserNameInput").attr('value')).value=userNames;
	}
	art.dialog.close(); 
}  


function getNodeInfo(nodeId,nodeName){
	document.getElementById("selNodeValue").value=nodeId;
	document.getElementById("selNodeText").value=nodeName;
}

function selectByOnDblClick(){
	var nodeId = document.getElementById("selNodeValue").value;
	var nodeName = document.getElementById("selNodeText").value;
	var objSelect = document.getElementById("haveChosenUserList");
	if(nodeId!="" && nodeName!=""){
	    if (jsSelectIsExitItem(objSelect, nodeId)) {
	        objSelect.value = nodeId;  //已经存在设为选中
	    } else {
			jsAddItemToSelect(objSelect,nodeName, nodeId);
	        objSelect.value = nodeId;  //设为选中
	    }
	}
}

function selUser(){
	var nodeId = document.getElementById("selNodeValue").value;
	var nodeName = document.getElementById("selNodeText").value;
	var objSelect = document.getElementById("haveChosenUserList");
	if(nodeId!="" && nodeName!=""){
	    if (jsSelectIsExitItem(objSelect, nodeId)) {        
	        objSelect.value = nodeId;  //已经存在设为选中
	    } else {        
			jsAddItemToSelect(objSelect,nodeName, nodeId);
	        objSelect.value = nodeId;  //设为选中
	    }
	}
}

function unSelUser(){
	var objSelect = document.getElementById("haveChosenUserList");
	jsRemoveSelectedItemFromSelect(objSelect);
}

//1.判断select选项中 是否存在Value="paraValue"的Item        
function jsSelectIsExitItem(objSelect, objItemValue) {        
    var isExit = false;        
    for (var i = 0; i < objSelect.options.length; i++) {        
        if (objSelect.options[i].value == objItemValue) {        
            isExit = true;        
            break;        
        }
    }
    return isExit;        
} 
//2.向select选项中 加入一个Item        
function jsAddItemToSelect(objSelect, objItemText, objItemValue) {        
    //判断是否存在        
    if (jsSelectIsExitItem(objSelect, objItemValue)) {        
        //alert("该Item的Value值已经存在");        
    } else {        
        var varItem = new Option(objItemText, objItemValue);      
        objSelect.options.add(varItem);     
        //alert("成功加入");     
    }        
} 
//3.从select选项中 删除一个Item        
function jsRemoveItemFromSelect(objSelect, objItemValue) { 
    //判断是否存在        
    if (jsSelectIsExitItem(objSelect, objItemValue)) {        
        for (var i = 0; i < objSelect.options.length; i++) {        
            if (objSelect.options[i].value == objItemValue) {        
                objSelect.options.remove(i);        
                break;        
            }        
        }        
//         alert("成功删除");        
    } else {        
//         alert("该select中 不存在该项");        
    }        
}    

// 4.删除select中选中的项    
function jsRemoveSelectedItemFromSelect(objSelect) {        
    var length = objSelect.options.length - 1;    
    for(var i = length; i >= 0; i--){    
        if(objSelect[i].selected == true){    
            objSelect.options[i] = null;    
        }    
    }    
}      

</script>
</html>
