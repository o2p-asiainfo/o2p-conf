package com.ailk.eaap.op2.conf.pard.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.AttrValue;
import com.ailk.eaap.op2.bo.FixedAttrValue;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.ProdOfferPricing;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProductAttrGroup;
import com.ailk.eaap.op2.bo.ValueAddedProdInfo;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.pard.service.IPardPordServ;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.workflow.engine.activity.ActivityInstance;
import com.workflow.remote.WorkflowRemoteInterface;


public class PardPordAction extends BaseAction{
  
	private static final long serialVersionUID = 1L;
	private ProdOffer prodOffer  = new ProdOffer();
	private ValueAddedProdInfo valueAddedProd = new ValueAddedProdInfo();
	private List<ProductAttr> productAtrrList;
	private List<AttrSpec> atrrSpecList;
	private List<Map> pricingPlanList ;
	private List<Map> attr = new ArrayList<Map>();
	private String pricingDesc = null;
	private String content_Id=null;
    private String activity_Id=null; 
    private ProdOfferChannelType prodChannelType = new ProdOfferChannelType();
    private List<Map> prodDealSvcList;
    private List<ProdOfferChannelType> channelTypeList = new ArrayList<ProdOfferChannelType>();
    private Map channelTypeMap = new HashMap();
	private List<Map> commissionPlanList =  new ArrayList<Map>();
	ProductAttr productAttr = new ProductAttr();
	private FixedAttrValue fixedAttrValue = new FixedAttrValue();
	private ProductAttrGroup productAttrGroup = new ProductAttrGroup();
	private List<ProductAttrGroup> productAttrGroupList =new ArrayList<ProductAttrGroup>();
	private List<Map> attrAllHashMaps = new ArrayList<Map>();
	//审批状态
	private String checkState ;
	
	//审批意见
	private String checkDesc ;
	
	
	private IPardPordServ iPardPordServ;
	
	private List<Map> checkStateList = new ArrayList<Map>();
	
