/*
 * @(#)AdapterServiceImpl.java        2013-8-20
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import com.ailk.eaap.op2.bo.NodeValReq;
import com.ailk.eaap.op2.bo.TransformerRule;
import com.ailk.eaap.op2.bo.ExtendMethod;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.conf.adapter.dao.IAdapterDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;

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

public class AdapterServiceImpl implements IAdapterService{
	
	private Logger log = Logger.getLogger("eaap_conf");
	
	private IAdapterDao adapterDao;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	
	public String testXML="<ContractRoot> "
		+" 	<TcpCont> "
		+" 		<TransactionID>1000000083201306060103025935</TransactionID> "
		+" 		<ActionCode>0</ActionCode> "
		+" 		<BusCode>BUS37017</BusCode> "
		+" 		<ServiceCode>SVC11001</ServiceCode> "
		+" 		<ServiceContractVer>SVC1100120110501</ServiceContractVer> "
		+" 		<ServiceLevel>1</ServiceLevel> "
		+" 		<SrcOrgID>100000</SrcOrgID> "
		+" 		<SrcSysID>1000000083</SrcSysID> "
		+" 		<SrcSysSign>integral10000000830803</SrcSysSign> "
		+" 		<DstOrgID>600104</DstOrgID> "
		+" 		<DstSysID>6001040003</DstSysID> "
		+" 		<ReqTime>20130606152629</ReqTime> "
		+" 	</TcpCont> "
		+" 	<SvcCont> "
		+" 		<QryInfoReq> "
		+" 			<InfoTypeID>81</InfoTypeID> "
		+" 			<PartyCodeInfo> "
		+" 				<CodeType>11</CodeType> "
		+" 				<CodeValue>18069709506</CodeValue> "
		+" 				<CityCode>0572</CityCode> "
		+" 			</PartyCodeInfo> "
		+" 			<Conditions> "
		+" 				<CondItemID>1</CondItemID> "
		+" 				<CondItemValue>201306</CondItemValue> "
		+" 			</Conditions> "
		+" 		</QryInfoReq> "
		+" 	</SvcCont> "
		+" </ContractRoot> ";

	/**
	 * 获取新的节点ID
	 * @return
	 */		
	public String getNewNodeId(){
		return adapterDao.getNewNodeId();
	}
	
	/**
	 * 获取新的节点内容操作配置ID
	 * @return
	 */	
	public String getNewOperNodeId(){
		return adapterDao.getNewOperNodeId();
	}	
	
	/**
	 * 获取新的节点路径配置ID
	 * @return
	 */	
	public String getNewPathId(){
		return adapterDao.getNewPathId();
	}
	
	/**
	 * 查询数据集
	 * @return
	 */
	public List queryDataSetList(Map map){	
		return adapterDao.queryDataSetList(map);
	}
	
	public int countDataSetList(Map map){
		return adapterDao.countDataSetList(map);
	}
	
	/**
	 * 查询扩展方式列表
	 * @return
	 */
	public List queryExtendList(Map map){
		return adapterDao.queryExtendList(map);
	}
	
	public int countExtendList(Map map){
		return adapterDao.countExtendList(map);
	}
	
	public List getProtocalAdapterList(Map map){
		List protocolAdapterList =  adapterDao.queryProtocolAdapterObjectByAdapterId(map);
		return protocolAdapterList;
	}
	
	public List getProtocalAdapterListByProtocol(Map map){
		List protocolAdapterList =  adapterDao.queryProtocalAdapterListObjectByProtocol(map);
		return protocolAdapterList;		
	}
	
	/**
	 * 根据传入的协议适配ID生成目标文档的文档结构树
	 * @param treeDocument
	 * @param adapterId  协议适配ID
	 * @param treeDocument
	 * @return 
	 */
	public void generateTreeStructure(Document treeDocument,String adapterId) throws DocumentException{

	}
	
	public void getAdapterConfigInfo(Document configDocument,String adapterId) throws DocumentException{

	}
	
	/**
	 * 根据适配协议ID生成APAPTER_NODE_CONFIG_COLLECTION元素
	 * @param adapterId
	 * @return
	 */
	public Element getAdapterNodeConfigCollectionElement(String adapterId){

		return null;
	}
	
	/**
	 * 根据节点ID生成NODE_CONTENT_CONFIG_COLLECTION元素
	 * @param nodeId
	 * @return
	 */
	public Element getNodeContentConfigCollectionElement(String nodeId){

		return null;
	}
	
	/**
	 * 根据节点操作方式NODE_OPER_ID生成NODE_PROPERTY_CONFIG_COLLECTION元素
	 * @param nodeId
	 * @return
	 */
	public Element getNodePropertyConfigCollectionElement(String nodeOperId){
		
		return null;
	}
	
	/**
	 * 根据节点操作方式NODE_OPER_ID生成NODE_PATH_CONFIG_COLLECTION元素
	 * @param nodeId
	 * @return
	 */	
	public Element getNodePathConfigCollectionElement(String nodeOperId){

		return null;
	}
	
	public void querySomeQuerySQLInfo(Document querySQLDocument,String dataSetId) throws DocumentException{

	}
	
	public void querySomeExtendMethodInfo(Document extendMethodDocument,String methodId) throws DocumentException{
		try{
			Element extendMethodElement = DocumentHelper.createElement("EXTEND_METHOD");
			Map mapTemp = new HashMap() ;  
			mapTemp.put("methodId", methodId);
			List extendMethodList =  adapterDao.querySomeExtendMethodInfo(mapTemp);
			for (int i=0;i<extendMethodList.size();i++){
				ExtendMethod extendMethod = (ExtendMethod)extendMethodList.get(i);
				extendMethodElement.addAttribute("method_id",methodId);
				String methodType = extendMethod.getMethodType();
				extendMethodElement.addAttribute("method_type",methodType);
				String methodName = extendMethod.getMethodName();
				extendMethodElement.addAttribute("method_name",methodName);				
				String className = extendMethod.getClassName();
				extendMethodElement.addAttribute("class_name",className);
				String beanid = extendMethod.getBeanid();
				extendMethodElement.addAttribute("beanid",beanid);
				String remarks = extendMethod.getRemarks();
				extendMethodElement.addAttribute("remarks",remarks);
				String segmentRealize = extendMethod.getSegmentRealize();
				extendMethodElement.addAttribute("segment_realize",segmentRealize);
				String state = extendMethod.getState();
				extendMethodElement.addAttribute("state",state);				
			}
			extendMethodDocument.add(extendMethodElement);
		}catch(Exception e){
			log.error(e.getStackTrace());
		}
	}	
	
	/**
	 * 保存协议适配配置
	 * @param paramMap
	 */	
	public void saveProcotolAdapter(Map paramMap){
		Document doc=(Document)paramMap.get("Document");
		String adapter_Id="";
		int index=0;
		
		Element root = doc.getRootElement();
		Element adapter_Node_Config_CollectionElement = root.element("APAPTER_NODE_CONFIG_COLLECTION");
		adapter_Id = root.attributeValue("adapter_id");
		//1删除旧数据
		//1.1删除 NODE_PATH_CONFIG的配置
		Map mapTemp = new HashMap() ;  
		mapTemp.put("adapterId", adapter_Id);
		adapterDao.deleteNodePathConfigByAdapterId(mapTemp);
		//1.2删除 NODE_PROPERTY_CONFIG的配置
		//1.3删除 NODE_CONTENT_CONFIG的配置
		adapterDao.deleteNodeContentConfigByAdapterId(mapTemp);
		//1.4删除 APAPTER_NODE_CONFIG的配置
		adapterDao.deleteAdapterNodeConfigByAdapterId(mapTemp);
		
		List list = adapterDao.queryAdapterNodeConfigByAdapterId(mapTemp);
		for(int i=0;i<list.size();i++){
			Map resultMap = (HashMap) list.get(i);
		}
		
		//解析保存新的数据
		List adapterNodeConfigList = adapter_Node_Config_CollectionElement.elements();
		for (int i=0;i<adapterNodeConfigList.size();i++){
			Element adapterNodeConfigElement = (Element)adapterNodeConfigList.get(i);
			//保存 adapterNodeConfigElement 配置数据
			saveAdapterNodeConfigElement(adapterNodeConfigElement);
			Element nodeContentConfigCollectionElement = adapterNodeConfigElement.element("NODE_CONTENT_CONFIG_COLLECTION");
			log.debug(adapterNodeConfigElement.asXML());
			List nodeContentConfigList = nodeContentConfigCollectionElement.elements();
			for(int j=0;j<nodeContentConfigList.size();j++){
				Element nodeContentConfigElement = (Element) nodeContentConfigList.get(j);
				saveNodeContentConfigElement(nodeContentConfigElement);
				log.debug("nodeContentConfigElement xml="+nodeContentConfigElement.asXML());
				Element nodePathConfigCollectionElement = nodeContentConfigElement.element("NODE_PATH_CONFIG_COLLECTION");
				List nodePathConfigList = nodePathConfigCollectionElement.elements();
				for(int k=0;k<nodePathConfigList.size();k++){
					Element nodePathConfigElement = (Element) nodePathConfigList.get(k);
					saveNodePathConfigElement(nodePathConfigElement);
				}
			}
		}
		paramMap.put("adapter_Id", adapter_Id);
		paramMap.put("result", "success");
	}
	
	/**
	 * 保存节点配置数据
	 * @param adapterNodeConfigElement
	 */
	public void saveAdapterNodeConfigElement(Element adapterNodeConfigElement){
		String state = adapterNodeConfigElement.attributeValue("state");
		String xml_Path = adapterNodeConfigElement.attributeValue("xml_path");
		String parent_Node_Id = adapterNodeConfigElement.attributeValue("parent_node_id");
		parent_Node_Id = "".equals(parent_Node_Id)?"0":parent_Node_Id;
		String operate_Type = adapterNodeConfigElement.attributeValue("operate_type");
		String sort_Order = adapterNodeConfigElement.attributeValue("sort_order");
		String nameSpaceUri = adapterNodeConfigElement.attributeValue("namespaceuri");
		String condiitonal_Relation = adapterNodeConfigElement.attributeValue("conditional_relation");
		String node_Name = adapterNodeConfigElement.attributeValue("node_name");
		String qnameFlag = adapterNodeConfigElement.attributeValue("qnameflag");
		String nameSpacepreFix = adapterNodeConfigElement.attributeValue("namespaceprefix");
		String node_Type = adapterNodeConfigElement.attributeValue("node_type");
		String auto_Add_Flag=adapterNodeConfigElement.attributeValue("auto_add_flag");
		String node_Id=adapterNodeConfigElement.attributeValue("node_id");
		String adapter_Id=adapterNodeConfigElement.attributeValue("adapter_id");
		String limitTime=adapterNodeConfigElement.attributeValue("limittime");
		
		Map adapterNodeConfigMap=new HashMap();
		adapterNodeConfigMap.put("state", state);
		adapterNodeConfigMap.put("xml_Path", xml_Path);
		adapterNodeConfigMap.put("parent_Node_Id", parent_Node_Id);
		adapterNodeConfigMap.put("operate_Type", operate_Type);
		adapterNodeConfigMap.put("sort_Order", sort_Order);
		adapterNodeConfigMap.put("nameSpaceUri", nameSpaceUri);
		adapterNodeConfigMap.put("condiitonal_Relation", condiitonal_Relation);
		adapterNodeConfigMap.put("node_Name", node_Name);
		adapterNodeConfigMap.put("qnameFlag", qnameFlag);
		adapterNodeConfigMap.put("nameSpacepreFix", nameSpacepreFix);
		adapterNodeConfigMap.put("node_Type", node_Type);
		adapterNodeConfigMap.put("auto_Add_Flag", auto_Add_Flag);
		adapterNodeConfigMap.put("node_Id", node_Id);
		adapterNodeConfigMap.put("adapter_Id", adapter_Id);
		adapterNodeConfigMap.put("limitTime", limitTime);
		adapterDao.saveAdapterNodeConfig(adapterNodeConfigMap);
	}
	
	/**
	 * 保存节点内容操作配置
	 * @param nodeContentConfigElement
	 */
	public void saveNodeContentConfigElement(Element nodeContentConfigElement){
		String state = nodeContentConfigElement.attributeValue("state");
		String node_Oper_Id = nodeContentConfigElement.attributeValue("node_oper_id");
		String par_Node_Oper_Id = nodeContentConfigElement.attributeValue("par_node_oper_id");
		par_Node_Oper_Id = ("".equals(par_Node_Oper_Id))?null:par_Node_Oper_Id;
		String relation_Produce_Type = nodeContentConfigElement.attributeValue("relation_produce_type");
		String isincdata = nodeContentConfigElement.attributeValue("isincdata");
		String sort_Order = nodeContentConfigElement.attributeValue("sort_order");
		String conditional_Relation = nodeContentConfigElement.attributeValue("conditional_relation");
		String restriction_Ids = nodeContentConfigElement.attributeValue("restriction_ids");
		String cont_Converter_Para = nodeContentConfigElement.attributeValue("cont_converter_para");
		String relation_Condition = nodeContentConfigElement.attributeValue("relation_condition");
		String src_Map_Type = nodeContentConfigElement.attributeValue("src_map_type");
		String method_Id=nodeContentConfigElement.attributeValue("method_id");
		method_Id = ("".equals(method_Id))?null:method_Id;
		String fix_Value=nodeContentConfigElement.attributeValue("fix_value");
		String par_Data_Set_Id=nodeContentConfigElement.attributeValue("par_data_set_id");
		par_Data_Set_Id = ("".equals(par_Data_Set_Id))?null:par_Data_Set_Id;
		String col_Name=nodeContentConfigElement.attributeValue("col_name");
		String data_Set_Id=nodeContentConfigElement.attributeValue("data_set_id");
		String cont_Converter_Id=nodeContentConfigElement.attributeValue("cont_converter_id");
		cont_Converter_Id = ("".equals(cont_Converter_Id))?null:cont_Converter_Id;
		String auto_Add_Flag=nodeContentConfigElement.attributeValue("auto_add_flag");
		String node_Id=nodeContentConfigElement.attributeValue("node_id");
		String delete_Type=nodeContentConfigElement.attributeValue("delete_type");
		String content_Type=nodeContentConfigElement.attributeValue("content_type");
		
		Map nodeContentConfigMap=new HashMap();
		nodeContentConfigMap.put("state", state);
		nodeContentConfigMap.put("node_Oper_Id", node_Oper_Id);
		nodeContentConfigMap.put("par_Node_Oper_Id", par_Node_Oper_Id);
		nodeContentConfigMap.put("relation_Produce_Type", relation_Produce_Type);
		nodeContentConfigMap.put("isincdata", isincdata);
		nodeContentConfigMap.put("sort_Order", sort_Order);
		nodeContentConfigMap.put("conditional_Relation", conditional_Relation);
		nodeContentConfigMap.put("restriction_Ids", restriction_Ids);
		nodeContentConfigMap.put("cont_Converter_Para", cont_Converter_Para);
		nodeContentConfigMap.put("relation_Condition", relation_Condition);
		nodeContentConfigMap.put("src_Map_Type", src_Map_Type);
		nodeContentConfigMap.put("method_Id", method_Id);
		nodeContentConfigMap.put("fix_Value", fix_Value);
		nodeContentConfigMap.put("par_Data_Set_Id", par_Data_Set_Id);
		nodeContentConfigMap.put("col_Name", col_Name);
		nodeContentConfigMap.put("data_Set_Id", data_Set_Id);
		nodeContentConfigMap.put("cont_Converter_Id", cont_Converter_Id);
		nodeContentConfigMap.put("auto_Add_Flag", auto_Add_Flag);
		nodeContentConfigMap.put("node_Id", node_Id);
		nodeContentConfigMap.put("delete_Type", delete_Type);
		nodeContentConfigMap.put("content_Type", content_Type);
		adapterDao.saveNodeContentConfig(nodeContentConfigMap);
	}
	
	/**
	 * 保存节点路径配置
	 * @param nodeContentConfigElement
	 */	
	public void saveNodePathConfigElement(Element nodePathConfigElement){
		String state = nodePathConfigElement.attributeValue("state");
		String path_Id = nodePathConfigElement.attributeValue("path_id");
		String confirm_Path = nodePathConfigElement.attributeValue("confirm_path");
		String suf_Sep_Chars = nodePathConfigElement.attributeValue("suf_sep_chars");
		String multi_Joint = nodePathConfigElement.attributeValue("multi_joint");
		String xml_From = nodePathConfigElement.attributeValue("xml_from");
		String node_Oper_Id = nodePathConfigElement.attributeValue("node_oper_id");
		String xml_Path = nodePathConfigElement.attributeValue("xml_path");
		String pre_Sep_Chars = nodePathConfigElement.attributeValue("pre_sep_chars");
		String joint_Type = nodePathConfigElement.attributeValue("joint_type");
		String par_Path_Level = nodePathConfigElement.attributeValue("par_path_level");
		String sort_Order = nodePathConfigElement.attributeValue("sort_order");
		
		Map nodePathConfigMap=new HashMap();
		nodePathConfigMap.put("state", state);
		nodePathConfigMap.put("path_Id", path_Id);
		nodePathConfigMap.put("confirm_Path",confirm_Path);
		nodePathConfigMap.put("suf_Sep_Chars", suf_Sep_Chars);
		nodePathConfigMap.put("multi_Joint", multi_Joint);
		nodePathConfigMap.put("xml_From", xml_From);
		nodePathConfigMap.put("node_Oper_Id", node_Oper_Id);
		nodePathConfigMap.put("xml_Path", xml_Path);
		nodePathConfigMap.put("pre_Sep_Chars", pre_Sep_Chars);
		nodePathConfigMap.put("joint_Type", joint_Type);
		nodePathConfigMap.put("par_Path_Level", par_Path_Level);
		nodePathConfigMap.put("sort_Order", sort_Order);
		adapterDao.saveNodePathConfig(nodePathConfigMap);
	}

	public IAdapterDao getAdapterDao() {
		return adapterDao;
	}

	public void setAdapterDao(IAdapterDao adapterDao) {
		this.adapterDao = adapterDao;
	}


	public List<Map> getDataSouceList(Map paramMap) {
		return adapterDao.getDataSouceList(paramMap);
	}	

	public void updateDataSet(Map param) {
		adapterDao.updateDataSet(param);
	}


	public void insertDataSet(Map param) {
		adapterDao.insertDataSet(param);
	}
	
	public void deleteDataSet(Map map) {
		adapterDao.deleteDataSet(map);
	}	
	
	public void saveDataSet(Map dataSet){
		String actionType = "ADD";
		if(dataSet.containsValue("actionType"))
		actionType = (String) dataSet.get("actionType");
		if("ADD".equals(actionType)){
			adapterDao.insertDataSet(dataSet);
		}else if("MODIFY".equals(actionType)){
			adapterDao.updateDataSet(dataSet);
		}else{
			log.info("saveDataSet nothing to do the key 'actionType's value= "+actionType);
		}
	}

	
	public List<Map> queryDataSetListByCond(Map param) {
		return adapterDao.queryDataSetListByCond(param);
	}
	
	public List<Map> queryNodeByContractId(Map param){
		return adapterDao.queryNodeByContractId(param);
	}
	
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException{
		Integer num = adapterDao.searchContractAndVersionListSum(map);
		return num;
	}
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractAndVersionList(Map map){
		return adapterDao.selectContractAndVersionList(map);
	}
	
	/**
	 * 获取主数据信息
	 * @param mainData
	 * @return
	 */
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData) ;
	}
	
	/**
	 * 获取主数据类型信息
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType) ;
	}

	public MainDataDao getMainDataSqlDAO() {
		return mainDataSqlDAO;
	}

	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}

	public MainDataTypeDao getMainDataTypeSqlDAO() {
		return mainDataTypeSqlDAO;
	}

	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}

	public List<Map> selectContractAdapterList(Map map){
		return adapterDao.selectContractAdapterList(map);
	}
	public Integer  selectContrateAdapterCnt (Map map)throws EAAPException{
		return adapterDao.selectContrateAdapterCnt(map);
	}
	public void delContractAdapter(Integer contractAdapterID){
		Map map = new HashMap();
		map.put("contractAdapterId", contractAdapterID);
		map.put("state", "D");
		adapterDao.delNodeDecMap(map);
		Map mapTemp = new HashMap() ;  
		mapTemp.put("contractAdapterId", contractAdapterID);
		List<Map> l = adapterDao.queryValAdapterRes(mapTemp);
		for(Map m:l){
			if("3".equals(m.get("NODE_VALUE_SOURCE_CD"))){
				map.put("consMapCD", m.get("VALUE_EXPRESS"));
				adapterDao.updateVarMapType(map);
				adapterDao.updateVariableMap(map);
				adapterDao.updateTransScript(map);
			}else if("4".equals(m.get("NODE_VALUE_SOURCE_CD"))){
				
			}
			map.put("nodeDescId", m.get("NODE_DESC_ID"));
			adapterDao.updateNodeValAdapterRes(map);
		}
		adapterDao.updateContractAdapter(map);
	}
	//------------------------------------------------------------------------------
	public Integer addContractAdapter(Map map) {
		// TODO Auto-generated method stub
		Integer id = adapterDao.queryContractAdapterID(map);
		map.put("contract_adapter_id", id);
		adapterDao.saveContractAdapter(map);
		return id;
	}
	public void updateContractAdapter(Map map) {
		adapterDao.updateContractAdapter(map);
	}
//---------------------------------------------------------
//------------------------------------------------------------
	public Integer addNodeDescMap(Map map) {
		Integer id = adapterDao.queryNodeDecMapID(map);
		map.put("node_desc_id", id);
		adapterDao.saveNodeDecMap(map);
		return id;
	}
	public void updateNodeDescMap(Map map) {
		adapterDao.updateNodeDecMap(map);
	}
	public void delNodeDescMap(Map map) {
		List<Map> l = new ArrayList<Map>();
		map.put("state", "D");
		if(""!=map.get("mapingId") && null!= map.get("mapingId")){
			Map mapTemp = new HashMap() ;  
			mapTemp.put("nodeValAdapterReqId", map.get("mapingId"));
			l = adapterDao.queryValAdapterResByMapingID(mapTemp);
			Map ml = l.get(0);
			if("3".equals(ml.get("NODE_VALUE_SOURCE_CD"))){
				map.put("consMapCD", ml.get("VALUE_EXPRESS"));
				adapterDao.updateVarMapType(map);
				Map mapTemp2 = new HashMap() ;  
				mapTemp2.put("consMapCD", map.get("consMapCD"));
				List<Map> list = adapterDao.queryVariableMap(mapTemp2);
				for(Map m:list){
					map.put("varMapingId", m.get("VAR_MAPING_ID"));
					adapterDao.updateTransScript(map);
					adapterDao.updateVariableMap(map);
				}
			}else if("4".equals(ml.get("NODE_VALUE_SOURCE_CD"))){
				
			}
			adapterDao.updateNodeValAdapterRes(map);
		}
		adapterDao.delNodeDecMap(map);
	}
	/**
	 * true 不存在
	 * false 存在
	 */
	public boolean isNodeMapDecExit(Map map) {
		Integer num = adapterDao.isNodeMapDecExit(map);
		return num==0?true:false;
	}
