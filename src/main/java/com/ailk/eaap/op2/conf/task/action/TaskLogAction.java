package com.ailk.eaap.op2.conf.task.action;

import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.fileExchange.model.TaskJobLogBean;
import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.conf.task.service.IJobConsoleService;
import com.ailk.eaap.op2.conf.task.service.ITaskService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;


/**
 * �澯����̨�õ���action
 *
 */
public class TaskLogAction extends BaseAction{

	private static final long serialVersionUID = 1L;	
	private ITaskService taskService;	
	public IJobConsoleService jobConsoleService;
	private List<TaskContentBean> listBean;
	
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();

    private String workName;
    private String statu;
	private String taskName;              
	private String jobName;
	private int taskLogId;
	private TaskJobLogBean taskJobLogBean;
    
    
    
    @SuppressWarnings("unchecked")
	private List<Map> selectStateList = new ArrayList<Map>();
	
	public String showTaskLog(){
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	public Map  getTaskLogList(Map prar){
		
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<TaskJobLogBean> tmpList = new ArrayList();  		 
         Map map = new HashMap() ;  
         map.put("jobName", "".equals(getRequest().getParameter("jobName"))?null:getRequest().getParameter("jobName")) ;

		 HttpSession session = ServletActionContext.getRequest().getSession();
		 Integer tenantId =CommonUtil.getTenantId(session);
		 map.put("tenantId", tenantId);
		   
         total= jobConsoleService.getTaskLogListNum(map);
         
         map.put("startPage", startRow);
         map.put("endPage", startRow+rows-1);
         map.put("startPage_mysql", startRow-1);
         map.put("endPage_mysql", rows);
         
         tmpList = jobConsoleService.getTaskLogList(map); 	
         
         returnMap.put("startRow", startRow);
         returnMap.put("rows", rows); 	
         returnMap.put("total", total);
         returnMap.put("dataList", page.convertJson(tmpList)); 
         
         return returnMap ;
   	}
	
	public String gotoTaskLogDetail(){	
		
		if(taskLogId >0){

			taskJobLogBean = jobConsoleService.getTaskJobLogById(taskLogId);
			
			String evenType = taskJobLogBean.getEventType();
			
			if ("1".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType1");
			} else if ("2".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType2");
			} else if ("3".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType3");
			} else if ("4".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType4");
			} else if ("5".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType5");
			} else if ("6".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType6");
			} else if ("7".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType7");
			} else if ("8".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType8");
			} else if ("9".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType9");
			} else if ("10".equals(evenType)) {
				evenType = getText("eaap.op2.conf.task.evenType10");
			}
			
			String logType = taskJobLogBean.getLogType();
			if ("1".equals(logType)) {
				logType = getText("eaap.op2.conf.task.logType1");
			} else if ("2".equals(logType)) {
				logType = getText("eaap.op2.conf.task.logType2");
			} 
			
			taskJobLogBean.setEventType(evenType);
			taskJobLogBean.setLogType(logType);
		}
		
		return SUCCESS;
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

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public ITaskService getTaskService() {
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

	public List<TaskContentBean> getListBean() {
		return listBean;
	}

	public void setListBean(List<TaskContentBean> listBean) {
		this.listBean = listBean;
	}
	
	@SuppressWarnings("unchecked")
	public String  selectSerInvokeInsList(String mark){
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		Map serInvokeInsStateMap3 = new HashMap();
		if(mark.endsWith("check")){
			 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.task.notRunNomal"));
			 serInvokeInsStateMap1.put("code", "2");			 
			 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.task.running"));
			 serInvokeInsStateMap2.put("code", "1");
			 serInvokeInsStateMap3.put("name", getText("eaap.op2.conf.task.notRunError"));
			 serInvokeInsStateMap3.put("code", "3");
		}	
		 selectStateList.add(serInvokeInsStateMap1);
		 selectStateList.add(serInvokeInsStateMap2);
		 selectStateList.add(serInvokeInsStateMap3);
		 
		return SUCCESS ;
	}

	
	@SuppressWarnings("unchecked")
	public List<Map> getSelectStateList() {
		return selectStateList;
	}

	@SuppressWarnings("unchecked")
	public void setSelectStateList(List<Map> selectStateList) {
		this.selectStateList = selectStateList;
	}

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public int getTaskLogId() {
		return taskLogId;
	}

	public void setTaskLogId(int taskLogId) {
		this.taskLogId = taskLogId;
	}

	public TaskJobLogBean getTaskJobLogBean() {
		return taskJobLogBean;
	}

	public void setTaskJobLogBean(TaskJobLogBean taskJobLogBean) {
		this.taskJobLogBean = taskJobLogBean;
	}

}
