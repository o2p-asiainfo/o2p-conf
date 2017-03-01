package com.ailk.eaap.op2.conf.auditing.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;
import com.ailk.eaap.op2.bo.Channel;
import com.ailk.eaap.op2.bo.ComponentPrice;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PricePlanLifeCycle;
import com.ailk.eaap.op2.bo.PricingPlan;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannel;
import com.ailk.eaap.op2.bo.ProdOfferRel;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ServiceSpec;
import com.ailk.eaap.op2.bo.SettleCycleDef;
import com.ailk.eaap.op2.bo.SettleRule;
import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.pushc.PushTargetList;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.IBusiDataInfoServ;
import com.ailk.eaap.op2.conf.auditing.service.IPardServiceSpecServ;
import com.ailk.eaap.op2.conf.auditing.service.ProdAndOfferAuditingServ;
import com.ailk.eaap.op2.conf.message.service.MessageServ;
import com.ailk.eaap.op2.conf.task.service.ITaskService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.loginFilter.bo.UserInfo;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.PushCInvokeUtils;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;

public class ProdAndOfferAuditingAction extends BaseAction {
	private static final long serialVersionUID = -6933061221183518598L;
	private Logger log = Logger.getLog(this.getClass());
	private ProdAndOfferAuditingServ ProdAndOfferAuditingServ;
	private MessageServ messageServ;
	private IPardServiceSpecServ pardServiceSpecServ;
	private ITaskService taskService;	
	private IBusiDataInfoServ busiDataInfoServ;
	public String process_Id;
	public String activity_Id;
	public String content_Id;
	public String checkState;
	public String checkDesc;
	private String pushMessageType;
    private String pushc_url;
	public String orgId;
	public String processDefImg;
	public String serviceName;
	public List<ServiceSpec> serviceSpeclist;
	public List<Map<String, Object>> serviceSpecAttrList;
	public String frontEndUrl;
	public String o2pWebDomin;
	
	public ProdOffer prodOffer = new ProdOffer();
	public OfferProdRel offerProdRel = new OfferProdRel();
	private List<OfferProdRel> offerProdRelList = new ArrayList<OfferProdRel>();
	private ProdOfferRel prodOfferRel = new ProdOfferRel();
	private List<ProdOfferRel> prodOfferRelList1 = new ArrayList<ProdOfferRel>();
	private List<ProdOfferRel> prodOfferRelList2 = new ArrayList<ProdOfferRel>();
	public PricingPlan pricingPlan = new PricingPlan();
	private List<PricingPlan> pricingPlanList = new ArrayList<PricingPlan>();
	private List<Map<String,String>> settleList = new ArrayList<Map<String,String>>();
	private JSONArray settlementList = new JSONArray();
	private JSONArray pricePlanList = new JSONArray();
	
	private Product product = new Product();
	private ProductAttr productAttr = new ProductAttr();
	private List<Map> subBusinessCodes = new ArrayList<Map>();
	private List<Map> prodAttrList = new ArrayList<Map>();
	private List<Map> componentList = new ArrayList<Map>();
	private Map attrSpecIsCustomizedMap = new HashMap();
	private Map attrSpecPageInTypeMap = new HashMap();
	private Map FuncSeletedTreeMap = new HashMap();
	
