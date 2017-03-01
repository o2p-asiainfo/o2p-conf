package com.ailk.eaap.op2.conf.manager.service;

import java.util.Map;
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Area;
import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.Auth;
import com.ailk.eaap.op2.bo.AuthBase;
import com.ailk.eaap.op2.bo.AuthObj;
import com.ailk.eaap.op2.bo.AuthObjAttr;
import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.MessageFlow;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.conf.auditing.dao.OrgRegAuditingDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
import com.ailk.eaap.op2.dao.OrgDao;
 
 
public class ConfManagerServ implements IConfManagerServ {
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
	 public List<Map> queryRoleNum(Org orgbean) {
		 return orgRegAuditingDao.queryRoleNum(orgbean);
	 }
	 public List<Map> queryMainDateTypeList(Map map){
			return orgRegAuditingDao.queryMainDateTypeList(map);
	 }
	 public List<Map> queryAuthList(Map map) {
		    return orgRegAuditingDao.queryAuthList(map) ;
	 }
	 public List<Map>  queryAuthListById(Map map){
		    return orgRegAuditingDao.queryAuthListById(map);
	 }
	 public Integer updateMainDataType(MainDataType mainDataType){
		 return orgRegAuditingDao.updateMainDataType(mainDataType) ;
	 }
	 public Integer updateMainData(MainData mainData){
		 return orgRegAuditingDao.updateMainData(mainData) ;
	 }
	public List<Map> queryAppApiInfo(Map app){
		return orgRegAuditingDao.queryAppApiInfo(app);
	}
	public List<Map> queryAppInfo(App app){
		return orgRegAuditingDao.queryAppInfo(app);
	}
	public String insertMainDataType(MainDataType mainDataType){
		return orgRegAuditingDao.insertMainDataType(mainDataType) ;
	}
	public Integer insertMainData(MainData mainData){
		return orgRegAuditingDao.insertMainData(mainData) ;
	}
	public Integer updateProdOffer(ProdOffer prodOffer){
		return orgRegAuditingDao.updateProdOffer(prodOffer) ;
	}
	public List<Map> queryProvinceForReg(Org orgBean){
		return orgSqlDAO.queryProvinceForReg(orgBean) ;
	}
	
