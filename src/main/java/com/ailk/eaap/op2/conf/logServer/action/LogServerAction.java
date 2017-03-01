package com.ailk.eaap.op2.conf.logServer.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.logServer.bean.DataSourceBean;
import com.ailk.eaap.op2.conf.logServer.service.ILogServerService;
import com.ailk.eaap.op2.conf.logServer.service.LogServerService;
import com.ailk.eaap.op2.conf.messageFlow.service.IMessageFlowSer;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;

import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.ailk.eaap.op2.bo.DataSource;
import com.ailk.eaap.op2.bo.DataSourceDbcp;
import com.ailk.eaap.op2.bo.DataSourceJndi;
import com.ailk.eaap.op2.bo.DataSourceRoute;

/**
 * @ClassName: LogServerAction
 * @Description: 
 * @author zhengpeng
 * @date 2015-1-28 上午9:34:38
 *
 */
public class LogServerAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private static final Logger LOG = Logger
			.getLog(LogServerAction.class);
	private ILogServerService logServerService;
	private Pagination page=new Pagination();
	private int rows;
	private int pageNum;
	private int total;
	private String pageState;
	private String attrName;
	private String objectId;
	private String endpoint_Spec_Attr_Id;
	private String newState;
	private String attrSpecCode;
	private DataSourceBean dataSourceBean;
	private List<Map<String,String>> listYN = new ArrayList<Map<String,String>>();
	private List<Map<String,String>> listType = new ArrayList<Map<String,String>>();
	private List<Map<String,String>> listＤSType = new ArrayList<Map<String,String>>();
	private String dataSourceId;
	private Map map;
	private String dataSourceType;
	private DataSource dataSource = new DataSource();
	private DataSourceDbcp dataSourceDbcp = new DataSourceDbcp();
	private DataSourceJndi dataSourceJndi = new DataSourceJndi();
	private DataSourceRoute dataSourceRoute = new DataSourceRoute();
	private String componentName;
	
	private int isHaveDefault;
	
	public void setLogServerService(ILogServerService logServerService) {
		this.logServerService = logServerService;
	}

	public String showLogServer(){
		return SUCCESS;
	}
	
	public Map getDataSourceList(Map para){
		rows = page.getRows();
		pageNum = page.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		Map<String,Object> returnMap = new HashMap<String,Object>();
		
		Map<String,Object> paramMap = new HashMap<String,Object>(); 
		paramMap.put("dataSourceName", CommonUtil.getStringByObj(para.get("dataSourceName")));
		paramMap.put("componentName", CommonUtil.getStringByObj(para.get("componentName")));
		paramMap.put("tabSuffix", CommonUtil.getStringByObj(para.get("tabSuffix")));
		paramMap.put("queryType", "ALLNUM");
		total = logServerService.queryDataSourceCount(paramMap);
		paramMap.put("pro", startRow);
		paramMap.put("end", startRow+rows-1);
         
		paramMap.put("pro_mysql", (pageNum - 1) * rows);
		paramMap.put("page_record", rows);
		
	    List<DataSourceBean> dataSourceList = logServerService.queryDataSourceList(paramMap);
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(dataSourceList)); 
		return returnMap;
	}

	public String editDataSource(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Yes");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "No");
		listYN.add(n);
		
		Map<String, String> dy = new HashMap<String, String>();
		dy.put("key", "0");
		dy.put("value", "Yes");
		listType.add(dy);
		Map<String, String> dn = new HashMap<String, String>();
		dn.put("key", "1");
		dn.put("value", "No");
		listType.add(dn);
		
		Map<String, String> dbcpT = new HashMap<String, String>();
		dbcpT.put("key", "1");
		dbcpT.put("value", "DBCP");
		listＤSType.add(dbcpT);
		Map<String, String> jndiT = new HashMap<String, String>();
		jndiT.put("key", "2");
		jndiT.put("value", "JNDI");
		listＤSType.add(jndiT);
		
		Map defaultMap = new HashMap();
		defaultMap.put("isDefault", "0");
		isHaveDefault =  this.getLogServerService().queryDataSourceCount(defaultMap);
		
		if(dataSourceId==null || dataSourceId.equals("")){
			dataSourceId = dataSource.getDataSourceId();
		}
		
		if(dataSourceId!=null && !dataSourceId.equals("")){
			//修改
			Map paramMap = new HashMap();
			paramMap.put("dataSourceId", dataSourceId);
			map = this.getLogServerService().getDataSourceById(paramMap);
			dataSource.setComponentId(CommonUtil.getMapValueToString(map, "COMPONENT_ID"));
			dataSource.setDataSourceId(CommonUtil.getMapValueToString(map, "DATA_SOURCE_ID"));
			dataSource.setDataSourceName(CommonUtil.getMapValueToString(map, "DATA_SOURCE_NAME"));
			dataSource.setIsDefault(CommonUtil.getMapValueToString(map, "IS_DEFAULT"));
			dataSource.setRemarks(CommonUtil.getMapValueToString(map, "REMARKS"));
			dataSource.setTabSuffix(CommonUtil.getMapValueToString(map, "TAB_SUFFIX"));
			dataSource.setIsbegininit(CommonUtil.getMapValueToString(map, "ISBEGININIT"));
			componentName = CommonUtil.getMapValueToString(map, "COMPONENT_NAME");

			if(dataSourceRoute.getDataSourceId()==null){
				dataSourceRoute =  this.getLogServerService().getDataSourceRouteById(paramMap);
			}
			
			
			if(dataSourceType !=null && !dataSourceType.equals("")){
				if(dataSourceType=="1"){
					if(dataSourceDbcp.getDataSourceId()==null){
						dataSourceDbcp =  this.getLogServerService().getDataSourceDbcpById(paramMap);
					}
				}
				if(dataSourceType=="2"){
					if(dataSourceJndi.getDataSourceId()==null){
						dataSourceJndi =  this.getLogServerService().getDataSourceJndiById(paramMap);
					}
				}
			}else{
				dataSourceType="1";		//1:DBCP, 2:JNDI
				if(dataSourceDbcp.getDataSourceId()==null){
					dataSourceDbcp =  this.getLogServerService().getDataSourceDbcpById(paramMap);
					if(dataSourceDbcp !=null){
						dataSourceType="1";
					}
				}
				if(dataSourceJndi.getDataSourceId()==null){
					dataSourceJndi =  this.getLogServerService().getDataSourceJndiById(paramMap);
					if(dataSourceJndi !=null){
						dataSourceType="2";
					}
				}
			}
		}else{
			//新增
			if(dataSourceType ==null || dataSourceType.equals("")){
				dataSourceType="1";		//1:DBCP, 2:JNDI
			}
		}
		return SUCCESS;
	}
	
	public String editDataSourceSave(){ 
		try {
				if(dataSource.getDataSourceId()!=null && !dataSource.getDataSourceId().equals("")){
					//修改
					this.getLogServerService().updateDataSource(dataSource);
					
					if(dataSourceRoute.getDataSourceId()!=null && !dataSourceRoute.getDataSourceRouteId().equals("")){
						if(dataSourceRoute.getPri().equals("")){
							dataSourceRoute.setPri(null);
						}
						this.getLogServerService().updateDataSourceRoute(dataSourceRoute);
					}else{
						if(dataSourceRoute.getPri().equals("")){
							dataSourceRoute.setPri(null);
						}
						this.getLogServerService().addDataSourceRoute(dataSourceRoute);
					}
					
					
					Map paramMap = new HashMap();
					paramMap.put("dataSourceId", dataSource.getDataSourceId());
					
					this.getLogServerService().delDataSource(paramMap);	
					
					
					if(dataSourceDbcp!=null){
						dataSourceDbcp.setDataSourceId(new Long(dataSource.getDataSourceId()));
					}
					if(dataSourceJndi!=null){
						dataSourceJndi.setDataSourceId(new Long(dataSource.getDataSourceId()));
					}
					
					if(dataSourceDbcp.getDataSourceId()!=null && dataSourceType.equals("1")){
						this.getLogServerService().addDataSourceDbcp(dataSourceDbcp);
					}
					if(dataSourceJndi.getDataSourceId()!=null&& dataSourceType.equals("2")){
						this.getLogServerService().addDataSourceJndi(dataSourceJndi);
					}
				}else{
					//新增
					String dataSourceId = this.getLogServerService().getCurrenId();
					dataSource.setDataSourceId(dataSourceId);
					this.getLogServerService().addDataSource(dataSource);
					
					dataSourceRoute.setDataSourceId(dataSourceId);
					dataSourceRoute.setState("A");
					if(dataSourceRoute.getPri().equals("")){
						dataSourceRoute.setPri(null);
					}
					this.getLogServerService().addDataSourceRoute(dataSourceRoute);
					
					System.out.println("dataSourceType"+dataSourceType);
					
					if(dataSourceType.equals("1")){
						dataSourceDbcp.setDataSourceId(Long.valueOf(dataSourceId));
						this.getLogServerService().addDataSourceDbcp(dataSourceDbcp);
					}else{
						dataSourceJndi.setDataSourceId(Long.valueOf(dataSourceId));
						
						this.getLogServerService().addDataSourceJndi(dataSourceJndi);
					}
				}
		}  catch (Exception e) {
			
			LOG.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}

	/**
	 * 转到添加页面
	 * @return
	 */
	public String gotoAddData(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Yes");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "No");
		listYN.add(n);
		
		Map<String, String> dy = new HashMap<String, String>();
		dy.put("key", "0");
		dy.put("value", "Yes");
		listType.add(dy);
		Map<String, String> dn = new HashMap<String, String>();
		dn.put("key", "1");
		dn.put("value", "No");
		listType.add(dn);
		
		Map<String, String> dbcpT = new HashMap<String, String>();
		dbcpT.put("key", "1");
		dbcpT.put("value", "DBCP");
		listＤSType.add(dbcpT);
		Map<String, String> jndiT = new HashMap<String, String>();
		jndiT.put("key", "2");
		jndiT.put("value", "JNDI");
		listＤSType.add(jndiT);
		
		return SUCCESS;
	}
	/**
	 * 跳转到修改页面
	 * @return
	 */
	public String updateDataSource(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Yes");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "No");
		listYN.add(n);
		
		Map<String, String> dy = new HashMap<String, String>();
		dy.put("key", "0");
		dy.put("value", "Yes");
		listType.add(dy);
		Map<String, String> dn = new HashMap<String, String>();
		dn.put("key", "1");
		dn.put("value", "No");
		listType.add(dn);

		Map<String, String> dbcpT = new HashMap<String, String>();
		dbcpT.put("key", "1");
		dbcpT.put("value", "DBCP");
		listＤSType.add(dbcpT);
		Map<String, String> jndiT = new HashMap<String, String>();
		jndiT.put("key", "2");
		jndiT.put("value", "JNDI");
		listＤSType.add(jndiT);
		Map paramMap = new HashMap();
		paramMap.put("dataSourceId", dataSourceId);
		map = this.getLogServerService().getDataSourceById(paramMap);
		return SUCCESS;
	}
	/**
	 * 添加提交操作
	 * @return
	 */
	public String addSubmit(){
		String dataSourceId = this.getLogServerService().getCurrenId();
		dataSourceBean.setDataSourceId(dataSourceId);
		this.getLogServerService().addDataSourceBean(dataSourceBean);
		return SUCCESS;
	}
	/**
	 * 修改提交
	 * @return
	 */
	public String updateSubmit(){
		this.getLogServerService().updateDataSourceBean(dataSourceBean);
		return SUCCESS;
	}
	/**
	 * 删除操作
	 */
	
	public void delDataSource(){
		PrintWriter pw = null;
		try{
			if(null != dataSourceId && !"".equals(dataSourceId)){
				LOG.debug("dataSourceId"+dataSourceId);
				
				Map paramMap = new HashMap();
				paramMap.put("dataSourceId", dataSourceId);
				this.getLogServerService().delSingleDataSource(paramMap);
				pw = getResponse().getWriter();
				pw.write("ok");
				pw.flush();
			}
		}catch (Exception e){
			LOG.error("delete datasource fail", e);
			try {
				pw = getResponse().getWriter();
				pw.write("fail");
				pw.flush();
			} catch (IOException e1) {;
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
	}
	public String getAttrName() {
		return attrName;
	}

	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}

	public String getObjectId() {
		return objectId;
	}

	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	public String getEndpoint_Spec_Attr_Id() {
		return endpoint_Spec_Attr_Id;
	}

	public void setEndpoint_Spec_Attr_Id(String endpoint_Spec_Attr_Id) {
		this.endpoint_Spec_Attr_Id = endpoint_Spec_Attr_Id;
	}

	public DataSourceBean getDataSourceBean() {
		return dataSourceBean;
	}

	public void setDataSourceBean(DataSourceBean dataSourceBean) {
		this.dataSourceBean = dataSourceBean;
	}

	public List<Map<String, String>> getListYN() {
		return listYN;
	}

	public void setListYN(List<Map<String, String>> listYN) {
		this.listYN = listYN;
	}

	public List<Map<String, String>> getListType() {
		return listType;
	}

	public void setListType(List<Map<String, String>> listType) {
		this.listType = listType;
	}
	
	public List<Map<String, String>> getListＤSType() {
		return listＤSType;
	}

	public void setListＤSType(List<Map<String, String>> listＤSType) {
		this.listＤSType = listＤSType;
	}

	public ILogServerService getLogServerService() {
		if (logServerService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			logServerService = (ILogServerService) ctx
					.getBean("eaap-op2-conf-logserver-logServerService");
		}
		return logServerService;
	}

	public String getDataSourceId() {
		return dataSourceId;
	}

	public void setDataSourceId(String dataSourceId) {
		this.dataSourceId = dataSourceId;
	}

	public Map getMap() {
		return map;
	}

	public void setMap(Map map) {
		this.map = map;
	}

	public String getDataSourceType() {
		return dataSourceType;
	}

	public void setDataSourceType(String dataSourceType) {
		this.dataSourceType = dataSourceType;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public DataSourceDbcp getDataSourceDbcp() {
		return dataSourceDbcp;
	}

	public void setDataSourceDbcp(DataSourceDbcp dataSourceDbcp) {
		this.dataSourceDbcp = dataSourceDbcp;
	}

	public DataSourceJndi getDataSourceJndi() {
		return dataSourceJndi;
	}

	public void setDataSourceJndi(DataSourceJndi dataSourceJndi) {
		this.dataSourceJndi = dataSourceJndi;
	}

	public DataSourceRoute getDataSourceRoute() {
		return dataSourceRoute;
	}

	public void setDataSourceRoute(DataSourceRoute dataSourceRoute) {
		this.dataSourceRoute = dataSourceRoute;
	}

	public String getComponentName() {
		return componentName;
	}

	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public String getNewState() {
		return newState;
	}

	public void setNewState(String newState) {
		this.newState = newState;
	}

	public String getAttrSpecCode() {
		return attrSpecCode;
	}

	public void setAttrSpecCode(String attrSpecCode) {
		this.attrSpecCode = attrSpecCode;
	}

	public int getIsHaveDefault() {
		return isHaveDefault;
	}

	public void setIsHaveDefault(int isHaveDefault) {
		this.isHaveDefault = isHaveDefault;
	}


}
