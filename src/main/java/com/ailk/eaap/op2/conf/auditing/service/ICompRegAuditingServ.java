package com.ailk.eaap.op2.conf.auditing.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.OrgRole;

 
public interface ICompRegAuditingServ{ 
	public List<Map> queryCompInfo(Component compbean);
	public List<Map> queryCompInfoList(Map map);
	public String addComp(Component compbean) ;
	public void delcComp(String compId);
	public void updateComp(Component compbean);
	public Integer updateApp(App appBean);
	public String selectSeqApp();
    public Integer saveApp(App appBean) ;
    public List<App> selectAPP(App appBean);
	/** 审批用户注册 **/
	public Integer checkCompOnline(Component compbean) ;
	/**
 	 * 获取主数据信息
 	 * @param mainData
 	 * @return
 	 */
 	public List<MainData> selectMainData(MainData mainData) ;
 	
 	/**
	 * 获取主数据类型信息
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType) ;
   
	public List<Map> queryCompTypeNCList(Map map) ;
	public List<Component> validatorComponentInfoExistList(Component component);
}
