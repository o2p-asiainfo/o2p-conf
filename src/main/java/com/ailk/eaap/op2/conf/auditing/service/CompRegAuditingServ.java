package com.ailk.eaap.op2.conf.auditing.service;

import java.util.Map;
import java.util.List;


import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.auditing.dao.CompRegAuditingDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;

 
public class CompRegAuditingServ implements ICompRegAuditingServ {
	private CompRegAuditingDao compRegAuditingDao ;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;


	public MainDataDao getMainDataSqlDAO() {
		return mainDataSqlDAO;
	}
	public CompRegAuditingDao getCompRegAuditingDao() {
		return compRegAuditingDao;
	}
	public void setCompRegAuditingDao(CompRegAuditingDao compRegAuditingDao) {
		this.compRegAuditingDao = compRegAuditingDao;
	}

	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}

	public MainDataTypeDao getMainDataTypeSqlDAO() {
		return mainDataTypeSqlDAO;
	}

	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}
	
	/**
	 * 获取主数据信息
	 * @param mainData
	 * @return
	 */
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData) ;
	}
	
	/**
	 * 获取主数据类型信息
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType) ;
	}
	public List<Map> queryCompInfo(Component compbean) {
		return compRegAuditingDao.queryCompInfo(compbean);
	}
	public List<Map> queryCompInfoList(Map map) {
		return compRegAuditingDao.queryCompInfoList(map);
	}
	public String addComp(Component compbean) {
		return compRegAuditingDao.addComp(compbean);
	}
	public Integer checkCompOnline(Component compbean) {
		return compRegAuditingDao.checkCompOnline(compbean);
	}
	public void delcComp(String compId) {
		compRegAuditingDao.delcComp(compId);
		
	}
	public void updateComp(Component compbean) {
		compRegAuditingDao.updateComp(compbean);
	}
	public Integer updateApp(App appBean){
		return compRegAuditingDao.updateApp(appBean);
	}
	
	public String selectSeqApp(){
		return compRegAuditingDao.selectSeqApp();
	}
	public Integer saveApp(App appBean){
		return compRegAuditingDao.saveApp(appBean);
	}
	public List<App> selectAPP(App appBean){
		return compRegAuditingDao.selectAPP(appBean);
	}
	 public List<Map> queryCompTypeNCList(Map map) {
		 return compRegAuditingDao.queryCompTypeNCList(map);
	 }
	 
	 public List<Component> validatorComponentInfoExistList(Component component){
			return compRegAuditingDao.validatorComponentInfoExistList(component);
		}
}
