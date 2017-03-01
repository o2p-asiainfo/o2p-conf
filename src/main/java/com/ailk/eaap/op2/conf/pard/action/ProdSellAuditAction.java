package com.ailk.eaap.op2.conf.pard.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.ailk.eaap.op2.conf.pard.service.IProdSellAuditServ;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.workflow.engine.activity.ActivityInstance;
import com.workflow.engine.process.ProcessInstance;
import com.workflow.remote.WorkflowRemoteInterface;

/**
 * 可销售产品审核
 * @author litian
 *
 */
@SuppressWarnings("unchecked")
public class ProdSellAuditAction extends BaseAction{

	private static final long serialVersionUID = 4190078652222604000L;
	private Log log = LogFactory.getLog(ProdSellAuditAction.class);
	private IProdSellAuditServ prodSellAuditServ;
	private String processId;
	private String activityId;
	private String applyName;
	private String applyDesc;
	private List<Map> applyInfoList;
	private String auditState;
	private String auditDesc;

	/**
	 * 待审核产品查询
	 * 
	 * @return
	 */
	public String queryApplyInfo(){
		HttpServletRequest request = getRequest();
		processId = request.getParameter("process_Id");
		activityId = request.getParameter("activity_Id");
		Map map = new HashMap();
		map.put("AUDIT_FLOW_ID", processId);
		applyInfoList = getIPardSellServ().queryApplyInfo(map);

		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		
		ProcessInstance processInstance = wi.getProcessInstance(processId);
		String activityId = processInstance.getBegin_Activity_Id();
		ActivityInstance instance = wi.getActivityInstance(activityId);
		applyDesc = instance.getCreate_Message();
		applyName = instance.getAct_Cont_Desc();
		return SUCCESS; 
	}
	
	/**
	 * 可销售产品审核
	 * 
	 * @return
	 * @throws Exception 
	 */
	public String prodAudit() throws Exception{
		StringBuffer sb = new StringBuffer("audit_result=");
		sb.append(auditState);
		sb.append(",suggestion=");
		sb.append(auditDesc);
		String actValues = sb.toString();

		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		
		ActivityInstance activityInstance = wi.getActivityInstance(activityId);
		
		Map retMap = wi.activityExecuteByUser(activityInstance, "123456", null,
				null, "E", actValues, null, null, null, auditDesc);
		log.info(retMap);
		if(!"1".equals(retMap.get("RETURNCODE"))){
			throw new Exception(getText("eaap.op2.conf.prodOffer.flowErrorMsg")); 
		}
		
		Map map = new HashMap();
		map.put("STATUS_CD", "1".equals(auditState) ? "1000" : "1298");
		map.put("AUDIT_FLOW_ID", processId);
		getIPardSellServ().updateAuditState(map);
		
		return SUCCESS;
	}
	
	private IProdSellAuditServ getIPardSellServ() {
		if (prodSellAuditServ == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			prodSellAuditServ = (IProdSellAuditServ) ctx
					.getBean("eaap-op2-conf-auditing-PardSellServ");
		}
		return prodSellAuditServ;
	}
	
	public List<Map> getApplyInfoList() {
		return applyInfoList;
	}

	public void setApplyInfoList(List<Map> applyInfoList) {
		this.applyInfoList = applyInfoList;
	}
	
	public String getProcessId() {
		return processId;
	}

	public void setProcessId(String processId) {
		this.processId = processId;
	}

	public String getActivityId() {
		return activityId;
	}

	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}

	public String getAuditState() {
		return auditState;
	}

	public void setAuditState(String auditState) {
		this.auditState = auditState;
	}

	public String getAuditDesc() {
		return auditDesc;
	}

	public void setAuditDesc(String auditDesc) {
		this.auditDesc = auditDesc;
	}

	public String getApplyDesc() {
		return applyDesc;
	}

	public void setApplyDesc(String applyDesc) {
		this.applyDesc = applyDesc;
	}

	public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}
}