	public String queryPardPordInfo(){
		
		  Map checkStateMap1 = new HashMap();
		  Map checkStateMap2 = new HashMap();
		 
		  checkStateMap1.put("key", "1") ;
		  checkStateMap1.put("value", getText("eaap.op2.conf.orgregauditing.checkpass")) ;
		  
		  checkStateMap2.put("key", "2") ;
		  checkStateMap2.put("value", getText("eaap.op2.conf.orgregauditing.checknotpass")) ;
		  
		  checkStateList.add(checkStateMap1);
		  checkStateList.add(checkStateMap2);
		
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id)));
		prodOffer = getPardPordServ().queryProdOffer(prodOffer);
		String btime = prodOffer.getEffDate() == null ? "" : DateUtil
				.convDateToString(prodOffer.getEffDate(), "yyyy-MM-dd");
		String etime = prodOffer.getExpDate() == null ? "" : DateUtil
				.convDateToString(prodOffer.getExpDate(), "yyyy-MM-dd");
		prodOffer.setFormatEffDate(btime);
		prodOffer.setFormatExpDate(etime);
		// 获取销售品 产品受理服务
		// 销售品与产品关联，取到productid（OFFER_PROD_REL）
		OfferProdRel offerProdRel = new OfferProdRel();
		offerProdRel.setProdOfferId(prodOffer.getProdOfferId());
		offerProdRel = getPardPordServ().queryOfferProdRel(offerProdRel);
		// 增值产品表里取SERVICE_ID(根据productId取)
		valueAddedProd.setProductId(offerProdRel.getProductId());
		valueAddedProd = getPardPordServ().queryValueAddedProdInfo(
				valueAddedProd);
		Map<String, Comparable> map = new HashMap();
		map.put("orgId", "800000003");
		map.put("serviceId", valueAddedProd.getServiceId());
		prodDealSvcList = getPardPordServ().queryProdDealSvcList(map);
		// 获取销售品 销售范围
		prodChannelType.setProdOfferId(prodOffer.getProdOfferId());
		channelTypeList = getPardPordServ().queryProdOfferChannelList(
				prodChannelType);
		channelTypeMap = getMainInfo(
				EAAPConstants.MAINDATATYPE_SIGN_PRODCHANNELTYPE,
				channelTypeList);
		//获得固定属性的详情		
		productAttrGroup.setProductId(offerProdRel.getProductId());
		productAttrGroupList = getPardPordServ().queryProductAttrGroup(productAttrGroup);
	
		for (int i = 0; i < productAttrGroupList.size(); i++) {
			Map hashMapAll = new HashMap();
			Map hashMap1 = new HashMap();
			Map hashMap2 = new HashMap();
			List<String>  productAtrrList1 = new ArrayList<String>();
			List<String>  productAtrrList2 = new ArrayList<String>();
			List<AttrValue> attrValueList1  =  new ArrayList<AttrValue>();
			ProductAttr productAttr1 = new ProductAttr();
			hashMap1.put("productAttrGroupId", (productAttrGroupList.get(i).getProductAttrGroupId()));
			hashMapAll.put("groupName", (productAttrGroupList.get(i).getGroupName()));
			hashMap1.put("attrSpecId", 25);
			productAttr = getPardPordServ().queryProductAttrGroupRelaAndProductAttr(hashMap1);
			hashMapAll.put("applicationsName", productAttr.getDefaultValue());
			hashMap1.put("productAttrGroupId", (productAttrGroupList.get(i).getProductAttrGroupId()));
			hashMap1.put("attrSpecId", 24);
			productAttr = getPardPordServ().queryProductAttrGroupRelaAndProductAttr(hashMap1);
			if(productAttr!=null){
			if(productAttr.getDefaultValue()!=null){
				productAtrrList1.add(productAttr.getDefaultValue());
			}else{
				productAttr1.setProductAttrId(productAttr.getProductAttrId());
				attrValueList1 = (List<AttrValue>) getPardPordServ().queryProductAttrValueAndAttrValue(productAttr1);
				for(int m = 0;m<attrValueList1.size();m++){
					productAtrrList1.add(attrValueList1.get(m).getAttrDesc());
				}			
			}
			  hashMapAll.put("applicationsNameAimList", productAtrrList1);
			}
			hashMap2.put("productAttrGroupId", (productAttrGroupList.get(i).getProductAttrGroupId()));
			hashMap2.put("attrSpecId", 41);
			productAttr = getPardPordServ().queryProductAttrGroupRelaAndProductAttr(hashMap2);
			if(productAttr!=null){
			if(productAttr.getDefaultValue()!=null){
				productAtrrList2.add(productAttr.getDefaultValue());
			}else{
				productAttr1.setProductAttrId(productAttr.getProductAttrId());
				attrValueList1 = (List<AttrValue>) getPardPordServ().queryProductAttrValueAndAttrValue(productAttr1);
				for(int m = 0;m<attrValueList1.size();m++){
					productAtrrList2.add(attrValueList1.get(m).getAttrDesc());
				}				
			}
			hashMapAll.put("trafficldenRuleList", productAtrrList2);
			}
			attrAllHashMaps.add(hashMapAll);
            		
		}
		//获取产品属性详情		
		
		AttrSpec attrSpec = new AttrSpec();
		if (productAttr == null) {
			productAttr = new ProductAttr();
		}
		productAttr.setProductId(offerProdRel.getProductId());
		productAttr.setDisplayType("21");
		productAtrrList = getPardPordServ().queryProductAtrr(productAttr);
        Iterator iter = productAtrrList.iterator();
        atrrSpecList = new ArrayList();
        while(iter.hasNext()){
        	productAttr = (ProductAttr) iter.next();
        	Map attrMap = new HashMap();
        	attrMap.put("defaultValue", productAttr.getDefaultValue());
        	attrSpec.setAttrSpecId(Integer.valueOf(productAttr.getAttrSpecId()));
        	attrSpec = getPardPordServ().queryAtrrSpec(attrSpec);        	
        	attrMap.put("attrSpecName", attrSpec.getAttrSpecName());
        	attr.add(attrMap);
        }
               
        //根据proOfferid 查出PRICING_INFO_ID  PRICING_CLASSIFY  PRICING_DESC NAME 
        ProdOfferPricing prodOfferPricing = new ProdOfferPricing();
        prodOfferPricing.setPricingType("12");
        prodOfferPricing.setProdOfferId(prodOffer.getProdOfferId());
        pricingPlanList= getPardPordServ().queryPricingClassify(prodOfferPricing);
        //佣金 
        prodOfferPricing.setPricingType("11");
        prodOfferPricing.setProdOfferId(prodOffer.getProdOfferId());
        commissionPlanList= getPardPordServ().queryPricingClassify(prodOfferPricing);
		return SUCCESS;
	}
	
	/**
	 * 审批
	 * @return
	 */
	public String checkProdOffer(){
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id)));
		if("1".equals(checkState)){
			//审批通过
			prodOffer.setStatusCd("1000") ;
		}else if("2".equals(checkState)){
			//审批不通过
			prodOffer.setStatusCd("1298") ;
		}
		
		this.getPardPordServ().editProdOfferStatus(prodOffer) ;
		String user_Id="123456";

		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		
		ActivityInstance activityInstance=wi.getActivityInstance(activity_Id);
		wi.activityExecuteByUser(activityInstance, user_Id, null, 
				null, "E", "audit_result="+checkState+",suggestion="+checkDesc, null, null, null, null);
		String javascript ="alert('"+getText("eaap.op2.conf.orgregauditing.auditingSuccess")+"');art.dialog.close();";
	    addActionScript(javascript);
		return SUCCESS ;
	}
	
	public Map getMainInfo(String mainTypeSign,
			List<ProdOfferChannelType> channelTypeList) {
		MainDataType mainDataType = new MainDataType();
		MainData mainData = new MainData();
		Map stateMap = new HashMap();
		List<MainData> mainDataList = new ArrayList<MainData>();

		mainDataType.setMdtSign(mainTypeSign);
		mainDataType = getPardPordServ().selectMainDataType(mainDataType)
				.get(0);
		mainData.setMdtCd(mainDataType.getMdtCd());
		if (channelTypeList != null && channelTypeList.size() > 0) {
			for (int i = 0; i < channelTypeList.size(); i++) {
				mainData.setCepCode(channelTypeList.get(i).getChannelType()
						+ "");
				List<MainData> ddd = getPardPordServ().selectMainData(
						mainData);
				if(ddd!= null &&ddd.size() > 0){
				for(int j = 0; j < ddd.size(); j++) {
					mainDataList.add(ddd.get(j));
				}
				}
			}

		}
		if (mainDataList != null && mainDataList.size() > 0) {
			for (int i = 0; i < mainDataList.size(); i++) {
				stateMap.put(mainDataList.get(i).getCepCode(), mainDataList
						.get(i).getCepName());
			}
		}

		return stateMap;
	}
	
	
	/**
	 * 获取serv实例
	 * @return
	 */
	public IPardPordServ getPardPordServ() {
		if(iPardPordServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				iPardPordServ = (IPardPordServ)ctx.getBean("eaap-op2-conf-pard-pord-service") ;
	     }
		return iPardPordServ;
	}

	public String getContent_Id() {
		return content_Id;
	}

	public void setContent_Id(String contentId) {
		content_Id = contentId;
	}

	public ProdOffer getProdOffer() {
		return prodOffer;
	}

	public void setProdOffer(ProdOffer prodOffer) {
		this.prodOffer = prodOffer;
	}

	public ValueAddedProdInfo getValueAddedProd() {
		return valueAddedProd;
	}

	public void setValueAddedProd(ValueAddedProdInfo valueAddedProd) {
		this.valueAddedProd = valueAddedProd;
	}

	public List<ProductAttr> getProductAtrrList() {
		return productAtrrList;
	}

	public void setProductAtrrList(List<ProductAttr> productAtrrList) {
		this.productAtrrList = productAtrrList;
	}

	public List<AttrSpec> getAtrrSpecList() {
		return atrrSpecList;
	}

	public void setAtrrSpecList(List<AttrSpec> atrrSpecList) {
		this.atrrSpecList = atrrSpecList;
	}

	public List<Map> getPricingPlanList() {
		return pricingPlanList;
	}

	public void setPricingPlanList(List<Map> pricingPlanList) {
		this.pricingPlanList = pricingPlanList;
	}

	public List<Map> getAttr() {
		return attr;
	}

	public void setAttr(List<Map> attr) {
		this.attr = attr;
	}

	public String getPricingDesc() {
		return pricingDesc;
	}

	public void setPricingDesc(String pricingDesc) {
		this.pricingDesc = pricingDesc;
	}

	public String getActivity_Id() {
		return activity_Id;
	}

	public void setActivity_Id(String activityId) {
		activity_Id = activityId;
	}

	public String getCheckState() {
		return checkState;
	}

	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}

	public String getCheckDesc() {
		return checkDesc;
	}

	public void setCheckDesc(String checkDesc) {
		this.checkDesc = checkDesc;
	}

	public ProdOfferChannelType getProdChannelType() {
		return prodChannelType;
	}

	public void setProdChannelType(ProdOfferChannelType prodChannelType) {
		this.prodChannelType = prodChannelType;
	}

	public List<Map> getProdDealSvcList() {
		return prodDealSvcList;
	}

	public void setProdDealSvcList(List<Map> prodDealSvcList) {
		this.prodDealSvcList = prodDealSvcList;
	}

	public List<ProdOfferChannelType> getChannelTypeList() {
		return channelTypeList;
	}

	public void setChannelTypeList(List<ProdOfferChannelType> channelTypeList) {
		this.channelTypeList = channelTypeList;
	}

	public Map getChannelTypeMap() {
		return channelTypeMap;
	}

	public void setChannelTypeMap(Map channelTypeMap) {
		this.channelTypeMap = channelTypeMap;
	}

	public List<Map> getCommissionPlanList() {
		return commissionPlanList;
	}

	public void setCommissionPlanList(List<Map> commissionPlanList) {
		this.commissionPlanList = commissionPlanList;
	}

	public FixedAttrValue getFixedAttrValue() {
		return fixedAttrValue;
	}

	public void setFixedAttrValue(FixedAttrValue fixedAttrValue) {
		this.fixedAttrValue = fixedAttrValue;
	}

	public ProductAttrGroup getProductAttrGroup() {
		return productAttrGroup;
	}

	public void setProductAttrGroup(ProductAttrGroup productAttrGroup) {
		this.productAttrGroup = productAttrGroup;
	}

	public List<ProductAttrGroup> getProductAttrGroupList() {
		return productAttrGroupList;
	}

	public void setProductAttrGroupList(List<ProductAttrGroup> productAttrGroupList) {
		this.productAttrGroupList = productAttrGroupList;
	}

	public List<Map> getAttrAllHashMaps() {
		return attrAllHashMaps;
	}

	public void setAttrAllHashMaps(List<Map> attrAllHashMaps) {
		this.attrAllHashMaps = attrAllHashMaps;
	}

	public List<Map> getCheckStateList() {
		return checkStateList;
	}

	public void setCheckStateList(List<Map> checkStateList) {
		this.checkStateList = checkStateList;
	}
	

}
