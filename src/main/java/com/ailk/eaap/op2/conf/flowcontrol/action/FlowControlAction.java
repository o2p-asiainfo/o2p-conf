package com.ailk.eaap.op2.conf.flowcontrol.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.authenticate.service.IAuthenticateServ;
import com.ailk.eaap.op2.conf.flowcontrol.service.IFlowControlServ;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

public class FlowControlAction extends BaseAction{

	/**
	 * 
	 * @author wanglm7
	 * @createTime 2013-06-18 10:05:15
	 * @desc 流量控制
	 * 
	 */
	
	private static final long serialVersionUID = 1L ;

	private static Log log = LogFactory.getLog(FlowControlAction.class);
	private IFlowControlServ flowcontrolServ ;
	
	private IAuthenticateServ authenticateServ ;
	
	//流量控制策略LIST
	private List<Map<String,String>> controlCountermsList ;
	
	//服务调用实例LIST
	private List<Map<String,String>> serInvokeInsList ;
	
	private String data ;
	
	private CtlCounterms2Comp ctlCounterms2Comp ;
	
	//已有配置
	private List<Map> policyList ;
	
	//组件LIST
	private List<Map<String,String>> componentList ;
	
	//服务LIST
	private List<Map<String,String>> serviceList ;
	
	private SerInvokeIns serInvokeIns = new SerInvokeIns(); 
	
	//分页
	private Pagination page = new Pagination();
	
	//修改用到的信息
	private Map ctlCounterms2CompInfo ;
	
	
	/**
	 * 主页
	 * @return
	 */
	public String flowControlIndex(){
		
		Map<String,String> componentMap = new HashMap<String, String>() ;
		componentList = this.getAuthenticateServ().getComponentList(componentMap) ;
		
		return SUCCESS ; 
	}
	
	/**
	 * 跳转增加页面前加载信息
	 * @return
	 */
	public String addFlowControlPre(){
		
		Map<String,String> componentMap = new HashMap<String, String>() ;
		componentList = this.getAuthenticateServ().getComponentList(componentMap) ;
		
		Map<String,String> controlCountermsMap = new HashMap<String, String>() ;
		controlCountermsList = this.getFlowControlServ().getControlCountermsList(controlCountermsMap) ;
		
		return SUCCESS ; 
	}
	
