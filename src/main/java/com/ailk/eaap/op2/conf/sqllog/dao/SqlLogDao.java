package com.ailk.eaap.op2.conf.sqllog.dao;

import java.util.List;

/**
 * @ClassName: SqlLogDao
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-19 下午2:20:42
 *
 */
public interface SqlLogDao {
	
	public List<String> getBakTableName();
	
	public void saveBakTableToLog(List<String> tableNameList);
	
	public void deleteBakOperateLog();
	
	public void deleteBakOperateLogData();

}