//-----------------------------------------------------------
	public Integer addNodeValAdapterRes(Map map) {
		Integer id = null;
		String val ="";
		id = adapterDao.queryNodeValAdapterResID(map);
		map.put("nodeId", id);
		if("1".equals(map.get("nodeValueSourceCd"))){
			//从源消息节点取值
			adapterDao.saveNodeValAdapterRes(map);
		}else if("2".equals(map.get("nodeValueSourceCd"))){
			//固定值
			adapterDao.saveNodeValAdapterRes(map);
		}else if("3".equals(map.get("nodeValueSourceCd"))){
			//map赋值
			adapterDao.saveNodeValAdapterRes(map);
		}else if("4".equals(map.get("nodeValueSourceCd"))){
			//javabean 赋值
			val = (String) map.get("valueExpress");
			map.put("valueExpress", "");
			map.put("script", val);
			adapterDao.saveNodeValAdapterRes(map);
		}else if("5".equals(map.get("nodeValueSourceCd"))){
			//拆分
		}else if("6".equals(map.get("nodeValueSourceCd"))){
			//合并
		}
		return id;
	}
	public void updateNodeValAdapterRes(Map map) {
		String nodeValAdapterReqId = (String) map.get("mapingID");
		if(null != nodeValAdapterReqId && !"".equals(nodeValAdapterReqId) && !"null".equals(nodeValAdapterReqId)){
			Map mapTemp = new HashMap() ;  
			mapTemp.put("nodeValAdapterReqId", nodeValAdapterReqId);		///
			List<Map> l = adapterDao.queryValAdapterResByMapingID(mapTemp);
			String sourceCD = (String) l.get(0).get("NODE_VALUE_SOURCE_CD");
			String varMapCD = (String) l.get(0).get("VALUE_EXPRESS");
			if("3".equals(sourceCD)){
				Map para = new HashMap();
				para.put("state", "D");
				para.put("consMapCD", varMapCD);
				para.put("contractAdapterId", map.get("contractAdapterId"));
				adapterDao.updateVarMapType(para);
				Map mapTemp2 = new HashMap() ;  
				mapTemp2.put("consMapCD", varMapCD);		
				List<Map> ll = adapterDao.queryVariableMap(mapTemp2);
				for(Map m:ll){
					para.put("varMapingId", m.get("VAR_MAPING_ID"));
					adapterDao.updateTransScript(para);
				}
				adapterDao.updateVariableMap(para);
			}
			
			String val;
			if("4".equals(map.get("nodeValueSourceCd"))){
				//Integer id = adapterDao.queryValAdapterResIDByParam(map);
				val = (String) map.get("valueExpress");
				map.put("valueExpress", "");
				map.put("script", val);
			}else if("3".equals(map.get("nodeValueSourceCd"))){
				//map赋值
				map.put("script", "");
			}else if("2".equals(map.get("nodeValueSourceCd"))){
				map.put("script", "");
			}
			adapterDao.updateNodeValAdapterRes(map);
		}
	}
	public List<Map> queryValAdapterResByMapingID(Map map){
		return adapterDao.queryValAdapterResByMapingID(map);
	}
