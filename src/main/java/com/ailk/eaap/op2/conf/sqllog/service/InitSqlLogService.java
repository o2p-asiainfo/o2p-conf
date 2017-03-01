package com.ailk.eaap.op2.conf.sqllog.service;

import java.util.List;

import com.ailk.eaap.o2p.sqllog.model.BakTableInfo;

/**
 * @ClassName: InitSqlLogService
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-24 上午10:06:34
 *
 */
public interface InitSqlLogService {
	
	public void initTableInfo();
	
	public List<BakTableInfo> getTableInfoByName(String tableName);

}
