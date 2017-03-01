package com.ailk.eaap.op2.conf.manager.action;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.proofmanage.service.IProofEffectService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.struts.BaseAction;

public class ShowAddressAction extends BaseAction {
	private static final long serialVersionUID = -3652512071296248967L;
	private Logger log = Logger.getLog(this.getClass());
	
	private String serInvokeInsId;
	private IProofEffectService proofeffectService;// spring注入对象业务
    private IConfManagerServ confManagerServ ;
	private String pageWebserviceAdd;//页面webservice地址
	private String pageHttpAdd;//页面http地址
	private String pageRestAdd;//页面rest地址
	private String url;//后台部署的URL
	private Map serInvokeInsMap = new HashMap() ;
	private List<Map> messgeFlowList = new ArrayList<Map>();
	private String msFlowUrl;
	/**
	 * 查看调用实例的访问地址
	 * @return
	 */
	public String showAddress(){
		url = getFinalPath();
		msFlowUrl = WebPropertyUtil.getPropertyValue("MESSAGE_FLOW_URL");
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		
		pageWebserviceAdd = getWebserviceAdd(tenantId.toString());
		pageHttpAdd = getHttpAdd(tenantId.toString());
		pageRestAdd = getRestAdd(tenantId.toString());
		
//		getRequest().getServerName()
		//messgeFlowList = getConfManagerServ().selectMessgeFlowList(null);
		log.info("messgeFlowList"+messgeFlowList);
		 Map paramap = new HashMap();
	     paramap.put("serInvokeInsId", serInvokeInsId) ;
	     serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
	     log.info("serInvokeInsMap"+serInvokeInsMap);
		return SUCCESS;
	}
	/*         内部方法区            */
	private String getRestAdd(String tenantId) {
		Map map = new HashMap();
 	   	map.put("serInvokeInsId", serInvokeInsId);
		List<Map<String,String>> listRestAddress = this.getProofeffectService().getRestAddress(map);
		String finalUrl = null;
		if(null != listRestAddress && listRestAddress.size() > 0){
			String resource = listRestAddress.get(0).get("ATTR_SPEC_VALUE");
			if(null != resource){
				finalUrl = url+tenantId+"/"+"rest"+resource;
			}
		}
		return finalUrl;
	}

	private String getHttpAdd(String tenantId) {
		Map map = new HashMap();
 	   	map.put("serInvokeInsId", serInvokeInsId);
		List<Map<String,String>> listHttpAddress = this.getProofeffectService().getHttpAddress(map);
		String finalUrl = null;
		if(null != listHttpAddress && listHttpAddress.size() > 0){
			String serviceCode = listHttpAddress.get(0).get("SERVICE_CODE");
			if(null != serviceCode ){
				finalUrl = url+tenantId+"/"+"http"+"/"+serviceCode;
			}
		}
		return finalUrl;
	}
	private String getWebserviceAdd(String tenantId) {
		Map map = new HashMap();
 	   	map.put("serInvokeInsId", serInvokeInsId);
		List<Map<String,String>> listWebService = this.getProofeffectService().getWebServiceMsg(map);
		String urlFirst = null;
		if(null != listWebService && listWebService.size() > 0){
//			String baseVersion = listWebService.get(0).get("VERSION");
//			String docVersion = listWebService.get(0).get("DOC_VERSION");
			String resource = listWebService.get(0).get("RESOURCE_ALISS");
			if(null != resource){
				urlFirst = url+tenantId+"/"+"webservice"+"/"+resource;
			}
		}
//		List<Map<String,String>> listWebServiceApi = this.getProofeffectService().getWebServiceApiMsg(serInvokeInsId);
//		String urlSecond = null;
//		if(null != listWebServiceApi && listWebServiceApi.size() > 0){
//			String api_method = listWebServiceApi.get(0).get("API_METHOD");
//			String code = listWebServiceApi.get(0).get("CODE");
//			if(null != api_method && null != code){
//				urlSecond = url+"webservice"+"/"+api_method+"?SrcSysCode="+code;
//			}
//		}
//		String finalUrl = null;
//		if(null != urlFirst && null != urlSecond){
//			finalUrl = "1、"+urlFirst+"; 2、"+urlSecond;
//		}else if(null == urlFirst && null != urlSecond){
//			finalUrl = urlSecond;
//		}else if(null != urlFirst && null == urlSecond){
//			finalUrl = urlFirst;
//		}else{
//			finalUrl = null;
//		}
		return urlFirst;
	}
	private String getFinalPath(){
		String url = WebPropertyUtil.getPropertyValue("serviceAgentUrl");
		String finalUrl = null;
		if(null != url){
			String midUrl = url.substring(url.indexOf("//")+2);
			String[] arrauUrl = midUrl.split("/");
		    finalUrl = "http://"+arrauUrl[0]+"/"+arrauUrl[1]+"/";
		}
		return finalUrl;
	}
	/*         JAVABEAN            */
	public String getSerInvokeInsId() {
		return serInvokeInsId;
	}
	public void setSerInvokeInsId(String serInvokeInsId) {
		this.serInvokeInsId = serInvokeInsId;
	}
	public IProofEffectService getProofeffectService() {
		if (proofeffectService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			proofeffectService = (IProofEffectService) ctx
					.getBean("eaap-op2-conf-proofeffect-proofeffectService");
		}
		return proofeffectService;
	}
	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
			   
	     }
		return confManagerServ;
	}
	public void setProofeffectService(IProofEffectService proofeffectService) {
		this.proofeffectService = proofeffectService;
	}
	public String getPageWebserviceAdd() {
		return pageWebserviceAdd;
	}
	public void setPageWebserviceAdd(String pageWebserviceAdd) {
		this.pageWebserviceAdd = pageWebserviceAdd;
	}
	public String getPageHttpAdd() {
		return pageHttpAdd;
	}
	public void setPageHttpAdd(String pageHttpAdd) {
		this.pageHttpAdd = pageHttpAdd;
	}
	public String getPageRestAdd() {
		return pageRestAdd;
	}
	public void setPageRestAdd(String pageRestAdd) {
		this.pageRestAdd = pageRestAdd;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Map getSerInvokeInsMap() {
		return serInvokeInsMap;
	}
	public void setSerInvokeInsMap(Map serInvokeInsMap) {
		this.serInvokeInsMap = serInvokeInsMap;
	}
	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
	}
	public List<Map> getMessgeFlowList() {
		return messgeFlowList;
	}
	public void setMessgeFlowList(List<Map> messgeFlowList) {
		this.messgeFlowList = messgeFlowList;
	}
	public String getMsFlowUrl() {
		return msFlowUrl;
	}
	public void setMsFlowUrl(String msFlowUrl) {
		this.msFlowUrl = msFlowUrl;
	}
	
	
}
