package com.ailk.eaap.op2.conf.pricing.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

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
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.conf.pricing.dao.IServicePricingDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
 

public class ServicePricingServImpl implements IServicePricingServ {
	public IServicePricingDao servicePricingDao;
    private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	private static Log log = LogFactory.getLog(ServicePricingServImpl.class);

	
	
	public List<Map> queryPackage(Map map){
		return servicePricingDao.queryPackage(map);
	}
	public List<Map> queryServiceList(Map map){
		return servicePricingDao.queryServiceList(map);
	}
	public BigDecimal insertProduct(Product pro){
		return servicePricingDao.insertProduct(pro);
	}
	
	public BigDecimal insertProdOffer(ProdOffer prodOffer){
		return servicePricingDao.insertProdOffer(prodOffer);
	}
	
	public Integer insertOfferProdRel(OfferProdRel offerProdRel){
		return servicePricingDao.insertOfferProdRel(offerProdRel);
	}
	
	public Integer insertServiceProRel(Map map){
		return servicePricingDao.insertServiceProRel(map);
	}

	public BigDecimal getProductbyCap(Map map){
		return servicePricingDao.getProductbyCap(map);
	}
	
	public List<Map<String, String>> queryService(Map map) {
		// TODO Auto-generated method stub
		List<Map<String, String>> serviceList = null;
		try {
			serviceList = servicePricingDao.queryService(map);
		} catch (EAAPException e) {
			log.error(e.getStackTrace());
		}	
		return serviceList;
	}
	
	public List<Map<String, String>> querySelectedService(Map map){
		List<Map<String, String>> serviceList = null;
		try {
			serviceList = servicePricingDao.querySelectedService(map);
		} catch (EAAPException e) {
			log.error(e.getStackTrace());
		}	
		return serviceList;
	}
	
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData);
	}
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType);
	}
	
	
	public IServicePricingDao getServicePricingDao() {
		return servicePricingDao;
	}
	public void setServicePricingDao(IServicePricingDao servicePricingDao) {
		this.servicePricingDao = servicePricingDao;
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
	public List<Map> getOffersIds(Map map){
		return servicePricingDao.getOffersIds(map);
	}
	public List<Map> getPricingPlan(Map map){
		return servicePricingDao.getPricingPlan(map);
	}
	public Integer updatePricingPlan(PricingPlan pricingPlan){
		return servicePricingDao.updatePricingPlan(pricingPlan);
	}
	public List<ProdOfferPricing> queryProdOfferPricing(ProdOfferPricing prodOfferPricing){
		return servicePricingDao.queryProdOfferPricing(prodOfferPricing);
	}
	public Integer updateProdOfferPricing(ProdOfferPricing prodOfferPricing){
		return servicePricingDao.updateProdOfferPricing(prodOfferPricing);
	}
	public Integer updatePricingTarget(PricingTarget pricingTarget){
		return servicePricingDao.updatePricingTarget(pricingTarget);
	}
	public List<OfferProdRelPricing> queryOfferProdRelPricing(OfferProdRelPricing offerProdRelPricing){
		return servicePricingDao.queryOfferProdRelPricing(offerProdRelPricing);
	}
	public Integer updateProdRelPricing(OfferProdRelPricing offerProdRelPricing){
		return servicePricingDao.updateProdRelPricing(offerProdRelPricing);
	}
	public Integer updateProdOffer(ProdOffer prodOffer){
		return servicePricingDao.updateProdOffer(prodOffer);
	}
	
	public Tenant queryTenant(Tenant tenant){
		return servicePricingDao.queryTenant(tenant);
	}
}
