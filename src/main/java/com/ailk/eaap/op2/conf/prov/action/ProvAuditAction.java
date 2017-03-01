package com.ailk.eaap.op2.conf.prov.action;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.security.SecurityUtil;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.FileShare;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.pushc.PushTargetList;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.IBusiDataInfoServ;
import com.ailk.eaap.op2.conf.manager.action.ConfManagerAction;
import com.ailk.eaap.op2.conf.message.service.MessageServ;
import com.ailk.eaap.op2.conf.prov.service.IProvAuditService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.loginFilter.bo.UserInfo;
import com.alibaba.fastjson.JSONObject;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.integration.o2p.web.util.PushCInvokeUtils;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;

public class ProvAuditAction extends BaseAction {
	/**
	 * 数值规范:
	 * 查询:query+方法名(queryApiDocument)
	 * 增加：add+方法名(addApiDocument)
	 * 删除：delete+方法名(deleteApiDocument)
	 * 修改：update+方法名(updateApiDocument)
	 * 展示:find+方法名(findApiDocument)  
	 */
	private static final long serialVersionUID = 1L;
	
	private static Log log = LogFactory.getLog(ProvAuditAction.class);
	
    private IProvAuditService provAuditService;
    
    private Org org;
    
    private Component component;
    
    private String applyTime;
    
    private List<Map<String, Object>> findAbilityList;
    
    private List<Map<String, Object>> findOrgList;
    //审核结果
    private String result;
    //审核内容
    private String proposal;
    private String pushMessageType;
    private String pushc_url;
    //系统登录ID
    private String user_Id;
	//流程ID
    private String process_Id;
    //环节ID
    private String activity_Id;
    //系统组件ID
    private String content_Id;
    
    private String audiResult;
    public String processDefImg;
    
    @SuppressWarnings("unchecked")
	private List<Map> selectStateList = new ArrayList<Map>();
    
    private Map orgStateMap = new HashMap() ;
    
    private FileShare fileShare = new FileShare();
    
    ConfManagerAction cm = new ConfManagerAction();
    private List<Map<String, Object>> showPackageList;
    private MessageServ messageServ;
	private IBusiDataInfoServ busiDataInfoServ;

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
    public List<Map<String, Object>> getShowPackageList() {
		return showPackageList;
	}

	public void setShowPackageList(List<Map<String, Object>> showPackageList) {
		this.showPackageList = showPackageList;
	}

	public Map getOrgStateMap() {
		return orgStateMap;
	}

	public void setOrgStateMap(Map orgStateMap) {
		this.orgStateMap = orgStateMap;
	}

