package com.ailk.eaap.op2.conf.autoComplete.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;
import com.linkage.rainbow.dao.SqlMapDAO;

public class AutoCompleteDao implements IAutoCompleteDao{
	private SqlMapDAO sqlMapDao;

	//组件自动补全
	public List<Component> queryComponentList(Component component){
		return (List<Component>)sqlMapDao.queryForList("component.queryComponent", component);
	}
	
	//服务自动补全
	public List<Service> queryServiceList(Service service){
		return (List<Service>)sqlMapDao.queryForList("service.queryService", service);
	}
	
	//查询组件列表
	public List<Map> queryAllComptList(Map map){
		return (List<Map>)sqlMapDao.queryForList("component.queryAllComptList", map);
	}
	public List<Map> queryAllComptCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("component.queryAllComptCount", map);
	}
	
	public List<Map> queryAllServiceList(Map map){
		return (List<Map>)sqlMapDao.queryForList("service.queryAllServiceList", map);
	}
	public List<Map> queryAllServiceCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("service.queryAllServiceCount", map);
	}
	
	//机构自动补全
	public List<Org> queryOrgList(Org org){
		return (List<Org>)sqlMapDao.queryForList("org.selectOrg", org);
	}
	
	public List<Map> queryAllOrgList(Map map){
		return (List<Map>)sqlMapDao.queryForList("org.queryAllOrgList", map);
	}
	
	public List<Map> queryAllOrgCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("org.queryAllOrgCount", map);
	}
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}
