package com.ailk.eaap.op2.conf.workFlowManager.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;

public interface IWorkFlowSer {
	   public List<BizFunction> queryWorkFlow(Map hashMap);//查询业务流程表
	   public void insertWorkFlow(BizFunction bizFunction);      //增加业务流程
	   public void updateWorkFlow(BizFunction bizFunction);      //更新业务流程
	   public List<BizFunction>  selectBizFunctionByFaBizFunctionAndType(BizFunction bizFunction) ; //通过父目录ID查找所有子业务流程
       public void deleWorkFlowNode(String nodeId);//删除业务流程节点
       public BizFunction getWorkFlowNodeById(BizFunction bizFunction);//根据id查询工作流
       public int isExistWorkFlowName(Map map);
       public int isExistBizFunctionCodeWhenEdit(Map map);
}
