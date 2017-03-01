package com.ailk.eaap.op2.conf.message.dao;

import com.linkage.rainbow.dao.SqlMapDAO;

public class MessageDaoImpl implements MessageDao {

	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}
