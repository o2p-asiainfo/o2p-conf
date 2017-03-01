<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%> 
<%@ page language="java" import="java.lang.*" pageEncoding="UTF-8"%>
<html>
 <head>
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/jquery-ui.css" />
<s:property value="%{tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/artDialog.js?skin='+#attr.contextStyleTheme)}" escape="false"/>  
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/airDialog/iframeTools.js')" escape="false"/>
<script type="text/javascript" src="../resource/comm/js/jquery.js"></script>
<s:property value="tagUtil.writeScript('/struts/simple/resource/jquery.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery-ui.min.js')" escape="false"/>
<s:property value="tagUtil.writeScript('/struts/simple/resource/plugins/jquery.easyui.min.js')" escape="false"/>
</head>
<body>
	<div class="contentWarp">
	   <div>
	   <form id="updateTechImpl" action="" method="post" name="updateTechImpl" >
	 	<table class="mgr-table"  style="border:1px solid #ccc; background-color:#FCFCFC;">
	   		<tr>
	   			<td class="item-content"  style="margin-top:10px; padding-bottom:10px; margin-bottom:10px; border-bottom-width:0;">
	   				 <div style="line-height:25px;">
				  		         <s:property value="%{getText('eaap.op2.conf.process.authExpressions')}"/>
				    </div>
				    
	   				 <div style="width:100%; line-height:30px;">
	  				 	<ui:inputText skin="${contextStyleTheme}" name="pressValue" id="pressValue" readonly="true" textSize="100" type="text"  style="float:left;width:535px; height:30px;"></ui:inputText>
				    	<div style="float:left;width:30px; height:30px; border:1px solid #ccc; cursor:pointer; background-color:#F0F0F0;"  onclick="clearLast();"  title="Back space"><img src='../resource/comm/images/backspace.png' width='14' height='14'  align="absmiddle" style="margin:8px 0 0 8px;"/></div>
				    	<div style="float:left;width:30px; height:30px; border:1px solid #ccc; cursor:pointer; background-color:#F0F0F0;"  onclick="clearAll();"   title="Clear All"><img src='../resource/comm/images/uploadify-cancel.png' width='14' height='14'  align="absmiddle" style="margin:8px 0 0 8px;"/></div>
				    </div>
				</td>
			<tr>
				<td style="border-top-width:0;">
	  				<div class="ui-widget" align="center"  style="margin:10px 0; width:100%; ">	  					  					
	  					<ui:button skin="${contextStyleTheme}" text="(" shape="s" onclick="fillValue('(','1');"></ui:button>
	  					<ui:button skin="${contextStyleTheme}" text=")" shape="s" onclick="fillValue(')','1');"></ui:button>
	  					<ui:button skin="${contextStyleTheme}" text="&&" shape="s" onclick="fillValue('&&','1');"></ui:button>
	  					<ui:button skin="${contextStyleTheme}" text="||" shape="s" onclick="fillValue('||','1');"></ui:button>	  					
	  				</div> 	

	  				<div class="ui-widget" align="center" id="expCon"   style="margin:10px 0;">					
	  				</div> 	
	   			</td>	 
	   		</tr>
	    </table>
	    </form>
	  </div>
 	  <div align="center"  style="padding-top:10px;">
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.serInvokeIns.confirm')}" onclick="submitValue();"></ui:button>
	  			<ui:button skin="${contextStyleTheme}" text="%{getText('eaap.op2.conf.serInvokeIns.cancel')}" onclick="art.dialog.close()"></ui:button>
	  </div> 
</div>
 </body>
<script>
var itemList=new Array();
var errFills =new Array();
	errFills[0]="()";
	errFills[1]="(&&";
	errFills[2]="(||";
	errFills[3]=")(";
	errFills[4]="&&)";
	errFills[5]="&&&&";
	errFills[6]="&&||";
	errFills[7]="||)";
	errFills[8]="||&&";
	errFills[9]="||||";

$(function(){
	itemList[0]="(";
	itemList[1]=")";
	itemList[2]="&&";
	itemList[3]="||";
	
	var val = $(art.dialog.opener.document).find("#authExpress").val();
	var codeObjs = $(art.dialog.opener.document).find("input[id=page_code]");
	i=4;
	codeObjs.each(function(){
		itemList[i]=$(this).val();
		i++;
		$("#expCon").append("<a class=\"button-base button-small\" onclick=\"fillValue('"+$(this).val()+"','2')\"><span class=\"button-text\">"+$(this).val()+"</span></a>");
	})
	$("#pressValue").val(val);
	
});

function fillValue(objVal,type){
	if($("#pressValue").val()=="" &&(objVal==")" || objVal=="&&" || objVal=="||")){
		return;
	}
	//")"后面必需有连接符才能加条件：
	if(lastIsObj(")") && type=="2"){
		return;
	}
	//最一项为条件时不能直接接着“(”:
	if(lastIsCondition() && objVal=="("){
		return;
	}
	//最一项为条件时再点击条件类型的按钮时先把原条件清掉：
	if(lastIsCondition() && type=="2"){
		clearLast();
	}
	var oldVal = $("#pressValue").val();
	$("#pressValue").val(oldVal+objVal);
	
	//错误的连接符验证：
	if(isHasErr()){
		clearLast();
	}
}

function isHasErr(){
	var ret = false;
	var fillVal = $("#pressValue").val();
	for(var i=0; i<errFills.length; i++){
		var m = fillVal.lastIndexOf(errFills[i]);
		if(m>-1){
			ret = true;
			break;
		}
	}
	return ret;
}

function lastIsCondition(){
	var ret = false;
	var fillVal = $("#pressValue").val();
	if(fillVal !=""){
		var s=-1;		//最后一个连接符位置
		for(var i=3; -1<i; i--){
			var m = fillVal.lastIndexOf(itemList[i]);
			if(m>s){
				s=m;
			}
		}
		var c=-1;	//最后一个条件位置
		for(var i=4; i<itemList.length; i++){
			var m = fillVal.lastIndexOf(itemList[i]);
			if(m>c){
				c=m;
			}
		}
		if(c>s){
			ret=true;
		}
	}
	return ret;
}

function lastIsObj(obj){
	var ret = false;
	var fillVal = $("#pressValue").val();
	var objM = fillVal.lastIndexOf(obj);
	var n = 0;
	var lastObj="";
	for(var i=0; i<itemList.length; i++){
		var m = fillVal.lastIndexOf(itemList[i]);
		if(m>n){
			n=m;
			lastObj = itemList[i];
		}
	}
	if(objM>n || (objM==n && obj==lastObj)){
		ret = true;
	}
	return ret;
}

function clearAll(){
	$('#pressValue').val("");
}
function clearLast(){
	var oldVal = $("#pressValue").val();
	var n = 0;
	for(var i=0; i<itemList.length; i++){
		var m = oldVal.lastIndexOf(itemList[i]);
		if(m>n){
			n=m;
		}
	}
	if(n>-1){
		var newVal = oldVal.substring(0,n);
		$("#pressValue").val(newVal);
	}
}
function submitValue(){
	art.dialog.opener.setObjValue("authExpress",$("#pressValue").val());
	art.dialog.close();
}
</script>
</html>

