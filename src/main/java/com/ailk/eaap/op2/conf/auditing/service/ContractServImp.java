/*
 * @(#)ContractServImp.java        2013-5-24
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
import com.ailk.eaap.op2.conf.auditing.dao.IContractRegAuditingDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;

/**
 * 类名称<br>
 * 这里是类的描述区域，概括出该的主要功能或者类的使用范围、注意事项等
 * <p>
 * @version 1.0
 * @author LYL 2013-5-24
 * <hr>
 * 修改记录
 * <hr>
 * 1、修改人员:    修改时间:<br>       
 *    修改内容:
 * <hr>
 */

public class ContractServImp implements IContractAuditingServ {
	public IContractRegAuditingDao getContractRegAuditingDao() {
		return contractRegAuditingDao;
	}

	public void setContractRegAuditingDao(
			IContractRegAuditingDao contractRegAuditingDao) {
		this.contractRegAuditingDao = contractRegAuditingDao;
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


	private IContractRegAuditingDao contractRegAuditingDao;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	

	public List<Map<String, Object>> queryContractList(
			Map<String, Object> queryConditionMap) {
		return contractRegAuditingDao.queryContractList(queryConditionMap);
	}


	public Integer queryContractListCount(
			Map<String, Object> queryConditionMap) {
		return contractRegAuditingDao.queryConractListCount(queryConditionMap);
	}

	public List<Map<String, Object>> queryContractAndFormat(
			Integer contractId) {
		return contractRegAuditingDao.queryContractAndFormat(contractId);
	}

	public Integer insertContract(Contract contract) {
		return contractRegAuditingDao.insertContract(contract);
	}

	public Integer insertContractVersion(ContractVersion contracVersion) {
		return contractRegAuditingDao.insertContractVersion(contracVersion);
	}

	public Integer insertContractFormat(ContractFormat contractFormat) {
		return contractRegAuditingDao.insertContractFormat(contractFormat);
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

	public void deleteContractCascade(Integer contractId) {
		contractRegAuditingDao.deleteContractCascade(contractId);
	}

}
