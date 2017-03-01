package com.ailk.eaap.op2.conf.monitor.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;
import com.linkage.rainbow.dao.SqlMapDAO;

public class MonitorReportDao implements IMonitorReportDao {
	private SqlMapDAO sqlMapDao;
	private SqlMapDAO sqlMapDaoDep;
	
	//监控报表-加载ORG下拉框可选值
	public List<Org> queryOrgList(Map map){
		return (List<Org>)sqlMapDao.queryForList("org.selectOrgList", map);
	}
	//监控报表-加载组件下拉框可选值
	public List<Component> queryComponentInfo(Map map){
		return (List<Component>)sqlMapDao.queryForList("component.selectComponentList", map);
	}
	//监控报表-加载服务下拉框可选值
	public List<Service> queryServiceList(Map map){
		String array = String.valueOf(map.get("orgId"));
		if(null != map.get("orgId") && !"".equals(array)){
			array = array.replace("'", "");
			String[] inArray = array.split(",");
			map.put("inArray", inArray);
		}
		return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-monitor-report.queryServiceList", map);
	}
	//监控报表-加载业务下拉框可选值
	public List<BizFunction> queryBizFunctionList(Map map){
		String array = String.valueOf(map.get("orgId"));
		if(null != map.get("orgId") && !"".equals(array)){
			array = array.replace("'", "");
			String[] inArray = array.split(",");
			map.put("inArray", inArray);
		}
		return (List<BizFunction>)sqlMapDao.queryForList("eaap-op2-conf-monitor-report.queryBizFunctionList", map);
	}
	
	//监控报表-查询动态报表数据 服务调用方
	public List selectReportResult(Map paraMap){
		String arrayCode = String.valueOf(paraMap.get("CODE"));
		if(null !=  paraMap.get("CODE") && !"".equals(arrayCode)){
			arrayCode = arrayCode.replace("'", "");
			String[] code = arrayCode.split(",");
			paraMap.put("arrayCode", code);
		}
		String arrayServiceCode = String.valueOf(paraMap.get("SERVICE_CODE"));
		if(null != paraMap.get("SERVICE_CODE") && !"".equals(arrayServiceCode)){
			arrayServiceCode = arrayServiceCode.replace("'", "");
			String[] servicecode = arrayServiceCode.split(",");
			paraMap.put("servicecode", servicecode);
		}
		String arrayComponent = String.valueOf(paraMap.get("COMPONENT_CODE"));
		if(null !=  paraMap.get("COMPONENT_CODE") && !"".equals(arrayComponent)){
			arrayComponent = arrayComponent.replace("'", "");
			String[] componentCode = arrayComponent.split(",");
			paraMap.put("componentCode", componentCode);
		}
		return (List)sqlMapDao.queryForList("eaap-op2-conf-monitor-report.selectReportResult", paraMap);
	}
	
	//监控报表-查询动态报表数据 服务使用方
	public List selectSvcUseReportResult(Map paraMap){
		String arrayCode = String.valueOf(paraMap.get("CODE"));
		if(null !=  paraMap.get("CODE") && !"".equals(arrayCode)){
			arrayCode = arrayCode.replace("'", "");
			String[] code = arrayCode.split(",");
			paraMap.put("arrayCode", code);
		}
		String arrayServiceCode = String.valueOf(paraMap.get("SERVICE_CODE"));
		if(null != paraMap.get("SERVICE_CODE") && !"".equals(arrayServiceCode)){
			arrayServiceCode = arrayServiceCode.replace("'", "");
			String[] servicecode = arrayServiceCode.split(",");
			paraMap.put("servicecode", servicecode);
		}
		String arrayComponent = String.valueOf(paraMap.get("COMPONENT_CODE"));
		if(null !=  paraMap.get("COMPONENT_CODE") && !"".equals(arrayComponent)){
			arrayComponent = arrayComponent.replace("'", "");
			String[] componentCode = arrayComponent.split(",");
			paraMap.put("componentCode", componentCode);
		}
		return (List)sqlMapDao.queryForList("eaap-op2-conf-monitor-report.selectSvcUseReportResult", paraMap);
	}
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	} 
	
	public SqlMapDAO getSqlMapDaoDep() {
		return sqlMapDaoDep;
	}
	public void setSqlMapDaoDep(SqlMapDAO sqlMapDaoDep) {
		this.sqlMapDaoDep = sqlMapDaoDep;
	}
}
