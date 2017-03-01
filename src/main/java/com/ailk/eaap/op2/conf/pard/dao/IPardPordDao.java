package com.ailk.eaap.op2.conf.pard.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.AttrValue;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProductAttrGroup;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.ValueAddedProdInfo;

public interface IPardPordDao {
	public ProdOffer queryProdOffer(ProdOffer prodOffer) ;
	public OfferProdRel queryOfferProdRel(OfferProdRel offerProdRel) ;
	public ValueAddedProdInfo queryValueAddedProdInfo(ValueAddedProdInfo valueProd);
	public List<ProductAttr> queryProductAtrr(ProductAttr productAttr);
	public AttrSpec queryAtrrSpec(AttrSpec attrSpec);
	public List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing);
	void editProdOfferStatus(ProdOffer prodOffer);
	public List<Map> queryProdDealSvcList(Map map);
	public List<ProdOfferChannelType> queryProdOfferChannelList(
			ProdOfferChannelType prodChannel);
	public ProductAttr queryProductAttrGroupRelaAndProductAttr(Map hashMap);
    public List<AttrValue> queryProductAttrValueAndAttrValue(ProductAttr productAttr);
    public List<ProductAttrGroup> queryProductAttrGroup(ProductAttrGroup productAttrGroup);
}
