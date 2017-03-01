package com.ailk.eaap.op2.conf.task.service;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;

public interface ITaskService {

	/**
	 * 任务列表
	 * 入参：传入任务对象。
     * 出参：输出任务总数。
	 */
	@SuppressWarnings("unchecked")
	public int getTaskListNum(Map param);
	
	/**
	 * 任务列表
	 * 入参：传入任务对象。
     * 出参：输出任务集合。
	 */
	@SuppressWarnings("unchecked")
	public List<Map> getTaskList(Map param);
	
	/**
	 * 启动任务列表
	 * 入参：传入任务对象。
     * 出参：输出成功启动的任务。
	 */
	public List<List<Integer>> start(List<TaskContentBean> taskContentList);
	
	/**
	 * 停止任务列表
	 * 入参：传入任务对象。
     * 出参：输出停止启动的任务。
	 */
	public List<List<Integer>> stop(List<TaskContentBean> taskContentList);
	
	/**
	 * 修改任务列表
	 * 入参：传入任务对象。
     * 出参：输出修改对象状态。
	 */
	public int updateTaskContentBean(TaskContentBean taskContentBean);

	/**
	 * 展现周期内容
	 * @return
	 */
	public List<Map<String, Object>>  getCycleList (Map map);
	
	/**
	 *获取任务风格
	 * @return
	 */
	public List<Map<String, Object>>  getTaskStyleList (Map map);
	
	/**
	 * 添加任务
	 * @param TaskManager
	 * @return Integer
	 */
	public Integer addTaskManager(TaskContentBean taskContentBean);	
	/**
	 * 展现属性值
	 * @return
	 */
	public List<Map<String, Object>>  getAttrSpecValueList (Map map);
	/**
	 * 通过taskTypeId获取Obj名称和Url
	 * @return
	 */
	public List<Map<String, Object>>  getObjNameAndUrlByTaskTypeId (Map param);
	/**
	 * 获取对象名称
	 * @return
	 */
	public List<Map<String, Object>>  getObjNameByObjId (Map param);
	
	public int updateServiceStatus(Map param);
	
	public String getServiceStatus(Map param);
	
	public List<MainData> selectMainData(MainData mainData);
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType);
}
