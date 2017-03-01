package com.ailk.eaap.op2.conf.hadoop.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.service.QueryServer;
import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.common.util.CommonUtil;
import com.ailk.eaap.o2p.common.util.date.UTCConvertUtil;
import com.ailk.eaap.o2p.common.util.date.UTCTimeUtil;
import com.ailk.eaap.o2p.common.util.date.UTCTimeUtil.DateType;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.QueryBean;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.logServer.bean.DataSourceBean;
import com.ailk.eaap.op2.conf.logServer.service.ILogServerService;
import com.ailk.eaap.op2.conf.manager.service.ConfManagerServ;
import com.ailk.eaap.op2.conf.serviceManager.service.ServiceManagerServImpl;
import com.ailk.eaap.op2.conf.techImpl.service.TechImplService;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

@SuppressWarnings("unchecked")

public class HadoopLogAction extends BaseAction{

	
	private static final long serialVersionUID = 1L;	
	private static Log log = LogFactory.getLog(HadoopLogAction.class);
	private QueryServer queryServer;
	private ILogServerService logServerService;
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
    private List<Map> statusList = new ArrayList<Map>();
    private List<Map> dataSourceList = new ArrayList<Map>();
	private String rowkeyValueCI;
	private String contractInteractionId;

	private String rowkeyValueEI;
	private Map<String, Object> resultMap ;  
	private String beginReqTime;
	private String endReqTime;
	private static final String[] FULL_PATERNS = {"yyyy-MM-dd HH:mm:ss"};
    
	
	@SuppressWarnings("unchecked")
	public String  selectStatusList(){
		Map statusMap1 = new HashMap();
		Map statusMap2 = new HashMap();
		Map statusMap3 = new HashMap();
		statusMap1.put("statusName", getText("eaap.op2.conf.hadoop.statusN"));
		statusMap1.put("statusCode", "N");			 
		statusMap2.put("statusName", getText("eaap.op2.conf.hadoop.statusMT"));
		statusMap2.put("statusCode", "MT");
		statusMap3.put("statusName", getText("eaap.op2.conf.hadoop.statusAT"));
		statusMap3.put("statusCode", "AT");

		statusList.add(statusMap1);
		statusList.add(statusMap2);
		statusList.add(statusMap3);
		return SUCCESS;
	}
	@SuppressWarnings("unchecked")//获取数据源的列表
	public String  selectDataSourceList(){
		List<DataSourceBean> dataSourceBeans=getLogServerService().queryDataSourceList(new HashMap());
		Map defaultDataSourceMap=null;
		for(DataSourceBean dataSourceBean:dataSourceBeans){
			Map dataSourceMap=new HashMap();
			dataSourceMap.put("dataSourceName", dataSourceBean.getDataSourceName());
			dataSourceMap.put("dataSourceId", dataSourceBean.getDataSourceId());
			if("0".equals(dataSourceBean.getIsDefault()) 
					|| "y".equals(dataSourceBean.getIsDefault().toLowerCase())
					|| "yes".equals(dataSourceBean.getIsDefault().toLowerCase())){
				defaultDataSourceMap=dataSourceMap;
			}else{
				dataSourceList.add(dataSourceMap);
			}
		}
		if(defaultDataSourceMap!=null){
			dataSourceList.add(0,defaultDataSourceMap);
		}
		return SUCCESS;
	}
    public String showHadoopCI(){
    	selectStatusList();
    	selectDataSourceList();
    	return SUCCESS;
    }
	
