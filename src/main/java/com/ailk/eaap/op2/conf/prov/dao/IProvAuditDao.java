package com.ailk.eaap.op2.conf.prov.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.common.EAAPException;


public interface IProvAuditDao{
	
	/**
	 * 根据组件ID查询应用能力选项
	 * @param component
	 * @return
	 */
	public List<Map<String, Object>>  provAbility (Map map)throws EAAPException;
	
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
	 * 更新审核状态
	 * @param component
	 * @return
	 */
	public String updateAuditing(String componentId,String auditing);
	
	/**
	 * 操作服务技术实现能力属性值（包括删除，上线，下线，审核）
	 * @param component
	 * @return
	 */
	public void operatorSerTechImpl(String  techImpAttId,String state) throws EAAPException;
	
	/**
	 * 展现机构信息
	 * @param component
	 * @return
	 */
	public List<Map<String, Object>>  showOrgList (Map map) throws EAAPException;
	
	public List<Map<String, Object>>  selectFileShare(Map map);
	
	public List<Map<String, Object>> showPackage(Map map);
	public Integer updateProdOffer(ProdOffer prodOfferBean);
	public Integer updateProduct(Product productBean) ;
	public List<Map<String, Object>>  getProduct(Map map);
	
	public void updateModuleVersion(String moduleName);
}