	/**
	 * 获取应用能力服务组件
	 * @param componentId
	 * @return
	 */
	public String provAuditIndex(){
		if(audiResult!=null && !audiResult.equals("")){
			component = new Component();
			pushc_url=WebPropertyUtil.getPropertyValue("pushc_url");
			if(!getRequest().getParameter("content_Id").equals("")){
				content_Id = getRequest().getParameter("content_Id");
				component.setComponentId(content_Id);//这个系统ID也是传进来的
				component = getProvAuditService().showComponent(component);
				if(component != null){
					Map mapTemp = new HashMap();  
					mapTemp.put("orgId", component.getOrgId().toString());		///
					findOrgList = getProvAuditService().showOrgList(mapTemp);
					if(findOrgList.size()>0){
						Map orgInfoMap = findOrgList.get(0);
						 if(orgInfoMap.get("EMAIL")!=null && !orgInfoMap.get("EMAIL").equals("")){
				    	   String emailPlaintext = SecurityUtil.getInstance().decryMsg(orgInfoMap.get("EMAIL").toString());
				    	   orgInfoMap.put("EMAIL",emailPlaintext);	 
				    	  }
				    	  if(orgInfoMap.get("CERTNUMBER")!=null && !orgInfoMap.get("CERTNUMBER").equals("")){
				    	   String certNumberPlaintext = SecurityUtil.getInstance().decryMsg(orgInfoMap.get("CERTNUMBER").toString());
				    	   orgInfoMap.put("CERTNUMBER",certNumberPlaintext);	 
				    	  }
				    	  if(orgInfoMap.get("TELEPHONE")!=null && !orgInfoMap.get("TELEPHONE").equals("")){
				    		   String telephonePlaintext = SecurityUtil.getInstance().decryMsg(orgInfoMap.get("TELEPHONE").toString());
				    		   orgInfoMap.put("TELEPHONE",telephonePlaintext);	 

					    	 }
				    	  List<Map<String, Object>> findOrgListtemp = new ArrayList();
				    	  findOrgListtemp.add(orgInfoMap);
				    	  findOrgList = findOrgListtemp;
					    	   
					}
				    
					applyTime = DateUtil.convDateToString(component.getRegTime(),"yyyy-MM-dd HH:mm");	
					Map map1 = new HashMap();  
					map1.put("componentId", component.getComponentId());		///
					findAbilityList = getProvAuditService().provAbility(map1);
					Map map2 = new HashMap();  
					map2.put("componentId", component.getComponentId());		///
					showPackageList = getProvAuditService().showPackage(map2);	
					
					selectSerInvokeInsList("");
					orgStateMap = cm.getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG);
					//获取流程图片
					processDefImg = CommonUtil.getProcessDefImg("ott_" + content_Id);
				}
			}	
		}	
		return SUCCESS;
	}

	/**
	 * 审核提交功能
	 * @param componentId
	 * @return
	 */
	public void provAuditSubmit(){
		PrintWriter out = null;
		try {
			getResponse().setContentType("text/html;charset=UTF-8");
			out = getResponse().getWriter();
			if(!CommonUtil.isExitTaskByTaskId(activity_Id)){
				String ret="{\"retCode\":\"0001\",\"retMsg\":\"Task[id="+activity_Id+"] is not find!\"}";
				out.print(ret);
				return;
			}
			component = new Component();
			component.setComponentId(content_Id);
			component = getProvAuditService().showComponent(component);
			String retMsg = getText("eaap.op2.conf.orgregauditing.auditingSuccess");		//审核成功
			
			if(audiResult!=null && !audiResult.equals("")){
				String act_Values = "";
				String state = "";
				String messageContent="";
				JSONObject jsonObject = new JSONObject();
				Map<String, Object> taskVariables = new HashMap<String, Object>();
				taskVariables.put("taskId", activity_Id);
				//1是审核通过，2是审核不通过
				if(result.equals("1")){
					act_Values ="audit_result=" + result + ",suggestion="+proposal;
					messageContent="O2P Auditing Result:[System Name:"+component.getName()+", System  Id:"+component.getComponentId()+"],"+retMsg;
					jsonObject.put("o2pAuditResult", Boolean.TRUE);
					state = EAAPConstants.COMM_STATE_ONLINE;
					
					getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_COM.replace("#id", component.getComponentId()).replace("#name", component.getName()), 
							proposal, 1, proposal, null, String.valueOf(component.getOrgId()));
				}else if(result.equals("2")){
					act_Values ="audit_result=" + result + ",suggestion="+proposal;
					jsonObject.put("o2pAuditResult", Boolean.FALSE);
					if(null != component.getState() && !"".equals(component.getState())){
						if(EAAPConstants.COMM_STATE_WAITAUDI.equals(component.getState())){//提交待审核状态
							state = EAAPConstants.COMM_STATE_NOPASSAUDI;//提交审核不通过
						}else{
							state = EAAPConstants.COMM_STATE_NOUPGRADE;//升级审核不通过
						}
					}
					String msgId = getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_COM.replace("#id", component.getComponentId()).replace("#name", component.getName()), 
				    		"o2p audit is fail.", 3, proposal, null, String.valueOf(component.getOrgId()));
					
					StringBuffer msgHandleAddress = new StringBuffer();
					msgHandleAddress.append("/provider/provOperator.shtml?state=E&").append("componentId=").append(content_Id).append("&").append("process_Id=").append(process_Id).append("&")
					   .append("message.msgId=").append(msgId);
					Message msg = new Message();
					msg.setMsgId(new BigDecimal(msgId));
					msg.setMsgHandleAddress(msgHandleAddress.toString());
					getMessageServ().modifyMessage(msg);
					
					retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");		//此次审核操作不通过，已提交给第三方重新修改信息.
					messageContent="O2P Auditing Result:[System Name:"+component.getName()+", System  Id:"+component.getComponentId()+"],"+retMsg+"\nReject Reason:"+proposal;
				}
				jsonObject.put("o2pAuditResultDesc", act_Values);
				taskVariables.put("varJson", jsonObject.toJSONString());
				if(CommonUtil.completeTask(taskVariables)){
					getProvAuditService().updateAuditing(content_Id, state);
				}else{
					retMsg = getText("eaap.op2.conf.orgregauditing.auditingFail");	 //此次审核操作不通过，已提交给第三方重新修改信息.
				}
				//选择推送消息类型，消息推送方法
				if(!StringUtils.isEmpty(pushMessageType)){
					Org org=new Org();
					org.setOrgId(component.getOrgId());
					org=provAuditService.queryOrg(org);
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
		    String ret="{\"retCode\":\"0000\",\"retMsg\":\""+retMsg+"\"}";
			out.print(ret);
		
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
			    String ret="{\"retCode\":\"9999\",\"retMsg\":\""+e.getMessage()+"\"}";		//提交审核失败
				out.print(ret);
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),e1));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),e));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
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
		
	public IProvAuditService getProvAuditService() {
		if(provAuditService == null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			provAuditService = (IProvAuditService)ctx.getBean("eaap-op2-conf-auditing-ProvAuditService");			   
     }
		return provAuditService;
	}

	//邮箱或者短信的targetList的值
	public static PushTargetList setTargetInfoValue(String targetType,Integer targetId,String targetAddress){
		PushTargetList pushTargetInfo=new PushTargetList();
		pushTargetInfo.setTargetType(new BigInteger(targetType));//1-客户id  2-操作员id
		pushTargetInfo.setTargetId(targetId.toString());
		pushTargetInfo.setTargeAddress(targetAddress);
		return pushTargetInfo;
	}

	public void setProvAuditService(IProvAuditService provAuditService) {
		this.provAuditService = provAuditService;
	}



	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public Component getComponent() {
		return component;
	}


	public void setComponent(Component component) {
		this.component = component;
	}

	public String getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public List<Map<String, Object>> getFindAbilityList() {
		return findAbilityList;
	}

	public void setFindAbilityList(List<Map<String, Object>> findAbilityList) {
		this.findAbilityList = findAbilityList;
	}

	public String getActivity_Id() {
		return activity_Id;
	}

	public void setActivity_Id(String activity_Id) {
		this.activity_Id = activity_Id;
	}

	public String getUser_Id() {
		return user_Id;
	}

	public void setUser_Id(String user_Id) {
		this.user_Id = user_Id;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getProposal() {
		return proposal;
	}

	public void setProposal(String proposal) {
		this.proposal = proposal;
	}

	public String getContent_Id() {
		return content_Id;
	}

	public void setContent_Id(String content_Id) {
		this.content_Id = content_Id;
	}

	public String getProcess_Id() {
		return process_Id;
	}

	public void setProcess_Id(String process_Id) {
		this.process_Id = process_Id;
	}

	public List<Map<String, Object>> getFindOrgList() {
		return findOrgList;
	}

	public void setFindOrgList(List<Map<String, Object>> findOrgList) {
		this.findOrgList = findOrgList;
	}

	public String getAudiResult() {
		return audiResult;
	}

	public void setAudiResult(String audiResult) {
		this.audiResult = audiResult;
	}
	@SuppressWarnings("unchecked")
	public String  selectSerInvokeInsList(String mark){
	  Map serInvokeInsStateMap1 = new HashMap();
	  Map serInvokeInsStateMap2 = new HashMap();
	  serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.prov.audiOk"));
	  serInvokeInsStateMap1.put("code", "1");			 
	  serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.audiNo"));
	  serInvokeInsStateMap2.put("code", "2");	
	  selectStateList.add(serInvokeInsStateMap1);
	  selectStateList.add(serInvokeInsStateMap2);		 
	  return SUCCESS ;
	}
	
	
	
	public String readImg(){
		try {		
		HttpServletResponse response = getResponse() ; 
		java.sql.Blob blob = null;
		List<Map<String, Object>> fileShareList = getProvAuditService().selectFileShare(fileShare.getSFileId().toString());
		if(fileShareList != null){
			for(Map<String, Object> item : fileShareList){
				blob = (Blob) item.get("SFILECONTENT");
				int length = (int) blob.length();
				byte[] byteArr = blob.getBytes(1, length);
				response.setContentType("image/jpeg") ; 
				OutputStream ops = response.getOutputStream();
				for (int i = 0; i < byteArr.length; i++) {
					ops.write(byteArr[i]);
				}
				ops.flush();
				ops.close();				
				}
			}	
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
		return null ;
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
	
	
	public List<Map> getSelectStateList() {
		return selectStateList;
	}

	public void setSelectStateList(List<Map> selectStateList) {
		this.selectStateList = selectStateList;
	}

	public FileShare getFileShare() {
		return fileShare;
	}

	public void setFileShare(FileShare fileShare) {
		this.fileShare = fileShare;
	}
	public String getProcessDefImg() {
		return processDefImg;
	}
	public void setProcessDefImg(String processDefImg) {
		this.processDefImg = processDefImg;
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


}
