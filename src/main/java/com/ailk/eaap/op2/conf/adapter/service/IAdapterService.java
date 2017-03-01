/*
 * @(#)IAdapterService.java        2013-8-20
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;

import com.ailk.eaap.op2.bo.NodeValReq;
import com.ailk.eaap.op2.bo.TransformerRule;
import com.ailk.eaap.op2.bo.Contract2AttrSpec;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.common.EAAPException;

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

public interface IAdapterService {	
	
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
		
	public List getProtocalAdapterList(Map map);
	
	public List getProtocalAdapterListByProtocol(Map map);
	
	public void generateTreeStructure(Document treeDocument,String adapterId) throws DocumentException;
	
	public void getAdapterConfigInfo(Document configDocument,String adapterId) throws DocumentException;
	
	public void querySomeQuerySQLInfo(Document querySQLDocument,String dataSetId) throws DocumentException;
	
	public void querySomeExtendMethodInfo(Document extendMethodDocument,String methodId) throws DocumentException;
	public List<Map> getDataSouceList(Map paramMap);
	public void updateDataSet(Map param);
	public void insertDataSet(Map param);
	public void saveDataSet(Map dataSet);
	/**
	 * 保存协议适配配置
	 * @param paramMap
	 */
	public void saveProcotolAdapter(Map paramMap);

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
	
	/**
 	 * 获取主数据信息
 	 * @param mainData
 	 * @return
 	 */
 	public List<MainData> selectMainData(MainData mainData) ;
	
	/**
	 * 获取主数据类型信息
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType) ;
   
	public Integer  insertContractAdapter (Map map);
	
   //////////////////////////////////////////////////////////
	//协议适配管理列表
	public List<Map> selectContractAdapterList(Map map);
	public Integer  selectContrateAdapterCnt (Map map)throws EAAPException;
	public void delContractAdapter(Integer contractAdapterID);
	//协议适配
	public Integer addContractAdapter(Map map);
	public void updateContractAdapter(Map map);
	//节点映射
	public void updateNodeDescMap(Map map);
	public Integer addNodeDescMap(Map map);
	public boolean isNodeMapDecExit(Map map);
	public void delNodeDescMap(Map map);
	//取值要求
	public Integer addNodeValAdapterRes(Map map);
	public void updateNodeValAdapterRes(Map map);
	public List<Map> queryValAdapterResByMapingID(Map map);
	//变量映射表
	public Integer saveVariableMap(Map map);
	public void updateVariableMap(Map map);
	public void delVariableMap(Map map);
	public List queryVariableMap(Map map);
	//变量映射类型
	public Integer saveVarMapType(Map map);
	public Integer queryVarMapTypeID(Map map);
	public Integer isVarMapTypeExit(Map map);
	public void updateVarMapType(Map map);
	public List<Map> queryVarMapTypeByID(Map map);
	//协议转换对应的脚本变量
	public void saveTransScript(Map map);
	public void updateTransScript(Map map);
	//动态参数映射表DYN_PARAM_MAP
	public Integer saveDynParamMap(Map map);
	public void delDynParamMap(Map map);
	
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
	 * @param map
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
