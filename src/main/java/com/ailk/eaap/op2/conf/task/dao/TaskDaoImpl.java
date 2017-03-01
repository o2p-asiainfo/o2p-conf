package com.ailk.eaap.op2.conf.task.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import com.ailk.eaap.o2p.task.model.TaskContentBean;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;

public class TaskDaoImpl implements ITaskDao{

	private SqlMapDAO sqlMapDao;
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
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

	public List<Map> getTaskList(Map param) {
		// TODO Auto-generated method stub

		Map map = new HashMap();
		map.put("taskName", "aaaaaaaaaaaa");
		map.put("serviceName", "bbbbbbbbbb");
		map.put("state", "A");
		Map map1 = new HashMap();
		map.put("taskName", "cccccccc");
		map.put("serviceName", "dddddddd");
		map.put("state", "A");
		Map map2 = new HashMap();
		map.put("taskName", "eeeeeee");
		map.put("serviceName", "fffffff");
		map.put("state", "A");
		List<Map> list = new ArrayList();
		list.add(map);
		list.add(map1);
		list.add(map2);
		return list;
	}

	public int getTaskListNum(Map param) {
		// TODO Auto-generated method stub
		return 0;
	}

	@SuppressWarnings("unchecked")
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "gather_cycle", columnNames = "NAME", idName = "GCCD", propertyNames = "NAME") 
		}
	)
	public List<Map<String, Object>> getCycleList(Map map) {
		// TODO Auto-generated method stub	
		return sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getCycleList",map);
	}

	public List<Map<String, Object>> getTaskStyleList(Map map) {
		// TODO Auto-generated method stub	
		return sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getTaskStyleList",map);
	}
	
	public Integer addTaskManager(TaskContentBean taskContentBean) {
		// TODO Auto-generated method stub
		return (Integer) sqlMapDao.insert("eaap-op2-conf-contract-prov.INSERT_TASK_MANAGE", taskContentBean);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getAttrSpecValueList(Map map) {
		// TODO Auto-generated method stub
		return sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getAttrSpecValueList",map);
	}

	@Override
	public List<Map<String, Object>> getObjNameAndUrlByTaskTypeId(Map param) {
		// TODO Auto-generated method stub
		return sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getObjNameAndUrlByTaskTypeId",param);
	}

	@Override
	public List<Map<String, Object>> getObjNameByObjId(Map param) {
			return sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getObjNameByObjId", param);
	}
	
	public int updateServiceStatus(Map param){
		return sqlMapDao.update("eaap-op2-conf-serviceManager.updateServiceStatus", param);
	}
	
	public String getServiceStatus(Map param){
		return (String) sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.getServiceStatus", param);
	}
}
