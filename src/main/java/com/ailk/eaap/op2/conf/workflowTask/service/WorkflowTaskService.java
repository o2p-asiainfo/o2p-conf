package com.ailk.eaap.op2.conf.workflowTask.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;

/**
 * @ClassName: WorkflowTaskService
 * @Description: 
 * @author zhengpeng
 * @date 2015-4-17 上午10:26:45
 *
 */
public interface WorkflowTaskService {
	
	public List<Map<String,Object>> getWorkFlowTaskResultList(Map<String,Object> paramMap);
	
	public List<Map<String,Object>> getWorkFlowTaskResultCount(Map<String,Object> paramMap);
	
	public int updateWorkFlowTaskResult(Map<String,Object> paramMap);
	
	public List<MainData> selectMainData(MainData mainData);
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType);

}
