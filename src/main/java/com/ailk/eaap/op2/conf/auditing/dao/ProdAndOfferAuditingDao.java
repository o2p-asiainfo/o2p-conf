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

public interface ProdAndOfferAuditingDao { 
	
	public Product selectProduct(Product product);
	public Integer updateProduct(Product product);
	
	public Integer updateProdOffer(ProdOffer prodoffer);
	public ProdOffer selectProdOffer(ProdOffer prodoffer);
	
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
	
	public List<Map<String,Object>> qryOfferProductRel(OfferProdRel offerProdRel);
	
	public List<Map<String,Object>> getSettleListByOperatorId(Map<String,Object> map);
	public List<SettleCycleDef> querySettleCycleDef(SettleCycleDef settleCycleDef);
	public List<Map<String,Object>> getSettleOperator(Map<String,Object> map);
	public List<SettleRule> querySettleRule(SettleRule settleRule);
 }
