package com.ailk.eaap.op2.conf.autoComplete.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;

public interface IAutoCompleteDao {
	public List<Component> queryComponentList(Component component);
	public List<Map> queryAllComptList(Map map);
	public List<Map> queryAllComptCount(Map map);
	public List<Service> queryServiceList(Service service);
	public List<Map> queryAllServiceList(Map map);
	public List<Map> queryAllServiceCount(Map map);
	public List<Org> queryOrgList(Org org);
	public List<Map> queryAllOrgList(Map map);
	public List<Map> queryAllOrgCount(Map map);
}
