package com.ailk.eaap.op2.conf.authenticate.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.authenticate.service.IAuthenticateServ;
import com.ailk.eaap.op2.conf.flowcontrol.service.IFlowControlServ;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

public class AuthenticateAction extends BaseAction{

	/**
	 * @author wanglm7 
	 * @create time 2013-06-06 14:46:40
	 * @desc 认证鉴权
	 */
	private static Log log = LogFactory.getLog(AuthenticateAction.class);
	private IAuthenticateServ authenticateServ ;
	
	private IFlowControlServ flowcontrolServ ;
	
	//组件LIST
	private List<Map<String,String>> componentList ;
	
	//服务LIST
	private List<Map<String,String>> serviceList ;
	
	//认证类型LIST
	private List<Map<String,Object>> proofTypeList ;
	
	//服务调用实例LIST
	private List<Map<String,String>> serInvokeInsList ;
	
	//查询已存在数据
	private List<Map> existsDataList ; 
	
	private SerInvokeIns serInvokeIns = new SerInvokeIns(); 
	
	private static final long serialVersionUID = 1L;
	
	private String data ; 
	
	private ProofEffect proofEffect ; 
	
	private List<ProofValues> proofValuesList ; 
	
	//分页
	private Pagination page = new Pagination();
	
	private Map hashMap = new HashMap() ;
	
	
	/**
	 * 查询页面
	 * @return
	 */
	public String authenticateIndex(){
		
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
	 * 查询已有配置
	 * @return
	 */
	public String queryExistsAuthenticate(){
		
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
        	page.setTotalRecord(Integer.valueOf(String.valueOf(this.getAuthenticateServ().showProofEffectList(map).get(0).get("ALLNUM"))));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        map.put("queryType", "") ;
        setPageParameters(page,"page");
        map.put("pro", page.getPageStart());
        map.put("end", page.getPageEnd());
        
		existsDataList =  this.getAuthenticateServ().showProofEffectList(map) ;
		
		for(Map emap : existsDataList){
			int serInvokeId =  new BigDecimal(emap.get("SER_INVOKE_INS_ID").toString()).intValue();
			Map<String,Object> inmap = new HashMap<String,Object>() ;
			inmap.put("data", serInvokeId);
			//根据服务调用实例ID查 包含的认证类型
			List<Map> proofTypeList = this.getAuthenticateServ().queryProofTypeListBySerInvokeInsId(inmap) ;
			
			for(Map  pmap: proofTypeList){
				int proofId =  new BigDecimal(pmap.get("PROOFE_ID").toString()).intValue();
				inmap.put("data", proofId);
				//根据有效论证标识查询包含的属性
				List<Map> attrList = this.getAuthenticateServ().queryAttrListByProofId(inmap) ;
				pmap.put("attrList", attrList) ;
			}
			emap.put("proofTypeList", proofTypeList) ;
			
		}
		
		return SUCCESS; 
	}
	
	
	/**
	 * 获取PROOF_TYPE属性值
	 * @return
	 */
	public String queryProofAttr(){
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("data", data) ;
		
		List<Map<String,String>> attrList = this.getAuthenticateServ().queryProofAttr(map) ;
		
		try {
			StringBuilder sb = new StringBuilder("");
			sb.append("{\"attrList\":"+JSONArray.fromObject(attrList).toString()+"}") ;
			
			PrintWriter pw = getResponse().getWriter() ;
			pw.write(sb.toString()) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		
		return NONE;
	}
	
	
	/**
	 * 删除ProofEffect
	 * @return
	 */
	public String deleteAuthenticate(){
		this.getAuthenticateServ().deleteAuthenticate(serInvokeIns) ;
		return SUCCESS  ; 
	}
	
	/**
	 * 增加操作前信息加载
	 * @return
	 */
	public String addAuthenticatePre(){
		
		Map<String,String> proofTypeMap = new HashMap<String, String>() ;
		proofTypeList = this.getAuthenticateServ().getProofTypeList(proofTypeMap) ;
		
		Map<String,Object> map = new HashMap<String, Object>();
		for(Map<String,Object> pmap : proofTypeList){
			map.put("data", pmap.get("PT_CD")) ;
			List<Map<String,String>> attrList = this.getAuthenticateServ().queryProofAttr(map) ;
			pmap.put("attrList", attrList) ;
		}
		
		return SUCCESS ; 
	}
	
	/**
	 * 认证鉴权增加操作
	 * @return
	 */
	public String addAuthenticate(){
		
		//先查询是否在SER_INVOKE_INS表存在
		String serInvokeInsId = this.getFlowControlServ().querySerInvokeInsExist(serInvokeIns) ;
		
		//查询是否在PROOF_EFFECT表已经添加
		Map mapTemp = new HashMap();  
		mapTemp.put("serInvokeInsId", serInvokeInsId);
		String count = this.getAuthenticateServ().queryCount(mapTemp) ;
		if(Integer.parseInt(count) > 0){
			this.getSession().setAttribute("msg", getText("eaap.op2.conf.authenticate.authenticateErrorMsg"));
			return ERROR ; 
		}
		
		String[] proofTypeAtrSpecCdValues = getRequest().getParameterValues("proofTypeAtrSpecCdValues") ;
		String[] proofTypePtcdValues = getRequest().getParameterValues("proofTypePtcdValues") ;
		String[] attrValues = getRequest().getParameterValues("attrValues") ;
		
		
		this.getAuthenticateServ().addAllData(proofTypeAtrSpecCdValues,proofTypePtcdValues,attrValues,serInvokeInsId) ;
		
		return SUCCESS ;
	}
	
	/**
	 * 修改操作页面初始化
	 * @return
	 */
	public String updateAuthenticatePre(){
		
		Map<String,Object> inmap = new HashMap<String,Object>() ;
		inmap.put("data", serInvokeIns.getSerInvokeInsId());
		//根据服务调用实例ID查 包含的认证类型
		List<Map> proofTypeList = this.getAuthenticateServ().queryProofTypeListBySerInvokeInsId(inmap) ;
		
		for(Map pmap : proofTypeList){
			int proofId =  new BigDecimal(pmap.get("PROOFE_ID").toString()).intValue();
			inmap.put("data", proofId);
			//根据有效论证标识查询包含的属性
			List<Map> attrList = this.getAuthenticateServ().queryAttrListByProofIdAll(inmap) ;
			pmap.put("attrList", attrList) ;
		}
		hashMap.put("proofTypeList", proofTypeList) ;
		
		return SUCCESS ; 
	}
	
	
	/**
	 * 修改操作
	 * @return
	 */
	public String updateAuthenticate(){
		
		String[] proofValuesIds = getRequest().getParameterValues("proofValuesId") ;
		String[] attrValues = getRequest().getParameterValues("attrValues") ;
		
		this.getAuthenticateServ().updateAll(proofValuesIds , attrValues) ;
		return SUCCESS ; 
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

	public List<Map<String, Object>> getProofTypeList() {
		return proofTypeList;
	}

	public void setProofTypeList(List<Map<String, Object>> proofTypeList) {
		this.proofTypeList = proofTypeList;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public List<Map<String, String>> getSerInvokeInsList() {
		return serInvokeInsList;
	}

	public void setSerInvokeInsList(List<Map<String, String>> serInvokeInsList) {
		this.serInvokeInsList = serInvokeInsList;
	}

	public ProofEffect getProofEffect() {
		return proofEffect;
	}

	public void setProofEffect(ProofEffect proofEffect) {
		this.proofEffect = proofEffect;
	}

	public List<ProofValues> getProofValuesList() {
		return proofValuesList;
	}

	public void setProofValuesList(List<ProofValues> proofValuesList) {
		this.proofValuesList = proofValuesList;
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

	public List<Map> getExistsDataList() {
		return existsDataList;
	}

	public void setExistsDataList(List<Map> existsDataList) {
		this.existsDataList = existsDataList;
	}

	public Map getHashMap() {
		return hashMap;
	}

	public void setHashMap(Map hashMap) {
		this.hashMap = hashMap;
	}
	
}
