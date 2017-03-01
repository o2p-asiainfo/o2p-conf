package com.ailk.eaap.op2.conf.logServer.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.TestScene;
import com.ailk.eaap.op2.conf.logServer.bean.DataSourceBean;
import com.linkage.rainbow.dao.SqlMapDAO;
import com.ailk.eaap.op2.bo.DataSource;
import com.ailk.eaap.op2.bo.DataSourceDbcp;
import com.ailk.eaap.op2.bo.DataSourceJndi;
import com.ailk.eaap.op2.bo.DataSourceRoute;

/**
 * @ClassName: LogServerDao
 * @Description: 
 * @author zhengpeng
 * @date 2015-1-28 上午9:35:12
 *
 */
public class LogServerDao implements ILogServerDao{
	
	private SqlMapDAO sqlMapDao;

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DataSourceBean> queryDataSourceList(Map<String, Object> paramMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-logserver.queryDataSourceList", paramMap);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int queryDataSourceCount(Map<String, Object> paramMap) {
		List<Map<String,Object>> resultMapList = sqlMapDao.queryForList("eaap-op2-conf-logserver.queryDataSourceCount", paramMap);
		return Integer.valueOf(String.valueOf(resultMapList.get(0).get("ALLNUM")));
	}

	@Override
	public String getCurrenId() {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-logserver.getCurrenId", null);
	}

	@Override
	public void addDataSourceBean(DataSourceBean dataSourceBean) {
		sqlMapDao.insert("eaap-op2-conf-logserver.addDataSourceBean", dataSourceBean);
	}
	/**
	 * 删除数据源操作
	 * @param dataSourceId
	 */
	@Override
	public void delDataSource(Map dataSourceMap) {
		sqlMapDao.delete("eaap-op2-conf-logserver.delDataSourceDbcp", dataSourceMap);
		sqlMapDao.delete("eaap-op2-conf-logserver.delDataSourceJndi", dataSourceMap);
	}
	
	public void delSingleDataSource(Map dataSourceMap) {
		sqlMapDao.delete("eaap-op2-conf-logserver.delDataSourceRoute", dataSourceMap);
		sqlMapDao.delete("eaap-op2-conf-logserver.delDataSourceDbcp", dataSourceMap);
		sqlMapDao.delete("eaap-op2-conf-logserver.delDataSourceJndi", dataSourceMap);
		sqlMapDao.delete("eaap-op2-conf-logserver.delDataSource", dataSourceMap);
	}
	
	/**
	 * 查询数据源
	 * @param dataSourceId
	 * @return
	 */
	@Override
	public Map getDataSourceById(Map dataSourceMap) {
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-logserver.getDataSourceById", dataSourceMap);
	}
	/**
	 * 修改数据源
	 * @param dataSourceBean
	 */
	@Override
	public void updateDataSourceBean(DataSourceBean dataSourceBean) {
		sqlMapDao.update("eaap-op2-conf-logserver.updateDataSourceBean", dataSourceBean);
	}

	public DataSourceDbcp getDataSourceDbcpById(Map dataSourceMap) {
		return (DataSourceDbcp)sqlMapDao.queryForObject("eaap-op2-conf-logserver.getDataSourceDbcpById", dataSourceMap);
	}
	public DataSourceJndi getDataSourceJndiById(Map dataSourceMap) {
		return (DataSourceJndi)sqlMapDao.queryForObject("eaap-op2-conf-logserver.getDataSourceJndiById", dataSourceMap);
	}
	public DataSourceRoute getDataSourceRouteById(Map dataSourceMap) {
		return (DataSourceRoute)sqlMapDao.queryForObject("eaap-op2-conf-logserver.getDataSourceRouteById", dataSourceMap);
	}

	public void addDataSource(DataSource dataSource){
		sqlMapDao.insert("eaap-op2-conf-logserver.addDataSource", dataSource);
	}
	public void addDataSourceDbcp(DataSourceDbcp dataSourceDbcp){
		sqlMapDao.insert("eaap-op2-conf-logserver.addDataSourceDbcp", dataSourceDbcp);
	}
	public void addDataSourceJndi(DataSourceJndi dataSourceJndi){
		sqlMapDao.insert("eaap-op2-conf-logserver.addDataSourceJndi", dataSourceJndi);
	}
	public void addDataSourceRoute(DataSourceRoute dataSourceRoute){
		sqlMapDao.insert("eaap-op2-conf-logserver.addDataSourceRoute", dataSourceRoute);
	}
	
	public void updateDataSource(DataSource dataSource){
		sqlMapDao.update("eaap-op2-conf-logserver.updateDataSource", dataSource);
	}
	public void updateDataSourceRoute(DataSourceRoute dataSourceRoute){
		sqlMapDao.update("eaap-op2-conf-logserver.updateDataSourceRoute", dataSourceRoute);
	}
	
	@Override
	public void changeDefault(Map map) {
		// TODO Auto-generated method stub
		sqlMapDao.update("eaap-op2-conf-logserver.changeDefault", map);
	}

}