//----------------------------------------
	public Integer saveVariableMap(Map map) {
		Integer id = adapterDao.queryVariableMapID(map);
		map.put("varMapingID", id);
		adapterDao.saveVariableMap(map);
		adapterDao.saveTransScript(map);
		return id;
	}
	public void updateVariableMap(Map map) {
		adapterDao.updateVariableMap(map);
	}
	public void delVariableMap(Map map) {
		adapterDao.delVariableMap(map);
	}
	public List queryVariableMap(Map map) {
		return adapterDao.queryVariableMap(map);
	}
//--------------------------------------
	public Integer saveVarMapType(Map map) {
		Integer id = adapterDao.queryVarMapTypeID(map);
		map.put("varMapTypeID", id);
		adapterDao.saveVarMapType(map);
		return id;
	}
	public Integer isVarMapTypeExit(Map map){
		Integer cnt =  adapterDao.isVarMapTypeExit(map);
		return cnt;
	}
	public Integer queryVarMapTypeID(Map map) {
		return adapterDao.queryVarMapTypeID(map);
	}
	public void updateVarMapType(Map map){
		Map para = new HashMap();
		para.put("varMapTypeId", map.get("varMapTypeId"));
		String consMapCD = (String) adapterDao.queryVarMapTypeByID(para).get(0).get("CONS_MAP_CD");
		adapterDao.updateVarMapType(map);
		Map mapTemp = new HashMap() ;  
		mapTemp.put("consMapCD", consMapCD);		
		List<Map> l = adapterDao.queryVariableMap(mapTemp);
		for(Map m : l){
			map.put("varMapingId", m.get("VAR_MAPING_ID"));
			adapterDao.updateVariableMap(map);
		}
		
		map.put("valueExpress", map.get("consMapCD"));
		adapterDao.updateNodeValAdapterRes(map);
	}
	public List<Map> queryVarMapTypeByID(Map map){
		return adapterDao.queryVarMapTypeByID(map);
	}
