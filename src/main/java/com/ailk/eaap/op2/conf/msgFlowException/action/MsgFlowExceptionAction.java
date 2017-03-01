package com.ailk.eaap.op2.conf.msgFlowException.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import net.sf.json.JSONArray;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.StringUtil;
import com.ailk.eaap.o2p.common.service.IExceptionDealInfoService;
import com.ailk.eaap.o2p.common.service.ITriggerExceptionService;
import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.common.util.CommonUtil;
import com.ailk.eaap.o2p.common.util.date.UTCConvertUtil;
import com.ailk.eaap.o2p.common.util.date.UTCTimeUtil.DateType;
import com.ailk.eaap.op2.bo.ExceptionDealInfo;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.msgFlowException.service.IMsgFlowExceptionService;

public class MsgFlowExceptionAction extends BaseAction{
	private static final long serialVersionUID = 1L;	
	private static Log log = LogFactory.getLog(MsgFlowExceptionAction.class);
	private IMsgFlowExceptionService msgFlowExceptionService;
    private IConfManagerServ confManagerServ ;
	private List<Map> tryStatusList = new ArrayList<Map>();
	private String exceptionId;
	private String tryStatus;
	
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
    
	private IExceptionDealInfoService exceptionDealInfoService;
	private ITriggerExceptionService triggerExceptionService;
	private ExceptionDealInfo exceptionDealInfo = new ExceptionDealInfo();

