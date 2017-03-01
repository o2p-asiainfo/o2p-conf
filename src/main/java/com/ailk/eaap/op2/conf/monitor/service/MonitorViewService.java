package com.ailk.eaap.op2.conf.monitor.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PortalPanel;
import com.ailk.eaap.op2.bo.RegStatRecent;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.monitor.dao.MonitorViewDao;

public class MonitorViewService implements IMonitorViewService {

	private MonitorViewDao monitorViewDao;
	
	//监控视图首页-所有业务视图
	public List<RegStatRecent> queryAllBizInfo(Map<String,String> map) {
		if ("1".equals(map.get("queryType"))){ //性能
			//return monitorViewDao.queryAllBizInfo(); //全部标签
			return monitorViewDao.queryAllBizPerfomanceInfo(map);
		}else if ("2".equals(map.get("queryType"))) { //服务使用方
			return monitorViewDao.querySvcRequestBizInfo(map);
		}else { //服务提供方
			return monitorViewDao.querySvcRegBizInfo(map);
		}
	}
	
	//监控视图首页-加载所有个性化面板
	public List<PortalPanel> queryPortalPanelInfo(PortalPanel portalPanel){
		return monitorViewDao.queryPortalPanelInfo(portalPanel);
	}
	
	//监控视图首页-系统性能仪表图-总性能
	public Double queryAvgUsingNum(Map map){
		return monitorViewDao.queryAvgUsingNum(map);
	}
	
	//监控视图首页-系统性能仪表图-落地方时长统计
	public Double queryAvgUsingDstNum(Map map){
		return monitorViewDao.queryAvgUsingDstNum(map);
	}
	
	public Double queryCsbNum(Map map){
		return monitorViewDao.queryCsbNum(map);
	}
	//监控视图首页-保存面板拖动顺序
	public void updatePortalPanel(PortalPanel portalPanel){
		monitorViewDao.updatePortalPanel(portalPanel);
	}
	
	public List<BizFunction> queryBizFunctionList(Map map){
		return monitorViewDao.queryBizFunctionList(map);
	}
	
	//组件监控视图-加载组件下拉框可选值
	public List<Map> queryComponentList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询组件总数
    		return monitorViewDao.queryComponentCount(map);
    	}else{ //查询组件信息
    		return monitorViewDao.queryComponentList(map);
    	}
	}
	
	//组件监控视图-加载组件曲线图接口数据
	public List<RegStatRecent> queryComponentData(Map map){
		if ("1".equals(map.get("tabType"))){ //性能
			return monitorViewDao.queryPerformanceCompData(map);
		}else if ("2".equals(map.get("tabType"))){ //服务使用方
			return monitorViewDao.querySvcRequestCompData(map);
		}else{ //服务提供方
			return monitorViewDao.querySvcRegCompData(map);
		}
	}
	
	//组件监控视图-下钻-组件所有服务
	public List<Map> queryComponentSvcList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询某个组件下的服务总数
    		return monitorViewDao.queryComponentSvcCount(map);
    	}else{ //查询组件服务列表
    		return monitorViewDao.queryComponentSvcList(map);
    	}
	}
	
	//单个业务监控视图
	public List<Map> querySingleBizList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询业务流程总数
    		return monitorViewDao.querySingleBizCount(map);
    	}else{ //查询业务流程列表
    		return monitorViewDao.querySingleBizList(map);
    	}
	}
	
	//组件监控视图-下钻-组件所有服务接口数据
	public List<RegStatRecent> queryComponentServiceData(Map map){
		if("1".equals(map.get("tabType"))){//性能
			return monitorViewDao.queryPerformanceCompSvcData(map);
		}else if ("2".equals(map.get("tabType"))){
			return monitorViewDao.querySvcRequestCompSvcData(map);
		}else{
			return monitorViewDao.querySvcRegCompSvcData(map);
		}
	}
	
	public List<Component> queryComponentInfo(Map map){
		return monitorViewDao.queryComponentInfo(map);
	}
	public List<Org> queryOrgList(Map map){
		return monitorViewDao.queryOrgList(map);
	}
	public List<Service> queryServiceList(Map map){
		return monitorViewDao.queryServiceList(map);
	}
	public List<Map> querySvcPerformanceList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询总数
    		return monitorViewDao.querySvcPerformanceCount(map);
    	}else{ //查询信息
    		return monitorViewDao.querySvcPerformanceList(map);
    	}
	}
	
	public Integer selectCfgPanelIsExist(PortalPanel portalPanel){
		return monitorViewDao.selectCfgPanelIsExist(portalPanel);
	}
	public List<RegStatRecent> querySingleBizData(Map map){
		if ("1".equals(map.get("tabType"))){ //性能
			return monitorViewDao.queryPerformanceSingleBizData(map);
		}else if ("2".equals(map.get("tabType"))){ //服务使用方
			return monitorViewDao.queryRequestSingleBizData(map);
		}else{
			return monitorViewDao.querySvcRegSingleBizData(map);
		}
	}
	
	public List<RegStatRecent> querySvcPerformanceData(Map map){
		if ("1".equals(map.get("tabType"))){ //性能
			return monitorViewDao.querySvcPerformanceData(map);
		}else if ("2".equals(map.get("tabType"))){ //服务使用方
			return monitorViewDao.querySvcUsePerformanceData(map);
		}else{
			return monitorViewDao.querySvcSupplyPerformanceData(map);
		}
	}
	
	public void deletePortalPanel(PortalPanel portalPanel){
		 monitorViewDao.deletePortalPanel(portalPanel);
	}
	public List<RegStatRecent> queryLineAvgUsingNum(Map map){
		return monitorViewDao.queryLineAvgUsingNum(map);
	}
	
	public List<RegStatRecent> queryLineAvgUsingDstNum(Map map){
		return monitorViewDao.queryLineAvgUsingDstNum(map);
	}
	
	public List<RegStatRecent> queryLineCsbNum(Map map){
		return monitorViewDao.queryLineCsbNum(map);
	}
	
	public String queryPortalPanelSeq(){
		return monitorViewDao.queryPortalPanelSeq();
	}
	
	public Integer selectMaxDisplaySeq(PortalPanel portalPanel){
		return monitorViewDao.selectMaxDisplaySeq(portalPanel);
	}
	
	public Integer selectCfgPanelNum(PortalPanel portalPanel){
		return monitorViewDao.selectCfgPanelNum(portalPanel);
	}
	
	public void insertPortalPanel(PortalPanel portalPanel){
		 monitorViewDao.insertPortalPanel(portalPanel);
	}
	
	public MonitorViewDao getMonitorViewDao() {
		return monitorViewDao;
	}
	public void setMonitorViewDao(MonitorViewDao monitorViewDao) {
		this.monitorViewDao = monitorViewDao;
	}
}
