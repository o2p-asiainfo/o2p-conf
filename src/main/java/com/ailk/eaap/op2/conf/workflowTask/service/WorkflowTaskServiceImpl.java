package com.ailk.eaap.op2.conf.workflowTask.service;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.workflowTask.dao.WorkflowTaskDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;

/**
 * @ClassName: WorkflowTaskServiceImpl
 * @Description: 
 * @author zhengpeng
 * @date 2015-4-17 上午10:31:12
 *
 */
public class WorkflowTaskServiceImpl implements WorkflowTaskService{
	
	private WorkflowTaskDao workflowTaskDao;
	private MainDataDao mainDataDao;
	private MainDataTypeDao mainDataTypeDAO;
	
	public MainDataTypeDao getMainDataTypeDAO() {
		return mainDataTypeDAO;
	}

	public void setMainDataTypeDAO(MainDataTypeDao mainDataTypeDAO) {
		this.mainDataTypeDAO = mainDataTypeDAO;
	}

	public MainDataDao getMainDataDao() {
		return mainDataDao;
	}

	public void setMainDataDao(MainDataDao mainDataDao) {
		this.mainDataDao = mainDataDao;
	}

	public WorkflowTaskDao getWorkflowTaskDao() {
		return workflowTaskDao;
	}

	public void setWorkflowTaskDao(WorkflowTaskDao workflowTaskDao) {
		this.workflowTaskDao = workflowTaskDao;
	}
	
	public List<MainData> selectMainData(MainData mainData){
		return mainDataDao.selectMainData(mainData);
	}

	@Override
	public List<Map<String, Object>> getWorkFlowTaskResultList(Map<String, Object> paramMap) {
		return workflowTaskDao.getWorkFlowTaskResultList(paramMap);
	} 
	
	@Override
	public List<Map<String, Object>> getWorkFlowTaskResultCount(Map<String, Object> paramMap) {
		return workflowTaskDao.getWorkFlowTaskResultCount(paramMap);
	} 
	
	public int updateWorkFlowTaskResult(Map<String,Object> paramMap){
		return workflowTaskDao.updateWorkFlowTaskResult(paramMap);
	}
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeDAO.selectMainDataType(mainDataType) ;
	}

}
