package com.ailk.eaap.op2.conf.operatorlog.dao;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.conf.operatorlog.action.FuzzyModel;
import com.linkage.rainbow.dao.SqlMapDAO;

public class OperatorLogDaoImpl implements IOperatorLogDao {

	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	@Override
	public int countOptLogList(Map map) {
		return Integer.valueOf(String.valueOf(sqlMapDao.queryForObject("eaap-op2-conf-operatorlog-manage-sqlmap.countOptLogList", map)));
	}

	@Override
	public List<Map> queryOptLogList(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-operatorlog-manage-sqlmap.queryOptLogList", map);
	}

	@Override
	public List<Map> getOptLogById(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-operatorlog-manage-sqlmap.getOptLogById", map);
	}

	@Override
	public List<Map> getDataLogByMap(Map<String, String> paramMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-operatorlog-manage-sqlmap.getDataLogByMap", paramMap);
	}

	@Override
	public List<Map> getAllTableColByName(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-operatorlog-manage-sqlmap.getAllTableColByName", map);
	}

	@Override
	public int countFuzzyList(Map map) {
		return Integer.valueOf(String.valueOf(sqlMapDao.queryForObject("eaap-op2-conf-operatorlog-manage-sqlmap.countFuzzyList", map)));
	}

	@Override
	public List<Map> queryFuzzyList(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-operatorlog-manage-sqlmap.queryFuzzyList", map);
	}

	@Override
	public String queryNextPriId() {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-operatorlog-manage-sqlmap.queryNextPriId", null);
	}

	@Override
	public void addHideRrocess(FuzzyModel fuzzyModel) {
		sqlMapDao.insert("eaap-op2-conf-operatorlog-manage-sqlmap.addHideRrocess", fuzzyModel);
	}

	@Override
	public void delHideProcess(Map map) {
		sqlMapDao.delete("eaap-op2-conf-operatorlog-manage-sqlmap.delHideProcess", map);
	}

	@Override
	public void updateSubmitProcess(FuzzyModel fuzzyModel) {
		sqlMapDao.update("eaap-op2-conf-operatorlog-manage-sqlmap.updateSubmitProcess", fuzzyModel);
	}
}
