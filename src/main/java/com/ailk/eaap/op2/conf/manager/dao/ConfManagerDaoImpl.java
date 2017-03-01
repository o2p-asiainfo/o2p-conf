package com.ailk.eaap.op2.conf.manager.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
 

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.AppApiList;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class ConfManagerDaoImpl   implements ConfManagerDao {
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
	
	public List<Map> queryAppApiInfo(Map app){
		if("ALLNUM".equals(String.valueOf(app.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAppApiInfoCount", app) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAppApiInfo", app) ;
		}
		
	}
	public List<Map> queryAppInfo(App app){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingorgandapp.queryAppInfo", app) ;
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
		                
		      sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateAppApiList", appApiList) ;
		      
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingorgandapp.updateApp", appBean) ;
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
		return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectProductAttr", productAttr) ;
		
	}
	public List<Map> selectPricingListByOfferId(ProdOffer prodOffer){
	 	return (ArrayList<Map>)sqlMapDao.queryForList("eaap-op2-conf-pardMix.selectPricingListByOfferId", prodOffer) ;
    }
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}
