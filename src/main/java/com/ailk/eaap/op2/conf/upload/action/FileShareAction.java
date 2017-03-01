package com.ailk.eaap.op2.conf.upload.action;
 
import java.io.File;
import java.io.OutputStream;
 
import java.sql.Blob;
import java.util.Map;
import java.util.List;
 

import javax.servlet.http.HttpServletResponse;
 
import com.ailk.eaap.op2.bo.FileShare;
import com.ailk.eaap.op2.conf.upload.serv.IFileShareServ;
 
import com.linkage.rainbow.ui.struts.BaseAction;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
/**
 * �ĵ��ϴ����ع���Action<br>
 * ��ʾ�ĵ��ϴ����ؽ���,�����ĵ��ϴ���������.
 * <p>
 */

public class FileShareAction extends BaseAction {
	protected transient final Log log = LogFactory.getLog(FileShareAction.class);
	private String PARENT_FORM_FILEID_DOC_ID;
	private String PARENT_FORM_FILEID_DOC_NAME;
	private String PARENT_FORM_IMAGE_ID;
    private File upload;
    private String contentType;
    private String fileName; 
    private FileShare fileShare = new FileShare();
    private IFileShareServ fileShareService ;
    private String uploadSate="Y" ;  
	private String isCheckedOk ;
	private int    MAX_LIMIT_MESSAGE_SIZE=1*1024*1024;
    public String readImg(){
		try {
			
		HttpServletResponse response =getResponse() ;
		 
		List<Map> fileShareList = (List<Map>)getFileShareService().selectFileShare(fileShare);
		java.sql.Blob blob = null;
		byte[] byteArr = null;
		if (fileShareList != null) {
			for(Map item : fileShareList) {
				if (item.get("S_FILE_CONTENT") != null && item.get("S_FILE_CONTENT").getClass().getName().equals("oracle.sql.BLOB")) {
					
					blob = (Blob) item.get("S_FILE_CONTENT");
					int length = (int) blob.length();
					byteArr = blob.getBytes(1, length);
				}
				if (item.get("S_FILE_CONTENT") != null && item.get("S_FILE_CONTENT").getClass().getName().equals("[B")) {
					
					byteArr =(byte[])item.get("S_FILE_CONTENT");
				}
				
			}
		}
		
		response.setContentType("image/jpeg") ;
		 
		OutputStream ops = response.getOutputStream();
		if (byteArr != null && byteArr.length > 0) {
			for (int i = 0; i < byteArr.length; i++) {
				ops.write(byteArr[i]);
			}
			ops.flush();
	        ops.close();
		}
        
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
		return null ;
	}   
 
    
    /**
     * �ϴ��ĵ��ϴ�����Action<br>
     * ���ϴ����ĵ�������com/doone/sys/manage/doc/applicationContext-doc.xml�����ļ���,<br>
     * sys-manage-doc-docAction Bean��doc���Զ���Ĵ�ŵ�Ŀ¼<br>
     * 1.��ʹ�þ��·��<br>
     *   ��linux�� value="/user/myUserName/doc"<br>
     *   window��  value="d:/doc"<br>
     * 2.ʹ�����·��,���ڵ�WebRoot�µ���Ŀ¼��.��:value="doc"<br>
     * �ļ��ϴ���,�����ĵ�����ҵ�����,����ݿ��¼���ļ���Ϣ.
     * @return "success"<br>
     */
	public String doUpload() {
		 fileShare.setSFileName(fileName) ;
		 fileShare.setSFileContent(upload) ;
		 
		 if(!"yes".equals(isCheckedOk)){
			 if(upload.length() > MAX_LIMIT_MESSAGE_SIZE){
					uploadSate = "N" ;
					addActionMessage(getText("eaap.op2.conf.manager.auth.uploaderrordes"));
					return this.SUCCESS;
				}
		 }
		Integer docId =	getFileShareService().saveFileShare(fileShare) ;
		try {
			String javascript ="";
			
			 
			
			if(PARENT_FORM_FILEID_DOC_ID != null){
				javascript+= "parent.document.getElementById('"+PARENT_FORM_FILEID_DOC_ID+"').value=\""+docId+"\";";
			}
			if(PARENT_FORM_FILEID_DOC_NAME != null){
				javascript+= "parent.document.getElementById('"+PARENT_FORM_FILEID_DOC_NAME+"').value=\""+fileName+"\";";
			}
			if(PARENT_FORM_IMAGE_ID != null){
				javascript+= "parent.document.getElementById('"+PARENT_FORM_IMAGE_ID+"').src=\"../fileShare/readImg.shtml?fileShare.sFileId="+docId+"\";";
			}
			 
			addActionScript(javascript);
			addActionMessage(getText("eaap.op2.conf.manager.auth.imageuploadsuccess")+fileName);
		 } catch (Exception e) {
			 log.error(e.getStackTrace());
			addActionMessage(getText("eaap.op2.conf.manager.auth.imagenotupload")+e.getMessage());
		} 
		return this.SUCCESS;
	}
	 /**
     * ��ʾ�ϴ�ҳ��Action
     * @return "success"
     */
	public String upload() {
	 
		return this.SUCCESS;
	}
	
public IFileShareServ getFileShareService() {
	if(fileShareService==null){
        //ȡ��spring������
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// ȡ��spring beanʵ��
			fileShareService = (IFileShareServ)ctx.getBean("eaap-op2-conf-fileShareServ");
		   
     }
	return fileShareService;
}
public void setFileShareService(IFileShareServ fileShareService) {
	this.fileShareService = fileShareService;
}

public FileShare getFileShare() {
	return fileShare;
}

public void setFileShare(FileShare fileShare) {
	this.fileShare = fileShare;
}


public String getPARENT_FORM_FILEID_DOC_ID() {
	return PARENT_FORM_FILEID_DOC_ID;
}


public void setPARENT_FORM_FILEID_DOC_ID(String parent_form_fileid_doc_id) {
	PARENT_FORM_FILEID_DOC_ID = parent_form_fileid_doc_id;
}


public String getPARENT_FORM_FILEID_DOC_NAME() {
	return PARENT_FORM_FILEID_DOC_NAME;
}


public void setPARENT_FORM_FILEID_DOC_NAME(String parent_form_fileid_doc_name) {
	PARENT_FORM_FILEID_DOC_NAME = parent_form_fileid_doc_name;
}


public File getUpload() {
	return upload;
}


public void setUpload(File upload) {
	this.upload = upload;
}


public String getContentType() {
	return contentType;
}


public void setContentType(String contentType) {
	this.contentType = contentType;
}


public String getUploadFileName() {
    return fileName;
}
public void setUploadFileName(String fileName) {
    this.fileName = fileName;
}


public String getIsCheckedOk() {
	return isCheckedOk;
}


public void setIsCheckedOk(String isCheckedOk) {
	this.isCheckedOk = isCheckedOk;
}


public int getMAX_LIMIT_MESSAGE_SIZE() {
	return MAX_LIMIT_MESSAGE_SIZE;
}


public void setMAX_LIMIT_MESSAGE_SIZE(int max_limit_message_size) {
	MAX_LIMIT_MESSAGE_SIZE = max_limit_message_size;
}


public String getPARENT_FORM_IMAGE_ID() {
	return PARENT_FORM_IMAGE_ID;
}


public void setPARENT_FORM_IMAGE_ID(String parent_form_image_id) {
	PARENT_FORM_IMAGE_ID = parent_form_image_id;
}


public String getUploadSate() {
	return uploadSate;
}


public void setUploadSate(String uploadSate) {
	this.uploadSate = uploadSate;
}

 
	
}
