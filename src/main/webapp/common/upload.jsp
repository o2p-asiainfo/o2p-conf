<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" import="java.util.*"%>
<%@ include file="/common/taglibs.jsp"%>
 
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/platform.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/register.css" />

	<body style="text-align: center;PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px;">
		<s:fielderror />
		<s:form name="uploadForm" id="uploadForm" validate="true" action="doUpload"
			namespace="/fileShare" method="post" enctype="multipart/form-data" theme="simple">
			 <ui:validators validateAlert="word" >
				<ui:validator fieldId="para_DOC_TITLE" validatorType="requiredstring" 
					message="%{getText('eaap.op2.portal.reg.regPleaseUpPhoto')}"></ui:validator>
			</ui:validators>
			<s:hidden name="DOC_DIR" id="DOC_DIR"></s:hidden>
			<s:hidden name="PARENT_FORM_FILEID_DOC_ID" id="PARENT_FORM_FILEID_DOC_ID"></s:hidden>
			<s:hidden name="PARENT_FORM_FILEID_DOC_NAME" id="PARENT_FORM_FILEID_DOC_NAME"></s:hidden>
			<s:hidden name="PARENT_FORM_IMAGE_ID" id="PARENT_FORM_IMAGE_ID"></s:hidden>
            <s:hidden name="isCheckedOk" id="isCheckedOk" value="no"></s:hidden>
			<table width="100%">
				<tr>
					<td>
						<table width="100%" class="sys-inputTable" cellpadding="0"
							cellspacing="0">
							<tr>
								<td align="center" class="sys-inputTable-td-left" width="15%">
								<s:property value="%{getText('eaap.op2.conf.manager.auth.filename')}"/>
								</td>
								<td width="47%" align="left" height="23" class="sys-inputTable-td">
								  <ui:inputText skin="${contextStyleTheme}" disabled="true" name="fileShare.sFileName" id="para_DOC_TITLE" textSize="30"></ui:inputText>	
								</td>
							</tr>
							<tr>
					          <td width="12%" align="center" height="46"   class="sys-inputTable-td-left">
					          <s:property value="%{getText('eaap.op2.conf.manager.auth.filepath')}"/>
					          </td>
					          <td width="47%" align="left" height="23" class="sys-inputTable-td">
					          	 <s:file name="upload"   id="para_FILE_NAME"   onchange="setTitle(this)" size="30" cssClass="sys-text-area"/>
					          </td>
					        </tr> 

						</table>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">
						<table width="100%">
							<tr>
								  <td width="47%" style="text-align: right;">
							 
									<ui:button skin="${contextStyleTheme}" name="buttonadddept" id="buttonadddept" disabled="false" text="%{getText('eaap.op2.conf.manager.auth.upload')}"></ui:button>	
									 
								  
								    <ui:button skin="${contextStyleTheme}" name="buttonadddept2" id="buttonadddept2" onclick="parent.closeWin();"  text="%{getText('eaap.op2.conf.orgregauditing.cancel')}"></ui:button>
								   </td>
								   
								   <td width="47%" style="text-align: center;">
									 <div id="showEmsg"></div>
								   </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	
	  <script language="JavaScript">
	    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;     
	    function checkProperty(obj) {
	        var allowImgExt=".jpg|.jpeg|.gif|.bmp|.png|" ;
			var fileName = obj.value ;  
	        var fileExt=fileName.substr(fileName.lastIndexOf(".")).toLowerCase();       
	     
	        if(allowImgExt!=0&&allowImgExt.indexOf(fileExt+"|")==-1) 
			{
			  document.getElementById('buttonadddept').href="#"; 
			  document.getElementById('showEmsg').innerHTML="<font  color='red' size=2><s:property value="%{getText('eaap.op2.conf.manager.auth.uploaderrornotimage')}"/></font>" ;
			}
			else
			{
			 document.getElementById('buttonadddept').href="javascript:onSubmit();"; 
			document.getElementById('showEmsg').innerHTML="" ;
			var fileSize = 0;     
		    if (isIE && !obj.files) {       
		      var filePath = obj.value;       
		      var fileSystem = new ActiveXObject("Scripting.FileSystemObject");    
		      var file = fileSystem.GetFile (filePath);       
		      
		      fileSize = file.size;      
		    } else 
		     {      
		     fileSize = obj.files[0].size;       
		     }     
		     if(fileSize>1*1024*1024){    
		       document.getElementById('buttonadddept').href="#"; 
			   document.getElementById('showEmsg').innerHTML="<font  color='red' size=2><s:property value="%{getText('eaap.op2.conf.manager.auth.uploaderrordes')}"/></font>" ;
		      }else
		      { 
		        document.getElementById('buttonadddept').href="javascript:onSubmit();";
		        document.getElementById('showEmsg').innerHTML="" ;
		        document.getElementById('isCheckedOk').value='yes'; 
		       }   
			 }
		  } 
       
       
			function setTitle(selectedfile){
			 
			  document.getElementById('isCheckedOk').value='no'; 
			  var fname = selectedfile.value;
			  var i,j;
			  i=fname.lastIndexOf("\\",fname.length);
			  j=fname.lastIndexOf(".",fname.length);
			  if((j<0)||(j<i)) j=fname.length;
			  fname=fname.substring(i+1,j);
			  document.getElementById('para_DOC_TITLE').value=fname;
			  checkProperty(selectedfile);
			 
			 }
			
		function onSubmit(){
                if(document.getElementById('para_DOC_TITLE').value.trim()==""){
	         		return;
         		} 
         document.getElementById('buttonadddept').href="#";         
         document.uploadForm.submit();
        }
		</script>
		</s:form>
	</body>
</html>