	/**
	 * 修改页面前加载
	 * @return
	 */
	public String updateFlowControlPre(){
		
		Map<String,String> componentMap = new HashMap<String, String>() ;
		componentList = this.getAuthenticateServ().getComponentList(componentMap) ;
		
		Map<String,String> controlCountermsMap = new HashMap<String, String>() ;
		controlCountermsList = this.getFlowControlServ().getControlCountermsList(controlCountermsMap) ;
		
		ctlCounterms2CompInfo =  this.getFlowControlServ().getCtlCounterms2CompById(ctlCounterms2Comp);
		
		return SUCCESS;
	}
	/**
	 * 获取已有的策略
	 * @return
	 */
	public String queryExistsPolicy(){
		
		Map<String,Object> map = new HashMap<String,Object>() ;
		String cid ;
		if("".equals(serInvokeIns.getComponentId())){
			cid = null ; 
		}else{
		    cid = serInvokeIns.getComponentId() ;
		}
		map.put("componentId", cid);
		map.put("serviceId", serInvokeIns.getServiceId());
		
		if(getSelectPerPage("page")==-1){
			page.setPageRecord(EAAPConstants.EAAP_PAGE_RECORE_5);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
        if(getQueryFlag("page")==-1){ 
        	map.put("queryType", "ALLNUM") ;
        	page.setTotalRecord(Integer.valueOf(String.valueOf(this.getFlowControlServ().showSerInvokeInsList(map).get(0).get("ALLNUM"))));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        map.put("queryType", "") ;
        setPageParameters(page,"page");
        map.put("pro", page.getPageStart());
        map.put("end", page.getPageEnd());
        
        policyList = this.getFlowControlServ().showSerInvokeInsList(map);
		
		return SUCCESS; 
		
	}
	
	/**
	 * 新增操作
	 * @return
	 */
	public String addFlowControl(){
		
		//先查询是否在SER_INVOKE_INS表存在
		String id = this.getFlowControlServ().querySerInvokeInsExist(serInvokeIns) ;
		ctlCounterms2Comp.setSerInvokeInsId(Integer.parseInt(id));
		
		//查询是否在CTL_COUNTERMS_2_COMP表已经添加
		String count = this.getFlowControlServ().queryCount(ctlCounterms2Comp) ;
		if(Integer.parseInt(count) > 0){
			this.getSession().setAttribute("msg", getText("eaap-op2-conf-flowcontrol.policyErrorMsg"));  
			return ERROR ; 
		}
		
		String seq = this.getFlowControlServ().queryCtlCounterms2CompSeq() ;
		ctlCounterms2Comp.setCtlC2CompId(Integer.parseInt(seq)) ;
		ctlCounterms2Comp.setEffectState("A") ;
		
		this.getFlowControlServ().insertCtlCounterms2Comp(ctlCounterms2Comp) ;
		
		return SUCCESS ; 
	}
	
	/**
	 * 修改
	 * @return
	 */
	public String updateFlowControl(){
		this.getFlowControlServ().updateCtlCounterms2Comp(ctlCounterms2Comp) ;
		
		return SUCCESS ;	
	}
	
	/**
	 * 删除
	 * @return
	 */
	public String deleteCtlCounterms2Comp(){
		
		this.getFlowControlServ().deleteProofEffect(ctlCounterms2Comp) ;
		
		return SUCCESS ; 
	}
	
	/**
	 * 根据组件ID获取对应的服务信息
	 * @return
	 */
	public String getServiceInfo(){
		Map<String,String> map = new HashMap<String, String>() ;
		map.put("data", data) ;
		List<Map> serviceList = this.getFlowControlServ().getServiceInfo(map) ;
		
		try {
			StringBuilder sb = new StringBuilder("");
			sb.append("{\"serviceList\":"+JSONArray.fromObject(serviceList).toString()+"}") ;
			
			PrintWriter pw = getResponse().getWriter() ;
			pw.write(sb.toString()) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		return NONE ;  
	}
	
	/**
	 * 获取serv实例
	 * @return
	 */
	public IFlowControlServ getFlowControlServ() {
		if(flowcontrolServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				flowcontrolServ = (IFlowControlServ)ctx.getBean("eaap-op2-conf-flowcontrol-flowcontrolServ") ;
	     }
		return flowcontrolServ;
	}

	/**
	 * 获取serv实例
	 * @return
	 */
	public IAuthenticateServ getAuthenticateServ() {
		if(authenticateServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				authenticateServ = (IAuthenticateServ)ctx.getBean("eaap-op2-conf-authenticate-authenticateServ") ;
	     }
		return authenticateServ;
	}
	
	public List<Map<String, String>> getControlCountermsList() {
		return controlCountermsList;
	}

	public void setControlCountermsList(
			List<Map<String, String>> controlCountermsList) {
		this.controlCountermsList = controlCountermsList;
	}

	public List<Map<String, String>> getSerInvokeInsList() {
		return serInvokeInsList;
	}

	public void setSerInvokeInsList(List<Map<String, String>> serInvokeInsList) {
		this.serInvokeInsList = serInvokeInsList;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public CtlCounterms2Comp getCtlCounterms2Comp() {
		return ctlCounterms2Comp;
	}

	public void setCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp) {
		this.ctlCounterms2Comp = ctlCounterms2Comp;
	}

	public List<Map<String, String>> getComponentList() {
		return componentList;
	}

	public void setComponentList(List<Map<String, String>> componentList) {
		this.componentList = componentList;
	}

	public List<Map<String, String>> getServiceList() {
		return serviceList;
	}

	public void setServiceList(List<Map<String, String>> serviceList) {
		this.serviceList = serviceList;
	}

	public SerInvokeIns getSerInvokeIns() {
		return serInvokeIns;
	}

	public void setSerInvokeIns(SerInvokeIns serInvokeIns) {
		this.serInvokeIns = serInvokeIns;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public List<Map> getPolicyList() {
		return policyList;
	}

	public void setPolicyList(List<Map> policyList) {
		this.policyList = policyList;
	}

	public Map getCtlCounterms2CompInfo() {
		return ctlCounterms2CompInfo;
	}

	public void setCtlCounterms2CompInfo(Map ctlCounterms2CompInfo) {
		this.ctlCounterms2CompInfo = ctlCounterms2CompInfo;
	}
	
}
