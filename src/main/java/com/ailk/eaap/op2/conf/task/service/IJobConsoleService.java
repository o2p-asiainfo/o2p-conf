package com.ailk.eaap.op2.conf.task.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.o2p.fileExchange.model.TaskJobLogBean;
import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.bo.GatherCycle;

public interface IJobConsoleService {
	
	/**
	 * 添加任务
	 * @param param
	 */
	public int addTask(Map<String, Object> param);
	/**
	 * 启动任务
	 * @param taskContentList
	 * @return
	 */
	public List<String> start(List<TaskContentBean> taskContentList);
	
	/**
	 * 运行所有任务
	 */
	public List<String> runAll(String tenantId);
	
	/**
	 * 启动所有任务
	 */
	public List<String> startAll(String tenantId);
	
	/**
	 * 停止所有任务
	 */
	public List<String> stopAll(String tenantId);
	
	/**
	 * 运行任务
	 * @param taskContentList
	 */
	public List<String> run(List<TaskContentBean> taskContentList);
	
	/**
	 * 关闭任务
	 * @param taskContentList
	 */
	public List<String> stop(List<TaskContentBean> taskContentList);
	
	
	/**
	 * 获取任务列表的总数
	 * @param param
	 * @return
	 */
	public int getTaskListNum(Map<String, Object> param);

	/**
	 * 获取任务列表
	 * @param param
	 * @return
	 */
	public List<TaskContentBean> getTaskList(Map<String, Object> param);
	
	/**
	 * 获取任务日志的总数
	 * @param param
	 * @return
	 */
	public int getTaskLogListNum(Map<String, Object> param);
	
	/**
	 * 获取任务日志列表
	 * @param param
	 * @return
	 */
	public List<TaskJobLogBean> getTaskLogList(Map<String, Object> param);

	
	/**
	 * 查看任务
	 * @param taskId
	 * @return
	 */
	public TaskContentBean getTaskContentBean(Map<String, Object> param);

	/**
	 * 修改任务
	 * @param taskId
	 * @return
	 */
	public int updateTaskContentBean(TaskContentBean taskContentBean);
	
	
	/**
	 * 获取周期列表
	 * @return
	 */
	public List<TaskContentBean>  getTaskCycleList();
	
	/**
	 * 获取周期列表
	 * @param param
	 * @return
	 */
	public List<GatherCycle> getTaskCycleList(Map<String, Object> param);
	
	/**
	 * 获取周期数目
	 * @param param
	 * @return
	 */
	public int getTaskCycleNum(Map<String, Object> param);

	
	/**
	 * 修改周期
	 * @param gc
	 */
	public void updateCycle(GatherCycle gc);
	
	/**
	 * 删除周期
	 * @param gc
	 */
	public int deleteCycle(GatherCycle gc);
	
	
	/**
	 * 新增周期
	 * @param gc
	 * @return
	 */
	public int addCycle(GatherCycle gc);
	
	/**
	 * 根据id查询周期
	 * @param gcCd
	 * @return
	 */
	public GatherCycle getGatherCycleBean(int gcCd);

	/**
	 * 用户操作日志
	 * @param map
	 */
	public void operatorLog(Map<String, Object> map);
	
	public void shutDown(String tenantId);
	
	/**
	 * 日志详细信息
	 * @param taskLogId
	 * @return
	 */
	public TaskJobLogBean getTaskJobLogById(int taskLogId);
	

	/**
	 * 获取任务类型列表
	 * @param param
	 * @return
	 */
	public List<TaskContentBean> getTaskTypeList(Map<String, Object> param);
	
	/**
	 * 删除任务
	 * @param ids
	 */
	public List<String> deleteTask(List<String> taskIds);
	
	/**
	 * 
	 * startFlag:是否启动定时任务生产者标示 <br/> 
	 * @author mf 
	 * @return 
	 * @since JDK 1.6
	 */
	public boolean startFlag(String tenantId);
}
