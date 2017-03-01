package com.ailk.eaap.op2.conf.flowcontrol.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.SerInvokeIns;

public interface IFlowControlDao {

	List<Map<String, String>> getControlCountermsList(
			Map<String, String> controlCountermsMap);

	List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap);

	List<Map<String, String>> queryExistsPolicy(Map<String, String> map);

	String queryCtlCounterms2CompSeq();

	String queryCount(CtlCounterms2Comp ctlCounterms2Comp);

	void insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);

	void deleteProofEffect(CtlCounterms2Comp ctlCounterms2Comp);

	List<Map> querySerInvokeInsCount(Map<String, Object> map);

	List<Map> showSerInvokeInsList(Map<String, Object> map);

	String querySerInvokeInsExist(SerInvokeIns serInvokeIns);

	List<Map> getServiceInfo(Map<String, String> map);

	Map getCtlCounterms2CompById(
			CtlCounterms2Comp ctlCounterms2Comp);

	void updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);


}
