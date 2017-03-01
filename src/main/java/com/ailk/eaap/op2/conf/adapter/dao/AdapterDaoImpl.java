/*
 * @(#)AdapterDaoImpl.java        2013-8-22
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.NodeValReq;
import com.ailk.eaap.op2.bo.TransformerRule;
import com.ailk.eaap.op2.common.EAAPException;
import com.linkage.rainbow.dao.SqlMapDAO;

/**
 * 类名称<br>
 * 这里是类的描述区域，概括出该的主要功能或者类的使用范围、注意事项等
 * <p>
 * @version 1.0
 * @author Administrator 2013-8-22
 * <hr>
 * 修改记录
 * <hr>
 * 1、修改人员:    修改时间:<br>       
 *    修改内容:
 * <hr>
 */

public class AdapterDaoImpl implements IAdapterDao{
	
	private SqlMapDAO sqlMapDao;
	
	/**
	 * 获取新的节点ID
	 * @return
	 */		
	public String getNewNodeId(){
		return (String)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.getNewNodeId",  null);
	}
	
	/**
	 * 获取新的节点内容操作配置ID
	 * @return
	 */	
	public String getNewOperNodeId(){
		return (String)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.getNewOperNodeId", null);
	}
	
	/**
	 * 获取新的节点路径配置ID
	 * @return
	 */		
	public String getNewPathId(){
		return (String)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.getNewPathId", null);
	}
	
	/**
	 * 查询数据集
	 * @return
	 */	
	public List queryDataSetList(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryDataSetList", map);
	}
	
