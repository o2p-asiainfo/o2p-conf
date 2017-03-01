package com.ailk.eaap.op2.conf.msgFlowException.dao;

import java.util.Map;
import java.util.List;
import com.linkage.rainbow.dao.SqlMapDAO;

public class MsgFlowExceptionDao implements IMsgFlowExceptionDao {
	private SqlMapDAO sqlMapDaoDep; 
	
	public List<Map> getExceptionDealInfoList(Map map) {
		String tryStatus = String.valueOf(map.get("tryStatus"));
		if(null != map.get("tryStatus") && !"".equals(tryStatus)){
			String[] status = tryStatus.split(",");
			map.put("arrayTryStatus", status);
		}
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDaoDep.queryForList("eaap-op2-conf-msgFlowException.getExceptionDealInfoListCount", map);
		}else{
			return (List<Map>)sqlMapDaoDep.queryForList("eaap-op2-conf-msgFlowException.getExceptionDealInfoList", map);
		}
    }
	
	public void tryStatusUpdate(Map map){
		String exceptionIds = String.valueOf(map.get("exceptionIds"));
		if(null != map.get("exceptionIds") && !"".equals(exceptionIds)){
			String[] arrIds = exceptionIds.split(",");
			map.put("arrayExceptionId", arrIds);
		}
		sqlMapDaoDep.update("eaap-op2-conf-msgFlowException.tryStatusUpdate", map);

		String tryStatus = String.valueOf(map.get("tryStatus"));
		if("X".equals(tryStatus)){
			sqlMapDaoDep.insert("eaap-op2-conf-msgFlowException.exceptionToHis", map);
			sqlMapDaoDep.delete("eaap-op2-conf-msgFlowException.exceptionDel", map);
		}
	}

	public SqlMapDAO getSqlMapDaoDep() {
		return sqlMapDaoDep;
	}

	public void setSqlMapDaoDep(SqlMapDAO sqlMapDaoDep) {
		this.sqlMapDaoDep = sqlMapDaoDep;
	}


}
