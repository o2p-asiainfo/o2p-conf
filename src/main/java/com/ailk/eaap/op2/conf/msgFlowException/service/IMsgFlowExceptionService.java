package com.ailk.eaap.op2.conf.msgFlowException.service;

import java.util.Map;
import java.util.List;


public interface IMsgFlowExceptionService {

	public List<Map> getExceptionDealInfoList(Map map); 
	public void tryStatusUpdate(Map map);

}
