package com.ailk.eaap.op2.conf.pricing.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.OfferProdRelPricing;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.PricingTarget;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.Tenant;
import com.ailk.eaap.op2.common.EAAPErrorCodeDef;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.common.EAAPTags;
import com.linkage.rainbow.dao.SqlMapDAO;
 

public class ServicePricingDaoImpl implements IServicePricingDao {
	private SqlMapDAO sqlMapDao;
	public List<Map> queryPackage(Map map){
		if(map.get("offerIds")!=null && !"".equals(map.get("offerIds").toString())){
			map.put("PROD_OFFER_ID", map.get("offerIds").toString().split(","));
		}
		if(map.get("ORG_TYPE")!=null && !"".equals(map.get("ORG_TYPE").toString())){
			map.put("ORG_TYPE_CODE", map.get("ORG_TYPE").toString().split(","));
		}
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pricing.queryPackageSum", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pricing.queryPackage", map);
		}
	}
	public List<Map> queryServiceList(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pricing.queryServiceListSum", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pricing.queryServiceList", map);
		}
	}
	public BigDecimal insertProduct(Product pro){
		return (BigDecimal)sqlMapDao.insert("eaap-op2-conf-pricing.insertProduct", pro) ;
		
	}
	
	public BigDecimal insertProdOffer(ProdOffer prodOffer){
		BigDecimal prdOffer= (BigDecimal) sqlMapDao.insert("eaap-op2-conf-pricing.insertProdOffer", prodOffer);
		return prdOffer;
		
	}
	public Integer insertOfferProdRel(OfferProdRel offerProdRel){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-pricing.insertOfferProdRel", offerProdRel) ;
		
	}
	
	public Integer insertServiceProRel(Map map){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-pricing.insertServiceProRel", map) ;
		
	}
	
	public BigDecimal getProductbyCap(Map map){
		return (BigDecimal)  sqlMapDao.queryForObject("eaap-op2-conf-pricing.getProductbyCap", map) ;
  

	}
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> queryService(Map map)
			throws EAAPException {
		// TODO Auto-generated method stub
		List<Map<String, String>> serviceList;
		try {
			serviceList = sqlMapDao.queryForList("eaap-op2-conf-pricing.queryService", map);
		} catch (Exception e) {
			throw new EAAPException(EAAPTags.SEG_PROVAPP_SIGN, EAAPErrorCodeDef.WRITE_QUEUE_ERR_9012,
				      new Timestamp(System.currentTimeMillis()) + "  Get ability apply to list Errors", e);
		}
		return serviceList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> querySelectedService(Map map)
			throws EAAPException {
		// TODO Auto-generated method stub
		List<Map<String, String>> serviceList;
		try {
			serviceList = sqlMapDao.queryForList("eaap-op2-conf-pricing.querySelectedService", map);
		} catch (Exception e) {
			throw new EAAPException(EAAPTags.SEG_PROVAPP_SIGN, EAAPErrorCodeDef.WRITE_QUEUE_ERR_9012,
				      new Timestamp(System.currentTimeMillis()) + "  Get ability apply to list Errors", e);
		}
		return serviceList;
	}
	
	public List<Map> getOffersIds(Map map){
		if(map.get("SERVICE_ID")!=null && !"".equals(map.get("SERVICE_ID").toString())){
			map.put("API_IDS", map.get("SERVICE_ID").toString().split(","));
		}
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pricing.getOffersIds", map) ;

	}
	public List<Map> getPricingPlan(Map map){
		
		 
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pricing.getPricingPlan", map);
		}
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	public Integer updatePricingPlan(PricingPlan pricingPlan){
		return sqlMapDao.update("eaap-op2-conf-pricing.updatePricingPlan", pricingPlan);
	}
	//定价计划关联
	public List<ProdOfferPricing> queryProdOfferPricing(ProdOfferPricing prodOfferPricing){
		return sqlMapDao.queryForList("eaap-op2-conf-pricing.queryProdOfferPricing", prodOfferPricing);
	}
	public Integer updateProdOfferPricing(ProdOfferPricing prodOfferPricing){
		return sqlMapDao.update("eaap-op2-conf-pricing.updateProdOfferPricing", prodOfferPricing);
	}
	public Integer updatePricingTarget(PricingTarget pricingTarget){
		return sqlMapDao.update("eaap-op2-conf-pricing.updatePricingTarget", pricingTarget);
	}
	public List<OfferProdRelPricing> queryOfferProdRelPricing(OfferProdRelPricing offerProdRelPricing){
		return sqlMapDao.queryForList("eaap-op2-conf-pricing.queryOfferProdRelPricing", offerProdRelPricing);
	}
	public Integer updateProdRelPricing(OfferProdRelPricing offerProdRelPricing){
		return sqlMapDao.update("eaap-op2-conf-pricing.updateProdRelPricing", offerProdRelPricing);
	}
	public Integer updateProdOffer(ProdOffer prodOffer){
		return sqlMapDao.update("eaap-op2-conf-pricing.updateProdOffer", prodOffer);
	}
	public Tenant queryTenant(Tenant tenant){
		return (Tenant) sqlMapDao.queryForObject("eaap-op2-conf-pricing.queryTenant", tenant);
	}
}
