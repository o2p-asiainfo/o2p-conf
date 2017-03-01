package com.ailk.eaap.op2.conf.task.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.sqllog.service.IntfSqlLogService;
import com.ailk.eaap.op2.conf.task.service.IJobConsoleService;
import com.ailk.eaap.op2.conf.task.service.ITaskService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.conf.util.I18nAspectForCustom;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;


/**
 * 閸涘﹨顒熼幒褍鍩楅崣鎵暏閸掓壆娈慳ction
 *
 */
public class TaskAction extends BaseAction{

	private static final long serialVersionUID = 1L;	
	private Logger log = Logger.getLog(this.getClass());
	private ITaskService taskService;	
	public IJobConsoleService jobConsoleService;
	private TaskContentBean bean;	
	private List<TaskContentBean> listBean;
	private List<Map<String, Object>> cycleList;
	private List<Map<String, Object>> attrSpecValueList;
	private List<Map<String, Object>> objNameAndUrl;
	private List<TaskContentBean> taskTypeList;
	private List<Map<String, Object>> taskStyleList;
	private List<Map<String,Object>> serviceStatusList;
	
	private IntfSqlLogService intfSqlLogService;
	
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();

    private String serviceName;
    private String statu;
    private String operator;
    private int    taskId;                //娴犺濮熺粻锛勬倞ID
	private String taskCode;              //娴犺濮熺紓鏍垳
	private String taskName;              //娴犺濮熼崥宥囆�
	private String gcCd;                  //闁插洭娉﹂崨銊︽埂缂傛牜鐖�
	private int    threadNumber;          //娴犺濮熺痪璺ㄢ柤濮圭姳閲滈弫锟�	private String startDate;             //閸氼垰濮╅弮鍫曟？
	private String startDate;             //鍚姩鏃堕棿
	private String stopDate;              //閸嬫粍顒涢弮鍫曟？
	private String taskState;             //娴犺濮熼悩鑸碉拷
	private String stateLastDate;         //閻樿埖锟介張锟芥煀娣囶喗鏁奸弮鍫曟？
	private String taskDesc;              //娴犺濮熼幓蹇氬牚
	private String gcName;                  //閸涖劍婀￠崥宥囆�
	private String gcExp;                 //閸涖劍婀＄挧閿嬵剾鐞涖劏鎻锟�
	private int serviceId;
	private String serInvokeInsId;
	private String allFlag;
	private String serInvokeInsName;
	private String taskIdStr;
	private String serviceStatus;
	private static final String SERVICE_STATUS = "SERVICE_STATUS";


	@SuppressWarnings("unchecked")
	private List<Map> selectStateList = new ArrayList<Map>();
	
