package com.ailk.eaap.op2.conf.prov.dao;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.TechImpAtt;
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.common.EAAPErrorCodeDef;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.common.EAAPTags;
import com.linkage.rainbow.dao.SqlMapDAO;


public class ProvAuditDao implements IProvAuditDao {
	private static Log log = LogFactory.getLog(ProvAuditDao.class);
	private SqlMapDAO sqlMapDao; 

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	public List<Map<String, String>> queryApilityCountMon(Map map)
			throws EAAPException {
		// TODO Auto-generated method stub
		return null;
	}

	public Org showOrg(Org org) {
		// TODO Auto-generated method stub
		Org orgInfo = new Org();
		try {	
			orgInfo = (Org) sqlMapDao.queryForObject("org.selectOrg", org);
		}
		catch (Exception e) {
			log.error(e.getStackTrace());
		}
		return orgInfo;
	}

	public Component showComponent(Component component) {
		// TODO Auto-generated method stub
		Component componentInfo = new Component();
		componentInfo = (Component) sqlMapDao.queryForObject("provide.selectComponent", component);
		return componentInfo;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> provAbility(Map map)
			throws EAAPException {
		// TODO Auto-generated method stub
		List<Map<String, Object>> provAbility;
		try {
			provAbility = sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.showService", map);
		} catch (Exception e) {
			throw new EAAPException(EAAPTags.SEG_PROVAPP_SIGN, EAAPErrorCodeDef.WRITE_QUEUE_ERR_9012,
				      new Timestamp(System.currentTimeMillis()) + "  Get ability apply to list Errors", e);
		}
		return provAbility;
	}

	public String updateAuditing(String componentId, String auditing) {
		// TODO Auto-generated method stub
		int num;
		Component component = new Component();
		component.setComponentId(componentId);
		if(EAAPConstants.COMM_STATE_NOPASSAUDI.equals(auditing)){//提交审核不通过
			component.setState(auditing);
		}else if(EAAPConstants.COMM_STATE_ONLINE.equals(auditing)){//通过
			component.setState(auditing);
			component.setUpState("");
		}else{
			component.setUpState(auditing);
		}
		num = sqlMapDao.update("provide.updateComponent", component);
		if(num >= 1){
			componentId = component.getComponentId();
		}
		return componentId;
	}

	public void operatorSerTechImpl(String serTechImplId, String state)
			throws EAAPException {
		//更新SER_TECH_IMPL状态
		SerTechImpl serTechImpl = new SerTechImpl();
		serTechImpl.setSerTechImplId(new Integer(serTechImplId));
		serTechImpl.setState(state);//删除
		sqlMapDao.update("provide.updateSerTechImpl", serTechImpl);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> showOrgList(Map map) throws EAAPException{
		// TODO Auto-generated method stub
		List<Map<String, Object>> orgList;
		try {
			orgList = sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.showOrg", map);
		} catch (Exception e) {
			throw new EAAPException(EAAPTags.SEG_PROVAPP_SIGN, EAAPErrorCodeDef.WRITE_QUEUE_ERR_9012,
				      new Timestamp(System.currentTimeMillis()) + "  Get ability apply to list Errors", e);
		}
		return orgList;
	}
	
	public void updateModuleVersion(String moduleName) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("moduleName", moduleName);
		paramMap.put("version", (new java.text.SimpleDateFormat("yyyyMMddHHmmssSSS")).format(new Date()));
		sqlMapDao.update("loadCommon.updateModuleVersion", paramMap);
	}

	public List<Map<String, Object>> selectFileShare(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.selectFileShare", map);
		// TODO Auto-generated method stub
		//return null;
	}
	
	public List<Map<String, Object>> showPackage(Map map){
		List<Map<String, Object>> showPackage = null;
		List<Map<String, Object>> resault =  new ArrayList<Map<String, Object>>() ;
		try {
		showPackage = sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.selectPackageList", map);
		} catch (Exception e) {
			throw new EAAPException(EAAPTags.SEG_PROVAPP_SIGN, EAAPErrorCodeDef.WRITE_QUEUE_ERR_9012,
				      new Timestamp(System.currentTimeMillis()) + "  Get package apply to list Errors", e);
		}
		List<Map<String, Object>> sonList = null;
		List<Map<String, Object>> sonList2 = null;
		
		String tenantId = map.get("tenantId").toString();
		for(int i=0; i<showPackage.size();i++){
			Map father = (Map)showPackage.get(i);
			Map son = new HashMap();
			son.put("tenantId", tenantId);
			String ofrId ;
			if(!"".equals(father.get("PROD_OFFER_ID"))){ 
				son.put("prodOfferId", father.get("PROD_OFFER_ID"));
				son.put("servCode", father.get("PROD_OFFER_ID"));
				sonList =sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.getPricingPlan", son);
				sonList2 = sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.getSettleAPI",son);
				father.put("PricePlan", sonList);
				father.put("settleList", sonList2);
			}
			resault.add(father);
			
		}
		
		
		
		return resault;
	}
	public Integer updateProdOffer(ProdOffer prodOfferBean) {
		
		return (Integer)sqlMapDao.update("prodOffer.updateProdOffer", prodOfferBean) ;
	}
	public Integer updateProduct(Product productBean) {
		
		return (Integer)sqlMapDao.update("eaap-op2-conf-auditing-prov.updateProduct",productBean) ;
	}
	
	public List<Map<String, Object>>  getProduct(Map map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prov.getProduct", map);
	}

}

