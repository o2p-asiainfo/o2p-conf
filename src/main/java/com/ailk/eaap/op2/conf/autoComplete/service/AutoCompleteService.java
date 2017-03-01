package com.ailk.eaap.op2.conf.autoComplete.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.autoComplete.dao.AutoCompleteDao;

public class AutoCompleteService implements IAutoCompleteService{
	private AutoCompleteDao autoCompleteDao;
	
	public List<Component> queryComponentList(Component component){
		return autoCompleteDao.queryComponentList(component);
	}
	
	public List<Service> queryServiceList(Service service){
		return autoCompleteDao.queryServiceList(service);
	}
	
	public List<Org> queryOrgList(Org org){
		return autoCompleteDao.queryOrgList(org);
	}
	
	public List<Map> queryAllComptList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询总数
    		return autoCompleteDao.queryAllComptCount(map);
    	}else{ //查询信息
    		return autoCompleteDao.queryAllComptList(map);
    	}
	}
	
	public List<Map> queryAllServiceList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询总数
    		return autoCompleteDao.queryAllServiceCount(map);
    	}else{ //查询信息
    		return autoCompleteDao.queryAllServiceList(map);
    	}
	}
	
	public List<Map> queryAllOrgList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询总数
    		return autoCompleteDao.queryAllOrgCount(map);
    	}else{ //查询信息
    		return autoCompleteDao.queryAllOrgList(map);
    	}
	}
	
	public AutoCompleteDao getAutoCompleteDao() {
		return autoCompleteDao;
	}

	public void setAutoCompleteDao(AutoCompleteDao autoCompleteDao) {
		this.autoCompleteDao = autoCompleteDao;
	}
}
