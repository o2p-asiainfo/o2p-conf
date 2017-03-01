package com.ailk.eaap.op2.conf.mealrate.action;

import java.math.BigDecimal;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.mealrate.service.IMealRateServ;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.workflow.engine.activity.ActivityInstance;
import com.workflow.remote.WorkflowRemoteInterface;

public class MealRateAction extends BaseAction{

	/**
	 * @author wanglm7
	 * @create time 2013年5月15日 10:06:26
	 * @des  套餐议价审批
	 */
	private static final long serialVersionUID = 1L;

	private IMealRateServ mealRateServ ;
	
	private ProdOffer prodOffer = new ProdOffer() ;
	
	//装载通话时长List
	private List<Map<String,String>> voiceList ;
	
	//装载流量List
	private List<Map<String,String>> dataList ;
	
	//装载短信List
	private List<Map<String,String>> msgList ;
	
	//装载此销售品对应产品List
	private List<Map<String,String>> productList ;
	
	//装载定价计划信息
	private List<Map> pricingList ;
	
	private String content_Id ;
	
	private String activity_Id ;
	
	//审批状态
	private String checkState ;
	
	//审批意见
	private String checkDesc ;
	
    private PricingPlan pricingPlan ;
    
	/**
	 * 获得此销售品的所有属性信息、定价信息
	 * @return
	 */
	public String queryMealRateInfo(){
		
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id))) ;
		Map<String,String> map = new HashMap<String, String>() ;
		map.put("mdt_sign", EAAPConstants.MAINDATATYPE_PROD_SPEC_UNIT) ;
		map.put("prodOfferId", content_Id) ;
		voiceList = this.getMealRateServ().getVoiceList(map) ; 
		dataList  = this.getMealRateServ().getDataList(map) ; 
		msgList   = this.getMealRateServ().getMsgList(map) ; 
		productList = this.getMealRateServ().getProductList(map) ; 
		prodOffer = this.getMealRateServ().getProdOffer(prodOffer) ;
		pricingList = this.getMealRateServ().selectPricingListByOfferId(prodOffer) ;
		return SUCCESS ; 
	}
	
	/**
	 * 审批
	 * @return
	 */
	public String checkProdOffer(){
		prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id))) ;
		if("1".equals(checkState)){
			//审批通过
			prodOffer.setStatusCd("1000") ;
		}else if("2".equals(checkState)){
			//审批不通过
			prodOffer.setStatusCd("1298") ;
		}
		
		this.getMealRateServ().editProdOfferStatus(prodOffer) ;
		String user_Id="123456";
		
		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		
		ActivityInstance activityInstance=wi.getActivityInstance(activity_Id);
		Map<String,String> map = new HashMap<String, String>() ; 
		map = wi.activityExecuteByUser(activityInstance, user_Id, null, null, "E", "audit_result="+checkState+",suggestion="+checkDesc, null, null, null, null);
		String returnCode = map.get("RETURNCODE");
		
		if("1".equals(returnCode)){
			//提交审批成功
			this.getMealRateServ().editProdOfferStatus(prodOffer) ;
		}
		return null ;
	}
	
	/**
	 * 获取serv实例
	 * @return
	 */
	public IMealRateServ getMealRateServ() {
		if(mealRateServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				mealRateServ = (IMealRateServ)ctx.getBean("eaap-op2-conf-auditing-mealRateServ") ;
	     }
		return mealRateServ;
	}

	
	
	public List<Map<String, String>> getVoiceList() {
		return voiceList;
	}

	public void setVoiceList(List<Map<String, String>> voiceList) {
		this.voiceList = voiceList;
	}

	public List<Map<String, String>> getDataList() {
		return dataList;
	}

	public void setDataList(List<Map<String, String>> dataList) {
		this.dataList = dataList;
	}

	public List<Map<String, String>> getMsgList() {
		return msgList;
	}

	public void setMsgList(List<Map<String, String>> msgList) {
		this.msgList = msgList;
	}

	public List<Map<String, String>> getProductList() {
		return productList;
	}

	public void setProductList(List<Map<String, String>> productList) {
		this.productList = productList;
	}

	public ProdOffer getProdOffer() {
		return prodOffer;
	}

	public void setProdOffer(ProdOffer prodOffer) {
		this.prodOffer = prodOffer;
	}

	public PricingPlan getPricingPlan() {
		return pricingPlan;
	}

	public void setPricingPlan(PricingPlan pricingPlan) {
		this.pricingPlan = pricingPlan;
	}

	public String getContent_Id() {
		return content_Id;
	}

	public void setContent_Id(String contentId) {
		content_Id = contentId;
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

	public List<Map> getPricingList() {
		return pricingList;
	}

	public void setPricingList(List<Map> pricingList) {
		this.pricingList = pricingList;
	}
	
}
