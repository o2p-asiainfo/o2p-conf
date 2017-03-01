package com.ailk.eaap.op2.conf.sqllog.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowCallbackHandler;

import com.ailk.eaap.o2p.sqllog.model.BakTableInfo;
import com.ailk.eaap.o2p.sqllog.model.OperateLog;
import com.ailk.eaap.o2p.sqllog.model.OperateLogData;
import com.ailk.eaap.op2.conf.sqllog.service.InitSqlLogService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;

/**
 * @ClassName: SqlLogDaoImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-19 下午2:21:18
 *
 */
public class SqlLogDaoImpl implements SqlLogDao{
	
	private JdbcTemplate jdbcTemplate;
	private InitSqlLogService initSqlLogService;
	private Logger log = Logger.getLog(this.getClass());

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	} 
	
	public InitSqlLogService getInitSqlLogService() {
		return initSqlLogService;
	}

	public void setInitSqlLogService(InitSqlLogService initSqlLogService) {
		this.initSqlLogService = initSqlLogService;
	}



	public List<String> getBakTableName(){
		String sql = "SELECT table_name FROM BAK_TABLE_NAME";
		final List<String> tableNameList = new ArrayList<String>();
		this.jdbcTemplate.query(sql,new RowCallbackHandler(){
			public void processRow(ResultSet rs) throws SQLException{
				String tableName = rs.getString("table_name");
				tableNameList.add(tableName.toLowerCase());
			}
		});
		return tableNameList;
	}
	
	
	public void saveBakTableToLog(List<String> tableNameList){
		long logIndex = 1L;
		long logDataIndex = 1L;
		for(String tableName : tableNameList){

			List<Map<String, Object>> resultList = this.getTableResult(tableName);
			if(resultList != null){
				OperateLog operateLog = new OperateLog();
				operateLog.setLogId(logIndex++);
				operateLog.setUserName("admin");
				operateLog.setTableName(tableName);
				operateLog.setOptType("A"); 
				operateLog.setCreateDate(System.currentTimeMillis());
				this.saveBakOperateLog(operateLog);
				
				List<BakTableInfo> tableInfoList = this.getInitSqlLogService().getTableInfoByName(tableName.toString());
				
				for(Map<String,Object> logData : resultList){
					OperateLogData operateLogData = new OperateLogData();
					operateLogData.setId(logDataIndex++); 
					operateLogData.setLogId(operateLog.getLogId());
					String dataJson = JSON.toJSONString(logData,SerializerFeature.WriteDateUseDateFormat);
					String keyData = this.getDataKey(logData, tableInfoList);
					operateLogData.setDataLog(dataJson);
					operateLogData.setDataKey(keyData); 
					operateLogData.setCreateDate(System.currentTimeMillis());
					this.saveBakOperateLogData(operateLogData);  
				}
			}
		}
	}
	
	private String getDataKey(Map<String, Object> result,List<BakTableInfo> tableInfoList){
		String dataKey = "";
		if(tableInfoList != null){
			Map<String,Object> dataKeyMap = new HashMap<String,Object>(); 
			for(BakTableInfo bakTableInfo : tableInfoList){
				if(result.containsKey(bakTableInfo.getColumnName())){
					dataKeyMap.put(bakTableInfo.getColumnName(), result.get(bakTableInfo.getColumnName()).toString());
				}
			}
			dataKey = JSON.toJSONString(dataKeyMap);
		}
		return dataKey;
	}
	
	
	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> getTableResult(String tableName){
		List<Map<String, Object>> resultList = null;
		try{
			String sql = "select * from " + tableName;
			resultList = this.jdbcTemplate.queryForList(sql);
		}catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"SqlLogDaoImpl getTableResult exception:" + e.getCause(),null));
		}
		return resultList;
	} 
	
	public void saveBakOperateLog(final OperateLog operateLog){
		String sql = "INSERT INTO OPERATE_LOG (LOG_ID,USER_NAME,TABLE_NAME,OPT_TYPE,CREATE_DATE) VALUES(?,?,?,?,?)";
		this.jdbcTemplate.update(sql,new PreparedStatementSetter() {   
            public void setValues(PreparedStatement ps) throws SQLException {   
                ps.setLong(1, operateLog.getLogId());    
                ps.setString(2, operateLog.getUserName());
                ps.setString(3, operateLog.getTableName());             
                ps.setString(4, operateLog.getOptType());
                ps.setLong(5, operateLog.getCreateDate()); 
            }   
        });
	}
	
	public void saveBakOperateLogData(final OperateLogData operateLogData){
		String sql = "INSERT INTO OPERATE_LOG_DATA (ID,LOG_ID,DATA_KEY,DATA_LOG,CREATE_DATE) VALUES(?,?,?,?,?)";
		this.jdbcTemplate.update(sql,new PreparedStatementSetter() {   
            public void setValues(PreparedStatement ps) throws SQLException {   
                ps.setLong(1, operateLogData.getId());
                ps.setLong(2, operateLogData.getLogId()); 
                ps.setString(3, operateLogData.getDataKey());
                ps.setString(4, operateLogData.getDataLog());  
                ps.setLong(5, operateLogData.getCreateDate()); 
            }   
        });
	}
	
	
	public void deleteBakOperateLog(){
		this.jdbcTemplate.execute("DELETE FROM OPERATE_LOG WHERE LOG_ID <= 1000");
	}
	
	public void deleteBakOperateLogData(){
		this.jdbcTemplate.execute("DELETE FROM OPERATE_LOG_DATA WHERE ID <= 100000");
	}
	
	
//	public long queryOperateLogId(String dbType){
//	if(dbType.equals(SqlParase.MYSQL)){
//		return this.jdbcTemplate.queryForLong("SELECT nextval('SEQ_OPERATE_LOG_BAK')");
//	}else{
//		return this.jdbcTemplate.queryForLong("SELECT SEQ_OPERATE_LOG_BAK.NEXTVAL FROM DUAL");
//	}
//}
//
//public long queryOperateDataLogId(String dbType){
//	if(dbType.equals(SqlParase.MYSQL)){
//		return this.jdbcTemplate.queryForLong("SELECT nextval('SEQ_OPERATE_LOG_DATA_BAK')");
//	}else{
//		return this.jdbcTemplate.queryForLong("SELECT SEQ_OPERATE_LOG_DATA_BAK.NEXTVAL FROM DUAL");
//	}
//}
	
}
