package com.ibatis.sqlmap.engine.execution;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;

/**
 * @ClassName: SqlQueryDao
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-10 上午10:05:02
 *
 */
public class SqlQueryDaoImpl implements SqlQueryDao{
	
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	} 
		
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> queryTableValue(String querySql,Object[] parameters){
		List<Map<String, Object>> resultList = this.jdbcTemplate.queryForList(querySql, parameters);
		return resultList;
	}
	
	public List<String> queryTableInfo(String tableName){
		String sql = "SELECT column_name FROM BAK_TABLE_INFO WHERE table_name = '"+tableName+"' AND column_key = 'Y'";
		final List<String> tableInfoList = new ArrayList<String>();
		this.jdbcTemplate.query(sql, new RowCallbackHandler(){
			public void processRow(ResultSet rs) throws SQLException{
				String columnName = rs.getString("column_name");
				tableInfoList.add(columnName);
			}
		});
		return tableInfoList;
	}
	
}
