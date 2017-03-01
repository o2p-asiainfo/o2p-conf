package com.ailk.eaap.op2.conf.auditing.dao;

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
import com.ailk.eaap.op2.bo.OrgAuthCode;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
 
public interface OrgRegAuditingDao { 
	public List<Map> queryOrgInfo(Org orgbean);
	public List<Map> queryOrgInfoList(Map map);
	public List<Map> queryRoleNum(Org orgbean);
	public List<Map> queryAppApiInfo(Map app);
	public List<Map> queryAppInfo(App app);
	public List<Map> queryProdDealSvcList(Map map);
	public Integer addOrg(Org orgBean,String [] orgRoles);
	public Integer updateRoleCode(Org orgBean,String [] orgRoles);
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer);
	public List<ProdOfferChannelType>  selectProdOfferChannelType(ProdOfferChannelType prodOfferChannelType) ;
	public List<Map> selectOfferProdRel(OfferProdRel offerProdRel) ;
	public List<Product>  selectProduct(Product product) ;
	public List<Map> selectAllAttrValueByOfferId(Product product) ;
	public List<Map>  selectProductAttr(ProductAttr productAttr) ;
	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer) ;
	public Integer updateProdOffer(ProdOffer prodOffer) ;
	/** 审批用户注册 **/
	public Integer checkOrgOnline (Org orgBean) ;
	
	/** 审批应用上线和升级 **/
	public Integer checkAppOnlineOrUpgrade(App appBean);
	public String getOrgIdByAppId(Map map) ;
	public List<Map> queryAuthList(Map map) ;
	public List<Map> queryMainDateTypeList(Map map);
	public Integer updateMainDataType(MainDataType mainDataType) ;
	public Integer updateMainData(MainData mainData) ;
	public String insertMainDataType(MainDataType mainDataType);
	public Integer insertMainData(MainData mainData) ;
	public List<Map>  selectProductAttrInGroup(ProductAttr productAttr);
	public List<Map> selectGroupInfoByProductId(Map map);
	public List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing);
	public List<Map> selectMainDataList(Map map);
	public List<Map> selectSerInvokeInsList(Map map);
	public Integer insertSerInvokeIns(SerInvokeIns serInvokeIns);
	public List<Map>  selectSerInvokeIns(Map map);
	public List<Map>  queryAuthListById(Map map);
	public Integer updateSerInvokeIns(SerInvokeIns serInvokeIns);
	public List<Map> queryProofInfoById(Map map);
	public void deleteProofValues(SerInvokeIns serInvokeIns);
	
	public void deleteProofEffect(SerInvokeIns serInvokeIns);
	
	
	public Integer insertProofEffect(ProofEffect proofEffect);
	
	public Integer insertProofValues(ProofValues proofValues);
	
	public List<Map>  queryCC2cInfoListById(Map map);
	
	
	public Integer insertCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);
	
	
	public Integer updateCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);
	public List<AttrSpec>  selectAtrrSpecListBySpecCode(Map map);
	public List<Map> queryAuthObjAttrListById(Map map);
	
	public Integer insertAuthInfo(Auth auth);
	
	public Integer insertAuthBaseInfo(AuthBase authBase);
	
	public Integer insertAuthObjInfo(AuthObj authObj);
	public Integer updateAuthInfo(Auth auth);
	public Integer updateAuthObjInfo(AuthObj authObj);
	public List<Map> selectMessgeFlowList(MessageFlow messageFlow);
	public List<Org> selectOrgListForLike(Org org);
	
	public Integer insertAuthObjAttr(AuthObjAttr authObjAttr);
	
	public Integer updateAuthObjAttr(AuthObjAttr authObjAttr);
	public List<Map>  quertAttrValuesByProof(Map map);
	public List<Map> queryProdOfferList(Map map) ;
	
	public List<Area> loadCityAreaList(Map paraMap);
	
	public void delCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp);
	public List<Org> validatorOrgInfoExistList(Org org);
	public Integer insertOrgAuthCode(OrgAuthCode orgAuthCode);
	public List<Map> queryPkgList(Map map) ;

	/**
	 * 查看数据状态
	 * @param mdt_cd
	 * @return
	 */
	public String getTypeById(Map map);
	
	public List<Map> getLogLevelList();
	
	//org删除的时候要追加一个判断，如果有添加过产品销售品的话不允许删除
	public String isDeleteByOffer(Map map);
	public String isDeleteByProduct(Map map);
}