	public Integer addOrg(Org orgBean,String [] orgRoles){
		return orgRegAuditingDao.addOrg(orgBean, orgRoles) ;
	}
	public Integer updateRoleCode(Org orgBean,String [] orgRoles){
		return orgRegAuditingDao.updateRoleCode(orgBean, orgRoles);
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
	/** 审批用户注册 **/
	public Integer checkOrgOnline(Org orgBean){
		return  orgRegAuditingDao.checkOrgOnline(orgBean) ;
	}
	
	/** 审批应用上线和升级 **/
	public Integer checkAppOnlineOrUpgrade(App appBean){
		                 
		return orgRegAuditingDao.checkAppOnlineOrUpgrade(appBean) ;
		      
	 
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
	public List<Map> selectMainDataList(Map map) {
		return orgRegAuditingDao.selectMainDataList(map) ;
	}
	public OrgRegAuditingDao getOrgRegAuditingDao() {
		return orgRegAuditingDao;
	}
	public void setOrgRegAuditingDao(OrgRegAuditingDao orgRegAuditingDao) {
		this.orgRegAuditingDao = orgRegAuditingDao;
	}
	public List<Map> selectSerInvokeInsList(Map map){
		return orgRegAuditingDao.selectSerInvokeInsList(map);
	}
	public Integer insertSerInvokeIns(SerInvokeIns serInvokeIns){
		return orgRegAuditingDao.insertSerInvokeIns(serInvokeIns) ;
	}
	public List<Map>  selectSerInvokeIns(Map map){
		return orgRegAuditingDao.selectSerInvokeIns(map);
	}
	public Integer updateSerInvokeIns(SerInvokeIns serInvokeIns){
		return orgRegAuditingDao.updateSerInvokeIns(serInvokeIns) ;
	}
	public List<Map> queryProofInfoById(Map map){
		return orgRegAuditingDao.queryProofInfoById(map);
	}
	
	public void deleteProofValues(SerInvokeIns serInvokeIns){
		orgRegAuditingDao.deleteProofValues(serInvokeIns);
	}
	
	public void deleteProofEffect(SerInvokeIns serInvokeIns){
		orgRegAuditingDao.deleteProofEffect(serInvokeIns) ;
	}
	
	
	public Integer insertProofEffect(ProofEffect proofEffect){
		return (Integer)orgRegAuditingDao.insertProofEffect(proofEffect) ;
	}
	
	public Integer insertProofValues(ProofValues proofValues){
		return (Integer)orgRegAuditingDao.insertProofValues(proofValues);
	}
	
	public List<Map>  queryCC2cInfoListById(Map map){
		return (List<Map>)orgRegAuditingDao.queryCC2cInfoListById(map);
		
	}
	public List<Map>  quertAttrValuesByProof(Map map){
		return (List<Map>)orgRegAuditingDao.quertAttrValuesByProof(map);
	}
	
	public Integer insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp){
		return (Integer)orgRegAuditingDao.insertCtlCounterms2Comp(ctlCounterms2Comp);
	}
	public Integer insertAuthInfo(Auth auth){
		return (Integer)orgRegAuditingDao.insertAuthInfo(auth);
	}
	
	public Integer insertAuthBaseInfo(AuthBase authBase){
		return (Integer)orgRegAuditingDao.insertAuthBaseInfo(authBase);
	}
	
	public Integer insertAuthObjInfo(AuthObj authObj){
		return (Integer)orgRegAuditingDao.insertAuthObjInfo(authObj);
	}
	
	public Integer updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp){
		return (Integer)orgRegAuditingDao.updateCtlCounterms2Comp(ctlCounterms2Comp);
	}
	public List<AttrSpec>  selectAtrrSpecListBySpecCode(Map map){
		return orgRegAuditingDao.selectAtrrSpecListBySpecCode(map);
	}
	public List<Map> queryAuthObjAttrListById(Map map){
		return orgRegAuditingDao.queryAuthObjAttrListById(map);
	}
	public Integer updateAuthInfo(Auth auth){
		return orgRegAuditingDao.updateAuthInfo(auth);
	}
	public Integer updateAuthObjInfo(AuthObj authObj){
		return orgRegAuditingDao.updateAuthObjInfo(authObj);
	}
	public List<Map> selectMessgeFlowList(MessageFlow messageFlow){
		return orgRegAuditingDao.selectMessgeFlowList(messageFlow);
	}
	public List<Org> selectOrgListForLike(Org org){
		return orgRegAuditingDao.selectOrgListForLike(org);
	}
	
	public Integer insertAuthObjAttr(AuthObjAttr authObjAttr){
		return orgRegAuditingDao.insertAuthObjAttr(authObjAttr);
	}
	
	public Integer updateAuthObjAttr(AuthObjAttr authObjAttr){
		return orgRegAuditingDao.updateAuthObjAttr(authObjAttr);
	}
	public List<Map> queryProdOfferList(Map map) {
		return orgRegAuditingDao.queryProdOfferList(map);
	}
	
	public List<Area> loadCityAreaList(Map paraMap){
		return orgRegAuditingDao.loadCityAreaList(paraMap);
	}
	
	public void delCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp){
		orgRegAuditingDao.delCtlCounterms2Comp(ctlCounterms2Comp);
	}
	
	public List<Org> validatorOrgInfoExistList(Org org){
		return orgRegAuditingDao.validatorOrgInfoExistList(org);
	}
	/**
	 * 查看数据状态
	 * @param mdt_cd
	 * @return
	 */
	@Override
	public String getTypeById(Map map) {
		return orgRegAuditingDao.getTypeById(map);
	}
	
	public List<Map> getLogLevelList(){
		return orgRegAuditingDao.getLogLevelList();
	}
	
	//org删除的时候要追加一个判断，如果有添加过产品销售品的话不允许删除
	public String isDeleteByOffer(Map map){
		return orgRegAuditingDao.isDeleteByOffer(map);
	}
	public String isDeleteByProduct(Map map){
		return orgRegAuditingDao.isDeleteByProduct(map);
	}
}
