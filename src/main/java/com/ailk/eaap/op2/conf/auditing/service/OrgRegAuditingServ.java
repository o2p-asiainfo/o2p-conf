package com.ailk.eaap.op2.conf.auditing.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.OrgAuthCode;
import com.ailk.eaap.op2.bo.OrgRole;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.conf.auditing.dao.OrgRegAuditingDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
import com.ailk.eaap.op2.dao.OrgDao;
 
 
public class OrgRegAuditingServ implements IOrgRegAuditingServ {
	private OrgRegAuditingDao orgRegAuditingDao ;
	private MainDataDao mainDataSqlDAO ;
	private MainDataTypeDao mainDataTypeSqlDAO;
	private OrgDao orgSqlDAO; 
	public OrgDao getOrgSqlDAO() {
		return orgSqlDAO;
	}

	public void setOrgSqlDAO(OrgDao orgSqlDAO) {
		this.orgSqlDAO = orgSqlDAO;
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

	public List<Map> queryOrgInfo(Org orgbean){
		return orgRegAuditingDao.queryOrgInfo(orgbean);
	 }
	
	public List<Map> queryOrgInfoList(Map map){
		return orgRegAuditingDao.queryOrgInfoList(map);
	 }
	
	public List<Map> queryAppApiInfo(Map app){
		return orgRegAuditingDao.queryAppApiInfo(app);
	}
	public List<Map> queryAppInfo(App app){
		return orgRegAuditingDao.queryAppInfo(app);
	}
	public Integer updateProdOffer(ProdOffer prodOffer){
		return orgRegAuditingDao.updateProdOffer(prodOffer) ;
	}
	public List<Map> queryProvinceForReg(Org orgBean){
		return orgSqlDAO.queryProvinceForReg(orgBean) ;
	}
	
	public Integer addOrg(Org orgBean,OrgRole orgRoleBean){
		return orgSqlDAO.addOrg(orgBean, orgRoleBean) ;
	}
	
	public List<Map> queryCityForReg(Org orgBean){
		return orgSqlDAO.queryCityForReg(orgBean) ;
	}
	public List selectOrg(Org org){
		return orgSqlDAO.selectOrg(org);
	 }
	public List<Map> queryProdDealSvcList(Map map){
		return orgRegAuditingDao.queryProdDealSvcList(map) ;
	}
 
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer){
		return orgRegAuditingDao.selectProdOffer(prodOffer) ;
	}
	public List<ProdOfferChannelType>  selectProdOfferChannelType(ProdOfferChannelType prodOfferChannelType){
		return orgRegAuditingDao.selectProdOfferChannelType(prodOfferChannelType) ;
	}
	public List<Map> selectOfferProdRel(OfferProdRel offerProdRel){
		return orgRegAuditingDao.selectOfferProdRel(offerProdRel) ;
	}
	public List<Product>  selectProduct(Product product){
		return orgRegAuditingDao.selectProduct(product) ;
	}
	public List<Map> selectAllAttrValueByOfferId(Product product){
		return orgRegAuditingDao.selectAllAttrValueByOfferId(product);
	}
	public List<Map>  selectProductAttr(ProductAttr productAttr){
		return orgRegAuditingDao.selectProductAttr(productAttr) ;
	}
	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer){
		return orgRegAuditingDao.selectPricingListByOfferId(prodOffer) ;
	}
    public List<Map>  selectProductAttrInGroup(ProductAttr productAttr){
    	return orgRegAuditingDao.selectProductAttrInGroup(productAttr);
	}
	public List<Map> selectGroupInfoByProductId(Map map){
		return orgRegAuditingDao.selectGroupInfoByProductId(map);
	}
	public List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing){
		return orgRegAuditingDao.queryPricingClassify(prodOfferPricing);
	}
	/** 审批用户注册 **/
	public Integer checkOrgOnline(Org orgBean){
		return  orgRegAuditingDao.checkOrgOnline(orgBean) ;
	}
	
	/** 审批应用上线和升级 **/
	public Integer checkAppOnlineOrUpgrade(App appBean){
		return orgRegAuditingDao.checkAppOnlineOrUpgrade(appBean) ;
	}
	
	public String getOrgIdByAppId(Map map){
		return orgRegAuditingDao.getOrgIdByAppId(map);
	}
	
	/**
	 * 获取主数据信息
	 * @param mainData
	 * @return
	 */
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData) ;
	}
	
	/**
	 * 获取主数据类型信息
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType) ;
	}
	public OrgRegAuditingDao getOrgRegAuditingDao() {
		return orgRegAuditingDao;
	}
	public void setOrgRegAuditingDao(OrgRegAuditingDao orgRegAuditingDao) {
		this.orgRegAuditingDao = orgRegAuditingDao;
	}
	public List<Org> selectOrgListForLike(Org org){
		return this.orgRegAuditingDao.selectOrgListForLike(org);
	}
	public List<Map> queryPkgList(Map map){
		return this.orgRegAuditingDao.queryPkgList(map);
	}
	
	public Integer insertOrgAuthCode(OrgAuthCode orgAuthCode){
		return orgRegAuditingDao.insertOrgAuthCode(orgAuthCode);
	 }

	@Override
	public Org queryOrg(Org paramOrg) {
		// TODO Auto-generated method stub
		return orgSqlDAO.queryOrg(paramOrg);
	}
	
	public  Component selectComponentOne(Component paramComponent){
		return orgSqlDAO.selectComponentOne(paramComponent);
	}
}
