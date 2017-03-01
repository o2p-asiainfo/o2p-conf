/** 
 * Project Name:o2p-workflow-pro 
 * File Name:ManualOperController.java 
 * Package Name:com.ailk.o2p.workflow.controller 
 * Date:2016年1月24日下午2:43:29 
 * Copyright (c) 2016, www.asiainfo.com All Rights Reserved. 
 * 
*/  
  
package com.ailk.eaap.op2.conf.auditing.action;  


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.axis.utils.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.ExceptionLog;
import com.ailk.eaap.op2.conf.auditing.service.IExceptionLogServ;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WorkRestUtils;
import com.linkage.rainbow.ui.struts.BaseAction;

/** 
 * ClassName:ManualOperController <br/> 
 * Function: TODO ADD FUNCTION. <br/> 
 * Reason:   TODO ADD REASON. <br/> 
 * Date:     2016年1月24日 下午2:43:29 <br/> 
 * @author   wushuzhen 
 * @version   
 * @since    JDK 1.7 
 * @see       
 */
public class ManualOperExceptionAction extends BaseAction{
	private static final Logger log = Logger.getLog(ManualOperExceptionAction.class);
	
	private IExceptionLogServ exceptionLogServ;
	
	public String process_Id;
	public String activity_Id;
	public String content_Id;
	public String act_Id;
	
	public String selectValue;
	public String taskId;

	JSONObject subData;
	ExceptionLog exceptionLog=new ExceptionLog();
	List<Map<String,String>> nextTachList= new ArrayList<Map<String,String>>();

	/**
	 * 下个执行节点下拉框
	 */
	public List<Map<String, String>> getNextTach(String processId){
		String nextTachJsonStr=WorkRestUtils.getNextTach(processId);
		com.alibaba.fastjson.JSONObject retJson = new com.alibaba.fastjson.JSONObject();
		com.alibaba.fastjson.JSONObject json = null;
		List<Map<String,String>> nextTachList=new ArrayList<Map<String,String>>();
		Map<String, String> nextTachMap = null;
		if(!StringUtils.isEmpty(nextTachJsonStr)){
			retJson = JSON.parseObject(nextTachJsonStr);
		}
		
		JSONArray array = retJson.getJSONArray("dataArray");
		if(array!=null){
			for (int i=0;i<array.size();i++){
				json = new JSONObject();
				nextTachMap=new HashMap<String, String>();
				json = (com.alibaba.fastjson.JSONObject) (array.get(i));
				nextTachMap.put("id", json.getString("id"));
				nextTachMap.put("name",json.getString("name"));
		        nextTachList.add(nextTachMap);
			}
		}		
		return nextTachList;
	}
	
	/**
	 * activiti 信息
	 */
	private JSONObject taskListByActivitiId(String activitiId){
		String message = WorkRestUtils.getActMsgInfo(activitiId);
		JSONObject retJson = new JSONObject();
		if(!StringUtils.isEmpty(message)){
			retJson = JSON.parseObject(message);
		}
		return retJson;
	    
	}
	
	/**
	 * 手动任务详情处理
	 */
	public String queryExceptionLogInfo(){
		try{
			subData=this.taskListByActivitiId(act_Id);
			String actBeforeErrorActId=WorkRestUtils.getActivityBeforeErrorAct(process_Id);
			exceptionLog=this.getExceptionLogServ().selectExceptionLogByActId(null,content_Id);
			nextTachList=getNextTach(process_Id);
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"exception:" + e.getMessage(),null));
		}
		
		return SUCCESS ;
	}

	
	public void reSendMessage(){
		JSONObject data = new JSONObject();
		data.put("nextTach", selectValue);
		WorkRestUtils.completeTask(taskId,data.toJSONString());
	}
	
	
	public JSONObject getSubData() {
		return subData;
	}

	public void setSubData(JSONObject subData) {
		this.subData = subData;
	}

	public ExceptionLog getExceptionLog() {
		return exceptionLog;
	}

	public void setExceptionLog(ExceptionLog exceptionLog) {
		this.exceptionLog = exceptionLog;
	}



	public List<Map<String, String>> getNextTachList() {
		return nextTachList;
	}

	public void setNextTachList(List<Map<String, String>> nextTachList) {
		this.nextTachList = nextTachList;
	}

	public void setExceptionLogServ(IExceptionLogServ exceptionLogServ) {
		this.exceptionLogServ = exceptionLogServ;
	}



	
	public IExceptionLogServ getExceptionLogServ() {
		if(exceptionLogServ==null){
            //取得spring上下文
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			// 取得spring bean实例
			exceptionLogServ = (IExceptionLogServ)ctx.getBean("exceptionLogService");
	     }
		return exceptionLogServ;
	}


	public String getProcess_Id() {
		return process_Id;
	}

	public void setProcess_Id(String process_Id) {
		this.process_Id = process_Id;
	}

	public String getActivity_Id() {
		return activity_Id;
	}

	public void setActivity_Id(String activity_Id) {
		this.activity_Id = activity_Id;
	}

	public String getContent_Id() {
		return content_Id;
	}

	public void setContent_Id(String content_Id) {
		this.content_Id = content_Id;
	}
	
	 public String getSelectValue() {
			return selectValue;
		}

	public void setSelectValue(String selectValue) {
		this.selectValue = selectValue;
	}
	
	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	public String getAct_Id() {
		return act_Id;
	}

	public void setAct_Id(String act_Id) {
		this.act_Id = act_Id;
	}
}
