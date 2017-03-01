/*
 * @(#)IContractAuditingServ.java        2013-5-22
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.auditing.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;

/**
 * 类名称<br>
 * 这里是类的描述区域，概括出该的主要功能或者类的使用范围、注意事项等
 * <p>
 * @version 1.0
 * @author LYL 2013-5-22
 * <hr>
 * 修改记录
 * <hr>
 * 1、修改人员:    修改时间:<br>       
 *    修改内容:
 * <hr>
 */

public interface IContractAuditingServ {
	public List<Map<String, Object>> queryContractList(Map<String,Object> queryConditionMap);
	public Integer queryContractListCount(Map<String,Object> queryConditionMap);
	public List<Map<String, Object>> queryContractAndFormat(Integer contractId);
	public Integer insertContract(Contract contract);
	public Integer insertContractVersion(ContractVersion contracVersion);
	public Integer insertContractFormat(ContractFormat contractFormat);
	public void deleteContractCascade(Integer contractid);
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
}
