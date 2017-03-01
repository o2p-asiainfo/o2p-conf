package com.ailk.eaap.op2.conf.adapter.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import oracle.sql.CLOB;

import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.adapter.service.IAdapterService;
import com.ailk.eaap.op2.conf.adapter.service.INewAdapterService;
import com.ailk.eaap.op2.conf.adapter.util.DataInteractiveUtil;
import com.ailk.eaap.op2.conf.adapter.util.Expression;
import com.ailk.eaap.op2.conf.adapter.util.ExpressionUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.struts.BaseAction;

public class NewAdapterAction extends BaseAction{
	private static final long serialVersionUID = 1L;
    private Logger log = Logger.getLog(this.getClass());
	private INewAdapterService newAdapterService;
	private IAdapterService adapterService;
	//页面传参
	private String pageTcpCtrFId;
	private String pageContractType;
	private String pageLoadSideFlg;
	private String pageContractName;
	private String pageTcpCtrFIdList;
	
	private String pageProtocolName;
	private String pageContractVersion;
	private String pageProtocolType;
	private String pageReqRsp;
	
	private String pageSrcTcpCtrFId;
	private String pageTarTcpCtrFId;
	private String type;
	private String svname;
	private String tvname;
	private String pageContractAdapterId;
	
	
	private String operator;
	private String pageSrcNodeDescId;
	private String pageTarNodeDescId;
	
	private String pageNodeValAdapterReqId;
	private String pageConsMapCD;
	private String pageConsMapName;
	private String pageVarMapTypeId;
	
	private String pageCondition;
	private String pageComplexCondition;
	private String pageRelectExpress;
	private String pageNodeValue;
	private String pageScript;
	private String pageDataSource;
	private String pageKeyExp;
	private String pageValExp;
	private String pageVarMappingId;
	
	//消息流转过来的参数
	private String pageEndpointId;//新加的参数
	private String pageState;
	private String attrName;
	private String objectId;
	private String endpoint_Spec_Attr_Id;
	private String transformerRuleId;
	private String moreSource;//所有端点的ID，跟名字信息
	private String newState;
	private String attrSpecCode;
	
	//脚本配置相关
	private String pageScriptFileText;
	private String pageAdapterType;
	
