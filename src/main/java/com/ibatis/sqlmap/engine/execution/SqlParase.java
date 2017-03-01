package com.ibatis.sqlmap.engine.execution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.conf.activemq.service.SqlLogMessageProducer;
import com.ailk.eaap.o2p.sqllog.model.BakTableInfo;
import com.ailk.eaap.o2p.sqllog.model.OperateActInfo;
import com.ailk.eaap.o2p.sqllog.model.OperateLog;
import com.ailk.eaap.o2p.sqllog.model.OperateLogData;
import com.ailk.eaap.o2p.sqllog.model.SqlLogBean;
import com.ailk.eaap.op2.common.CommonUtil;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.sqllog.service.InitSqlLogService;
import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.ast.SQLExpr;
import com.alibaba.druid.sql.ast.SQLName;
import com.alibaba.druid.sql.ast.SQLStatement;
import com.alibaba.druid.sql.ast.statement.SQLDeleteStatement;
import com.alibaba.druid.sql.ast.statement.SQLInsertStatement;
import com.alibaba.druid.sql.ast.statement.SQLInsertStatement.ValuesClause;
import com.alibaba.druid.sql.ast.statement.SQLUpdateSetItem;
import com.alibaba.druid.sql.ast.statement.SQLUpdateStatement;
import com.alibaba.druid.sql.parser.SQLParserUtils;
import com.alibaba.druid.sql.parser.SQLStatementParser;
import com.alibaba.druid.sql.visitor.SQLASTOutputVisitor;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;

/**
 * @ClassName: SqlParase 
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-9 上午10:33:38
 *
 */
public class SqlParase {
	
	public static final String DB_TYPE_PRO_NAME = "databaseType";
	public static final String MYSQL = "mysql";
	public static final String ORACLE = "oracle";
    private static final String PRE_ATTR = "?";
    private SqlQueryDaoImpl sqlQueryDao = null;
    private SqlLogMessageProducer sqlLogMessageProducer = null;
    private InitSqlLogService initSqlLogService = null;
    private Logger log = Logger.getLog(this.getClass());
    public static final String LOG_TABLE_NAME = "operate_log";
    public static final String LOG_DATA_TABLE_NAME = "operate_log_data";
    
