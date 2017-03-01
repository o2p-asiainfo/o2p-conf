package com.ailk.eaap.op2.conf.apiManager.dao;

import java.util.Map;
import java.util.List;
import com.linkage.rainbow.dao.SqlMapDAO;

public class ApiManagerDaoImpl implements IApiManagerDao{
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	public String queryGridCount(){ 
	  return (String)sqlMapDao.queryForObject("", "");
	};//查询所有的数目
	 public List<Map> queryApi(){
		 return (List<Map>)sqlMapDao.queryForList("", ""); 
	   };//查询所有的api的对象
	
}
