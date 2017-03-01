package com.ailk.eaap.op2.conf.workflowTask.dao;

import java.util.List;
import java.util.Map;

import com.linkage.rainbow.dao.SqlMapDAO;

/**
 * @ClassName: WorkflowTaskDaoImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-4-17 上午10:25:44
 *
 */
public class WorkflowTaskDaoImpl implements WorkflowTaskDao{
	
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getWorkFlowTaskResultList(Map<String,Object> paramMap){
		return sqlMapDao.queryForList("eaap-op2-conf-workflow-task.getWorkFlowTaskResultList", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> getWorkFlowTaskResultCount(Map<String,Object> paramMap){
		return sqlMapDao.queryForList("eaap-op2-conf-workflow-task.getWorkFlowTaskResultCount", paramMap);
	}
	
	public int updateWorkFlowTaskResult(Map<String,Object> paramMap){ 
		return sqlMapDao.update("eaap-op2-conf-workflow-task.updateWorkFlowTaskReslt", paramMap);
	}
	
	

}
