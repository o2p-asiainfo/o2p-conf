package com.ailk.eaap.op2.conf.sqllog.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.sqllog.model.BakTableInfo;
import com.ailk.eaap.op2.conf.sqllog.dao.InitSqlLogDao;
import com.ailk.eaap.op2.conf.util.ActInterceptor;
import com.alibaba.druid.util.StringUtils;
import com.asiainfo.foundation.log.Logger;

/**
 * @ClassName: InitSqlLogServiceImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-24 上午10:08:47
 *
 */
public class InitSqlLogServiceImpl implements InitSqlLogService{ 
	
	private InitSqlLogDao initSqlLogDao;
	private static Map<String,List<BakTableInfo>> bakTableMap = new HashMap<String,List<BakTableInfo>>();
	private static Logger logger = Logger.getLog(InitSqlLogServiceImpl.class);

	public void setInitSqlLogDao(InitSqlLogDao initSqlLogDao) {
		this.initSqlLogDao = initSqlLogDao;
	}
	
	private static boolean isInit = true;
	
	public void initialize(){
		String isInitStr = CustomPropertyConfigurer.getProperty(ActInterceptor.SQLLOG_ISINTERCEPTOR);
		if(!StringUtils.isEmpty(isInitStr)){
			isInit = Boolean.valueOf(isInitStr);
		}
		if(isInit){
			this.initTableInfo(); 
		}
	}
	
	public List<BakTableInfo> getTableInfoByName(String tableName){
		List<BakTableInfo> tableInfoList = new ArrayList<BakTableInfo>();
		tableInfoList = bakTableMap.get(tableName);
		return tableInfoList;
	}

	public void initTableInfo(){
		List<BakTableInfo> tableInfoList = this.initSqlLogDao.qryTableInfoList();
		Map<String,List<BakTableInfo>> tableInfoMap = new HashMap<String,List<BakTableInfo>>();
		for(BakTableInfo bakTableInfo : tableInfoList){
			if(tableInfoMap.containsKey(bakTableInfo.getTableName())){
				List<BakTableInfo> tableList = tableInfoMap.get(bakTableInfo.getTableName());
				tableList.add(bakTableInfo);
			}else{
				List<BakTableInfo> tableList = new ArrayList<BakTableInfo>();
				tableList.add(bakTableInfo);
				tableInfoMap.put(bakTableInfo.getTableName(), tableList);
			}
		}
		
		for(String tableName : tableInfoMap.keySet()){
			bakTableMap.put(tableName, tableInfoMap.get(tableName));
		}
		
	}

}
