package com.ailk.eaap.op2.conf.pard.dao;

import java.util.ArrayList;
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
import com.ailk.eaap.op2.bo.ValueAddedProdInfo;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;

public class PardPordDaoImpl implements IPardPordDao {
	private SqlMapDAO sqlMapDao;

	public ProdOffer queryProdOffer(ProdOffer prodOffer) {
		return (ProdOffer) sqlMapDao.queryForObject(
				"prodOffer.selectProdOffer", prodOffer);
	}

	public OfferProdRel queryOfferProdRel(OfferProdRel offerProdRel) {
		return (OfferProdRel) sqlMapDao.queryForObject(
				"offerProdRel.selectOfferProdRel", offerProdRel);
	}

	public ValueAddedProdInfo queryValueAddedProdInfo(
			ValueAddedProdInfo valueProd) {
		return (ValueAddedProdInfo) sqlMapDao.queryForObject(
				"valueAddedProdInfo.selectValueAddedProdInfo", valueProd);
	}


	public List<ProductAttr> queryProductAtrr(ProductAttr productAttr) {
		return (List<ProductAttr>) sqlMapDao.queryForList(
				"productAtrr.selectProductAtrr", productAttr);
	}
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "attr_spec", columnNames = "ATTR_SPEC_NAME", idName = "attrSpecId", propertyNames = "attrSpecName") 
		}
	)
	public AttrSpec queryAtrrSpec(AttrSpec attrSpec) {
		return (AttrSpec) sqlMapDao.queryForObject("atrrSpec.selectAtrrSpec",
				attrSpec);
	}

    public  List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing){
    	return (List<Map>)sqlMapDao.queryForList("pricing.selectClassifyNameByProdofferId", prodOfferPricing);
    }
    
	public void editProdOfferStatus(ProdOffer prodOffer) {
		sqlMapDao.update("prodOffer.updateProdOffer", prodOffer);
	}
	@SuppressWarnings("unchecked")
	public List<Map> queryProdDealSvcList(Map map) {
		return (List<Map>) sqlMapDao.queryForList(
				"eaap-op2-conf-pardMix.showProdDealSvcList", map);
	}
	@SuppressWarnings("unchecked")
	public List<ProdOfferChannelType> queryProdOfferChannelList(
			ProdOfferChannelType prodChannel) {
		return (List<ProdOfferChannelType>) sqlMapDao.queryForList(
				"prodOfferChannelType.selectProdOfferChannelType", prodChannel);
	}
    public ProductAttr queryProductAttrGroupRelaAndProductAttr(Map hashMap){
    	return (ProductAttr)sqlMapDao.queryForObject("eaap-op2-conf-pardPord.queryProductAttrGroupRelaAndProductAttr", hashMap);
    }
    public List<AttrValue> queryProductAttrValueAndAttrValue(ProductAttr productAttr){
    	return (List<AttrValue>)sqlMapDao.queryForList("eaap-op2-conf-pardPord.queryProductAttrValueAndAttrValue", productAttr);
    }
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
    public List<ProductAttrGroup> queryProductAttrGroup(ProductAttrGroup productAttrGroup){
    	return (List<ProductAttrGroup>)sqlMapDao.queryForList("productAttrGroup.queryProductAttrGroup", productAttrGroup);
    }
}
