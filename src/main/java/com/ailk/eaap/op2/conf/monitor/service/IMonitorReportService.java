package com.ailk.eaap.op2.conf.monitor.service;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;

public interface IMonitorReportService {
	public List<Org> queryOrgList(Map map);
	public List<Component> queryComponentInfo(Map map);
	public List<Service> queryServiceList(Map map);
	public List<BizFunction> queryBizFunctionList(Map map);
	public List selectReportResult(Map paraMap);
}