	public String showException(){
		Map objTypeMap = new HashMap() ;
		///objTypeMap = getMainInfo(EAAPConstants.EXCEPTION_DEAL_INFO_TRY_STATUS);
		objTypeMap = getMainInfo("exceptionDealInfoTryStatus");
		Iterator iter = objTypeMap.entrySet().iterator();   
		while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 tryStatusList.add(mapTmp) ;
		}
		return SUCCESS;
	}
	

	public Map getExceptionDealInfoList(Map para){
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map map = new HashMap() ;
		map.put("serinvokeinsName", ("".equals(getRequest().getParameter("serinvokeinsName"))||getRequest().getParameter("serinvokeinsName")==null)?null:getRequest().getParameter("serinvokeinsName").toLowerCase()) ;
		map.put("serviceName", ("".equals(getRequest().getParameter("serviceName"))||getRequest().getParameter("serviceName")==null)?null:getRequest().getParameter("serviceName").toLowerCase()) ;
		map.put("componentName", ("".equals(getRequest().getParameter("componentName"))||getRequest().getParameter("componentName")==null)?null:getRequest().getParameter("componentName").toLowerCase()) ;
		map.put("messageflowName", ("".equals(getRequest().getParameter("messageflowName"))||getRequest().getParameter("messageflowName")==null)?null:getRequest().getParameter("messageflowName").toLowerCase()) ;
		map.put("endpointName", ("".equals(getRequest().getParameter("endpointName"))||getRequest().getParameter("endpointName")==null)?null:getRequest().getParameter("endpointName").toLowerCase()) ;
		//map.put("tryStatus", "".equals(getRequest().getParameter("tryStatus"))?null:getRequest().getParameter("tryStatus")) ;
		
		String tryStatus = getRequest().getParameter("tryStatus");
		if(tryStatus!=null && !"".equals(tryStatus)){
			 map.put("tryStatus",tryStatus);
		 }else{
			 String isInit = getRequest().getParameter("isInit"); 
			 if(StringUtil.isEmpty(isInit)){
				 map.put("tryStatus","E,W");		////W:初始异常需要人工处理，R:准备调度，D:调度中，C:调度完成（成功），E:调度完成（失败），X:异常调度作废
			 }else{
				 map.put("tryStatus",null);
			 }
		 }

		map.put("queryType", "ALLNUM") ;
		total=Integer.valueOf(String.valueOf(msgFlowExceptionService.getExceptionDealInfoList(map).get(0).get("ALLNUM"))) ;
		
		map.put("queryType", "") ;
		map.put("pro", startRow);
        map.put("end", startRow+rows-1);
        map.put("pro_mysql", startRow - 1);
        map.put("page_record", rows);
        List<Map> exceptionList = msgFlowExceptionService.getExceptionDealInfoList(map) ;

		Map returnMap = new HashMap();
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(exceptionList));

		return returnMap ;
	}
	

	public void tryStatusUpdate(){
		PrintWriter out =null;
		try {
			Map map = new HashMap() ;
			map.put("tryStatus", tryStatus);
			map.put("exceptionIds", exceptionId);
			getMsgFlowExceptionService().tryStatusUpdate(map);

		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"tryResult\":\"true\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
			    String ret="[{\"msg\":\"failure\",\"tryResult\":\""+e.getMessage()+"\"}]";
				out.print(ret);
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	

	public String showDetail(){
         try {	
     		if(exceptionId !=null && !"".equals(exceptionId)){
     			Map map = new HashMap() ;     			
     			map.put("queryType", "") ;
     			map.put("pro", 1);
     	        map.put("end", 10);
     	        map.put("pro_mysql", 0);
     	        map.put("page_record", 10);
     			map.put("exceptionId", exceptionId) ;
     	        List<Map> exceptionList = getMsgFlowExceptionService().getExceptionDealInfoList(map) ;
     	        if(exceptionList!=null && exceptionList.size()>0){
     	        	Map exception = exceptionList.get(0);
     	        	String serInvokeInsName = exception.get("SERINVOKEINS_NAME").toString();
     	        	exceptionDealInfo.setExceptionId(Integer.valueOf(exceptionId));
     	        	exceptionDealInfo.setSerInvokeInsName(serInvokeInsName);
     	        	exceptionDealInfo.setServiceName(exception.get("SERVICE_NAME").toString());
     	        	exceptionDealInfo.setComponentName(exception.get("COMPONENT_NAME").toString());
     	        	exceptionDealInfo.setMessageFlowName(exception.get("SERINVOKEINS_NAME").toString());
     	        	exceptionDealInfo.setEndPointName(exception.get("ENDPOINT_NAME").toString());
     	        	exceptionDealInfo.setTryNum(Integer.valueOf(exception.get("TRY_NUM").toString()));
     	        	exceptionDealInfo.setExceptionCode(exception.get("EXCEPTION_CODE").toString());
     	        	exceptionDealInfo.setExceptionStack(exception.get("EXCEPTION_STACK").toString());
     	        	//exceptionDealInfo.setTryStatus(exception.get("TRY_STATUS").toString());
     	        	exceptionDealInfo.setCreateDate((exception.get("CREATE_DATE")!=null)?Timestamp.valueOf(exception.get("CREATE_DATE").toString()):null);
     	        	exceptionDealInfo.setUpdateDate((exception.get("UPDATE_DATE")!=null)?Timestamp.valueOf(exception.get("UPDATE_DATE").toString()):null);
     	        	
     	        	String tryStatus = exception.get("TRY_STATUS").toString();
     	        	String tryStatusText="";
     	        	if(!"".equals(tryStatus)){
	     	        	Map objTypeMap = new HashMap() ;
		     	   		objTypeMap = getMainInfo("exceptionDealInfoTryStatus");
		     	   		Iterator iter = objTypeMap.entrySet().iterator();   
		     	   		while(iter.hasNext()) {
		     	   			 Entry entry = (Entry)iter.next();
		     	   			 if(tryStatus.equals(entry.getKey().toString())){
		     	   				tryStatusText = entry.getValue().toString();
		     	   			 }
		     	   		}
     	        	}
     	        	exceptionDealInfo.setTryStatus(tryStatusText);
     	        }
     			
    		}
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}
	
	
	
	
	public IExceptionDealInfoService getExceptionDealInfoService() {
		return exceptionDealInfoService;
	}

	public void setExceptionDealInfoService(
			IExceptionDealInfoService exceptionDealInfoService) {
		this.exceptionDealInfoService = exceptionDealInfoService;
	}

	public ITriggerExceptionService getTriggerExceptionService() {
		return triggerExceptionService;
	}

	public void setTriggerExceptionService(
			ITriggerExceptionService triggerExceptionService) {
		this.triggerExceptionService = triggerExceptionService;
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

	public String getExceptionId() {
		return exceptionId;
	}

	public void setExceptionId(String exceptionId) {
		this.exceptionId = exceptionId;
	}

	public ExceptionDealInfo getExceptionDealInfo() {
		return exceptionDealInfo;
	}

	public void setExceptionDealInfo(ExceptionDealInfo exceptionDealInfo) {
		this.exceptionDealInfo = exceptionDealInfo;
	}
	

	public Map getMainInfo(String mainTypeSign){
	  	      MainDataType mainDataType = new MainDataType();
	  	      MainData mainData = new MainData();
	  	      Map stateMap = new HashMap() ;
	  	      mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	      mainDataType.setMdtSign(mainTypeSign) ;
	  	      List<MainDataType> mdList = getConfManagerServ().selectMainDataType(mainDataType);
	  	      if(mdList!=null && mdList.size()>0){
				  mainDataType = mdList.get(0) ;
				  mainData.setMdtCd(mainDataType.getMdtCd()) ;
				  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
				  List<MainData> mainDataList = getConfManagerServ().selectMainData(mainData) ;
				  if(mainDataList!=null && mainDataList.size()>0){
					  for(int i=0;i<mainDataList.size();i++){
						  stateMap.put(mainDataList.get(i).getCepCode(), mainDataList.get(i).getCepName()) ;
					  }
				  }
	  	      }
			return  stateMap ;
	  }

	public IMsgFlowExceptionService getMsgFlowExceptionService() {
		if (msgFlowExceptionService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			msgFlowExceptionService = (IMsgFlowExceptionService)ctx.getBean("eaap-op2-conf-msgFlowExceptionServices");
		}
		return msgFlowExceptionService;
	}

	public void setMsgFlowExceptionService(IMsgFlowExceptionService msgFlowExceptionService) {
		this.msgFlowExceptionService = msgFlowExceptionService;
	}

	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
            //取得spring上下文
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				// 取得spring bean实例
				//logginService = (ILoginServ)ctx.getBean("eaap-op2-portal-login-LoginServ");
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
			   
	     }
		return confManagerServ;
	}
	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
	}


	public List<Map> getTryStatusList() {
		return tryStatusList;
	}
	public void setTryStatusList(List<Map> tryStatusList) {
		this.tryStatusList = tryStatusList;
	}

	public String getTryStatus() {
		return tryStatus;
	}
	public void setTryStatus(String tryStatus) {
		this.tryStatus = tryStatus;
	}
	
	
	
	
}
