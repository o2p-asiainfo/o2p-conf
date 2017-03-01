package com.ailk.eaap.op2.conf.monitor.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PortalPanel;
import com.ailk.eaap.op2.bo.RegStatRecent;
import com.ailk.eaap.op2.bo.Service;
import com.linkage.rainbow.dao.SqlMapDAO;

public class MonitorViewDao implements IMonitorViewDao {
	private SqlMapDAO sqlMapDao; 
	private SqlMapDAO sqlMapDaoSm;
	private SqlMapDAO sqlMapDaoDep;
	private SqlMapDAO sqlMapDaoStat;
	
	//监控视图首页-所有业务视图-全部
	public List<RegStatRecent> queryAllBizInfo() {
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryAllBizInfo", null);
	}
	
	//监控视图首页-所有业务视图-性能
	public List<RegStatRecent> queryAllBizPerfomanceInfo(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryAllBizPerfomanceInfo", map);
	}
	//监控视图首页-所有业务视图-服务请求方
	public List<RegStatRecent> querySvcRequestBizInfo(Map map) {
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRequestBizInfo", map);
	}
	
	//监控视图首页-所有业务视图-服务注册方
	public List<RegStatRecent> querySvcRegBizInfo(Map map) {
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRegBizInfo", map);
	}
	
	//监控视图首页-加载所有个性化面板
	public List<PortalPanel> queryPortalPanelInfo(PortalPanel portalPanel){
		return (List<PortalPanel>)sqlMapDaoSm.queryForList("portalPanel.queryCfgPortalPanelInfo", portalPanel);
	}
	
	//监控视图首页-系统性能仪表图-总性能
	public Double queryAvgUsingNum(Map map){
		return (Double)sqlMapDaoStat.queryForObject("eaap-op2-conf-monitor-view.queryAvgUsingNum", map);
	}
	
	//监控视图首页-系统性能仪表图-落地方时长统计
	public Double queryAvgUsingDstNum(Map map){
		return (Double)sqlMapDaoStat.queryForObject("eaap-op2-conf-monitor-view.queryAvgUsingDstNum", map);
	}
	
	//监控视图首页-系统性能仪表图-CSB
	public Double queryCsbNum(Map map){
		return (Double)sqlMapDaoStat.queryForObject("eaap-op2-conf-monitor-view.queryCsbNum", map);
	}
	
	//监控视图首页-系统性能曲线图-总性能
	public List<RegStatRecent> queryLineAvgUsingNum(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryLineAvgUsingNum", map);
	}
	
	//监控视图首页-系统性能曲线图-落地方时长统计
	public List<RegStatRecent> queryLineAvgUsingDstNum(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryLineAvgUsingDstNum", map);
	}
	
	//监控视图首页-系统性能曲线图-CSB性能
	public List<RegStatRecent> queryLineCsbNum(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryLineCsbNum", map);
	}
	
	//监控视图首页-保存面板拖动顺序
	public void updatePortalPanel(PortalPanel portalPanel) {
		sqlMapDaoSm.update("portalPanel.savePortalPanelCfg", portalPanel);
	}
	
