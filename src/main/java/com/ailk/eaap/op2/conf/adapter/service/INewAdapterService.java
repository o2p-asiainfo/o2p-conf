/*
 * @(#)IAdapterService.java        2013-8-20
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.adapter.service;

import java.util.List;
import java.util.Map;


public interface INewAdapterService {

	public int getCountContractListByMap(Map map);

	public List<Map> getContractListByMap(Map map);

	public String getConAdaEndId();

	public void addConAdaEnd(Map contractEndpoint);

	public void updateContractRecords(Map<String, String> param);

	public void delConAdaEndByMap(Map<String, String> param);

	public String isExitOperator(String operator, String pageContractAdapterId);

	public String isExitLine(Map<String, String> param);

	public String getSelectedLeftFormat(String pageContractAdapterId);

	public String changeToAction(Map<String, String> param);

	public List<Map> getNodeValAdaReq(Map<String, String> param);

	public String addNodeValAdapterRes(Map<String, String> param);

	public int getCountValableMapByMap(Map map);

	public List<Map> getValableMapByMap(Map map);

	public String getVarMapTypeName(Map<String, String> param);

	public void delAdapterEndpoint(Map<String, String> param);

	public Map getContractAdapterById(Map<String, String> param);

	public List<Map> getConAdaEndListById(Map<String, String> param);

	public String getContractNameById(Map param);

	public List<Map> getNodeMapperListById(Map map);

	public String getFormatIdById(Map<String, String> param);

	public List<Map> getContractFormat(Map<String, String> param);

	public void updateResult(Map<String, String> param);

	public String getActionValue(Map<String, String> param);

	public int countVarMapType(Map map);

	public List<Map> queryVarMapType(Map map);

	public void deleteVarMapType(Map<String, String> param);	
	
	String assembleValueExpression(String complexCondition);

	public String unAssembleValueExpression(String valueOf);
	
	public List<Map> getRToCLinesDataById(Map<String, String> param);

	public String getFunctionList();

	public String assembleReflectValueExpression(String pageRelectExpress);

	public String unAssembleReflectValueExpression(String pageRelectExpress);
}
