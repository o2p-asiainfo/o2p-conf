package com.ailk.eaap.op2.conf.pard.dao;

import java.util.Map;
import java.util.List;

import com.linkage.rainbow.dao.SqlMapDAO;

@SuppressWarnings("unchecked")
public class ProdSellAuditDaoImpl implements ProdSellAuditDao{

	private SqlMapDAO sqlMapDao;
	
	public List<Map> queryApplyInfo(Map map) {
		List<Map> returnList = sqlMapDao.queryForList("eaap-op2-conf-auditing-pardSell.queryApplyInfo", map);
		return returnList;
	}
	
	public void updateAuditState(Map map) {
		sqlMapDao.update("eaap-op2-conf-auditing-pardSell.updateAuditState", map);
	}

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}
