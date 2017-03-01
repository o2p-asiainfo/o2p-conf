package com.ailk.eaap.op2.conf.doc.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.ContractDoc;
import com.linkage.rainbow.dao.SqlMapDAO;

public class ContractDocDao implements IContractDocDao {
	
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public List<Map<String, String>> showContractDocs(Map map) {
		return (List<Map<String, String>>)sqlMapDao.queryForList("eaap-op2-conf-contractDoc.showContractDocs",map);
	}

	public int addContractDoc(ContractDoc contractDoc) {
		return (Integer) sqlMapDao.insert("eaap-op2-conf-contractDoc.addContractDoc", contractDoc);
	}

	public void delContracDoc(Map map) {
		sqlMapDao.delete("eaap-op2-conf-contractDoc.delContracDoc", map);;
	}

	public int countDocSum(Map map) {
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contractDoc.countDocSum", map);
	}

	public List<Map> countDoc(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-contractDoc.countDoc", map);
	}

	public void updateContractDoc(ContractDoc contractDoc) {
		// TODO Auto-generated method stub
	 sqlMapDao.update("eaap-op2-conf-contractDoc.updateContractDoc", contractDoc);
	}

	public int isExitDocName(Map map){
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contractDoc.isExitDocName", map);
	}

	@Override
	public int isResAlissExit(Map map) {
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contractDoc.isResAlissExit", map);
	}
}
