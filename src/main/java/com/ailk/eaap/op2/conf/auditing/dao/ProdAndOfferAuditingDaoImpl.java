package com.ailk.eaap.op2.conf.auditing.dao;
 
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Channel;
import com.ailk.eaap.op2.bo.ComponentPrice;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.PricePlanLifeCycle;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannel;
import com.ailk.eaap.op2.bo.ProdOfferRel;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.SettleCycleDef;
import com.ailk.eaap.op2.bo.SettleRule;
import com.linkage.rainbow.dao.SqlMapDAO;
@SuppressWarnings("all")
public class ProdAndOfferAuditingDaoImpl   implements ProdAndOfferAuditingDao {
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	
	public Product selectProduct(Product product){
		return (Product) sqlMapDao.queryForObject("eaap-op2-conf-auditing-prodAndOffer.selectProduct", product);
	}
	public Integer updateProduct(Product product){
		return sqlMapDao.update("eaap-op2-conf-auditing-prodAndOffer.updateProduct", product);
	}
	
	public Integer updateProdOffer(ProdOffer prodoffer){
		return sqlMapDao.update("eaap-op2-conf-auditing-prodAndOffer.updateProdOffer", prodoffer);
	}
	public ProdOffer selectProdOffer(ProdOffer prodoffer){
		return (ProdOffer) sqlMapDao.queryForObject("eaap-op2-conf-auditing-prodAndOffer.selectProdOffer", prodoffer);
	}
	
	public List<ProdOfferRel> selectProdOfferRel(ProdOfferRel prodOfferRel){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.selectProdOfferRel", prodOfferRel);
	}
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRel){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.selectOfferProdRel", offerProdRel);
	}
	
	public List<Map<String,Object>> qryOfferProductRel(OfferProdRel offerProdRel){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.qryOfferProductRel", offerProdRel);
	}
	
	public List<Map> queryComponentList(Map map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.queryComponentList", map);
	}
	
	public List<Map> queryProductAttrInfo(ProductAttr productAttr){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.queryProductAttrInfo", productAttr);
	}
	
	public List<PricingPlan> getPricingPlan(Map map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.getPricingPlan", map);
	}
	public PricePlanLifeCycle queryPricePlanLifeCycle(PricePlanLifeCycle pricePlanLifeCycle){
		return (PricePlanLifeCycle) sqlMapDao.queryForObject("eaap-op2-conf-auditing-prodAndOffer.queryPricePlanLifeCycle", pricePlanLifeCycle);
	}
	public String getPriceObjectProduct(String pricingInfoId){
		return (String) sqlMapDao.queryForObject("eaap-op2-conf-auditing-prodAndOffer.getPriceObjectProduct", pricingInfoId);
	}
	public List<ComponentPrice> queryComponentPrice(Map<String, Object> map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.queryComponentPrice", map);
	}
	
	public List<Map<String,String>> getSettleRule(Map<String,String> map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.getSettleRule", map);
	}
	public List<Channel> getProdOfferChannel(ProdOfferChannel poChannel){
		return sqlMapDao.queryForList("prodOfferChannelType.selectProdOfferChannel", poChannel);
	}
	
	

	public List<Map<String,Object>> getSettleListByOperatorId(Map<String,Object> map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.getSettleListByOperatorId", map);
	}
	public List<SettleCycleDef> querySettleCycleDef(SettleCycleDef settleCycleDef){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.querySettleCycleDef", settleCycleDef);
	}
	public List<Map<String,Object>> getSettleOperator(Map<String,Object> map){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.getSettleOperator", map);
	}
	public List<SettleRule> querySettleRule(SettleRule settleRule){
		return sqlMapDao.queryForList("eaap-op2-conf-auditing-prodAndOffer.querySettleRule", settleRule);
	}
	
}
