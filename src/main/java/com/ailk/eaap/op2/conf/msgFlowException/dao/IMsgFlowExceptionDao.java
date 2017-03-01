package com.ailk.eaap.op2.conf.msgFlowException.dao;

import java.util.Map;
import java.util.List;

public interface IMsgFlowExceptionDao {

	public List<Map> getExceptionDealInfoList(Map map); 
	public void tryStatusUpdate(Map map);

}
