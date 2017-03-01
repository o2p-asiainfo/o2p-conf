package com.ailk.eaap.o2p.conf.activemq.service;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.jms.core.JmsTemplate;

import com.ailk.eaap.o2p.sqllog.model.OperateLog;

/**
 * @ClassName: SqlLogRunnable
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-25 下午4:14:08
 *
 */
public class SqlLogRunnable implements Runnable{
	
	private ActiveMQQueue destination;
	private OperateLog operateLog;
	private JmsTemplate jmsTemplate;
	
	public SqlLogRunnable(JmsTemplate jmsTemplate,ActiveMQQueue destination,OperateLog operateLog){
		this.destination = destination;
		this.operateLog = operateLog;
		this.jmsTemplate = jmsTemplate;
	}

	@Override
	public void run() {
		jmsTemplate.convertAndSend(destination,operateLog);
	}

}
