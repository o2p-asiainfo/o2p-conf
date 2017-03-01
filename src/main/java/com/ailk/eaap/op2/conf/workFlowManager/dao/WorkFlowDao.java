package com.ailk.eaap.op2.conf.workFlowManager.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.BizFunction;
import com.linkage.rainbow.dao.SqlMapDAO;

public class WorkFlowDao implements IWorkFlowDao{
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
    
	public void insertWorkFlow(BizFunction bizFunction) {
		sqlMapDao.insert("eaap-op2-conf-workFlow.insertBizFunction", bizFunction);		
	}

	public void updateWorkFlow(BizFunction bizFunction){
		sqlMapDao.update("eaap-op2-conf-workFlow.updateBizFunction", bizFunction);
	}
	
	public List<BizFunction> queryWorkFlow(Map hashMap) {
		return null;
	}

	public BizFunction getWorkFlowNodeById(BizFunction bizFunction){
		return (BizFunction) sqlMapDao.queryForObject("eaap-op2-conf-workFlow.getWorkFlowNodeById", bizFunction);
	}
	
	public List<BizFunction> selectBizFunctionByFaBizFunctionAndType(
			BizFunction bizFunction) {
		return (List<BizFunction>)sqlMapDao.queryForList("eaap-op2-conf-workFlow.queryOrgInfoByBizFunctionId", bizFunction);
	}

	public void deleWorkFlowNode(Map map) {
		
		sqlMapDao.delete("eaap-op2-conf-workFlow.deleWorkFlowNode", map);
		
	}
	public int isExistWorkFlowName(Map map){
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-workFlow.isExistWorkFlowName", map);
	}
	public int isExistBizFunctionCodeWhenEdit(Map map){
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-workFlow.isExistBizFunctionCodeWhenEdit", map);
	}
}
