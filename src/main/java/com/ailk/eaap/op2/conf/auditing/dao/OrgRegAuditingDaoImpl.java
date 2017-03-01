package com.ailk.eaap.op2.conf.auditing.dao;
 
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
 




import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.AppApiList;
import com.ailk.eaap.op2.bo.Area;
import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.Auth;
import com.ailk.eaap.op2.bo.AuthBase;
import com.ailk.eaap.op2.bo.AuthObj;
import com.ailk.eaap.op2.bo.AuthObjAttr;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.MessageFlow;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.OrgAuthCode;
import com.ailk.eaap.op2.bo.OrgRole;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class OrgRegAuditingDaoImpl   implements OrgRegAuditingDao {
	private SqlMapDAO sqlMapDao;
	public List<Map> queryOrgInfo(Org orgbean) {
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryOrgInfo", orgbean) ;
    }
	
	public List<Map> queryOrgInfoList(Map map) {
		String arryState = String.valueOf(map.get("state"));
		if(null != map.get("state") && !"".equals(arryState)){
			arryState = arryState.replace("(", "").replace(")", "").replace("'", "");
			String[] state = arryState.split(",");
			map.put("arrayState", state);
		}
		String arrayOrgTypeCode = String.valueOf(map.get("orgTypeCode"));
		if(null != map.get("orgTypeCode") && !"".equals(arrayOrgTypeCode)){
			arrayOrgTypeCode = arrayOrgTypeCode.replace("(", "").replace(")", "").replace("'", "");
			String[] orgTypeCode = arrayOrgTypeCode.split(",");
			map.put("arrayOrgTypeCode", orgTypeCode);
		}
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryOrgInfoListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryOrgInfoList", map) ;
		}
    }
	
	public String isDeleteByProduct(Map map){
		return (String) sqlMapDao.queryForObject("eaap-op2-conf-autitingorgandapp.isDeleteByProduct", map);
	}
	
	public String isDeleteByOffer(Map map){
		return (String) sqlMapDao.queryForObject("eaap-op2-conf-autitingorgandapp.isDeleteByOffer", map);
	}
	
	public List<Map> queryRoleNum(Org orgbean) {
		   return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryRoleNum", orgbean) ;
	 }
	
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data_type", columnNames = "MDT_NAME,MDT_DESC", idName = "mtid", propertyNames = "MDT_NAME,MDT_DESC") 
		}
	)
	public List<Map> queryMainDateTypeList(Map map) {
		String arryState = String.valueOf(map.get("state"));
		if(null != map.get("state") && !"".equals(arryState)){
			arryState = arryState.replace("(", "").replace(")", "").replace("'", "");
			String[] state = arryState.split(",");
			map.put("arrayState", state);
		}
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectMainDataTypeCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectMainDataType", map) ;
		}
		
    }
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME,CEP_DES", idName = "MAIND_ID", propertyNames = "CEP_NAME,CEP_DES")
		}
	)
	public List<Map> selectMainDataList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectMainDataListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectMainDataList", map) ;
		}
		
    }
	
	
	public List<Map> queryAuthList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAuthListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAuthList", map) ;
		}
		
     }
	
	public List<Map>  quertAttrValuesByProof(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.quertAttrValuesByProof", map) ;
	}
	
	public List<Map> queryProdOfferList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("prodOffer.queryProdOfferListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("prodOffer.queryProdOfferList", map) ;
		}
		
     }
	
	
	public List<Map> selectSerInvokeInsList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectSerInvokeInsListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectSerInvokeInsList", map) ;
		}
		
     }
	
	
	
	public Integer insertAuthInfo(Auth auth){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertAuthInfo", auth) ;
	}
	
	public Integer insertAuthBaseInfo(AuthBase authBase){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertAuthBaseInfo", authBase) ;
	}
	
	public Integer insertAuthObjAttr(AuthObjAttr authObjAttr){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertAuthObjAttr", authObjAttr) ;
	}
	
	public Integer updateAuthObjAttr(AuthObjAttr authObjAttr){
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateAuthObjAttr", authObjAttr) ;
	}
	public Integer updateAuthObjInfo(AuthObj authObj){
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateAuthObjInfo", authObj) ;
	}
	
	
	public Integer insertAuthObjInfo(AuthObj authObj){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertAuthObjInfo", authObj) ;
	}
	
	public Integer updateAuthInfo(Auth auth){
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateAuthInfo", auth) ;
	}
	
	
	
	
	public Integer updateMainDataType(MainDataType mainDataType){
		return (Integer)sqlMapDao.update("mainDataType.updateMainDataType", mainDataType) ;
	}
	public Integer updateMainData(MainData mainData){
		return (Integer)sqlMapDao.update("mainData.updateMainData", mainData) ;
	}
	
	public String insertMainDataType(MainDataType mainDataType){
		return (String)sqlMapDao.insert("mainDataType.insertMainDataType", mainDataType) ;
	}
	
	public Integer insertMainData(MainData mainData){
		return (Integer)sqlMapDao.insert("mainData.insertMainData", mainData) ;
	}
	
	public Integer insertSerInvokeIns(SerInvokeIns serInvokeIns){
		return (Integer)sqlMapDao.insert("serInvokeIns.insertSerInvokeIns", serInvokeIns) ;
	}
	
	public Integer updateSerInvokeIns(SerInvokeIns serInvokeIns){
		return (Integer)sqlMapDao.update("serInvokeIns.updateSerInvokeIns", serInvokeIns) ;
	}
	
	public void deleteProofValues(SerInvokeIns serInvokeIns){
		 sqlMapDao.update("eaap-op2-conf-autitingorgandapp.deleteProofValues", serInvokeIns) ;
	}
	
	public void deleteProofEffect(SerInvokeIns serInvokeIns){
		 sqlMapDao.update("eaap-op2-conf-autitingorgandapp.deleteProofEffect", serInvokeIns) ;
	}
	
	
	
	
	
	public List<Map>  queryCC2cInfoListById(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryCC2cInfoListByIdCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryCC2cInfoListById", map) ;
		}
		
		
	}
	
	public List<Map>  queryAuthListById(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAuthListByIdCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAuthListById", map) ;
		}
		
		
	}
	 public List<AttrSpec>  selectAtrrSpecListBySpecCode(Map map){
		 String arrayAttrSpecCode = String.valueOf(map.get("attrSpecCode"));
		 if(null != map.get("attrSpecCode") && !"".equals(arrayAttrSpecCode)){
			 arrayAttrSpecCode = arrayAttrSpecCode.replace("(", "").replace(")", "").replace("'", "");
			 String[] attrSpecCode = arrayAttrSpecCode.split(",");
			 map.put("arrayAttrSpecCode", attrSpecCode);
		 }
		  return (List<AttrSpec>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectAtrrSpecListBySpecCode", map) ;
	 }
	
	
	public Integer insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertCtlCounterms2Comp", ctlCounterms2Comp) ;
	}
	
	
	public Integer updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp){
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateCtlCounterms2Comp", ctlCounterms2Comp) ;
	}
	
	
	
	
	public Integer insertProofEffect(ProofEffect proofEffect){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertProofEffect", proofEffect) ;
	}
	
	public Integer insertProofValues(ProofValues proofValues){
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertProofValues", proofValues) ;
	}
	
	
	public List<Map>  selectSerInvokeIns(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectSerInvokeIns", map) ;
		
	}
	public List<Map> queryProofInfoById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryProofInfoById", map) ;
	}
	public List<Map> queryAuthObjAttrListById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAuthObjAttrListById", map) ;
	}
	
	public List<Map> queryAppApiInfo(Map app){
		if("ALLNUM".equals(String.valueOf(app.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAppApiInfoCount", app) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAppApiInfo", app) ;
		}
		
	}
	public List<Map> queryAppInfo(App app){
		
		List<Map> aa = (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAppInfo", app) ;
		
		return aa ;
	}
	
	public List<Map> selectMessgeFlowList(MessageFlow messageFlow){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.selectMessgeFlowList", messageFlow) ;
	}
	
	
	/** 审批用户注册 **/
	public Integer checkOrgOnline (Org orgBean){
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateOrg", orgBean) ;
	}
	
	/** 审批应用上线和升级 **/
	public Integer checkAppOnlineOrUpgrade(App appBean){
	     AppApiList appApiList = new AppApiList() ;
	     appApiList.setAppId(appBean.getAppId()) ;
	     if("D".equals(appBean.getAppState())){
	    	 appApiList.setState("D") ;
	     }else{
	    	 appApiList.setState("C") ;
	     }
	     Component component = new Component();   
	     component.setComponentId(appBean.getComponentId());
	     component.setState(appBean.getAppState());
	      sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateAppApiList", appApiList) ;
	      
	     sqlMapDao.update("eaap-op2-conf-autitingcomp.updateComponent", component) ;
		 return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateApp", appBean) ;
	}
	
	public String getOrgIdByAppId(Map map) {
		return (String) sqlMapDao.queryForObject("eaap-op2-conf-autitingorgandapp.getOrgIdByAppId", map);
	}
	/**
     * 查询某供应者下所有的产品受理服务
     * @param map
     * @return
     */
	@SuppressWarnings("unchecked")
	public List<Map> queryProdDealSvcList(Map map) {
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.showProdDealSvcList", map);
	}
	 
	public Integer updateProdOffer(ProdOffer prodOffer){
		return (Integer)sqlMapDao.update("eaap-op2-conf-pardMix.updateProdOffer", prodOffer) ;
    }
	
	public List<ProdOfferChannelType>  selectProdOfferChannelType(ProdOfferChannelType prodOfferChannelType){
		return (ArrayList<ProdOfferChannelType>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProdOfferChannelType", prodOfferChannelType) ;
		
	}
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer){
	 	return (ArrayList<ProdOffer>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProdOffer", prodOffer) ;
    }
	public List<Map> selectOfferProdRel(OfferProdRel offerProdRel){
	 	return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectOfferProdRel", offerProdRel) ;
    }
	public List<Product>  selectProduct(Product product){
		return (ArrayList<Product>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProduct", product) ;
		
	}
	public List<Map> selectAllAttrValueByOfferId(Product product){
	 	return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectAllAttrValueByOfferId", product) ;
    }
	public List<Map>  selectProductAttr(ProductAttr productAttr){
		return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProductAttrNotInGroup", productAttr) ;
		
	}
	public List<Map>  selectProductAttrInGroup(ProductAttr productAttr){
		return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProductAttrInGroup", productAttr) ;
		
	}
	public List<Map> selectGroupInfoByProductId(Map map){
	 	return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectGroupInfoByProductId", map) ;
    }
	
	 public  List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing){
	    	return (ArrayList<Map>)sqlMapDao.queryForList("pricing.selectClassifyNameByProdofferId", prodOfferPricing);
     }
	
	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer){
	 	return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectPricingListByOfferId", prodOffer) ;
    }
	public Integer addOrg(Org orgBean,String [] orgRoles){
		OrgRole orgRoleBean = new OrgRole() ;
		Integer orgId = (Integer)sqlMapDao.insert("org.insertOrg", orgBean) ;
		if(orgRoles!=null && orgRoles.length>=1){
			for(String roleCode:orgRoles){
				orgRoleBean.setOrgId(orgId) ;
				orgRoleBean.setRoleCode(roleCode);
				sqlMapDao.insert("org_role.insertOrgRole", orgRoleBean) ;
			}
		 }
		
		
		 
		   return orgId ;
	}
	
	public Integer updateRoleCode(Org orgBean,String [] orgRoles){
		
		
		OrgRole orgRoleBean = new OrgRole() ;
		orgRoleBean.setOrgId(orgBean.getOrgId()) ;
		sqlMapDao.delete("org_role.deleteOrgRole", orgRoleBean);
		 
		if(orgRoles!=null && orgRoles.length>=1){
			for(String roleCode:orgRoles){
				orgRoleBean.setOrgId(orgBean.getOrgId()) ;
				orgRoleBean.setRoleCode(roleCode);
				sqlMapDao.insert("org_role.insertOrgRole", orgRoleBean) ;
			}
		 }
		  return orgBean.getOrgId() ;
	}
	
	
	public List<Org> selectOrgListForLike(Org org){
		return (ArrayList<Org>)sqlMapDao.queryForList("org.selectOrg", org) ;
	}
	
	public List<Area> loadCityAreaList(Map paraMap){
		return (List<Area>)sqlMapDao.queryForList("org.selectCity", paraMap);
	}
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	public void delCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp){
		sqlMapDao.delete("eaap-op2-conf-autitingorgandapp.delCtlCounterms2Comp", ctlCounterms2Comp);
	}
	
	public List<Org> validatorOrgInfoExistList(Org org){
		return (ArrayList<Org>)sqlMapDao.queryForList("org.validatorOrgInfoExistList", org) ;
	}
	
	public Integer insertOrgAuthCode(OrgAuthCode orgAuthCode) {
		return (Integer)sqlMapDao.insert("eaap-op2-conf-autitingorgandapp.insertOrgAuthCode", orgAuthCode);
	}
	
	public List<Map> queryPkgList(Map map){
		List<Map> appPkgList =new ArrayList<Map>();
		appPkgList = sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryPkgList", map) ;
		List<Map> father = new ArrayList<Map>();
		if(appPkgList.size()>0){
           Map temp = new HashMap(); 
			for(int m=0;m<appPkgList.size();m++){
				List<Map> son = new ArrayList<Map>();
				List<Map> son2 = new ArrayList<Map>();
				List<Map> son3 = new ArrayList<Map>();
				
				temp = appPkgList.get(m);
				String arrayOfferId = String.valueOf(temp.get("PROD_OFFER_ID"));
				if(null != temp.get("PROD_OFFER_ID") && !"".equals(arrayOfferId)){ 
					arrayOfferId = arrayOfferId.replace("'", "");
					String[] offerId = arrayOfferId.split(",");
					temp.put("arrayOfferId", offerId);
					temp.put("servCode",temp.get("PROD_OFFER_ID"));
					//temp.put("statusCd","1200");
				}
				temp.put("prodOfferId", temp.get("PROD_OFFER_ID"));
				son =  sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryApiIds", temp) ;
				son2 =  sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.getPricingPlan", temp) ;
				son3 = sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.getSettleAPI",temp);
				
				temp.put("APIs", son);
				temp.put("pricePlan", son2);
				temp.put("settleList", son3);
				father.add(temp);
			}
		}
		return father;
	}
	/**
	 * 查看数据状态
	 * @param mdt_cd
	 * @return
	 */
	@Override
	public String getTypeById(Map map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-autitingorgandapp.getTypeById", map);
	}

	@Override
	public List<Map> getLogLevelList() {
		return sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.getLogLevelList", null) ;
	}
}