	public String showTask(){
		selectSerInvokeInsList("check");
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	public String operatorTask(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		
		if (!"1".equals(allFlag)) {sentOperatorLog(taskIdStr,operator);}
		
		if(operator != null && !operator.equals("")){
			
			if (!"".equals(taskIdStr) || "1".equals(allFlag)) {
				
				if(operator.equals("start")){
					if ("1".equals(allFlag)) {
						List<String> errorList = jobConsoleService.startAll(tenantId.toString());
						String data = "";
						StringBuffer dataBf = new StringBuffer();
						for (String errorStr : errorList) {
							//data += errorStr + ",";
							dataBf.append(errorStr).append(",");
						}
						data = dataBf.toString();
						if (data != null && data.length() >= 1) {
							data = data.substring(0, data.length() - 1);
						}
						String jsonStr ="[{\"msg\":\"true\",\"data\":[" + data + "]}]";
						PrintWriter pw;
						try {
							pw = getResponse().getWriter();
							pw.write(jsonStr) ;
							pw.close() ;
						} catch (IOException e) {
							log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
						}
						return NONE;
					} else {
						String[] taskIdArray = taskIdStr.split(",");
						List<String> taskIdList = Arrays.asList(taskIdArray);
						List<TaskContentBean> taskContenList = new ArrayList();
						for (String taskId : taskIdList){
							TaskContentBean taskContentBean = new TaskContentBean();
							
							Map taskMap = new HashMap();
							taskMap.put("taskId", taskId);
							taskMap.put("tenantId", tenantId.toString());
							
							taskContentBean = jobConsoleService.getTaskContentBean(taskMap);
							taskContentBean.setTenantId(tenantId);
							taskContenList.add(taskContentBean);
						}
						
						List<String> errorList = jobConsoleService.start(taskContenList);
						String data = "";
						for (String errorStr : errorList) {
							data += errorStr + ",";
						}
						if (data != null && data.length() >= 1) {
							data = data.substring(0, data.length() - 1);
						}
						String jsonStr ="[{\"msg\":\"true\",\"data\":[" + data + "]}]";
						PrintWriter pw;
						try {
							pw = getResponse().getWriter();
							pw.write(jsonStr) ;
							pw.close() ;
						} catch (IOException e) {
							log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
						}
						return NONE;
					}
				} else if(operator.equals("stop")){
					if ("1".equals(allFlag)) {
						List<String> errorList = jobConsoleService.stopAll(tenantId.toString());
						String data = "";
						for (String errorStr : errorList) {
							data += errorStr + ",";
						}
						if (data != null && data.length() >= 1) {
							data = data.substring(0, data.length() - 1);
						}
						String jsonStr ="[{\"msg\":\"true\",\"data\":[" + data + "]}]";
						PrintWriter pw;
						try {
							pw = getResponse().getWriter();
							pw.write(jsonStr) ;
							pw.close() ;
						} catch (IOException e) {
							log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
						}
						return NONE;
					} else {
						String[] taskIdArray = taskIdStr.split(",");
						List<String> taskIdList = Arrays.asList(taskIdArray);
						List<TaskContentBean> taskContenList = new ArrayList();
						for (String taskId : taskIdList){
							TaskContentBean taskContentBean = new TaskContentBean();
							
							Map taskMap = new HashMap();
							taskMap.put("taskId", taskId);
							taskMap.put("tenantId", tenantId.toString());
							
							taskContentBean = jobConsoleService.getTaskContentBean(taskMap);
							taskContentBean.setTenantId(tenantId);
							taskContenList.add(taskContentBean);
						}
						
						List<String> errorList = jobConsoleService.stop(taskContenList);
						String data = "";
						for (String errorStr : errorList) {
							data += errorStr + ",";
						}
						if (data != null && data.length() >= 1) {
							data = data.substring(0, data.length() - 1);
						}
						String jsonStr ="[{\"msg\":\"true\",\"data\":[" + data + "]}]";
						PrintWriter pw;
						try {
							pw = getResponse().getWriter();
							pw.write(jsonStr) ;
							pw.close() ;
						} catch (IOException e) {
							log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
						}
						return NONE;
					}
				}
			} else if(operator.equals("run")){
				if ("1".equals(allFlag)) {
					List<String> errorList = jobConsoleService.runAll(tenantId.toString());
					String data = "";
					for (String errorStr : errorList) {
						data += errorStr + ",";
					}
					if (data != null && data.length() >= 1) {
						data = data.substring(0, data.length() - 1);
					}
					String jsonStr ="[{\"msg\":\"true\",\"data\":[" + data + "]}]";
					PrintWriter pw;
					try {
						pw = getResponse().getWriter();
						pw.write(jsonStr) ;
						pw.close() ;
					} catch (IOException e) {
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
					}
					return NONE;
				} else {
					String[] taskIdArray = taskIdStr.split(",");
					List<String> taskIdList = Arrays.asList(taskIdArray);
					List<TaskContentBean> taskContenList = new ArrayList();
					for (String taskId : taskIdList){
						TaskContentBean taskContentBean = new TaskContentBean();
						
						Map taskMap = new HashMap();
						taskMap.put("taskId", taskId);
						taskMap.put("tenantId", tenantId.toString());
						
						taskContentBean = jobConsoleService.getTaskContentBean(taskMap);
						taskContentBean.setTenantId(Integer.valueOf(tenantId));
						taskContenList.add(taskContentBean);
					}
					
					List<String> errorList = jobConsoleService.run(taskContenList);
					String data = "";
					for (String errorStr : errorList) {
						data += errorStr + ",";
					}
					if (data != null && data.length() >= 1) {
						data = data.substring(0, data.length() - 1);
					}
					String jsonStr ="[{\"msg\":\"true\",\"data\":[" + data + "]}]";
					PrintWriter pw;
					try {
						pw = getResponse().getWriter();
						pw.write(jsonStr) ;
						pw.close() ;
					} catch (IOException e) {
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
					}
					return NONE;
				}
			}
		}
		return SUCCESS;
	}

	private String serviceObjName;
	/**
	 * 鏉╂稑鍙嗗ǎ璇插閸滃奔鎱ㄩ弨鐟板礂鐠侇噣顪氭い锟�
	 * 
	 */
	public String gotoAddTask(){	

		if(taskId >0){	

			Map taskMap = new HashMap();
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId =CommonUtil.getTenantId(session);
			taskMap.put("taskId", taskId);
			taskMap.put("tenantId", tenantId.toString());
			bean = jobConsoleService.getTaskContentBean(taskMap);
			
			Map param = new HashMap();
			param.put("ObjId", bean.getTaskRelaObj().getObjId());
			param.put("ser_invoke_ins_id", bean.getTaskRelaObj().getObjId());
			String serviceStatus = this.getTaskService().getServiceStatus(param);
			if(serviceStatus == null){
				serviceStatus = "A"; 
			}
			bean.setServiceStatus(serviceStatus);
			serviceObjName = this.getTaskService().getObjNameByObjId(param).get(0).get("OBJNAME").toString();
			if ("F".equals(bean.getTaskState())) {
				taskState = getText("eaap.op2.conf.task.notRunNomal");
			} else if ("I".equals(bean.getTaskState())) {
				taskState = getText("eaap.op2.conf.task.running");
			} else if (bean.getTaskState() != null) {
				taskState = getText("eaap.op2.conf.task.notRunError");
			}

		}
		//显示队列类型名
		Map map = new HashMap();  
		attrSpecValueList = this.getTaskService().getAttrSpecValueList(map);
		selectSerInvokeInsList("check");
		Map mapTemp = new HashMap();  
		cycleList = this.getTaskService().getCycleList(mapTemp);
		taskStyleList = this.getTaskService().getTaskStyleList(mapTemp);
		
		String serviceStatusCD = this.getMainDateTypeCd(SERVICE_STATUS);
		List<MainData> mainDataList = this.getMainDate(serviceStatusCD);
		serviceStatusList = new ArrayList<Map<String,Object>>();
		if(mainDataList!=null && mainDataList.size()>0){
			  for(int i=0;i<mainDataList.size();i++){
				  Map mainDataMap = new HashMap();
				  mainDataMap.put("cepCode", mainDataList.get(i).getCepCode());
				  mainDataMap.put("cepName", mainDataList.get(i).getCepName());
				  serviceStatusList.add(mainDataMap); 
			  }
		 }
		return SUCCESS;
	}
	
	private List<MainData> getMainDate(String mdtName){
		MainData mainData = new MainData();
		mainData.setMdtCd(mdtName);
		List<MainData> mainDateList = this.getTaskService().selectMainData(mainData);
		return mainDateList;
	}
	
	private String getMainDateTypeCd(String mdtName){
		MainDataType mainDateType = new MainDataType();
		mainDateType.setMdtName(mdtName);
		List<MainDataType> mainDateTypeList = this.getTaskService().selectMainDataType(mainDateType);
		String mdtCd = "";
		if(mainDateTypeList.size()>0){
			mdtCd = mainDateTypeList.get(0).getMdtCd();
		}
		return mdtCd;
	}
	
	private int taskTypeId;
	/**
	 * getObjNameAndUrlByTaskTypeId
	 * @return
	 */
	public String getObjNameAndUrlByTaskTypeId() {
		String jsonStr ="";//返回数据
		Map param = new HashMap();
		param.put("TASKTYPEID", taskTypeId);
		objNameAndUrl = this.getTaskService().getObjNameAndUrlByTaskTypeId(param);
		if (objNameAndUrl==null) {
			jsonStr ="[{\"msg\":\"0\",\"data\":\"objName is empty!\"}]";
		}else {
			jsonStr ="[{\"msg\":\"1\",\"NAME\":\""+objNameAndUrl.get(0).get("NAME").toString()+"\",\"URL\":\""+objNameAndUrl.get(0).get("URL").toString()+"\"}]";
		}
		
		//返回json数据
		PrintWriter pw;
		try {
			pw = getResponse().getWriter();
			pw.write(jsonStr) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}
	/**
	 * 
	 */
	public String editTask(){	
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		
		//TypeObj传递来一个queueName
		if(bean.getTaskId() >0){

			if(bean.getThreadNumber()<1){
				bean.setThreadNumber(1);
			}
			bean.setStartDate(null);
			bean.setStopDate(null);
			bean.setTaskState(null);
			bean.setTenantId(tenantId);
			jobConsoleService.updateTaskContentBean(bean);
			if(bean.getTaskRelaObj().getObjId() != 0){
				Map paraMap = new HashMap();
				paraMap.put("serviceState", bean.getServiceStatus()); 
				paraMap.put("ser_invoke_ins_id", bean.getTaskRelaObj().getObjId());
				this.getTaskService().updateServiceStatus(paraMap); 
			}
			this.getIntfSqlLogService().sendIntfSqlLog(bean, "task", EAAPConstants.SQL_UPDATE);
		}
		else{

			Map map = new HashMap() ;  
			map.put("taskCode", bean.getTaskCode());
			map.put("taskName", bean.getTaskName());
			map.put("gcCd", bean.getGcCd());
			map.put("threadNumber", "1");
			map.put("startDate", new Date());
			map.put("startDate", new Date());
			map.put("stateLastDate", new Date());
			map.put("taskType", bean.getTaskType());
			map.put("taskDesc", bean.getTaskDesc());
			map.put("objId", bean.getTaskRelaObj().getObjId());
			map.put("objTypeCd", "1");
			map.put("state", "A");
			map.put("taskStyle", bean.getTaskStyle());
			map.put("tenantId", tenantId);
			jobConsoleService.addTask(map);
			this.getIntfSqlLogService().sendIntfSqlLog(bean, "task", EAAPConstants.SQL_INSERT); 
		}
		selectSerInvokeInsList("base");
		return SUCCESS;
	}

	/**
	 * 閸掔娀娅庨崡蹇氼唴妫ｆ牠銆�

	 * 
	 */
	public String deleteTask(){
		
		if (!"".equals(taskIdStr)) {
			String[] taskIdArray = taskIdStr.split(",");
			List<String> taskIdList = Arrays.asList(taskIdArray);
			List<String> errorList = jobConsoleService.deleteTask(taskIdList);
			for(String taskId : taskIdList){
				Map<String,Object> taskIdMap = new HashMap<String,Object>();
				taskIdMap.put("taskId", taskId);
				this.getIntfSqlLogService().sendIntfSqlLog(taskIdMap, "task", EAAPConstants.SQL_DELETE); 
			}
			String data = "";
			StringBuffer dataBf = new StringBuffer();
			for (String errorStr : errorList) {
				//data += errorStr + "*&*";
				dataBf.append(errorStr).append("*&*");
			}
			data = dataBf.toString();
			if (data != null && data.length() >= 3) {
				data = data.substring(0, data.length() - 3);
			}
			String jsonStr ="[{\"msg\":\"true\",\"data\":\"" + data + "\"}]";
			PrintWriter pw;
			try {
				pw = getResponse().getWriter();
				pw.write(jsonStr) ;
				pw.close() ;
			} catch (IOException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		}
		return NONE;
	}
	
	@SuppressWarnings("unchecked")
	public Map  getTaskList(Map prar) throws Throwable{
		
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<TaskContentBean> tmpList = new ArrayList(); 
   		 List<Map> tempMapList = new ArrayList();
   		Map map = new HashMap() ;  
           map.put("taskName", "".equals(getRequest().getParameter("taskName"))?null:getRequest().getParameter("taskName")) ;
           map.put("serInvokeInsName", "".equals(getRequest().getParameter("serInvokeInsName"))?null:getRequest().getParameter("serInvokeInsName")) ;
   		   map.put("statu", "".equals(getRequest().getParameter("statu"))?null:getRequest().getParameter("statu")) ;
   		   
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId =CommonUtil.getTenantId(session);
   		   map.put("tenantId", tenantId);
   		   
   		   total= jobConsoleService.getTaskListNum(map);
   	        map.put("startPage", startRow);
            map.put("endPage", startRow+rows-1);
            
            map.put("startPage_mysql", startRow-1);
            map.put("endPage_mysql", rows);
            tmpList = jobConsoleService.getTaskList(map);
            for(TaskContentBean taskContentBean : tmpList){
            	
            }
            I18nAspectForCustom i18nAspectForCustom = I18nAspectForCustom.getCustomI18nService();
            if(i18nAspectForCustom != null){
            	i18nAspectForCustom.translateI18N(tmpList);
            }
           
           for (TaskContentBean temp : tmpList) {
        	   Map tempMap = new HashMap() ;  
        	   tempMap.put("taskId", temp.getTaskId());
        	   tempMap.put("taskName", temp.getTaskName());
        	   tempMap.put("threadNumber", temp.getThreadNumber());
        	   tempMap.put("name", temp.getName());
        	   tempMap.put("taskType", temp.getTaskType());
        	   tempMap.put("taskTypeName", temp.getTaskTypeObj()==null ?"":temp.getTaskTypeObj().getQueueName());
        	   tempMap.put("stateLastDate", temp.getStateLastDate());
        	   tempMap.put("startDate", temp.getStartDate());
        	   tempMap.put("stopDate", temp.getStopDate());
        	   tempMap.put("taskState", temp.getTaskState());
        	   tempMap.put("gcExp", temp.getGcExp());
        	   tempMap.put("serviceObjectId", temp.getTaskRelaObj()==null ?"":temp.getTaskRelaObj().getObjId());
        	   tempMap.put("taskStyle", temp.getTaskStyle());
        	   tempMap.put("taskStyleName",  temp.getTaskStyleObj()==null ?"":temp.getTaskStyleObj().getTaskStyleDesc());
        	   if(temp.getTaskUsable()){
        		   tempMap.put("serviceStatus", "A");
	           	}else{
	           		tempMap.put("serviceStatus", "D");
	           	}
        	   tempMapList.add(tempMap);
           }
            returnMap.put("startRow", startRow);
            returnMap.put("rows", rows); 	
            returnMap.put("total", total);
            returnMap.put("dataList", page.convertJson(tempMapList)); 
   		return returnMap ;
   	}
	
	@SuppressWarnings("unchecked")
	public String  selectSerInvokeInsList(String mark){
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		Map serInvokeInsStateMap3 = new HashMap();
		if(mark.endsWith("base")){			 
			 serInvokeInsStateMap1.put("name", getText("eaap.op2.portal.prov.effective"));
			 serInvokeInsStateMap1.put("code", "A");			 
			 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.effectiveLoss"));
			 serInvokeInsStateMap2.put("code", "R");
		}
		if(mark.endsWith("check")){
			 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.task.notRunNomal"));
			 serInvokeInsStateMap1.put("code", "F");			 
			 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.task.running"));
			 serInvokeInsStateMap2.put("code", "I");
			 serInvokeInsStateMap3.put("name", getText("eaap.op2.conf.task.notRunError"));
			 serInvokeInsStateMap3.put("code", "E");
		}	
		 selectStateList.add(serInvokeInsStateMap1);
		 selectStateList.add(serInvokeInsStateMap2);
		 selectStateList.add(serInvokeInsStateMap3);
		return SUCCESS ;
	}
	
	public void sentOperatorLog(String taskIdStr,String operatorType){
		String ipAddress = getRequest().getRemoteAddr();
		String sessionId = getRequest().getSession().getId().toString();
		
		Cookie[] cookies = getRequest().getCookies();
		Cookie cookie = null;
		String sysPersonId = null;
		if(cookies != null){
			for(int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if("sysPersonId".equals(cookie.getName())){
					sysPersonId = cookie.getValue();
				}
			}
		}

		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		   
		String[] taskIdArray = taskIdStr.split(",");
		List<String> taskIdList = Arrays.asList(taskIdArray);
		for (String taskId : taskIdList){
			Map operatorLogMap = new HashMap();
			operatorLogMap.put("taskId", taskId);
			operatorLogMap.put("sessionId", sessionId);
			operatorLogMap.put("staffNo", sysPersonId);
			operatorLogMap.put("ip", ipAddress);
			operatorLogMap.put("type", operatorType);
			operatorLogMap.put("tenantId", tenantId);
			jobConsoleService.operatorLog(operatorLogMap);
		}
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

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
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

	public void setJobConsoleService(IJobConsoleService jobConsoleService) {
		this.jobConsoleService = jobConsoleService;
	}

	public IJobConsoleService getJobConsoleService() {
		if(jobConsoleService==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			jobConsoleService = (IJobConsoleService)ctx.getBean("jobConsoleService");		   
	     }
		return jobConsoleService;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public TaskContentBean getBean() {
		return bean;
	}

	public void setBean(TaskContentBean bean) {
		this.bean = bean;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public List<TaskContentBean> getListBean() {
		return listBean;
	}

	public void setListBean(List<TaskContentBean> listBean) {
		this.listBean = listBean;
	}
	
	public String getTaskCode() {
		return taskCode;
	}

	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}

	public String getGcCd() {
		return gcCd;
	}

	public void setGcCd(String gcCd) {
		this.gcCd = gcCd;
	}

	public int getThreadNumber() {
		return threadNumber;
	}

	public void setThreadNumber(int threadNumber) {
		this.threadNumber = threadNumber;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getStopDate() {
		return stopDate;
	}

	public void setStopDate(String stopDate) {
		this.stopDate = stopDate;
	}

	public String getTaskState() {
		return taskState;
	}

	public void setTaskState(String taskState) {
		this.taskState = taskState;
	}

	public String getStateLastDate() {
		return stateLastDate;
	}

	public void setStateLastDate(String stateLastDate) {
		this.stateLastDate = stateLastDate;
	}

	public String getTaskDesc() {
		return taskDesc;
	}

	public void setTaskDesc(String taskDesc) {
		this.taskDesc = taskDesc;
	}

	public String getGcExp() {
		return gcExp;
	}

	public void setGcExp(String gcExp) {
		this.gcExp = gcExp;
	}

	@SuppressWarnings("unchecked")
	public List<Map> getSelectStateList() {
		return selectStateList;
	}

	@SuppressWarnings("unchecked")
	public void setSelectStateList(List<Map> selectStateList) {
		this.selectStateList = selectStateList;
	}

	public int getServiceId() {
		return serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}

	public String getGcName() {
		return gcName;
	}

	public void setGcName(String gcName) {
		this.gcName = gcName;
	}

	public List<Map<String, Object>> getCycleList() {
		return cycleList;
	}

	public void setCycleList(List<Map<String, Object>> cycleList) {
		this.cycleList = cycleList;
	}

	public String getSerInvokeInsId() {
		return serInvokeInsId;
	}

	public void setSerInvokeInsId(String serInvokeInsId) {
		this.serInvokeInsId = serInvokeInsId;
	}

	public String getAllFlag() {
		return allFlag;
	}

	public void setAllFlag(String allFlag) {
		this.allFlag = allFlag;
	}

	public List<TaskContentBean> getTaskTypeList() {
		return taskTypeList;
	}

	public void setTaskTypeList(List<TaskContentBean> taskTypeList) {
		this.taskTypeList = taskTypeList;
	}

	public String getSerInvokeInsName() {
		return serInvokeInsName;
	}

	public void setSerInvokeInsName(String serInvokeInsName) {
		this.serInvokeInsName = serInvokeInsName;
	}

	public String getTaskIdStr() {
		return taskIdStr;
	}

	public void setTaskIdStr(String taskIdStr) {
		this.taskIdStr = taskIdStr;
	}

	public List<Map<String, Object>> getAttrSpecValueList() {
		return attrSpecValueList;
	}

	public void setAttrSpecValueList(List<Map<String, Object>> attrSpecValueList) {
		this.attrSpecValueList = attrSpecValueList;
	}

	public int getTaskTypeId() {
		return taskTypeId;
	}

	public void setTaskTypeId(int taskTypeId) {
		this.taskTypeId = taskTypeId;
	}

	public List<Map<String, Object>> getObjNameAndUrl() {
		return objNameAndUrl;
	}

	public void setObjNameAndUrl(List<Map<String, Object>> objNameAndUrl) {
		this.objNameAndUrl = objNameAndUrl;
	}

	public String getServiceObjName() {
		return serviceObjName;
	}

	public void setServiceObjName(String serviceObjName) {
		this.serviceObjName = serviceObjName;
	}

	public List<Map<String, Object>> getTaskStyleList() {
		return taskStyleList;
	}

	public void setTaskStyleList(List<Map<String, Object>> taskStyleList) {
		this.taskStyleList = taskStyleList;
	}

	
	public IntfSqlLogService getIntfSqlLogService() {
		if(intfSqlLogService == null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			intfSqlLogService = (IntfSqlLogService)ctx.getBean("eaap-op2-conf-sqllog-intfSqlLogService");		   
	     }
		return intfSqlLogService;
	}

	public void setIntfSqlLogService(IntfSqlLogService intfSqlLogService) {
		this.intfSqlLogService = intfSqlLogService;
	}

	public List<Map<String, Object>> getServiceStatusList() {
		return serviceStatusList;
	}

	public void setServiceStatusList(List<Map<String, Object>> serviceStatusList) {
		this.serviceStatusList = serviceStatusList;
	}

	public String getServiceStatus() {
		return serviceStatus;
	}

	public void setServiceStatus(String serviceStatus) {
		this.serviceStatus = serviceStatus;
	}

	
}