    /**
     * 查询操作
     * @param querySql
     * @param parameters
     * @param operateActInfo
     * @return
     */
    public void querySqlProcess(String querySql,Object[] parameters,OperateActInfo operateActInfo){
    	try{
	    	OperateLog operateLog = new OperateLog();
			operateLog.setUserName(operateActInfo.getUserName());
			operateLog.setUserIp(operateActInfo.getUserIp());
			operateLog.setOptType(EAAPConstants.SQL_QUERY); 
			operateLog.setExecClass(operateActInfo.getExecClass()); 
			operateLog.setExecMethod(operateActInfo.getExceMothod());
			operateLog.setTenantId(operateActInfo.getTenantId());
			operateLog.setSqlLog(this.getSqlLog(querySql, parameters)); 
			operateLog.setCreateDate(System.currentTimeMillis());
			this.getSqlMQSenderService().sendMessage(operateLog);
    	}catch (Exception e) {
    		log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"SqlParase querySqlProcess exception:" + CommonUtil.getErrMsg(e),null));
		}
    }
    
    public String getDBType(){
    	return SqlLogUtil.getDbType();
    }
    
    public SQLStatement getSQLStatement(String updateSql,String dbType){
    	SQLStatementParser parser = SQLParserUtils.createSQLStatementParser(updateSql, dbType);
		List<SQLStatement> stmtList = parser.parseStatementList();
		SQLStatement sqlStatement = null;
		if(stmtList.size() > 0){
			sqlStatement = stmtList.get(0);
		}
    	return sqlStatement;
    }
    
	public void updateSqlProcess(String updateSql, Object[] parameters,SQLStatement stmt, String dbType,OperateActInfo operateActInfo){
		List<SQLStatement> stmtList = new ArrayList<SQLStatement>();
		stmtList.add(stmt);
		try{
			if (stmt instanceof SQLInsertStatement) {
				this.insertSqlParse(updateSql, stmt, stmtList, parameters,
							dbType, operateActInfo);
			} else if (stmt instanceof SQLUpdateStatement) {
				this.updateSqlParse(updateSql, stmt, stmtList, parameters,
							dbType, operateActInfo); 
			} else if (stmt instanceof SQLDeleteStatement) {
				this.deleteSqlParse(updateSql, stmt, stmtList, parameters,
							dbType, operateActInfo);
			}
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"SqlParase updateSqlProcess exception:" + CommonUtil.getErrMsg(e),null));
		}

	}
	
	private String getSqlLog(String updateSql,Object[] parameters){
		SqlLogBean sqlLogBean = new SqlLogBean();
		sqlLogBean.setSql(updateSql);
		sqlLogBean.setParameters(parameters);
		String json = JSON.toJSONString(sqlLogBean,SerializerFeature.WriteDateUseDateFormat); 
		return json;
	}
	
	/**
	 * 删除操作
	 * @param updateSql
	 * @param stmt
	 * @param stmtList
	 * @param parameters
	 * @param dbType
	 * @param operateActInfo
	 * @throws Exception
	 */
	private void deleteSqlParse(String updateSql,SQLStatement stmt,List<SQLStatement> stmtList,Object[] parameters,String dbType,OperateActInfo operateActInfo) throws Exception{
		SQLDeleteStatement dStmt = (SQLDeleteStatement)stmt;
		SQLName sqlName = dStmt.getTableName();
		StringBuffer tableNameBuffer = new StringBuffer();
		SQLASTOutputVisitor visitor = SQLUtils.createFormatOutputVisitor(tableNameBuffer, stmtList, dbType);
		sqlName.accept(visitor);
		
		SQLExpr whereExpr = dStmt.getWhere();
		StringBuffer tableWhere = new StringBuffer();
		SQLASTOutputVisitor whereVisitor = SQLUtils.createFormatOutputVisitor(tableWhere, stmtList, dbType);
		whereExpr.accept(whereVisitor);
		
		String tableName = tableNameBuffer.toString().toLowerCase();
		OperateLog operateLog = new OperateLog();
		operateLog.setUserName(operateActInfo.getUserName());
		operateLog.setUserIp(operateActInfo.getUserIp());
		operateLog.setTableName(tableName);
		operateLog.setOptType(EAAPConstants.SQL_DELETE); 
		operateLog.setExecClass(operateActInfo.getExecClass()); 
		operateLog.setExecMethod(operateActInfo.getExceMothod());
		operateLog.setTenantId(operateActInfo.getTenantId());
		operateLog.setSqlLog(this.getSqlLog(updateSql, parameters)); 
		operateLog.setCreateDate(System.currentTimeMillis());
		
		String querySql = "select * from " + tableName + " where " + tableWhere;
		List<Map<String, Object>> resultList = this.getSqlQueryDao().queryTableValue(querySql, parameters);
		
		List<BakTableInfo> tableInfoList = this.getInitSqlLogService().getTableInfoByName(tableName);
		
		List<OperateLogData> logDataList = new ArrayList<OperateLogData>();
		for(Map<String, Object> result : resultList){
			String dataJson = JSON.toJSONString(result);
			String dataKey = this.getDataKey(result, tableInfoList);
			OperateLogData logDataBean = new OperateLogData();
			logDataBean.setDataLog(dataJson);
			logDataBean.setDataKey(dataKey);
			logDataBean.setCreateDate(System.currentTimeMillis());
			logDataList.add(logDataBean); 
		}
		operateLog.setLogDataList(logDataList);
		this.getSqlMQSenderService().sendMessage(operateLog);
	}
	
	/**
	 * 更新操作
	 * @param stmt
	 * @param stmtList
	 * @param parameters
	 * @param dbType
	 * @throws Exception
	 */
	private void updateSqlParse(String updateSql,SQLStatement stmt,List<SQLStatement> stmtList,Object[] parameters,String dbType,OperateActInfo operateActInfo) throws Exception{
		SQLUpdateStatement uStmt = (SQLUpdateStatement)stmt;
		SQLName sqlName = uStmt.getTableName();
		StringBuffer tableNameBuffer = new StringBuffer();
		SQLASTOutputVisitor visitor = SQLUtils.createFormatOutputVisitor(tableNameBuffer, stmtList, dbType);
		sqlName.accept(visitor);
		
		SQLExpr whereExpr = uStmt.getWhere();
		StringBuffer tableWhere = new StringBuffer();
		SQLASTOutputVisitor whereVisitor = SQLUtils.createFormatOutputVisitor(tableWhere, stmtList, dbType);
		whereExpr.accept(whereVisitor);
		
		List<SQLUpdateSetItem> itemList = uStmt.getItems();
		StringBuffer tableItem = null; 
		SQLASTOutputVisitor itemVisitor = null;
		int whereIndex = 0;
		for(SQLUpdateSetItem item : itemList){
			SQLExpr valueExpr = item.getValue();
			tableItem = new StringBuffer();
			itemVisitor = SQLUtils.createFormatOutputVisitor(tableItem, stmtList, dbType);
			valueExpr.accept(itemVisitor);
			if(PRE_ATTR.equals(tableItem.toString())){
				whereIndex++;
			}	
		}
		List<Object> queryParam = new ArrayList<Object>();
		for(int i = whereIndex; i < parameters.length; i++){
			queryParam.add(parameters[i]);
		}
		String tableName = tableNameBuffer.toString().toLowerCase();
		String querySql = "select * from " + tableName + " where " + tableWhere;
		List<Map<String, Object>> resultList = this.getSqlQueryDao().queryTableValue(querySql, queryParam.toArray());
		
		OperateLog operateLog = new OperateLog();
		operateLog.setUserName(operateActInfo.getUserName());
		operateLog.setUserIp(operateActInfo.getUserIp());
		operateLog.setTableName(tableName);
		operateLog.setOptType(EAAPConstants.SQL_UPDATE);
		operateLog.setExecClass(operateActInfo.getExecClass()); 
		operateLog.setExecMethod(operateActInfo.getExceMothod());
		operateLog.setTenantId(operateActInfo.getTenantId());
		operateLog.setSqlLog(this.getSqlLog(updateSql, parameters)); 
		operateLog.setCreateDate(System.currentTimeMillis());
		
		List<OperateLogData> logDataList = new ArrayList<OperateLogData>();
		
		List<BakTableInfo> tableInfoList = this.getInitSqlLogService().getTableInfoByName(tableName);
		
		for(Map<String, Object> result : resultList){
			String dataKey = this.getDataKey(result, tableInfoList);
			String dataJson = JSON.toJSONString(result,SerializerFeature.WriteDateUseDateFormat);
			OperateLogData logDataBean = new OperateLogData();
			logDataBean.setDataLog(dataJson);
			logDataBean.setDataKey(dataKey);
			logDataBean.setCreateDate(System.currentTimeMillis());
			logDataList.add(logDataBean);
		}
		operateLog.setLogDataList(logDataList);
		this.getSqlMQSenderService().sendMessage(operateLog); 
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
	
	
	/**
	 * 新增操作
	 * @param stmt
	 * @param stmtList
	 * @param parameters
	 * @param dbType
	 * @throws Exception
	 */
	private void insertSqlParse(String updateSql, SQLStatement stmt,List<SQLStatement> stmtList, Object[] parameters, String dbType,
			OperateActInfo operateActInfo) throws Exception {
		
		SQLInsertStatement istmt = (SQLInsertStatement) stmt;
		SQLName sqlName = istmt.getTableName();
		StringBuffer tableNameBuffer = new StringBuffer();
		SQLASTOutputVisitor visitor = SQLUtils.createFormatOutputVisitor(tableNameBuffer, stmtList, dbType);
		sqlName.accept(visitor);
		String tableName = tableNameBuffer.toString().toLowerCase();
		if(!this.isLogTable(tableName)){
			
			ValuesClause valuesClause = istmt.getValues();
			List<SQLExpr> valueExprList = valuesClause.getValues();
			List<SQLExpr> columnExprList = istmt.getColumns();
			SQLASTOutputVisitor valueVisitor = null;
			SQLASTOutputVisitor columnVisitor = null;
			StringBuffer value = null;
			StringBuffer column = null;
			int size = columnExprList.size();
			int paramIndex = 0;
			Map<String,Object> result = new HashMap<String,Object>();
			for (int i = 0; i < size; i++) {
				column = new StringBuffer();
				columnVisitor = SQLUtils.createFormatOutputVisitor(column,stmtList, dbType);
				SQLExpr columnExpr = columnExprList.get(i);
				columnExpr.accept(columnVisitor);
	
				value = new StringBuffer();
				valueVisitor = SQLUtils.createFormatOutputVisitor(value, stmtList,dbType);
				SQLExpr valueExpr = valueExprList.get(i);
				valueExpr.accept(valueVisitor);
				if (PRE_ATTR.equals(value.toString())) {
					Object parameter = parameters[paramIndex];
					paramIndex++;
					result.put(column.toString().toLowerCase(), parameter.toString());
				} else {
					String _value = LocalSqlConver.localSqlConver(value.toString(),dbType);
					result.put(column.toString().toLowerCase(), _value);
				}
			}
			OperateLog operateLog = new OperateLog();
			operateLog.setUserName(operateActInfo.getUserName());
			operateLog.setUserIp(operateActInfo.getUserIp());
			operateLog.setTableName(tableName);
			operateLog.setOptType(EAAPConstants.SQL_INSERT);
			operateLog.setExecClass(operateActInfo.getExecClass());
			operateLog.setExecMethod(operateActInfo.getExceMothod());
			operateLog.setTenantId(operateActInfo.getTenantId());
			operateLog.setSqlLog(this.getSqlLog(updateSql, parameters));
			operateLog.setCreateDate(System.currentTimeMillis());
			List<OperateLogData> logDataList = new ArrayList<OperateLogData>();
			
			List<BakTableInfo> tableInfoList = this.getInitSqlLogService().getTableInfoByName(tableName);
			OperateLogData logDataBean = new OperateLogData();
			String dataJson = JSON.toJSONString(result,SerializerFeature.WriteDateUseDateFormat);
			String dataKey = this.getDataKey(result, tableInfoList);
			logDataBean.setDataLog(dataJson);
			logDataBean.setDataKey(dataKey); 
			logDataBean.setCreateDate(System.currentTimeMillis());
			logDataList.add(logDataBean);
	
			operateLog.setLogDataList(logDataList);
			this.getSqlMQSenderService().sendMessage(operateLog);
		}
	}
	
	private boolean isLogTable(String tableName){
		boolean isLogTable = false;
		if(LOG_TABLE_NAME.equals(tableName)
				|| LOG_DATA_TABLE_NAME.equals(tableName)){
			isLogTable = true;
		}
		return isLogTable;
	}
	
	private SqlQueryDaoImpl getSqlQueryDao() {
		if(sqlQueryDao == null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(ServletActionContext.getServletContext());
			sqlQueryDao = (SqlQueryDaoImpl)ctx.getBean("eaap-conf-sql-SqlQueryDao");
	     }
		return sqlQueryDao;
	}
	
	public SqlLogMessageProducer getSqlMQSenderService() {
		if(sqlLogMessageProducer == null){
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(ServletActionContext.getServletContext()); 
			sqlLogMessageProducer = (SqlLogMessageProducer)ctx.getBean("sqlLogQueueProducer");
	     }
		return sqlLogMessageProducer; 
	}
	
	public InitSqlLogService getInitSqlLogService() {
		if(initSqlLogService == null){
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(ServletActionContext.getServletContext()); 
			initSqlLogService = (InitSqlLogService)ctx.getBean("eaap-op2-conf-sqllog-initSqllogService");
	     }
		return initSqlLogService; 
	}
}
