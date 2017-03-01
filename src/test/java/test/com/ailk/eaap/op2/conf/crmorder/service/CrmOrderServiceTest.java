package test.com.ailk.eaap.op2.conf.crmorder.service;

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

import test.com.ailk.eaap.op2.conf.util.TestUtil;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.crmorder.service.ICrmOrderService;

/**
 * @ClassName: CrmOrderServiceTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-26 上午11:06:04
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:eaap-op2-conf-spring.xml"})
public class CrmOrderServiceTest extends AbstractJUnit4SpringContextTests{

	@Autowired
	private ICrmOrderService crmOrderService;
	
	@Test
	public void testselectMainData() {
		MainDataType mainDataType = new MainDataType();
		mainDataType.setMdtSign("CRM_ORDER_TYPE") ;
		mainDataType = crmOrderService.selectMainDataType(mainDataType).get(0);
		
		MainData mainData = new MainData();
		mainData.setMdtCd(mainDataType.getMdtCd());
		List<MainData> mainDataList = crmOrderService.selectMainData(mainData);
		assertNotNull(mainDataList); 
	}
	
	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#selectMainDataType(com.ailk.eaap.op2.bo.MainDataType)}.
	 */
	@Test
	public void testSelectMainDataType() {
		MainDataType mainDataType = new MainDataType();
		mainDataType.setMdtName("CRM_ORDER_TYPE");
		List<MainDataType> typeList = crmOrderService.selectMainDataType(mainDataType);
		assertNotNull(typeList);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#queryOrderInfoList(java.util.Map)}.
	 */
	@Test
	public void testQueryOrderInfoList_1() {
		Map paramMap = new HashMap(); 
		paramMap.put("queryType", "ALLNUM"); 
		List<Map> list = crmOrderService.queryOrderInfoList(paramMap);
		assertNotNull(list);
	}
	
	@Test
	public void testQueryOrderInfoList_2() {
		Map paramMap = new HashMap(); 
		paramMap.put("pro_mysql", 0);
		paramMap.put("page_record", 10);
		List<Map> list = crmOrderService.queryOrderInfoList(paramMap);
		assertNotNull(list);
	}

	
	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#queryCrmOrderUserById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderUserById() {
		Map paramMap = new HashMap(); 
		List<Map> list = crmOrderService.queryCrmOrderUserById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#queryCrmOrderCustomerById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderCustomerById() {
		Map paramMap = new HashMap(); 
		List<Map> list = crmOrderService.queryCrmOrderCustomerById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#queryCrmOrderProductById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmOrderProductById() {
		Map paramMap = new HashMap(); 
		List<Map> list = crmOrderService.queryCrmOrderProductById(paramMap);
		assertNotNull(list);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#queryAttrSpec()}.
	 */
	@Test
	public void testQueryAttrSpec() {
		Map paramMap = new HashMap(); 
		List<Map> list = crmOrderService.queryAttrSpec(paramMap);
		assertNotNull(list);
		TestUtil.testPrintln(list); 
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService#queryCrmUserAddressById(java.util.Map)}.
	 */
	@Test
	public void testQueryCrmUserAddressById() {
		Map paramMap = new HashMap(); 
		List<Map> list = crmOrderService.queryCrmUserAddressById(paramMap);
		assertNotNull(list);
	}

}
