package com.ailk.eaap.op2.conf.autoComplete.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import net.sf.json.JSONArray;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.autoComplete.service.IAutoCompleteService;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
/**
 * 组件自动补全公共类<br>
 * @version 1.0
 * @author chenwei 2012-6-26
 */
@SuppressWarnings("unchecked")
public class AutoCompleteAction extends BaseAction{

	private static Log log = LogFactory.getLog(AutoCompleteAction.class);
	private static final long serialVersionUID = 1L;
	
	private IAutoCompleteService autoCompleteService;
	/** 搜索关键字,组件名称 **/
	private Component component = new Component();
	/** 组件智能提示列表，以JSON数据格式返回 */
	private List<String> autoSuggests = new ArrayList<String>();
	/** 全部组件列表**/
    private List<Map> componentList = new ArrayList<Map>();
   
    /** 服务**/
    private Service service = new Service();
    /** 服务智能提示列表，以JSON数据格式返回 */
	private List<String> svcAutoSuggests = new ArrayList<String>();
	/** 全部服务列表**/
    private List<Map> serviceList = new ArrayList<Map>();
    
    /**机构**/
    private Org org = new Org();
    /**机构只能提示列表**/
    private List<String> orgAutoSuggests = new ArrayList<String>();
    /**All 机构列表**/
    private List<Map> orgList = new ArrayList<Map>();
    
    /** 分页**/
    private Pagination page = new Pagination();
    
