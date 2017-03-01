package com.ailk.eaap.op2.conf.monitor.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.monitor.dao.MonitorReportDao;

public class MonitorReportService implements IMonitorReportService{
	private MonitorReportDao monitorReportDao;

	public List<Org> queryOrgList(Map map){
		return monitorReportDao.queryOrgList(map);
	}
	public List<Component> queryComponentInfo(Map map){
		return monitorReportDao.queryComponentInfo(map);
	}
	public List<Service> queryServiceList(Map map){
		return monitorReportDao.queryServiceList(map);
	}
	public List<BizFunction> queryBizFunctionList(Map map){
		return monitorReportDao.queryBizFunctionList(map);
	}
	public List selectReportResult(Map paraMap){
		if ("1".equals(paraMap.get("targetType"))){ //服务调用方
			return monitorReportDao.selectReportResult(paraMap);
		}else{ //服务使用方
			return monitorReportDao.selectSvcUseReportResult(paraMap);
		}
	}
	
	public MonitorReportDao getMonitorReportDao() {
		return monitorReportDao;
	}

	public void setMonitorReportDao(MonitorReportDao monitorReportDao) {
		this.monitorReportDao = monitorReportDao;
	}
}