	@SuppressWarnings("unchecked")
	public Map  getHadoopCIList(Map prar){
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
        
		QueryBean queryBean = new QueryBean();
		queryBean.setDataSourceId(prar.get("dataSourceId")==null?"":prar.get("dataSourceId").toString());
		queryBean.setContractInteractionId(prar.get("contractInteractionId")==null?"":prar.get("contractInteractionId").toString());
		queryBean.setContractVersion(prar.get("contractVersion")==null?"":prar.get("contractVersion").toString());
		queryBean.setJfTransactionID(prar.get("srcTranId")==null?"":prar.get("srcTranId").toString());
		queryBean.setJfSrcSysCode(prar.get("srcSysCode")==null?"":prar.get("srcSysCode").toString());
		queryBean.setDstSysCode(prar.get("dstSysCode")==null?"":prar.get("dstSysCode").toString());  
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = com.ailk.eaap.op2.conf.util.CommonUtil.getTenantId(session);
		queryBean.setTenantId(tenantId);
		//convert to utc time by niezh at 20150326
		if(prar.get("queryParamsData")!=null){
			JSONObject queryParamsData=JSONObject.fromObject(prar.get("queryParamsData").toString().replaceAll("&quot;", "\\\""));
			prar.put("bSrcReqTime", queryParamsData.get("bSrcReqTime"));
			prar.put("eSrcReqTime", queryParamsData.get("eSrcReqTime"));
		}
		Object bSrcReqTime=prar.get("bSrcReqTime");
		if(bSrcReqTime!=null && !"".equals(bSrcReqTime.toString())){
			String bSrcReqTimeStr = bSrcReqTime.toString();
			if(bSrcReqTimeStr.length()==16){
				bSrcReqTimeStr = bSrcReqTimeStr+":00";
			}
			queryBean.setStartSrcReqTime(UTCTimeUtil.getHadoopLogUTCTimeStr(bSrcReqTimeStr, CommonUtil.getTimeOffsetForSession(getSession()), FULL_PATERNS));
		}
		Object eSrcReqTime=prar.get("eSrcReqTime");
		if(eSrcReqTime!=null && !"".equals(eSrcReqTime.toString())){
			String eSrcReqTimeStr = eSrcReqTime.toString();
			if(eSrcReqTimeStr.length()==16){
				eSrcReqTimeStr = eSrcReqTimeStr+":00";
			}
			queryBean.setEndSrcReqTime(UTCTimeUtil.getHadoopLogUTCTimeStr(eSrcReqTimeStr, CommonUtil.getTimeOffsetForSession(getSession()), FULL_PATERNS));
		}
		queryBean.setResponseCode(prar.get("responseCode")==null?"":prar.get("responseCode").toString());
		log.debug("responseCode:"+prar.get("responseCode").toString());
		queryBean.setStatus(prar.get("status")==null?"":prar.get("status").toString());
         total= (int) queryServer.queryCICount(queryBean);
         String CIInfo=queryServer.queryCIDataPage(queryBean,pageNum,rows);
 
         JSONArray myJsonArray =null ;
         try {
			myJsonArray = JSONArray.fromObject(CIInfo);   
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
         
        //convert to utc time by niezh at 20150326
         String ctrUTCTime=CustomPropertyConfigurer.getProperty("ctrUTCTime");
         //UTC转为本地时间 
         if("true".equals(ctrUTCTime)){
        	 UTCConvertUtil.checkObject(myJsonArray, CommonUtil.getTimeOffsetForSession(getSession()), DateType.UTC_DATE);
         }
			
         returnMap.put("startRow", startRow);
         returnMap.put("rows", rows); 	
         returnMap.put("total", total);
         returnMap.put("dataList",myJsonArray); 
         
         return returnMap ;
   	}
	
	@SuppressWarnings("unchecked")
	public Map  getHadoopEIList(Map prar){
		
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
        
		QueryBean queryBean = new QueryBean();
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = com.ailk.eaap.op2.conf.util.CommonUtil.getTenantId(session);
		queryBean.setTenantId(tenantId);
		queryBean.setContractInteractionId(prar.get("queryParamsData")==null?"":prar.get("queryParamsData").toString());
         total= (int) queryServer.queryEICount(queryBean);
         String EIInfo=queryServer.queryEIDataPage(queryBean,pageNum,rows);
 
         JSONArray myJsonArray =null ;
         try {
			myJsonArray = JSONArray.fromObject(EIInfo);   
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
         
         returnMap.put("startRow", startRow);
         returnMap.put("rows", rows); 	
         returnMap.put("total", total);
         returnMap.put("dataList",myJsonArray); 
         
         return returnMap ;
   	} 
	
	@SuppressWarnings("unchecked")
	public String gotoCIDetail(){	
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = com.ailk.eaap.op2.conf.util.CommonUtil.getTenantId(session);
		if(rowkeyValueCI !=null && !"".equals(rowkeyValueCI)){
			if(queryServer==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				queryServer = (QueryServer)ctx.getBean("hadoopConsoleService");		   
		     }
			String CIInfo=queryServer.queryCIByRowkey(rowkeyValueCI, tenantId);
	         JSONArray myJsonArray =null ;
	         JSONObject myJsonObject=null;
	         try {
	        	 
				myJsonArray = JSONArray.fromObject(CIInfo); 
				myJsonObject= myJsonArray.getJSONObject(0);
				 resultMap=(Map) JSONObject.toBean(myJsonObject, new HashMap<String, String>(), new JsonConfig());
				//根据serviceCode获取serviceId add by nzh
				 WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				 ServiceManagerServImpl	serverManagerService = (ServiceManagerServImpl)ctx.getBean("eaap-op2-conf-service-manager-service");		 
				 Map serviceMap=new HashMap();
				 serviceMap.put("serviceCode", resultMap.get("bizIntfCode"));
				 List<Service> serviceList=serverManagerService.selectServiceList(serviceMap);
				 if(serviceList!=null&&serviceList.size()>0){
					 resultMap.put("bizIntfId", ((Service)serviceList.get(0)).getServiceId());
				 }
				 //srcOrgId
				 ConfManagerServ	confManagerServ = (ConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");		 
				 Org org=new  Org();
				 org.setOrgCode(String.valueOf(resultMap.get("srcOrgCode")));
				 List<Org> orgList=confManagerServ.selectOrg(org);
				 if(orgList!=null&&orgList.size()>0){
					 resultMap.put("srcOrgId", ((Org)orgList.get(0)).getOrgId());
				 }
				 //dstOrgId
				 org.setOrgCode(String.valueOf(resultMap.get("dstOrgCode")));
				 orgList=confManagerServ.selectOrg(org);
				 if(orgList!=null&&orgList.size()>0){
					 resultMap.put("dstOrgId", ((Org)orgList.get(0)).getOrgId());
				 }
				 //srcSysId
				 TechImplService techImplService = (TechImplService)ctx.getBean("eaap-op2-conf-techimpl-TechImplService");	
				 Component component=new  Component();
				 component.setCode(String.valueOf(resultMap.get("srcSysCode")));
				 Component componentObj=techImplService.queryComponent(component);
				 resultMap.put("srcSysId", componentObj.getComponentId());
				 //dstSysId
				 component.setCode(String.valueOf(resultMap.get("dstSysCode")));
				 componentObj=techImplService.queryComponent(component);
				 resultMap.put("dstSysId", componentObj.getComponentId());
			} catch (Exception e) {
				log.error(e.getStackTrace());
			}
		}
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	public String gotoEIDetail(){	
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = com.ailk.eaap.op2.conf.util.CommonUtil.getTenantId(session);
		if(rowkeyValueEI !=null && !"".equals(rowkeyValueEI)){
			if(queryServer==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				queryServer = (QueryServer)ctx.getBean("hadoopConsoleService");		   
		     }
			String EIInfo=queryServer.queryEIByRowkey(rowkeyValueEI, tenantId);

	         JSONArray myJsonArray =null ;
	         JSONObject myJsonObject=null;
	         try {
	        	 
				myJsonArray = JSONArray.fromObject(EIInfo); 
				myJsonObject= myJsonArray.getJSONObject(0);
				 resultMap=(Map) JSONObject.toBean(myJsonObject, new HashMap<String, String>(), new JsonConfig());
				 
			} catch (Exception e) {
				log.error(e.getStackTrace());
			}
		}
		return SUCCESS;
	}
	
	
	
	
	
    public String showHadoopCtg(){
    	selectDataSourceList();
    	return SUCCESS;
    }
    
	@SuppressWarnings("unchecked")
	public Map  getHadoopCtgList(Map prar){
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();

		QueryBean queryBean = new QueryBean();
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = com.ailk.eaap.op2.conf.util.CommonUtil.getTenantId(session);
		queryBean.setTenantId(tenantId);
		queryBean.setDataSourceId(prar.get("dataSourceId")==null?"":prar.get("dataSourceId").toString());
		queryBean.setLogSeq(prar.get("logSeq")==null?"":prar.get("logSeq").toString());
		queryBean.setFunName(prar.get("funName")==null?"":prar.get("funName").toString());
		queryBean.setErrCode(prar.get("errCode")==null?"":prar.get("errCode").toString());
		
		//convert to utc time by niezh at 20150326
		if(prar.get("queryParamsData")!=null){
			JSONObject queryParamsData=JSONObject.fromObject(prar.get("queryParamsData").toString().replaceAll("&quot;", "\\\""));
			prar.put("startCreateDate", queryParamsData.get("bSrcReqTime"));
			prar.put("endCreateDate", queryParamsData.get("eSrcReqTime"));
		}
		Object bSrcReqTime=prar.get("startCreateDate");
		if(bSrcReqTime!=null && !"".equals(bSrcReqTime.toString())){
			String bSrcReqTimeStr = bSrcReqTime.toString();
			if (bSrcReqTimeStr.length() == 16) {
				bSrcReqTimeStr = bSrcReqTimeStr + ":00";
			}
			queryBean.setStartSrcReqTime(UTCTimeUtil.getHadoopLogUTCTimeStr(bSrcReqTimeStr.toString(), CommonUtil.getTimeOffsetForSession(getSession()), FULL_PATERNS));
		}
		Object eSrcReqTime=prar.get("endCreateDate");
		if(eSrcReqTime!=null && !"".equals(eSrcReqTime.toString())){
			String eSrcReqTimeStr = eSrcReqTime.toString();
			if(eSrcReqTimeStr.length()==16){
				eSrcReqTimeStr = eSrcReqTimeStr+":00";
			}
			queryBean.setEndSrcReqTime(UTCTimeUtil.getHadoopLogUTCTimeStr(eSrcReqTimeStr.toString(), CommonUtil.getTimeOffsetForSession(getSession()), FULL_PATERNS));
		}
		queryBean.setJfTransactionID(prar.get("srcTranId")==null?"":prar.get("srcTranId").toString());
		
        total= (int) queryServer.queryCtgCount(queryBean);
        String CIInfo=queryServer.queryCtgDataPage(queryBean,pageNum,rows);
 
         JSONArray myJsonArray =null ;
         try {
			myJsonArray = JSONArray.fromObject(CIInfo);   
		} catch (Exception e) {
			log.error(e.getStackTrace());
		}
         
       //convert to utc time by niezh at 20150326
		 String ctrUTCTime=CustomPropertyConfigurer.getProperty("ctrUTCTime");
		 //UTC转为本地时间 
		 if("true".equals(ctrUTCTime)){
			 UTCConvertUtil.checkObject(myJsonArray, CommonUtil.getTimeOffsetForSession(getSession()), DateType.UTC_DATE);
		 }
 
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList",myJsonArray);
		return returnMap ;
   	}
	
	@SuppressWarnings("unchecked")
	public String gotoCtgDetail(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = com.ailk.eaap.op2.conf.util.CommonUtil.getTenantId(session);
		if(rowkeyValueCI !=null && !"".equals(rowkeyValueCI)){
			if(queryServer==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				queryServer = (QueryServer)ctx.getBean("hadoopConsoleService");		   
		     }
			String CIInfo=queryServer.queryCtgByRowkey(rowkeyValueCI, tenantId);
			
			JSONArray myJsonArray =null ;
			JSONObject myJsonObject=null;
			try {
				myJsonArray = JSONArray.fromObject(CIInfo); 
				myJsonObject= myJsonArray.getJSONObject(0);
				resultMap=(Map) JSONObject.toBean(myJsonObject, new HashMap<String, String>(), new JsonConfig());
			} catch (Exception e) {
	        	 log.error(e.getStackTrace());
			}
		}
		return SUCCESS;
	}
    
    
	
	
	public String getRowkeyValueEI() {
		return rowkeyValueEI;
	}

	public void setRowkeyValueEI(String rowkeyValueEI) {
		this.rowkeyValueEI = rowkeyValueEI;
	}
	
	public QueryServer getQueryServer() {
		return queryServer;
	}

	public void setQueryServer(QueryServer queryServer) {
		this.queryServer = queryServer;
	}
	
	public ILogServerService getLogServerService() {
		if (logServerService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession().getServletContext());
			logServerService = (ILogServerService) ctx.getBean("eaap-op2-conf-logserver-logServerService");
		}
		return logServerService;
	}
	
	public void setLogServerService(ILogServerService logServerService) {
		this.logServerService = logServerService;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
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

	public String getRowkeyValueCI() {
		return rowkeyValueCI;
	}

	public void setRowkeyValueCI(String rowkeyValueCI) {
		this.rowkeyValueCI = rowkeyValueCI;
	}
	public String getContractInteractionId() {
		return contractInteractionId;
	}

	public void setContractInteractionId(String contractInteractionId) {
		this.contractInteractionId = contractInteractionId;
	}

	public Map<String, Object> getResultMap() {
		return resultMap;
	}


	public void setResultMap(Map<String, Object> resultMap) {
		this.resultMap = resultMap;
	}
	
	public List<Map> getStatusList() {
		return statusList;
	}

	public void setStatusList(List<Map> statusList) {
		this.statusList = statusList;
	}
	
	public List<Map> getDataSourceList() {
		return dataSourceList;
	}

	public void setDataSourceList(List<Map> dataSourceList) {
		this.dataSourceList = dataSourceList;
	}

	public String getBeginReqTime() {
		if(beginReqTime==null || "".equals(beginReqTime)){
			Date utcDate=UTCTimeUtil.getUTCDate();	//当前utc时间
			Calendar cal = Calendar.getInstance();   
			cal.setTime(utcDate);
			cal.set(Calendar.HOUR_OF_DAY , cal.get(Calendar.HOUR_OF_DAY) - 1 ) ; 																					//开始时间设置为当前时间-1小时
			Date beginDT = UTCTimeUtil.getLocalDateByUTC(cal.getTime(),CommonUtil.getTimeOffsetForSession(getSession()));		//根据客户端对UTC时间的偏移量转成客户端当前时间
			beginReqTime=DateFormatUtils.format(beginDT, "yyyy-MM-dd HH:mm:ss"); 																		//格式转换
			//beginReqTime=UTCTimeUtil.convertDateStrByType(new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTime()),CommonUtil.getTimeOffsetForSession(getSession()), FULL_PATERNS,DateType.UTC_DATE);
		}
		return beginReqTime;
	}
	public void setBeginReqTime(String beginReqTime) {
		this.beginReqTime = beginReqTime;
	}
	public String getEndReqTime() {
		if(endReqTime==null || "".equals(endReqTime)){
			Date utcDate=UTCTimeUtil.getUTCDate();	//当前utc时间
			Date endDT = UTCTimeUtil.getLocalDateByUTC(utcDate,CommonUtil.getTimeOffsetForSession(getSession()));			//根据客户端对UTC时间的偏移量转成客户端当前时间
			endReqTime=DateFormatUtils.format(endDT, "yyyy-MM-dd HH:mm:ss"); 																		//格式转换
			//endReqTime=UTCTimeUtil.convertDateStrByType(new  SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(utcDate),CommonUtil.getTimeOffsetForSession(getSession()), FULL_PATERNS,DateType.UTC_DATE);
		}
		return endReqTime;
	}
	public void setEndReqTime(String endReqTime) {
		this.endReqTime = endReqTime;
	}
}
