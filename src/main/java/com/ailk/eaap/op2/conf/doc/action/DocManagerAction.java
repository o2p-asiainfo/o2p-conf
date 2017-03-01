package com.ailk.eaap.op2.conf.doc.action;

import java.util.ArrayList;


import java.util.Date;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;
import java.util.Set;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Writer;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.opensymphony.xwork2.ActionSupport;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.common.StringUtil;
import com.ailk.eaap.op2.conf.doc.service.IContractDocSer;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

public class DocManagerAction extends BaseAction {

	private Logger log = Logger.getLog(this.getClass());
	private static final long serialVersionUID = 1L;
	private List<Map<String, String>> pageParList = new ArrayList<Map<String,String>>();
	private ContractDoc contractDoc = new ContractDoc();
	private File file;
    private String fileFileName;
    private String fileFileContentType;
    private String message = "";
    private String delDocId;
    private IContractDocSer iContractDocSer;
    private List<Map<String,String>> docsList;
	private String reqFrom;
    
    private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
	
	public List<Map<String, String>> getPageParList() {
		return pageParList;
	}
	public void setPageParList(List<Map<String, String>> pageParList) {
		this.pageParList = pageParList;
	}
	public File getFile() {
		return file;
	}
	public void setFile(File file) {
		this.file = file;
	}
	public String getFileFileName() {
		return fileFileName;
	}
	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}
	public String getFileFileContentType() {
		return fileFileContentType;
	}
	public void setFileFileContentType(String fileFileContentType) {
		this.fileFileContentType = fileFileContentType;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public ContractDoc getContractDoc() {
		return contractDoc;
	}
	public void setContractDoc(ContractDoc contractDoc) {
		this.contractDoc = contractDoc;
	}
	public String getDelDocId() {
		return delDocId;
	}
	public void setDelDocId(String delDocId) {
		this.delDocId = delDocId;
	}
	 public List<Map<String, String>> getDocsList() {
		return docsList;
	}
	public void setDocsList(List<Map<String, String>> docsList) {
		this.docsList = docsList;
	}
	@JSON(serialize = false)
	public IContractDocSer getiContractDocSer() {
		if(iContractDocSer==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			iContractDocSer = (IContractDocSer)ctx.getBean("eaap-op2-conf-contractdoc-service") ;
	     }
		return iContractDocSer;
	}
	
	public String showManager(){
		loadDocs();
		return SUCCESS;
	}
	public void setiContractDocSer(IContractDocSer iContractDocSer) {
		this.iContractDocSer = iContractDocSer;
	}
	
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public Pagination getPage() {
		return page;
	}
	public void setPage(Pagination page) {
		this.page = page;
	}
	public Pagination getPagination() {
		return pagination;
	}
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	private void loadDocs(){
		Map map = new HashMap();
		pageParList = this.getiContractDocSer().showContractDocs(map);
	}
	public String getDocs(){
		loadDocs();
		return SUCCESS;
	}
	
	public String showPage(){
		return SUCCESS;
	}
	public String fileUploadJson(){
		if(contractDoc.getContractDocId()!=null){
			 try{
				 this.getiContractDocSer().updateContractDoc(contractDoc);
		        } catch(Exception e){
		        	message="Sorry，database is error";
		        }
		}else{
			 try{
				 if(null != contractDoc.getDocType() && !"".equals(contractDoc.getDocType())){
					 if(contractDoc.getDocType() .toUpperCase().endsWith(".WSDL")){
						 contractDoc.setDocType("1");
					 }else{
						 contractDoc.setDocType("");
					 }
				 }
		        this.getiContractDocSer().addContractDoc(contractDoc);
		        } catch(Exception e){
		        	message="Sorry，database is error";
		        }
		}
        return SUCCESS;
	}
	public String delDoc(){
		Map mapTemp = new HashMap();  
		mapTemp.put("contractDocId", delDocId);
		this.getiContractDocSer().delContracDoc(mapTemp);
		loadDocs();
		return SUCCESS;
	}
	public String showDocs(){
		return SUCCESS;
	}

	public Map  getContractDocList(Map prar){
		String selDocName  = getRequest().getParameter("selDocName");
		if(null == selDocName || "".equals(selDocName)){
			selDocName = null;
		}
		String selDocVersion = getRequest().getParameter("selDocVersion");
		if(null == selDocVersion || "".equals(selDocVersion)){
			selDocVersion = null;
		}
		String selResAliss = getRequest().getParameter("selResAliss");
		if(null == selResAliss ||  "".equals(selResAliss)){
			selResAliss = null;
		}
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<Map> tmpList = new ArrayList<Map>() ;  		 
         Map map = new HashMap() ;  
         map.put("docName", selDocName);
         map.put("docVersion", selDocVersion);
         map.put("resourceAliss", selResAliss);
   	       try {
			total= getiContractDocSer().countDocSum(map);
			} catch (Exception e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
           
   	       map.put("queryType", "") ;
   	       map.put("startPage", startRow);
           map.put("endPage", startRow+rows-1);
           
           map.put("startPage_mysql", startRow-1);
           map.put("endPage_mysql", rows);
           tmpList =getiContractDocSer().countDoc(map);
   		   
            returnMap.put("startRow", startRow);
            returnMap.put("rows", rows); 	
            returnMap.put("total", total);
            returnMap.put("dataList", page.convertJson(tmpList));	
   		return returnMap ;
   	}
	public String deleteDoc(){
		if(delDocId != null && !delDocId.equals("")){
			Map mapTemp = new HashMap();  
			mapTemp.put("contractDocId", delDocId);
			this.getiContractDocSer().delContracDoc(mapTemp);
		}
		return SUCCESS;
	}
	public String getReqFrom() {
		return reqFrom;
	}
	public void setReqFrom(String reqFrom) {
		this.reqFrom = reqFrom;
	}

	public void isExitDocName(){
		String name = getRequest().getParameter("name");
		Map<String,String> retMap = new HashMap<String,String>();
		HttpServletRequest req = this.getRequest();
		JSONObject json = new JSONObject();
		try {
			req.setCharacterEncoding("UTF-8");
			Writer wr = getResponse().getWriter();
			String js = StringUtil.getString(req.getInputStream(),"UTF-8");
			Map mapTemp = new HashMap();  
			mapTemp.put("name", name);
			int cnt = this.getiContractDocSer().isExitDocName(mapTemp);
			if(cnt==0){
				retMap.put("retCode", "1");
				retMap.put("retMsg", "ok");
			}else{
				retMap.put("retCode", "0");
				retMap.put("retMsg", "err");
			}
			json.putAll(retMap);
			wr.write(json.toString());
			wr.close();
		} catch (IOException e) {
			try {
				req.setCharacterEncoding("UTF-8");
				Writer wr = getResponse().getWriter();
				retMap.put("retCode", "-1");
				retMap.put("retMsg", "occur exception:"+e.getMessage());
				json.putAll(retMap);
				wr.write(json.toString());
				wr.close();
			} catch (Exception e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
		}
	}
	
	public void isResAlissExit(){
		String name = getRequest().getParameter("name");
		Map<String,String> retMap = new HashMap<String,String>();
		HttpServletRequest req = this.getRequest();
		JSONObject json = new JSONObject();
		try {
			req.setCharacterEncoding("UTF-8");
			Writer wr = getResponse().getWriter();
			String js = StringUtil.getString(req.getInputStream(),"UTF-8");
			Map mapTemp = new HashMap();  
			mapTemp.put("name", name);
			int cnt = this.getiContractDocSer().isResAlissExit(mapTemp);
			if(cnt==0){
				retMap.put("retCode", "1");
				retMap.put("retMsg", "ok");
			}else{
				retMap.put("retCode", "0");
				retMap.put("retMsg", "err");
			}
			json.putAll(retMap);
			wr.write(json.toString());
			wr.close();
		} catch (IOException e) {
			try {
				req.setCharacterEncoding("UTF-8");
				Writer wr = getResponse().getWriter();
				retMap.put("retCode", "-1");
				retMap.put("retMsg", "occur exception:"+e.getMessage());
				json.putAll(retMap);
				wr.write(json.toString());
				wr.close();
			} catch (Exception e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
		}
	}
}