	public int countDataSetList(Map map){
		Integer  value = (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.countDataSetList", map); 
		return value.intValue();
	}
	
	/**
	 * 查询扩展方式列表
	 * @return
	 */
	public List queryExtendList(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryExtendList", map);
	}
	
	public int countExtendList(Map map){
		Integer  value = (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.countExtendList", map); 
		return value.intValue();
	}	
	
	/**
	 * 根据协议适配ID查询协议配置表
	 * @param adapterId
	 * @return
	 */
	public List queryProtocolAdapterObjectByAdapterId(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryProtocolAdapterObjectByAdapterId", map);
	}
	
	public List queryProtocalAdapterListObjectByProtocol(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryProtocalAdapterListObjectByProtocol", map);
	}
	
	/**
	 * 根据协议适配ID查询协议配置表
	 * @param adapterId
	 * @return
	 */
	public List queryProtocolAdapterByAdapterId(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryProtocolAdapterByAdapterId", map);
	}	
	
	/**
	 * 根据协议适配ID查询节点配置表
	 * @param adapterId
	 * @return
	 */
	public List queryAdapterNodeConfigByAdapterId(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryAdapterNodeConfigByAdapterId", map);
	}
	
	/**
	 * 根据节点ID查询节点内容操作配置
	 * @param nodeId
	 * @return
	 */	
	public List queryNodeContentConfigByNodeId(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryNodeContentConfigByNodeId", map);
	}
	
	/**
	 * 根据节点内容操作配置ID查询节点属性操作配置
	 * @param nodeOperId
	 * @return
	 */	
	public List queryNodePropertyConfigByNodeOperId(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryNodePropertyConfigByNodeOperId", map);
	}
	
	/**
	 * 根据节点内容操作配置ID查询节点路径配置
	 * @param nodeOperId
	 * @return
	 */		
	public List queryNodePathConfigByNodeOperId(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryNodePathConfigByNodeOperId", map);
	}
	
	/**
	 * 查询某个QUERYSQL信息
	 * @param dataSetId
	 * @return
	 */	
	public List querySomeQuerySQLInfo(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.querySomeQuerySQLInfo", map);
	}
	
	/**
	 * 查询某个扩展方式的信息
	 * @param methodId
	 * @return
	 */
	public List querySomeExtendMethodInfo(Map map){	
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.querySomeExtendMethodInfo", map);
	}
	
	/**
	 * 保存节点配置信息
	 * @param paramMap
	 */
	public void saveAdapterNodeConfig(Map paramMap){
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveAdapterNodeConfig", paramMap);
	}
	
	/**
	 * 保存节点内容操作配置
	 * @param paramMap
	 */
	public void saveNodeContentConfig(Map paramMap){
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveNodeContentConfig", paramMap);
	}
	
	/**
	 * 保存节点路径配置
	 * @param paramMap
	 */	
	public void saveNodePathConfig(Map paramMap){
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveNodePathConfig", paramMap);
	}
	
	/**
	 * 根据删除 NODE_CONTENT_CONFIG的配置
	 * @param adapter_Id
	 */
	public void deleteNodePathConfigByAdapterId(Map map){
		this.sqlMapDao.delete("eaap-op2-conf-adapter.deleteNodePathConfigByAdapterId", map);
	}
	
	/**
	 * 删除 NODE_CONTENT_CONFIG的配置
	 * @param adapter_Id
	 */
	public void deleteNodeContentConfigByAdapterId(Map map){
		this.sqlMapDao.delete("eaap-op2-conf-adapter.deleteNodeContentConfigByAdapterId", map);
	}
	
	/**
	 * 删除 APAPTER_NODE_CONFIG的配置
	 * @param adapter_Id
	 */
	public void deleteAdapterNodeConfigByAdapterId(Map map){
		this.sqlMapDao.delete("eaap-op2-conf-adapter.deleteAdapterNodeConfigByAdapterId", map);
	}


	public List<Map> getDataSouceList(Map paramMap) {
		// TODO Auto-generated method stub
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.getDataSouceList",paramMap);
	}
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	
	public void updateDataSet(Map param) {
		sqlMapDao.update("eaap-op2-conf-adapter.updateDataSet", param);
	}


	public void insertDataSet(Map param) {
		sqlMapDao.update("eaap-op2-conf-adapter.insertDataSet", param);
	}
	
	public void deleteDataSet(Map map){
		sqlMapDao.delete("eaap-op2-conf-adapter.deleteDataSet", map);
	}
	
	public List<Map> queryDataSetListByCond(Map param){
		return sqlMapDao.queryForList("eaap-op2-conf-adapter.queryDataSetListByCond", param);
	}

	public List<Map> queryNodeByContractId(Map param){
		return sqlMapDao.queryForList("eaap-op2-conf-adapter.queryNodeByContractId", param);
	}
	
	/**
	 * 统计协议与对应协议版本总数
	 * @param Map
	 * @return
	 */
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException{
		Integer num = 0;
		num = (Integer) sqlMapDao.queryForObject("eaap-op2-conf-adapter.countContractAndVersionSum",map);
		return num;
	}
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractAndVersionList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-adapter.countContractAndVersion", map) ;
	}
//------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------
	public List<Map> selectContractAdapterList(Map map){
		return sqlMapDao.queryForList("eaap-op2-conf-adapter.countContractAdapter", map) ;
	}
	public Integer  selectContrateAdapterCnt (Map map)throws EAAPException{
		Integer num = 0;
		num = (Integer) sqlMapDao.queryForObject("eaap-op2-conf-adapter.countContractAdapterSum",map);
		return num;
	}
//-----------------------------------------------------------------------------------
	public void saveContractAdapter(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.insert("eaap-op2-conf-adapter.insertContractAdapter", map);
	}
	public Integer queryContractAdapterID(Map map) {
		// TODO Auto-generated method stub
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.queryContractAdapterId", map);
	}
	@Override
	public void updateContractAdapter(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateContractAdapter", map);
	}
//---------------------------------------------------------------------------
	public void saveNodeDecMap(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveAdapterConfig", map);
	}
	@Override
	public Integer isNodeMapDecExit(Map map) {
		// TODO Auto-generated method stub
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.isNodeMapDecExit", map);
	}
	@Override
	public void updateNodeDecMap(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateNodeDecMap", map);
	}
	public Integer queryNodeDecMapID(Map map){
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.queryNodeDecMapID", map);
	}
	public void delNodeDecMap(Map map){
		this.sqlMapDao.delete("eaap-op2-conf-adapter.delNodeDecMap", map);
	}
//----------------------------------------------------------
	@Override
	public void saveNodeValAdapterRes(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveNodeValAdapterRes", map);
	}
	@Override
	public void updateNodeValAdapterRes(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateNodeValAdapterRes", map);
	}
	@Override
	public Integer queryNodeValAdapterResID(Map map) {
		// TODO Auto-generated method stub
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.nodeValAdapterResID",map);
	}
	public Integer queryValAdapterResIDByParam(Map map){
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.queryValAdapterResIDByParam",map);
	}
	public List<Map> queryValAdapterRes(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryValAdapterRes", map);
	}
	public List<Map> queryValAdapterResByMapingID(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryValAdapterResByMapingID", map);
	}
//--------------------------------------------------------------------------
	@Override
	public void saveVariableMap(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveVariableMap", map);
	}
	@Override
	public void updateVariableMap(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateVariableMap", map);
	}
	@Override
	public void delVariableMap(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.update("eaap-op2-conf-adapter.delVariableMap", map);
	}
	@Override
	public List queryVariableMap(Map map) {
		// TODO Auto-generated method stub
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryVariableMap", map);
	}
	@Override
	public Integer queryVariableMapID(Map map) {
		// TODO Auto-generated method stub
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.varVariableMapID",map);
	}
//-----------------------------------------------------------------------
	@Override
	public void saveVarMapType(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveVarMapType", map);
	}
	@Override
	public Integer queryVarMapTypeID(Map map) {
		// TODO Auto-generated method stub
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.queryVarMapTypeID",map);
	}
	public void updateVarMapType(Map map){
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateVarMapType", map);
	}
	public Integer isVarMapTypeExit(Map map){
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.isVarMapTypeExit",map);
	}
	public List<Map> queryVarMapTypeByID(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryVarMapTypeByID", map);
	}
//--------------------------------------------------------------------------------
	@Override
	public void saveTransScript(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveTransScript", map);
	}
	@Override
	public void updateTransScript(Map map) {
		// TODO Auto-generated method stub
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateTransScript", map);
	}
	//---------------------------------------------------------------
	public Integer queryDynParamMapID(Map map){
		return (Integer)this.sqlMapDao.queryForObject("eaap-op2-conf-adapter.queryDynParamMapID",map);
	}
	public void updateDynParamMapID(Map map){
		this.sqlMapDao.update("eaap-op2-conf-adapter.updateDynParamMap", map);
	}
	public void saveDynParamMapID(Map map){
		this.sqlMapDao.insert("eaap-op2-conf-adapter.saveDynParamMap", map);
	}
	public List queryDynParamMapByResID(Map map){
		return this.sqlMapDao.queryForList("eaap-op2-conf-adapter.queryDynParamMapByResID", map);
	}
	public Integer  insertContractAdapter (Map map){
		Integer contractAdapterId = (Integer)sqlMapDao.insert("eaap-op2-conf-adapter.insertContractAdapterScript", map) ;
	    return contractAdapterId ;
	}
		
	public Map queryContractAdapter(Map map){
		return (Map) sqlMapDao.queryForObject("eaap-op2-conf-adapter.queryContractAdapter", map);
	}
	
	public List<Map> queryContractAndVersion(Map map){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-adapter.queryContractAndVersion", map) ;
		}
	
	public List<Map> selectNodeDescMaperList(Map map){
		return (List<Map>) sqlMapDao.queryForList("eaap-op2-conf-adapter.selectNodeDescMaperList",  map);
	}
	/**
	 * 得到协议转化对象
	 * @param transformerRuleId
	 * @return
	 */
	@Override
	public TransformerRule getTransformerRuleById(Map map) {
		return (TransformerRule)sqlMapDao.queryForObject("eaap-op2-conf-adapter.selectAllUseable",  map);
	}
	/**
	 * 删除节点取值要求
	 * @param map
	 */
	@Override
	public void delNodeValAdapterRea(Map map) {
		this.sqlMapDao.delete("eaap-op2-conf-adapter.delNodeValAdapterRea", map);
	}
	/**
	 * 删除节点映射信息
	 * @param map
	 */
	@Override
	public void delNodeMaper(Map map) {
		this.sqlMapDao.delete("eaap-op2-conf-adapter.delNodeMaper", map);
	}
	/**
	 * 删除节点取值要求信息
	 * @param map
	 */
	@Override
	public void delAdapterReq(Map map) {
		this.sqlMapDao.delete("eaap-op2-conf-adapter.delAdapterReq", map);
	}
	/**
	 * 得到节点取值要求
	 * @param map
	 * @return
	 */
	@Override
	public NodeValReq getNodeValReqByMap(Map<String, String> map) {
		return  (NodeValReq)sqlMapDao.queryForObject("eaap-op2-conf-adapter.selectNodeValReqByNodeId", map);
	}
	/**
	 * 得到基类协议的协议格式ID
	 * @param map
	 * @return
	 */
	@Override
	public String getTcpCtrFIdByMap(Map map) {
		List<Map> paraMap = (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-adapter.getTcpCtrFIdByMap", map);
		if(null != paraMap && paraMap.size()>0){ 
			return paraMap.get(0).get("TCP_CTR_F_ID").toString();
		}
		return null;
	}

	@Override
	public boolean isExitNodeValReq(Map map) {
		Integer num = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter.isExitNodeValReq", map);
		if(num > 0){
			return true;
		}
		return false;
	}
	
}
