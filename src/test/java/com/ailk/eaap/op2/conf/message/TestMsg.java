package com.ailk.eaap.op2.conf.message;


import java.math.BigDecimal;
import java.util.Map;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.message.MessageRecipientRel;
import com.ailk.eaap.op2.conf.message.service.MessageServ;

public class TestMsg {

	private ApplicationContext ctx ;
	private MessageServ messageServ;
	@Before
	public void testUp(){
		String[] configLocations = new String[]{"classpath*:spring/eaap-op2-common-spring.xml",
				"classpath*:spring/o2p-baseDao-spring.xml",
				"classpath:o2p-security-service-spring-all.xml",
				"classpath*:spring/**/*conf*spring.xml",
				"classpath*:*conf*spring.xml"};
		ctx = new ClassPathXmlApplicationContext(configLocations );
		messageServ = (MessageServ)ctx.getBean("eaap-op2-conf-message-messageServ");
	}
	@Test
	public void cntMsg(){
		Message msg = new Message();
		msg.setStatusCd("1500");
		Integer cnt = messageServ.counMsgList(msg);
		System.out.println(cnt);
		Assert.assertNotNull(cnt);
	}
	@Test
	public void addMsg(){
		Message msg = new Message();
		MessageRecipientRel msgRecRel = new MessageRecipientRel();
		
		msg.setMsgTitle("sssssssssssbbbbbbbb");
		msg.setMsgType(1);
		msg.setMsgRecType(2);
		msgRecRel.setMsgRecType(2);
		msgRecRel.setRecId("11111");
		messageServ.addMessage(msg, msgRecRel);
	}
	
	@Test
	public void lookMsgById(){
		Message msg = new Message();
		msg.setMsgId(new BigDecimal("94"));
		Map<String, Object> obs = messageServ.getMsgById(msg);
		String recName = (String) obs.get("recName");
		System.out.println(recName);
	}
}
