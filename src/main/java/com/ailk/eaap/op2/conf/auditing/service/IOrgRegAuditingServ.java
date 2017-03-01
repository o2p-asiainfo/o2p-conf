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

 
public interface IOrgRegAuditingServ{ 
	public List selectOrg(Org org) ;
	public List<Map> queryOrgInfo(Org orgbean);
	public List<Map> queryOrgInfoList(Map map);
	public List<Map> queryAppApiInfo(Map app);
	public List<Map> queryAppInfo(App app);
	public List<Map> queryProvinceForReg(Org orgBean);
	public List<Map> queryCityForReg(Org orgBean);
	public Integer addOrg(Org orgBean,OrgRole orgRoleBean) ;
 
	public List<ProdOffer> selectProdOffer(ProdOffer prodOffer) ;
	public List<ProdOfferChannelType>  selectProdOfferChannelType(ProdOfferChannelType prodOfferChannelType);
	public List<Map> selectOfferProdRel(OfferProdRel offerProdRel);
	public List<Product>  selectProduct(Product product) ;
	public List<Map> selectAllAttrValueByOfferId(Product product);
	public List<Map>  selectProductAttr(ProductAttr productAttr);
	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer) ;
	public Integer updateProdOffer(ProdOffer prodOffer) ;
	public List<Map>  selectProductAttrInGroup(ProductAttr productAttr);
	public List<Map> selectGroupInfoByProductId(Map map);
	public List<Map> queryPricingClassify(ProdOfferPricing prodOfferPricing);
		
	/** 审批用户注册 **/
	public Integer checkOrgOnline(Org orgBean) ;
	/** 审批应用上线和升级 **/
	public Integer checkAppOnlineOrUpgrade(App appBean) ;
	
	public String getOrgIdByAppId(Map map);
	/**
 	 * 获取主数据信息
 	 * @param mainData
 	 * @return
 	 */
 	public List<MainData> selectMainData(MainData mainData) ;
 	
 	/**
	 * 获取主数据类型信息
	 * @param mainDataType
	 * @return
	 */
	public List<MainDataType> selectMainDataType(MainDataType mainDataType) ;
   
	public List<Map> queryProdDealSvcList(Map map) ;
	
	public List<Org> selectOrgListForLike(Org org);
	
	public Integer insertOrgAuthCode(OrgAuthCode orgAuthCode);
	
	public List<Map> queryPkgList(Map map);
	
	 public  Org queryOrg(Org paramOrg);
	 
	 public  Component selectComponentOne(Component paramComponent);
}
