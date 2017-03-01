package com.ailk.eaap.o2p.conf.activemq.service;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.jms.core.JmsTemplate;

import com.ailk.eaap.o2p.sqllog.model.OperateLog;

/**
 * @ClassName: SqlLogThreadPool
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-25 下午4:02:41
 *
 */
public class SqlLogThreadPoolUtil {
	
	public static final String SQL_LOG_POOL_SIZE = "sqlLog.pool.size";
	private static ExecutorService pool = null;
	
	static{
		pool = Executors.newCachedThreadPool();
	}
	
	public static void addPoolThread(JmsTemplate jmsTemplate,ActiveMQQueue destination,OperateLog operateLog){
		SqlLogRunnable sqlLogRunnable = new SqlLogRunnable(jmsTemplate,destination,operateLog);
		pool.execute(sqlLogRunnable);  
	}

}
