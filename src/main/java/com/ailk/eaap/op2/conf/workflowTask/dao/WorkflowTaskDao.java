package com.ailk.eaap.op2.conf.workflowTask.dao;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: WorkflowTaskDao
 * @Description: 
 * @author zhengpeng
 * @date 2015-4-17 上午10:22:42
 *
 */
public interface WorkflowTaskDao {
	
	public List<Map<String,Object>> getWorkFlowTaskResultList(Map<String,Object> paramMap);
	
	public List<Map<String,Object>> getWorkFlowTaskResultCount(Map<String,Object> paramMap);
	
	public int updateWorkFlowTaskResult(Map<String,Object> paramMap);

}
