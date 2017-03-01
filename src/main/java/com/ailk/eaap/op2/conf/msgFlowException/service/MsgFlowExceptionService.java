package com.ailk.eaap.op2.conf.msgFlowException.service;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.conf.msgFlowException.dao.IMsgFlowExceptionDao;

public class MsgFlowExceptionService implements IMsgFlowExceptionService {
	private IMsgFlowExceptionDao msgFlowExceptionDao;
	
	public List<Map> getExceptionDealInfoList(Map map){
    	return msgFlowExceptionDao.getExceptionDealInfoList(map);
	}

	public void tryStatusUpdate(Map map){
		msgFlowExceptionDao.tryStatusUpdate(map);
	}

	
	
	
	public IMsgFlowExceptionDao getMsgFlowExceptionDao() {
		return msgFlowExceptionDao;
	}
	public void setMsgFlowExceptionDao(IMsgFlowExceptionDao msgFlowExceptionDao) {
		this.msgFlowExceptionDao = msgFlowExceptionDao;
	}

	
}
