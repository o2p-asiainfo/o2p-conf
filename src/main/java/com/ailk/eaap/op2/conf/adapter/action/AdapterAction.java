/**
 * @(#)AdapterAction.java        2013-8-20
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */
package com.ailk.eaap.op2.conf.adapter.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oracle.sql.CLOB;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.ProtocolAdapter;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.common.StringUtil;
import com.ailk.eaap.op2.conf.adapter.service.IAdapterService;
import com.ailk.eaap.op2.conf.adapter.util.AdapterConfigConstant;
import com.ailk.eaap.op2.conf.adapter.util.DataInteractiveUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

/**
 * 类名称<br>
 * 这里是类的描述区域，概括出该的主要功能或者类的使用范围、注意事项等
 * <p>
 * @version 1.0
 * @author Administrator 2013-8-20
 * <hr>
 * 修改记录
 * <hr>
 * 1、修改人员:    修改时间:<br>       
 *    修改内容:
 * <hr>
 */

public class AdapterAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Logger log = Logger.getLog(this.getClass());
	
	public IAdapterService adapterService;
	
	public String adapterId;
	
	public ProtocolAdapter protocolAdapter;
	
	public String inputUrl;
	
	public List dataSetList;
	
	public List extendList;
	
	public List<Map<String,String>> msgSwitchModeList = new ArrayList<Map<String,String>>();
	
	public List<Map<String,String>> adapterStateList = new ArrayList<Map<String,String>>();
	
	public List<Map<String,String>> dataSourceTypeList = new ArrayList<Map<String,String>>();
	
	public List<Map<String,String>> typeL = new ArrayList<Map<String,String>>();
	
	
	public List<Map<String, String>> getTypeL() {
		return typeL;
	}

	public void setTypeL(List<Map<String, String>> typeL) {
		this.typeL = typeL;
	}

	public List<Map> dataSourcelist;
	private Pagination page = new Pagination();
	
	//协议适配模型的action
	List<Map<String,Object>> scriptL = new ArrayList<Map<String,Object>>();
	List<Map<String,Object>> metaDataMachingL = new ArrayList<Map<String,Object>>();
	
	public List<Map<String, Object>> getMetaDataMachingL() {
		Map map = new HashMap();
   		map.put("id","1");
   		map.put("val",getText("eaap.op2.conf.adapter.fromDb"));
   		this.metaDataMachingL.add(map);
   		Map map1 = new HashMap();
   		map1.put("id","2");
   		map1.put("val",getText("eaap.op2.conf.adapter.fromHost"));
   		this.metaDataMachingL.add(map1);
		return metaDataMachingL;
	}

	public void setMetaDataMachingL(List<Map<String, Object>> metaDataMachingL) {
		this.metaDataMachingL = metaDataMachingL;
	}

	//选择协议返回数据
	private String contractName;
	private String contractVersionName;
	private String contractVersionId;
	private String contractId;
	private String chooseTcpCtrFId;
	private String contractType;
	private String chooseReqRspFlag;
	
	private int tcpCtrFId;
	private int noTcpCtrFId;
	private String reqRspFlag;
	private String loadSideFlg;
	private String contractVersion;
	private String contractVersionType;
	private String httpType;
	private String drawJson;
	
	private int rows;
	private int pageNum;
	private int total;
    private Pagination pagination = new Pagination();
    
    private Map contractTypeMap = new HashMap() ;
    private List<Map> httpTypeList = new ArrayList<Map>() ;
    private List<Map> contractTypeList = new ArrayList<Map>() ;
    
    //测试脚本变量
    private File scriptFileUpload;
    private File originalFileUpload; 
    private String scriptFileText; 
    private String originalFileText; 
    private int adapterType; 
    private int srcTcpCtrFId;
    private int tarTcpCtrFId;
    private String adapterTypeName;
    private Integer contractAdapterId;
    private String sourceMessageText; 
    private String testUniversalResult; 
    
    private String spath;
    private String sname;
    private String tpath;
    private String lineid;
    private Integer contractAdapterID;
    private String adapter_name;
    private String consMapCD;
    
    //初始化
    private int transformerRuleId;
    private int srcContractId;
    private int  srcContractVersionId;
    private String srcReqRspFlag;
    private String srcContractName;
    private String srcContractVersionName;
    private String srcContractType ;
    private int tarContractId;
    private int  tarContractVersionId;
    private String tarReqRspFlag;
    private String tarContractName;
    private String tarContractVersionName;
    private String tarContractType ;
    
 //adapter弹出框初始化
	private String attrName;
	private String objectId;
	private String endpoint_Spec_Attr_Id;
	private String transformer;
	private String chooseTransformerRuleId;
	private String pageState;
	private String sourceType;
    
	
	/**
	 * 跳转至协议配置主界面
	 * @return
	 */
	public String toMainAdapterConfig(){

		return SUCCESS;
	}
	
	public String adapterManagerSave(){
		return SUCCESS;
	}
	/**
	 * 跳转至数据集管理
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String toDataSetManager(){
		return SUCCESS;
	}
	
	/**---------------------------------------------------------------------------------------------------
	 * 保存协议适配
	 * @return
	 */
	public void saveAdapterConfig(){
		Map paramMap = new HashMap();
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		String sid = getRequest().getParameter("sid");
		String tid = getRequest().getParameter("tid");
		String type = getRequest().getParameter("type");
		String svname = getRequest().getParameter("svname");
		String tvname = getRequest().getParameter("tvname");
		String adapter_name = svname+getText("eaap.op2.conf.adapter.contractAdapter")+tvname;
		if(null != adapter_name){
			if(adapter_name.length()> 80){
				adapter_name = adapter_name.substring(0, 80);
			}
		}
		paramMap.put("sid", Integer.parseInt(sid));
		paramMap.put("tid", Integer.parseInt(tid));
		paramMap.put("type", Integer.parseInt(type));
		paramMap.put("adapter_name", adapter_name);
		paramMap.put("state", "S");
		if(null != contractAdapterID && contractAdapterID > 0){//说明有适配ID存在
			Map<String,String> map = new HashMap<String,String>();
			map.put("srcTcpCtrFId", sid);
			map.put("tarTcpCtrFId", tid);
			map.put("adapterName", adapter_name);
			map.put("adapterType", type);
			map.put("scriptSrc", "");
			map.put("contractAdapterId", contractAdapterID+"");
			getAdapterService().updateContractAdapter(map);
		}else{
			contractAdapterID = getAdapterService().addContractAdapter(paramMap);
		}
		this.setContractAdapterID(contractAdapterID);
		this.setAdapter_name(adapter_name);
		getRequest().getSession().setAttribute("contractAdapterID", this.getContractAdapterID());
		getRequest().getSession().setAttribute("adapter_name", adapter_name);
		retMap.put("adapter_name", adapter_name);
		retMap.put("contractAdapterID", contractAdapterID+"");
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage()+"contractAdapterId :"+this.getContractAdapterID(),null));
		}
	}
	public String saveNodeDescMap(){
		Map paramMap = new HashMap();
		Integer contractAdapterID = (Integer) getRequest().getSession().getAttribute("contractAdapterID");
		String src_node_desc_id = getRequest().getParameter("sid");
		String tar_node_desc_id = getRequest().getParameter("tid");
		String action_type_cd = getRequest().getParameter("type");
		
		if(null!=src_node_desc_id&& !"".equals(src_node_desc_id))
			paramMap.put("src_node_desc_id", Integer.parseInt(src_node_desc_id));
		paramMap.put("tar_node_desc_id", Integer.parseInt(tar_node_desc_id));
		paramMap.put("action_type_cd", action_type_cd);
		paramMap.put("contract_adapter_id", contractAdapterID);
		if(null!=contractAdapterID){
			if(this.getAdapterService().isNodeMapDecExit(paramMap)){
				this.getAdapterService().addNodeDescMap(paramMap);
				if("M".equals(paramMap.get("action_type_cd"))){
					/*Map map = new HashMap();
					map.put("nodeDescId", paramMap.get("tar_node_desc_id"));
					map.put("contractAdapterId", contractAdapterID);
					map.put("consMapCD", null);
					map.put("nodeValueSourceCd", "1");
					this.getAdapterService().addNodeValAdapterRes(map);*/
				}
			}else{
				this.getAdapterService().updateNodeDescMap(paramMap);
			}
		}
		return NONE;
	}
	
	public String addNodeValAdapterRes(){
		Map map = new HashMap();
		Integer mapingID;
		Integer contractAdapterID = (Integer) getRequest().getSession().getAttribute("contractAdapterID");
		//String actionType = getRequest().getParameter("actionType");
		String tar_node_desc_id = getRequest().getParameter("tid");
		String assignVal = getRequest().getParameter("assignVal");
		String assignCondition = getRequest().getParameter("assignCondition");
		String way = getRequest().getParameter("way");
		String nodeValAdapterReqId = getRequest().getParameter("nodeValAdapterReqId");
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		map.put("nodeDescId", tar_node_desc_id);
		map.put("contractAdapterId",  contractAdapterID);
		map.put("nodeValueSourceCd", way);
		map.put("valueExpress", assignVal);
		map.put("triggerExpress", assignCondition);
		boolean isExit =  this.getAdapterService().isExitNodeValReq(map);
		if(isExit){//存在说明是修改
			map.put("mapingID", nodeValAdapterReqId);
			retMap.put("code", "1");
			retMap.put("mapingID", nodeValAdapterReqId+"");
			this.getAdapterService().updateNodeValAdapterRes(map);
			json.putAll(retMap);
			try {
				DataInteractiveUtil.actionResponsePage(getResponse(), json);
			} catch (Exception e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		}else{
			mapingID = this.getAdapterService().addNodeValAdapterRes(map);
			retMap.put("code", "1");
			retMap.put("mapingID", mapingID+"");
			json.putAll(retMap);
			try {
				DataInteractiveUtil.actionResponsePage(getResponse(), json);
			} catch (Exception e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		}
//		if("add".equals(actionType)){
//			mapingID = this.getAdapterService().addNodeValAdapterRes(map);
//			retMap.put("code", "1");
//			retMap.put("mapingID", mapingID+"");
//			json.putAll(retMap);
//			try {
//				DataInteractiveUtil.actionResponsePage(getResponse(), json);
//			} catch (Exception e) {
//				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//			}
//		}else{
//			map.put("mapingID", nodeValAdapterReqId);
//			retMap.put("code", "1");
//			retMap.put("mapingID", nodeValAdapterReqId+"");
//			this.getAdapterService().updateNodeValAdapterRes(map);
//			json.putAll(retMap);
//			try {
//				DataInteractiveUtil.actionResponsePage(getResponse(), json);
//			} catch (Exception e) {
//				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//			}
//		}
		return NONE;
	}
	public String queryVarNodeReq(){
		String mapingID = getRequest().getParameter("mapingID");
		List<Map> l = new ArrayList<Map>();
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		if(null!=mapingID && !"".equals(mapingID) && !"null".equals(mapingID)){
			Map mapTemp = new HashMap();  
			mapTemp.put("nodeValAdapterReqId", mapingID);		///
			l = this.getAdapterService().queryValAdapterResByMapingID(mapTemp);
			for(Map m : l){
				retMap.put("assignConditionVal", (String) m.get("TRIGGER_EXPRESS"));
				retMap.put("wayVal", (String) m.get("NODE_VALUE_SOURCE_CD"));
				retMap.put("code", "1");
				if("2".equals(m.get("NODE_VALUE_SOURCE_CD"))){
					retMap.put("assignVal", (String) m.get("VALUE_EXPRESS"));
				}else if("3".equals(m.get("NODE_VALUE_SOURCE_CD"))){
					Map map = new HashMap();
					map.put("consMapTypeCD", (String) m.get("VALUE_EXPRESS"));
					List<Map> ll = new ArrayList<Map>();
					ll = this.getAdapterService().queryVarMapTypeByID(map);
					for(Map mm : ll){
						retMap.put("name", (String) mm.get("NAME"));
						retMap.put("varMapTypeID", mm.get("VAR_MAP_TYPE_ID")+"");
					}
					retMap.put("consMapCD", (String) m.get("VALUE_EXPRESS"));
				}else if("4".equals(m.get("NODE_VALUE_SOURCE_CD"))){
					retMap.put("assignVal", (String) m.get("SCRIPT"));
				}
			}
			json.putAll(retMap);
			try {
				DataInteractiveUtil.actionResponsePage(getResponse(), json);
			} catch (Exception e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		}
		return NONE;
	}
	public String delNodeDescMap(){
		String src_node_desc_id = getRequest().getParameter("sid");
		String tar_node_desc_id = getRequest().getParameter("tid");
		Integer contractAdapterID = (Integer) getRequest().getSession().getAttribute("contractAdapterID");
		String nodeValAdapterReqId = getRequest().getParameter("nodeValAdapterReqId");
		
		Map map = new HashMap();
		if(!"".equals(src_node_desc_id)&&null!=src_node_desc_id){
			map.put("sid", Integer.parseInt(src_node_desc_id));
		}
		map.put("nodeDescId", Integer.parseInt(tar_node_desc_id));
		map.put("contractAdapterId", contractAdapterID);
		map.put("consMapCD", consMapCD);
		map.put("mapingId", nodeValAdapterReqId);
		this.getAdapterService().delNodeDescMap(map);
		this.getAdapterService().delNodeValAdapterRea(map);//删除节点取值要求
		return NONE;
	}
	public String addVarMapType(){
		Integer contractAdapterID = (Integer) getRequest().getSession().getAttribute("contractAdapterID");
		String adapter_name = getRequest().getParameter("name");
		String consMapCD = getRequest().getParameter("consMapCD");
		String varMapTypeID = getRequest().getParameter("varMapTypeID");
		String nodeDescId = getRequest().getParameter("tid");
		Map map = new HashMap();
		Integer cnt ;
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		map.put("contractAdapterId", contractAdapterID);
		map.put("name", adapter_name);
		map.put("consMapCD", consMapCD);
		map.put("nodeDescId", Integer.parseInt(nodeDescId));
		if(contractAdapterID!=null){
			if(!"".equals(varMapTypeID)&&null!=varMapTypeID){
				map.put("varMapTypeId", varMapTypeID);
				this.getAdapterService().updateVarMapType(map);
				retMap.put("code", "1");
				retMap.put("errMsg", varMapTypeID);
			}else{
				cnt = this.getAdapterService().isVarMapTypeExit(map);
				if(0==cnt){
					Integer id = this.getAdapterService().saveVarMapType(map);
					retMap.put("code", "1");
					retMap.put("errMsg", id+"");
				}else{
					retMap.put("code", "0");
					retMap.put("errMsg", getText("eaap.op2.conf.adapter.varMapTypeExist"));
				}
			}
		}
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	return NONE;
	}
	public String saveOrUpdateVariableMap(){
		String consMapCD = getRequest().getParameter("consMapCD");
		String dataSource = getRequest().getParameter("source");
		String keyExpress = getRequest().getParameter("key");
		String valExpress = getRequest().getParameter("val");
		String actionType = getRequest().getParameter("actionType");
		String varMapingID = getRequest().getParameter("varMapingID");
		
		Map map = new HashMap();
		map.put("consMapCD", consMapCD);
		map.put("dataSource", dataSource);
		map.put("keyExpress", keyExpress);
		map.put("valExpress", valExpress);
		map.put("contractAdapterId",getRequest().getSession().getAttribute("contractAdapterID") );
		
		if(varMapingID!=null&&varMapingID!=""){
			map.put("varMapingID", Integer.parseInt(varMapingID));
		}
		if("insert".equals(actionType)){
			this.getAdapterService().saveVariableMap(map);
		}else if("update".equals(actionType)){
			this.getAdapterService().updateVariableMap(map);
		}
		
		return NONE;
	}
	public String delVariableMap(){
		String varMapingID = getRequest().getParameter("varMapingID");
		Map mapTemp = new HashMap();  
		mapTemp.put("varMapingID", varMapingID);		
		this.getAdapterService().delVariableMap(mapTemp);
		Map map = new HashMap();
		map.put("contractAdapterId",getRequest().getSession().getAttribute("contractAdapterID") );
		map.put("varMapingId", varMapingID);
		this.getAdapterService().updateTransScript(map);
		return NONE;
	}

	public void delContractAdapter(){
		if(null!=contractAdapterID){
			this.getAdapterService().delContractAdapter(contractAdapterID);
		}
	}
	
	public String saveDataSet(){
		HttpServletRequest req = this.getRequest();
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		try {
			req.setCharacterEncoding("UTF-8");
			Writer wr = getResponse().getWriter();
			String js = StringUtil.getString(req.getInputStream(),"UTF-8");
			JSONArray dsObjs = JSONArray.fromObject(js);
			for(int i=0;i<dsObjs.size();i++){
				JSONObject obj = (JSONObject) (dsObjs.get(i));
				String dataSourceType = obj.getString("dataSourceType");
				String querySql = obj.getString("querySql");
				String id = obj.getString("id");
				String state = obj.getString("state");
				String remarks = obj.getString("remarks");
				String actionType = obj.getString("actionType");
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("dataSourceId", null);
				map.put("dataSourceType", dataSourceType);
				map.put("querySql", querySql);
				map.put("remarks", remarks);
				map.put("state", state);
				map.put("dataSetId", id);
				if("ADD".equals(actionType)){
					getAdapterService().insertDataSet(map);
				}else if("MOD".equals(actionType)){
					getAdapterService().updateDataSet(map);
				}
				else if("DEL".equals(actionType)){
					Map mapTemp = new HashMap() ;  
					mapTemp.put("dataSetId", id);
					getAdapterService().deleteDataSet(mapTemp);
				}
			}
			retMap.put("retCode", "0");
			retMap.put("retMsg", "success");
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
		return null;
	}
	public String getDataSouceList(){
		Map mapTemp = new HashMap() ;  
		List<Map> list = getAdapterService().getDataSouceList(mapTemp);
		JSONObject json = new JSONObject();
		json.element("dataSourceList", list);
		try {
			Writer wr = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			wr.write(json.getJSONArray("dataSourceList").toString());
			wr.close();
		} catch (IOException e) {
			log.error("queryDataSetJSON error：", e);
		}
		return null;
	}
	public String queryDataSetJSON(){
		Map paramMap = new HashMap();
        dataSetList=getAdapterService().queryDataSetList(paramMap);
		if(dataSetList==null){
			dataSetList= new ArrayList();
		}
		Map retMap = new HashMap(); 
		retMap.put("total", dataSetList.size());
		retMap.put("rows", dataSetList);
		JSONObject json = new JSONObject();
		json.putAll(retMap);
		try {
			Writer wr = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			wr.write(json.toString());
			wr.close();
		} catch (IOException e) {
			log.error("queryDataSetJSON error：", e);
		}
		return null;
	}
	/**
	 * 跳转至数据集管理
	 * @return
	 */
	public String toExtendManager(){
		Map paramMap = new HashMap();
    	//分页
    	if(getSelectPerPage("page")==-1){
			page.setPageRecord(10);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
        if(getQueryFlag("page")==-1){
    		Map mapTemp = new HashMap() ;  
        	page.setTotalRecord(getAdapterService().countExtendList(mapTemp));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        setPageParameters(page,"page");
        paramMap.put("start",page.getPageStart());
        paramMap.put("end",page.getPageEnd());
        extendList=getAdapterService().queryExtendList(paramMap);
		if(extendList==null){
			extendList = new ArrayList();
		}
		return SUCCESS;
	}
	
	/**
	 * 查询某页面的扩展方式选择
	 * @return
	 */
	public String queryExtendMethod(){
		Map paramMap = new HashMap();
    	//分页
    	if(getSelectPerPage("page")==-1){
			page.setPageRecord(10);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
        if(getQueryFlag("page")==-1){
    		Map mapTemp = new HashMap() ;  
        	page.setTotalRecord(getAdapterService().countExtendList(mapTemp));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        setPageParameters(page,"page");
        paramMap.put("start",page.getPageStart());
        paramMap.put("end",page.getPageEnd());
        extendList=getAdapterService().queryExtendList(paramMap);
		if(extendList==null){
			extendList = new ArrayList();
		}
		return SUCCESS;		
	}
	
	/**
	 * 界面配置测试的协议报文
	 * @return
	 * @throws Exception 
	 */
	public String testProtocalAdapter() throws Exception{

		return SUCCESS;		
	}
	
	public String queryDataSet(){
		Map paramMap = new HashMap();
    	//分页
    	if(getSelectPerPage("page")==-1){
			page.setPageRecord(10);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
        if(getQueryFlag("page")==-1){
    		Map mapTemp = new HashMap() ;  
        	page.setTotalRecord(getAdapterService().countDataSetList(mapTemp));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        setPageParameters(page,"page");
        paramMap.put("start",page.getPageStart());
        paramMap.put("end",page.getPageEnd());
        dataSetList=getAdapterService().queryDataSetList(paramMap);
		if(dataSetList==null){
			dataSetList= new ArrayList();
		}
		return SUCCESS;
	}	
	
	/**
	 * 根据模板或源报文生成目标报文的树形
	 * @return
	 * @throws DocumentException 
	 */
	public String generateTreeStructure() throws DocumentException{
		adapterId=getRequest().getParameter("adapterId");
		Document treeDocument = DocumentHelper.createDocument();
		getAdapterService().generateTreeStructure(treeDocument,adapterId);
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_XML_DATA,treeDocument);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out,getRequest(),getResponse(),"XML");	
		return SUCCESS;
	}
	
	/**
	 * 获取协议适配配置信息
	 * @return
	 * @throws DocumentException
	 */
	public String getAdapterConfigInfo() throws DocumentException{
		adapterId=getRequest().getParameter("adapterId");
		Document configDocument = DocumentHelper.createDocument();
		getAdapterService().getAdapterConfigInfo(configDocument, adapterId);
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_XML_DATA,configDocument);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out,getRequest(),getResponse(),"XML");	
		return SUCCESS;		
	}
	
	/**
	 * 获取新的节点ID
	 * @return
	 */
	public String getNewNodeId(){
		String node_Id=getAdapterService().getNewNodeId();
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_TEXT_DATA,node_Id);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out, getRequest(), getResponse(), "TEXT");
		return SUCCESS;					
	}
	
	/**
	 * 获取新的节点内容操作配置ID
	 * @return
	 */
	public String getNewNodeOperId(){
		String node_Oper_Id=getAdapterService().getNewOperNodeId();
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_TEXT_DATA,node_Oper_Id);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out, getRequest(), getResponse(), "TEXT");
		return SUCCESS;					
	}	
	
	/**
	 * 获取新的节点路径配置ID
	 * @return
	 */
	public String getNewPathId(){
		String path_Id=getAdapterService().getNewPathId();
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_TEXT_DATA,path_Id);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out, getRequest(), getResponse(), "TEXT");
		return SUCCESS;					
	}
	
	/**
	 * 获取某个SQL语句的信息
	 * @return
	 * @throws DocumentException 
	 */	
	public String querySomeQuerySQLInfo() throws DocumentException{
		String dataSetId=getRequest().getParameter("dataSetId");
		Document querySQLDocument = DocumentHelper.createDocument();
		getAdapterService().querySomeQuerySQLInfo(querySQLDocument, dataSetId);
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_XML_DATA,querySQLDocument);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out, getRequest(), getResponse(), "XML");
		return SUCCESS;			
	}
	
	/**
	 * 获取某个扩展方式的信息
	 * @return
	 * @throws DocumentException 
	 */
	public String querySomeExtendMethodInfo() throws DocumentException{
		String methodId=getRequest().getParameter("methodId");
		Document extendMethodDocument = DocumentHelper.createDocument();
		getAdapterService().querySomeExtendMethodInfo(extendMethodDocument, methodId);
		getRequest().setAttribute(AdapterConfigConstant.CONST_RES_XML_DATA,extendMethodDocument);
		PrintWriter out=null;
		DataInteractiveUtil.actionResponsePage(out, getRequest(), getResponse(), "XML");
		return SUCCESS;					
	}		
	
	/**
	 * 保存协议适配配置
	 * @return
	 */
	public String saveProcotolAdapter(){
		
		return SUCCESS;
	}

	public IAdapterService getAdapterService() {
		if (adapterService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			adapterService = (IAdapterService) ctx.getBean("eaap-op2-conf-adapterService");
		}
		return adapterService;
	}

	public void setAdapterService(IAdapterService adapterService) {
		this.adapterService = adapterService;
	}

	public String getAdapterId() {
		return adapterId;
	}

	public void setAdapterId(String adapterId) {
		this.adapterId = adapterId;
	}

	public ProtocolAdapter getProtocolAdapter() {
		return protocolAdapter;
	}

	public void setProtocolAdapter(ProtocolAdapter protocolAdapter) {
		this.protocolAdapter = protocolAdapter;
	}
	
	public String getInputUrl() {
		return inputUrl;
	}

	public void setInputUrl(String inputUrl) {
		this.inputUrl = inputUrl;
	}

	public List getDataSetList() {
		return dataSetList;
	}

	public void setDataSetList(List dataSetList) {
		this.dataSetList = dataSetList;
	}
	
	public List getExtendList() {
		return extendList;
	}

	public void setExtendList(List extendList) {
		this.extendList = extendList;
	}
	
	public List<Map<String,String>> getMsgSwitchModeList() {
		if(msgSwitchModeList.isEmpty()){
			Map<String,String> msgSwitchModeXML = new HashMap<String,String>();
			Map<String,String> msgSwitchModeURL = new HashMap<String,String>();
			msgSwitchModeXML.put("id", "1");
			msgSwitchModeXML.put("type", "XML");
			msgSwitchModeURL.put("id", "2");
			msgSwitchModeURL.put("type", "URL");
			msgSwitchModeList.add(msgSwitchModeXML);
			msgSwitchModeList.add(msgSwitchModeURL);
		}
		
		return msgSwitchModeList;
	}

	public List<Map<String,String>> getAdapterStateList() {
		if(adapterStateList.isEmpty()){
			Map<String,String> map1 = new HashMap<String,String>();
			Map<String,String> map2 = new HashMap<String,String>();
			map1.put("code", "A");
			map1.put("name", "activate");
			map2.put("code", "D");
			map2.put("name", "invalidate");
			adapterStateList.add(map1);
			adapterStateList.add(map2);
		}
		
		return adapterStateList;		
	}

	public List<Map<String, String>> getDataSourceTypeList() {
		if(dataSourceTypeList.isEmpty()){
			Map<String,String> map1 = new HashMap<String,String>();
			Map<String,String> map2 = new HashMap<String,String>();
			map1.put("id", "1");
			map1.put("name", "DBCP DS");
			map2.put("id", "2");
			map2.put("name", "WAS DS");
			dataSourceTypeList.add(map1);
			dataSourceTypeList.add(map2);
		}
		return dataSourceTypeList;
	}
	
	public List<Map> getDataSourcelist() {
		return dataSourcelist;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	
	//-----------------------协议适配模型页面对应的Action---------------------------------
	public String managerAdapter(){
		String[] arr = {getText("eaap.op2.conf.adapter.univeralModel"),
				getText("eaap.op2.conf.adapter.jsThrough"),
				getText("eaap.op2.conf.adapter.bshThrough"),
				getText("eaap.op2.conf.adapter.pythonThrough"),
				getText("eaap.op2.conf.adapter.xslAdapter"), 
				"STD_XML2JSON","STD_JSON2XML","STD_CSV2XLS","STD_FILE2BYTE"};
		for(int i=0;i<arr.length;i++){
			Map<String,String> map = new HashMap<String,String>();
			map.put("key", (i+1)+"");
			map.put("value", arr[i]);
			typeL.add(map);
		}
		return SUCCESS;
	}
	public String adapterTest() throws SQLException, UnsupportedEncodingException, IOException{
		Map<String, Object> m2 = new HashMap<String, Object>();
		m2.put("id", "2");
		m2.put("val", "js scriptExecutor");
		scriptL.add(m2);
		Map<String, Object> m3 = new HashMap<String, Object>();
		m3.put("id", "3");
		m3.put("val", "bsh scriptExecutor");
		scriptL.add(m3);
		Map<String, Object> m4 = new HashMap<String, Object>();
		m4.put("id", "4");
		m4.put("val", "Python scriptExecutor");
		scriptL.add(m4);
		Map<String, Object> m5 = new HashMap<String, Object>();
		m5.put("id", "5");
		m5.put("val", "xsl");
		scriptL.add(m5);
		Map<String, Object> m6 = new HashMap<String, Object>();
		m6.put("id", "6");
		m6.put("val", "xml2Json");
		scriptL.add(m6);
		Map<String, Object> m7 = new HashMap<String, Object>();
		m7.put("id", "7");
		m7.put("val", "json2Xml");
		scriptL.add(m7);

		Map<String, Object> m12 = new HashMap<String, Object>();
		m12.put("id", "12");
		m12.put("val", "byte2String");
		scriptL.add(m12);

		Map<String, Object> m14 = new HashMap<String, Object>();
		m14.put("id", "14");
		m14.put("val", "file2String");
		scriptL.add(m14);
		
		Map<String, Object> m15 = new HashMap<String, Object>();
		m15.put("id", "15");
		m15.put("val", "message2File");
		scriptL.add(m15);
		
		Map<String, Object> m16 = new HashMap<String, Object>();
		m16.put("id", "16");
		m16.put("val", "javassist");
		scriptL.add(m16);
		
		if (objectId != null && !"".equals(objectId)) {
			String[] objectArray = objectId.split("_");
 			chooseTransformerRuleId = "transformer_rule_id" + "_" + objectArray[objectArray.length - 1];
		}
		if (transformerRuleId > 0) {
			getRequest().getSession().setAttribute("contractAdapterID", transformerRuleId);
			Map mapTemp = new HashMap();  
			mapTemp.put("transformerRuleId", transformerRuleId);		
			Map contractAdapterMap = getAdapterService().queryContractAdapter(mapTemp);
			if (contractAdapterMap != null) {
				adapter_name = contractAdapterMap.get("APAPTER_NAME") != null?(String) contractAdapterMap.get("APAPTER_NAME"):"";
				String ruleId = String.valueOf(contractAdapterMap.get("CONTRACT_ADAPTER_ID"));
				transformerRuleId = Integer.parseInt(ruleId) ;
				contractAdapterId = Integer.parseInt(ruleId) ;
				contractAdapterID = Integer.parseInt(ruleId) ;
				
				if(contractAdapterMap.get("SCRIPT_SRC")!=null){
					Object scriptSrc = contractAdapterMap.get("SCRIPT_SRC");
					if (scriptSrc instanceof CLOB) {
						Reader is = ((CLOB) scriptSrc).getCharacterStream();
						BufferedReader br = new BufferedReader(is);
						String s = "";
						StringBuffer sb = new StringBuffer();
						while ((s = br.readLine())!= null) {
							sb.append(s+"\n");
						}
						scriptFileText = sb.toString();
						is.close();
						br.close();
					} else {
						scriptFileText = new String(
								(byte[]) contractAdapterMap.get("SCRIPT_SRC"));
					}
					adapterType  = Integer.parseInt(String.valueOf(contractAdapterMap.get("ADAPTER_TYPE")));
				}

				Map map = new HashMap();
				map.put("tcpCtrFId", contractAdapterMap.get("SRC_CTR_F_ID"));
				List<Map> srcContractAndVersionList = getAdapterService().queryContractAndVersion(map);
				if(srcContractAndVersionList.size()>0){
					Map srcContractAndVersionMap = srcContractAndVersionList.get(0);
					if (srcContractAndVersionMap != null) {
						String contractId = String.valueOf(srcContractAndVersionMap.get("CONTRACTID"));
						srcContractId = Integer.valueOf(contractId);
						String versionId = String.valueOf(srcContractAndVersionMap.get("VERSIONID"));
						srcContractVersionId = Integer.valueOf(versionId);
						String tcpCtrFid = String.valueOf(srcContractAndVersionMap.get("TCPCTRFID"));
						srcTcpCtrFId = Integer.valueOf(tcpCtrFid);
						srcReqRspFlag = (String)srcContractAndVersionMap.get("REQ_RSP");
						srcContractName = (String)srcContractAndVersionMap.get("NAME");
						srcContractVersionName = (String)srcContractAndVersionMap.get("VERSION");
						if(srcContractAndVersionMap.get("CONTYPE") !=null){
							if (((String)srcContractAndVersionMap.get("CONTYPE")).equals("1")) {
								srcContractType = getText("eaap.op2.conf.adapter.contractType1");
							}else if (((String)srcContractAndVersionMap.get("CONTYPE")).equals("2")) {
								srcContractType = getText("eaap.op2.conf.adapter.contractType2");
							}else if (((String)srcContractAndVersionMap.get("CONTYPE")).equals("3")) {
								srcContractType = getText("eaap.op2.conf.adapter.contractType3");
							}else if (((String)srcContractAndVersionMap.get("CONTYPE")).equals("4")) {
								srcContractType = getText("eaap.op2.conf.adapter.contractType4");
							}else if (((String)srcContractAndVersionMap.get("CONTYPE")).equals("5")) {
								srcContractType = getText("eaap.op2.conf.adapter.contractType5");
							}else if (((String)srcContractAndVersionMap.get("CONTYPE")).equals("6")) {
								srcContractType = getText("eaap.op2.conf.adapter.contractType6");
							}
						}
					}
				}
				
				map.put("tcpCtrFId", contractAdapterMap.get("TAR_CTR_F_ID"));
				List<Map> tarContractAndVersionList = getAdapterService().queryContractAndVersion(map);
				if(tarContractAndVersionList.size()>0){
					Map tarContractAndVersionMap = tarContractAndVersionList.get(0);
					if (tarContractAndVersionMap != null) {
						String tarCId = String.valueOf(tarContractAndVersionMap.get("CONTRACTID"));
						tarContractId = Integer.valueOf(tarCId);
						String tarCVersId = String.valueOf(tarContractAndVersionMap.get("VERSIONID"));
						tarContractVersionId = Integer.valueOf(tarCVersId);
						String tarTCFid = String.valueOf(tarContractAndVersionMap.get("TCPCTRFID"));
						tarTcpCtrFId = Integer.valueOf(tarTCFid);
						tarReqRspFlag = (String)tarContractAndVersionMap.get("REQ_RSP");
						tarContractName = (String)tarContractAndVersionMap.get("NAME");
						tarContractVersionName = (String)tarContractAndVersionMap.get("VERSION");
						if(tarContractAndVersionMap.get("CONTYPE") !=null){
							if (((String)tarContractAndVersionMap.get("CONTYPE")).equals("1")) {
								tarContractType = getText("eaap.op2.conf.adapter.contractType1");
							}else if (((String)tarContractAndVersionMap.get("CONTYPE")).equals("2")) {
								tarContractType = getText("eaap.op2.conf.adapter.contractType2");
							}else if (((String)tarContractAndVersionMap.get("CONTYPE")).equals("3")) {
								tarContractType = getText("eaap.op2.conf.adapter.contractType3");
							}else if (((String)tarContractAndVersionMap.get("CONTYPE")).equals("4")) {
								tarContractType = getText("eaap.op2.conf.adapter.contractType4");
							}else if (((String)tarContractAndVersionMap.get("CONTYPE")).equals("5")) {
								tarContractType = getText("eaap.op2.conf.adapter.contractType5");
							}else if (((String)tarContractAndVersionMap.get("CONTYPE")).equals("6")) {
								tarContractType = getText("eaap.op2.conf.adapter.contractType6");
							}
						}
					}
				}
			}
		}
		
		return SUCCESS;
	}
	
	public List<Map<String, Object>> getScriptL() {
		return scriptL;
	}
	public String addMetaData() {
		String consMapCD = this.getConsMapCD();
		String dataSource = getRequest().getParameter("source");
		String keyExpress = getRequest().getParameter("keyExpress");
		String valExpress = getRequest().getParameter("valExpress");
		String varMapingID = getRequest().getParameter("varMapingID");
		
		Map map = new HashMap();
		map.put("consMapCD", consMapCD);
		map.put("dataSource", dataSource);
		map.put("keyExpress", keyExpress);
		map.put("valExpress", valExpress);
		if(varMapingID!=""&&varMapingID!=null)
			map.put("varMapingID", Integer.parseInt(varMapingID));
		this.setContractTypeMap(map);
		return SUCCESS;
	}

	public void setScriptL(List<Map<String, Object>> scriptL) {
		this.scriptL = scriptL;
	}

	public String operate(){
		return SUCCESS;
	}
	public String operateAssign(){
		return SUCCESS;
	}
	public String chooseVersion(){
		
		contractTypeMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_CONTRACTCON);
		 Iterator iter = contractTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			  Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 contractTypeList.add(mapTmp) ;
		 }
		Map map1 = new HashMap(); 
		map1.put("key", "REQ");
		map1.put("value", "REQ");
		Map map2 = new HashMap(); 
		map2.put("key", "RSP");
		map2.put("value", "RSP");
		httpTypeList.add(map1);
		httpTypeList.add(map2);
		
		return SUCCESS;
	}
	
	public Map  getList(Map prar){
		Map returnMap = new HashMap();
  		 List<Map> tmpList = new ArrayList<Map>() ;
	     returnMap.put("startRow", 1);
	     returnMap.put("rows", 10);
	     returnMap.put("total", 33);
	     returnMap.put("dataList", page.convertJson(tmpList)); 
  		return returnMap ;
  	}
	
	public Map  getMetaDataMacthingList(Map prar){
		Map returnMap = new HashMap();
 		 List<Map> tmpList = new ArrayList<Map>();
 		 String consMapCD = (String) prar.get("consMapCD");
 		 if(!"".equals(consMapCD) && null!=consMapCD ){
 			getRequest().getSession().setAttribute("consMapCD", consMapCD);
			Map mapTemp = new HashMap();  
			mapTemp.put("consMapCD", consMapCD);		
 			tmpList = this.getAdapterService().queryVariableMap(mapTemp);
 		 }
	     returnMap.put("startRow", 1);
	     returnMap.put("rows", 10); 	
	     returnMap.put("total", tmpList.size());
	     returnMap.put("dataList", page.convertJson(tmpList));  		
 		return returnMap ;
 	}
	public List<Object> showTree(Map map){
    	List<Object> list = new ArrayList<Object>();
		
    	
    	Map mapTest3 = new HashMap(); 
		mapTest3.put("nodeDirId", 3);
		mapTest3.put("qwepId", 1);
		mapTest3.put("qweIsParent", false);
		mapTest3.put("qwepName","avcd");
		list.add(mapTest3);
		return list ;
	}
	public List<Object> showTree2(Map map){
    	List<Object> list = new ArrayList<Object>();
    	Map mapTest = new HashMap(); 
		mapTest.put("nodeDirId", 1);
		mapTest.put("qwepId", 0);
		mapTest.put("qweIsParent", true);
		mapTest.put("qwepName","avc");
		mapTest.put("isOpen",true);
		list.add(mapTest);
	
		Map mapTest2 = new HashMap(); 
		mapTest2.put("nodeDirId", 2);
		mapTest2.put("qwepId", 1);
		mapTest2.put("qweIsParent", false);
		mapTest2.put("qwepName","avcd");
		list.add(mapTest2);
		
		Map mapTest3 = new HashMap(); 
		mapTest3.put("nodeDirId", 3);
		mapTest3.put("qwepId", 1);
		mapTest3.put("qweIsParent", false);
		mapTest3.put("qwepName","avcd");
		list.add(mapTest3);
		return list ;
	}
	public Map  getContractAdapterList(Map prar){
		  rows = pagination.getRows();
		  pageNum = pagination.getPage();
		  int startRow;
		  startRow = (pageNum - 1) * rows + 1;
		  Map returnMap = new HashMap();
		  List<Map> tmpList = new ArrayList<Map>() ;  		 
		  Map map = new HashMap() ;  
		  map.put("sfid", "".equals(getRequest().getParameter("sfid"))?null:getRequest().getParameter("sfid")) ;
		  map.put("tfid", "".equals(getRequest().getParameter("tfid"))?null:getRequest().getParameter("tfid")) ;
		  map.put("type", "".equals(getRequest().getParameter("type"))?null:getRequest().getParameter("type")) ;
		  
		  try {
			   total= getAdapterService().selectContrateAdapterCnt(map);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		   }         
		   map.put("startPage", startRow);
		   map.put("endPage", startRow+rows-1);
		   
		   map.put("startPage_mysql", startRow-1);
		   map.put("endPage_mysql", rows);
		   tmpList =getAdapterService().selectContractAdapterList(map) ;
		   
		   returnMap.put("startRow", startRow);
		   returnMap.put("rows", rows); 	
		   returnMap.put("total", total);
		   returnMap.put("dataList", page.convertJson(tmpList));  		
		   return returnMap ;
	}
	
	public Map  getContractAndVersionList(Map prar){
		  rows = pagination.getRows();
		  pageNum = pagination.getPage();
		  int startRow;
		  startRow = (pageNum - 1) * rows + 1;
		  Map returnMap = new HashMap();
		  List<Map> tmpList = new ArrayList<Map>() ;  		 
		  Map map = new HashMap() ;  
		  map.put("contractVersion", "".equals(getRequest().getParameter("contractVersion"))?null:getRequest().getParameter("contractVersion")) ;
		  map.put("contractName", "".equals(getRequest().getParameter("contractName"))?null:getRequest().getParameter("contractName")) ;
		  map.put("contractType", "".equals(getRequest().getParameter("contractType"))?null:getRequest().getParameter("contractType")) ;
		  map.put("httpType", "".equals(getRequest().getParameter("httpType"))?null:getRequest().getParameter("httpType")) ;
		  
		  if(prar.get("queryParamsData") != null && StringUtils.isNotEmpty(prar.get("queryParamsData").toString())){
			  map.put("tcpCtrFId",prar.get("queryParamsData"));
		  } else {
			  map.put("tcpCtrFId", "".equals(getRequest().getParameter("noTcpCtrFId"))?null:getRequest().getParameter("noTcpCtrFId")) ;
		  }
			  
		  try {
			   total= getAdapterService().searchContractAndVersionListSum(map);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		   }         
		   map.put("startPage", startRow);
		   map.put("endPage", startRow+rows-1);
		   
		   map.put("startPage_mysql", startRow-1);
		   map.put("endPage_mysql", rows);
		   tmpList =getAdapterService().selectContractAndVersionList(map) ;
		   
		   returnMap.put("startRow", startRow);
		   returnMap.put("rows", rows); 	
		   returnMap.put("total", total);
		   returnMap.put("dataList", page.convertJson(tmpList));  		
		   return returnMap ;
  	}
	/**
	 * 获取节点Json数据结构
	 */
	public void getNodeDesc(){
		
		Map map = new HashMap() ;  
		map.put("tcpCtrFId", tcpCtrFId);
		String nodeString = "";
		String pathStr = "";
		String contractFlag = "/";
		String parentNodeDescIdPath = "";
		if (contractType.equals("2")) {
			contractFlag = ".";
		    pathStr = "$";
		}
		int i = 0;
		//得到基类协议的协议格式ID
		String baseContractAdaperId  = getAdapterService().getTcpCtrFIdByMap(map);
		if(null != baseContractAdaperId && !"".equals(baseContractAdaperId)){
			map.put("baseTcpFId", baseContractAdaperId);
		}
		List<Map> tmpList = new ArrayList<Map>() ; 
		List<Map<String,String>> dataList = new ArrayList<Map<String,String>>() ; 
		tmpList =getAdapterService().queryNodeByContractId(map) ;
//	  做递归生成node_path		
		for (Map data : tmpList) {
			if (data.get("PARENT_NODE_ID") == null 
					)  {
				dataList = getNodeDescLevel(data, tmpList, dataList, pathStr, i, contractFlag,parentNodeDescIdPath);
			}
		}
		JSONObject nodes = new JSONObject(); //json根节点：nodes
		JSONObject rNum = new JSONObject(); //json子节点：R(Num)
		// 将HashMap转换成json

		int j = 1;
		for (Map<String,String> dataMap : dataList) {
			if(!dataMap.isEmpty())
			{
				
				JSONObject nodeValue = new JSONObject(); //json叶子子节点
			     String name = (String)dataMap.get("name");
			     String path = (String)dataMap.get("path");
			     String nodeDescIdPath = (String)dataMap.get("nodeDescIdPath");
			     String childCount = (String)dataMap.get("childCount");
			     String dept = (String)dataMap.get("dept");
			     String nodeDescId = (String)dataMap.get("nodeDescId");
			     String nodeTypeCons = (String)dataMap.get("nodeTypeCons");
			     String nodeNumberCons = (String)dataMap.get("nodeNumberCons");
			     nodeValue.put("name", name);
			     nodeValue.put("nodeType", nodeTypeCons);
			     nodeValue.put("nodeNum", nodeNumberCons);
			     nodeValue.put("dept", dept);
			     nodeValue.put("path", path);
			     nodeValue.put("nodeDescIdPath", nodeDescIdPath);
			     nodeValue.put("childCount", childCount);
			     nodeValue.put("nodeDescId", nodeDescId);
			     rNum.put(loadSideFlg + String.valueOf(j++), nodeValue);
			}
		}
		nodes.put("nodes", rNum);
		log.info("Mawl Node begin:{0}", "start");
		log.info("Mawl Node log:{0}", nodes.toString());
		PrintWriter pw = null;
		try {
			pw = getResponse().getWriter();
			pw.write(nodes.toString()) ;
			pw.flush();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != pw){
				pw.close() ;
			}
		}
	}

	public List<Map<String,String>> getNodeDescLevel(Map data, List<Map> tmpList, 
			List<Map<String,String>> dataMapList, String parentPath, int i, String contractFlag, String parentNodeDescIdPath){
		String[] nodeTypeCons = {"","String","Number","Object","DATE","","","JsonArray"};
		String[] nodeNumCons = {"","[1-1]","[1-N]","[0-1]","[0-N]"};
		Integer typeCons = 0;
		Integer numCons = 0;
		Map<String, String> dataMap = new HashMap<String, String>(); 
		String path = parentPath + contractFlag + (String)data.get("NODE_NAME");
		String nodeDescIdPath = parentNodeDescIdPath + "/" + String.valueOf(data.get("NODE_DESC_ID"));
		int dept = i + 1;
		dataMap.put("name", (String)data.get("NODE_NAME"));
		dataMap.put("path", path);
		dataMap.put("nodeDescIdPath", nodeDescIdPath);
		dataMap.put("childCount", String.valueOf(data.get("CHILD_COUNT")));
		dataMap.put("dept", String.valueOf(dept));
		dataMap.put("nodeDescId", String.valueOf(data.get("NODE_DESC_ID")));
		//新增
		if( !"".equals(data.get("NODE_TYPE_CONS")) && null!=data.get("NODE_TYPE_CONS")){
			typeCons = Integer.parseInt((String) data.get("NODE_TYPE_CONS"));
		}
		if(!"".equals(data.get("NODE_NUMBER_CONS")) && null!= data.get("NODE_NUMBER_CONS")){
			numCons = Integer.parseInt((String) data.get("NODE_NUMBER_CONS"));
		}
		dataMap.put("nodeTypeCons", nodeTypeCons[typeCons]);
		dataMap.put("nodeNumberCons", nodeNumCons[numCons]);
		dataMapList.add(dataMap);
		for (Map tempMap : tmpList) {
			if (null != tempMap.get("PARENT_NODE_ID")  && !"null".equals(String.valueOf(tempMap.get("PARENT_NODE_ID")))
					&& tempMap.get("PARENT_NODE_ID").equals(data.get("NODE_DESC_ID")) 
					&& !(String.valueOf(data.get("NODE_TYPE"))).equals("8")) {
				getNodeDescLevel(tempMap,  tmpList, dataMapList, path, dept, contractFlag,nodeDescIdPath);
			}
		}
		return dataMapList;
	}
	
	public Map getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map stateMap = new HashMap() ;
	  	
	  	  mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = (MainDataType) getAdapterService().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
			  List<MainData> mainDataList = getAdapterService().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }
	
	
	   public void uploadFile(){
		   PrintWriter pw;
		   String resutlText = "";
		   try {
				resutlText = readFileByChars(scriptFileUpload);
				pw = getResponse().getWriter();
				pw.write(resutlText) ;
				pw.close() ;
			} catch (Exception e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
	    }
	   
	   public void originalFileUpload (){
		   
		   PrintWriter pw;
		   String resutlText = "";
		   try {
				resutlText = readFileByChars(originalFileUpload);
				pw = getResponse().getWriter();
				pw.write(resutlText) ;
				pw.close() ;
			} catch (Exception e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
	    }
	   
	   /**
	     * 以字符为单位读取文件，常用于读文本，数字等类型的文件
	     */
	    public String readFileByChars(File file) {
	        Reader reader = null;
	        try {
	            // System.out.println("以字符为单位读取文件内容，一次读一个字节：");
	            // 一次读一个字符
	            reader = new InputStreamReader(new FileInputStream(file),"GBK");
	            int tempchar;
	            String result = "";
				StringBuffer bf= new StringBuffer();
	            while ((tempchar = reader.read()) != -1) {
	                // 对于windows下，\r\n这两个字符在一起时，表示一个换行。
	                // 但如果这两个字符分开显示时，会换两次行。
	                // 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
	                if (((char) tempchar) != '\r') {
	                	//result += (char) tempchar;
	                	bf.append((char) tempchar);
	                }
	            }
	            result = bf.toString();
	            reader.close();
	            return result;
	        } catch (Exception e) {
	        	log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
	        }
	        return null;
	    }
	    /**
	     * 查看测试结果
	     */
		   public void testUniversalAdapter (){
//			   PrintWriter pw;
//			   boolean flag = false;
//			   if(null != this.getSourceType() && !"".equals(this.getSourceType())){
//				   if("1".equals(this.getSourceType())){//Document
////					   MessageBO<Document> message = new MessageBO<Document>();
//						Document doc = null;
//						try {
//							doc = DocumentHelper.parseText(sourceMessageText);//文档转化
//							flag = true;
//						} catch (DocumentException e1) {
//							 try {
//									pw = getResponse().getWriter();
//									pw.write("Source message error!") ;
//									pw.flush();
//									pw.close() ;
//								} catch (Exception e) {
//									log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//								}
//							 log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
//						}
//						if(flag){
//							message.setMsgBody(doc);
//							doTransForm(message);
//						}
//				   }else if("2".equals(this.getSourceType())){//json
//					   MessageBO<JSONObject> message = new MessageBO<JSONObject>();
//					   JSONObject  json = null;
//					   try{
//					      json = JSONObject.fromObject(sourceMessageText);
//					      flag = true;
//					   }catch (Exception e){
//						   try {
//								pw = getResponse().getWriter();
//								pw.write("Source message error!") ;
//								pw.flush();
//								pw.close() ;
//							} catch (Exception e1) {
//								log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
//							}
//						 log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//					   }
//					   if(flag){
//						   message.setMsgBody(json);
//						   doTransForm(message);
//					   }
//				   }
//			   }
		    }
           /**
            * 执行具体转换方法
            * @param message
            */
//		   public void doTransForm(MessageBO<?> message){
//			   PrintWriter  pw;
//			   try{ 
//
//				}catch (Exception e){
//					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//					try {
//						pw = getResponse().getWriter();
//						pw.write("Translation exception") ;
//						pw.flush();
//						pw.close() ;
//					} catch (IOException e1) {
//						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//					}
//				}
//		   }
		/**
		 * 测试脚本效果
		 */
		public void testScriptAdapter (){
//			   PrintWriter pw;
//			   boolean flag = false;
//			   if(null != this.getSourceType() && !"".equals(this.getSourceType())){
//				   if("1".equals(this.getSourceType())){//xml
//					   MessageBO<Document> message = new MessageBO<Document>();
//						Document doc = null;
//						try {
//							doc = DocumentHelper.parseText(originalFileText);//文档转化
//							flag = true;
//						} catch (DocumentException e1) {
//							 try {
//									pw = getResponse().getWriter();
//									pw.write("Original Message Input Error!") ;
//									pw.flush();
//									pw.close() ;
//								} catch (Exception e) {
//									log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//								}
//							 log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
//						}
//						if(flag){
//							message.setMsgBody(doc);
//							doScriptTransForm(message);
//						}
//				   }else if("2".equals(this.getSourceType())){//json
//					   MessageBO<JSONObject> message = new MessageBO<JSONObject>();
//					   JSONObject  json = null;
//					   try{
//					      json = JSONObject.fromObject(originalFileText);
//					      flag = true;
//					   }catch (Exception e){
//						   try {
//								pw = getResponse().getWriter();
//								pw.write("Original Message Input Error!") ;
//								pw.flush();
//								pw.close() ;
//							} catch (Exception e1) {
//								log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
//							}
//						 log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//					   }
//					   if(flag){
//						   message.setMsgBody(json);
//						   doScriptTransForm(message);
//					   }
//				   }
//			   }
		}
		/**
		 * 执行脚本转换
		 * @param message
		 */
//		public void doScriptTransForm(MessageBO<?> message){
//			PrintWriter  pw = null;
//			try{ 
//				
//			}catch (Exception e){
//				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//				try {
//					pw = getResponse().getWriter();
//					pw.write("Translation exception") ;
//					pw.flush();
//					pw.close() ;
//				} catch (IOException e1) {
//					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//				}
//			}
//		}
		   /**
		    * 脚本转换的保存
		    */
		   public void saveScriptAdapter (){
			   try {
			   PrintWriter pw;
			   Map map = new HashMap();
			   map.put("adapterName", adapterTypeName);
			   map.put("adapterType", adapterType);
			   map.put("scriptSrc", scriptFileText);
			   map.put("state", "A");
			   String jsonStr = "{\"msg\": ";
			   
			   if (contractAdapterId!=null &&  contractAdapterId> 0) {
				   map.put("srcTcpCtrFId", 0);
				   map.put("tarTcpCtrFId", 0);
				   map.put("contractAdapterId", contractAdapterId);
				   getAdapterService().updateContractAdapter(map);
				   getAdapterService().delNodeMaper(map);//删除节点映射信息
				   getAdapterService().delAdapterReq(map);//删除节点取值要求信息
				   jsonStr += "\"update\",\"contractAdapterId\":" + String.valueOf(contractAdapterId) + "}";
			   } else {
				   contractAdapterId = getAdapterService().insertContractAdapter(map);
				   jsonStr += "\"save\",\"contractAdapterId\":" + String.valueOf(contractAdapterId) + "}";
			   }
					pw = getResponse().getWriter();
					pw.write(jsonStr) ;
					pw.close() ;
				} catch (Exception e1) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage()+"contractAdapterId :"+contractAdapterId,null));
				}
		    }
		   /**
		    * 协议适配拉线保存
		    */
		   public void saveUniversalAdapter (){
			   
			   PrintWriter pw;
			   String jsonStr = "{\"msg\": ";
			   if (transformerRuleId > 0) {
				   Map map = new HashMap();
				   map.put("state", "A");
				   map.put("contractAdapterId", transformerRuleId);
				   getAdapterService().updateContractAdapter(map);
				   jsonStr += "\"save\",\"contractAdapterId\":" + String.valueOf(transformerRuleId) + "}";
			   } else {
				   jsonStr += "\"\"}";
			   }
			   try {
					pw = getResponse().getWriter();
					pw.write(jsonStr) ;
					pw.close() ;
				} catch (Exception e1) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage()+"contractAdapterId :"+contractAdapterId,null));
				}
		    }
	   
			public synchronized void getLineDesc(){
				PrintWriter pw = null;
				try {
				Map srcMap = new HashMap() ;  
				srcMap.put("tcpCtrFId", srcTcpCtrFId);
				String nodeString = "";
				String pathStr = "";
				String contractFlag = "/";
				String parentNodeDescIdPath = "";
				int i = 0;
				List<Map> srcTmpList = new ArrayList<Map>() ; 
				List<Map<String, String>> srcDataList = new ArrayList<Map<String,String>>() ; 
				//得到基类协议的协议格式ID
				String baseContractAdaperId  = getAdapterService().getTcpCtrFIdByMap(srcMap);
				if(null != baseContractAdaperId && !"".equals(baseContractAdaperId)){
					srcMap.put("baseTcpFId", baseContractAdaperId);
				}
				srcTmpList =getAdapterService().queryNodeByContractId(srcMap) ;
				
//			  源协议做递归生成node_path		
				for (Map data : srcTmpList) {
					if (data.get("PARENT_NODE_ID") == null 
					//		&& !((String)data.get("NODE_TYPE")).equals("6")
							)  {
						srcDataList = getNodeDescLevel(data, srcTmpList, srcDataList, pathStr, i, contractFlag,parentNodeDescIdPath);
					}
				}
				
				Map tarMap = new HashMap() ;  
				tarMap.put("tcpCtrFId", tarTcpCtrFId);
				List<Map> tarTmpList = new ArrayList<Map>() ; 
				List<Map<String,String>> tarDataList = new ArrayList<Map<String,String>>() ; 
				//得到基类协议的协议格式ID
				String baseAdaperId  = getAdapterService().getTcpCtrFIdByMap(tarMap);
				if(null != baseAdaperId && !"".equals(baseAdaperId)){
					tarMap.put("baseTcpFId", baseAdaperId);
				}
				tarTmpList =getAdapterService().queryNodeByContractId(tarMap) ;
				
//				目标协议做递归生成node_path		
			    i = 0;
				for (Map data : tarTmpList) {
					if (data.get("PARENT_NODE_ID") == null 
							//&& !((String)data.get("NODE_TYPE")).equals("6")
							)  {
						tarDataList = getNodeDescLevel(data, tarTmpList, tarDataList, pathStr, i, contractFlag,parentNodeDescIdPath);
					}
				}
				
	//			 获取节点映射。 transformerRuleId = 370;
				Map mapTemp = new HashMap();  
				mapTemp.put("transformerRuleId", transformerRuleId);		
				List<Map> linesTempList = getAdapterService().selectNodeDescMaperList(mapTemp);
				Map srcTempMap = new HashMap();
				// 获取节点点的映射关系。
				int j = 0;
				for (Map<String,String> srcDataMap : srcDataList) {
					if(!srcDataMap.isEmpty())
					{   
						 j++;
						 srcTempMap.put((String)srcDataMap.get("nodeDescId"), "L" + String.valueOf(j));
					}
				}
				
				Map tarTempMap = new HashMap();
				j = 0;
				for (Map<String,String> tarDataMap : tarDataList) {
					if(!tarDataMap.isEmpty()){
						 j++;
						 tarTempMap.put((String)tarDataMap.get("nodeDescId"), "R" + String.valueOf(j));
					}
				}
				
				for (Map lineMap : linesTempList) {
					if (lineMap.get("SRC_NODE_DESC_ID") != null && srcTempMap.containsKey(String.valueOf(lineMap.get("SRC_NODE_DESC_ID")))) {
						lineMap.put("fromId", srcTempMap.get(String.valueOf(lineMap.get("SRC_NODE_DESC_ID"))));
					}
					if (lineMap.get("TAR_NODE_DESC_ID") != null && tarTempMap.containsKey(String.valueOf(lineMap.get("TAR_NODE_DESC_ID")))) {
						lineMap.put("toId", tarTempMap.get(String.valueOf(lineMap.get("TAR_NODE_DESC_ID"))));
					}
				}
				
				// 将HashMap转换成json
				j = 0;
				JSONObject root = new JSONObject(); //json根节点对象
				JSONObject lineObj = new JSONObject(); //线对象
				JSONObject repeadJson = new JSONObject(); //操作记录对象
				JSONObject tableObj = new JSONObject(); //表格数据对象
				
				for (Map lineMap : linesTempList) {
					JSONObject lineMessageObj = new JSONObject(); //具体线对象信息
					if (lineMap.get("fromId") != null && lineMap.get("toId") != null) {
						String from = String.valueOf(lineMap.get("fromId"));
						String to = String.valueOf(lineMap.get("toId"));
						lineMessageObj.put("type", "sl");
						lineMessageObj.put("from", from);
						lineMessageObj.put("to", to);
						lineMessageObj.put("name", "");
						lineMessageObj.put("alt", "true");
						lineMessageObj.put("operate", lineMap.get("ACTION_TYPE"));
						lineObj.put(to+from, lineMessageObj);//线数据ID to+from
						repeadJson.put(from+to, String.valueOf(lineMap.get("ACTION_TYPE")));//添加操作记录
					} else if(lineMap.get("fromId") == null && lineMap.get("toId") != null){
						lineMessageObj.put("type", "sl");
						lineMessageObj.put("from", "");
						lineMessageObj.put("to", lineMap.get("toId"));
						lineMessageObj.put("name", "my_" + lineMap.get("toId"));
						lineMessageObj.put("alt", "true");
						lineMessageObj.put("operate", lineMap.get("ACTION_TYPE"));
						lineObj.put("op" + String.valueOf(lineMap.get("toId")), lineMessageObj);//线数据ID op+lineMap.get("toId")
						repeadJson.put(String.valueOf(lineMap.get("toId")), String.valueOf(lineMap.get("ACTION_TYPE")));//添加操作记录
					}
					JSONObject tableMessageObj = new JSONObject(); //表格数据对象
					String mud  ="";
					if(null == lineMap.get("fromId") || "".equals(lineMap.get("fromId"))){
						tableMessageObj.put("from", "\"null\"");
						mud  = "op" + String.valueOf(lineMap.get("toId"));
					}else{
						tableMessageObj.put("from", lineMap.get("fromId"));
						mud  = String.valueOf(lineMap.get("toId"))+String.valueOf(lineMap.get("fromId"));
					}
					j++;
					tableMessageObj.put("lineId", mud);
					tableMessageObj.put("to", lineMap.get("toId"));
					tableMessageObj.put("type", lineMap.get("ACTION_TYPE"));
					tableMessageObj.put("wayId", "way" + String.valueOf(j));
					tableMessageObj.put("wayVal", String.valueOf(lineMap.get("NODE_VALUE_SOURCE_CD")));
					tableMessageObj.put("assignValId", "assignVal" + String.valueOf(j));
					tableMessageObj.put("assignVal", String.valueOf(lineMap.get("NODE_VAL_ADAPTER_REQ_ID")));
					tableMessageObj.put("assignConditionValueId", "assignConditionValue" + String.valueOf(j));
					tableMessageObj.put("assignConditionValue", String.valueOf(lineMap.get("NODE_VAL_ADAPTER_REQ_ID")));
					tableObj.put("GooFlow_line_Adapter_" + String.valueOf(j), tableMessageObj);
				}
				root.put("lines", lineObj);//添加线对象
				root.put("areas", "{}");
				root.put("initNum", String.valueOf(linesTempList.size()));
				root.put("repeadJson", repeadJson);//添加操作记录
				root.put("GooFlow_line_Adapter", tableObj);//表格数据对象
				log.info("Mawl begin:{0}", "start");
				log.info("Mawl log:{0}", root.toString());
					pw = getResponse().getWriter();
					pw.write(root.toString()) ;
					pw.flush();
					try {
						Thread.sleep(1000) ;
					} catch (InterruptedException e) {
					}
				} catch (IOException e) {
					try {
						pw = getResponse().getWriter();
					} catch (IOException e1) {
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
					}
					pw.write("error") ;
					pw.flush();
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
				}finally{
					if(null != pw){
						pw.close() ;
					}
				}
			}
		   
	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getContractVersionName() {
		return contractVersionName;
	}

	public void setContractVersionName(String contractVersionName) {
		this.contractVersionName = contractVersionName;
	}

	public String getContractVersionId() {
		return contractVersionId;
	}

	public void setContractVersionId(String contractVersionId) {
		this.contractVersionId = contractVersionId;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public int getTcpCtrFId() {
		return tcpCtrFId;
	}

	public void setTcpCtrFId(int tcpCtrFId) {
		this.tcpCtrFId = tcpCtrFId;
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

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public String getLoadSideFlg() {
		return loadSideFlg;
	}

	public void setLoadSideFlg(String loadSideFlg) {
		this.loadSideFlg = loadSideFlg;
	}

	public String getContractVersion() {
		return contractVersion;
	}

	public void setContractVersion(String contractVersion) {
		this.contractVersion = contractVersion;
	}

	public String getContractVersionType() {
		return contractVersionType;
	}

	public void setContractVersionType(String contractVersionType) {
		this.contractVersionType = contractVersionType;
	}

	public String getChooseTcpCtrFId() {
		return chooseTcpCtrFId;
	}

	public void setChooseTcpCtrFId(String chooseTcpCtrFId) {
		this.chooseTcpCtrFId = chooseTcpCtrFId;
	}

	public String getContractType() {
		return contractType;
	}

	public void setContractType(String contractType) {
		this.contractType = contractType;
	}

	public int getNoTcpCtrFId() {
		return noTcpCtrFId;
	}

	public void setNoTcpCtrFId(int noTcpCtrFId) {
		this.noTcpCtrFId = noTcpCtrFId;
	}

	public String getReqRspFlag() {
		return reqRspFlag;
	}

	public void setReqRspFlag(String reqRspFlag) {
		this.reqRspFlag = reqRspFlag;
	}

	public String getChooseReqRspFlag() {
		return chooseReqRspFlag;
	}

	public void setChooseReqRspFlag(String chooseReqRspFlag) {
		this.chooseReqRspFlag = chooseReqRspFlag;
	}

	public Map getContractTypeMap() {
		return contractTypeMap;
	}

	public void setContractTypeMap(Map contractTypeMap) {
		this.contractTypeMap = contractTypeMap;
	}

	public List<Map> getHttpTypeList() {
		return httpTypeList;
	}

	public void setHttpTypeList(List<Map> httpTypeList) {
		this.httpTypeList = httpTypeList;
	}

	public List<Map> getContractTypeList() {
		return contractTypeList;
	}

	public void setContractTypeList(List<Map> contractTypeList) {
		this.contractTypeList = contractTypeList;
	}

	public String getHttpType() {
		return httpType;
	}

	public void setHttpType(String httpType) {
		this.httpType = httpType;
	}

	public File getScriptFileUpload() {
		return scriptFileUpload;
	}

	public void setScriptFileUpload(File scriptFileUpload) {
		this.scriptFileUpload = scriptFileUpload;
	}

	public File getOriginalFileUpload() {
		return originalFileUpload;
	}

	public void setOriginalFileUpload(File originalFileUpload) {
		this.originalFileUpload = originalFileUpload;
	}

	public String getScriptFileText() {
		return scriptFileText;
	}

	public void setScriptFileText(String scriptFileText) {
		this.scriptFileText = scriptFileText;
	}

	public String getOriginalFileText() {
		return originalFileText;
	}

	public void setOriginalFileText(String originalFileText) {
		this.originalFileText = originalFileText;
	}

	public int getAdapterType() {
		return adapterType;
	}

	public void setAdapterType(int adapterType) {
		this.adapterType = adapterType;
	}

	public int getSrcTcpCtrFId() {
		return srcTcpCtrFId;
	}

	public void setSrcTcpCtrFId(int srcTcpCtrFId) {
		this.srcTcpCtrFId = srcTcpCtrFId;
	}

	public int getTarTcpCtrFId() {
		return tarTcpCtrFId;
	}

	public void setTarTcpCtrFId(int tarTcpCtrFId) {
		this.tarTcpCtrFId = tarTcpCtrFId;
	}

	public String getAdapterTypeName() {
		return adapterTypeName;
	}

	public void setAdapterTypeName(String adapterTypeName) {
		this.adapterTypeName = adapterTypeName;
	}

	public String getConsMapCD() {
		return consMapCD;
	}

	public void setConsMapCD(String consMapCD) {
		this.consMapCD = consMapCD;
	}

	public String getAdapter_name() {
		return adapter_name;
	}

	public void setAdapter_name(String adapter_name) {
		this.adapter_name = adapter_name;
	}

	public Integer getContractAdapterID() {
		return contractAdapterID;
	}

	public void setContractAdapterID(Integer contractAdapterID) {
		this.contractAdapterID = contractAdapterID;
	}

	public String getLineid() {
		return lineid;
	}

	public void setLineid(String lineid) {
		this.lineid = lineid;
	}

	public String getSpath() {
		return spath;
	}

	public void setSpath(String spath) {
		this.spath = spath;
	}

	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}

	public String getTpath() {
		return tpath;
	}

	public void setTpath(String tpath) {
		this.tpath = tpath;
	}

	public int getTransformerRuleId() {
		return transformerRuleId;
	}

	public void setTransformerRuleId(int transformerRuleId) {
		this.transformerRuleId = transformerRuleId;
	}

	public int getSrcContractId() {
		return srcContractId;
	}

	public void setSrcContractId(int srcContractId) {
		this.srcContractId = srcContractId;
	}

	public int getSrcContractVersionId() {
		return srcContractVersionId;
	}

	public void setSrcContractVersionId(int srcContractVersionId) {
		this.srcContractVersionId = srcContractVersionId;
	}

	public String getSrcReqRspFlag() {
		return srcReqRspFlag;
	}

	public void setSrcReqRspFlag(String srcReqRspFlag) {
		this.srcReqRspFlag = srcReqRspFlag;
	}

	public String getSrcContractName() {
		return srcContractName;
	}

	public void setSrcContractName(String srcContractName) {
		this.srcContractName = srcContractName;
	}

	public String getSrcContractVersionName() {
		return srcContractVersionName;
	}

	public void setSrcContractVersionName(String srcContractVersionName) {
		this.srcContractVersionName = srcContractVersionName;
	}

	public String getSrcContractType() {
		return srcContractType;
	}

	public void setSrcContractType(String srcContractType) {
		this.srcContractType = srcContractType;
	}

	public int getTarContractId() {
		return tarContractId;
	}

	public void setTarContractId(int tarContractId) {
		this.tarContractId = tarContractId;
	}

	public int getTarContractVersionId() {
		return tarContractVersionId;
	}

	public void setTarContractVersionId(int tarContractVersionId) {
		this.tarContractVersionId = tarContractVersionId;
	}

	public String getTarReqRspFlag() {
		return tarReqRspFlag;
	}

	public void setTarReqRspFlag(String tarReqRspFlag) {
		this.tarReqRspFlag = tarReqRspFlag;
	}

	public String getTarContractName() {
		return tarContractName;
	}

	public void setTarContractName(String tarContractName) {
		this.tarContractName = tarContractName;
	}

	public String getTarContractVersionName() {
		return tarContractVersionName;
	}

	public void setTarContractVersionName(String tarContractVersionName) {
		this.tarContractVersionName = tarContractVersionName;
	}

	public String getTarContractType() {
		return tarContractType;
	}

	public void setTarContractType(String tarContractType) {
		this.tarContractType = tarContractType;
	}

	public String getAttrName() {
		return attrName;
	}

	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}

	public String getObjectId() {
		return objectId;
	}

	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	public String getEndpoint_Spec_Attr_Id() {
		return endpoint_Spec_Attr_Id;
	}

	public void setEndpoint_Spec_Attr_Id(String endpoint_Spec_Attr_Id) {
		this.endpoint_Spec_Attr_Id = endpoint_Spec_Attr_Id;
	}

	public String getTransformer() {
		return transformer;
	}

	public void setTransformer(String transformer) {
		this.transformer = transformer;
	}

	public String getChooseTransformerRuleId() {
		return chooseTransformerRuleId;
	}

	public void setChooseTransformerRuleId(String chooseTransformerRuleId) {
		this.chooseTransformerRuleId = chooseTransformerRuleId;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public String getDrawJson() {
		return drawJson;
	}

	public void setDrawJson(String drawJson) {
		this.drawJson = drawJson;
	}

	public String getSourceMessageText() {
		return sourceMessageText;
	}

	public void setSourceMessageText(String sourceMessageText) {
		this.sourceMessageText = sourceMessageText;
	}

	public String getTestUniversalResult() {
		return testUniversalResult;
	}

	public void setTestUniversalResult(String testUniversalResult) {
		this.testUniversalResult = testUniversalResult;
	}

	public String getSourceType() {
		return sourceType;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	public Integer getContractAdapterId() {
		return contractAdapterId;
	}

	public void setContractAdapterId(Integer contractAdapterId) {
		this.contractAdapterId = contractAdapterId;
	}
	
}
