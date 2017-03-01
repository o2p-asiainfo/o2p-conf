package com.ailk.eaap.op2.conf.remoteCallInfo.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.RemoteCallInfo;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class RemoteCallInfoDaoImpl   implements RemoteCallInfoDao { 
	private SqlMapDAO sqlMapDao;
	
	
	public List<Map> getRemoteCallInfoList(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-remoteCallInfo.getRemoteCallInfoListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-remoteCallInfo.getRemoteCallInfoList", map) ;
		}
	}

	public RemoteCallInfo getRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		return (RemoteCallInfo)sqlMapDao.queryForObject("eaap-op2-conf-remoteCallInfo.getRemoteCallInfo", remoteCallInfo);
	}
	
	public void insertRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		sqlMapDao.insert("eaap-op2-conf-remoteCallInfo.insertRemoteCallInfo", remoteCallInfo);
	}
	public void updateRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		sqlMapDao.update("eaap-op2-conf-remoteCallInfo.updateRemoteCallInfo", remoteCallInfo);
	}
	public void deleteRemoteCallInfo(RemoteCallInfo remoteCallInfo){
		sqlMapDao.delete("eaap-op2-conf-remoteCallInfo.deleteRemoteCallInfo", remoteCallInfo);
	}
	
	
	
	
	
	
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
}

