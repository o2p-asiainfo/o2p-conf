/*
 * @(#)ContractRegAuditingDaoImpl.java        2013-5-22
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.auditing.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.linkage.rainbow.dao.SqlMapDAO;

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

public class ContractRegAuditingDaoImpl implements IContractRegAuditingDao {
	private SqlMapDAO sqlMapDao;
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public Integer queryConractListCount(Map<String, Object> map) {
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-autitingContract.queryContractInfoListCount", map);
	}

	public List<Map<String, Object>> queryContractList(
			Map<String, Object> map) {
		return (List<Map<String, Object>>)sqlMapDao.queryForList("eaap-op2-conf-autitingContract.queryContractInfoList", map);
	}

	public List<Map<String, Object>> queryContractAndFormat(
			Integer contractId) {
		return (List<Map<String, Object>>)sqlMapDao.queryForList("eaap-op2-conf-autitingContract.queryContractVersionAndFormat", contractId);
	}

	public Integer insertContract(Contract contract) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingContract.insertContract", contract);
	}

	public Integer insertContractVersion(ContractVersion contracVersion) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingContract.insertContractVersion", contracVersion);
	}

	public Integer insertContractFormat(ContractFormat contractFormat) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingContract.insertContractFormat", contractFormat);
	}

	public void deleteContractCascade(Integer contractId) {
		sqlMapDao.delete("eaap-op2-conf-autitingContract.insertContractFormat", contractId);
	}

}
