package com.ailk.eaap.op2.conf.auditing.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Channel;
import com.ailk.eaap.op2.bo.ComponentPrice;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PricePlanLifeCycle;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannel;
import com.ailk.eaap.op2.bo.ProdOfferRel;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.SettleCycleDef;
import com.ailk.eaap.op2.bo.SettleRule;
public interface ProdAndOfferAuditingServ{ 
	public Product selectProduct(Product product);
	public Integer updateProduct(Product product);
	
	public void updateServiceSpec(String productId,String statusCd,String servicePublisher);
	public Integer updateProdOffer(ProdOffer prodoffer);
	public ProdOffer selectProdOffer(ProdOffer prodoffer);
	
	public List<MainData> selectMainData(MainData mainData) ;
	public List<MainDataType> selectMainDataType(MainDataType mainDataType) ;
	
	public List<ProdOfferRel> selectProdOfferRel(ProdOfferRel prodOfferRel);
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRel);
	
	public List<Map> queryProductAttrInfo(ProductAttr productAttr);
	public List<Map> queryComponentList(Map map);
	
	public List<PricingPlan> getPricingPlan(Map map);
	public PricePlanLifeCycle queryPricePlanLifeCycle(PricePlanLifeCycle pricePlanLifeCycle);
	public String getPriceObjectProduct(String pricingInfoId);
	public List<ComponentPrice> queryComponentPrice(Map<String, Object> map);
	
	public List<Map<String,String>> getSettleRule(Map<String,String> map);
	public List<Channel> getProdOfferChannel(ProdOfferChannel poChannel);
	 public  Org queryOrg(Org paramOrg);
	 
	 public List<Map<String,Object>> qryOfferProductRel(OfferProdRel offerProdRel);
	 

	public List<Map<String,Object>> getSettleListByOperatorId(Map<String,Object> map);
	public SettleCycleDef querySettleCycleDef(SettleCycleDef settleCycleDef);
	public List<Map<String,Object>> getSettleOperator(Map<String,Object> map);
	public List<SettleRule> querySettleRule(SettleRule settleRule);
	 
}
