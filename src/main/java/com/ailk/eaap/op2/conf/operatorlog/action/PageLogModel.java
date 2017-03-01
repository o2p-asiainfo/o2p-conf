package com.ailk.eaap.op2.conf.operatorlog.action;

public class PageLogModel {
	
	private String logId;
	private String userName;
	private String userIp;
	private String createDate;
	private String execClass;
	private String execMethod;
	private String optAction;
	private String tableName;
	private String sqlLog;
	private String dataLog;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getExecClass() {
		return execClass;
	}
	public void setExecClass(String execClass) {
		this.execClass = execClass;
	}
	public String getExecMethod() {
		return execMethod;
	}
	public void setExecMethod(String execMethod) {
		this.execMethod = execMethod;
	}
	public String getOptAction() {
		return optAction;
	}
	public void setOptAction(String optAction) {
		this.optAction = optAction;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getSqlLog() {
		return sqlLog;
	}
	public void setSqlLog(String sqlLog) {
		this.sqlLog = sqlLog;
	}
	public String getDataLog() {
		return dataLog;
	}
	public void setDataLog(String dataLog) {
		this.dataLog = dataLog;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getUserIp() {
		return userIp;
	}
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}

}
