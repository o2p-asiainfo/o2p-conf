package com.ailk.eaap.op2.conf.sqllog.service;

/**
 * @ClassName: IntfSqlLogService
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-2 下午2:47:06
 *
 */
public interface IntfSqlLogService {
	
	public void sendIntfSqlLog(Object sendObj,String tableName,String operate);

}