	 private Map contractTypeMap = new HashMap() ;
	 private List<Map> httpTypeList = new ArrayList<Map>() ;
	 private List<Map> contractTypeList = new ArrayList<Map>() ;
	 private List<Map<String,Object>> metaDataMachingL = new ArrayList<Map<String,Object>>();
	 private List<Map<String,Object>> moreSourceList = new ArrayList<Map<String,Object>>();
	//协议适配模型的action
	 private List<Map<String,Object>> scriptL = new ArrayList<Map<String,Object>>();
	//分页参数
	private int start;
	private int length;
	private int total;
	private int draw;
	/**
	 * 新协议适配页面初使化
	 * @return
	 * @throws SQLException 
	 * @throws IOException 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String newAdapterPage() throws SQLException, IOException{
		if (objectId != null && !"".equals(objectId)) {
			String[] arrayEndpoint = objectId.split("_");
			if(arrayEndpoint.length>0){
				pageEndpointId = objectId.split("_")[arrayEndpoint.length-1];//从消息流传进来的端点ID
			}
		}else{
			pageEndpointId = "12";//测试用
		}//moreSourceList
		if(null != moreSource && !"".equals(moreSource)){
			String[] source = moreSource.split(":");
			if(source.length>0){
				for(String finalvalue : source){
					String[] key = finalvalue.split(",");
					if(key.length>0){
						Map<String,Object> map = new HashMap<String,Object>();
						map.put("id",key[0]);
						map.put("val","ID:"+key[0]+" Name:"+key[1]);
						moreSourceList.add(map);
					}
				}
			}
		}
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
		
		Map map3 = new HashMap();
   		map3.put("id","1");
   		map3.put("val",getText("eaap.op2.conf.adapter.fromDb"));
   		this.metaDataMachingL.add(map3);
   		Map map4 = new HashMap();
   		map4.put("id","2");
   		map4.put("val",getText("eaap.op2.conf.adapter.fromHost"));
   		this.metaDataMachingL.add(map4);
   		
   		//脚本配置初使化
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
		
		if(null != transformerRuleId && !"".equals(transformerRuleId)){//说明是查看配置
			this.setPageContractAdapterId(transformerRuleId);
			Map mapTemp = new HashMap();  
			mapTemp.put("transformerRuleId", transformerRuleId);		
			Map contractAdapterMap = getAdapterService().queryContractAdapter(mapTemp);//协议转化对象
			if(null != contractAdapterMap){
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
						pageScriptFileText = sb.toString();
						is.close();
						br.close();
					} else {
						pageScriptFileText = new String((byte[]) contractAdapterMap.get("SCRIPT_SRC"));
					}
				}
				pageAdapterType  = String.valueOf(contractAdapterMap.get("ADAPTER_TYPE"));
				if(null != contractAdapterMap.get("SRC_CTR_F_ID")){
					pageSrcTcpCtrFId = String.valueOf(contractAdapterMap.get("SRC_CTR_F_ID"));
				}
				if(null != contractAdapterMap.get("TAR_CTR_F_ID")){
					pageTarTcpCtrFId = String.valueOf(contractAdapterMap.get("TAR_CTR_F_ID"));
				}
			}
		}
		return SUCCESS;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map getMainInfo(String mainTypeSign){
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
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void getContractList(){
		List<Map> tmpList = new ArrayList<Map>() ;  		 
		Map map = new HashMap() ;  
		if(null != pageProtocolName && !"".equals(pageProtocolName)){
			map.put("contractName", pageProtocolName);
		}
		if(null != pageContractVersion && !"".equals(pageContractVersion)){
			map.put("contractVersion", pageContractVersion);
		}
		if(null != pageProtocolType && !"".equals(pageProtocolType)){
			map.put("contractType", pageProtocolType);
		}
		if(null != pageReqRsp && !"".equals(pageReqRsp)){
			map.put("httpType", pageReqRsp);
		}
		if(null != pageContractAdapterId && !"".equals(pageContractAdapterId)){
			pageTcpCtrFIdList =  getNewAdapterService().getSelectedLeftFormat(pageContractAdapterId);
			if(null != pageTcpCtrFIdList && !"".equals(pageTcpCtrFIdList)){
				map.put("tcpCtrFId", pageTcpCtrFIdList);
			}
		}
		//mysql参数
		map.put("startPage_mysql", start);
		map.put("endPage_mysql", length);
		//oracle参数
		map.put("startPage", start+1);
		map.put("endPage", start+length);
		total = getNewAdapterService().getCountContractListByMap(map);
		tmpList = getNewAdapterService().getContractListByMap(map);
		JSONObject json = new JSONObject();
		json.put("draw", draw);
		json.put("recordsTotal", length);
		json.put("recordsFiltered", total);
		JSONArray jsonArray = new JSONArray();
		if(null !=  tmpList && tmpList.size() > 0){
			for(Map itData : tmpList){
				JSONObject jsondata = new JSONObject();
				jsondata.put("name", String.valueOf(itData.get("NAME")));
				jsondata.put("version", String.valueOf(itData.get("VERSION")));
				jsondata.put("contype", getShuitValue(String.valueOf(itData.get("CONTYPE"))));
				jsondata.put("contypeNum", String.valueOf(itData.get("CONTYPE")));
				jsondata.put("req_rsp", String.valueOf(itData.get("REQ_RSP")));
				jsondata.put("tcpcrtfid", String.valueOf(itData.get("TCPCTRFID")));
				jsonArray.add(jsondata);
			}
		}
		json.put("data", jsonArray);
	    PrintWriter pw = null;
	    try {
			pw = this.getResponse().getWriter();
			pw.write(json.toString());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != pw){
				pw.flush();
				pw.close();
			}
		}
	}
	/**
	 * 得到变量映射类型列表
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void getVarMapTypeList(){
		List<Map> tmpList = new ArrayList<Map>() ;  		 
		Map map = new HashMap() ;  
		if(null != pageConsMapCD && !"".equals(pageConsMapCD)){
			map.put("consMapCD", pageConsMapCD);
		}
		if(null != pageConsMapName && !"".equals(pageConsMapName)){
			map.put("consMapName", pageConsMapName);
		}
		//mysql参数
		map.put("startPage_mysql", start);
		map.put("endPage_mysql", length);
		//oracle参数
		map.put("startPage", start+1);
		map.put("endPage", start+length);
		total = getNewAdapterService().countVarMapType(map);
		tmpList = getNewAdapterService().queryVarMapType(map);
		JSONObject json = new JSONObject();
		json.put("draw", draw);
		json.put("recordsTotal", length);
		json.put("recordsFiltered", total);
		JSONArray jsonArray = new JSONArray();
		if(null !=  tmpList && tmpList.size() > 0){
			for(Map itData : tmpList){
				JSONObject jsondata = new JSONObject();
				jsondata.put("id", String.valueOf(itData.get("VAR_MAP_TYPE_ID")));
				jsondata.put("varMapType", String.valueOf(itData.get("CONS_MAP_CD")));
				jsondata.put("name", String.valueOf(itData.get("NAME")));
				jsonArray.add(jsondata);
			}
		}
		json.put("data", jsonArray);
	    PrintWriter pw = null;
	    try {
			pw = this.getResponse().getWriter();
			pw.write(json.toString());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != pw){
				pw.flush();
				pw.close();
			}
		}
	}
	/**
	 * 获取变量映射表的值
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void getValableMap(){//pageConsMapCD
		List<Map> tmpList = new ArrayList<Map>() ;  		 
		Map map = new HashMap() ;  
		if(null != pageConsMapCD && !"".equals(pageConsMapCD)){
			map.put("consMapCD", pageConsMapCD);
		}else{
			map.put("consMapCD", "0");
		}
		//mysql参数
		map.put("startPage_mysql", start);
		map.put("endPage_mysql", length);
		//oracle参数
		map.put("startPage", start+1);
		map.put("endPage", start+length);
		total = getNewAdapterService().getCountValableMapByMap(map);
		tmpList = getNewAdapterService().getValableMapByMap(map);
		JSONObject json = new JSONObject();
		json.put("draw", draw);
		json.put("recordsTotal", length);
		json.put("recordsFiltered", total);
		JSONArray jsonArray = new JSONArray();
		if(null !=  tmpList && tmpList.size() > 0){
			for(Map itData : tmpList){
				JSONObject jsondata = new JSONObject();
				jsondata.put("varMappingId", String.valueOf(itData.get("VAR_MAPING_ID")));
				jsondata.put("consMapCd", String.valueOf(itData.get("CONS_MAP_CD")));
				jsondata.put("dataSource", getShuitDataValue(String.valueOf(itData.get("DATA_SOURCE"))));
				jsondata.put("dataSourceNum", String.valueOf(itData.get("DATA_SOURCE")));
				jsondata.put("keyExp", String.valueOf(itData.get("KEY_EXPRESS")));
				jsondata.put("valExp", String.valueOf(itData.get("VAL_EXPRESS")));
				jsondata.put("state", String.valueOf(itData.get("STATE")));
				jsonArray.add(jsondata);
			}
		}
		json.put("data", jsonArray);
	    PrintWriter pw = null;
	    try {
			pw = this.getResponse().getWriter();
			pw.write(json.toString());
			pw.flush();
			pw.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != pw){
				pw.flush();
				pw.close();
			}
		}
	}
	private Object getShuitDataValue(String type) {
		if(null != type && !"".equals(type) && !"null".equals(type)){
			if("1".equals(type)){
				return this.getText("eaap.op2.conf.adapter.fromDb");
			}else if("2".equals(type)){
				return this.getText("eaap.op2.conf.adapter.fromHost");
			}
		}
		return "";
	}
	private String getShuitValue(String type){
		if(null != type && !"".equals(type) && !"null".equals(type)){
			if("1".equals(type)){
				return this.getText("eaap.op2.conf.adapter.contractType1");
			}else if("2".equals(type)){
				return this.getText("eaap.op2.conf.adapter.contractType2");
			}else if("3".equals(type)){
				return this.getText("eaap.op2.conf.adapter.contractType3");
			}else if("4".equals(type)){
				return this.getText("eaap.op2.conf.adapter.contractType4");
			}else if("5".equals(type)){
				return this.getText("eaap.op2.conf.adapter.contractType5");
			}else if("6".equals(type)){
				return this.getText("eaap.op2.conf.adapter.contractType6");
			}
		}
		return "";
	}
	/**
	 * 加载所有数据
	 */
	public void loadAllData(){
		//协议转化表对象
		Map<String,String> mapt = new HashMap<String,String>() ;  
		mapt.put("pageContractAdapterId", pageContractAdapterId);
		Map contractAdapter = getNewAdapterService().getContractAdapterById(mapt);
		//协议端点列表
		List<Map>  listConAdaEnd = getNewAdapterService().getConAdaEndListById(mapt);
		Map<String,String> mapBaseList = new HashMap<String,String>();//存储协议及基类协议ID
		JSONObject allRecords = new JSONObject();
		JSONObject nodes = new JSONObject();
		JSONObject leftOrRight = new JSONObject();
		JSONObject contract = new JSONObject();
		JSONObject table = new JSONObject();
		if(null != contractAdapter){
			String srcCtrFId = String.valueOf(contractAdapter.get("SRCCTRFID"));
			String srcType = String.valueOf(contractAdapter.get("SRCTYPE"));
			if(null != srcCtrFId && !"".equals(srcCtrFId) && !"null".equals(srcCtrFId)){//说明有值
				JSONObject leftJson = getLeftJson(srcCtrFId,srcType,"XX");
				contract.put(srcCtrFId, leftJson);
				JSONObject tableJson = getTableJson(srcCtrFId,"L");
				table.put(srcCtrFId+"L", tableJson);
				//
				Map<String,String> map = new HashMap<String,String>() ;  
				map.put("tcpCtrFId", srcCtrFId);
		       //得到基类协议的协议格式ID
				String baseContractAdaperId  = getAdapterService().getTcpCtrFIdByMap(map);
				mapBaseList.put(srcCtrFId, baseContractAdaperId);
			}
			String tarCtrFId = String.valueOf(contractAdapter.get("TARCTRID"));
			String tarType = String.valueOf(contractAdapter.get("TARTYPE"));
            if(null != tarCtrFId && !"".equals(tarCtrFId) && !"null".equals(tarCtrFId)){//说明有值
            	JSONObject rightJson = getRightJson(tarCtrFId,tarType);
            	leftOrRight.put("RightNode", rightJson);
            	JSONObject tableJson = getTableJson(tarCtrFId,"R");
            	table.put(tarCtrFId+"r", tableJson);
            	//
				Map<String,String> map = new HashMap<String,String>() ;  
				map.put("tcpCtrFId", tarCtrFId);
		       //得到基类协议的协议格式ID
				String baseContractAdaperId  = getAdapterService().getTcpCtrFIdByMap(map);
				mapBaseList.put(tarCtrFId, baseContractAdaperId);
			}
		}
		//协议端点里的协议
		if(null != listConAdaEnd && listConAdaEnd.size()>0){
			for(Map valueMap : listConAdaEnd){
				String contractFormateId = String.valueOf(valueMap.get("CONTRACT_FORMATE_ID"));
				String conType = String.valueOf(valueMap.get("CON_TYPE"));
				String actionType = String.valueOf(valueMap.get("ACTION_TYPE"));
				if(null != contractFormateId && !"".equals(contractFormateId) && !"null".equals(contractFormateId)){//说明有值
					JSONObject leftJson = getLeftJson(contractFormateId,conType,actionType);
					contract.put(contractFormateId, leftJson);
					JSONObject tableJson = getTableJson(contractFormateId,"L");
					table.put(contractFormateId+"L", tableJson);
					//
					Map<String,String> map = new HashMap<String,String>() ;  
					map.put("tcpCtrFId", contractFormateId);
			       //得到基类协议的协议格式ID
					String baseContractAdaperId  = getAdapterService().getTcpCtrFIdByMap(map);
					mapBaseList.put(contractFormateId, baseContractAdaperId);
				}
			}
		}
		leftOrRight.put("LeftNode", contract);
		nodes.put("nodes", leftOrRight);
		//线操作
		Map mapTemp = new HashMap() ;  
		mapTemp.put("pageContractAdapterId", pageContractAdapterId);
		List<Map> nodeMapperList = getNewAdapterService().getNodeMapperListById(mapTemp);
		if(null != nodeMapperList && nodeMapperList.size() > 0){
			JSONObject lineJson = getLineJson(nodeMapperList,mapBaseList);
			nodes.put("lines", lineJson);
		}
		nodes.put("tables", table);
		allRecords.put("all", nodes);
		log.info("Mawl Node begin:{0}", "start");
		log.info("Mawl Node log:{0}", allRecords.toString());
		PrintWriter pw = null;
		try {
			pw = getResponse().getWriter();
			pw.write(allRecords.toString()) ;
			pw.flush();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if(null != pw){
				pw.close() ;
			}
		}
	}
	/**
	 * 得到表格数据
	 * @param srcCtrFId
	 * @param string
	 * @return
	 */
	private JSONObject getTableJson(String srcCtrFId, String action) {
		JSONObject tableJson = new JSONObject();
		Map mapt = new HashMap() ;  
		mapt.put("contractFormateId", srcCtrFId);
		String contractName = getNewAdapterService().getContractNameById(mapt);
		tableJson.put("id", srcCtrFId);
		tableJson.put("name", contractName);
		tableJson.put("action", action);
		return tableJson;
	}
	/**
	 * 得到线数据
	 * @param srcNodeDescId源节点ID
	 * @param srcTcpId 源协议ID
	 * @param actionType 动作类型
	 * @param tarNodeDescId 目标节点ID
	 * @param tarTcpId 目标协议ID
	 * @return
	 */
	private JSONObject getLineJson(List<Map> nodeMapperList,Map<String,String> mapBaseList) {
		JSONObject line = new JSONObject();
		for(Map lineMap : nodeMapperList){
			JSONObject content = new JSONObject();
			String srcNodeDescId = String.valueOf(lineMap.get("SRC_NODE_DESC_ID"));
			String srcTcpId = String.valueOf(lineMap.get("SRCTCPID"));
			String actionType = String.valueOf(lineMap.get("ACTION_TYPE_CD"));
			String tarNodeDescId = String.valueOf(lineMap.get("TAR_NODE_DESC_ID"));
			String tarTcpId = String.valueOf(lineMap.get("TARTCPID"));
			String key = "";
			if(null != srcTcpId && !"".equals(srcTcpId) && !"null".equals(srcTcpId)){
				for(Map.Entry<String, String> entry : mapBaseList.entrySet()){
					String keyCon = entry.getKey();
					String valueCon = entry.getValue();
					if(null != valueCon && !"".equals(valueCon)){
						if(valueCon.equals(srcTcpId)){
							srcTcpId = keyCon;
						}
					}
				}
			}
			if(null != tarTcpId && !"".equals(tarTcpId) && !"null".equals(tarTcpId)){
				for(Map.Entry<String, String> entry : mapBaseList.entrySet()){
					String keyCon = entry.getKey();
					String valueCon = entry.getValue();
					if(null != valueCon && !"".equals(valueCon)){
						if(valueCon.equals(tarTcpId)){
							tarTcpId = keyCon;
						}
					}
				}
			}
			content.put("type", "s1");
			if("M".equals(actionType)){
				content.put("from", srcTcpId+"L"+srcNodeDescId);
				content.put("operate", "Move");
				key=tarTcpId+"R"+tarNodeDescId+srcTcpId+"L"+srcNodeDescId;
			}else if("U".equals(actionType)){
				content.put("from", srcTcpId+"L"+srcNodeDescId);
				content.put("operate", "Logic");
				key=tarTcpId+"R"+tarNodeDescId+srcTcpId+"L"+srcNodeDescId;
			}else if("A".equals(actionType)){
				content.put("from", "");
				content.put("operate", "Assign");
				key=tarTcpId+"R"+tarNodeDescId;
			}else if("R".equals(actionType)){
				content.put("from", "");
				content.put("operate", "Other");
				key=tarTcpId+"R"+tarNodeDescId;
			}else if("Z".equals(actionType)){		//纵转横
				content.put("from", srcTcpId+"L"+srcNodeDescId);
				content.put("operate", "R to C");
				key=tarTcpId+"R"+tarNodeDescId+srcTcpId+"L"+srcNodeDescId;
			}else if("H".equals(actionType)){		//横转纵
				content.put("from", srcTcpId+"L"+srcNodeDescId);
				content.put("operate", "C to R");
				key=tarTcpId+"R"+tarNodeDescId+srcTcpId+"L"+srcNodeDescId;
			}else if("RFT".equals(actionType)){		//横转纵
				content.put("from", srcTcpId+"L"+srcNodeDescId);
				content.put("operate", "Reflect");
				key=tarTcpId+"R"+tarNodeDescId+srcTcpId+"L"+srcNodeDescId;
			}
			content.put("to", tarTcpId+"R"+tarNodeDescId);
			content.put("alt",true);
			line.put(key, content);
		}
		return line;
	}
	/**
	 * 得到右边协议的树级关系
	 * @param tarCtrFId  协议格式ID
	 * @param tarType协议格式类型
	 * @return
	 */
	private JSONObject getRightJson(String tarCtrFId, String tarType) {
		Map<String,String> map = new HashMap<String,String>() ;  
		map.put("tcpCtrFId", tarCtrFId);
		String pathStr = "";
		String contractFlag = "/";
		String parentNodeDescIdPath = "";
		if (tarType.equals("2")) {
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
			if (data.get("PARENT_NODE_ID") == null )  {
				dataList = getNodeDescLevel(data, tmpList, dataList, pathStr, i, contractFlag,parentNodeDescIdPath);
			}
		}
		JSONObject rNum = new JSONObject();
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
			     String nodePath = (String)dataMap.get("nodePath");
			     String nodeLocal = (String)dataMap.get("nodeType");
			     nodeValue.put("name", name);
			     nodeValue.put("nodeType", nodeTypeCons);
			     nodeValue.put("nodeNum", nodeNumberCons);
			     nodeValue.put("dept", dept);
			     nodeValue.put("path", path);
			     nodeValue.put("nodeDescIdPath", nodeDescIdPath);
			     nodeValue.put("childCount", childCount);
			     nodeValue.put("nodeDescId", nodeDescId);
			     nodeValue.put("nodePath", nodePath);
			     nodeValue.put("nodeLocal", nodeLocal);
			     rNum.put(tarCtrFId+"R" + nodeDescId, nodeValue);
			}
		}
		return rNum;
	}
	
	@SuppressWarnings("rawtypes")
	public String loadCToRLinesData() throws Exception {
		JSONObject allRecords = new JSONObject();
		String pageContractAdapterId = this.getPageContractAdapterId();
		String pageTarNodeDescId = this.getPageTarNodeDescId();
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", pageContractAdapterId);
		param.put("tarNodeDescId", pageTarNodeDescId);
		List<Map> nodeMapperList = getNewAdapterService().getRToCLinesDataById(param);
		allRecords.put("all", nodeMapperList);
		DataInteractiveUtil.actionResponsePage(getResponse(), allRecords);
		return null;
	}
	
	/**
	 * 得到左边协议的树级关系
	 * @param contractFormateId 协议格式ID
	 * @param conType 协议格式类型
	 * @param actionType 动作类型
	 * @return
	 */
	private JSONObject getLeftJson(String contractFormateId, String conType,
			String actionType) {
		Map<String,String> map = new HashMap<String,String>() ;  
		map.put("tcpCtrFId", contractFormateId);
		String pathStr = "";
		String contractFlag = "/";
		String parentNodeDescIdPath = "";
		if (conType.equals("2")) {
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
			if (data.get("PARENT_NODE_ID") == null )  {
				dataList = getNodeDescLevel(data, tmpList, dataList, pathStr, i, contractFlag,parentNodeDescIdPath);
			}
		}
		Map mapt = new HashMap() ;  
		mapt.put("contractFormateId", contractFormateId);
		String contractName = getNewAdapterService().getContractNameById(mapt);
		JSONObject contractLevel = new JSONObject(); 
		contractLevel.put("versionName", contractName);
		if("XX".equals(actionType)){
			contractLevel.put("flags", "false");
		}else{
			contractLevel.put("flags", actionType);
		}
//		contractLevel.put("flags", "false");
		contractLevel.put("checkbox", this.getText("eaap.op2.conf.protocol.intoprotocol"));
		contractLevel.put("actionR", this.getText("eaap.op2.conf.protocol.RAction"));
		contractLevel.put("actionT", this.getText("eaap.op2.conf.protocol.TAction"));
		contractLevel.put("inputId", this.getText("eaap.op2.conf.protocol.updateMessageFlowId"));
		JSONObject nodeKey = new JSONObject(); 
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
			     String nodePath = (String)dataMap.get("nodePath");
			     String nodeLocal = (String)dataMap.get("nodeType");
			     nodeValue.put("name", name);
			     nodeValue.put("nodeType", nodeTypeCons);
			     nodeValue.put("nodeNum", nodeNumberCons);
			     nodeValue.put("dept", dept);
			     nodeValue.put("path", path);
			     nodeValue.put("nodeDescIdPath", nodeDescIdPath);
			     nodeValue.put("childCount", childCount);
			     nodeValue.put("nodeDescId", nodeDescId);
			     nodeValue.put("nodePath", nodePath);
			     nodeValue.put("nodeLocal", nodeLocal);
			     nodeKey.put(contractFormateId+"L" + nodeDescId, nodeValue);
			}
		}
		contractLevel.put("nodeList", nodeKey);
		return contractLevel;
	}
	/**
	 * 获取节点Json数据结构
	 */
	public void getNodeDesc(){
		
		Map<String,String> map = new HashMap<String,String>() ;  
		map.put("tcpCtrFId", pageTcpCtrFId);
		String pathStr = "";
		String contractFlag = "/";
		String parentNodeDescIdPath = "";
		if (pageContractType.equals("2")) {
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
			if (data.get("PARENT_NODE_ID") == null )  {
				dataList = getNodeDescLevel(data, tmpList, dataList, pathStr, i, contractFlag,parentNodeDescIdPath);
			}
		}
		JSONObject nodes = new JSONObject(); //json根节点：nodes
		JSONObject lRAction = new JSONObject(); //左右节点层
		JSONObject rNum = new JSONObject(); 
		JSONObject contractLevel = new JSONObject(); //协议层
		if("L".equals(pageLoadSideFlg)){
			contractLevel.put("versionName", pageContractName);
			if("0".equals(getRequest().getParameter("pageContractNum"))){
				contractLevel.put("flags", "false");
			}else{
				contractLevel.put("flags", "T");
			}
			contractLevel.put("checkbox", this.getText("eaap.op2.conf.protocol.intoprotocol"));
			contractLevel.put("actionR", this.getText("eaap.op2.conf.protocol.RAction"));
			contractLevel.put("actionT", this.getText("eaap.op2.conf.protocol.TAction"));
			contractLevel.put("inputId", this.getText("eaap.op2.conf.protocol.updateMessageFlowId"));
			JSONObject nodeKey = new JSONObject(); 
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
				     String nodePath = (String)dataMap.get("nodePath");
				     String nodeLocal = (String)dataMap.get("nodeType");
				     nodeValue.put("name", name);
				     nodeValue.put("nodeType", nodeTypeCons);
				     nodeValue.put("nodeNum", nodeNumberCons);
				     nodeValue.put("dept", dept);
				     nodeValue.put("path", path);
				     nodeValue.put("nodeDescIdPath", nodeDescIdPath);
				     nodeValue.put("childCount", childCount);
				     nodeValue.put("nodeDescId", nodeDescId);
				     nodeValue.put("nodePath", nodePath);
				     nodeValue.put("nodeLocal", nodeLocal);
				     nodeKey.put(pageTcpCtrFId+pageLoadSideFlg + nodeDescId, nodeValue);
				}
			}
			contractLevel.put("nodeList", nodeKey);
			rNum.put(pageTcpCtrFId, contractLevel);
			lRAction.put("LeftNode", rNum);
		}else{//右节点
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
				     String nodePath = (String)dataMap.get("nodePath");
				     String nodeLocal = (String)dataMap.get("nodeType");
				     nodeValue.put("name", name);
				     nodeValue.put("nodeType", nodeTypeCons);
				     nodeValue.put("nodeNum", nodeNumberCons);
				     nodeValue.put("dept", dept);
				     nodeValue.put("path", path);
				     nodeValue.put("nodeDescIdPath", nodeDescIdPath);
				     nodeValue.put("childCount", childCount);
				     nodeValue.put("nodeDescId", nodeDescId);
				     nodeValue.put("nodePath", nodePath);
				     nodeValue.put("nodeLocal", nodeLocal);
				     rNum.put(pageTcpCtrFId+pageLoadSideFlg + nodeDescId, nodeValue);
				}
			}
			lRAction.put("RightNode", rNum);
		}
		nodes.put("nodes", lRAction);
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
	private List<Map<String,String>> getNodeDescLevel(Map data, List<Map> tmpList, 
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
		dataMap.put("nodePath", (String)data.get("NODE_PATH"));
		dataMap.put("nodeDescIdPath", nodeDescIdPath);
		dataMap.put("childCount", String.valueOf(data.get("CHILD_COUNT")));
		dataMap.put("dept", String.valueOf(dept));
		dataMap.put("nodeDescId", String.valueOf(data.get("NODE_DESC_ID")));
		dataMap.put("nodeType", String.valueOf(data.get("NODE_TYPE")));
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
	/**
	 * 保存协议转化规则
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void saveAdapterConfig(){
		Map paramMap = new HashMap();
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		String adapter_name = getText("eaap.op2.conf.adapter.contractAdapter")+tvname;
		if(null != pageTarTcpCtrFId && !"".equals(pageTarTcpCtrFId)){
			paramMap.put("tid", pageTarTcpCtrFId);
		}
		paramMap.put("type", type);
		paramMap.put("adapter_name", adapter_name);
		paramMap.put("state", "S");
		if(null != pageContractAdapterId && !"".equals(pageContractAdapterId)){//说明有适配ID存在
			Map<String,String> map = new HashMap<String,String>();
			if(null != pageTarTcpCtrFId && !"".equals(pageTarTcpCtrFId)){
				map.put("tarTcpCtrFId", pageTarTcpCtrFId);
			}
			map.put("adapterName", adapter_name);
			map.put("contractAdapterId", pageContractAdapterId+"");
			getAdapterService().updateContractAdapter(map);//修改协议转化规则
		}else{
			pageContractAdapterId = getAdapterService().addContractAdapter(paramMap)+"";//添加协议转化规则
		}
		//添加协议端点记录
		if(null != pageSrcTcpCtrFId && !"".equals(pageSrcTcpCtrFId)){
			String conAdaEndId = getNewAdapterService().getConAdaEndId();//得到协议端点表ID
			Map contractEndpoint = new HashMap();
			contractEndpoint.put("conAdaEndId", conAdaEndId);
			contractEndpoint.put("contractAdapterId", pageContractAdapterId);
			contractEndpoint.put("endPointId", pageEndpointId);
			contractEndpoint.put("srcTcpCtrFId", pageSrcTcpCtrFId);
			contractEndpoint.put("actionType", "T");
			getNewAdapterService().addConAdaEnd(contractEndpoint);
		}
		retMap.put("pageContractAdapterId",pageContractAdapterId);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 删除选中的协议
	 */
	public void delContractRecords(){
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", pageContractAdapterId);
		param.put("tcpCrtFId", pageTarTcpCtrFId);
		param.put("endpointId", pageEndpointId);
		getNewAdapterService().updateContractRecords(param);//去掉协议转换表中的源节点记录(如果存在的话)
		getNewAdapterService().delConAdaEndByMap(param);//去掉协议端点里面的记录(如果存在的话)
	}
	/**
	 * 判断动作类型是否存在
	 */
	public void isExitOperator(){
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		String result = getNewAdapterService().isExitOperator(this.getOperator(),this.getPageContractAdapterId());
		retMap.put("result",result);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 判断线操作是否存在
	 */
	public void isExitLine(){
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", this.getPageContractAdapterId());
		param.put("operator", this.getOperator());
		if(null != this.getPageSrcNodeDescId() && !"".equals(this.getPageSrcNodeDescId())){
			param.put("srcNodeDescId", this.getPageSrcNodeDescId());
		}
		param.put("tarNodeDescId", this.getPageTarNodeDescId());
		String result = getNewAdapterService().isExitLine(param);
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		retMap.put("result",result);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 获得点击前的状态
	 */
	public void getActionValue(){
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", this.getPageContractAdapterId());
		param.put("contractFormatId", this.getPageSrcTcpCtrFId());
		String result = getNewAdapterService().getActionValue(param);
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		retMap.put("result",result);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 协议格式转换动作
	 */
	public void changeToAction(){
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", this.getPageContractAdapterId());
		param.put("operator", this.getOperator());
		param.put("srcTcpCtrFId", this.getPageSrcTcpCtrFId());
		param.put("endpointId", this.getPageEndpointId());
		String result = getNewAdapterService().changeToAction(param);
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		retMap.put("result",result);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 取得节点取值要求信息
	 */
	public void getNodeValAdaReq(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", this.getPageContractAdapterId());
		param.put("tarNodeDescId", this.getPageTarNodeDescId());
		List<Map> resultList = getNewAdapterService().getNodeValAdaReq(param);
		if(null != resultList && resultList.size() > 0){
			retMap.put("result", "HAVE_DATA");
			retMap.put("nodeReqId", String.valueOf(resultList.get(0).get("NODE_VAL_ADAPTER_REQ_ID")));
			retMap.put("valueWay",String.valueOf(resultList.get(0).get("NODE_VALUE_SOURCE_CD")));
			if("8".equals(String.valueOf(resultList.get(0).get("NODE_VALUE_SOURCE_CD")))) {
				retMap.put("valueExp",getNewAdapterService().unAssembleValueExpression((String)resultList.get(0).get("VALUE_EXPRESS")));
			} else if("9".equals(String.valueOf(resultList.get(0).get("NODE_VALUE_SOURCE_CD")))) {
				retMap.put("valueExp",getNewAdapterService().unAssembleReflectValueExpression((String)resultList.get(0).get("VALUE_EXPRESS")));
			} else {
				retMap.put("valueExp",String.valueOf(resultList.get(0).get("VALUE_EXPRESS")));
			}
			retMap.put("valueScript",String.valueOf(resultList.get(0).get("SCRIPT")));
			retMap.put("triggerExp",String.valueOf(resultList.get(0).get("TRIGGER_EXPRESS")));
		}else{
			retMap.put("result", "NO_DATA");
		}
		JSONObject json = new JSONObject();
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 添加节点取值要求
	 */
	public void addNodeValAdapterRes(){
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractAdapterId", this.getPageContractAdapterId());
		param.put("nodeDescId", this.getPageTarNodeDescId());
		param.put("nodeValueSourceCd", this.getType());
		if(null != pageNodeValue && !"".equals(pageNodeValue)){
			param.put("valueExpress", this.getPageNodeValue());
		}
		if(StringUtils.hasText(pageComplexCondition)) {
			param.put("valueExpress", getNewAdapterService().assembleValueExpression(this.getPageComplexCondition()));
		} 
		if(StringUtils.hasText(getPageRelectExpress())) {
			param.put("valueExpress", getNewAdapterService().assembleReflectValueExpression(this.getPageRelectExpress()));
		}
		if(null != pageScript && !"".equals(pageScript)){
			param.put("script", pageScript);
		}
		param.put("triggerExpress", this.getPageCondition());
		String result = getNewAdapterService().addNodeValAdapterRes(param);
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		retMap.put("result",result);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	
	
	/**
	 * 获取函数列表
	 */
	public void getFunctionList(){
		Map<String,String> param = new HashMap<String,String>();
		String result = getNewAdapterService().getFunctionList();
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		retMap.put("result",result);
		retMap.put("code", "success");
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	
	/**
	 * 添加变量映射类型表
	 */
	public void addVarMapType(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("name", pageConsMapName);
		param.put("consMapCD", pageConsMapCD);
		int cnt = this.getAdapterService().isVarMapTypeExit(param);
		if(0==cnt){
			Integer id = this.getAdapterService().saveVarMapType(param);
			retMap.put("result", "success");
			retMap.put("errMsg", id+"");
		}else{
			retMap.put("result", "error");
			retMap.put("errMsg", getText("eaap.op2.conf.adapter.varMapTypeExist"));
		}
		JSONObject json = new JSONObject();
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 得到变量映射类型名称
	 */
	public void getVarMapTypeName(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("consMapCD", pageConsMapCD);
		String result = getNewAdapterService().getVarMapTypeName(param);
		JSONObject json = new JSONObject();
		retMap.put("result", result);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 添加变量映射表
	 */
	public void addVariableMap(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("consMapCD", pageConsMapCD);
		param.put("dataSource", pageDataSource);
		param.put("keyExpress", pageKeyExp);
		param.put("valExpress", pageValExp);
		param.put("contractAdapterId",pageContractAdapterId);
		this.getAdapterService().saveVariableMap(param);
		JSONObject json = new JSONObject();
		retMap.put("result", "success");
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 修改变量映射表
	 */
	public void updateVariableMap(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("varMapingId", pageVarMappingId);
		param.put("consMapCD", pageConsMapCD);
		param.put("dataSource", pageDataSource);
		param.put("keyExpress", pageKeyExp);
		param.put("valExpress", pageValExp);
		param.put("contractAdapterId",pageContractAdapterId);
		this.getAdapterService().updateVariableMap(param);
		JSONObject json = new JSONObject();
		retMap.put("result", "success");
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 查看消息流Id
	 */
	public void showMessageFlowId(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("contractFormatId", pageSrcTcpCtrFId);
		param.put("contractAdapterId",pageContractAdapterId);
		List<Map> list = this.getNewAdapterService().getContractFormat(param);
		String messageFlowId =  "";
		if(null !=  list && list.size()>0){
			if(null != list.get(0).get("ENDPOINT_ID")){
				messageFlowId = String.valueOf(list.get(0).get("ENDPOINT_ID"));
			}
		}
		JSONObject json = new JSONObject();
		retMap.put("messageFlowId", messageFlowId);
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 修改消息流
	 */
	public void updateResult(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("endPointId", pageEndpointId);
		param.put("contractFormatId", pageSrcTcpCtrFId);
		param.put("contractAdapterId",pageContractAdapterId);
		this.getNewAdapterService().updateResult(param);
		JSONObject json = new JSONObject();
		retMap.put("result", "success");
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 删除变量映射类型
	 */
	public void deleteVarMapType(){
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("varMapTypeId", pageVarMapTypeId);
		this.getNewAdapterService().deleteVarMapType(param);
		JSONObject json = new JSONObject();
		retMap.put("result", "success");
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 是否可以提交数据
	 */
	public void isOrNotSubmit(){
		Map<String,String> retMap = new HashMap<String,String>();
		JSONObject json = new JSONObject();
		boolean flag = false;
		Map<String,String> map = new HashMap<String,String>() ;  
		map.put("pageContractAdapterId", pageContractAdapterId);
		Map contractAdapter = getNewAdapterService().getContractAdapterById(map);
		if(null != contractAdapter){
			String srcCtrFId = String.valueOf(contractAdapter.get("SRCCTRFID"));
			String tarCtrFId = String.valueOf(contractAdapter.get("TARCTRID"));
			if(null !=srcCtrFId && !"".equals(srcCtrFId) &&!"null".equals(srcCtrFId) && !"0".equals(srcCtrFId)
					&& null !=tarCtrFId && !"".equals(tarCtrFId) &&!"null".equals(tarCtrFId) && !"0".equals(tarCtrFId)){
				flag = true;
			}
		}
		if(flag){
			retMap.put("result", "success");
		}else{
			retMap.put("result", "fail");
		}
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 脚本保存
	 */
	public void saveScriptAdapter(){
		JSONObject json = new JSONObject();
		Map<String,String> retMap = new HashMap<String,String>();
		Map<String,String> param = new HashMap<String,String>();
		param.put("adapterType", pageAdapterType);
		param.put("scriptSrc", pageScriptFileText);
		param.put("state", "A");
		if (pageContractAdapterId!=null && !"".equals(pageContractAdapterId)) {
			param.put("srcTcpCtrFId", "0");
			param.put("tarTcpCtrFId", "0");
			param.put("contractAdapterId", pageContractAdapterId);
			getAdapterService().updateContractAdapter(param);
			getAdapterService().delNodeMaper(param);//删除节点映射信息
		    getAdapterService().delAdapterReq(param);//删除节点取值要求信息
			Map<String,String> param2 = new HashMap<String,String>();
			param2.put("pageContractAdapterId", pageAdapterType);
		    getNewAdapterService().delAdapterEndpoint(param2);//删除协议端点信息
		    retMap.put("msg", "update");
		    retMap.put("contractAdapterId", pageContractAdapterId);
		   } else {
			   pageContractAdapterId = getAdapterService().insertContractAdapter(param)+"";
			   retMap.put("msg", "add");
			   retMap.put("contractAdapterId", pageContractAdapterId);
		   }
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	/**
	 * 删除变量映射表
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void delVariableMap(){
		Map mapTemp = new HashMap();  
		mapTemp.put("varMapingID", pageVarMappingId);		
		this.getAdapterService().delVariableMap(mapTemp);
		Map map = new HashMap();
		map.put("contractAdapterId",pageContractAdapterId);
		map.put("varMapingId", pageVarMappingId);
		this.getAdapterService().updateTransScript(map);
	}
	/**
	 * 添加节点
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void saveNodeDescMap(){
		Map paramMap = new HashMap();
		if(null!=pageSrcNodeDescId&& !"".equals(pageSrcNodeDescId)){
			paramMap.put("src_node_desc_id", pageSrcNodeDescId);
		}
			paramMap.put("tar_node_desc_id", pageTarNodeDescId);
			paramMap.put("action_type_cd", operator);
			paramMap.put("contract_adapter_id", pageContractAdapterId);
		if(null!=pageContractAdapterId){
			if(this.getAdapterService().isNodeMapDecExit(paramMap)){
				this.getAdapterService().addNodeDescMap(paramMap);
			}else{
				this.getAdapterService().updateNodeDescMap(paramMap);
			}
		}
	}
	/**
	 * 删除节点
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void delNodeDescMap(){
		Map map = new HashMap();
		if(!"".equals(pageSrcNodeDescId)&&null!=pageSrcNodeDescId){
			map.put("sid", pageSrcNodeDescId);
		}
		map.put("nodeDescId", pageTarNodeDescId);
		map.put("contractAdapterId", pageContractAdapterId);
		this.getAdapterService().delNodeDescMap(map);
		this.getAdapterService().delNodeValAdapterRea(map);//删除节点取值要求
	}
	/////////////javabean
	public INewAdapterService getNewAdapterService() {
		if (newAdapterService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			newAdapterService = (INewAdapterService) ctx.getBean("eaap-op2-conf-newAdapterService");
		}
		return newAdapterService;
	}
	public void setNewAdapterService(INewAdapterService adapterService) {
		this.newAdapterService = adapterService;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getDraw() {
		return draw;
	}
	public void setDraw(int draw) {
		this.draw = draw;
	}public IAdapterService getAdapterService() {
		if (adapterService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			adapterService = (IAdapterService) ctx.getBean("eaap-op2-conf-adapterService");
		}
		return adapterService;
	}
	public void setAdapterService(IAdapterService adapterService) {
		this.adapterService = adapterService;
	}
	public String getPageTcpCtrFId() {
		return pageTcpCtrFId;
	}
	public void setPageTcpCtrFId(String pageTcpCtrFId) {
		this.pageTcpCtrFId = pageTcpCtrFId;
	}
	public String getPageContractType() {
		return pageContractType;
	}
	public void setPageContractType(String pageContractType) {
		this.pageContractType = pageContractType;
	}
	public String getPageLoadSideFlg() {
		return pageLoadSideFlg;
	}
	public void setPageLoadSideFlg(String pageLoadSideFlg) {
		this.pageLoadSideFlg = pageLoadSideFlg;
	}
	public String getPageProtocolName() {
		return pageProtocolName;
	}
	public void setPageProtocolName(String pageProtocolName) {
		this.pageProtocolName = pageProtocolName;
	}
	public String getPageContractVersion() {
		return pageContractVersion;
	}
	public void setPageContractVersion(String pageContractVersion) {
		this.pageContractVersion = pageContractVersion;
	}
	public String getPageProtocolType() {
		return pageProtocolType;
	}
	public void setPageProtocolType(String pageProtocolType) {
		this.pageProtocolType = pageProtocolType;
	}
	public String getPageReqRsp() {
		return pageReqRsp;
	}
	public void setPageReqRsp(String pageReqRsp) {
		this.pageReqRsp = pageReqRsp;
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
	public String getPageContractName() {
		return pageContractName;
	}
	public void setPageContractName(String pageContractName) {
		this.pageContractName = pageContractName;
	}
	public String getPageTcpCtrFIdList() {
		return pageTcpCtrFIdList;
	}
	public void setPageTcpCtrFIdList(String pageTcpCtrFIdList) {
		this.pageTcpCtrFIdList = pageTcpCtrFIdList;
	}
	public String getPageTarTcpCtrFId() {
		return pageTarTcpCtrFId;
	}
	public void setPageTarTcpCtrFId(String pageTarTcpCtrFId) {
		this.pageTarTcpCtrFId = pageTarTcpCtrFId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSvname() {
		return svname;
	}
	public void setSvname(String svname) {
		this.svname = svname;
	}
	public String getTvname() {
		return tvname;
	}
	public void setTvname(String tvname) {
		this.tvname = tvname;
	}
	public String getPageContractAdapterId() {
		return pageContractAdapterId;
	}
	public void setPageContractAdapterId(String pageContractAdapterId) {
		this.pageContractAdapterId = pageContractAdapterId;
	}
	public String getPageSrcTcpCtrFId() {
		return pageSrcTcpCtrFId;
	}
	public void setPageSrcTcpCtrFId(String pageSrcTcpCtrFId) {
		this.pageSrcTcpCtrFId = pageSrcTcpCtrFId;
	}
	public String getPageEndpointId() {
		return pageEndpointId;
	}
	public void setPageEndpointId(String pageEndpointId) {
		this.pageEndpointId = pageEndpointId;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getPageSrcNodeDescId() {
		return pageSrcNodeDescId;
	}
	public void setPageSrcNodeDescId(String pageSrcNodeDescId) {
		this.pageSrcNodeDescId = pageSrcNodeDescId;
	}
	public String getPageTarNodeDescId() {
		return pageTarNodeDescId;
	}
	public void setPageTarNodeDescId(String pageTarNodeDescId) {
		this.pageTarNodeDescId = pageTarNodeDescId;
	}
	public String getPageNodeValAdapterReqId() {
		return pageNodeValAdapterReqId;
	}
	public void setPageNodeValAdapterReqId(String pageNodeValAdapterReqId) {
		this.pageNodeValAdapterReqId = pageNodeValAdapterReqId;
	}
	public String getPageConsMapCD() {
		return pageConsMapCD;
	}
	public void setPageConsMapCD(String pageConsMapCD) {
		this.pageConsMapCD = pageConsMapCD;
	}
	public String getPageCondition() {
		return pageCondition;
	}
	public void setPageCondition(String pageCondition) {
		this.pageCondition = pageCondition;
	}
	public String getPageNodeValue() {
		return pageNodeValue;
	}
	public void setPageNodeValue(String pageNodeValue) {
		this.pageNodeValue = pageNodeValue;
	}
	public String getPageScript() {
		return pageScript;
	}
	public void setPageScript(String pageScript) {
		this.pageScript = pageScript;
	}
	public List<Map<String, Object>> getMetaDataMachingL() {
		return metaDataMachingL;
	}
	public void setMetaDataMachingL(List<Map<String, Object>> metaDataMachingL) {
		this.metaDataMachingL = metaDataMachingL;
	}
	public String getPageConsMapName() {
		return pageConsMapName;
	}
	public void setPageConsMapName(String pageConsMapName) {
		this.pageConsMapName = pageConsMapName;
	}
	public String getPageDataSource() {
		return pageDataSource;
	}
	public void setPageDataSource(String pageDataSource) {
		this.pageDataSource = pageDataSource;
	}
	public String getPageKeyExp() {
		return pageKeyExp;
	}
	public void setPageKeyExp(String pageKeyExp) {
		this.pageKeyExp = pageKeyExp;
	}
	public String getPageValExp() {
		return pageValExp;
	}
	public void setPageValExp(String pageValExp) {
		this.pageValExp = pageValExp;
	}
	public String getPageVarMappingId() {
		return pageVarMappingId;
	}
	public void setPageVarMappingId(String pageVarMappingId) {
		this.pageVarMappingId = pageVarMappingId;
	}
	public String getPageState() {
		return pageState;
	}
	public void setPageState(String pageState) {
		this.pageState = pageState;
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
	public String getTransformerRuleId() {
		return transformerRuleId;
	}
	public void setTransformerRuleId(String transformerRuleId) {
		this.transformerRuleId = transformerRuleId;
	}
	public List<Map<String, Object>> getScriptL() {
		return scriptL;
	}
	public void setScriptL(List<Map<String, Object>> scriptL) {
		this.scriptL = scriptL;
	}
	public String getPageScriptFileText() {
		return pageScriptFileText;
	}
	public void setPageScriptFileText(String pageScriptFileText) {
		this.pageScriptFileText = pageScriptFileText;
	}
	public String getPageAdapterType() {
		return pageAdapterType;
	}
	public void setPageAdapterType(String pageAdapterType) {
		this.pageAdapterType = pageAdapterType;
	}
	public String getPageVarMapTypeId() {
		return pageVarMapTypeId;
	}
	public void setPageVarMapTypeId(String pageVarMapTypeId) {
		this.pageVarMapTypeId = pageVarMapTypeId;
	}
	public String getMoreSource() {
		return moreSource;
	}
	public void setMoreSource(String moreSource) {
		this.moreSource = moreSource;
	}
	public List<Map<String, Object>> getMoreSourceList() {
		return moreSourceList;
	}
	public void setMoreSourceList(List<Map<String, Object>> moreSourceList) {
		this.moreSourceList = moreSourceList;
	}
	public String getNewState() {
		return newState;
	}
	public void setNewState(String newState) {
		this.newState = newState;
	}
	public String getAttrSpecCode() {
		return attrSpecCode;
	}
	public void setAttrSpecCode(String attrSpecCode) {
		this.attrSpecCode = attrSpecCode;
	}
	public String getPageComplexCondition() {
		return pageComplexCondition;
	}
	public void setPageComplexCondition(String pageComplexCondition) {
		this.pageComplexCondition = pageComplexCondition;
	}
	public String getPageRelectExpress() {
		return pageRelectExpress;
	}
	public void setPageRelectExpress(String pageRelectExpress) {
		this.pageRelectExpress = pageRelectExpress;
	}
}