	public Map getFuncSeletedTreeMap() {
		return FuncSeletedTreeMap;
	}
	public void setFuncSeletedTreeMap(Map funcSeletedTreeMap) {
		FuncSeletedTreeMap = funcSeletedTreeMap;
	}
	public List<ServiceSpec> getServiceSpeclist() {
		return serviceSpeclist;
	}
	public void setServiceSpeclist(List<ServiceSpec> serviceSpeclist) {
		this.serviceSpeclist = serviceSpeclist;
	}
	public IPardServiceSpecServ getPardServiceSpecServ() {
		if(pardServiceSpecServ==null){
            //取得spring上下文
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// 取得spring bean实例
			pardServiceSpecServ = (IPardServiceSpecServ)ctx.getBean("eaap-op2-conf-message-pardServiceSpecServ");
	     }
		return pardServiceSpecServ;
	}
	public void setPardServiceSpecServ(IPardServiceSpecServ pardServiceSpecServ) {
		this.pardServiceSpecServ = pardServiceSpecServ;
	}
	public Map getAttrSpecIsCustomizedMap() {
		return attrSpecIsCustomizedMap;
	}
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
	public void setAttrSpecIsCustomizedMap(Map attrSpecIsCustomizedMap) {
		this.attrSpecIsCustomizedMap = attrSpecIsCustomizedMap;
	}
	public Map getAttrSpecPageInTypeMap() {
		return attrSpecPageInTypeMap;
	}
	public void setAttrSpecPageInTypeMap(Map attrSpecPageInTypeMap) {
		this.attrSpecPageInTypeMap = attrSpecPageInTypeMap;
	}
	public List<Map> getComponentList() {
		return componentList;
	}
	public void setComponentList(List<Map> componentList) {
		this.componentList = componentList;
	}
	public List<Map> getSubBusinessCodes() {
		return subBusinessCodes;
	}
	public void setSubBusinessCodes(List<Map> subBusinessCodes) {
		this.subBusinessCodes = subBusinessCodes;
	}
	public List<Map> getProdAttrList() {
		return prodAttrList;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public void setProdAttrList(List<Map> prodAttrList) {
		this.prodAttrList = prodAttrList;
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
	public List<Map<String, String>> getSettleList() {
		return settleList;
	}
	public void setSettleList(List<Map<String, String>> settleList) {
		this.settleList = settleList;
	}
	public JSONArray getSettlementList() {
		return settlementList;
	}
	public void setSettlementList(JSONArray settlementList) {
		this.settlementList = settlementList;
	}
	public JSONArray getPricePlanList() {
		return pricePlanList;
	}
	public void setPricePlanList(JSONArray pricePlanList) {
		this.pricePlanList = pricePlanList;
	}
	public String getCheckDesc() {
		return checkDesc;
	}
	public void setCheckDesc(String checkDesc) {
		this.checkDesc = checkDesc;
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
	public List<OfferProdRel> getOfferProdRelList() {
		return offerProdRelList;
	}
	public void setOfferProdRelList(List<OfferProdRel> offerProdRelList) {
		this.offerProdRelList = offerProdRelList;
	}
	public ProdOfferRel getProdOfferRel() {
		return prodOfferRel;
	}
	public void setProdOfferRel(ProdOfferRel prodOfferRel) {
		this.prodOfferRel = prodOfferRel;
	}
	public List<ProdOfferRel> getProdOfferRelList1() {
		return prodOfferRelList1;
	}
	public void setProdOfferRelList1(List<ProdOfferRel> prodOfferRelList1) {
		this.prodOfferRelList1 = prodOfferRelList1;
	}
	public List<ProdOfferRel> getProdOfferRelList2() {
		return prodOfferRelList2;
	}
	public void setProdOfferRelList2(List<ProdOfferRel> prodOfferRelList2) {
		this.prodOfferRelList2 = prodOfferRelList2;
	}
	public PricingPlan getPricingPlan() {
		return pricingPlan;
	}
	public void setPricingPlan(PricingPlan pricingPlan) {
		this.pricingPlan = pricingPlan;
	}
	public List<PricingPlan> getPricingPlanList() {
		return pricingPlanList;
	}
	public void setPricingPlanList(List<PricingPlan> pricingPlanList) {
		this.pricingPlanList = pricingPlanList;
	}
	public String getProcess_Id() {
		return process_Id;
	}
	public void setProcess_Id(String process_Id) {
		this.process_Id = process_Id;
	}
	public String getActivity_Id() {
		return activity_Id;
	}
	public void setActivity_Id(String activity_Id) {
		this.activity_Id = activity_Id;
	}
	public String getContent_Id() {
		return content_Id;
	}
	public void setContent_Id(String content_Id) {
		this.content_Id = content_Id;
	}
	public ProdAndOfferAuditingServ getProdAndOfferAuditingServ() {
		if(ProdAndOfferAuditingServ==null){
            //取得spring上下文
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// 取得spring bean实例
			ProdAndOfferAuditingServ = (ProdAndOfferAuditingServ)ctx.getBean("eaap-op2-conf-auditing-prodAndOfferServ");
	     }
		return ProdAndOfferAuditingServ;
	}
	public void setProdAndOfferAuditingServ(
			ProdAndOfferAuditingServ prodAndOfferAuditingServ) {
		ProdAndOfferAuditingServ = prodAndOfferAuditingServ;
	}
	public String getCheckState() {
		return checkState;
	}
	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}
	public String getPushMessageType() {
		return pushMessageType;
	}
	public void setPushMessageType(String pushMessageType) {
		this.pushMessageType = pushMessageType;
	}
	public String getPushc_url() {
		return pushc_url;
	}
	public void setPushc_url(String pushc_url) {
		this.pushc_url = pushc_url;
	}
	
//--------------------------------------------------------------------------------	
	
	public List<Map<String, Object>> getServiceSpecAttrList() {
		return serviceSpecAttrList;
	}
	public void setServiceSpecAttrList(List<Map<String, Object>> serviceSpecAttrList) {
		this.serviceSpecAttrList = serviceSpecAttrList;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}	
	public String getFrontEndUrl() {
		return frontEndUrl;
	}
	public void setFrontEndUrl(String frontEndUrl) {
		this.frontEndUrl = frontEndUrl;
	}
	public String getO2pWebDomin() {
		return o2pWebDomin;
	}
	public void setO2pWebDomin(String o2pWebDomin) {
		this.o2pWebDomin = o2pWebDomin;
	}
	
	public String queryPardPordInfo(){
		try{
			if(!"".equals(content_Id)&&null!=content_Id){
				// 获取用户登录状态
				Map roleCodeMap = (Map) session.get("userRoleCode");
				//  获取产品规格基本信息
				product.setProductId(BigDecimal.valueOf(Long.valueOf(content_Id)));
				product = getProdAndOfferAuditingServ().selectProduct(product);
				
				ProductAttr productAttr = new ProductAttr();
				productAttr.setProductId(product.getProductId());
				productAttr.setDisplayType("21");
				List<Map> productAtrrAll= getProdAndOfferAuditingServ().queryProductAttrInfo(productAttr);
				pushc_url=WebPropertyUtil.getPropertyValue("pushc_url");
				attrSpecIsCustomizedMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ATTRSPECISCUSTOMIZED);
				attrSpecPageInTypeMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ATTRSPEC_TYPE);
				//根据规格功能拆分
				Map tempMap=null;
				for(int i=0;i<productAtrrAll.size();i++){
					tempMap=productAtrrAll.get(i);
					if(EAAPConstants.SUB_BUSINESS.equals(tempMap.get("ATTR_SPEC_ID").toString())){//子业务编码
						subBusinessCodes.add(tempMap);
					}else if(EAAPConstants.SERVICE_PROVIDER.equals(tempMap.get("ATTR_SPEC_ID").toString())){//第三方系统编码 即组件
						Map map = new HashMap();
						map.put("componentId", tempMap.get("DEFAULT_VALUE"));
						componentList = getProdAndOfferAuditingServ().queryComponentList(map);
					}else{
						prodAttrList.add(tempMap);
					}
				}
			}
			
			String serviceId = this.getPardServiceSpecServ().getProductServiceRel(content_Id).getServiceId();
			ServiceSpec serviceSpec = new ServiceSpec();
			serviceSpec.setServiceId(new BigDecimal(serviceId));
			serviceName = this.getPardServiceSpecServ().qryServiceSpeclist(serviceSpec).get(0).getServiceName();
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("serviceId", serviceId);
			serviceSpecAttrList = pardServiceSpecServ.qryServiceSpecAttr(params);
			
			processDefImg = CommonUtil.getProcessDefImg(EAAPConstants.PROCESS_MODEL_ID_PRODUCT);
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}
	
	
	public String getProcessDefImg() {
		return processDefImg;
	}
	public void setProcessDefImg(String processDefImg) {
		this.processDefImg = processDefImg;
	}
	private String taskListByProcessId(String pid){
		RestTemplate rest = new RestTemplate();
		String message = rest.getForObject(WebPropertyUtil.getPropertyValue("work_flow_pro_url")+"/task/taskListByProcessId/{processId}",
	    		String.class,pid);
		JSONObject retJson = new JSONObject();
		if(!StringUtils.isEmpty(message)){
			retJson = JSON.parseObject(message);
		}
		return retJson.getString("taskId");
	    
	}
	private Boolean completeTask(Map<String, Object> variables){
		RestTemplate rest = new RestTemplate();
		
		String message = rest.postForObject(WebPropertyUtil.getPropertyValue("work_flow_pro_url")+"/task/completeTask?taskId={taskId}&varJson={varJson}",
	    		null, String.class,variables);
		JSONObject retJson = new JSONObject();
		if(!StringUtils.isEmpty(message)){
			retJson = JSON.parseObject(message);
		}
		return "0000".equals(retJson.getString("code"));
	}
	
	public void checkPardProduct(){
		PrintWriter out = null;
		getResponse().setContentType("text/html;charset=UTF-8");
		try{
			out = getResponse().getWriter();
			if(!CommonUtil.isExitTaskByTaskId(activity_Id)){
				String ret="{\"retCode\":\"0001\",\"retMsg\":\"Task[id="+activity_Id+"] is not find!\"}";
				out.print(ret);
				return;
			}
			String need_Msg_Person = "";
			String statusCd = "1500";
			String retMsg = getText("eaap.op2.conf.orgregauditing.auditingSuccess");		//审核成功
			
			product.setProductId(BigDecimal.valueOf(Long.valueOf(content_Id))) ;
			product = this.getProdAndOfferAuditingServ().selectProduct(product);
			if(null!=product){
				need_Msg_Person = product.getProductProviderId()+"";
				Map<String, Object> taskVariables = new HashMap<String, Object>();
				if(null==activity_Id||"".equals(activity_Id)){
					taskVariables.put("taskId", this.taskListByProcessId(product.getAuditFlowId()));
				}else{
					taskVariables.put("taskId", activity_Id);
				}
				
				JSONObject jsonObject = new JSONObject();
				String messageContent="";
				if("1".equals(checkState)){
					log.info(LogModel.EVENT_APP_EXCPT, "{0} checked product is {1} pass", orgId,content_Id);
					
					product.setProductPublisher(getLoginId());
					jsonObject.put("O2P_audit_result", Boolean.TRUE);
					jsonObject.put("O2P_audit_resultDesc", checkDesc);
					messageContent="O2P Auditing Result:[Product Name:"+product.getProductName()+", Product Id:"+product.getProductId()+"],"+retMsg;
					//发送成功消息
					this.getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_PRODUCT.replace("#id", product.getProductId()+"").replace("#name", product.getProductName()), 
							checkDesc, 1 ,checkDesc, null, need_Msg_Person);
					
					if(EAAPConstants.isCloud()){
						statusCd = "1000";
					}
					
					need_Msg_Person = null;
				 }else if("2".equals(checkState)){
					statusCd = "1298";
				    log.info(LogModel.EVENT_APP_EXCPT, "{0} checked product is {1} not pass", orgId,content_Id);
				    jsonObject.put("O2P_audit_result", Boolean.FALSE);
					jsonObject.put("O2P_audit_resultDesc", checkDesc);
					String msgId = getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_PRODUCT.replace("#id", product.getProductId()+"").replace("#name", product.getProductName()), 
				    		EAAPConstants.WORK_FLOW_MESSAGE_O2P_CHECK_NOT_PASS_SUB_TITLE, 3, checkDesc, null, need_Msg_Person);
					
					StringBuffer msgHandleAddress = new StringBuffer();
					msgHandleAddress.append("/pardProduct/toUpdate.shtml?").append("productId=").append(content_Id).append("&").append("process_Id=").append(process_Id).append("&")
					   .append("message.msgId=").append(msgId);
					Message msg = new Message();
					msg.setMsgId(new BigDecimal(msgId));
					msg.setMsgHandleAddress(msgHandleAddress.toString());
					getMessageServ().modifyMessage(msg);
					retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");	 //此次审核操作不通过，已提交给第三方重新修改信息.
					messageContent="O2P Auditing Result:[Product Name:"+product.getProductName()+", Product Id:"+product.getProductId()+"],"+retMsg+"\nReject Reason:"+checkDesc;
				}
				
				taskVariables.put("varJson", jsonObject.toJSONString());
				if(this.completeTask(taskVariables)){
					product.setStatusCd(statusCd);
					getProdAndOfferAuditingServ().updateProduct(product);
					
				}else{
					retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");	 //此次审核操作不通过，已提交给第三方重新修改信息.
				}
				//选择推送消息类型，消息推送方法
				if(!StringUtils.isEmpty(pushMessageType)){
					Org org=new Org();
					org.setOrgId(product.getProductProviderId());
					org=ProdAndOfferAuditingServ.queryOrg(org);
					org.setEmail(PushCInvokeUtils.decryInvoke(org.getEmail()));
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
				
			}
			
		    String ret="{\"retCode\":\"0000\",\"retMsg\":\""+retMsg+"\"}";
			out.print(ret);
		}catch(Exception e){
			String ret="{\"retCode\":\"9999\",\"retMsg\":\""+com.ailk.eaap.op2.common.CommonUtil.getErrMsg(e)+"\"}";		//提交审核失败
			out.print(ret);
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,com.ailk.eaap.op2.common.CommonUtil.getErrMsg(e),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	public String showProdOfferInfo(){
		if(!"".equals(content_Id)&&null!=content_Id){
			prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id)));
			prodOffer = this.getProdAndOfferAuditingServ().selectProdOffer(prodOffer);
			prodOffer.setFormatEffDate("".equals(StringUtil.valueOf(prodOffer.getEffDate()))?null:DateUtil.convDateToString(prodOffer.getEffDate(), "yyyy-MM-dd")) ;
			prodOffer.setFormatExpDate("".equals(StringUtil.valueOf(prodOffer.getEffDate()))?null:DateUtil.convDateToString(prodOffer.getExpDate(), "yyyy-MM-dd")) ;
			pushc_url=WebPropertyUtil.getPropertyValue("pushc_url");
			offerProdRel.setProdOfferId(prodOffer.getProdOfferId());
			offerProdRelList =  this.getProdAndOfferAuditingServ().selectOfferProdRel(offerProdRel);
			
			prodOfferRel.setOfferAId(prodOffer.getProdOfferId());
			prodOfferRel.setRelTypeCd("100000");
			prodOfferRelList1 = this.getProdAndOfferAuditingServ().selectProdOfferRel(prodOfferRel);//依赖
			
			prodOfferRel.setRelTypeCd("200000");
			prodOfferRelList2 = this.getProdAndOfferAuditingServ().selectProdOfferRel(prodOfferRel);//互斥
			
			//定价计划
			Map pricePlanMap = new HashMap();
			pricePlanMap.put("prodOfferId", prodOffer.getProdOfferId());
			pricingPlanList = this.getProdAndOfferAuditingServ().getPricingPlan(pricePlanMap); 

			//Price Plan定价计划:
			Map map = new HashMap();
			map.put("prodOfferId", prodOffer.getProdOfferId());
			List<PricingPlan> pricingPlansList = this.getProdAndOfferAuditingServ().getPricingPlan(pricePlanMap); 
			for(PricingPlan pricingPlan:pricingPlansList){
				JSONObject pricePlanJSON=new JSONObject();
				pricePlanJSON.put("pricingInfoId", pricingPlan.getPricingInfoId());
				//Price Name:
				pricePlanJSON.put("priceName", pricingPlan.getPricingName());
				//Priority:
				pricePlanJSON.put("priority", pricingPlan.getBillingPriority());
				//Offset Type:
				PricePlanLifeCycle pricePlanLifeCycle = new PricePlanLifeCycle();
				pricePlanLifeCycle.setPricePlanId(Long.valueOf(pricingPlan.getPricingInfoId()));
				pricePlanLifeCycle = this.getProdAndOfferAuditingServ().queryPricePlanLifeCycle(pricePlanLifeCycle);
				if("1".equals(String.valueOf(pricePlanLifeCycle.getSubEffectMode()))){
					//1:Offset
					String offsetType=getMainDataCepName(EAAPConstants.ACTIVATION_OFFSET_TYPE, String.valueOf(pricePlanLifeCycle.getSubEffectMode()))+":  "+pricePlanLifeCycle.getSubDelayUnit() + getMainDataCepName(EAAPConstants.ACTIVATION_OFFSET, String.valueOf(pricePlanLifeCycle.getSubDelayCycle()));
					pricePlanJSON.put("offsetType",offsetType);
				}else{
					//0:Immediately 
					pricePlanJSON.put("offsetType",getMainDataCepName(EAAPConstants.ACTIVATION_OFFSET_TYPE, String.valueOf(pricePlanLifeCycle.getSubEffectMode())));
				}
				//Effective Time:
				pricePlanJSON.put("effectiveDate",pricePlanLifeCycle.getValidUnit() +" " +getMainDataCepName(EAAPConstants.PRICE_PLAN_VALIDITY_PERIOD, pricePlanLifeCycle.getVaildType()));
				//Price Object-Product:
				String priceObjectProduct = this.getProdAndOfferAuditingServ().getPriceObjectProduct(String.valueOf(pricingPlan.getPricingTargetId()));
				pricePlanJSON.put("priceObjectProduct",priceObjectProduct);
				
				//Charge Information:
				JSONArray chargeInformationArray = new JSONArray();
				Map paramMap = new HashMap();
				paramMap.put("priPricingInfoId", pricingPlan.getPricingInfoId());
				List<ComponentPrice> componentPriceList = this.getProdAndOfferAuditingServ().queryComponentPrice(paramMap);
				for(ComponentPrice componentPrice:componentPriceList){
					JSONObject chargeInformationJSON=new JSONObject();
					chargeInformationJSON.put("id",componentPrice.getPriceId());
					chargeInformationJSON.put("type",componentPrice.getPriceType());
					chargeInformationArray.add(chargeInformationJSON);
				}
				pricePlanJSON.put("chargeInformation",chargeInformationArray);
				pricePlanList.add(pricePlanJSON);
			}
			
			//结算信息
//			Map<String,String> settleMap = new HashMap<String,String>();
//			settleMap.put("partnerCode", prodOffer.getOfferProviderId());
//			settleMap.put("servCode", prodOffer.getProdOfferId().toString());
//			settleMap.put("statusCd", EAAPConstants.STATUS_CD_FOR_ADD);
//			settleList = this.getProdAndOfferAuditingServ().getSettleRule(settleMap);
			Map bMap = new HashMap();
			bMap.put("prodOfferId", prodOffer.getProdOfferId());
			List<Map<String, Object>> settleList = this.getProdAndOfferAuditingServ().getSettleListByOperatorId(bMap);
			for(Map<String, Object> dataMap:settleList){
					JSONObject settleJSON=new JSONObject();					
					settleJSON.put("busiId",dataMap.get("BUSIID"));
					//Name:
					settleJSON.put("name",dataMap.get("BUSINAME"));
					//Effective Date:
					settleJSON.put("effectiveDate",dataMap.get("EFFECTIVEDATE"));
					//Product Category:
					String busiType = String.valueOf(dataMap.get("BUSITYPE"));
					settleJSON.put("productCategory",getMainDataCepName(EAAPConstants.SETTLE_DIRECTORY_TYPE, busiType));
					//Description:
					settleJSON.put("description",dataMap.get("DESCRIPTION"));
					
					SettleCycleDef settleCycleDef=new SettleCycleDef();
					settleCycleDef.setPartnerCode(dataMap.get("PARTNERCODE").toString());
					settleCycleDef.setBusiCode(dataMap.get("BUSICODE").toString());
					settleCycleDef.setStatusCd(EAAPConstants.STATUS_CD_FOR_ADD);
					settleCycleDef = this.getProdAndOfferAuditingServ().querySettleCycleDef(settleCycleDef);
					if(null!=settleCycleDef){
						try {
							settleCycleDef.setBillEndDate(this.changeDateFormat(settleCycleDef.getBillEndDate(), "yyyyMMdd", "yyyy-MM-dd"));
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						//First Settlement Date :
						settleJSON.put("firstSettlementDate",settleCycleDef.getBillEndDate());
						//Cycle Type:
						settleJSON.put("cycleType",settleCycleDef.getCycleCount() +" "+getMainDataCepName(EAAPConstants.SETTLE_CYCLE_TYPE,settleCycleDef.getCycleType().toString()));
					}
					
					//Operator:
					Map oMap = new HashMap();
					oMap.put("busiId", dataMap.get("BUSIID").toString());
					List<Map<String, Object>> oList = this.getProdAndOfferAuditingServ().getSettleOperator(oMap);
					if(oList.size()>0){
						Map tMap = oList.get(0);
						String orgName = tMap.get("ORG_NAME").toString();
						settleJSON.put("operator",orgName);
					}else{
						settleJSON.put("operator","");
					}
					
					//Settle Rule Info:
					JSONArray rulesArray = new JSONArray();
					SettleRule settleRule = new SettleRule();
					settleRule.setBusiCode(dataMap.get("BUSICODE").toString());
					settleRule.setServCode(dataMap.get("SERVCODE").toString());
					settleRule.setStatusCd(EAAPConstants.STATUS_CD_FOR_ADD);
					settleRule.setRaiseFlag(0);	
					List<SettleRule> settleRulelist = this.getProdAndOfferAuditingServ().querySettleRule(settleRule);
					for(SettleRule settleRuleTemp:settleRulelist){
						JSONObject rulesJSON=new JSONObject();
						rulesJSON.put("type",settleRuleTemp.getRuleType());
						rulesJSON.put("id",settleRuleTemp.getRuleId());
						rulesArray.add(rulesJSON);
					}
					settleJSON.put("rules",rulesArray);
					settlementList.add(settleJSON);
			}
			
			
			//渠道
			ProdOfferChannel poChannel=new ProdOfferChannel();
			poChannel.setProdOfferId(prodOffer.getProdOfferId());
			List<Channel> pcList= this.getProdAndOfferAuditingServ().getProdOfferChannel(poChannel);
			StringBuilder funcId=new StringBuilder();
			StringBuilder funcValue=new StringBuilder();
			for(Channel pc:pcList){
				funcId.append(pc.getChannelId()).append(",");
				funcValue.append(pc.getChannelName()).append(",");
			}
			FuncSeletedTreeMap.put("funcId", funcId.length()>0?funcId.substring(0, funcId.length()-1):funcId.toString()); 
			FuncSeletedTreeMap.put("funcValue",  funcValue.length()>0?funcValue.substring(0, funcValue.length()-1):funcValue.toString()); 
			FuncSeletedTreeMap.put("funcPath",funcValue.length()>0?funcValue.substring(0, funcValue.length()-1):funcValue.toString()); 
			
			frontEndUrl = WebPropertyUtil.getPropertyValue("frontEnd_url");		//从公共配置文件eaap_common.properties取frontEnd工程地址
			o2pWebDomin = WebPropertyUtil.getPropertyValue("o2p_web_domin");		//从公共配置文件eaap_common.properties取cloud/local标识
			
		}
		
		return SUCCESS;
	}
	
