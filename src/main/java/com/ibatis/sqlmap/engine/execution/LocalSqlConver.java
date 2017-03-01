package com.ibatis.sqlmap.engine.execution;

import com.ailk.eaap.o2p.common.util.date.UTCTimeUtil;

/**
 * @ClassName: LocalSqlConver
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-16 上午9:29:21
 *
 */
public class LocalSqlConver {
	
    public static final String MYSQL_UTCDATE = "utc_timestamp";
    public static final String ORACLE_UTCDATE = "SYS_EXTRACT_UTC(current_timestamp)";
    private static final String[] FULL_PATERNS = {"yyyy-MM-dd HH:mm:ss"};
    
    public static String localSqlConver(String valueSql,String sqlType){
    	String value = "";
    	if(sqlType.equals(SqlParase.MYSQL)){
	    	if(valueSql.toUpperCase().indexOf(MYSQL_UTCDATE.toUpperCase()) > -1){
	    		value = UTCTimeUtil.getUTCDateStrByFormat(FULL_PATERNS);
	    	}else{
	    		value = valueSql;
	    	}
    	}else if(sqlType.equals(SqlParase.ORACLE)){
    		if(valueSql.toUpperCase().indexOf(ORACLE_UTCDATE.toUpperCase()) > -1){
	    		value = UTCTimeUtil.getUTCDateStrByFormat(FULL_PATERNS);
	    	}else{
	    		value = valueSql;
	    	}
    	}
    	return value;
    }
    
}
