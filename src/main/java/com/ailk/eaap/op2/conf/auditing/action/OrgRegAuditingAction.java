package com.ailk.eaap.op2.conf.auditing.action;
 
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;
import java.util.Properties;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.security.SecurityUtil;
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
import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.pushc.PushTargetList;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.IBusiDataInfoServ;
import com.ailk.eaap.op2.conf.auditing.service.IOrgRegAuditingServ;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.PushCInvokeUtils;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;
import com.workflow.engine.activity.ActivityInstance;
import com.workflow.engine.process.ProcessInstance;
import com.workflow.remote.WorkflowRemoteInterface;
import com.ailk.eaap.op2.conf.message.service.MessageServ;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.conf.util.RegActivationSendMailUtil;
import com.ailk.eaap.op2.loginFilter.bo.UserInfo;
import com.alibaba.fastjson.JSONObject;

public class OrgRegAuditingAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7598604688747931946L;
	private Logger log = Logger.getLog(this.getClass());
	private String activity_Id ;
	private String content_Id ;
	private String process_Id ;
	private String process_Model_Id ;
    private IOrgRegAuditingServ orgRegAuditingServ ;
    private MessageServ messageServ;
	private IBusiDataInfoServ busiDataInfoServ;
    private Map orgInfoMap = new HashMap() ;
    private Map appInfoMap = new HashMap() ;
    private String checkState ;
    private String checkDesc ;
    private String pushMessageType;
    private String pushc_url;
    private List<Map> appApiInfoList = new ArrayList<Map>() ;
	private Org org = new Org() ;
	private OrgRole orgRole = new OrgRole() ;
	private App app = new App() ;
    private Pagination page=new Pagination();
    private List<Map> orgInfoList = new ArrayList<Map>() ;
    private List<Map> orgStateList = new ArrayList<Map>() ;
    private Map orgStateMap = new HashMap() ;
    private Map cardTypeMap= new HashMap() ;
    private String tmpType ;
    private List<Map> cityList = new ArrayList<Map>() ;
	private List<Map> provinceList = new ArrayList<Map>() ;
	private ProdOffer  prodOffer = new ProdOffer();
	private OfferProdRel offerProdRel = new OfferProdRel();
	private List<Map> provServiceList = new ArrayList<Map>() ;
	private ProdOfferChannelType prodOfferChannelType = new ProdOfferChannelType() ;
	private Map prodChannelMap = new HashMap() ;
	private List<ProdOfferChannelType> prodOfferChannelTypeList = new ArrayList<ProdOfferChannelType>() ;
    private Product   product = new Product() ;
	private ProductAttr productAttr = new ProductAttr() ;
	private List<Map> productAttrList = new ArrayList<Map>() ;
	private List<Product> chooseProdOardList = new ArrayList<Product>() ;
	private List<Map> pricingList = new ArrayList<Map>() ;
	private ProdOfferPricing prodOfferPricing = new ProdOfferPricing() ;
	private List<Map> commissionPlanList = new ArrayList<Map>() ;
	private String pageShowMsg;
	
	private String regActivationResult;
	private OrgAuthCode orgAuthCode = new OrgAuthCode();
	
	private List<Map> appPkgInfoList = new ArrayList<Map>() ;
	
	public MessageServ getMessageServ() {
		if(messageServ==null){
            //取得spring上下文
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// 取得spring bean实例
			messageServ = (MessageServ)ctx.getBean("eaap-op2-conf-message-messageServ");
	     }
		return messageServ;
	}
	public void setMessageServ(MessageServ messageServ) {
		this.messageServ = messageServ;
	}
	
 	public List<Map> getAppPkgInfoList() {
		return appPkgInfoList;
	}

	public void setAppPkgInfoList(List<Map> appPkgInfoList) {
		this.appPkgInfoList = appPkgInfoList;
	}

	public List<Map> getCityList() {
		return cityList;
	}

	public void setCityList(List<Map> cityList) {
		this.cityList = cityList;
	}

	public List<Map> getProvinceList() {
		return provinceList;
	}

	public void setProvinceList(List<Map> provinceList) {
		this.provinceList = provinceList;
	}

	public Map getOrgStateMap() {
		return orgStateMap;
	}

	public void setOrgStateMap(Map orgStateMap) {
		this.orgStateMap = orgStateMap;
	}

	
	public Map getCardTypeMap() {
		return cardTypeMap;
	}
	public void setCardTypeMap(Map cardTypeMap) {
		this.cardTypeMap = cardTypeMap;
	}
	public OrgRegAuditingAction() {
		
		
	}
	
	public String queryOrgInfo(){
		orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		cardTypeMap=getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG_CERT_TYPE) ;
		org.setOrgId(Integer.valueOf(content_Id)) ;
	    orgInfoMap = getOrgRegAuditingServ().queryOrgInfo(org).get(0) ;
	    pushc_url=WebPropertyUtil.getPropertyValue("pushc_url");
	    Map orgTypeNameMap = new HashMap();
		orgTypeNameMap.put("0", getText("eaap.op2.conf.orgregauditing.userisother"));
		orgTypeNameMap.put("1", getText("eaap.op2.conf.orgregauditing.useriscomp"));
		orgTypeNameMap.put("2", getText("eaap.op2.conf.orgregauditing.userisperson"));
		
		Map certTypeNameMap = new HashMap();
		certTypeNameMap.put("1", getText("eaap.op2.conf.manager.auth.cardtypeisider"));
		certTypeNameMap.put("2", getText("eaap.op2.conf.manager.auth.cardtypeiscom"));
		
		 Map partnerTypeNameMap = new HashMap();
		 partnerTypeNameMap.put("1", getText("eaap.op2.conf.orgregauditing.partnerTypeForNormalPartner"));
		 partnerTypeNameMap.put("2", getText("eaap.op2.conf.orgregauditing.partnerTypeForOperator"));
		
		if (orgInfoMap.get("ORG_TYPE_CODE") != null) {
			orgInfoMap.put("ORGTYPENAME", orgTypeNameMap.get(orgInfoMap.get("ORG_TYPE_CODE")));
		}
		if (orgInfoMap.get("CERT_TYPE_CODE") != null) {
			orgInfoMap.put("CERTTYPENAME", certTypeNameMap.get(orgInfoMap.get("CERT_TYPE_CODE")));
		}
		
		if (orgInfoMap.get("CERT_TYPE_CODE") != null) {
			orgInfoMap.put("CARDTYPENAME", cardTypeMap.get(orgInfoMap.get("CERT_TYPE_CODE")));
		}
		
		if(orgInfoMap.get("PARTNER_TYPE")!=null){
			orgInfoMap.put("PARTNERTYPENAME", partnerTypeNameMap.get(orgInfoMap.get("PARTNER_TYPE")));
		}
	    //解密操作
		if(null != orgInfoMap.get("EMAIL") && !"".equals(String.valueOf(orgInfoMap.get("EMAIL")))){
			String email = "";
			try{
				email = SecurityUtil.getInstance().decryMsg(String.valueOf(orgInfoMap.get("EMAIL")));
				if(null == email || "".equals(email)){
					email = String.valueOf(orgInfoMap.get("EMAIL"));
				}
			} catch(Exception e){
				email = String.valueOf(orgInfoMap.get("EMAIL"));
			}
			orgInfoMap.put("EMAIL", email);
		}
		//副邮箱
		if(null != orgInfoMap.get("SUB_EMAIL") && !"".equals(String.valueOf(orgInfoMap.get("SUB_EMAIL")))){
			String subEmail = "";
			try{
				subEmail = SecurityUtil.getInstance().decryMsg(String.valueOf(orgInfoMap.get("SUB_EMAIL")));
				if(null == subEmail || "".equals(subEmail)){
					subEmail = String.valueOf(orgInfoMap.get("SUB_EMAIL"));
				}
			} catch(Exception e){
				subEmail = String.valueOf(orgInfoMap.get("SUB_EMAIL"));
			}
			orgInfoMap.put("SUB_EMAIL", subEmail);
		}
		
		if(null != orgInfoMap.get("TELEPHONE") && !"".equals(String.valueOf(orgInfoMap.get("TELEPHONE")))){
			String telephone = "";
			try{
				telephone = SecurityUtil.getInstance().decryMsg(String.valueOf(orgInfoMap.get("TELEPHONE")));
				if(null == telephone || "".equals(telephone)){
					telephone = String.valueOf(orgInfoMap.get("TELEPHONE"));
				}
			} catch(Exception e){
				telephone = String.valueOf(orgInfoMap.get("TELEPHONE"));
			}
			orgInfoMap.put("TELEPHONE", telephone);
		}
		//副号码
		if(null != orgInfoMap.get("SUB_TELEPHONE") && !"".equals(String.valueOf(orgInfoMap.get("SUB_TELEPHONE")))){
			String subTelephone = "";
			try{
				subTelephone = SecurityUtil.getInstance().decryMsg(String.valueOf(orgInfoMap.get("SUB_TELEPHONE")));
				if(null == subTelephone || "".equals(subTelephone)){
					subTelephone = String.valueOf(orgInfoMap.get("SUB_TELEPHONE"));
				}
			} catch(Exception e){
				subTelephone = String.valueOf(orgInfoMap.get("SUB_TELEPHONE"));
			}
			orgInfoMap.put("SUB_TELEPHONE", subTelephone);
		}
		if(null != orgInfoMap.get("CERT_NUMBER") && !"".equals(String.valueOf(orgInfoMap.get("CERT_NUMBER")))){
			String cardNum = "";
			try{
				cardNum = SecurityUtil.getInstance().decryMsg(String.valueOf(orgInfoMap.get("CERT_NUMBER")));
				if(null == cardNum || "".equals(cardNum)){
					cardNum = String.valueOf(orgInfoMap.get("CERT_NUMBER"));
				}
			} catch(Exception e){
				cardNum = String.valueOf(orgInfoMap.get("CERT_NUMBER"));
			}
			orgInfoMap.put("CERT_NUMBER", cardNum);
		}
	    if("info".equals(tmpType)){
	    	return "successtoinfo" ;
	    }else if("edit".equals(tmpType)){
	    	cityList = getOrgRegAuditingServ().queryCityForReg(org) ;
			provinceList = getOrgRegAuditingServ().queryProvinceForReg(org) ;
			return "successtoedit" ;
	    }else{
	    	return SUCCESS ;
	    }
		
	}
	
	
	public String queryAppInfo(){
		Map tmpMap = new HashMap() ;
	    tmpMap.put("appId", Integer.valueOf(content_Id)) ;
		 if(getSelectPerPage("page")==-1){
	         page.setPageRecord(2);
	         }else{
	         page.setPageRecord(getSelectPerPage("page"));
	         }
	         //判断是否是第1次查询
	         if(getQueryFlag("page")==-1){ 
	        	 tmpMap.put("queryType", "ALLNUM") ;
	        	 page.setTotalRecord(Integer.valueOf(String.valueOf( getOrgRegAuditingServ().queryAppApiInfo(tmpMap).get(0).get("ALLNUM")))); //page.setTotalRecord(testFacade.selectMenuInfoCount(para));
	         }else{
	             page.setTotalRecord(getQueryFlag("page"));
	         }
	         //设置查询条件
	         setPageParameters(page,"page");

	         tmpMap.put("pro", page.getPageStart());
	         tmpMap.put("end", page.getPageEnd());
	         tmpMap.put("queryType", "query") ;
	        
	         if (page.getPageStart() < 0) {
	        	 tmpMap.put("pro_mysql", 0);
	         } else {
	        	 tmpMap.put("pro_mysql", page.getPageStart());
	         }
	         if (page.getPageEnd() - page.getPageStart() + 1 < 0) {
	        	 tmpMap.put("page_record", 0);
	         } else {
	        	 tmpMap.put("page_record", page.getPageEnd() - page.getPageStart() + 1);
	         }
	         
	   
		app.setAppId(Integer.valueOf(content_Id)) ;
		
		appInfoMap = getOrgRegAuditingServ().queryAppInfo(app).get(0) ;
		appPkgInfoList = getOrgRegAuditingServ().queryPkgList(tmpMap);
		org.setOrgId(Integer.valueOf(String.valueOf(appInfoMap.get("APP_DEVE")))) ;
	    orgInfoMap = getOrgRegAuditingServ().queryOrgInfo(org).get(0) ;
	    pushc_url=WebPropertyUtil.getPropertyValue("pushc_url");
		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		try{
			ProcessInstance processInstance =wi.getProcessInstance(process_Id);
			process_Model_Id = processInstance.getProcess_Model_Id();
		}catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"queryAppInfo:"+e.getMessage(),null));
		}
	    return SUCCESS ;
	}
	 
	/**
	 * 融合销售品详情
	 * @return
	 */
	public String showProdOffer(){
		
		Map map = new HashMap() ;
	    
		map.put("orgId", 800000003) ;
		/**遍历当前用户提供的服务**/
		provServiceList = getOrgRegAuditingServ().queryProdDealSvcList(map) ;
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id)));
		
		 List<Map> prodeTmpAttrValueList = new ArrayList<Map>() ;
		 String urlString = SUCCESS ;
		 
		 List<Map>  tmpOffProdRel = new ArrayList();
		 orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		 prodChannelMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_PRODCHANNELTYPE) ;
		 prodOffer = getOrgRegAuditingServ().selectProdOffer(prodOffer).get(0) ;
		 offerProdRel.setProdOfferId(prodOffer.getProdOfferId()) ;
		 
		 prodOfferChannelType.setProdOfferId(prodOffer.getProdOfferId()) ;
		 prodOfferChannelTypeList = getOrgRegAuditingServ().selectProdOfferChannelType(prodOfferChannelType) ;
		 tmpOffProdRel = getOrgRegAuditingServ().selectOfferProdRel(offerProdRel);
		 for(int j=0;j<tmpOffProdRel.size() ;j++){
			 product.setProductId(BigDecimal.valueOf(Long.valueOf(tmpOffProdRel.get(j).get("PRODUCT_ID").toString()))) ;
			 
			 List<Product> productList = getOrgRegAuditingServ().selectProduct(product) ;
			 for(int i=0;i<productList.size() ;i++){
				 Map  myTmpMap = new HashMap() ;
				  if("10".equals(((Product)productList.get(i)).getCooperationType())
						   ||("11".equals(((Product)productList.get(i)).getCooperationType())
								   &&!String.valueOf(prodOffer.getOfferProviderId()).equals(StringUtil.valueOf(((Product)productList.get(i)).getProductProviderId())))){
					    List<Map> myTmpproductAttrList = new ArrayList<Map>() ;
					    List<Map> myTmpCheckBoxValueList = new ArrayList<Map>() ; 
					   prodeTmpAttrValueList = getOrgRegAuditingServ().selectAllAttrValueByOfferId((Product)productList.get(i)) ;
					   productAttr.setProductId(((Product)productList.get(i)).getProductId()) ;
					   myTmpproductAttrList = getOrgRegAuditingServ().selectProductAttr(productAttr) ;
					   myTmpMap.put("prodyys",(Product)productList.get(i)) ;
					   myTmpMap.put("prodattr", myTmpproductAttrList) ;
					   myTmpMap.put("myAttrValueList", prodeTmpAttrValueList) ;
					   
					   for(int h=0;h<myTmpproductAttrList.size();h++){
							if("12".equals(myTmpproductAttrList.get(h).get("DISPLAY_TYPE").toString())){
								 if(myTmpproductAttrList.get(h).get("DEFAULT_VALUE")!=null&&myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().length()>0){
									 for(int m=0;m<myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().split(",").length;m++){
										 Map myMapTmp = new HashMap() ;
										 myMapTmp.put("ATTR_SPEC_ID", myTmpproductAttrList.get(h).get("ATTR_SPEC_ID").toString()) ;
										 myMapTmp.put("PRODUCT_ATTR_ID", myTmpproductAttrList.get(h).get("PRODUCT_ATTR_ID").toString()) ;
										 myMapTmp.put("DEFAULT_VALUE", myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().split(",")[m]) ;
										 for(int k=0;k<prodeTmpAttrValueList.size();k++){
											 if(prodeTmpAttrValueList.get(k).get("ATTR_VALUE_ID").toString().equals(myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().split(",")[m])){
												 myMapTmp.put("ATTR_VALUE_NAME", prodeTmpAttrValueList.get(k).get("ATTR_VALUE_NAME").toString()) ;
											 }
										 }
										 myTmpCheckBoxValueList.add(myMapTmp) ;                                                                 
									 }
								 }
							}
						 }
					   
					   myTmpMap.put("checkBoxValueList", myTmpCheckBoxValueList) ;
					   productAttrList.add(myTmpMap) ;
				    }else if("11".equals(((Product)productList.get(i)).getCooperationType())&&String.valueOf(prodOffer.getOfferProviderId()).equals(StringUtil.valueOf(((Product)productList.get(i)).getProductProviderId()))){
					  chooseProdOardList.add((Product)productList.get(i)) ;
				  }
			  }
		  }
		 pricingList = getOrgRegAuditingServ().selectPricingListByOfferId(prodOffer) ;
		 
		prodOffer.setFormatEffDate("".equals(StringUtil.valueOf(prodOffer.getEffDate()))?null:DateUtil.convDateToString(prodOffer.getEffDate(), "yyyy-MM-dd")) ;
		prodOffer.setFormatExpDate("".equals(StringUtil.valueOf(prodOffer.getEffDate()))?null:DateUtil.convDateToString(prodOffer.getExpDate(), "yyyy-MM-dd")) ;
			 
			
		 return urlString ;
	}
	
	public String showProdOfferInfo(){
		
         Map map = new HashMap() ;
         map.put("orgId", 800000003) ;
		/**遍历当前用户提供的服务**/
		provServiceList = getOrgRegAuditingServ().queryProdDealSvcList(map) ;
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id))) ;
		 
		
		 List<Map> prodeTmpAttrValueList = new ArrayList<Map>() ;
		 String urlString = SUCCESS ;
		 if("show".equals(StringUtil.valueOf(tmpType))){
			 urlString = "successToShow" ;
		 }
		 List<Map>  tmpOffProdRel = new ArrayList();
		 orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		 prodChannelMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_PRODCHANNELTYPE) ;
		 prodOffer = getOrgRegAuditingServ().selectProdOffer(prodOffer).get(0) ;
		 offerProdRel.setProdOfferId(prodOffer.getProdOfferId()) ;
		 
		 prodOfferChannelType.setProdOfferId(prodOffer.getProdOfferId()) ;
		 prodOfferChannelTypeList = getOrgRegAuditingServ().selectProdOfferChannelType(prodOfferChannelType) ;
		 tmpOffProdRel = getOrgRegAuditingServ().selectOfferProdRel(offerProdRel);
		 for(int j=0;j<tmpOffProdRel.size() ;j++){
			 product.setProductId(BigDecimal.valueOf(Long.valueOf(tmpOffProdRel.get(j).get("PRODUCT_ID").toString()))) ;
			 
			 List<Product> productList = getOrgRegAuditingServ().selectProduct(product) ;
			 for(int i=0;i<productList.size() ;i++){
				 Map  myTmpMap = new HashMap() ;
				   if("10".equals(((Product)productList.get(i)).getCooperationType())
						   ||("11".equals(((Product)productList.get(i)).getCooperationType())
								   &&!String.valueOf(prodOffer.getOfferProviderId()).equals(StringUtil.valueOf(((Product)productList.get(i)).getProductProviderId())))){
					    List<Map> myTmpproductAttrList = new ArrayList<Map>() ;
					    List<Map> myTmpCheckBoxValueList = new ArrayList<Map>() ; 
					    
					    List<Map> myProductAttrInGroupList = new ArrayList<Map>() ;
					    List<Map> myChooseProductGroupList = new ArrayList<Map>() ;
					   prodeTmpAttrValueList = getOrgRegAuditingServ().selectAllAttrValueByOfferId((Product)productList.get(i)) ;
					   productAttr.setProductId(((Product)productList.get(i)).getProductId()) ;
					   productAttr.setStatusCd(EAAPConstants.PRODUCT_ATTR_ONLINE) ;
					   myTmpproductAttrList = getOrgRegAuditingServ().selectProductAttr(productAttr) ;
					   myProductAttrInGroupList = getOrgRegAuditingServ().selectProductAttrInGroup(productAttr) ;
					   
					   myTmpMap.put("productId", productAttr.getProductId());
					   myChooseProductGroupList = getOrgRegAuditingServ().selectGroupInfoByProductId(myTmpMap);
					   
					   myTmpMap.put("prodyys",(Product)productList.get(i)) ;
					   myTmpMap.put("prodattr", myTmpproductAttrList) ;
					   myTmpMap.put("myAttrValueList", prodeTmpAttrValueList) ;
					   
					   for(int h=0;h<myTmpproductAttrList.size();h++){
							if("12".equals(myTmpproductAttrList.get(h).get("DISPLAY_TYPE").toString())){
								 if(myTmpproductAttrList.get(h).get("DEFAULT_VALUE")!=null&&myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().length()>0){
									 for(int m=0;m<myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().split(",").length;m++){
										 Map myMapTmp = new HashMap() ;
										 myMapTmp.put("ATTR_SPEC_ID", myTmpproductAttrList.get(h).get("ATTR_SPEC_ID").toString()) ;
										 myMapTmp.put("PRODUCT_ATTR_ID", myTmpproductAttrList.get(h).get("PRODUCT_ATTR_ID").toString()) ;
										 myMapTmp.put("DEFAULT_VALUE", myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().split(",")[m]) ;
										 for(int k=0;k<prodeTmpAttrValueList.size();k++){
											 if(prodeTmpAttrValueList.get(k).get("ATTR_VALUE_ID").toString().equals(myTmpproductAttrList.get(h).get("DEFAULT_VALUE").toString().split(",")[m])){
												 myMapTmp.put("ATTR_VALUE_NAME", prodeTmpAttrValueList.get(k).get("ATTR_VALUE_NAME").toString()) ;
											 }
										 }
										 myTmpCheckBoxValueList.add(myMapTmp) ;                                                                 
									 }
								 }
							}
						 }
					   
					   
					   for(int h=0;h<myProductAttrInGroupList.size();h++){
							if("12".equals(myProductAttrInGroupList.get(h).get("DISPLAY_TYPE").toString())){
								 if(myProductAttrInGroupList.get(h).get("DEFAULT_VALUE")!=null&&myProductAttrInGroupList.get(h).get("DEFAULT_VALUE").toString().length()>0){
									 for(int m=0;m<myProductAttrInGroupList.get(h).get("DEFAULT_VALUE").toString().split(",").length;m++){
										 Map myMapTmp = new HashMap() ;
										 myMapTmp.put("ATTR_SPEC_ID", myProductAttrInGroupList.get(h).get("ATTR_SPEC_ID").toString()) ;
										 myMapTmp.put("PRODUCT_ATTR_ID", myProductAttrInGroupList.get(h).get("PRODUCT_ATTR_ID").toString()) ;
										 myMapTmp.put("DEFAULT_VALUE", myProductAttrInGroupList.get(h).get("DEFAULT_VALUE").toString().split(",")[m]) ;
										 for(int k=0;k<prodeTmpAttrValueList.size();k++){
											 if(prodeTmpAttrValueList.get(k).get("ATTR_VALUE_ID").toString().equals(myProductAttrInGroupList.get(h).get("DEFAULT_VALUE").toString().split(",")[m])){
												 myMapTmp.put("ATTR_VALUE_NAME", prodeTmpAttrValueList.get(k).get("ATTR_VALUE_NAME").toString()) ;
											 }
										 }
										 myTmpCheckBoxValueList.add(myMapTmp) ;                                                                 
									 }
								 }
							}
						 }
					   
					      myTmpMap.put("groupList", myChooseProductGroupList) ;
						  myTmpMap.put("attrInGroupList", myProductAttrInGroupList) ;  
					   myTmpMap.put("checkBoxValueList", myTmpCheckBoxValueList) ;
					   productAttrList.add(myTmpMap) ;
				    }else if("11".equals(((Product)productList.get(i)).getCooperationType())&&String.valueOf(prodOffer.getOfferProviderId()).equals(StringUtil.valueOf(((Product)productList.get(i)).getProductProviderId()))){
					  chooseProdOardList.add((Product)productList.get(i)) ;
				  }
			  }
		  }
		
		 prodOfferPricing.setProdOfferId(prodOffer.getProdOfferId());
		 prodOfferPricing.setPricingType(EAAPConstants.PRCING_TYPE_PRICETOUSER);
		 pricingList = getOrgRegAuditingServ().queryPricingClassify(prodOfferPricing) ;
		 prodOfferPricing.setPricingType(EAAPConstants.PRCING_TYPE_COMMISSION);
		 commissionPlanList = getOrgRegAuditingServ().queryPricingClassify(prodOfferPricing);
		 
		 
	 
		prodOffer.setFormatEffDate("".equals(StringUtil.valueOf(prodOffer.getEffDate()))?null:DateUtil.convDateToString(prodOffer.getEffDate(), "yyyy-MM-dd")) ;
		prodOffer.setFormatExpDate("".equals(StringUtil.valueOf(prodOffer.getEffDate()))?null:DateUtil.convDateToString(prodOffer.getExpDate(), "yyyy-MM-dd")) ;
		return urlString ;
	}
	
	public void checkOrgOnline(){
		PrintWriter out = null;
		try {
			getResponse().setContentType("text/html;charset=UTF-8");
			out = getResponse().getWriter();
			if(!CommonUtil.isExitTaskByTaskId(activity_Id)){
				String ret="{\"retCode\":\"0001\",\"retMsg\":\"Task[id="+activity_Id+"] is not find!\"}";
				out.print(ret);
				return;
			}
			org.setOrgId(Integer.valueOf(content_Id)) ;
			JSONObject jsonObject = new JSONObject();
			String messageContent="";
			Map<String, Object> taskVariables = new HashMap<String, Object>();
			taskVariables.put("taskId", activity_Id);
			String retMsg = getText("eaap.op2.conf.orgregauditing.auditingSuccess");		//审核成功
			
			String orgUserName ="";
			String orgEmail ="";
			List<Org> orgList = getOrgRegAuditingServ().selectOrgListForLike(org) ;
			if (orgList != null && orgList.size() > 0) {
		  	    Org orgInfo = new Org();
				orgInfo = orgList.get(0) ;
				orgUserName = orgInfo.getOrgUsername();
				orgEmail = orgInfo.getEmail();
			    //邮箱解密操作
				if(null != orgEmail && !"".equals(orgEmail)){
					String email = "";
					try{
						email = SecurityUtil.getInstance().decryMsg(String.valueOf(orgEmail));
						if(null == email || "".equals(email)){
							email = orgEmail;
						}
					} catch(Exception e){
						email =orgEmail;
					}
					orgEmail = email;
				}
			}
			
			if("1".equals(checkState)){
				String isMailActivation = WebPropertyUtil.getPropertyValue("userRegIsNeedMailActivation");
				if("Y".equals(isMailActivation)){
					//需要邮件激活：
					orgAuthCode.setOrgId(org.getOrgId());
					orgAuthCode.setAuthType("2");
					String authCode = StringUtil.Md5(org.getOrgId() + DateUtil.convDateToString(new Date() , "yyyy-MM-dd HH:mm:ss"));
					orgAuthCode.setAuthCode(authCode);
					getOrgRegAuditingServ().insertOrgAuthCode(orgAuthCode);
					
			        HttpServletRequest request = ServletActionContext.getRequest();
					String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/portal/reg/regActivation.shtml?sid=" + authCode;
					
					String dt = DateUtil.convDateToString(new Date() , "yyyy-MM-dd HH:mm:ss");
					String content = getPropertiesValueByCode("regActivation.mailContent");			///邮件内容从mail-send.properties配置文件读取
					if(content!=null && !content.equals("")){
						content = StringUtils.replace(content, "${userName}", orgUserName);
						content = StringUtils.replace(content, "${url}", url);
						content = StringUtils.replace(content, "${date}", dt);
					}
					if(orgEmail!=null && !orgEmail.equals("") && content!=null && !content.equals("")){
						RegActivationSendMailUtil sendMail = new RegActivationSendMailUtil();
						sendMail.send(orgEmail, content);	//发送激活邮件给注册用户
					}
				}else{
					//不需要邮件激活直接启用
					org.setState("D") ;
				}
				
				jsonObject.put("o2pAuditResult", Boolean.TRUE);
				messageContent="O2P Auditing Result:[Org User Name:"+orgList.get(0).getName()+", Org Id:"+org.getOrgId()+"],"+retMsg;
				getMessageServ().addMsg(new BigDecimal(getLoginId()), "1",EAAPConstants.WORK_FLOW_MESSAGE_TITLE_ORG.replace("#id", content_Id).replace("#name", orgUserName), 
						checkDesc, 1, checkDesc, null, content_Id);
			}else if("2".equals(checkState)){
				org.setState("C") ;
				jsonObject.put("o2pAuditResult", Boolean.FALSE);
				retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
				messageContent="O2P Auditing Result:[Org User Name:"+orgList.get(0).getName()+", Org Id:"+org.getOrgId()+"],"+retMsg+"\nReject Reason:"+checkDesc;
				String msgId = getMessageServ().addMsg(new BigDecimal(getLoginId()), "1",EAAPConstants.WORK_FLOW_MESSAGE_TITLE_ORG.replace("#id", content_Id).replace("#name", orgUserName), 
			    		"o2p audit is fail.", 3, checkDesc, null, content_Id);
				
				StringBuffer msgHandleAddress = new StringBuffer();
				msgHandleAddress.append("/org/userInfo.shtml?").append("process_Id=").append(process_Id).append("&")
				   .append("message.msgId=").append(msgId);
				Message msg = new Message();
				msg.setMsgId(new BigDecimal(msgId));
				msg.setMsgHandleAddress(msgHandleAddress.toString());
				getMessageServ().modifyMessage(msg);
			}
			
			jsonObject.put("o2pAuditResultDesc", checkDesc);
			taskVariables.put("varJson", jsonObject.toJSONString());
			
			if(CommonUtil.completeTask(taskVariables)){
				getOrgRegAuditingServ().checkOrgOnline(org) ;
			}else{
				retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
			}
			//选择推送消息类型，消息推送方法
			if(!StringUtils.isEmpty(pushMessageType)){
				Org orgNew=new Org();
				orgNew.setOrgId(org.getOrgId());
				orgNew=orgRegAuditingServ.queryOrg(orgNew);
				orgNew.setEmail(PushCInvokeUtils.decryInvoke(orgNew.getEmail()));
				orgNew.setTelephone(PushCInvokeUtils.decryInvoke(orgNew.getTelephone()));
				String subEmail= orgNew.getSubEmail();
				List<PushTargetList> pushTargetEmailInfoList=new ArrayList<PushTargetList>();
				List<PushTargetList> pushTargetSmsList=new ArrayList<PushTargetList>();
				if (!StringUtils.isEmpty(subEmail)) {
					String decrySubEmail = PushCInvokeUtils.decryInvoke(subEmail);
					orgNew.setSubEmail(decrySubEmail);
					//次邮箱
					PushTargetList pushTargetSecondEmailInfo=setTargetInfoValue("1",orgNew.getOrgId(),decrySubEmail);
					pushTargetEmailInfoList.add(pushTargetSecondEmailInfo);
				}
				String subTelephone=orgNew.getSubTelephone();
				if (!StringUtils.isEmpty(subTelephone)) {
					String decrySubTelephone = PushCInvokeUtils.decryInvoke(subTelephone);
					orgNew.setSubTelephone(decrySubTelephone);
					//次号码
					PushTargetList pushTargetSecondSmsInfo=setTargetInfoValue("1",orgNew.getOrgId(),orgNew.getSubTelephone());
					pushTargetSmsList.add(pushTargetSecondSmsInfo);
				}
				Map paramMap=new HashMap();
			
				//主邮箱
				PushTargetList pushTargetMainEmailInfo=setTargetInfoValue("1",orgNew.getOrgId(),orgNew.getEmail());
				pushTargetEmailInfoList.add(pushTargetMainEmailInfo);
				
				//主号码
				PushTargetList pushTargetMainSmsInfo=setTargetInfoValue("1",orgNew.getOrgId(),orgNew.getTelephone());
				pushTargetSmsList.add(pushTargetMainSmsInfo);
				
				paramMap.put("pushTargetEmailInfoList", pushTargetEmailInfoList);
				paramMap.put("pushTargetSmsList", pushTargetSmsList);
				paramMap.put("opId", getLoginId());
				paramMap.put("srcInteractionEntityId",orgNew.getOrgId() );
				paramMap.put("busiDataInfoMap", this.getBusiDataInfoServ().getBusiDataInfoMap());
				
				
				PushCInvokeUtils.pushCBatchInvokeByType(paramMap,messageContent,pushMessageType);
			}
			
		    
		    String ret="{\"retCode\":\"0000\",\"retMsg\":\""+retMsg+"\"}";
			out.print(ret);
		
		}  catch (Exception e) {
			String ret="{\"retCode\":\"9999\",\"retMsg\":\""+e.getMessage()+"\"}";		//提交审核失败
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),e));
			
			out.print(ret);
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}

 	public String getPropertiesValueByCode(String proCode) {
 		Properties p = new Properties();
 		InputStream in = null;
 		try {
 			in = OrgRegAuditingAction.class.getResourceAsStream("/mail-send.properties");
 			p.load(in);
 			if(null != in){
 				in.close();
 			}
 			return (String) p.get(proCode);
 		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"queryAppInfo:"+e.getMessage(),null));
 			return null;
 		}finally{
 			if(null != in){
 				try {
					in.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"queryAppInfo:"+e.getMessage(),null));
				}
 			}
 		}
 	}
 	
 	private String getLoginId(){
		UserInfo userInfo = (UserInfo) this.getRequest().getSession().getAttribute("cardNumber");
		if(null!=userInfo){
			return userInfo.getId();
		}
		return EAAPConstants.PROCESS_AUTHENTICATED_USER_ID;
	}
	
	public void checkAppOnlineOrUpgrade(){
		PrintWriter out = null;
		try {
			getResponse().setContentType("text/html;charset=UTF-8");
			out = getResponse().getWriter();
			if(!CommonUtil.isExitTaskByTaskId(activity_Id)){
				String ret = "{\"retCode\":\"0001\",\"retMsg\":\"Task[id="+activity_Id+"] is not find!\"}";
				out.print(ret);
				return;
			}
			String retMsg = getText("eaap.op2.conf.orgregauditing.auditingSuccess");		//审核成功
			JSONObject jsonObject = new JSONObject();
			String messageContent="";
			app.setAppId(Integer.valueOf(content_Id)) ;
			Map queryAppInfoMap = getOrgRegAuditingServ().queryAppInfo(app).get(0) ;
			Map<String, Object> taskVariables = new HashMap<String, Object>();
			taskVariables.put("taskId", activity_Id);
			if("1".equals(checkState)){
				app.setAppState(EAAPConstants.COMM_STATE_ONLINE);
				jsonObject.put("o2pAuditResult", Boolean.TRUE);
				Map mapTemp = new HashMap();  
				mapTemp.put("appId", content_Id);
				messageContent="O2P Auditing Result:[Application Name:"+queryAppInfoMap.get("APP_NAME")+", Application Id:"+app.getAppId()+"],"+retMsg;
				getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_APP.replace("#id", String.valueOf(app.getAppId())).replace("#name", String.valueOf(app.getAppName())), 
						checkDesc, 1, checkDesc, null, getOrgRegAuditingServ().getOrgIdByAppId(mapTemp));
			}else if("2".equals(checkState)){
				jsonObject.put("o2pAuditResult", Boolean.FALSE);
				 if(EAAPConstants.PROCESS_MODEL_ID_APPONLINE.equals(process_Model_Id)){
					 app.setAppState(EAAPConstants.COMM_STATE_NOUPGRADE) ;
				 }else{
					 app.setAppState(EAAPConstants.COMM_STATE_NOPASSAUDI) ;
				 }

				Map mapTemp = new HashMap();  
				mapTemp.put("appId", content_Id);
				 String msgId = getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_APP.replace("#id", String.valueOf(app.getAppId())).replace("#name", String.valueOf(app.getAppName())), 
				    		"o2p audit is fail.", 3, checkDesc, null, getOrgRegAuditingServ().getOrgIdByAppId(mapTemp));
					
				StringBuffer msgHandleAddress = new StringBuffer();
				msgHandleAddress.append("/mgr/manageDevMgr.shtml?").append("appId=").append(content_Id).append("&").append("process_Id=").append(process_Id).append("&")
				   .append("message.msgId=").append(msgId);
				Message msg = new Message();
				msg.setMsgId(new BigDecimal(msgId));
				msg.setMsgHandleAddress(msgHandleAddress.toString());
				getMessageServ().modifyMessage(msg);
				
				retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
				messageContent="O2P Auditing Result:[Application Name:"+queryAppInfoMap.get("APP_NAME")+", Application Id:"+app.getAppId()+"],"+retMsg+"\nReject Reason:"+checkDesc;
			}
			jsonObject.put("o2pAuditResultDesc", checkDesc);
			taskVariables.put("varJson", jsonObject.toJSONString());
			if(CommonUtil.completeTask(taskVariables)){
				getOrgRegAuditingServ().checkAppOnlineOrUpgrade(app) ;
			}else{
				retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
			}
			
			//消息推送方法
			if(!StringUtils.isEmpty(pushMessageType)){
				Component component=new Component();
				Map appInfoNewMap = getOrgRegAuditingServ().queryAppInfo(app).get(0) ;
				component.setComponentId(appInfoNewMap.get("COMPONENT_ID").toString());
				component=orgRegAuditingServ.selectComponentOne(component);
				Org org=new Org();
				org.setOrgId(component.getOrgId());
				org=orgRegAuditingServ.queryOrg(org);
				org.setEmail(PushCInvokeUtils.decryInvoke((org.getEmail())));
				org.setTelephone(PushCInvokeUtils.decryInvoke(org.getTelephone()));
				String subEmail= org.getSubEmail();
				List<PushTargetList> pushTargetEmailInfoList=new ArrayList<PushTargetList>();
				List<PushTargetList> pushTargetSmsList=new ArrayList<PushTargetList>();
				if (!StringUtils.isEmpty(subEmail)) {
					String decrySubEmail = PushCInvokeUtils.decryInvoke(subEmail);
					org.setSubEmail(decrySubEmail);
					//次邮箱
					PushTargetList pushTargetSecondEmailInfo=setTargetInfoValue("1",org.getOrgId(),decrySubEmail);
					pushTargetEmailInfoList.add(pushTargetSecondEmailInfo);
				}
				String subTelephone=org.getSubTelephone();
				if (!StringUtils.isEmpty(subTelephone)) {
					String decrySubTelephone = PushCInvokeUtils.decryInvoke(subTelephone);
					org.setSubTelephone(decrySubTelephone);
					//次号码
					PushTargetList pushTargetSecondSmsInfo=setTargetInfoValue("1",org.getOrgId(),org.getSubTelephone());
					pushTargetSmsList.add(pushTargetSecondSmsInfo);
				}
				Map paramMap=new HashMap();
			
				//主邮箱
				PushTargetList pushTargetMainEmailInfo=setTargetInfoValue("1",org.getOrgId(),org.getEmail());
				pushTargetEmailInfoList.add(pushTargetMainEmailInfo);
				
				//主号码
				PushTargetList pushTargetMainSmsInfo=setTargetInfoValue("1",org.getOrgId(),org.getTelephone());
				pushTargetSmsList.add(pushTargetMainSmsInfo);
				
				paramMap.put("pushTargetEmailInfoList", pushTargetEmailInfoList);
				paramMap.put("pushTargetSmsList", pushTargetSmsList);
				paramMap.put("opId", getLoginId());
				paramMap.put("srcInteractionEntityId",org.getOrgId() );
				paramMap.put("busiDataInfoMap", this.getBusiDataInfoServ().getBusiDataInfoMap());
				
				
				PushCInvokeUtils.pushCBatchInvokeByType(paramMap,messageContent,pushMessageType);
			}
			
			String ret="{\"retCode\":\"0000\",\"retMsg\":\""+retMsg+"\"}";
			out.print(ret);
		}catch(Exception e){
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
			    String ret="{\"retCode\":\"9999\",\"retMsg\":\""+e.getMessage()+"\"}";		//提交审核失败
				out.print(ret);
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	public String checkPardMix(){
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id)));
		if("1".equals(checkState)){
			prodOffer.setStatusCd("1000");
		 }else if("2".equals(checkState)){
		    prodOffer.setStatusCd("1298");
		}
		getOrgRegAuditingServ().updateProdOffer(prodOffer) ;

		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		
		String user_Id="123456";
		ActivityInstance activityInstance=wi.getActivityInstance(activity_Id);
		wi.activityExecuteByUser(activityInstance, user_Id, null, 
				null, "E", "audit_result="+checkState+",suggestion="+checkDesc, null, null, null, null);
		String javascript ="alert('"+getText("eaap.op2.conf.orgregauditing.auditingSuccess")+"');art.dialog.close();";
	    addActionScript(javascript);
		return SUCCESS ;
	}
	
	


	public String showOrgList(){
		Map map = new HashMap() ;
		 map.put("orgUsername", "".equals(org.getOrgUsername())?null:org.getOrgUsername()) ;
		 map.put("email", "".equals(org.getEmail())?null:org.getEmail()) ;
		 map.put("name", "".equals(org.getName())?null:org.getName()) ;
		 map.put("telephone", "".equals(org.getTelephone())?null:org.getTelephone()) ;
		 map.put("state", "".equals(org.getState())?null:org.getState()) ;
		 map.put("roleCode", "".equals(orgRole.getRoleCode())?null:orgRole.getRoleCode()) ;
		 
		if(getSelectPerPage("page")==-1){
	         page.setPageRecord(EAAPConstants.EAAP_PAGE_RECORE_10);
	         }else{
	         page.setPageRecord(getSelectPerPage("page"));
	         }
	         //判断是否是第1次查询
	         if(getQueryFlag("page")==-1){ 
	        	 map.put("queryType", "ALLNUM") ;
	        	 page.setTotalRecord(Integer.valueOf(String.valueOf(getOrgRegAuditingServ().queryOrgInfoList(map).get(0).get("ALLNUM")))); //page.setTotalRecord(testFacade.selectMenuInfoCount(para));
	         }else{
	             page.setTotalRecord(getQueryFlag("page"));
	         }
	         map.put("queryType", "") ;
	         //设置查询条件
	         setPageParameters(page,"page");

	         //查询本页记录List
	        
	         map.put("pro", page.getPageStart());
	         map.put("end", page.getPageEnd());
	         
		orgInfoList =getOrgRegAuditingServ().queryOrgInfoList(map) ;
		orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		
		
		Iterator iter = orgStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 orgStateList.add(mapTmp) ;
		 }
		 return SUCCESS ;
	}
	
	
	public String preAddOrgInfo(){
        Org orgBean =  new Org() ;
		cityList = getOrgRegAuditingServ().queryCityForReg(orgBean) ;
		provinceList = getOrgRegAuditingServ().queryProvinceForReg(orgBean) ;
	    return SUCCESS;
		 
	}
	
	
	public String updateOrgInfo(){
	   getOrgRegAuditingServ().checkOrgOnline(org) ;
	   content_Id=String.valueOf(org.getOrgId()) ;
	   tmpType ="info" ;
	   return SUCCESS ;
	}
	
	public String deleteOrgInfoById(){
		
		return null ;
	}
	public String insertOrgInfo(){
		 org.setOrgPwd(StringUtil.Md5(org.getOrgPwd())) ;
		 getOrgRegAuditingServ().addOrg(org, orgRole);
		 return SUCCESS ;
	}
	
	
	
	
	public String showMainDataTypeList(){
		 Map map = new HashMap() ;
		 map.put("orgUsername", "".equals(org.getOrgUsername())?null:org.getOrgUsername()) ;
		 map.put("email", "".equals(org.getEmail())?null:org.getEmail()) ;
		 map.put("name", "".equals(org.getName())?null:org.getName()) ;
		 map.put("telephone", "".equals(org.getTelephone())?null:org.getTelephone()) ;
		 map.put("state", "".equals(org.getState())?null:org.getState()) ;
		 map.put("roleCode", "".equals(orgRole.getRoleCode())?null:orgRole.getRoleCode()) ;
		 
		if(getSelectPerPage("page")==-1){
	         page.setPageRecord(EAAPConstants.EAAP_PAGE_RECORE_10);
	         }else{
	         page.setPageRecord(getSelectPerPage("page"));
	         }
	         //判断是否是第1次查询
	         if(getQueryFlag("page")==-1){ 
	        	 map.put("queryType", "ALLNUM") ;
	        	 page.setTotalRecord(Integer.valueOf(String.valueOf(getOrgRegAuditingServ().queryOrgInfoList(map).get(0).get("ALLNUM")))); //page.setTotalRecord(testFacade.selectMenuInfoCount(para));
	         }else{
	             page.setTotalRecord(getQueryFlag("page"));
	         }
	         map.put("queryType", "") ;
	         //设置查询条件
	         setPageParameters(page,"page");
	        
	         map.put("pro", page.getPageStart());
	         map.put("end", page.getPageEnd());

	         orgInfoList =getOrgRegAuditingServ().queryOrgInfoList(map) ;
		orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		
		Map orgTypeNameMap = new HashMap();
		orgTypeNameMap.put("0", getText("eaap.op2.conf.orgregauditing.userisother"));
		orgTypeNameMap.put("1", getText("eaap.op2.conf.orgregauditing.useriscomp"));
		orgTypeNameMap.put("2", getText("eaap.op2.conf.orgregauditing.userisperson"));
		
		Map certTypeNameMap = new HashMap();
		certTypeNameMap.put("1", getText("eaap.op2.conf.manager.auth.cardtypeisider"));
		certTypeNameMap.put("2", getText("eaap.op2.conf.manager.auth.cardtypeiscom"));
		
		for (Map temp:orgInfoList) {
			
			if (temp.get("ORG_TYPE_CODE") != null) {
				temp.put("ORGTYPENAME", orgTypeNameMap.get(temp.get("ORG_TYPE_CODE")));
			}
			if (temp.get("CERT_TYPE_CODE") != null) {
				temp.put("CERTTYPENAME", certTypeNameMap.get(temp.get("CERT_TYPE_CODE")));
			}
		}
		
		Iterator iter = orgStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 orgStateList.add(mapTmp) ;
		 }
		 return SUCCESS ;
	  }
	
	
	//邮箱或者短信的targetList的值
	public static PushTargetList setTargetInfoValue(String targetType,Integer targetId,String targetAddress){
		PushTargetList pushTargetInfo=new PushTargetList();
		pushTargetInfo.setTargetType(new BigInteger(targetType));//1-客户id  2-操作员id
		pushTargetInfo.setTargetId(targetId.toString());
		pushTargetInfo.setTargeAddress(targetAddress);
		return pushTargetInfo;
	}
	
	public IBusiDataInfoServ getBusiDataInfoServ() {
		if(null==busiDataInfoServ){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// 取得spring bean实例
			busiDataInfoServ = (IBusiDataInfoServ) ctx.getBean("busiDataInfoServ"); 
		}
		return busiDataInfoServ;
	}
	public void setBusiDataInfoServ(IBusiDataInfoServ busiDataInfoServ) {
		this.busiDataInfoServ = busiDataInfoServ;
	}
	
	
	public boolean verifyOrg(String verifyParam ,String paramValue) {
	    Org orgBean = new Org(); 
	    if("username".equals(verifyParam)){
	    	 orgBean.setOrgUsername(paramValue) ;
	    }else if(verifyParam.startsWith("email")){
	    	 orgBean.setEmail(paramValue) ;
	    } 
	   
		List orgList = getOrgRegAuditingServ().selectOrg(orgBean) ;
		return orgList==null||orgList.size()<1?true:false;
	}
	
	public Map getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map stateMap = new HashMap() ;
	  	  mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = getOrgRegAuditingServ().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
			  List<MainData> mainDataList = getOrgRegAuditingServ().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }

	public App getApp() {
		return app;
	}

	public void setApp(App app) {
		this.app = app;
	}

	public IOrgRegAuditingServ getOrgRegAuditingServ() {
		if(orgRegAuditingServ==null){
            //取得spring上下文
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				// 取得spring bean实例
				orgRegAuditingServ = (IOrgRegAuditingServ)ctx.getBean("eaap-op2-conf-auditing-orgAndAppServ");
			   
	     }
		return orgRegAuditingServ;
	}
	public void setOrgRegAuditingServ(IOrgRegAuditingServ orgRegAuditingServ) {
		this.orgRegAuditingServ = orgRegAuditingServ;
	}
 
	public Map getOrgInfoMap() {
		return orgInfoMap;
	}
	public void setOrgInfoMap(Map orgInfoMap) {
		this.orgInfoMap = orgInfoMap;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}

	public Map getAppInfoMap() {
		return appInfoMap;
	}

	public void setAppInfoMap(Map appInfoMap) {
		this.appInfoMap = appInfoMap;
	}

 
	public List<Map> getAppApiInfoList() {
		return appApiInfoList;
	}

	public void setAppApiInfoList(List<Map> appApiInfoList) {
		this.appApiInfoList = appApiInfoList;
	}

	 

	public String getContent_Id() {
		return content_Id;
	}

	public void setContent_Id(String content_Id) {
		this.content_Id = content_Id;
	}

	public String getCheckState() {
		return checkState;
	}

	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}

	public String getActivity_Id() {
		return activity_Id;
	}

	public void setActivity_Id(String activity_Id) {
		this.activity_Id = activity_Id;
	}

	public String getCheckDesc() {
		return checkDesc;
	}

	public void setCheckDesc(String checkDesc) {
		this.checkDesc = checkDesc;
	}

	public String getPushc_url() {
		return pushc_url;
	}
	public void setPushc_url(String pushc_url) {
		this.pushc_url = pushc_url;
	}
	public String getPushMessageType() {
		return pushMessageType;
	}
	public void setPushMessageType(String pushMessageType) {
		this.pushMessageType = pushMessageType;
	}
	public String getProcess_Id() {
		return process_Id;
	}

	public void setProcess_Id(String process_Id) {
		this.process_Id = process_Id;
	}

	public String getProcess_Model_Id() {
		return process_Model_Id;
	}

	public void setProcess_Model_Id(String process_Model_Id) {
		this.process_Model_Id = process_Model_Id;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public List<Map> getOrgInfoList() {
		return orgInfoList;
	}

	public void setOrgInfoList(List<Map> orgInfoList) {
		this.orgInfoList = orgInfoList;
	}

	public List<Map> getOrgStateList() {
		return orgStateList;
	}

	public void setOrgStateList(List<Map> orgStateList) {
		this.orgStateList = orgStateList;
	}

	public String getTmpType() {
		return tmpType;
	}

	public void setTmpType(String tmpType) {
		this.tmpType = tmpType;
	}

	public OrgRole getOrgRole() {
		return orgRole;
	}

	public void setOrgRole(OrgRole orgRole) {
		this.orgRole = orgRole;
	}

	public ProdOffer getProdOffer() {
		return prodOffer;
	}

	public void setProdOffer(ProdOffer prodOffer) {
		this.prodOffer = prodOffer;
	}

	public OfferProdRel getOfferProdRel() {
		return offerProdRel;
	}

	public void setOfferProdRel(OfferProdRel offerProdRel) {
		this.offerProdRel = offerProdRel;
	}

	public List<Map> getProvServiceList() {
		return provServiceList;
	}

	public void setProvServiceList(List<Map> provServiceList) {
		this.provServiceList = provServiceList;
	}

	public ProdOfferChannelType getProdOfferChannelType() {
		return prodOfferChannelType;
	}

	public void setProdOfferChannelType(ProdOfferChannelType prodOfferChannelType) {
		this.prodOfferChannelType = prodOfferChannelType;
	}

	public Map getProdChannelMap() {
		return prodChannelMap;
	}

	public void setProdChannelMap(Map prodChannelMap) {
		this.prodChannelMap = prodChannelMap;
	}

	public List<ProdOfferChannelType> getProdOfferChannelTypeList() {
		return prodOfferChannelTypeList;
	}

	public void setProdOfferChannelTypeList(
			List<ProdOfferChannelType> prodOfferChannelTypeList) {
		this.prodOfferChannelTypeList = prodOfferChannelTypeList;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ProductAttr getProductAttr() {
		return productAttr;
	}

	public void setProductAttr(ProductAttr productAttr) {
		this.productAttr = productAttr;
	}

	public List<Map> getProductAttrList() {
		return productAttrList;
	}

	public void setProductAttrList(List<Map> productAttrList) {
		this.productAttrList = productAttrList;
	}

	public List<Product> getChooseProdOardList() {
		return chooseProdOardList;
	}

	public void setChooseProdOardList(List<Product> chooseProdOardList) {
		this.chooseProdOardList = chooseProdOardList;
	}

	public List<Map> getPricingList() {
		return pricingList;
	}

	public void setPricingList(List<Map> pricingList) {
		this.pricingList = pricingList;
	}

	public ProdOfferPricing getProdOfferPricing() {
		return prodOfferPricing;
	}

	public void setProdOfferPricing(ProdOfferPricing prodOfferPricing) {
		this.prodOfferPricing = prodOfferPricing;
	}

	public List<Map> getCommissionPlanList() {
		return commissionPlanList;
	}

	public void setCommissionPlanList(List<Map> commissionPlanList) {
		this.commissionPlanList = commissionPlanList;
	}

	public String getPageShowMsg() {
		return pageShowMsg;
	}

	public void setPageShowMsg(String pageShowMsg) {
		this.pageShowMsg = pageShowMsg;
	}

	public String getRegActivationResult() {
		return regActivationResult;
	}

	public void setRegActivationResult(String regActivationResult) {
		this.regActivationResult = regActivationResult;
	}
	
	
}
