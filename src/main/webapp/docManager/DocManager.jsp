<%@ include file="/common/taglibs.jsp"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>  
	<head>            
		<title><s:property value="%{getText('eaap.op2.conf.contract.doc.docManager')}" /></title>        
		<script src="../resource/resources/scripts/jquery-1.7.1.min.js"></script>    
		<script type="text/javascript" src="../resource/contractDoc_files/contractDoc.js"></script>
		<script src="../resource/contractDoc_files/jPages.js" type="text/javascript"></script>
		<script src="../resource/contractDoc_files/ajaxfileupload.js" type="text/javascript"></script>
		<link href="../resource/contractDoc_files/jPages.css" type="text/css" rel="stylesheet">
		<link href="../resource/contractDoc_files/contractDoc.css" type="text/css" rel="stylesheet">    
	</head>    
	<body>  
		<div id="main_container">
			<table id="contractDocTab">
				<thead>
				    <tr class="thead1">
				    	<th class="th1"></th>
				        <th class="th2"><s:property value="%{getText('eaap.op2.conf.contract.doc.docName')}" /></th>
						<th class="th3"><s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" /></th>
						<th class="th4"><s:property value="%{getText('eaap.op2.conf.contract.doc.createDate')}" /></th>
						<th class="th5"><s:property value="%{getText('eaap.op2.conf.contract.doc.state')}" /></th>
						<th class="th6"><s:property value="%{getText('eaap.op2.conf.contract.doc.stateTime')}" /></th>  
				    </tr>
				</thead>
				<tbody id="group_one">
				</tbody>
			 </table>
			 <div id="contractDocBtn">
			 	<ui:button text="%{getText('eaap.op2.conf.contract.doc.del')}"  onclick="delDoc()"  id="delBtn"></ui:button>
			 </div>
			 <div class="holder"></div>
			 <div id="loadingDiv" style="display: none;">
			  	<img src="../resource/contractDoc_files/img/loading.gif" id="loadingImg" >
			  	<br>
			  	<br>
			  	<div id="loadingText"><span><s:property value="%{getText('eaap.op2.conf.contract.doc.fileUpdating')}" /></span></div>
			  </div>
			   <br /><br /><br /><br />
			  <div id="uploadFilediv">
			  	<table id="addTab">
			  		<tr>
			  			<td><s:property value="%{getText('eaap.op2.conf.contract.doc.docName')}" />：</td>
			  			<td><input type="txet" id="docName" name="contractDoc.docName"></td>
			  			<td><s:property value="%{getText('eaap.op2.conf.contract.doc.docVersion')}" />:</td>
			  			<td><input type="txet" id="docVersion" name="contractDoc.docVersion"></td>
			  		</tr>
			  		<tr>
			  			<td><s:property value="%{getText('eaap.op2.conf.contract.doc.selUpDoc')}" />：</td>
			  			<td colspan="2"><input type="file" id="file" name="file" /></td>
			  			<td><span id="alertMsg"></span></td>
			  		</tr>
			  	</table>
			    
			    <br />
			    <div id="uploadBtn">
				    <ui:button text="%{getText('eaap.op2.conf.contract.doc.addDoc')}"  onclick="validateAddDoc()"  id="addBtn"></ui:button>
				    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    <ui:button text="%{getText('eaap.op2.conf.contract.doc.close')}"  onclick="closeChild()"  id="closeBtn"></ui:button>
			    </div>
			  </div>
			  <div>
			  		<input type="hidden" id="first" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.first')}" />"/>
			  		<input type="hidden" id="last" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.last')}" />"/>
			  		<input type="hidden" id="pre" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.pre')}" />"/>
			  		<input type="hidden" id="next" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.next')}" />"/>
			  		<input type="hidden" id="onUse" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.onUse')}" />"/>
			  		<input type="hidden" id="unUse" value="%<s:property value="%{getText('eaap.op2.conf.contract.doc.unUse')}" />"/>
			  		<input type="hidden" id="docNameNull" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.docNameNull')}" />"/>
			  		<input type="hidden" id="docVersionNull" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.docVersionNull')}" />"/>
			  		<input type="hidden" id="selUpFile" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.selUpFile')}" />"/>
			  		<input type="hidden" id="confirmDel" value="<s:property value="%{getText('eaap.op2.conf.contract.doc.confirmDel')}" />"/>
			  </div>
		</div>		 
	</body>
</html>
