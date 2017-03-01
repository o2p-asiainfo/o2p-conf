package com.ailk.eaap.o2p.conf.activemq.service;

import org.apache.activemq.command.ActiveMQQueue;
import org.springframework.jms.core.JmsTemplate;

import com.ailk.eaap.o2p.sqllog.model.OperateLog;

/**
 * @ClassName: SqlLogMessageProducer
 * @Description: 
 * @author zhengpeng
 * @date 2015-3-18 下午2:24:38
 *
 */
public class SqlLogMessageProducer {
	
	private ActiveMQQueue destination;
	private JmsTemplate jmsTemplate;
	
	public void sendMessage(OperateLog operateLog){
		SqlLogThreadPoolUtil.addPoolThread(jmsTemplate, destination, operateLog);
	}

	public ActiveMQQueue getDestination() {
		return destination;
	}
	public void setDestination(ActiveMQQueue destination) {
		this.destination = destination;
	}
	public JmsTemplate getJmsTemplate() {
		return jmsTemplate;
	}
	public void setJmsTemplate(JmsTemplate jmsTemplate) {
		this.jmsTemplate = jmsTemplate;
	}
	
}
