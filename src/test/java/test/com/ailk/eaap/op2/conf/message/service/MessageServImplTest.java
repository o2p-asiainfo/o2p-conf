package test.com.ailk.eaap.op2.conf.message.service;

import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ailk.eaap.op2.bo.message.Message;
import com.ailk.eaap.op2.bo.message.MessageRecipientRel;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.message.service.MessageServ;

/**
 * @ClassName: MessageServImplTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-29 上午11:26:47
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:eaap-op2-conf-spring.xml"})
public class MessageServImplTest extends AbstractJUnit4SpringContextTests{
	
	@Autowired
	private MessageServ messageServ;

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#getMainInfo(java.lang.String)}.
	 */
	@Test
	public void testGetMainInfo() {
		Map<String,String> result = messageServ.getMainInfo(EAAPConstants.MESSAGE_MSG_REC_TYPE);
		assertNotNull(result); 
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#showSelectList(java.util.List, java.lang.String)}.
	 */
	@Test
	public void testShowSelectList() {
		List<Map<String,String>> msgRecTypelist = new ArrayList<Map<String,String>>();
		List<Map<String,String>> list = messageServ.showSelectList(msgRecTypelist, EAAPConstants.MESSAGE_MSG_REC_TYPE);
		assertNotNull(list); 
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#queryMsgList(com.ailk.eaap.op2.bo.message.Message)}.
	 */
	@Test
	public void testQueryMsgList() {
		Message msg = new Message();
		List<Message> list = messageServ.queryMsgList(msg);
		assertNotNull(list); 
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#counMsgList(com.ailk.eaap.op2.bo.message.Message)}.
	 */
	@Test
	public void testCounMsgList() {
		Message msg = new Message();
		Integer result = messageServ.counMsgList(msg);
		assertNotNull(result);  
	}


	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#queryMsgRecRla(com.ailk.eaap.op2.bo.message.MessageRecipientRel)}.
	 */
	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#queryMsgRecRla(com.ailk.eaap.op2.bo.message.MessageRecipientRel)}.
	 */
	@Test
	public void testQueryMsgRecRla() {
		MessageRecipientRel msgRecRel = new MessageRecipientRel();
		List<MessageRecipientRel> list = messageServ.queryMsgRecRla(msgRecRel);
		assertNotNull(list);  
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#countMsgRecRla(com.ailk.eaap.op2.bo.message.MessageRecipientRel)}.
	 */
	@Test
	public void testCountMsgRecRla() {
		
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#getRoleList()}.
	 */
	@Test
	public void testGetRoleList() {
		List<Map<String,String>> list = messageServ.getRoleList();
		assertNotNull(list);  
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#getOrgList(java.util.Map)}.
	 */
	@Test
	public void testGetOrgList() {
		
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#selectOrgName(java.util.Map)}.
	 */
	@Test
	public void testSelectOrgName() {
		Map paramMap = new HashMap(); 
		String reuslt = messageServ.selectOrgName(paramMap); 
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#selectMessageByData(java.util.Map)}.
	 */
	@Test
	public void testSelectMessageByData() {
		
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.message.service.MessageServImpl#countMessageByData(java.util.Map)}.
	 */
	@Test
	public void testCountMessageByData() {
		
	}

}
