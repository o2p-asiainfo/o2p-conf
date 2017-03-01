package com.ailk.eaap.op2.conf.workFlowManager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.conf.workFlowManager.dao.IWorkFlowDao;


public class WorkFlowSer implements IWorkFlowSer{
   private IWorkFlowDao workFlowManagerDao;
   
   

	public IWorkFlowDao getWorkFlowManagerDao() {
	return workFlowManagerDao;
}

public void setWorkFlowManagerDao(IWorkFlowDao workFlowManagerDao) {
	this.workFlowManagerDao = workFlowManagerDao;
}

	public void insertWorkFlow(BizFunction bizFunction) {
		workFlowManagerDao.insertWorkFlow(bizFunction);
	}

	public void updateWorkFlow(BizFunction bizFunction){
		workFlowManagerDao.updateWorkFlow(bizFunction);
	}
	
	public List<BizFunction> queryWorkFlow(Map hashMap) {
		return null;
	}

	public List<BizFunction> selectBizFunctionByFaBizFunctionAndType(
			BizFunction bizFunction) {
		return workFlowManagerDao.selectBizFunctionByFaBizFunctionAndType(bizFunction);
	}

	public void deleWorkFlowNode(String nodeId) {
		Map map =  new HashMap();
		map.put("nodeId", nodeId);
		workFlowManagerDao.deleWorkFlowNode(map);
		
	}
	
	public BizFunction getWorkFlowNodeById(BizFunction bizFunction){
		return workFlowManagerDao.getWorkFlowNodeById(bizFunction);
	}
	
	 public int isExistWorkFlowName(Map map){
		 return workFlowManagerDao.isExistWorkFlowName(map);
	 }
	 
	 public int isExistBizFunctionCodeWhenEdit(Map map){
		 return workFlowManagerDao.isExistBizFunctionCodeWhenEdit(map);
	 }
}