	private String getMainDataCepName(String mdtSign,String ecpCode){
		String retCepName="";
		String serviceStatusCD = this.getMainDateTypeCd(mdtSign);
		List<MainData> mainDataList = this.getMainDate(serviceStatusCD);
		if(mainDataList!=null && mainDataList.size()>0){
			  for(int i=0;i<mainDataList.size();i++){
				  if(ecpCode.equals(mainDataList.get(i).getCepCode())){
					  retCepName=mainDataList.get(i).getCepName();
					  break;
				  }
			  }
		 }
		return retCepName;
	}

	private List<MainData> getMainDate(String mdtName){
		MainData mainData = new MainData();
		mainData.setMdtCd(mdtName);
		List<MainData> mainDateList = this.getTaskService().selectMainData(mainData);
		return mainDateList;
	}
	
	private String getMainDateTypeCd(String mdtSign){
		MainDataType mainDateType = new MainDataType();
		mainDateType.setMdtSign(mdtSign);
		List<MainDataType> mainDateTypeList = this.getTaskService().selectMainDataType(mainDateType);
		String mdtCd = "";
		if(mainDateTypeList.size()>0){
			mdtCd = mainDateTypeList.get(0).getMdtCd();
		}
		return mdtCd;
	}

	private String changeDateFormat(String dateStr,String format1,String format2) throws ParseException{
		if(StringUtil.isBlank(dateStr)){
			return "";
		}
		SimpleDateFormat sdf1 = new SimpleDateFormat(format1);
		SimpleDateFormat sdf2 = new SimpleDateFormat(format2);
		return sdf2.format(sdf1.parse(dateStr));
	}