	/**组件 自动补全**/
	public String cmptAutoComplete(){
		//根据搜索关键字 查出来的组件列表
		String componentName = getRequest().getParameter("component_name");
		component.setName(componentName);
		List<Component> cmpList = getAutoCompleteService().queryComponentList(component);
		for (Component comp : cmpList){
			String str = "{'label':'"+comp.getName().trim()+"','value':'"+comp.getName().trim()+"','id':'"+comp.getComponentId().trim()+"'}";
			autoSuggests.add(str);
		}
		JSONArray jsonArr = JSONArray.fromObject(autoSuggests);
		try {
			PrintWriter  write = getResponse().getWriter();
			write.println(jsonArr.toString());
			write.close();
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		return NONE;
	}
	
	/**选择按钮 弹出框 渲染组件查询框页面**/
	public String showCompIndex(){
		return SUCCESS;
	}
	
	/**iframe load所有组件**/
	public String loadAllComponent(){
		Map map = new HashMap();
		//分页
    	if(getSelectPerPage("page")==-1){
			page.setPageRecord(10);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
    	// 判断是否从界面下拉选项中选择的组件
    	if (StringUtils.isNotEmpty(component.getComponentId())){
    		map.put("componentId", component.getComponentId());
    	}
    	//判断是否是第1次查询
        if(getQueryFlag("page")==-1){ 
        	map.put("queryType", "ALLNUM") ;
        	page.setTotalRecord(Integer.valueOf(String.valueOf(getAutoCompleteService().queryAllComptList(map).get(0).get("ALLNUM"))));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        map.put("queryType", "") ;
        //设置查询条件
        setPageParameters(page,"page");
        map.put("pro", page.getPageStart());
        map.put("end", page.getPageEnd());
        
		componentList = getAutoCompleteService().queryAllComptList(map);
		return SUCCESS;
	}
	
	/**服务自动补全**/
	public String serviceAutoComplete(){
		//根据搜索关键字 查出来的服务列表
		String serviceCnName = getRequest().getParameter("service_name");
		if(StringUtils.isBlank(serviceCnName)){
			service.setServiceCnName("");
		}else{
			service.setServiceCnName(serviceCnName);
		}
		
		
		List<Service> svcList = getAutoCompleteService().queryServiceList(service);
		for (Service svc : svcList){
			String str = "{'label':'"+svc.getServiceCnName().trim()+"','value':'"+svc.getServiceCnName().trim()+"','id':'"+svc.getServiceId()+"'}";
			svcAutoSuggests.add(str);
		}
		JSONArray jsonArr = JSONArray.fromObject(svcAutoSuggests);
		try {
			PrintWriter  write = getResponse().getWriter();
			write.println(jsonArr.toString());
			write.close();
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		return NONE;
	}
	
	/**选择按钮 弹出框 渲染服务查询框页面**/
	public String showServiceIndex(){
		return SUCCESS;
	}
	
	public String loadAllService(){
		Map map = new HashMap();
		//分页
    	if(getSelectPerPage("page")==-1){
			page.setPageRecord(10);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
    	// 判断是否从界面下拉选项中选择的服务
    	if (StringUtils.isNotEmpty(service.getServiceCode())){
    		map.put("serviceId", service.getServiceCode());
    	}
    	//判断是否是第1次查询
        if(getQueryFlag("page")==-1){ 
        	map.put("queryType", "ALLNUM") ;
        	page.setTotalRecord(Integer.valueOf(String.valueOf(getAutoCompleteService().queryAllServiceList(map).get(0).get("ALLNUM"))));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        map.put("queryType", "") ;
        //设置查询条件
        setPageParameters(page,"page");
        map.put("pro", page.getPageStart());
        map.put("end", page.getPageEnd());
        
        serviceList = getAutoCompleteService().queryAllServiceList(map);
		return SUCCESS;
	}
	
	/**机构自动补全**/
	public String orgAutoComplete(){
		//根据搜索关键字 查出来的机构列表
		String orgName = getRequest().getParameter("org_name");
		if(StringUtils.isBlank(orgName)){
			org.setName("");
		}else{
			org.setName(orgName);
		}
		
		List<Org> org_list = getAutoCompleteService().queryOrgList(org);
		for (Org orgBean : org_list){
			String str = "{'label':'"+orgBean.getName().trim()+"','value':'"+orgBean.getName().trim()+"','id':'"+orgBean.getOrgId()+"'}";
			orgAutoSuggests.add(str);
		}
		JSONArray jsonArr = JSONArray.fromObject(orgAutoSuggests);
		try {
			PrintWriter  write = getResponse().getWriter();
			write.println(jsonArr.toString());
			write.close();
		} catch (IOException e) {
			log.error(e.getStackTrace());
		}
		return NONE;
	}
	
	/**选择按钮 弹出框 渲染机构查询框页面**/
	public String showOrgIndex(){
		return SUCCESS;
	}
	
	public String loadAllOrg(){
		Map map = new HashMap();
		//分页
    	if(getSelectPerPage("page")==-1){
			page.setPageRecord(10);
		}else{
			page.setPageRecord(getSelectPerPage("page"));
		}
    	// 判断是否从界面下拉选项中选择的机构
    	if (StringUtils.isNotEmpty(org.getOrgCode())){
    		map.put("orgId", org.getOrgCode());
    	}
    	//判断是否是第1次查询
        if(getQueryFlag("page")==-1){ 
        	map.put("queryType", "ALLNUM") ;
        	page.setTotalRecord(Integer.valueOf(String.valueOf(getAutoCompleteService().queryAllOrgList(map).get(0).get("ALLNUM"))));
        }else{
            page.setTotalRecord(getQueryFlag("page"));
        }
        map.put("queryType", "") ;
        //设置查询条件
        setPageParameters(page,"page");
        map.put("pro", page.getPageStart());
        map.put("end", page.getPageEnd());
        
        orgList = getAutoCompleteService().queryAllOrgList(map);
		return SUCCESS;
	}
	
	public Component getComponent() {
		return component;
	}

	public void setComponent(Component component) {
		this.component = component;
	}
	
	public IAutoCompleteService getAutoCompleteService() {
		if (autoCompleteService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			autoCompleteService = (IAutoCompleteService)ctx.getBean("eaap-op2-conf-autoComplete-AutoCompleteService");
		}
		return autoCompleteService;
	}

	public void setAutoCompleteService(IAutoCompleteService autoCompleteService) {
		this.autoCompleteService = autoCompleteService;
	}

	public List<String> getAutoSuggests() {
		return autoSuggests;
	}

	public void setAutoSuggests(List<String> autoSuggests) {
		this.autoSuggests = autoSuggests;
	}


	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public List<Map> getComponentList() {
		return componentList;
	}

	public void setComponentList(List<Map> componentList) {
		this.componentList = componentList;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public List<String> getSvcAutoSuggests() {
		return svcAutoSuggests;
	}

	public void setSvcAutoSuggests(List<String> svcAutoSuggests) {
		this.svcAutoSuggests = svcAutoSuggests;
	}

	public List<Map> getServiceList() {
		return serviceList;
	}

	public void setServiceList(List<Map> serviceList) {
		this.serviceList = serviceList;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public List<String> getOrgAutoSuggests() {
		return orgAutoSuggests;
	}

	public void setOrgAutoSuggests(List<String> orgAutoSuggests) {
		this.orgAutoSuggests = orgAutoSuggests;
	}

	public List<Map> getOrgList() {
		return orgList;
	}

	public void setOrgList(List<Map> orgList) {
		this.orgList = orgList;
	}
}
