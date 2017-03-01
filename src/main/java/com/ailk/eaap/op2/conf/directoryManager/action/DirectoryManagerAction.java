package com.ailk.eaap.op2.conf.directoryManager.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.ailk.eaap.op2.bo.Directory;
import com.ailk.eaap.op2.common.StringUtil;
import com.ailk.eaap.op2.conf.directoryManager.service.IDirectoryManagerService;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.opensymphony.xwork2.ActionContext;
@SuppressWarnings("all")
public class DirectoryManagerAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private static Log log = LogFactory.getLog(DirectoryManagerAction.class);
	private IDirectoryManagerService directoryManagerServ;
	private Directory directory = new Directory();
	private List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
	
	public Directory getDirectory() {
		return directory;
	}

	public void setDirectory(Directory directory) {
		this.directory = directory;
	}

	private String msg;
	private String dirName;

	public String getDirName() {
		return dirName;
	}

	public void setDirName(String dirName) {
		this.dirName = dirName;
	}

	public IDirectoryManagerService getDirectoryManagerServ() {
		if (directoryManagerServ == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			directoryManagerServ = (IDirectoryManagerService) ctx
					.getBean("eaap-op2-conf-directoryManager-DirectoryManagerService");
		}
		return directoryManagerServ;
	}

	public void setDirectoryManagerServ(
			IDirectoryManagerService directoryManagerServ) {
		this.directoryManagerServ = directoryManagerServ;
	}


	public List<Object> getDirDataReg(Map map) {
		directory.setDirType("0");
		return getDirData(map);
	}

	public List<Object> getDirDataApi(Map map) {
		directory.setDirType("0");
		return getDirData(map);
	}

	public List<Object> getDirDataHelp(Map map) {
		directory.setDirType("0");
		return getDirData(map);
	}

	public List<Object> getDirData(Map map) {

 	    
		List<Object> list = new ArrayList<Object>();
		String id = (String) map.get("qweid");
		if ("0".equals(id)) {
			Map mapRoot = new HashMap();
			mapRoot.put("qweid", "root");
			mapRoot.put("qwepId", 0);
			mapRoot.put("qwepName",
					getText("eaap.op2.conf.directory.manager.dirRoot"));
			mapRoot.put("qweOpen", true);
			mapRoot.put("qweIsParent", true);
			list.add(mapRoot);
			// directory.setFaDirId(null);
		} else if ("root".equals(id)) {
			directory.setFaDirId(null);
		} else {
			directory.setFaDirId(Integer.parseInt(id));
		}

		if (!"0".equals(id)) {
			for (Directory dir : getDirectoryManagerServ()
					.selectDirectoryByFaDirIdAndType(directory)) {
				Map mapC = new HashMap();
				mapC.put("qweid", dir.getDirId());
				mapC.put("qwepId", id);
				mapC.put("qwepName", dir.getDirName());
				mapC.put("qweOpen", true);
				mapC.put("qweIsParent", true);
				list.add(mapC);
				
			}
		}

		return list;
	}

	public String execute() {
		return SUCCESS;
	}
   public void deleDirNode(){
		try {
			String value = getRequest().getParameter("value");
			getDirectoryManagerServ().deleDirNode(value);
	        String msg = "{\"message\":\"OK\"}";
	        getResponse().getWriter().print(msg);
		} catch (Exception e) {
	        String msg = "{\"message\":\"REEOR\"}";
	        try {
				getResponse().getWriter().print(msg);
			} catch (IOException e1) {
				log.error(e1.getStackTrace());
			}
		}
   }
    public String showAddDirNodeData(){
    	String dirIdStr = getRequest().getParameter("nodeDirId");
		if(StringUtils.isNotEmpty(dirIdStr)){
			directory.setDirId(Integer.parseInt(dirIdStr));
			directory = getDirectoryManagerServ().queryDirById(directory);
			Directory d = new Directory();
			if(null!=directory.getFaDirId()){
				d.setDirId(directory.getFaDirId());
				this.dirName = getDirectoryManagerServ().queryDirById(d).getDirName();
			}
		}
    	
    	
	   	Map Map1 = new HashMap();
 	    Map1.put("name", getText("eaap.op2.conf.directory.manager.addApiTypeDirTile"));
 	    Map1.put("dirNodeId", "0");
 	    Map Map2 = new HashMap();
 	    Map2.put("name", getText("eaap.op2.conf.directory.manager.addRegTypeDirTile"));
 	    Map2.put("dirNodeId", "1");
 	    resultList.add(Map1);
 	    resultList.add(Map2);
    	    return SUCCESS;
    }
	private String s;

	public String getService() {
		return "gg";
	}

	public void setService(String sa) {
		s = sa;
	}

	public String DirectoryMgr() {

			return SUCCESS;
	}
	
	public String addDirectory() {
		
		String fDirId = getRequest().getParameter("faDirId");
		String dirName = getRequest().getParameter("dirName");
		String sFileId = getRequest().getParameter("sFileId");
		String dirType = getRequest().getParameter("dirType");
		if (directory.getDirName() == null || "".equals(directory.getDirName())){
			directory.setDirName(dirName);
		}
		if ((directory.getSFileId() == null) && (sFileId!=null && !"".equals(sFileId))){
			directory.setSFileId(Integer.parseInt(sFileId));
		}
		if (directory.getDirType() == null || "".equals(directory.getDirType())){
			directory.setDirType(dirType);
		}
		
		if ("root".equals(fDirId) || fDirId == null || fDirId.trim().length() <= 0) {
			directory.setFaDirId(null);
		} else {
			directory.setFaDirId(Integer.parseInt(fDirId));
		}
		
		if(directory.getDirName().trim().length() <= 0)
		{

			return INPUT;
		}
		else
		{
			getDirectoryManagerServ().insertServiceManager(directory);
			
			msg = "true";
			PrintWriter pw;
			try {
				pw = getResponse().getWriter();
				pw.write(msg) ;
				pw.close() ;
			} catch (IOException e) {
				log.error(e.getStackTrace());
			}
			
			return SUCCESS;
		}
	}
	public String updateDirectory() {
		
		String dirId = getRequest().getParameter("dirId");
		String fDirId = getRequest().getParameter("faDirId");
		String dirName = getRequest().getParameter("dirName");
		String sFileId = getRequest().getParameter("sFileId");
		String dirType = getRequest().getParameter("dirType");
		if (directory.getDirId() == null || "".equals(directory.getDirId())){
			directory.setDirId(Integer.parseInt(dirId));
		}
		if (directory.getDirName() == null || "".equals(directory.getDirName())){
			directory.setDirName(dirName);
		}
		if ((directory.getSFileId() == null) && !"".equals(sFileId)){
			directory.setSFileId(Integer.parseInt(sFileId));
		}
		if (directory.getDirType() == null || "".equals(directory.getDirType())){
			directory.setDirType(dirType);
		}
		
		if ("root".equals(fDirId) || fDirId == null || fDirId.trim().length() <= 0) {
			directory.setFaDirId(null);
		} else {
			directory.setFaDirId(Integer.parseInt(fDirId));
		}
		getDirectoryManagerServ().updateServiceManager(directory);
		
		msg = "true";
		PrintWriter pw;
		try {
			pw = getResponse().getWriter();
			pw.write(msg) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		return NONE;
	}

	public String getDirById(){
		String dirIdStr = getRequest().getParameter("nodeDirId");
		if(StringUtils.isNotEmpty(dirIdStr)){
			directory.setDirId(Integer.parseInt(dirIdStr));
			directory = getDirectoryManagerServ().queryDirById(directory);
			Directory d = new Directory();
			if(null!=directory.getFaDirId()){
				d.setDirId(directory.getFaDirId());
				this.dirName = getDirectoryManagerServ().queryDirById(d).getDirName();
			}
		}
		return SUCCESS;
	}
	
	public String addDirectory(String DirId) {

		return SUCCESS;

	}

	public String getTestDataPre() {
		// ֻ������ת
		return SUCCESS;
	}

	public boolean ajaxRMIString() {
		return false;// "str1:"+str1+" str2:"+str2+" str3:"+str3;

	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public boolean verifyDirName() {

		if (dirName == "e") {
			return false;
		} else {
			return true;
		}
	}

	public List<Map<String, Object>> getResultList() {
		return resultList;
	}

	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}
	
	public void isChildDir(){
		String faDirIdStr = getRequest().getParameter("faDirId");
		Integer faDirId = new Integer(faDirIdStr);
		String dirIdStr = getRequest().getParameter("dirId");
		Integer dirId = new Integer(dirIdStr);
		boolean isChild = ChildContainSelf(faDirId, dirId);
		PrintWriter pw;
		String msg = isChild+"";
		try {
			pw = getResponse().getWriter();
			pw.write(msg) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		
	}
	
	public boolean ChildContainSelf(Integer faDirId,Integer dirId){
		Directory d = new Directory();
		d.setDirId(dirId);
		
		Directory resultD = this.getDirectoryManagerServ().queryDirById(d);
		if(resultD!=null){
			
			if(resultD.getFaDirId().intValue()==faDirId.intValue()){
				return false;
			}else{
				return ChildContainSelf(faDirId, resultD.getFaDirId().intValue());
			}
		}else{
			return true;
		}
		
	}
	
   public void isExistDirName(){
		    String dirName = getRequest().getParameter("dirName");
		    String faDirId = getRequest().getParameter("faDirId");
		    String dirType = getRequest().getParameter("dirType");
		    String dirId = getRequest().getParameter("dirId");
		    Map paramMap = new HashMap();
		    paramMap.put("dirName", dirName);
		    paramMap.put("faDirId", faDirId);
		    paramMap.put("dirType", dirType);
		    paramMap.put("dirId", dirId);
			Map<String,String> retMap = new HashMap<String,String>();
			HttpServletRequest req = this.getRequest();
			JSONObject json = new JSONObject();
			String msg = "true";
			int cnt = this.getDirectoryManagerServ().isExistDirName(paramMap);
			if(cnt > 0){
				msg = "false";
			}
			PrintWriter pw;
			try {
				pw = getResponse().getWriter();
				pw.write(msg) ;
				pw.close() ;
			} catch (IOException e) {
				log.error(e.getStackTrace());
			}
   }
}