	public ITaskService getTaskService() {
		if (taskService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			taskService = (ITaskService)ctx.getBean("eaap-op2-conf-task-service-taskService");
		}	
		return taskService;
	}
	public void setTaskService(ITaskService taskService) {
		this.taskService = taskService;
	}
	
	public void checkPardOffer(){
		PrintWriter out = null;
		JSONObject json = new JSONObject();
		try {
			Boolean syncLocalResult = Boolean.TRUE;
			String productId = null;
			String need_Msg_Person = EAAPConstants.PROVIDER_ID;
			json.put("retCode", WebConstants.RESULT_OK);
			
			String retMsg = getText("eaap.op2.conf.orgregauditing.auditingSuccess");		//审核成功
			
			prodOffer.setProdOfferId(BigDecimal.valueOf(Long.valueOf(content_Id))) ;
			prodOffer = this.getProdAndOfferAuditingServ().selectProdOffer(prodOffer);
			
			
			JSONObject jsonObject = new JSONObject();
			String messageContent="";
			if(null!=prodOffer){
				need_Msg_Person = prodOffer.getOfferProviderId();
				prodOffer.setStatusCd("1500");
				Map<String, Object> taskVariables = new HashMap<String, Object>();
				if(null==activity_Id||"".equals(activity_Id)){
					taskVariables.put("taskId", this.taskListByProcessId(String.valueOf(prodOffer.getAuditFlowId())));
				}else{
					taskVariables.put("taskId", activity_Id);
				}
				
				if("1".equals(checkState)){
					log.info(LogModel.EVENT_APP_EXCPT, "{0} checked prodOffer is {1} pass", orgId,content_Id);
					jsonObject.put("O2P_audit_result", Boolean.TRUE);
					messageContent="O2P Auditing Result:[Offer Name:"+prodOffer.getProdOfferName()+", Offer  Id:"+prodOffer.getProdOfferId()+"],"+retMsg;
					jsonObject.put("O2P_audit_resultDesc", checkDesc);
					if(EAAPConstants.isCloud()){
						jsonObject.put("offer_audit_result", "4");
						prodOffer.setStatusCd(EAAPConstants.STATUS_CD_FOR_PRODUCTOFFER_UP_PRICE);
					}else{
						jsonObject.put("offer_audit_result", "3");
					}
					//发送成功消息
					this.getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE.replace("#id", prodOffer.getProdOfferId()+"").replace("#name", prodOffer.getProdOfferName()), 
							checkDesc, 1 ,checkDesc, null, need_Msg_Person);
				 }else if("2".equals(checkState)){
				    prodOffer.setStatusCd("1298");
				    log.info(LogModel.EVENT_APP_EXCPT, "{0} checked prodOffer is {1} not pass", orgId,content_Id);
				    jsonObject.put("O2P_audit_result", Boolean.FALSE);
					jsonObject.put("O2P_audit_resultDesc", checkDesc);
					jsonObject.put("offer_audit_result", "2");
					
					String msgId = getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE.replace("#id", prodOffer.getProdOfferId()+"").replace("#name", prodOffer.getProdOfferName()), 
				    		"o2p audit is fail.", 3, checkDesc, null, need_Msg_Person);
					StringBuffer msgHandleAddress = new StringBuffer();
					msgHandleAddress.append("/pardOffer/toUpdate.shtml?").append("prodOffer.prodOfferId=").append(content_Id).append("&").append("process_Id=").append(process_Id).append("&")
					   .append("message.msgId=").append(msgId);
					
					Message msg = new Message();
					msg.setMsgId(new BigDecimal(msgId));
					msg.setMsgHandleAddress(msgHandleAddress.toString());
					getMessageServ().modifyMessage(msg);
					retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
					messageContent="O2P Auditing Result:[Offer Name:"+prodOffer.getProdOfferName()+", Offer  Id:"+prodOffer.getProdOfferId()+"],"+retMsg+"\nReject Reason:"+checkDesc;
				}
				taskVariables.put("varJson", jsonObject.toJSONString());
				if(this.completeTask(taskVariables)){
					prodOffer.setProdOfferPublisher(getLoginId());
					getProdAndOfferAuditingServ().updateProdOffer(prodOffer);
				}else{
					retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
				}
				//选择推送消息类型，消息推送方法
				if(!StringUtils.isEmpty(pushMessageType)){
					Org org=new Org();
					org.setOrgId(new Integer(prodOffer.getOfferProviderId()));
					org=ProdAndOfferAuditingServ.queryOrg(org);
					org.setEmail(PushCInvokeUtils.decryInvoke(org.getEmail()));
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
			}
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    json.put("retMsg", retMsg);
			out.print(json.toString());
		
		}catch(BusinessException e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				json.put("retCode", WebConstants.RESULT_ERR);
			    json.put("retMsg", e.getMessage());
			    out.print(json.toString());
			    
			}catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,com.ailk.eaap.op2.common.CommonUtil.getErrMsg(e1),null));
			}
		}catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
			    json.put("retCode", WebConstants.RESULT_ERR);
			    json.put("retMsg", com.ailk.eaap.op2.common.CommonUtil.getErrMsg(e));
			    out.print(json.toString());
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,com.ailk.eaap.op2.common.CommonUtil.getErrMsg(e1),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,com.ailk.eaap.op2.common.CommonUtil.getErrMsg(e),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	//邮箱或者短信的targetList的值
	public static PushTargetList setTargetInfoValue(String targetType,Integer targetId,String targetAddress){
		PushTargetList pushTargetInfo=new PushTargetList();
		pushTargetInfo.setTargetType(new BigInteger(targetType));//1-客户id  2-操作员id
		pushTargetInfo.setTargetId(targetId.toString());
		pushTargetInfo.setTargeAddress(targetAddress);
		return pushTargetInfo;
	}
	
