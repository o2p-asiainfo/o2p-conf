package com.ailk.eaap.op2.conf.remoteCallInfo.service;

import java.util.Map;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.RemoteCallInfo;

public interface IRemoteCallInfoService{

	public List<Map> getRemoteCallInfoList(Map map);
	public RemoteCallInfo getRemoteCallInfo(RemoteCallInfo remoteCallInfo);
	public void insertRemoteCallInfo(RemoteCallInfo remoteCallInfo);
	public void updateRemoteCallInfo(RemoteCallInfo remoteCallInfo);
	public void deleteRemoteCallInfo(RemoteCallInfo remoteCallInfo);
	
	
}
