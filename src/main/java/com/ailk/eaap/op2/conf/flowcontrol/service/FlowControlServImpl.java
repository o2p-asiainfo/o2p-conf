package com.ailk.eaap.op2.conf.flowcontrol.service;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.conf.flowcontrol.dao.IFlowControlDao;

public class FlowControlServImpl implements IFlowControlServ {

	private IFlowControlDao flowcontrolDAO ;

	public void setFlowcontrolDAO(IFlowControlDao flowcontrolDAO) {
		this.flowcontrolDAO = flowcontrolDAO;
	}

	public List<Map<String, String>> getControlCountermsList(
			Map<String, String> controlCountermsMap) {
		return flowcontrolDAO.getControlCountermsList(controlCountermsMap) ;
	}

	public List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap) {
		return flowcontrolDAO.getSerInvokeInsList(serInvokeInsMap) ;
	}

	public List<Map<String, String>> queryExistsPolicy(Map<String, String> map) {
		return flowcontrolDAO.queryExistsPolicy(map) ;
	}

	public String queryCtlCounterms2CompSeq() {
		return flowcontrolDAO.queryCtlCounterms2CompSeq();
	}

	public String queryCount(CtlCounterms2Comp ctlCounterms2Comp) {
		return flowcontrolDAO.queryCount(ctlCounterms2Comp);
	}

	public void insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp) {
		flowcontrolDAO.insertCtlCounterms2Comp(ctlCounterms2Comp);
	}

	public void deleteProofEffect(CtlCounterms2Comp ctlCounterms2Comp) {
		flowcontrolDAO.deleteProofEffect(ctlCounterms2Comp);
	}

	public List<Map> showSerInvokeInsList(Map<String, Object> map) {
		if ("ALLNUM".equals(map.get("queryType"))) { 
    		return flowcontrolDAO.querySerInvokeInsCount(map);
    	}else{
    		return flowcontrolDAO.showSerInvokeInsList(map);
    	}
	}

	public String querySerInvokeInsExist(SerInvokeIns serInvokeIns) {
		return flowcontrolDAO.querySerInvokeInsExist(serInvokeIns) ;
	}

	public List<Map> getServiceInfo(Map<String, String> map) {
		return flowcontrolDAO.getServiceInfo(map) ;
	}

	public Map getCtlCounterms2CompById(
			CtlCounterms2Comp ctlCounterms2Comp) {
		return flowcontrolDAO.getCtlCounterms2CompById(ctlCounterms2Comp) ;
	}

	public void updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp) {
		flowcontrolDAO.updateCtlCounterms2Comp(ctlCounterms2Comp) ;
	}
	
}
