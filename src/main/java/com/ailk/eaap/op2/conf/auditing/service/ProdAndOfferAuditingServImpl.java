package com.ailk.eaap.op2.conf.auditing.service;

import java.math.BigDecimal;
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
import com.ailk.eaap.op2.bo.ProductServiceRel;
import com.ailk.eaap.op2.bo.ServiceSpec;
import com.ailk.eaap.op2.bo.SettleCycleDef;
import com.ailk.eaap.op2.bo.SettleRule;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.dao.ProdAndOfferAuditingDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
import com.ailk.eaap.op2.dao.OrgDao;
import com.ailk.eaap.op2.dao.ProductServiceDAO;
import com.ailk.eaap.op2.dao.ServiceSpecDao;
public class ProdAndOfferAuditingServImpl implements ProdAndOfferAuditingServ {
	private ProdAndOfferAuditingDao prodAndOfferDao;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	private ServiceSpecDao serviceSpecDao;
	private ProductServiceDAO productServiceDAO;
	private OrgDao orgSqlDAO;
	
	public ProdAndOfferAuditingDao getProdAndOfferDao() {
		return prodAndOfferDao;
	}
	public void setProdAndOfferDao(ProdAndOfferAuditingDao prodAndOfferDao) {
		this.prodAndOfferDao = prodAndOfferDao;
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
	
	
	public OrgDao getOrgSqlDAO() {
		return orgSqlDAO;
	}
	public void setOrgSqlDAO(OrgDao orgSqlDAO) {
		this.orgSqlDAO = orgSqlDAO;
	}
	public ServiceSpecDao getServiceSpecDao() {
		return serviceSpecDao;
	}
	public void setServiceSpecDao(ServiceSpecDao serviceSpecDao) {
		this.serviceSpecDao = serviceSpecDao;
	}
	public ProductServiceDAO getProductServiceDAO() {
		return productServiceDAO;
	}
	public void setProductServiceDAO(ProductServiceDAO productServiceDAO) {
		this.productServiceDAO = productServiceDAO;
	}
	
	public void updateServiceSpec(String productId,String statusCd,String servicePublisher ){
		ProductServiceRel prodServRel = new ProductServiceRel();
		prodServRel.setProductId(productId);
		prodServRel.setStatus(EAAPConstants.COMM_STATE_VALID);
		prodServRel = productServiceDAO.queryProductService(prodServRel);
		if(null!=prodServRel){
			ServiceSpec serviceSpec = new ServiceSpec();
			serviceSpec.setServiceId(new BigDecimal(prodServRel.getServiceId()));
			serviceSpec.setStatusCd(statusCd);
			serviceSpec.setServicePublisher(servicePublisher);
			serviceSpecDao.updateServiceSpec(serviceSpec);
		}
	}
	
	public Product selectProduct(Product product){
		return prodAndOfferDao.selectProduct(product);
	}
	public Integer updateProduct(Product product){
		this.updateServiceSpec(String.valueOf(product.getProductId()), product.getStatusCd(),product.getProductPublisher());
		return prodAndOfferDao.updateProduct(product);
	}
	
	public Integer updateProdOffer(ProdOffer prodoffer){
		return prodAndOfferDao.updateProdOffer(prodoffer);
	}
	public ProdOffer selectProdOffer(ProdOffer prodoffer){
		return prodAndOfferDao.selectProdOffer(prodoffer);
	}
	
	public List<ProdOfferRel> selectProdOfferRel(ProdOfferRel prodOfferRel){
		return prodAndOfferDao.selectProdOfferRel(prodOfferRel);
	}
	public List<OfferProdRel> selectOfferProdRel(OfferProdRel offerProdRel){
		return prodAndOfferDao.selectOfferProdRel(offerProdRel);
	}

	public List<PricingPlan> getPricingPlan(Map map){
		return prodAndOfferDao.getPricingPlan(map);
	}
	public PricePlanLifeCycle queryPricePlanLifeCycle(PricePlanLifeCycle pricePlanLifeCycle){
		return prodAndOfferDao.queryPricePlanLifeCycle(pricePlanLifeCycle);
	}
	public String getPriceObjectProduct(String pricingInfoId){
		return prodAndOfferDao.getPriceObjectProduct(pricingInfoId);
	}
	public List<ComponentPrice> queryComponentPrice(Map<String, Object> map) {
		return prodAndOfferDao.queryComponentPrice(map);
	}
	
	public List<Map> queryProductAttrInfo(ProductAttr productAttr){
		return prodAndOfferDao.queryProductAttrInfo(productAttr);
	}
	public List<Map> queryComponentList(Map map){
		return prodAndOfferDao.queryComponentList(map);
	}
	
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData);
	}
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType);
	}
	
	public List<Map<String,String>> getSettleRule(Map<String,String> map){
		return prodAndOfferDao.getSettleRule(map);
	}
	public List<Channel> getProdOfferChannel(ProdOfferChannel poChannel){
		return prodAndOfferDao.getProdOfferChannel(poChannel);
	}
	@Override
	public Org queryOrg(Org paramOrg) {
		// TODO Auto-generated method stub
		return orgSqlDAO.queryOrg(paramOrg);
	}
	
	public List<Map<String,Object>> qryOfferProductRel(OfferProdRel offerProdRel){
		return prodAndOfferDao.qryOfferProductRel(offerProdRel);
	}
	

	public List<Map<String, Object>> getSettleListByOperatorId(Map<String, Object> map) {
		return prodAndOfferDao.getSettleListByOperatorId(map);
	}
	public SettleCycleDef querySettleCycleDef(SettleCycleDef settleCycleDef) {
		List<SettleCycleDef> settleCycleDefList = prodAndOfferDao.querySettleCycleDef(settleCycleDef);
		if(null==settleCycleDefList||settleCycleDefList.size()==0){
			return null;
		}
		return settleCycleDefList.get(0);
	}
	public List<Map<String, Object>> getSettleOperator(Map<String, Object> map) {
		return prodAndOfferDao.getSettleOperator(map);
	}
	public List<SettleRule> querySettleRule(SettleRule settleRule) {
		return prodAndOfferDao.querySettleRule(settleRule);
	}
}
