package com.ailk.eaap.op2.conf.remoteCallInfo.service;

import java.util.Map;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.RemoteCallInfo;
import com.ailk.eaap.op2.conf.remoteCallInfo.dao.RemoteCallInfoDao;

public class RemoteCallInfoService implements IRemoteCallInfoService { 
	private RemoteCallInfoDao remoteCallInfoDao ;
	public RemoteCallInfoDao getRemoteCallInfoDao() {
		return remoteCallInfoDao;
	}
	public void setRemoteCallInfoDao(RemoteCallInfoDao remoteCallInfoDao) {
		this.remoteCallInfoDao = remoteCallInfoDao;
	}
	

	public List<Map> getRemoteCallInfoList(Map map){
		 return remoteCallInfoDao.getRemoteCallInfoList(map);
	}
	
	public RemoteCallInfo getRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		return remoteCallInfoDao.getRemoteCallInfo(remoteCallInfo); 
	}
	
	public void insertRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		remoteCallInfoDao.insertRemoteCallInfo(remoteCallInfo); 
	}
	public void updateRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		remoteCallInfoDao.updateRemoteCallInfo(remoteCallInfo); 
	}
	public void deleteRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		remoteCallInfoDao.deleteRemoteCallInfo(remoteCallInfo); 
	}
	
	
	
	
}