	//组件监控视图-加载当前用户所有组件
	public List<Map> queryComponentList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.selectComponentList", map);
	}
	
	//组件监控视图-加载组件下拉框可选值
	public List<Component> queryComponentInfo(Map map){
		return (List<Component>)sqlMapDao.queryForList("component.selectComponentList", map);
	}
	
	//组件监控视图-加载ORG下拉框可选值
	public List<Org> queryOrgList(Map map){
		return (List<Org>)sqlMapDao.queryForList("org.selectOrgList", map);
	}
	
	//组件监控视图-加载组件曲线图接口数据-全部
	public List<RegStatRecent> queryAllComponentData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryAllComponentData", map);
	}
	
	//组件监控视图-加载组件曲线图接口数据-服务请求方
	public List<RegStatRecent> querySvcRequestCompData(Map map){
		String arrayDstCode = String.valueOf(map.get("dstCode"));
		if(null != map.get("dstCode") && !"".equals(arrayDstCode)){
			arrayDstCode = arrayDstCode.replace("'", "");
			String[] dstCode = arrayDstCode.split(",");
			map.put("arrayDstCode", dstCode);
		}
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRequestCompData", map);
	}
	
	//组件监控视图-加载组件曲线图接口数据-性能标签
	public List<RegStatRecent> queryPerformanceCompData(Map map){
		String arrayDstCode = String.valueOf(map.get("dstCode"));
		if(null != map.get("dstCode") && !"".equals(arrayDstCode)){
			arrayDstCode = arrayDstCode.replace("'", "");
			String[] dstCode = arrayDstCode.split(",");
			map.put("arrayDstCode", dstCode);
		}
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryPerformanceCompData", map);
	}
	
	//组件监控视图-加载组件曲线图接口数据-服务注册方
	public List<RegStatRecent> querySvcRegCompData(Map map){
		String arrayDstCode = String.valueOf(map.get("dstCode"));
		if(null != map.get("dstCode") && !"".equals(arrayDstCode)){
			arrayDstCode = arrayDstCode.replace("'", "");
			String[] dstCode = arrayDstCode.split(",");
			map.put("arrayDstCode", dstCode);
		}
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRegCompData", map);
	}
	
	//组件监控视图-获取用户下组件总记录数
	public List<Map> queryComponentCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.queryComponentCount", map);
	}
	
	//组件监控视图-获取某个组件下所有服务 总记录数
	public List<Map> queryComponentSvcCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.queryComponentSvcCount", map);
	}
	
	//组件监控视图-获取某个组件下所有服务
	public List<Map> queryComponentSvcList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.queryComponentSvcList", map);
	}
	
	//组件监控视图-获取某个组件下所有服务接口数据-全部标签
	public List<RegStatRecent> queryAllComponentSvcData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryAllComponentSvcData", map);
	}
	
	//组件监控视图-获取某个组件下所有服务接口数据-服务使用方
	public List<RegStatRecent> querySvcRequestCompSvcData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRequestCompSvcData", map);
	}
	
	//组件监控视图-获取某个组件下所有服务接口数据-性能标签
	public List<RegStatRecent> queryPerformanceCompSvcData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryPerformanceCompSvcData", map);
	}
	
	//组件监控视图-获取某个组件下所有服务接口数据-服务提供方
	public List<RegStatRecent> querySvcRegCompSvcData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRegCompSvcData", map);
	}
	//单个业务监控视图-业务流程总记录数
	public List<Map> querySingleBizCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.querySingleBizCount", map);
	}
	
	//单个业务监控视图首页
	public List<Map> querySingleBizList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.querySingleBizList", map);
	}
	
	//服务性能监控视图--初始化获取供应者下的所有服务
	public List<Map> querySvcPerformanceList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.querySvcPerformanceList", map);
	}
	
	//服务性能监控视图-服务总记录数
	public List<Map> querySvcPerformanceCount(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.querySvcPerformanceCount", map);
	}
	
	//服务性能监控视图-服务使用方-new
	public List<RegStatRecent> querySvcUsePerformanceData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcUsePerformanceData", map);
	}
	
	//服务性能监控视图-服务提供方-new
	public List<RegStatRecent> querySvcSupplyPerformanceData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcSupplyPerformanceData", map);
	}
	
	//服务性能监控视图-性能标签-new
	public List<RegStatRecent> querySvcPerformanceData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcPerformanceData", map);
	}
	
	//服务性能监控视图-全部标签-接口数据
	public List<RegStatRecent> queryAllSvcPerformanceData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryAllSvcPerformanceData", map);
	}
	
	//服务性能监控视图-CSB性能-接口数据
	public List<RegStatRecent> queryCsbSvcPerformanceData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryCsbSvcPerformanceData", map);
	}
	
	//服务性能监控视图-服务注册方-接口数据
	public List<RegStatRecent> queryRegSvcPerformanceData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryRegSvcPerformanceData", map);
	}
	
	//单个业务监控视图-全部标签接口数据
	public List<RegStatRecent> queryAllSingleBizData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryAllSingleBizData", map);
	}
	
	//单个业务监控视图-性能标签接口数据
	public List<RegStatRecent> queryPerformanceSingleBizData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryPerformanceSingleBizData", map);
	}
	
	//单个业务监控视图-服务请求方接口数据
	public List<RegStatRecent> queryRequestSingleBizData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.queryRequestSingleBizData", map);
	}
	
	//单个业务监控视图-落地方接口数据
	public List<RegStatRecent> querySvcRegSingleBizData(Map map){
		return (List<RegStatRecent>)sqlMapDaoStat.queryForList("eaap-op2-conf-monitor-view.querySvcRegSingleBizData", map);
	}
	
	//获取portalPanel序列
	public String queryPortalPanelSeq(){
		return (String)sqlMapDaoSm.queryForObject("portalPanel.selectPortalPanelSeq", null);
	}
	
	public Integer selectMaxDisplaySeq(PortalPanel portalPanel){
		return (Integer)sqlMapDaoSm.queryForObject("portalPanel.selectMaxDisplaySeq", portalPanel);
	}
	
	public Integer selectCfgPanelNum(PortalPanel portalPanel){
		return (Integer)sqlMapDaoSm.queryForObject("portalPanel.selectCfgPanelNum", portalPanel);
	}
	
	public List<BizFunction> queryBizFunctionList(Map map){
		String array = String.valueOf(map.get("orgId"));
		if(null != map.get("orgId") && !"".equals(array)){
			array = array.replace("'", "");
			String[] inArray = array.split(",");
			map.put("inArray", inArray);
		}
		return (List<BizFunction>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.queryBizFunctionList", map);
	}
	
	public List<Service> queryServiceList(Map map){
		String array = String.valueOf(map.get("orgId"));
		if(null != map.get("orgId") && !"".equals(array)){
			array = array.replace("'", "");
			String[] inArray = array.split(",");
			map.put("inArray", inArray);
		}
		return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-monitor-view.queryServiceList", map);
	}
	
	//查询该用户是否已配置该面板
	public Integer selectCfgPanelIsExist(PortalPanel portalPanel){
		return (Integer)sqlMapDaoSm.queryForObject("portalPanel.selectCfgPanelIsExist", portalPanel);
	}
	
	public void insertPortalPanel(PortalPanel portalPanel){
		sqlMapDaoSm.insert("portalPanel.insertPortalPanel", portalPanel);
	}
	//删除面板
	public void deletePortalPanel(PortalPanel portalPanel){
		sqlMapDaoSm.update("portalPanel.deletePortalPanel", portalPanel);
	}
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	public SqlMapDAO getSqlMapDaoSm() {
		return sqlMapDaoSm;
	}

	public void setSqlMapDaoSm(SqlMapDAO sqlMapDaoSm) {
		this.sqlMapDaoSm = sqlMapDaoSm;
	}
	public SqlMapDAO getSqlMapDaoDep() {
		return sqlMapDaoDep;
	}

	public void setSqlMapDaoDep(SqlMapDAO sqlMapDaoDep) {
		this.sqlMapDaoDep = sqlMapDaoDep;
	}

	public SqlMapDAO getSqlMapDaoStat() {
		return sqlMapDaoStat;
	}
	public void setSqlMapDaoStat(SqlMapDAO sqlMapDaoStat) {
		this.sqlMapDaoStat = sqlMapDaoStat;
	}
	
	
	
}
