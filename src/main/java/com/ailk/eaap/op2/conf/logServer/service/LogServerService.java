package com.ailk.eaap.op2.conf.logServer.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.DataSource;
import com.ailk.eaap.op2.bo.DataSourceDbcp;
import com.ailk.eaap.op2.bo.DataSourceJndi;
import com.ailk.eaap.op2.bo.DataSourceRoute;
import com.ailk.eaap.op2.conf.logServer.bean.DataSourceBean;
import com.ailk.eaap.op2.conf.logServer.dao.ILogServerDao;

/**
 * @ClassName: LogServerService
 * @Description: 
 * @author zhengpeng
 * @date 2015-1-28 上午9:36:22
 *
 */
public class LogServerService implements ILogServerService{
	
	private ILogServerDao logServerDao;

	public ILogServerDao getLogServerDao() {
		return logServerDao;
	}

	public void setLogServerDao(ILogServerDao logServerDao) {
		this.logServerDao = logServerDao;
	}

	@Override
	public List<DataSourceBean> queryDataSourceList(Map<String, Object> paramMap) {
		return logServerDao.queryDataSourceList(paramMap); 
	}

	@Override
	public int queryDataSourceCount(Map<String, Object> paramMap) {
		return logServerDao.queryDataSourceCount(paramMap); 
	}
	/**
	 * 得到当前ID值
	 * @return
	 */
	@Override
	public String getCurrenId() {
		return logServerDao.getCurrenId();
	}
	/**
	 * 添加数据源
	 * @param dataSourceBean
	 */
	@Override
	public void addDataSourceBean(DataSourceBean dataSourceBean) {
		logServerDao.addDataSourceBean(dataSourceBean);
	}
	/**
	 * 删除数据源操作
	 * @param dataSourceId
	 */
	@Override
	public void delDataSource(Map dataSourceMap) {
		logServerDao.delDataSource(dataSourceMap);
	}
	public void delSingleDataSource(Map dataSourceMap){
		logServerDao.delSingleDataSource(dataSourceMap);
	}
	/**
	 * 查询数据源
	 * @param dataSourceId
	 * @return
	 */
	@Override
	public Map getDataSourceById(Map dataSourceMap) {
		return logServerDao.getDataSourceById(dataSourceMap);
	}
	/**
	 * 修改数据源
	 * @param dataSourceBean
	 */
	@Override
	public void updateDataSourceBean(DataSourceBean dataSourceBean) {
		logServerDao.updateDataSourceBean(dataSourceBean);
	}

	public DataSourceDbcp getDataSourceDbcpById(Map dataSourceMap) {
		return logServerDao.getDataSourceDbcpById(dataSourceMap);
	}
	public DataSourceJndi getDataSourceJndiById(Map dataSourceMap) {
		return logServerDao.getDataSourceJndiById(dataSourceMap);
	}
	public DataSourceRoute getDataSourceRouteById(Map dataSourceMap) {
		return logServerDao.getDataSourceRouteById(dataSourceMap);
	}

	public void addDataSource(DataSource dataSource) {
		if(dataSource.getIsDefault()!=null && dataSource.getIsDefault().equals("0")){
			Map map = new HashMap();
			map.put("dataSourceId", dataSource.getDataSourceId());
			logServerDao.changeDefault(map);
		}
		logServerDao.addDataSource(dataSource);
	}
	public void addDataSourceDbcp(DataSourceDbcp dataSourceDbcp){
		logServerDao.addDataSourceDbcp(dataSourceDbcp);
	}
	public void addDataSourceJndi(DataSourceJndi dataSourceJndi){
		logServerDao.addDataSourceJndi(dataSourceJndi);
	}
	public void addDataSourceRoute(DataSourceRoute dataSourceRoute){
		logServerDao.addDataSourceRoute(dataSourceRoute);
	}
	public void updateDataSource(DataSource dataSource) {
		
		if(dataSource.getIsDefault()!=null && dataSource.getIsDefault().equals("0")){
			Map map = new HashMap();
			map.put("dataSourceId", dataSource.getDataSourceId());
			logServerDao.changeDefault(map);
		}
		logServerDao.updateDataSource(dataSource);
	}
	public void updateDataSourceRoute(DataSourceRoute dataSourceRoute){
		logServerDao.updateDataSourceRoute(dataSourceRoute);
	}
	
}
