package com.ailk.eaap.op2.conf.upload.action;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.util.Map;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.FileShare;
import com.ailk.eaap.op2.conf.upload.dto.UploadReturnMsg;
import com.ailk.eaap.op2.conf.upload.serv.IFileShareServ;
import com.linkage.rainbow.ui.struts.BaseAction;
/**
 * ͼƬ�ϴ�����Action,֧��ͬʱ�ϴ�����ͼƬ
 * ǰ��js���Ϊjquery uploadify
 * Author: chenwei
 * date  : 2013-09-06
 */

public class ResourceUploadAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	protected final Log log = LogFactory.getLog(ResourceUploadAction.class);
	/**�ϴ�ͼƬ����**/
	private File uploadify;
	private File uploadifyOther;
	/**ͼƬ���?*/
	private String uploadifyFileName; 
	private String uploadifyOtherFileName;
	/**����ͼƬĬ������ֽ���?*/
	private int MAX_LIMIT_MESSAGE_SIZE = 1*1024*1024;
	
	private FileShare fileShare = new FileShare();
	private IFileShareServ fileShareService ;
    
    /**�ϴ�ͼƬ**/
    public String uploadImage(){
    	 fileShare.setSFileName(uploadifyFileName) ;
		 fileShare.setSFileContent(uploadify) ;
		 
		 UploadReturnMsg  returnMsg = new UploadReturnMsg();
		 //�ϴ�ͼƬ���������������ֽ���
		 if(uploadify.length() > MAX_LIMIT_MESSAGE_SIZE){
			 returnMsg.setC_size(uploadify.length());
			 this.writeToResponse(getResponse(), returnMsg.wrappedErrorMsg());
			 return null;
		 }
		 
		 //ͼƬ���?
		 Integer imgId = getFileShareService().saveFileShare(fileShare) ;
		 returnMsg.setC_md5("");
		 returnMsg.setC_size(uploadify.length());
		 returnMsg.setC_url(imgId+"");
		 this.writeToResponse(getResponse(), returnMsg.wrappedSuccessMsg());
		 
//TODO
//ͼƬ�ϴ��迼��ͬһ���������ϴ�����ͼƬʱ�Ƿ����ظ�����,file_share��������(�����ļ�md5�����ܳ����ֶ�),����ʵ��
    	return null;
    }
    
    public String twiceUploadImage(){
   	 	 fileShare.setSFileName(uploadifyOtherFileName) ;
		 fileShare.setSFileContent(uploadifyOther);
		 
		 UploadReturnMsg  returnMsg = new UploadReturnMsg();
		 //�ϴ�ͼƬ���������������ֽ���
		 if(uploadifyOther.length() > MAX_LIMIT_MESSAGE_SIZE){
			 returnMsg.setC_size(uploadifyOther.length());
			 this.writeToResponse(getResponse(), returnMsg.wrappedErrorMsg());
			 return null;
		 }
		 
		 //ͼƬ���?
		 Integer imgId = getFileShareService().saveFileShare(fileShare) ;
		 returnMsg.setC_md5("");
		 returnMsg.setC_size(uploadifyOther.length());
		 returnMsg.setC_url(imgId+"");
		 this.writeToResponse(getResponse(), returnMsg.wrappedSuccessMsg());
		 
//TODO
//ͼƬ�ϴ��迼��ͬһ���������ϴ�����ͼƬʱ�Ƿ����ظ�����,file_share��������(�����ļ�md5�����ܳ����ֶ�),����ʵ��
   	return null;
   }
    
    /**����ݿ��ж�ȡͼ�?*/
    public String readImage(){
    	OutputStream ops =null;
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
	  		response.setContentType("image/png") ;
  		 
	  		ops = response.getOutputStream();
	  		if (byteArr!=null && byteArr.length>0){
	  			for (int i = 0; i < byteArr.length; i++) {
		  			ops.write(byteArr[i]);
		  		}
	  		}
	  		
  		} catch (Exception e) {
  			log.error(e.getStackTrace());
  		}finally{
  			try {
  				if (ops != null) {
  					ops.flush();
  	  				ops.close();
  				}
  			} catch (IOException e) {
  				log.error(e.getStackTrace());
  			}
  		}
  		return null ;
	}
    
    
    private void writeToResponse(HttpServletResponse res, String msg){
    	try {
			PrintWriter out = res.getWriter();
			out.print(msg);
			out.flush();
			out.close();
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
    }
    
	public File getUploadify() {
		return uploadify;
	}
	public void setUploadify(File uploadify) {
		this.uploadify = uploadify;
	}
	public String getUploadifyFileName() {
		return uploadifyFileName;
	}
	public void setUploadifyFileName(String uploadifyFileName) {
		this.uploadifyFileName = uploadifyFileName;
	}
	public FileShare getFileShare() {
		return fileShare;
	}
	public void setFileShare(FileShare fileShare) {
		this.fileShare = fileShare;
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

	public File getUploadifyOther() {
		return uploadifyOther;
	}

	public void setUploadifyOther(File uploadifyOther) {
		this.uploadifyOther = uploadifyOther;
	}

	public String getUploadifyOtherFileName() {
		return uploadifyOtherFileName;
	}

	public void setUploadifyOtherFileName(String uploadifyOtherFileName) {
		this.uploadifyOtherFileName = uploadifyOtherFileName;
	}

}
