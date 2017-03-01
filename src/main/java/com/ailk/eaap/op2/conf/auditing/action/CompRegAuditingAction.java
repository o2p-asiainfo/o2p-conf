package com.ailk.eaap.op2.conf.auditing.action;
 
import java.math.BigDecimal;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.ICompRegAuditingServ;
import com.ailk.eaap.op2.conf.message.service.MessageServ;
import com.ailk.eaap.op2.loginFilter.bo.UserInfo;
import com.alibaba.fastjson.JSONObject;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.StringUtil;

public class CompRegAuditingAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8558635911496334020L;
	private static Logger log = Logger.getLog(CompRegAuditingAction.class);
	private String activity_Id ;
	private App app  = new App();
	private String process_Id ;
	private String process_Model_Id ;
    private String checkState ;
    private String checkDesc ;
    private String orgId;
    private MessageServ messageServ;

	//--LYL
	private Component component = new Component();
	private Org org = new Org() ;
	private String tmpType ;
	private String content_Id ;
	private Map compInfoMap = new HashMap() ;
	private ICompRegAuditingServ compRegAuditingServ;
	//组件列表
    private List<Map> compInfoList = new ArrayList<Map>() ;
    //查询组件状态列表
    private Map compStateMap = new HashMap() ;
    private List<Map> compStateList = new ArrayList<Map>() ;
    
    private List<Map> comTypeList = new ArrayList<Map>() ;
    private List<Map> appTypeList = new ArrayList<Map>() ;
    private List<Map> appOauthTypeList = new ArrayList<Map>() ;
    
    //分页
    private Pagination page=new Pagination();
    private String chooseCompCode ;
    private String chooseComponentCode ;
    private String chooseOrgId ;
    private String chooseOrgName ;
    private String pageShowMsg;


	public String getChooseOrgId() {
		return chooseOrgId;
	}

	public void setChooseOrgId(String chooseOrgId) {
		this.chooseOrgId = chooseOrgId;
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

	public String getChooseOrgName() {
		return chooseOrgName;
	}

	public void setChooseOrgName(String chooseOrgName) {
		this.chooseOrgName = chooseOrgName;
	}

	private String chooseCompName ;
	private int rows;
	private int pageNum;
	private int total;
	private Pagination pagination = new Pagination();
	private String [] componentTypeIds ;
	private String [] componentStates ;
	public String queryCompInfo(){
		compStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_COMAPP);	
		Iterator iter = compStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			  Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();		  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 compStateList.add(mapTmp) ;
		 }
		component.setComponentId(content_Id) ;
		compInfoMap = getCompRegAuditingServ().queryCompInfo(component).get(0) ;
	    if("info".equals(tmpType)){
	    	return "successtoinfo" ;
	    }else if("edit".equals(tmpType)){
			return "successtoedit" ;
	    }else{
	    	return SUCCESS ;
	    }	
	}
	private String getLoginId(){
		UserInfo userInfo = (UserInfo) this.getRequest().getSession().getAttribute("cardNumber");
		if(null!=userInfo){
			return userInfo.getId();
		}
		return EAAPConstants.PROCESS_AUTHENTICATED_USER_ID;
	}
	
	public String checkCompOnline(){
		try{
			
			component.setComponentId(content_Id) ;
			List<Map> compList = getCompRegAuditingServ().queryCompInfo(component);
			String javascript ="art.dialog.alert('"+getText("eaap.op2.conf.proof.OperationTips")+"','"+getText("eaap.op2.conf.orgregauditing.auditingSuccess")+"');$('#reloadDataTable').click();art.dialog.close();";
			
			if(null!=compList){
				Map comp = compList.get(0);
				JSONObject jsonObject = new JSONObject();
				Map<String, Object> taskVariables = new HashMap<String, Object>();
				taskVariables.put("taskId", activity_Id);
				
				if("1".equals(checkState)){
					component.setState(EAAPConstants.COMM_STATE_ONLINE) ;
					jsonObject.put("o2pAuditResult", Boolean.TRUE);
					
					getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_COM.replace("#id", content_Id).replace("#name", String.valueOf(comp.get("name"))), 
							checkDesc, 1, checkDesc, null, String.valueOf(comp.get("org_id")));
				}else if("2".equals(checkState)){
					component.setState(EAAPConstants.COMM_STATE_NOPASSAUDI) ;
					jsonObject.put("o2pAuditResult", Boolean.FALSE);
					
					String msgId = getMessageServ().addMsg(new BigDecimal(getLoginId()), "1", EAAPConstants.WORK_FLOW_MESSAGE_TITLE_COM.replace("#id", content_Id).replace("#name", String.valueOf(comp.get("name"))), 
				    		"o2p audit is fail.", 3, checkDesc, null, String.valueOf(comp.get("org_id")));
					
					StringBuffer msgHandleAddress = new StringBuffer();
					msgHandleAddress.append("/portal/provider/provOperator.shtml?state=E&").append("componentId=").append(content_Id).append("&").append("process_Id=").append(process_Id).append("&")
					   .append("message.msgId=").append(msgId);
					Message msg = new Message();
					msg.setMsgId(new BigDecimal(msgId));
					msg.setMsgHandleAddress(msgHandleAddress.toString());
					getMessageServ().modifyMessage(msg);
					
					javascript ="art.dialog.alert('"+getText("eaap.op2.conf.proof.OperationTips")+"','"+getText("eaap.op2.conf.orgregauditing.auditingFail")+"');$('#reloadDataTable').click();art.dialog.close();";
				}
				jsonObject.put("o2pAuditResultDesc", checkDesc);
				taskVariables.put("varJson", jsonObject.toJSONString());
				if(CommonUtil.completeTask(taskVariables)){
					getCompRegAuditingServ().checkCompOnline(component) ;
				}else{
				}
			}
			addActionScript(javascript);
		}catch(Exception e){
			log.debug(e.getMessage());
		}
		return null ;
	}

	public String showCompList(){
	 
	    orgId = null;
		compStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_COMAPP);	
		Iterator iter = compStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			  Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();		  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 compStateList.add(mapTmp) ;
		 }
		  Map comTypeMap1 = new HashMap();
		  Map comTypeMap2 = new HashMap();
		  comTypeMap1.put("comTypeCode", "1") ;
		  comTypeMap1.put("comTypeName", getText("eaap.op2.conf.compregauditing.ITtype")) ;
		  
		  comTypeMap2.put("comTypeCode", "2") ;
		  comTypeMap2.put("comTypeName", getText("eaap.op2.conf.compregauditing.appType")) ;

			Map mapTemp = new HashMap(); 
		  comTypeList = getCompRegAuditingServ().queryCompTypeNCList(mapTemp);
		 return SUCCESS ;
	}
	
	
	
	public Map getCompList(Map para){
		
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		 
		startRow = (pageNum - 1) * rows + 1;
		 
		Map returnMap = new HashMap();

		 componentTypeIds =getRequest().getParameterValues("componentTypeIds");
		 String tmpcomponentTypeIds ="" ;
		if(componentTypeIds!=null && componentTypeIds.length>=1){
			StringBuffer idBf = new StringBuffer();
			 for(String componentTypeId:componentTypeIds){
				 //tmpcomponentTypeIds+=componentTypeId+",";
				 idBf.append(componentTypeId).append(",");
			 }
			 tmpcomponentTypeIds = idBf.toString();
			 tmpcomponentTypeIds = tmpcomponentTypeIds.substring(0,tmpcomponentTypeIds.length()-1);
		 }
		
		String tmpComponentState ="" ;
		componentStates =getRequest().getParameterValues("componentStates");
		 if(componentStates!=null && componentStates.length>=1){
			 String[] tempComponentStates ;
			 tempComponentStates = componentStates[0].split(",");
			 for(String componentState:tempComponentStates){
				 tmpComponentState+="'" + componentState+ "'" + ",";
			 }
			 tmpComponentState = tmpComponentState.substring(0,tmpComponentState.length()-1);
		 }
		
		 Map map = new HashMap() ;

		 map.put("queryType", "ALLNUM") ;
		 
		 map.put("code", "".equals(getRequest().getParameter("component.componentId"))?null:getRequest().getParameter("component.componentId")) ;
		 map.put("name", "".equals(getRequest().getParameter("component.name"))?null:getRequest().getParameter("component.name")) ;
		 if(StringUtil.valueOf(getRequest().getParameter("component.name")).equals(getText("eaap.op2.conf.manager.auth.canlike"))){
			 map.put("name",null);
		 }
		 
		 if(!"".equals(tmpcomponentTypeIds)){
			 map.put("componentTypeId", "("+tmpcomponentTypeIds+")") ;
		 }
		 map.put("appkey", "".equals(getRequest().getParameter("app.appkey"))?null:getRequest().getParameter("app.appkey")) ;
		 map.put("orgName", "".equals(getRequest().getParameter("org.name"))?null:getRequest().getParameter("org.name")) ;
		 if(!"".equals(para.get("queryParamsData"))&&para.get("queryParamsData")!=null){
				map.put("orgName", para.get("queryParamsData")); 
			 }
		 if(!"".equals(tmpComponentState)){
			 map.put("state", "("+tmpComponentState+")") ;
		 }else{
			 String isInit = getRequest().getParameter("isInit");  
			 if(StringUtil.isEmpty(isInit)){
				 map.put("state","('D')"); 
			 }
		 }
		 total = Integer.valueOf(String.valueOf(getCompRegAuditingServ().queryCompInfoList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
         map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", (pageNum - 1) * rows);
	     map.put("page_record", rows);
      
		compInfoList =getCompRegAuditingServ().queryCompInfoList(map) ;
		
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(compInfoList));
	    return returnMap ;
	}
	
	
	
	
	public String chooseCompInfo(){
		compStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_COMAPP);	
		Iterator iter = compStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			  Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();		  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 compStateList.add(mapTmp) ;
		 }
		  Map comTypeMap1 = new HashMap();
		  Map comTypeMap2 = new HashMap();
		  Map comTypeMap3 = new HashMap();
		  comTypeMap1.put("comTypeCode", "1") ;
		  comTypeMap1.put("comTypeName", getText("eaap.op2.conf.compregauditing.ITtype")) ;
		  
		  comTypeMap2.put("comTypeCode", "2") ;
		  comTypeMap2.put("comTypeName", getText("eaap.op2.conf.compregauditing.appType")) ;
		  
		  comTypeMap3.put("comTypeCode", "3") ;
		  comTypeMap3.put("comTypeName", getText("eaap.op2.conf.compregauditing.webType")) ;

		  Map map = new HashMap();
		  comTypeList = getCompRegAuditingServ().queryCompTypeNCList(map);
		 return SUCCESS ;
	}
	
	public String preAddCompInfo(){
		 
		compStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_COMAPP);	
		Iterator iter = compStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			  Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();		  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 compStateList.add(mapTmp) ;
		 }
		  
		  Map comTypeMap1 = new HashMap();
		  Map comTypeMap2 = new HashMap();
		  Map comTypeMap3 = new HashMap();
		  comTypeMap1.put("comTypeCode", "1") ;
		  comTypeMap1.put("comTypeName", getText("eaap.op2.conf.compregauditing.ITtype")) ;
		  
		  comTypeMap2.put("comTypeCode", "2") ;
		  comTypeMap2.put("comTypeName", getText("eaap.op2.conf.compregauditing.appType")) ;
		  
		  comTypeMap3.put("comTypeCode", "3") ;
		  comTypeMap3.put("comTypeName", getText("eaap.op2.conf.compregauditing.webType")) ;

		  Map map = new HashMap();
		  comTypeList = getCompRegAuditingServ().queryCompTypeNCList(map);
		  
		  Map appTypeMap1 = new HashMap();
		  Map appTypeMap2 = new HashMap();
		 
		  appTypeMap1.put("appTypeCode", "1") ;
		  appTypeMap1.put("appTypeName", getText("eaap.op2.conf.compregauditing.apptype1")) ;
		  
		  appTypeMap2.put("appTypeCode", "2") ;
		  appTypeMap2.put("appTypeName", getText("eaap.op2.conf.compregauditing.apptype2")) ;
		  
		  appTypeList.add(appTypeMap1);
		  appTypeList.add(appTypeMap2);
		  
		  Map appOauthTypeMap = new HashMap();
		  appOauthTypeMap.put("appOauthTypeCode", "2") ;
		  appOauthTypeMap.put("appOauthTypeName", getText("eaap.op2.conf.compregauditing.appOauthType1")) ;
		  
		  appOauthTypeList.add(appOauthTypeMap);
		  
		  if("edit".equals(tmpType)){
			  compInfoMap = getCompRegAuditingServ().queryCompInfo(component).get(0) ;
			  app.setComponentId(String.valueOf(compInfoMap.get("COMPONENT_ID"))) ;
			  List<App> tmpAppList = getCompRegAuditingServ().selectAPP(app);
			  if(tmpAppList!=null&&tmpAppList.size()>0){
				  app = getCompRegAuditingServ().selectAPP(app).get(0) ;
			  }else{
				  app = new App();
				  String time = String.valueOf(new Date().getTime());
				  app.setAppkey(StringUtil.Md5("APPKEY"+time+makeAwardNo(9999)));
				  app.setAppsecure(StringUtil.Md5("APPSECRET"+time+makeAwardNo(9999)));
			  }
//			  if("2".equals(String.valueOf(compInfoMap.get("COMPONENT_TYPE_ID")))){ 
//			  }
			  getRequest().getSession().setAttribute("tempComponentId",component.getComponentId());
			  return "successtoedit" ;
		  }else{
			  	getRequest().getSession().setAttribute("tempComponentId","");
			    String time = String.valueOf(new Date().getTime()) ;
			    app.setAppkey(StringUtil.Md5("APPKEY"+time+makeAwardNo(9999)));
				app.setAppsecure(StringUtil.Md5("APPSECRET"+time+makeAwardNo(9999)));
		  }
		  
	    return SUCCESS; 
	}

	
	public String updateCompInfo(){
		if(!"".equals(StringUtil.valueOf(component.getComponentId()))){
			getCompRegAuditingServ().updateComp(component);
		}
		if(!"".equals(StringUtil.valueOf(app.getAppId()))){
			getCompRegAuditingServ().updateApp(app);
		}else{
			String returnAppId = getCompRegAuditingServ().selectSeqApp();
		    app.setAppId(Integer.valueOf(returnAppId));
			app.setAppDeve(Integer.valueOf(component.getOrgId()));
			app.setComponentId(component.getComponentId()); 
			getCompRegAuditingServ().saveApp(app);
		}	
//		if(!"".equals(StringUtil.valueOf(app.getAppId())) && "2".equals(StringUtil.valueOf(component.getComponentTypeId()))){
//			getCompRegAuditingServ().updateApp(app) ;
//		}
	   return SUCCESS ;
	}
	
	public String insertCompInfo(){
		component.setState(EAAPConstants.COMM_STATE_ONLINE);
		String compId = getCompRegAuditingServ().addComp(component);
		String returnAppId = getCompRegAuditingServ().selectSeqApp();
	    app.setAppId(Integer.valueOf(returnAppId)) ;
	    app.setAppOauthType("".equals(getRequest().getParameter("app.appOauthType"))?null:getRequest().getParameter("app.appOauthType"));
	    app.setAppsecure("".equals(getRequest().getParameter("app.appsecure"))?null:getRequest().getParameter("app.appsecure"));
		app.setAppDeve(Integer.valueOf(component.getOrgId())) ;
		app.setComponentId(compId) ; 
		getCompRegAuditingServ().saveApp(app);
		
//		if("2".equals(String.valueOf(component.getComponentTypeId()))){
//		}
	    return SUCCESS ;
	}
	
	public String deleteComp(){
		if(!StringUtil.valueOf(content_Id).equals("")){
			component.setComponentId(content_Id);
			component.setState("X") ;
			getCompRegAuditingServ().updateComp(component);
		}
		
		return SUCCESS;
	}
	
	public Map getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map stateMap = new HashMap() ;
	  	   
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = getCompRegAuditingServ().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  List<MainData> mainDataList = getCompRegAuditingServ().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }
	
	
	
	/**
	 * 得到随机的信息资源
	 * 
	 * @param lngMax
	 * @return
	 * @throws Exception
	 */
	public static String makeAwardNo(long lngMax){
		SecureRandom random;
		String value = "";
		try {
			random = SecureRandom.getInstance("SHA1PRNG");
			value = String.valueOf(Math.abs(random.nextLong()  % lngMax));
		} catch (NoSuchAlgorithmException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return value;
	}
	
	
	public   String refreshSecret(){
		String time = String.valueOf(new Date().getTime()) ;
		 
		return StringUtil.Md5("APPSECRET"+time+makeAwardNo(9999));
		 
	}
	
	//验证component的编码是否存在。
	public boolean validatorComponentInfo(String verifyParam ,String paramValue) {
		if (getRequest().getSession().getAttribute("tempComponentId") != null 
				&& !"".equals(getRequest().getSession().getAttribute("tempComponentId"))) {
			component.setComponentId((String) getRequest().getSession().getAttribute("tempComponentId"));
		}else{
			component.setComponentId(null);
		}
		component.setCode(paramValue);
		List<Component> componentList = new ArrayList<Component>();
		componentList = getCompRegAuditingServ().validatorComponentInfoExistList(component);
		
		return componentList==null||componentList.size()<1?true:false;
	}	
	
	
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
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

	public String getTmpType() {
		return tmpType;
	}

	public void setTmpType(String tmpType) {
		this.tmpType = tmpType;
	}
	public CompRegAuditingAction() {		
	}
	public Component getComponent() {
		return component;
	}
	public void setComponent(Component component) {
		this.component = component;
	}
	public Map getCompStateMap() {
		return compStateMap;
	}
	public void setCompStateMap(Map compStateMap) {
		this.compStateMap = compStateMap;
	}
	public Map getCompInfoMap() {
		return compInfoMap;
	}
	public void setCompInfoMap(Map compInfoMap) {
		this.compInfoMap = compInfoMap;
	}
	public ICompRegAuditingServ getCompRegAuditingServ() {
		if(compRegAuditingServ==null){
            //取得spring上下文
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				// 取得spring bean实例
				//logginService = (ILoginServ)ctx.getBean("eaap-op2-portal-login-LoginServ");
				compRegAuditingServ = (ICompRegAuditingServ)ctx.getBean("eaap-op2-conf-auditing-compServ");
			   
	     }
		return compRegAuditingServ;
	}
	public void setCompRegAuditingServ(ICompRegAuditingServ compRegAuditingServ) {
		this.compRegAuditingServ = compRegAuditingServ;
	}
	public List<Map> getCompInfoList() {
		return compInfoList;
	}
	public void setCompInfoList(List<Map> compInfoList) {
		this.compInfoList = compInfoList;
	}
	public List<Map> getCompStateList() {
		return compStateList;
	}
	public void setCompStateList(List<Map> compStateList) {
		this.compStateList = compStateList;
	}

	public List<Map> getComTypeList() {
		return comTypeList;
	}

	public void setComTypeList(List<Map> comTypeList) {
		this.comTypeList = comTypeList;
	}

	public String getChooseCompCode() {
		return chooseCompCode;
	}

	public void setChooseCompCode(String chooseCompCode) {
		this.chooseCompCode = chooseCompCode;
	}

	public String getChooseCompName() {
		return chooseCompName;
	}

	public void setChooseCompName(String chooseCompName) {
		this.chooseCompName = chooseCompName;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String[] getComponentTypeIds() {
		return componentTypeIds;
	}

	public void setComponentTypeIds(String[] componentTypeIds) {
		this.componentTypeIds = Arrays.copyOf(componentTypeIds, componentTypeIds.length);
	}

	public App getApp() {
		return app;
	}

	public void setApp(App app) {
		this.app = app;
	}

	public Pagination getPagination() {
		return pagination;
	}

	public List<Map> getAppTypeList() {
		return appTypeList;
	}

	public void setAppTypeList(List<Map> appTypeList) {
		this.appTypeList = appTypeList;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String[] getComponentStates() {
		return componentStates;
	}

	public void setComponentStates(String[] componentStates) {
		this.componentStates = Arrays.copyOf(componentStates, componentStates.length);
	}
	 
	public String getChooseComponentCode() {
		return chooseComponentCode;
	}
 
	public void setChooseComponentCode(String chooseComponentCode) {
		this.chooseComponentCode = chooseComponentCode;
	}

	public String getPageShowMsg() {
		return pageShowMsg;
	}

	public void setPageShowMsg(String pageShowMsg) {
		this.pageShowMsg = pageShowMsg;
	}

	public List<Map> getAppOauthTypeList() {
		return appOauthTypeList;
	}

	public void setAppOauthTypeList(List<Map> appOauthTypeList) {
		this.appOauthTypeList = appOauthTypeList;
	}
}
