package com.ailk.eaap.op2.conf.sqllog.dao;

import java.util.List;

import com.ailk.eaap.o2p.sqllog.model.BakTableInfo;

/**
 * @ClassName: InitSqlLogDao
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-23 下午5:28:31
 *
 */
public interface InitSqlLogDao {
	
	public List<BakTableInfo> qryTableInfoList();

}
