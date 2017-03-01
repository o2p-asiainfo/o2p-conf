package com.ailk.eaap.op2.conf.contract.dao;

import com.ailk.eaap.op2.bo.ContractFormat;

import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.linkage.rainbow.dao.SqlMapDAO;

public class ContractManagerDao implements IContractManagerDao {
	
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public int addContractVersion(ContractVersion contracVersion) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-manageContract.insertContractVersion", contracVersion);
	}

	public int addDocContract(DocContract docContract) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-manageContract.insertDocContract", docContract);
	}

	public int addContractFormat(ContractFormat contractFormat) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-manageContract.insertContractFormat", contractFormat);
	}

	public int addNodeDesc(NodeDesc nodeDesc) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-manageContract.insertNodeDesc", nodeDesc);
	}

}
