package com.ailk.eaap.op2.conf.autoComplete.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;

public interface IAutoCompleteService {
	public List<Component> queryComponentList(Component component);
	public List<Map> queryAllComptList(Map map);
	public List<Service> queryServiceList(Service service);
	public List<Map> queryAllServiceList(Map map);
	public List<Org> queryOrgList(Org org);
	public List<Map> queryAllOrgList(Map map);
}
