package com.ibatis.sqlmap.engine.execution;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: SqlQueryDao
 * @Description:
 * @author zhengpeng
 * @date 2015-3-10 上午10:08:11
 * 
 */
public interface SqlQueryDao {

	public List<Map<String, Object>> queryTableValue(String querySql,Object[] parameters);
	
	public List<String> queryTableInfo(String tableName);

}
