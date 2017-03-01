package com.ailk.eaap.op2.conf.prov.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;

public interface IProvAuditService {

	/**
	 * 展现机构信息
	 * @param component
	 * @return
	 */
	public Org showOrg(Org org);
	
	/**
	 * 展现系统信息
	 * @param component
	 * @return
	 */
	public Component showComponent(Component component);
	
	/**
	 * 查询应用能力
	 * @param component
	 * @return
	 */
	public List<Map<String, Object>>  provAbility (Map map);
	
	/**
	 * 更新审核状态
	 * @param component
	 * @return
	 */
	public void updateAuditing(String componentId,String auditing);
	/**
	 * 展现机构信息
	 * @param component
	 * @return
	 */
	public List<Map<String, Object>>  showOrgList (Map map);
	
	public List<Map<String, Object>>  selectFileShare(String fileShareId);
	
	/**
	 * 
	 * showPackage:展示包. <br/>  
	 * 
	 * @author m 
	 * @param pro
	 * @return 
	 * @since JDK 1.6
	 */
	public List<Map<String, Object>> showPackage(Map map);
	
	 public  Org queryOrg(Org paramOrg);
}
