package com.ailk.eaap.op2.conf.flowcontrol.service;

import java.util.Map;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.SerInvokeIns;

public interface IFlowControlServ {

	/**
	 * 获取SER_INVOKE_INS
	 * @param serInvokeInsMap
	 * @return
	 */
	List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap);

	/**
	 * 获取CONTROL_COUNTERMS
	 * @param controlCountermsMap
	 * @return
	 */
	
	List<Map<String, String>> getControlCountermsList(
			Map<String, String> controlCountermsMap);

	/**
	 * 获得已配置策略
	 * @param map
	 * @return
	 */
	List<Map<String, String>> queryExistsPolicy(Map<String, String> map);

	/**
	 * 获取CTL_COUNTERMS_2_COMP表序列
	 * @return
	 */
	String queryCtlCounterms2CompSeq();

	/**
	 * 查询SER_INVOKE_INS_ID对应条数
	 * @return
	 */

	String queryCount(CtlCounterms2Comp ctlCounterms2Comp);

	/**
	 * 插入操作
	 * @param ctlCounterms2Comp
	 */
	void insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);

	/**
	 * 删除
	 * @param ctlCounterms2Comp
	 */
	void deleteProofEffect(CtlCounterms2Comp ctlCounterms2Comp);

	/**
	 * 总条数
	 * @param map
	 * @return
	 */
	List<Map> showSerInvokeInsList(Map<String, Object> map);

	/**
	 * 查询在 SER_INVOKE_INS表中是否存在对应的组件服务
	 * @param serInvokeIns
	 * @return
	 */
	String querySerInvokeInsExist(SerInvokeIns serInvokeIns);

	/**
	 * 根据组件ID查询对应的服务
	 * @param map
	 */
	List<Map> getServiceInfo(Map<String, String> map);

	Map getCtlCounterms2CompById(
			CtlCounterms2Comp ctlCounterms2Comp);

	/**
	 * 修改
	 * @param ctlCounterms2Comp
	 */
	void updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);

}
