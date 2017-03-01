package com.ailk.eaap.op2.conf.task.service;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.task.dao.ITaskDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
public class TaskServiceImpl implements ITaskService{

	private ITaskDao taskDao;
	private MainDataDao mainDataSqlDAO;
	private MainDataTypeDao mainDataTypeSqlDAO;
	
	public MainDataDao getMainDataSqlDAO() {
		return mainDataSqlDAO;
	}

	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}

	public MainDataTypeDao getMainDataTypeSqlDAO() {
		return mainDataTypeSqlDAO;
	}

	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}

	public List<Map> getTaskList(Map param) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getTaskListNum(Map param) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<List<Integer>> start(List<TaskContentBean> taskContentList) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<List<Integer>> stop(List<TaskContentBean> taskContentList) {
		// TODO Auto-generated method stub
		return null;
	}

	public int updateTaskContentBean(TaskContentBean taskContentBean) {
		// TODO Auto-generated method stub
		return 0;
	}

	public ITaskDao getTaskDao() {
		return taskDao;
	}

	public void setTaskDao(ITaskDao taskDao) {
		this.taskDao = taskDao;
	}

	public List<Map<String, Object>> getCycleList(Map map) {
		// TODO Auto-generated method stub
		return taskDao.getCycleList(map);
	}
	
	public List<Map<String, Object>> getTaskStyleList(Map map) {
		// TODO Auto-generated method stub
		return taskDao.getTaskStyleList(map);
	}

	public Integer addTaskManager(TaskContentBean taskContentBean) {
		// TODO Auto-generated method stub
		return taskDao.addTaskManager(taskContentBean);
	}

	@Override
	public List<Map<String, Object>> getAttrSpecValueList(Map map) {
		// TODO Auto-generated method stub
		return taskDao.getAttrSpecValueList(map);
	}

	@Override
	public List<Map<String, Object>> getObjNameAndUrlByTaskTypeId(Map param) {
		// TODO Auto-generated method stub
		return taskDao.getObjNameAndUrlByTaskTypeId(param);
	}

	@Override
	public List<Map<String, Object>> getObjNameByObjId(Map param) {
		// TODO Auto-generated method stub
		return taskDao.getObjNameByObjId(param);
	}
	
	public int updateServiceStatus(Map param){
		return taskDao.updateServiceStatus(param);
	}
	
	public String getServiceStatus(Map param){ 
		return taskDao.getServiceStatus(param);
	}
	
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData);
	}
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType);
	}
	
	
}
