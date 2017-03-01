package com.ailk.eaap.op2.conf.workFlowManager.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.common.StringUtil;
import com.ailk.eaap.op2.conf.workFlowManager.service.IWorkFlowSer;
import com.linkage.rainbow.ui.struts.BaseAction;

public class WorkFlowAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private static Log log = LogFactory.getLog(WorkFlowAction.class);
	private IWorkFlowSer workFlowManagerServ;
	private BizFunction bizFunction = new BizFunction();

    //获得业务流程的数据
	public List<Object> getBizData(HashMap map) {
		List<Object> list = new ArrayList<Object>();
		String id = (String) map.get("qweid");
		if ("0".equals(id)) {
//			Map mapRoot = new HashMap();
//			mapRoot.put("qweid", "root");
//			mapRoot.put("qwepId", 0);
//			mapRoot.put("qwepName",
//					getText("eaap.op2.conf.directory.manager.dirRoot"));
//			mapRoot.put("qweOpen", true);
//			mapRoot.put("qweIsParent", true);
//			list.add(mapRoot);
			//去除/结点，id重置为root
			id="root";
		} 
		if ("root".equals(id)) {
			bizFunction.setBizBizFunctionId(null);
		} else {
			bizFunction.setBizBizFunctionId(id);
		}

		if (!"0".equals(id)) {
			for (BizFunction biz : getWorkFlowManagerServ().selectBizFunctionByFaBizFunctionAndType(bizFunction)
					) {
				Map mapC = new HashMap();
				mapC.put("qweid", biz.getBizFunctionId());
				mapC.put("qwepId", id);
				mapC.put("qwepName", biz.getName());
				mapC.put("qweOpen", true);
				mapC.put("qweIsParent", true);
				list.add(mapC);
			}
		}

		return list;
	}


	//保存业务流程数据
	public String addWorkFlow() {
		 
		String fBziId = getRequest().getParameter("BizName");
		String name = getRequest().getParameter("name");
		String code = getRequest().getParameter("code");
		if (bizFunction.getName() == null || "".equals(bizFunction.getName())){
			bizFunction.setName(name);
		}
		if (bizFunction.getCode() == null || "".equals(bizFunction.getCode())){
			bizFunction.setCode(code);
		}
		
		if ("root".equals(fBziId) || fBziId.trim().length() <= 0) {
			bizFunction.setBizBizFunctionId(null);
		} else {
			bizFunction.setBizBizFunctionId(fBziId);
		}
		
		if(bizFunction.getName().trim().length() <= 0)
		{

			return INPUT;
		}
		else
		{
			getWorkFlowManagerServ().insertWorkFlow(bizFunction);
			
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
	//更新业务流程数据
	public String updateWorkFlow() {
		String bziId = getRequest().getParameter("bizFunctionId");
		String fBziId = getRequest().getParameter("bizBizFunctionId");
		String name = getRequest().getParameter("name");
		String code = getRequest().getParameter("code");
		if (bizFunction.getName() == null || "".equals(bizFunction.getName())){
			bizFunction.setName(name);
		}
		if (bizFunction.getCode() == null || "".equals(bizFunction.getCode())){
			bizFunction.setCode(code);
		}
		if (bizFunction.getBizFunctionId() == null || "".equals(bizFunction.getBizFunctionId().toString())){
			bizFunction.setBizFunctionId(Integer.parseInt(bziId));
		}
		if ("root".equals(fBziId) || fBziId.trim().length() <= 0) {
			bizFunction.setBizBizFunctionId(null);
		} else {
			bizFunction.setBizBizFunctionId(fBziId);
		}
		getWorkFlowManagerServ().updateWorkFlow(bizFunction);
		
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
	public  void deleWorkFlowNode(){
		try {
			String value = getRequest().getParameter("value");
			getWorkFlowManagerServ().deleWorkFlowNode(value);
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
	
	public String getWorkFlow(){
		String nodeWorkFlowId = getRequest().getParameter("NodeWorkFlowId");
		bizFunction.setBizFunctionId(Integer.parseInt(nodeWorkFlowId));
		bizFunction = getWorkFlowManagerServ().getWorkFlowNodeById(bizFunction);
		BizFunction b = new BizFunction();
		if(""!=bizFunction.getBizBizFunctionId()&&null!=bizFunction.getBizBizFunctionId()){
			b.setBizFunctionId(Integer.parseInt(bizFunction.getBizBizFunctionId()));
			dirName = getWorkFlowManagerServ().getWorkFlowNodeById(b).getName();
		}
		
 		return SUCCESS;
	}
	public String addDirectory(String DirId) {

		return SUCCESS;

	}

	public String getTestDataPre() {
		// 只用来跳转
		return SUCCESS;
	}
	
	public String openAddWorkFlow() {
		String nodeWorkFlowId = getRequest().getParameter("NodeWorkFlowId");
		if(StringUtils.isEmpty(nodeWorkFlowId)){
			return SUCCESS;
		}
		bizFunction.setBizFunctionId(Integer.parseInt(nodeWorkFlowId));
		bizFunction = getWorkFlowManagerServ().getWorkFlowNodeById(bizFunction);
		BizFunction b = new BizFunction();
		if(""!=bizFunction.getBizBizFunctionId()&&null!=bizFunction.getBizBizFunctionId()){
			b.setBizFunctionId(Integer.parseInt(bizFunction.getBizBizFunctionId()));
			dirName = getWorkFlowManagerServ().getWorkFlowNodeById(b).getName();
		}
		return SUCCESS;
	}

	public IWorkFlowSer getWorkFlowManagerServ() {
		if (workFlowManagerServ == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			workFlowManagerServ = (IWorkFlowSer) ctx
					.getBean("eaap-op2-conf-workFlowManager-WorkFlowManagerService");
		}
		return workFlowManagerServ;
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

	public boolean ajaxRMIString() {
		return false; 
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public boolean verifyDirName() {

		if (dirName.equals("e")) {
			return false;
		} else {
			return true;
		}
	}
    
	public void setWorkFlowManagerServ(IWorkFlowSer workFlowManagerServ) {
		this.workFlowManagerServ = workFlowManagerServ;
	}

	public BizFunction getBizFunction() {
		return bizFunction;
	}

	public void setBizFunction(BizFunction bizFunction) {
		this.bizFunction = bizFunction;
	}

	private String msg;
	private String dirName;

	public String getDirName() {
		return dirName;
	}

	public void setDirName(String dirName) {
		this.dirName = dirName;
	}
	
	public void isExistWorkFlowName(){
		   String name = getRequest().getParameter("name");
		   String bizBizFunctionId = getRequest().getParameter("bizBizFunctionId");
		   String bizFunctionId = getRequest().getParameter("bizFunctionId");
		   Map paramMap = new HashMap();
		   paramMap.put("name", name);
		   paramMap.put("bizBizFunctionId", bizBizFunctionId);
		   paramMap.put("bizFunctionId", bizFunctionId);
			String msg = "true";
			int cnt = this.getWorkFlowManagerServ().isExistWorkFlowName(paramMap);
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
	
	//修改时判断编码是否已存在
	public void isExistBizFunctionCodeWhenEdit(){
			String bizFunctionId = getRequest().getParameter("bizFunctionId");
			String bizFunctionCode = getRequest().getParameter("bizFunctionCode");
			Map paramMap = new HashMap();
			paramMap.put("bizFunctionId", bizFunctionId);
			paramMap.put("bizFunctionCode", bizFunctionCode);
			String msg = "true";
			int cnt = this.getWorkFlowManagerServ().isExistBizFunctionCodeWhenEdit(paramMap);
			if(cnt > 0){
				msg = "false";		//已存在
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
