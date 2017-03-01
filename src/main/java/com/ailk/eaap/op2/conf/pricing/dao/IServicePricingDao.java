package com.ailk.eaap.op2.conf.pricing.dao;

import java.math.BigDecimal;
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
import com.ailk.eaap.op2.common.EAAPException;

 

public interface IServicePricingDao {
	public List<Map> queryPackage(Map map);
	public List<Map> queryServiceList(Map map);
	public BigDecimal insertProduct(Product pro);
	public BigDecimal insertProdOffer(ProdOffer prodOffer);
	public Integer insertOfferProdRel(OfferProdRel offerProdRel);
	public Integer insertServiceProRel(Map map);
	public BigDecimal getProductbyCap(Map map);
	public List<Map<String, String>> queryService(Map map)
			throws EAAPException;
	public List<Map<String, String>> querySelectedService(Map map) throws EAAPException;;
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
