package com.ibatis.sqlmap.engine.execution;

import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.common.util.CommonUtil;
import com.ailk.eaap.op2.conf.util.ActInterceptor;
import com.alibaba.druid.util.JdbcUtils;
import org.apache.commons.lang.StringUtils;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;

/**
 * @ClassName: SqlLogUtil
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-20 下午4:11:37
 *
 */
public class SqlLogUtil {
	

	private static String DB_TYPE = SqlParase.MYSQL;
	private static boolean SQL_LOG_ISINTERCEPTOR = false;
	
	static{
		String sys_dbType = WebPropertyUtil.getPropertyValue(SqlParase.DB_TYPE_PRO_NAME);
    	if(SqlParase.MYSQL.equals(sys_dbType)){
    		DB_TYPE = JdbcUtils.MYSQL;
		}else if(SqlParase.ORACLE.equals(sys_dbType)){
			DB_TYPE = JdbcUtils.ORACLE;
		}
    	String sqlLogIsInterceptor = WebPropertyUtil.getPropertyValue(ActInterceptor.SQLLOG_ISINTERCEPTOR); 
    	if(!StringUtils.isEmpty(sqlLogIsInterceptor)){
    		SQL_LOG_ISINTERCEPTOR = Boolean.valueOf(sqlLogIsInterceptor);
    	}
	}
	
	public static String getDbType(){
		return DB_TYPE;
	}
	
	public static boolean getSqlLogIsInterceptor(){
		return SQL_LOG_ISINTERCEPTOR;
	}

}
