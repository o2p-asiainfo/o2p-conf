package com.ailk.eaap.op2.conf.workFlowManager.dao;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.BizFunction;



public interface IWorkFlowDao {
	   public List<BizFunction> queryWorkFlow(Map hashMap);//查询业务流程表
	   public void insertWorkFlow(BizFunction bizFunction);      //增加业务流程
	   public void updateWorkFlow(BizFunction bizFunction);
	   public List<BizFunction>  selectBizFunctionByFaBizFunctionAndType(BizFunction bizFunction) ; //通过父目录ID查找所有子业务流程
	   public void deleWorkFlowNode(Map map);//删除业务流程节点
	   public BizFunction getWorkFlowNodeById(BizFunction bizFunction);
	   public int isExistWorkFlowName(Map map);
	   public int isExistBizFunctionCodeWhenEdit(Map map);
}
