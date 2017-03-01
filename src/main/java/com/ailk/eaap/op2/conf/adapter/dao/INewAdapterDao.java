/*
 * @(#)IAdapterDao.java        2013-8-22
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.dao;

import java.util.List;
import java.util.Map;

public interface INewAdapterDao {

	public int getCountContractListByMap(Map map);

	public List<Map> getContractListByMap(Map map);
	public String getConAdaEndId();

	public void addConAdaEnd(Map contractEndpoint);
	public void updateContractRecords(Map<String, String> param);

	public void delConAdaEndByMap(Map<String, String> param);

	public String querySrcById(Map<String, String> param);

	public int queryActionById(Map<String, String> param);

	public boolean isExitOper(Map<String, String> param);

	public List<Map> getEndPointSrcList(Map<String, String> param);

	public String getFormatId(Map<String, String> param);

	public List<Map> getNodeMapper(String contractAdapterId,
			String tarNodeDescId);

	public boolean isExitSrcTcpCtrFId(Map<String, String> param);

	public void updateContractAdapter(Map<String, String> param);

	public void updateConAdaEndpoint(Map<String, String> param);

	public boolean isExitInAdapter(Map<String, String> param);

	public List<Map> getNodeValAdaReq(Map<String, String> param);

	public boolean isExitNodeValReq(Map<String, String> param);
	
	public int getCountValableMapByMap(Map map);

	public List<Map> getValableMapByMap(Map map);

	public String getVarMapTypeName(Map<String, String> param);

	public void delAdapterEndpoint(Map<String, String> param);

	public Map getContractAdapterById(Map<String, String> param);

	public List<Map> getConAdaEndListById(Map<String, String> param);

	public String getContractNameById(Map<String, String> param);

	public List<Map> getNodeMapperListById(Map map);

	public List<Map> getContractFormat(Map<String, String> param);

	public void updateResult(Map<String, String> param);

	public String getActionValue(Map<String, String> param);

	public int countVarMapType(Map map);

	public List<Map> queryVarMapType(Map map);

	public void deleteVarMapType(Map<String, String> param);	
	
	public List<Map> getRToCLinesDataById(Map<String, String> param);
}
