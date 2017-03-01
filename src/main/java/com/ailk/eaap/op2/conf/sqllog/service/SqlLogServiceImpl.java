package com.ailk.eaap.op2.conf.sqllog.service;

import java.util.List;

import com.ailk.eaap.op2.conf.sqllog.dao.SqlLogDao;

/**
 * @ClassName: SqlLogServiceImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-19 下午2:19:35
 *
 */
public class SqlLogServiceImpl implements SqlLogService{

	private SqlLogDao sqlLogDao;

	public void setSqlLogDao(SqlLogDao sqlLogDao) {
		this.sqlLogDao = sqlLogDao;
	}

	public void saveBakOperateLog(){
		this.sqlLogDao.deleteBakOperateLogData();
		this.sqlLogDao.deleteBakOperateLog();
		List<String> tableNameList = this.sqlLogDao.getBakTableName();
		this.sqlLogDao.saveBakTableToLog(tableNameList);
	}
	
}
