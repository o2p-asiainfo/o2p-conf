package test.com.ailk.eaap.op2.conf.crmorder.dao;

import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ailk.eaap.op2.conf.crmorder.dao.ICrmOrderDao;

/**
 * @ClassName: CrmOrderDaoTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-28 下午9:14:36
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:eaap-op2-conf-spring.xml"})
public class CrmOrderDaoTest extends AbstractJUnit4SpringContextTests{

	@Autowired
	private ICrmOrderDao crmOrderDao;

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryAttrSpec()}.
	 */
	@Test
	public void testQueryAttrSpec() {
		Map paramMap = new HashMap(); 
		List<Map> list = crmOrderDao.queryAttrSpec(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryCrmUserAddressById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmUserAddressById() {
		Map paramMap = new HashMap(); 
		paramMap.put("uIds", "1");
		List<Map> list = crmOrderDao.queryCrmUserAddressById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryCrmOrderProductById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderProductById() {
		Map paramMap = new HashMap(); 
		paramMap.put("orderId", "1");
		List<Map> list = crmOrderDao.queryCrmOrderProductById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryCrmOrderCustomerById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderCustomerById() {
		Map paramMap = new HashMap(); 
		paramMap.put("orderId", "1");
		List<Map> list = crmOrderDao.queryCrmOrderCustomerById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryCrmOrderUserById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderUserById() {
		Map paramMap = new HashMap(); 
		paramMap.put("orderId", "1");
		List<Map> list =  crmOrderDao.queryCrmOrderUserById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryCrmOrderById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderById() {
		Map paramMap = new HashMap(); 
		paramMap.put("orderId", "1");
		List<Map> list =  crmOrderDao.queryCrmOrderById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao#queryOrderInfoList(java.util.Map)}.
	 */
	@Test
	public void testQueryOrderInfoList_1() {
		Map paramMap = new HashMap(); 
		paramMap.put("queryType", "ALLNUM"); 
		List<Map> list = crmOrderDao.queryOrderInfoList(paramMap);
		assertNotNull(list);
	}
	
	@Test
	public void testQueryOrderInfoList_2() {
		Map paramMap = new HashMap(); 
		paramMap.put("pro_mysql", 0);
		paramMap.put("page_record", 10);
		List<Map> list = crmOrderDao.queryOrderInfoList(paramMap);
		assertNotNull(list);
	}

}
