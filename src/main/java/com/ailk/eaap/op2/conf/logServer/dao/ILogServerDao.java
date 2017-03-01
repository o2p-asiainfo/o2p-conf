package com.ailk.eaap.op2.conf.logServer.dao;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.DataSource;
import com.ailk.eaap.op2.bo.DataSourceDbcp;
import com.ailk.eaap.op2.bo.DataSourceJndi;
import com.ailk.eaap.op2.bo.DataSourceRoute;
import com.ailk.eaap.op2.conf.logServer.bean.DataSourceBean;

/**
 * @ClassName: ILogServerDao
 * @Description: 
 * @author zhengpeng
 * @date 2015-1-28 上午9:35:39
 *
 */
public interface ILogServerDao {
	
	public List<DataSourceBean> queryDataSourceList(Map<String,Object> paramMap);
	
	public int queryDataSourceCount(Map<String,Object> paramMap); 
	/**
	 * 得到当前ID值
	 * @return
	 */
	public String getCurrenId();

	/**
	 * 添加数据源
	 * @param dataSourceBean
	 */
	public void addDataSourceBean(DataSourceBean dataSourceBean);
	/**
	 * 删除数据源操作
	 * @param dataSourceId
	 */
	public void delDataSource(Map dataSourceMap);
	/**
	 * 查询数据源
	 * @param dataSourceId
	 * @return
	 */
	public Map getDataSourceById(Map dataSourceMap);
	/**
	 * 修改数据源
	 * @param dataSourceBean
	 */
	public void updateDataSourceBean(DataSourceBean dataSourceBean); 

	public DataSourceDbcp getDataSourceDbcpById(Map dataSourceMap);
	public DataSourceJndi getDataSourceJndiById(Map dataSourceMap);
	public DataSourceRoute getDataSourceRouteById(Map dataSourceMap);
	
	public void addDataSource(DataSource dataSource);
	public void addDataSourceDbcp(DataSourceDbcp dataSourceDbcp);
	public void addDataSourceJndi(DataSourceJndi dataSourceJndi);
	public void addDataSourceRoute(DataSourceRoute dataSourceRoute);
	public void updateDataSource(DataSource dataSource); 
	public void updateDataSourceRoute(DataSourceRoute dataSourceRoute); 
	public void delSingleDataSource(Map dataSourceMap);
	
	public void changeDefault(Map map);
}
