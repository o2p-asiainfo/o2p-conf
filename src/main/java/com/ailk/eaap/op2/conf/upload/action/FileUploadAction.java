package com.ailk.eaap.op2.conf.upload.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
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
 * 文件上传下载公共Action,支持同时上传多个文件
 * 前端js组件为jquery uploadify
 * Author: chenwei
 * date  : 2013-09-07
 */
public class FileUploadAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	protected final Log log = LogFactory.getLog(FileUploadAction.class);
	/**上传文档对象**/
	private File uploadify;
	/**文档名称**/
	private String uploadifyFileName;
	
	private FileShare fileShare = new FileShare();
    private IFileShareServ fileShareService ;
    
    /**下载区域变量**/
    private InputStream inputStream; //输出流变量
	private String fileFileName;    //下载文件名
	private String contentType;     //下载文件类型
    
	/**上传文件*/
    public String uploadFile (){
    	fileShare.setSFileContent(uploadify) ;
    	fileShare.setSFileName(uploadifyFileName) ;
		
		UploadReturnMsg  returnMsg = new UploadReturnMsg();
		//文件入库
	   Integer imgId = getFileShareService().saveFileShare(fileShare) ;
	   returnMsg.setC_md5("");
	   returnMsg.setC_size(uploadify.length());
	   returnMsg.setC_url(imgId+"");
	   this.writeToResponse(getResponse(), returnMsg.wrappedSuccessMsg());
       return null;
    }
    
    /**
     * struts2的文件下载
     * contentType doc-word,xls-excel,来源于上传后显示已上传文件a标签url
     **/
    public String downloadFile(){
    	try {
    		//1 设置下载的文件名
        	String sfileId = getRequest().getParameter("fileShare.sFileId");
    		String contentType = getRequest().getParameter("contentType");
    		 	
    		fileShare.setSFileId(Integer.parseInt(sfileId));
    		String fileName = (String)getFileShareService().selectFileShare(fileShare).get(0).get("S_FILE_NAME") ;
    		this.setFileFileName(fileName);
    		
        	//2 设置下载的文件类型
    		if ("doc".equals(contentType)){
    			this.setContentType("application/vnd.ms-word;charset=ISO8859-1");
    		}else if ("xls".equals(contentType)){
    			this.setContentType("application/vnd.ms-excel;charset=ISO8859-1");
    		}
    		
    		//3 设置inputStream
    		List<Map> files=getFileShareService().selectFileShare(fileShare);
    		
    		byte[] byteArr =(byte[]) files.get(0).get("S_FILE_CONTENT");
    		InputStream is = new ByteArrayInputStream(byteArr);
    		this.setInputStream(is);
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
    	return SUCCESS;
    }
    
    /**输出流**/
    public InputStream getInputStream() {
		return inputStream;
	}

    /**提供转换编码后供下载用的文件名**/
	public String getFileFileName() {
		 try {   
			 getResponse().setHeader("charset","ISO8859-1");  
			 return new String(this.fileFileName.getBytes(), "ISO8859-1");   
         } catch (UnsupportedEncodingException e) {   
        	 log.error(e.getStackTrace());
             return null;
         }
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
    
    public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
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
	        //取得spring上下文
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			fileShareService = (IFileShareServ)ctx.getBean("eaap-op2-conf-fileShareServ");
	     }
		return fileShareService;
	}
	public void setFileShareService(IFileShareServ fileShareService) {
		this.fileShareService = fileShareService;
	}
}
