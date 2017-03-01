package com.ailk.eaap.op2.conf.pricing.action;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

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
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.adapter.util.DataInteractiveUtil;
import com.ailk.eaap.op2.conf.pricing.service.IServicePricingServ;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.bo.UserRoleInfo;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class ServicePricingAction extends BaseAction{
  
	private static final long serialVersionUID = 1L;
	private IServicePricingServ servicePricingServ;
	private List<Map> packageList;
	private List<Map> serviceList;
	private Map orgStateMap = new HashMap() ;
	private List<Map> orgStateList;
	private List<Map> selectOrgTypeList = new ArrayList<Map>() ;
	private List<Map> selectRoleList;
	private List<Map> selServiceList;
	private String packageName;
	private ProdOffer prodOffer = new ProdOffer();
	private Map searchMap = new HashMap();
	public ProdOfferPricing prodOfferPricing = new ProdOfferPricing();
	public PricingTarget pricingTarget = new PricingTarget();
	public OfferProdRelPricing offerProdRelPricing = new OfferProdRelPricing();
	public List<OfferProdRelPricing> offerProdRelPricingList = new ArrayList<OfferProdRelPricing>();

	
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
	private int rows;
	private int pageNum;
	private int total;
	private String serviceIds;
	private String prodIds;
	private String defaultName;
	private String actionType;
	private String state;
	private String serviceId;
	private Logger log = Logger.getLog(this.getClass());
	private List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
	private String pricingTargetId;
 
	private String pricingInfoId;
	private PricingPlan pricingPlan = new PricingPlan();
	private String offerId;
	private String serviceNames;
	private List<Map> pricePlanList = new ArrayList<Map>();
	JSONObject json = new JSONObject();
	HashMap<String,String> retMap = new HashMap<String,String>();
	private String ordType="";
	private String portalUrl = "";
	private String frontEndUrl="";
	
	
	public String servicePricingList(){
		//Map map =new HashMap();
		
		//map.put("ORG_ID", "800000003");
		Map hashMap1 = new HashMap();
        hashMap1.put("name", getText("eaap.op2.conf.server.manager.serviceEnable"));
        hashMap1.put("componentId", "D");
        Map hashMap2 = new HashMap();
        hashMap2.put("name", getText("eaap.op2.conf.server.manager.serviceDisable"));
        hashMap2.put("componentId", "N");
        
        resultList.add(hashMap1);
        resultList.add(hashMap2);
        
		Map  map1 = new HashMap();
		map1.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.useriscomp"));
		map1.put("orgTypeCode", "1");
		
		Map  map2 = new HashMap();
		map2.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisperson"));
		map2.put("orgTypeCode", "2");
		
		Map  map3 = new HashMap();
		map3.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisother"));
		map3.put("orgTypeCode", "0");
		
		selectOrgTypeList.add(map1) ;
		selectOrgTypeList.add(map2) ;
		selectOrgTypeList.add(map3) ;
		return SUCCESS;
	}
	
	/**
	 * select package
	 */
	public Map getPackageList(Map para){

		
		  
		Map returnMap = new HashMap();
		try{
			rows = pagination.getRows();
			pageNum = pagination.getPage();
			int startRow;
			 
			startRow = (pageNum - 1) * rows + 1;
	
			 //String tmpOrgTypeCode ="" ;
			// String tmpState ="" ;
			 Map map = new HashMap() ;
   
	 
			 //map.put("ORG_ID", "800000003");
			 map.put("queryType", "ALLNUM") ;
			 String pkgName = getRequest().getParameter("packageName");
			 String serId = getRequest().getParameter("serviceId");
			 String st = getRequest().getParameter("state");
			 if(!"".equals(pkgName)&&null!=pkgName){
				 map.put("PROD_OFFER_NAME", pkgName);
			 }
			 if(!"".equals(st)&&null!=st){
				 map.put("STATE", st);
				 
			 }
			 if(!"".equals(serId)&&null!=serId){
				 map.put("SERVICE_ID", serId);
				List<Map> offers = getServicePricingServ().getOffersIds(map);
				if(offers.size()>0){
					Map temp ;
					String offerIds = "";
					StringBuffer bf = new StringBuffer();
					for(int i =0;i<offers.size();i++){
						temp = offers.get(i);
						//offerIds += temp.get("PROD_OFFER_ID")+",";
						bf.append(temp.get("PROD_OFFER_ID")).append(",");
					}
					offerIds = bf.toString();
					map.put("offerIds", offerIds);
				}
				 
				 
			 }
			 String tmpOrgTypeCode ="" ;
			 String tmpState ="" ;  
			 String [] orgTypeCodes =getRequest().getParameterValues("orgTypeCodes");
			 if(orgTypeCodes!=null && orgTypeCodes.length>=1){
				 for(String orgTypeCode:orgTypeCodes){
					 tmpOrgTypeCode+=orgTypeCode + ",";
				 }
				 tmpOrgTypeCode = tmpOrgTypeCode.substring(0,tmpOrgTypeCode.length()-1);
				 map.put("ORG_TYPE", tmpOrgTypeCode);
			 }
			 
			 List<Map> tmpOrgList1 = getServicePricingServ().queryPackage(map);
			 total = Integer.valueOf(String.valueOf(tmpOrgList1.get(0).get("ALLNUM"))) ;
		     map.put("queryType", "") ;
		     map.put("pro", startRow);
		     map.put("end", startRow+rows-1);
		         
		     map.put("pro_mysql", (pageNum - 1) * rows);
			 map.put("page_record", rows);
	  
			List<Map> packageList=getServicePricingServ().queryPackage(map);
		    
		    
			returnMap.put("startRow", startRow);
			returnMap.put("rows", rows); 	
			returnMap.put("total", total);
			returnMap.put("dataList", page.convertJson(packageList));
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"getPackageList exception",null));
		}
		return returnMap;
	
	}
	
	
    /**
     * add package
     */
	public String servicePricingPkg(){
		
		
		return SUCCESS;
	}
	public String selectService(){
		
		return SUCCESS;
	}
	public String addServicePricing(){
		return SUCCESS;
	}
	public String addservicePkg(){
		// insert prod_offer
		String provider ="";
		provider = WebPropertyUtil.getPropertyValue("O2P_PROVIDER_ID");//从公共配置文件“eaap_common.properties”中读取消OTP组件ID  
		
		prodOffer= new ProdOffer();
		prodOffer.setProdOfferName(packageName);
		//prodOffer.setOfferProviderId(componentId);3
		prodOffer.setStatusCd("1000") ;
		prodOffer.setCooperationType("13");
		//effDate,expDate
		Date efftime = new Date(); 
		String exptime = "2099-01-01"; 
		try {
			prodOffer.setEffDate(efftime) ;
			prodOffer.setExpDate("".equals(StringUtil.valueOf(prodOffer.getFormatExpDate()))?null:DateUtil.stringToDate(prodOffer.getFormatExpDate().replace("-","/"), "yyyy/MM/dd")) ;
		} catch (ParseException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null)); 
		}
		prodOffer.setOfferProviderId(provider);
		BigDecimal offId =getServicePricingServ().insertProdOffer(prodOffer);
		prodOffer.setProdOfferId(offId); 
		 
		HashMap map = new HashMap();
		if(serviceIds!=null){ 
			String []serIds = serviceIds.split(",");
			map.put("service", serIds);
		}
