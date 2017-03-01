/*
 * @(#)IAdapterDao.java        2013-8-22
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

public interface IAdapterDao {
	
	/**
	 * 获取新的节点ID
	 * @return
	 */		
	public String getNewNodeId();
	
	/**
	 * 获取新的节点内容操作配置ID
	 * @return
	 */	
	public String getNewOperNodeId();
	
	/**
	 * 获取新的节点路径配置ID
	 * @return
	 */		
	public String getNewPathId();
	
	/**
	 * 查询数据集
	 * @return
	 */	
	public List queryDataSetList(Map map);
	
	public int countDataSetList(Map map);
	
	/**
	 * 查询扩展方式列表
	 * @return
	 */
	public List queryExtendList(Map map);
	
	public int countExtendList(Map map);
	
	/**
	 * 根据协议适配ID查询协议配置表
	 * @param adapterId
	 * @return
	 */
	public List queryProtocolAdapterObjectByAdapterId(Map map);	
	
	public List queryProtocalAdapterListObjectByProtocol(Map map);
	
	/**
	 * 根据协议适配ID查询协议配置表
	 * @param adapterId
	 * @return
	 */
	public List queryProtocolAdapterByAdapterId(Map map);
	
	/**
	 * 根据协议适配ID查询节点配置表
	 * @param adapterId
	 * @return
	 */
	public List queryAdapterNodeConfigByAdapterId(Map map);
	
	/**
	 * 根据节点ID查询节点内容操作配置
	 * @param nodeId
	 * @return
	 */
	public List queryNodeContentConfigByNodeId(Map map);
	
	/**
	 * 根据节点内容操作配置ID查询节点属性操作配置
	 * @param nodeOperId
	 * @return
	 */
	public List queryNodePropertyConfigByNodeOperId(Map map);
	
	/**
	 * 根据节点内容操作配置ID查询节点路径配置
	 * @param nodeOperId
	 * @return
	 */
	public List queryNodePathConfigByNodeOperId(Map map);
	
	/**
	 * 查询某个QUERYSQL信息
	 * @param dataSetId
	 * @return
	 */	
	public List querySomeQuerySQLInfo(Map map);
	
	/**
	 * 查询某个扩展方式的信息
	 * @param methodId
	 * @return
	 */
	public List querySomeExtendMethodInfo(Map map);
	
	/**
	 * 保存节点配置信息
	 * @param paramMap
	 */
	public void saveAdapterNodeConfig(Map paramMap);
	
	/**
	 * 节点内容操作配置
	 * @param paramMap
	 */
	public void saveNodeContentConfig(Map paramMap);
	
	/**
	 * 保存节点路径配置
	 * @param paramMap
	 */	
	public void saveNodePathConfig(Map paramMap);
	
	/**
	 * 根据删除 NODE_CONTENT_CONFIG的配置
	 * @param adapter_Id
	 */
	public void deleteNodePathConfigByAdapterId(Map map);
	
	/**
	 * 删除 NODE_CONTENT_CONFIG的配置
	 * @param adapter_Id
	 */
	public void deleteNodeContentConfigByAdapterId(Map map);
	
	/**
	 * 删除 APAPTER_NODE_CONFIG的配置
	 * @param adapter_Id
	 */
	public void deleteAdapterNodeConfigByAdapterId(Map map);
	public List<Map> getDataSouceList(Map param);
	public void updateDataSet(Map param);
	public void insertDataSet(Map param);

	public void deleteDataSet(Map map);

	public List<Map> queryDataSetListByCond(Map param);
	
	public List<Map> queryNodeByContractId(Map param);
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException;
	public List<Map> selectContractAndVersionList(Map map);
	
	public Integer  insertContractAdapter (Map map);
	//////////////////////////////////////////////////////////
	//协议适配管理列表
	public List<Map> selectContractAdapterList(Map map);
	public Integer  selectContrateAdapterCnt (Map map)throws EAAPException;
	//协议适配的dao方法
	public void saveContractAdapter (Map map);
	public void updateContractAdapter(Map map);
	public Integer queryContractAdapterID(Map map);
	//节点映射的dao方法
	public void saveNodeDecMap(Map map);
	public void updateNodeDecMap(Map map);
	public Integer isNodeMapDecExit(Map map);
	public Integer queryNodeDecMapID(Map map);
	public void delNodeDecMap(Map map);
	//取值要求的dao方法
	public void saveNodeValAdapterRes(Map map);
	public void updateNodeValAdapterRes(Map map);
	public Integer queryNodeValAdapterResID(Map map);
	public Integer queryValAdapterResIDByParam(Map map);
	public List<Map> queryValAdapterRes(Map map);
	public List<Map> queryValAdapterResByMapingID(Map map);
	//变量映射表的dao方法
	public void saveVariableMap(Map map);
	public void updateVariableMap(Map map);
	public void delVariableMap(Map map);
	public List queryVariableMap(Map map);
	public Integer queryVariableMapID(Map map);
	//变量映射类型的dao方法
	public void saveVarMapType(Map map);
	public Integer queryVarMapTypeID(Map map);
	public Integer isVarMapTypeExit(Map map);
	public void updateVarMapType(Map map);
	public List<Map> queryVarMapTypeByID(Map map);
	//协议转换对应的脚本变量的dao方法
	public void saveTransScript(Map map);
	public void updateTransScript(Map map);
	//动态参数映射表的dao方法DYN_PARAM_MAP
	public Integer queryDynParamMapID(Map map);
	public void updateDynParamMapID(Map map);
	public void saveDynParamMapID(Map map);
	public List queryDynParamMapByResID(Map map);
	public Map queryContractAdapter(Map map);
	public List<Map> queryContractAndVersion(Map map);
	public List<Map> selectNodeDescMaperList(Map map);
	/**
	 * 得到协议转化对象
	 * @param transformerRuleId
	 * @return
	 */
	public TransformerRule getTransformerRuleById(Map map);
	/**
	 * 删除节点取值要求
	 * @param map
	 */
	public void delNodeValAdapterRea(Map map);

	/**
	 * 删除节点映射信息
	 */
	public void delNodeMaper(Map map);

	/**
	 * 删除节点取值要求信息
	 * @param map
	 */
	public void delAdapterReq(Map map);
	/**
	 * 得到节点取值要求
	 * @param map
	 * @return
	 */
	public NodeValReq getNodeValReqByMap(Map<String, String> map);
	/**
	 * 得到基类协议的协议格式ID
	 * @param map
	 * @return
	 */
	public String getTcpCtrFIdByMap(Map map);

	public boolean isExitNodeValReq(Map map);
}
