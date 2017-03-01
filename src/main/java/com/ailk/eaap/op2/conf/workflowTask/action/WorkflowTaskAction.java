package com.ailk.eaap.op2.conf.workflowTask.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.common.CommonUtil;
import com.ailk.eaap.op2.conf.workflowTask.service.WorkflowTaskService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;
import com.linkage.rainbow.util.StringUtil;

/**
 * @ClassName: WorkflowTaskAction
 * @Description: 
 * @author zhengpeng
 * @date 2015-4-17 上午10:35:54
 *
 */
public class WorkflowTaskAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	private WorkflowTaskService workflowTaskService;
	private Logger log = Logger.getLog(this.getClass());
	private static final String WORKFLOW_TASK_STATUS = "WORKFLOW_TASK_STATUS";
	private Pagination page=new Pagination();
	private String startDate = DateUtil.convDateToString(DateUtil.getDateBefore(new Date(), -1),"yyyy-MM-dd");
	private String endDate = DateUtil.convDateToString(new Date(), "yyyy-MM-dd");
	private List<Map> statusTypeList = new ArrayList<Map>();
	private int rows;
	private int pageNum;
	private int total;
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setWorkflowTaskService(WorkflowTaskService workflowTaskService) {
		this.workflowTaskService = workflowTaskService;
	}
	
	public WorkflowTaskService getWorkflowTaskService() {
		if(workflowTaskService == null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			workflowTaskService = (WorkflowTaskService)ctx.getBean("eaap-op2-conf-workflow-task-service");
	     }
		return workflowTaskService;
	}
	

	public List<Map> getStatusTypeList() {
		return statusTypeList;
	}

	public void setStatusTypeList(List<Map> statusTypeList) {
		this.statusTypeList = statusTypeList;
	}

	public String showWorkFlowTaskList(){
		MainDataType mainDataType = new MainDataType();
		mainDataType.setMdtSign(WORKFLOW_TASK_STATUS);
		mainDataType = getWorkflowTaskService().selectMainDataType(mainDataType).get(0);
		
		MainData mainData = new MainData();
		mainData.setMdtCd(mainDataType.getMdtCd());
		List<MainData> mainDataList = getWorkflowTaskService().selectMainData(mainData);
		
		if(mainDataList!=null && mainDataList.size()>0){
			 for(int i=0;i<mainDataList.size();i++){
				 Map mainDataMap = new HashMap();
				 mainDataMap.put("cepCode", mainDataList.get(i).getCepCode());
				 mainDataMap.put("cepName", mainDataList.get(i).getCepName());
				 statusTypeList.add(mainDataMap); 
			 }
		}
		return SUCCESS;
	}
	
	
	public Map getWorkFlowTaskList(Map paramMap){
		rows = page.getRows();
		pageNum = page.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		Map<String,Object> returnMap = new HashMap<String,Object>();
		
		Map<String,Object> map = new HashMap<String,Object>(); 
		map.put("ACT_ID", "".equals(paramMap.get("act_id"))?null:paramMap.get("act_id"));
		map.put("ACT_NAME", "".equals(paramMap.get("act_name"))?null:paramMap.get("act_name"));
		map.put("RESULT", "".equals(paramMap.get("act_name"))?null:paramMap.get("act_name"));
		if(paramMap.get("startDate") == null || "".equals(paramMap.get("startDate"))){
			map.put("START_DATE", startDate);
		}else{
			map.put("START_DATE", paramMap.get("startDate"));
		}
		if(paramMap.get("endDate") == null || "".equals(paramMap.get("endDate"))){
			map.put("END_DATE", startDate);
		}else{
			map.put("END_DATE", paramMap.get("endDate"));
		}
		List<Map<String,Object>> tmpList = this.getWorkflowTaskService().getWorkFlowTaskResultCount(map); 
		total = Integer.valueOf(String.valueOf(tmpList.get(0).get("ALLNUM")));
		map.put("pro", startRow);
        map.put("end", startRow+rows-1);
         
        map.put("pro_mysql", (pageNum - 1) * rows);
	    map.put("page_record", rows);
	    tmpList = this.getWorkflowTaskService().getWorkFlowTaskResultList(map);
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(tmpList)); 
		return returnMap;
	}
	
	public String updateWorkFlowTaskResult(){
		String id = this.id;
		if(!StringUtil.isEmpty(id)){
			Map<String,Object> map = new HashMap<String,Object>(); 
			map.put("ID", id);
			int reuslt = this.getWorkflowTaskService().updateWorkFlowTaskResult(map);
			String jsonStr ="[{\"msg\":\""+reuslt+"\"}]";
			PrintWriter pw;
			try {
				pw = getResponse().getWriter();
				pw.write(jsonStr) ;
				pw.close() ;
			} catch (IOException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,CommonUtil.getErrMsg(e),null));
			}
		}
		return NONE;
	}
	
	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
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
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	

}
