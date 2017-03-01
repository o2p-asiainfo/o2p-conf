
package com.ailk.eaap.op2.conf.monitor.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PortalPanel;
import com.ailk.eaap.op2.bo.RegStatRecent;
import com.ailk.eaap.op2.bo.Service;

public interface IMonitorViewDao {
	public List<RegStatRecent> queryAllBizInfo();
	public List<RegStatRecent> queryAllBizPerfomanceInfo(Map map);
	public List<RegStatRecent> querySvcRequestBizInfo(Map map);
	public List<RegStatRecent> querySvcRegBizInfo(Map map);
	public List<PortalPanel> queryPortalPanelInfo(PortalPanel portalPanel);
	public Double queryAvgUsingNum(Map map);
	public Double queryAvgUsingDstNum(Map map);
	public Double queryCsbNum(Map map);
	public void updatePortalPanel(PortalPanel portalPanel);
	public List<Map> queryComponentList(Map map);
	public List<Component> queryComponentInfo(Map map);
	public List<Org> queryOrgList(Map map);
	public List<RegStatRecent> queryAllComponentData(Map map);
	public List<RegStatRecent> querySvcRequestCompData(Map map);
	public List<RegStatRecent> queryPerformanceCompData(Map map);
	public List<RegStatRecent> querySvcRegCompData(Map map);
	public List<Map> queryComponentCount(Map map);
	public List<Map> queryComponentSvcCount(Map map);
	public List<Map> queryComponentSvcList(Map map);
	public List<RegStatRecent> queryAllComponentSvcData(Map map);
	public List<RegStatRecent> querySvcRequestCompSvcData(Map map);
	public List<RegStatRecent> queryPerformanceCompSvcData(Map map);
	public List<RegStatRecent> querySvcRegCompSvcData(Map map);
	public List<Map> querySvcPerformanceList(Map map);
	public List<Map> querySvcPerformanceCount(Map map);
	public List<RegStatRecent> queryAllSvcPerformanceData(Map map);
	public List<RegStatRecent> queryCsbSvcPerformanceData(Map map);
	public List<RegStatRecent> queryRegSvcPerformanceData(Map map);
	public List<RegStatRecent> querySvcUsePerformanceData(Map map);
	public List<RegStatRecent> querySvcSupplyPerformanceData(Map map);
	public List<RegStatRecent> querySvcPerformanceData(Map map);
	public List<RegStatRecent> queryLineAvgUsingNum(Map map);
	public List<RegStatRecent> queryLineAvgUsingDstNum(Map map);
	public List<RegStatRecent> queryLineCsbNum(Map map);
	public List<Map> querySingleBizCount(Map map);
	public List<Map> querySingleBizList(Map map);
	public List<RegStatRecent> queryAllSingleBizData(Map map);
	public List<RegStatRecent> queryPerformanceSingleBizData(Map map);
	public List<RegStatRecent> queryRequestSingleBizData(Map map);
	public List<RegStatRecent> querySvcRegSingleBizData(Map map);
	public String queryPortalPanelSeq();
	public Integer selectMaxDisplaySeq(PortalPanel portalPanel);
	public Integer selectCfgPanelNum(PortalPanel portalPanel);
	public void insertPortalPanel(PortalPanel portalPanel);
	public Integer selectCfgPanelIsExist(PortalPanel portalPanel);
	public void deletePortalPanel(PortalPanel portalPanel);
	public List<BizFunction> queryBizFunctionList(Map map);
	public List<Service> queryServiceList(Map map);
}