//	request.getSession().setAttribute("cardNumber", userInfo);//用户信息
//	request.getSession().setAttribute("sysIdType", sysPerson.getSysIdTypeId()); //用户身份类型（管理员。。）
	private String getLoginId(){
		UserInfo userInfo = (UserInfo) this.getRequest().getSession().getAttribute("cardNumber");
		if(null==userInfo || null == userInfo.getId() || "".equals(userInfo.getId())){
			return EAAPConstants.PROCESS_AUTHENTICATED_USER_ID;
		}
		return userInfo.getId();
	}
	
	public Map getMainInfo(String mainTypeSign) {
		MainDataType mainDataType = new MainDataType();
		MainData mainData = new MainData();
		Map stateMap = new HashMap();

		mainDataType.setMdtSign(mainTypeSign);
		mainDataType = getProdAndOfferAuditingServ().selectMainDataType(mainDataType)
				.get(0);
		mainData.setMdtCd(mainDataType.getMdtCd());
		List<MainData> mainDataList = getProdAndOfferAuditingServ().selectMainData(
				mainData);
		if (mainDataList != null && mainDataList.size() > 0) {
			for (int i = 0; i < mainDataList.size(); i++) {
				stateMap.put(mainDataList.get(i).getCepCode(), mainDataList
						.get(i).getCepName());
			}
		}
		return stateMap;
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
}
