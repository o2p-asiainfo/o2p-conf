package com.ailk.eaap.op2.conf.adapter.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.linkage.rainbow.dao.SqlMapDAO;

public class NewAdapterDaoImpl implements INewAdapterDao {

	private SqlMapDAO sqlMapDao;
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getCountContractListByMap(Map map) {
		String array = String.valueOf(map.get("tcpCtrFId"));
		if(null != map.get("tcpCtrFId") && !"".equals(array)){
			array = array.replace("'", "");
			String[] inArray = array.split(",");
			map.put("inArray", inArray);
		}
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getCountContractListByMap", map);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Map> getContractListByMap(Map map) {
		String array = String.valueOf(map.get("tcpCtrFId"));
		if(null != map.get("tcpCtrFId") && !"".equals(array)){
			array = array.replace("'", "");
			String[] inArray = array.split(",");
			map.put("inArray", inArray);
		}
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getContractListByMap", map);
	}
	
	@Override
	public String getConAdaEndId() {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getConAdaEndId", null);
	}

	@Override
	public void addConAdaEnd(Map contractEndpoint) {
		sqlMapDao.insert("eaap-op2-conf-adapter-new.addConAdaEnd", contractEndpoint);
	}
	@Override
	public void updateContractRecords(Map<String, String> param) {
		sqlMapDao.update("eaap-op2-conf-adapter-new.updateContractRecords", param);
	}
	@Override
	public void delConAdaEndByMap(Map<String, String> param) {
		sqlMapDao.delete("eaap-op2-conf-adapter-new.delConAdaEndByMap", param);
	}
	@Override
	public String querySrcById(Map<String, String> param) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.querySrcById", param);
	}
	@Override
	public int queryActionById(Map<String, String> param) {
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.queryActionById", param);
	}
	@Override
	public boolean isExitOper(Map<String, String> param) {
		int num = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.isExitOper", param);
		if(num > 0){
			return true;
		}
		return false;
	}
	@Override
	public List<Map> getEndPointSrcList(Map<String, String> param) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getEndPointSrcList", param);
	}
	@Override
	public String getFormatId(Map<String, String> param) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getFormatId", param);
	}
	@Override
	public List<Map> getNodeMapper(String contractAdapterId,
			String tarNodeDescId) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("contractAdapterId", contractAdapterId);
		map.put("tarNodeDescId", tarNodeDescId);
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getNodeMapper", map);
	}
	@Override
	public boolean isExitSrcTcpCtrFId(Map<String, String> param) {
		Integer num = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.isExitSrcTcpCtrFId", param);
		if(num > 0){
			return true;
		}
		return false;
	}
	@Override
	public void updateContractAdapter(Map<String, String> param) {
		sqlMapDao.update("eaap-op2-conf-adapter-new.updateContractAdapter", param);
	}
	@Override
	public void updateConAdaEndpoint(Map<String, String> param) {
		sqlMapDao.update("eaap-op2-conf-adapter-new.updateConAdaEndpoint", param);
	}
	@Override
	public boolean isExitInAdapter(Map<String, String> param) {
		String value = (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.isExitInAdapter", param);
		if(null != value && !"".equals(value) && !"0".equals(value)){
			return true;
		}
		return false;
	}
	@Override
	public List<Map> getNodeValAdaReq(Map<String, String> param) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getNodeValAdaReq", param);
	}
	@Override
	public boolean isExitNodeValReq(Map<String, String> param) {
		Integer num = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.isExitNodeValReq", param);
		if(num > 0){
			return true;
		}
		return false;
	}
	@Override
	public int getCountValableMapByMap(Map map) {
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getCountValableMapByMap", map);
	}
	@Override
	public List<Map> getValableMapByMap(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getValableMapByMap", map);
	}
	@Override
	public String getVarMapTypeName(Map<String, String> param) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getVarMapTypeName", param);
	}
	@Override
	public void delAdapterEndpoint(Map<String, String> param) {
		sqlMapDao.delete("eaap-op2-conf-adapter-new.delAdapterEndpoint", param);
	}
	@Override
	public Map getContractAdapterById(Map<String, String> param) {
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getContractAdapterById", param);
	}
	@Override
	public List<Map> getConAdaEndListById(Map<String, String> param) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getConAdaEndListById", param);
	}
	@Override
	public String getContractNameById(Map param) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getContractNameById", param);
	}
	@Override
	public List<Map> getNodeMapperListById(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getNodeMapperListById", map);
	}
	@Override
	public List<Map> getContractFormat(Map<String, String> param) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getContractFormat", param);
	}
	@Override
	public void updateResult(Map<String, String> param) {
		sqlMapDao.update("eaap-op2-conf-adapter-new.updateResult", param);
	}
	@Override
	public String getActionValue(Map<String, String> param) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.getActionValue", param);
	}
	@Override
	public int countVarMapType(Map map) {
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-adapter-new.countVarMapType", map);
	}
	@Override
	public List<Map> queryVarMapType(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.queryVarMapType", map);
	}
	@Override
	public void deleteVarMapType(Map<String, String> param) {
		sqlMapDao.delete("eaap-op2-conf-adapter-new.deleteVarMapType", param);
	}
	
	@Override
	public List<Map> getRToCLinesDataById(Map<String, String> param){
		System.out.println(param);
		return sqlMapDao.queryForList("eaap-op2-conf-adapter-new.getRToCLinesDataById", param);
	}

}
