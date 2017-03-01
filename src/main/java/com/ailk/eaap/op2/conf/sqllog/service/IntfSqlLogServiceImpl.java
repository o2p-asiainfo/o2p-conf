package com.ailk.eaap.op2.conf.sqllog.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.o2p.conf.activemq.service.SqlLogMessageProducer;
import com.ailk.eaap.o2p.sqllog.model.OperateActInfo;
import com.ailk.eaap.o2p.sqllog.model.OperateLog;
import com.ailk.eaap.o2p.sqllog.model.OperateLogData;
import com.ailk.eaap.op2.conf.util.OperateActContext;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.serializer.SerializerFeature;

/**
 * @ClassName: IntfSqlLogServiceImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-2 下午2:50:21
 *
 */
public class IntfSqlLogServiceImpl implements IntfSqlLogService{
	
	private SqlLogMessageProducer sqlLogMessageProducer = null;

	public SqlLogMessageProducer getSqlLogMessageProducer() {
		return sqlLogMessageProducer;
	}

	public void setSqlLogMessageProducer(SqlLogMessageProducer sqlLogMessageProducer) {
		this.sqlLogMessageProducer = sqlLogMessageProducer;
	}
	
	
	public void sendIntfSqlLog(Object sendObj,String tableName,String operate){
		if(sendObj != null){
			OperateActInfo operateActInfo = OperateActContext.getActInfo();
			if(operateActInfo != null){
				OperateLog operateLog = new OperateLog();
				operateLog.setUserName(operateActInfo.getUserName());
				operateLog.setUserIp(operateActInfo.getUserIp());
				operateLog.setTableName(tableName);
				operateLog.setOptType(operate); 
				operateLog.setExecClass(operateActInfo.getExecClass()); 
				operateLog.setExecMethod(operateActInfo.getExceMothod());
				operateLog.setCreateDate(System.currentTimeMillis());
				
				List<OperateLogData> logDataList = new ArrayList<OperateLogData>();
				OperateLogData logDataBean = new OperateLogData();
				String dataJson = JSON.toJSONString(sendObj,SerializerFeature.WriteDateUseDateFormat);
				String dataKey = this.getDataKey(dataJson); 
				logDataBean.setDataLog(dataJson);
				logDataBean.setDataKey(dataKey);
				logDataBean.setCreateDate(System.currentTimeMillis());
				logDataList.add(logDataBean);
		
				operateLog.setLogDataList(logDataList);
				sqlLogMessageProducer.sendMessage(operateLog);
			}
		}
	}
	
	
	private String getDataKey(String dataJson){
		Map<String,Object> dataKeyMap = new HashMap<String,Object>(); 
		Map<String,Object> sendMap = (Map<String, Object>) JSON.parse(dataJson);
		String dataKey = null;
		if(sendMap.get("taskId") != null){
			dataKeyMap.put("taskid", String.valueOf(sendMap.get("taskId")));  
			dataKey = JSON.toJSONString(dataKeyMap); 
		}
		return dataKey;
	}

}
