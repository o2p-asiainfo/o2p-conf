package com.ailk.eaap.op2.conf.flowcontrol.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.linkage.rainbow.dao.SqlMapDAO;

public class FlowControlDaoImpl implements IFlowControlDao {

	private SqlMapDAO sqlMapDao ;

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public List<Map<String, String>> getControlCountermsList(
			Map<String, String> controlCountermsMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-flowcontrol.getControlCountermsList", controlCountermsMap);
	}

	public List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-flowcontrol.getSerInvokeInsList", serInvokeInsMap);
	}

	public List<Map<String, String>> queryExistsPolicy(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-flowcontrol.queryExistsPolicy", map);
	}

	public String queryCtlCounterms2CompSeq() {
		return (String) sqlMapDao.queryForObject("ctlCounterms2Comp.selectCtlCounterms2CompSeq", null);
	}

	public String queryCount(CtlCounterms2Comp ctlCounterms2Comp) {
		return (String) sqlMapDao.queryForObject("ctlCounterms2Comp.selectCtlCounterms2CompCount", ctlCounterms2Comp);
	}

	public void insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp) {
		sqlMapDao.update("ctlCounterms2Comp.insertCtlCounterms2Comp", ctlCounterms2Comp) ;
	}

	public void deleteProofEffect(CtlCounterms2Comp ctlCounterms2Comp) {
		sqlMapDao.update("ctlCounterms2Comp.deleteCtlCounterms2Comp", ctlCounterms2Comp) ;
	}

	public List<Map> querySerInvokeInsCount(Map<String, Object> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-flowcontrol.querySerInvokeInsCount", map);
	}

	public List<Map> showSerInvokeInsList(Map<String, Object> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-flowcontrol.querySerInvokeInsList", map);
	}

	public String querySerInvokeInsExist(SerInvokeIns serInvokeIns) {
		return (String) sqlMapDao.queryForObject("eaap-op2-conf-flowcontrol.querySerInvokeInsExist", serInvokeIns) ;
	}

	public List<Map> getServiceInfo(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-flowcontrol.getServiceInfo", map);
	}

	public Map getCtlCounterms2CompById(
			CtlCounterms2Comp ctlCounterms2Comp) {
		return (Map) sqlMapDao.queryForObject("eaap-op2-conf-flowcontrol.getCtlCounterms2CompById", ctlCounterms2Comp);
	}

	public void updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp) {
		sqlMapDao.update("ctlCounterms2Comp.updateCtlCounterms2Comp", ctlCounterms2Comp) ;
	}
	
}
