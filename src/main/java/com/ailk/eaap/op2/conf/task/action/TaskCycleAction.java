package com.ailk.eaap.op2.conf.task.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.bo.GatherCycle;
import com.ailk.eaap.op2.conf.task.service.IJobConsoleService;
import com.ailk.eaap.op2.conf.task.service.ITaskService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

/**
 * 告警控制台用到的action
 * 
 */
public class TaskCycleAction extends BaseAction {
	private Logger log = Logger.getLog(this.getClass());

	private static final long serialVersionUID = 1L;
	private ITaskService taskService;
	public IJobConsoleService jobConsoleService;
	private List<TaskContentBean> listBean;

	private int rows;
	private int pageNum;
	private int total;
	private Pagination page = new Pagination();
	private Pagination pagination = new Pagination();

	private GatherCycle gatherCycleBean = new GatherCycle();
	private List<Map> dateList = new ArrayList<Map>();

	@SuppressWarnings("unchecked")
	private List<Map> selectStateList = new ArrayList<Map>();

	private int gcCd;
	private String taskCycleFlag;

	public String showTaskCycle() {
		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public Map getTaskCycleList(Map prar) {

		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		Map returnMap = new HashMap();
		List<GatherCycle> tmpList = new ArrayList();
		Map map = new HashMap();
		map.put("taskCycleName", "".equals(getRequest().getParameter("taskCycleName")) ? null : getRequest().getParameter("taskCycleName"));
		map.put("taskCycleCd", "".equals(getRequest().getParameter("taskCycleCd")) ? null : getRequest().getParameter("taskCycleCd"));

		map.put("startPage_mysql", startRow - 1);
		map.put("endPage_mysql", rows);
		
		map.put("startRow_oracle", startRow);
		map.put("endRow_oracle", startRow+rows-1);

		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		map.put("tenantId", tenantId);
		total = jobConsoleService.getTaskCycleNum(map); 

		tmpList = jobConsoleService.getTaskCycleList(map);
		
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows);
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(tmpList));
		return returnMap;
	}

	/**
	 * 进入添加和修改周期首页
	 * 
	 */
	public String gotoAddTaskCycle() {
		if (gcCd > 0) {
			gatherCycleBean = getJobConsoleService().getGatherCycleBean(gcCd);
		}
		return SUCCESS;
	}

	/**
	 * 添加/修改周期提交
	 * 
	 */
	public String editTaskCycle() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		gatherCycleBean.setTenantId(tenantId);
		
		if (gatherCycleBean.getGcCd() != null && gatherCycleBean.getGcCd() > 0) {
			jobConsoleService.updateCycle(gatherCycleBean);
		} else {
			gcCd = jobConsoleService.addCycle(gatherCycleBean);
		}
		return SUCCESS;
	}

	/**
	 * 删除周期首页
	 * 
	 */
	public String deleteTaskCycle() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		gatherCycleBean.setTenantId(tenantId);
		
		gatherCycleBean.setGcCd(gcCd);
		int count = jobConsoleService.deleteCycle(gatherCycleBean);
		String msg = "";
		if(count > 0){
			msg = "true";
		} else {

		}
		PrintWriter pw;
		try {
			pw = getResponse().getWriter();
			pw.write(msg) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return null;
	}

	public boolean verifyCron(String verifyParam, String paramValue) {
		String regex = "(([*]{1}|([0-5]{0,1}[0-9]{1})|([0-5]{0,1}[0-9]{1}([,-][0-5]{0,1}[0-9])*)|([0-5]{0,1}[0-9]{1}/[0-5]{0,1}[0-9]{1}))\\s+){2}";
		// 小时
		regex += "(([*]{1}|(([0,1]{0,1}[0-9]{1})|2[0-3])|((([0,1]{0,1}[0-9]{1})|2[0-3])([,-](([0,1]{0,1}[0-9]{1})|2[0-3]))*)|((([0,1]{0,1}[0-9]{1})|2[0-3])/(([0,1]{0,1}[0-9]{1})|2[0-3])))\\s+){1}";

		// 月中的天
		regex += "(([*?L]{1}|[1-7]#[1-5]|(([0-2]{0,1}[0-9]{1}L{0,1})|3[0-1])|((([0-2]{0,1}[0-9]{1})|3[0-1])([,-](([0-2]{0,1}[0-9]{1})|3[0-1]))*)|((([0-2]{0,1}[0-9]{1})|3[0-1])/(([0-2]{0,1}[0-9]{1})|3[0-1])))\\s+){1}";

		// 月
		regex += "(([*]{1}|(([0]{0,1}[0-9]{1})|1[0-1])|((([0]{0,1}[0-9]{1})|1[0-1])([,-](([0]{0,1}[0-9]{1})|1[0-1]))*)|((([0]{0,1}[0-9]{1})|1[0-1])/(([0]{0,1}[0-9]{1})|1[0-1])))\\s+){1}";

		// 星期中的天1=sun
		regex += "(([*?]{1}|(([1-7]|SUN|MON|TUE|WED|THU|FRI|SAT|Sun|Mon|Tue|Wed|Thu|Fri|Sat|sun|mon|tue|wed|thu|fri|sat){1}L{0,1})|((([1-7]|SUN|MON|TUE|WED|THU|FRI|SAT|Sun|Mon|Tue|Wed|Thu|Fri|Sat|sun|mon|tue|wed|thu|fri|sat){1})([,-](([1-7]|SUN|MON|TUE|WED|THU|FRI|SAT|Sun|Mon|Tue|Wed|Thu|Fri|Sat|sun|mon|tue|wed|thu|fri|sat){1}))*)|((([1-7]|SUN|MON|TUE|WED|THU|FRI|SAT|Sun|Mon|Tue|Wed|Thu|Fri|Sat|sun|mon|tue|wed|thu|fri|sat){1})/(([1-7]|SUN|MON|TUE|WED|THU|FRI|SAT|Sun|Mon|Tue|Wed|Thu|Fri|Sat|sun|mon|tue|wed|thu|fri|sat){1})))\\s*){1}";
		// 年
		regex += "(([*]{0,1})|20[0-9][0-9]{1}([-]20[0-9][0-9])*){1}";

		String input = paramValue;

		if (!Pattern.matches(regex, input)) {
			return false;
		}
		;// 需要判断的字符串是否符合全由数字组成,符合返回true,否则返回false

		return true;
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
	public String selectSerInvokeInsList(String mark) {
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		Map serInvokeInsStateMap3 = new HashMap();
		if (mark.endsWith("check")) {
			serInvokeInsStateMap1.put("name",
					getText("eaap.op2.conf.task.notRunNomal"));
			serInvokeInsStateMap1.put("code", "2");
			serInvokeInsStateMap2.put("name",
					getText("eaap.op2.conf.task.running"));
			serInvokeInsStateMap2.put("code", "1");
			serInvokeInsStateMap3.put("name",
					getText("eaap.op2.conf.task.notRunError"));
			serInvokeInsStateMap3.put("code", "3");
		}
		selectStateList.add(serInvokeInsStateMap1);
		selectStateList.add(serInvokeInsStateMap2);
		selectStateList.add(serInvokeInsStateMap3);

		return SUCCESS;
	}

	@SuppressWarnings("unchecked")
	public List<Map> getSelectStateList() {
		return selectStateList;
	}

	@SuppressWarnings("unchecked")
	public void setSelectStateList(List<Map> selectStateList) {
		this.selectStateList = selectStateList;
	}

	public List<Map> getDateList() {
		return dateList;
	}

	public void setDateList(List<Map> dateList) {
		this.dateList = dateList;
	}

	public int getGcCd() {
		return gcCd;
	}

	public void setGcCd(int gcCd) {
		this.gcCd = gcCd;
	}

	public GatherCycle getGatherCycleBean() {
		return gatherCycleBean;
	}

	public void setGatherCycleBean(GatherCycle gatherCycleBean) {
		this.gatherCycleBean = gatherCycleBean;
	}

	public String getTaskCycleFlag() {
		return taskCycleFlag;
	}

	public void setTaskCycleFlag(String taskCycleFlag) {
		this.taskCycleFlag = taskCycleFlag;
	}
}