//		List services = getServicePricingServ().queryService(map);
		List services = getServicePricingServ().querySelectedService(map);
    
		//String userId = StringUtil.valueOf("800000003");
		if(services.size()>0){
			serviceList= services;
			BigDecimal con;
			OfferProdRel offerProdRel = new OfferProdRel();
			for(int i=0;i<services.size();i++){
				Product pro = new Product();
				HashMap temp = (HashMap)services.get(i);
				/*查看这个服务是否已经是产品*/
				con = getServicePricingServ().getProductbyCap(temp);
				
				pro.setProductName(StringUtil.valueOf(temp.get("CNNAME")));
				pro.setProductNbr(StringUtil.valueOf(temp.get("SERVICEID")));
				//pro.setProductProviderId(Integer.parseInt(userId));
				pro.setStatusCd("1000");
				pro.setCooperationType("13");
				BigDecimal newProuctId;
                if(null!=con){
                	newProuctId =con;
				}else {
					newProuctId = getServicePricingServ().insertProduct(pro); 
					//插入服务产品关系表SERVICE_PRODUCT_REAL
					temp.put("PRODUCT_ID", newProuctId); 
					getServicePricingServ().insertServiceProRel(temp);
				}
				
				offerProdRel.setProductId(newProuctId);
				offerProdRel.setProdOfferId(offId);
				int relaId = getServicePricingServ().insertOfferProdRel(offerProdRel);
				
			}
		}
		
		ordType ="add";
		//showAbilityList = getServicePricingServ().showAbility(componentId);	
		//showPackageList = getServicePricingServ().showPackage(componentId);	
		 
		return SUCCESS;
	}
	
	public String servicePkgDetail(){
		String aa = ordType;
		prodOffer = new ProdOffer();
		Map map = new HashMap();
		map.put("offerIds", offerId );
		map.put("prodOfferId", offerId);
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(offerId)));
		//prodOfferId
		List<Map> tmpOrgList1 = getServicePricingServ().queryPackage(map);
		if(tmpOrgList1.size()>0){
			Map temp = tmpOrgList1.get(0);
			prodOffer.setProdOfferName((String)temp.get("PACKAGENAME"));
			serviceNames = (String)temp.get("PRODUCTS");
		}
		pricePlanList = getServicePricingServ().getPricingPlan(map);
		
		return SUCCESS;
	}
	/**
	 * add price plan
	 */
	public void addPricePlan(){
		 
		HttpServletResponse response = getResponse() ; 
		try {
			
			String tenantCode = null;
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId =CommonUtil.getTenantId(session);
			if(tenantId != null ){
				Tenant  tenant = new Tenant();
				tenant.setTenantId(Integer.valueOf(tenantId));
				tenant = getServicePricingServ().queryTenant(tenant);
				tenantCode=  tenant.getCode(); 
			}
			String regex="\\u0024\\u002EtenantCode";
		  
		    
			frontEndUrl= WebPropertyUtil.getPropertyValue("frontEnd_url");//从公共配置文件“eaap_common.properties”中读取
			frontEndUrl = frontEndUrl.replaceAll(regex,tenantCode);
			frontEndUrl = frontEndUrl+"/provider/toPricePlan.shtml?prodOfferId="+prodIds+"&defaultName="+defaultName;			
			response.sendRedirect(frontEndUrl);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}
	
	/**
	 *  price plan detail  modify
	 */
	public void goPricePlan(){
	
		 
		HttpServletResponse response = getResponse() ; 
		try {
			
			String tenantCode = null;
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId =CommonUtil.getTenantId(session);
			if(tenantId != null ){
				Tenant  tenant = new Tenant();
				tenant.setTenantId(Integer.valueOf(tenantId));
				tenant = getServicePricingServ().queryTenant(tenant);
				tenantCode=  tenant.getCode(); 
			}
			String regex="\\u0024\\u002EtenantCode";
		  
		    
			frontEndUrl= WebPropertyUtil.getPropertyValue("frontEnd_url");//从公共配置文件“eaap_common.properties”中读取
			frontEndUrl = frontEndUrl.replaceAll(regex,tenantCode);
			
			frontEndUrl = frontEndUrl+"/provider/toPricePlan.shtml?actionType="+actionType+"&pricingInfoId="+pricingPlan.getPricingInfoId()+"&pricingTargetId="+pricingTargetId+"&prodOfferId="+prodIds+
					"&defaultName="+defaultName;
			response.sendRedirect(frontEndUrl);


		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
	}	 
 /**
  * 
  * delPricePlan:(这里用一句话描述这个方法的作用). <br/> 
  * TODO(这里描述这个方法适用条件 – 可选).<br/> 
  * TODO(这里描述这个方法的执行流程 – 可选).<br/> 
  * TODO(这里描述这个方法的使用方法 – 可选).<br/> 
  * TODO(这里描述这个方法的注意事项 – 可选).<br/> 
  * 
  * @author m 
  * @return 
  * @since JDK 1.6
  */
	public String delPricePlan(){
		String priceInfoId = getRequest().getParameter("priceInfoId");
		String prodOfferId = getRequest().getParameter("prodOfferId");
		String pricingTargetId = getRequest().getParameter("pricingTargetId");
		
		if(!"".equals(priceInfoId)&&null!=priceInfoId&&!"".equals(prodOfferId)&&null!=prodOfferId&&!"".equals(pricingTargetId)&&null!=pricingTargetId){
			pricingPlan.setPricingInfoId(Integer.parseInt(priceInfoId));
			pricingPlan.setStatusCd("11");
			this.getServicePricingServ().updatePricingPlan(pricingPlan);
			
			prodOfferPricing.setPricingInfoId(Integer.parseInt(priceInfoId));
			prodOfferPricing.setProdOfferId(BigDecimal.valueOf(Long.valueOf(prodOfferId)));
			prodOfferPricing = this.getServicePricingServ().queryProdOfferPricing(prodOfferPricing).get(0);
			prodOfferPricing.setStatusCd("11");
			this.getServicePricingServ().updateProdOfferPricing(prodOfferPricing);
			
			pricingTarget.setPricingTargetId(Integer.parseInt(pricingTargetId));
			pricingTarget.setStatusCd("11");
			this.getServicePricingServ().updatePricingTarget(pricingTarget);
			
			offerProdRelPricing.setPricingInfoId(Integer.parseInt(pricingTargetId));
			offerProdRelPricingList = this.getServicePricingServ().queryOfferProdRelPricing(offerProdRelPricing);
			for(OfferProdRelPricing o : offerProdRelPricingList){
				o.setStatusCd("11");
				this.getServicePricingServ().updateProdRelPricing(o);
			}
		}
		json.putAll(retMap);
		try {
			DataInteractiveUtil.actionResponsePage(getResponse(), json);
		} catch (Exception e) {
			// TODO Auto-generated catch block
	    	log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return NONE;
	}
 
	/**
	 * delete package(OFFER)
	 */
	public void delServicePkg(){
		String pkgId = this.getRequest().getParameter("pkgId");
 
		HashMap temp = new HashMap(); 
		if(!"".equals(pkgId)&&null!=pkgId){
			temp.put("prodOfferId", pkgId); 
			prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(pkgId)));
			prodOffer.setStatusCd("1300");
			getServicePricingServ().updateProdOffer(prodOffer);
			//获取offer 下api 然后 状态置为D
			  
		}

	}
	/**
	 * submit price plan
	 */
	public IServicePricingServ getServicePricingServ() {
		if(servicePricingServ==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			servicePricingServ = (IServicePricingServ)ctx.getBean("eaap-op2-conf-pricing-servicePricingService");
     }
		return servicePricingServ;
	}
	public void setServicePricingServ(IServicePricingServ servicePricingServ) {
		this.servicePricingServ = servicePricingServ;
	}



	public List<Map> getPackageList() {
		return packageList;
	}



	public void setPackageList(List<Map> packageList) {
		this.packageList = packageList;
	}
	
	
	public Map getOrgStateMap() {
		return orgStateMap;
	}



	public void setOrgStateMap(Map orgStateMap) {
		this.orgStateMap = orgStateMap;
	}



	public List<Map> getOrgStateList() {
		return orgStateList;
	}



	public void setOrgStateList(List<Map> orgStateList) {
		this.orgStateList = orgStateList;
	}



	public List<Map> getSelectOrgTypeList() {
		return selectOrgTypeList;
	}



	public void setSelectOrgTypeList(List<Map> selectOrgTypeList) {
		this.selectOrgTypeList = selectOrgTypeList;
	}



	public List<Map> getSelectRoleList() {
		return selectRoleList;
	}



	public void setSelectRoleList(List<Map> selectRoleList) {
		this.selectRoleList = selectRoleList;
	}



	public List<Map> getSelServiceList() {
		return selServiceList;
	}



	public void setSelServiceList(List<Map> selServiceList) {
		this.selServiceList = selServiceList;
	}



	public String getPackageName() {
		return packageName;
	}



	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}



	public Map getSearchMap() {
		return searchMap;
	}



	public void setSearchMap(Map searchMap) {
		this.searchMap = searchMap;
	}



	public ProdOffer getProdOffer() {
		return prodOffer;
	}



	public void setProdOffer(ProdOffer prodOffer) {
		this.prodOffer = prodOffer;
	}



	public String getServiceIds() {
		return serviceIds;
	}

	public void setServiceIds(String serviceIds) {
		this.serviceIds = serviceIds;
	}

	public List<Map> getServiceList() {
		return serviceList;
	}

	public void setServiceList(List<Map> serviceList) {
		this.serviceList = serviceList;
	}

	public String getProdIds() {
		return prodIds;
	}

	public void setProdIds(String prodIds) {
		this.prodIds = prodIds;
	}

	public String getDefaultName() {
		return defaultName;
	}

	public void setDefaultName(String defaultName) {
		this.defaultName = defaultName;
	}

	public String getActionType() {
		return actionType;
	}

	public void setActionType(String actionType) {
		this.actionType = actionType;
	}

	public List<Map<String, Object>> getResultList() {
		return resultList;
	}

	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getPricingTargetId() {
		return pricingTargetId;
	}

	public void setPricingTargetId(String pricingTargetId) {
		this.pricingTargetId = pricingTargetId;
	}

	 

	public String getPricingInfoId() {
		return pricingInfoId;
	}

	public void setPricingInfoId(String pricingInfoId) {
		this.pricingInfoId = pricingInfoId;
	}

	public PricingPlan getPricingPlan() {
		return pricingPlan;
	}

	public void setPricingPlan(PricingPlan pricingPlan) {
		this.pricingPlan = pricingPlan;
	}

	
	public String getOfferId() {
		return offerId;
	}

	public void setOfferId(String offerId) {
		this.offerId = offerId;
	}

	public String getServiceNames() {
		return serviceNames;
	}

	public void setServiceNames(String serviceNames) {
		this.serviceNames = serviceNames;
	}

	public List<Map> getPricePlanList() {
		return pricePlanList;
	}

	public void setPricePlanList(List<Map> pricePlanList) {
		this.pricePlanList = pricePlanList;
	}

	public ProdOfferPricing getProdOfferPricing() {
		return prodOfferPricing;
	}

	public void setProdOfferPricing(ProdOfferPricing prodOfferPricing) {
		this.prodOfferPricing = prodOfferPricing;
	}

	public PricingTarget getPricingTarget() {
		return pricingTarget;
	}

	public void setPricingTarget(PricingTarget pricingTarget) {
		this.pricingTarget = pricingTarget;
	}

	public OfferProdRelPricing getOfferProdRelPricing() {
		return offerProdRelPricing;
	}

	public void setOfferProdRelPricing(OfferProdRelPricing offerProdRelPricing) {
		this.offerProdRelPricing = offerProdRelPricing;
	}

	public List<OfferProdRelPricing> getOfferProdRelPricingList() {
		return offerProdRelPricingList;
	}

	public void setOfferProdRelPricingList(
			List<OfferProdRelPricing> offerProdRelPricingList) {
		this.offerProdRelPricingList = offerProdRelPricingList;
	}

	public String getOrdType() {
		return ordType;
	}

	public void setOrdType(String ordType) {
		this.ordType = ordType;
	}

	public Map getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map stateMap = new HashMap() ;
	  	
	  	  mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = getServicePricingServ().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
			  List<MainData> mainDataList = getServicePricingServ().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }

	
 
}
