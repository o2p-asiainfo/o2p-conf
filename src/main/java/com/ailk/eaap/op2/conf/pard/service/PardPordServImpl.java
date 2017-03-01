package com.ailk.eaap.op2.conf.pard.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.AttrValue;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProductAttrGroup;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.ValueAddedProdInfo;
import com.ailk.eaap.op2.conf.pard.dao.IPardPordDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;

public class PardPordServImpl implements IPardPordServ {
	public IPardPordDao pardPordDao;
    private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	
	public ProdOffer queryProdOffer(ProdOffer prodOffer){
		return pardPordDao.queryProdOffer(prodOffer);
	}
	public OfferProdRel queryOfferProdRel(OfferProdRel offerProdRel){
		return pardPordDao.queryOfferProdRel(offerProdRel);
	}
	public ValueAddedProdInfo queryValueAddedProdInfo(ValueAddedProdInfo valueProd){
		return pardPordDao.queryValueAddedProdInfo(valueProd);
	}
	public List<ProductAttr> queryProductAtrr(ProductAttr productAttr){
		return pardPordDao.queryProductAtrr(productAttr);
	}
	public AttrSpec queryAtrrSpec(AttrSpec attrSpec){
		return pardPordDao.queryAtrrSpec(attrSpec);
	}
	public List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing){
		return pardPordDao.queryPricingClassify(prodOfferPricing);
	}
	public void editProdOfferStatus(ProdOffer prodOffer) {
		pardPordDao.editProdOfferStatus(prodOffer) ;
	}
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType) ;
	}
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData) ;
	}
    public List<Map> queryProdDealSvcList(Map map){
    	return pardPordDao.queryProdDealSvcList(map);
    }
    public List<ProdOfferChannelType> queryProdOfferChannelList(
			ProdOfferChannelType prodChannel) {
		return pardPordDao.queryProdOfferChannelList(prodChannel);
	}

	public IPardPordDao getPardPordDao() {
		return pardPordDao;
	}

	public void setPardPordDao(IPardPordDao pardPordDao) {
		this.pardPordDao = pardPordDao;
	}
	public MainDataDao getMainDataSqlDAO() {
		return mainDataSqlDAO;
	}
	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}
	public MainDataTypeDao getMainDataTypeSqlDAO() {
		return mainDataTypeSqlDAO;
	}
	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}
    public List<ProductAttrGroup> queryProductAttrGroup(ProductAttrGroup productAttrGroup){
    	return pardPordDao.queryProductAttrGroup(productAttrGroup);
    }
	public ProductAttr queryProductAttrGroupRelaAndProductAttr(Map hashMap){
		 return this.pardPordDao.queryProductAttrGroupRelaAndProductAttr(hashMap);
	 }
	public List<AttrValue> queryProductAttrValueAndAttrValue(ProductAttr productAttr){
		return pardPordDao.queryProductAttrValueAndAttrValue(productAttr);
	}
}
