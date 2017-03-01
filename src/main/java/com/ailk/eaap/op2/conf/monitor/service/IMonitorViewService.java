package com.ailk.eaap.op2.conf.monitor.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PortalPanel;
import com.ailk.eaap.op2.bo.RegStatRecent;
import com.ailk.eaap.op2.bo.Service;

public interface IMonitorViewService {
	public List<RegStatRecent> queryAllBizInfo(Map<String,String> map);
	public List<PortalPanel> queryPortalPanelInfo(PortalPanel portalPanel);
	public Double queryAvgUsingNum(Map map);
	public Double queryAvgUsingDstNum(Map map);
	public Double queryCsbNum(Map map);
	public void updatePortalPanel(PortalPanel portalPanel);
	public List<Map> queryComponentList(Map map);
	public List<RegStatRecent> queryComponentData(Map map);
	public List<Map> queryComponentSvcList(Map map);
	public List<RegStatRecent> queryComponentServiceData(Map map);
	public List<Component> queryComponentInfo(Map map);
	public List<Map> querySvcPerformanceList(Map map);
	public List<RegStatRecent> querySvcPerformanceData(Map map);
	public List<RegStatRecent> queryLineAvgUsingNum(Map map);
	public List<RegStatRecent> queryLineAvgUsingDstNum(Map map);
	public List<RegStatRecent> queryLineCsbNum(Map map);
	public List<Map> querySingleBizList(Map map);
	public List<RegStatRecent> querySingleBizData(Map map);
	public String queryPortalPanelSeq();
	public Integer selectMaxDisplaySeq(PortalPanel portalPanel);
	public Integer selectCfgPanelNum(PortalPanel portalPanel);
	public void insertPortalPanel(PortalPanel portalPanel);
	public Integer selectCfgPanelIsExist(PortalPanel portalPanel);
	public List<Org> queryOrgList(Map map);
	public void deletePortalPanel(PortalPanel portalPanel);
	public List<BizFunction> queryBizFunctionList(Map map);
	public List<Service> queryServiceList(Map map);
}
