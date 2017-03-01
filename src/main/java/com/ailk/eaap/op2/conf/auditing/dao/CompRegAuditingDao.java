package com.ailk.eaap.op2.conf.auditing.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
 
public interface CompRegAuditingDao { 
	public List<Map> queryCompInfo(Component compbean);
	public List<Map> queryCompInfoList(Map map);
	public String addComp(Component compbean);
	public void delcComp(String compId);
	public void updateComp(Component compbean);
	public Integer updateApp(App appBean);
	public String selectSeqApp();
	public Integer saveApp(App appBean);
	public List<App> selectAPP(App appBean);
	/** 审批组件注册 **/
	public Integer checkCompOnline (Component orgBean) ;
	 public List<Map> queryCompTypeNCList(Map map);
	 public List<Component> validatorComponentInfoExistList(Component component);

}
