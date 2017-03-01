package test.com.ailk.eaap.op2.conf.doc.service;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ailk.eaap.op2.conf.doc.service.IContractDocSer;

/**
 * @ClassName: ContractDocSerTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-29 上午10:39:55
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:eaap-op2-conf-spring.xml"})
public class ContractDocSerTest extends AbstractJUnit4SpringContextTests{
	
	@Autowired
	private IContractDocSer contractDocSer;

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.service.ContractDocSer#showContractDocs(java.util.Map)}.
	 */
	@Test
	public void testShowContractDocs() {
		Map paramMap = new HashMap(); 
		List<Map<String, String>> list = contractDocSer.showContractDocs(paramMap);
		assertNotNull(list);
	}
	

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.service.ContractDocSer#countDocSum(java.util.Map)}.
	 */
	@Test
	public void testCountDocSum() {
		Map paramMap = new HashMap(); 
		int result = contractDocSer.countDocSum(paramMap);
	}


	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.service.ContractDocSer#isExitDocName(java.lang.String)}.
	 */
	@Test
	public void testIsExitDocName() {
		String name = "test";
		//int result = contractDocSer.isExitDocName(name);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.service.ContractDocSer#isResAlissExit(java.lang.String)}.
	 */
	@Test
	public void testIsResAlissExit() {
		String name = "test";
		//int result = contractDocSer.isResAlissExit(name);
	}

}