//--------------------------------------------
	public void saveTransScript(Map map) {
		adapterDao.saveTransScript(map);
	}
	public void updateTransScript(Map map) {
		adapterDao.updateTransScript(map);
	}
//-------------------------------------------
	@Override
	public Integer saveDynParamMap(Map map) {
		return null;
	}
	@Override
	public void delDynParamMap(Map map) {
	}

	public Integer  insertContractAdapter (Map map){
		return adapterDao.insertContractAdapter(map);
	}
		
	public Map queryContractAdapter(Map map){
		return adapterDao.queryContractAdapter(map);
	}
	
	public List<Map> queryContractAndVersion(Map map){
		return adapterDao.queryContractAndVersion(map);
	}
	
	public List<Map> selectNodeDescMaperList(Map map){
		return adapterDao.selectNodeDescMaperList(map);
	}

	/**
	 * 得到协议转化对象
	 * @param transformerRuleId
	 * @return
	 */
	@Override
	public TransformerRule getTransformerRuleById(Map map) {
		return adapterDao.getTransformerRuleById(map);
	}
	/**
	 * 删除节点取值要求
	 * @param map
	 */
	@Override
	public void delNodeValAdapterRea(Map map) {
		adapterDao.delNodeValAdapterRea(map);
	}

	/**
	 * 删除节点映射信息
	 */
	@Override
	public void delNodeMaper(Map map) {
		adapterDao.delNodeMaper(map);
	}

	/**
	 * 删除节点取值要求信息
	 */
	@Override
	public void delAdapterReq(Map map) {
		adapterDao.delAdapterReq(map);
	}
	/**
	 * 得到节点取值要求
	 * @param map
	 * @return
	 */
	@Override
	public NodeValReq getNodeValReqByMap(Map<String, String> map) {
		return adapterDao.getNodeValReqByMap(map);
	}
	/**
	 * 得到基类协议的协议格式ID
	 * @param map
	 * @return
	 */
	@Override
	public String getTcpCtrFIdByMap(Map map) {
		return adapterDao.getTcpCtrFIdByMap(map);
	}

	@Override
	public boolean isExitNodeValReq(Map map) {
		return adapterDao.isExitNodeValReq(map);
	}

	
	
	
	
	
	
	
	

	
}
