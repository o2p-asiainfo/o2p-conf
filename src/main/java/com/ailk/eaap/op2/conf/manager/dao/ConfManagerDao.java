package com.ailk.eaap.op2.conf.manager.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
 
public interface ConfManagerDao { 
	public List<Map> queryOrgInfo(Org orgbean);
	public List<Map> queryOrgInfoList(Map map);
	public List<Map> queryAppApiInfo(Map app);
	public List<Map> queryAppInfo(App app);
	public List<Map> queryProdDealSvcList(Map map);
 
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
}
