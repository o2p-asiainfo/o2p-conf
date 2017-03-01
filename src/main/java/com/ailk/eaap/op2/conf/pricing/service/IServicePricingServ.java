package com.ailk.eaap.op2.conf.pricing.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.OfferProdRelPricing;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.PricingTarget;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.Tenant;
 
@SuppressWarnings("unchecked")
public interface IServicePricingServ {
	public List<Map> queryPackage(Map map);
	public List<Map> queryServiceList(Map map);
	public BigDecimal insertProduct(Product pro);
	public BigDecimal insertProdOffer(ProdOffer prodOffer);
	public Integer insertOfferProdRel(OfferProdRel offerProdRel);
	public Integer insertServiceProRel(Map map);
	public BigDecimal getProductbyCap(Map map);
	public List<Map<String, String>> queryService(Map map);
	public List<Map<String, String>> querySelectedService(Map map);
	public List<MainDataType> selectMainDataType(MainDataType mainDataType);
	public List<MainData> selectMainData(MainData mainData) ;
	public List<Map> getOffersIds(Map map);
	public List<Map> getPricingPlan(Map map);
	public Integer updatePricingPlan(PricingPlan pricingPlan);
	public List<ProdOfferPricing> queryProdOfferPricing(ProdOfferPricing prodOfferPricing);
	public Integer updateProdOfferPricing(ProdOfferPricing prodOfferPricing);
	public Integer updatePricingTarget(PricingTarget pricingTarget);
	public List<OfferProdRelPricing> queryOfferProdRelPricing(OfferProdRelPricing offerProdRelPricing);
	public Integer updateProdRelPricing(OfferProdRelPricing offerProdRelPricing);
	public Integer updateProdOffer(ProdOffer prodOffer);
	public Tenant queryTenant(Tenant tenant);
}
