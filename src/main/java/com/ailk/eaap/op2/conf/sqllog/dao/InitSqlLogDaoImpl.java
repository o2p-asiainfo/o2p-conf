package com.ailk.eaap.op2.conf.sqllog.dao;

import java.util.List;

import com.ailk.eaap.o2p.sqllog.model.BakTableInfo;
import com.linkage.rainbow.dao.SqlMapDAO;

/**
 * @ClassName: InitSqlLogDaoImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-24 上午9:37:33
 *
 */
public class InitSqlLogDaoImpl implements InitSqlLogDao{
	
	private SqlMapDAO sqlMapDao;
	
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	@SuppressWarnings("unchecked")
	public List<BakTableInfo> qryTableInfoList(){
		return sqlMapDao.queryForList("operate_log.queryTableInfo",null);
	}

}
