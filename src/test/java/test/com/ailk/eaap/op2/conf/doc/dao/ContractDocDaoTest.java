package test.com.ailk.eaap.op2.conf.doc.dao;

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

import com.ailk.eaap.op2.conf.doc.dao.IContractDocDao;

/**
 * @ClassName: ContractDocDaoTest
 * @Description: 
 * @author zhengpeng
 * @date 2015-6-29 上午9:48:06
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:eaap-op2-conf-spring.xml"})
public class ContractDocDaoTest extends AbstractJUnit4SpringContextTests{
	
	@Autowired
	private IContractDocDao contractDocDao; 

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.dao.ContractDocDao#showContractDocs(java.util.Map)}.
	 */
	@Test
	public void testShowContractDocs() {
		Map paramMap = new HashMap(); 
		List<Map<String, String>> list = contractDocDao.showContractDocs(paramMap);
		assertNotNull(list);
	}


	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.dao.ContractDocDao#countDocSum(java.util.Map)}.
	 */
	@Test
	public void testCountDocSum() {
		Map paramMap = new HashMap(); 
		int result = contractDocDao.countDocSum(paramMap);
	}


	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.dao.ContractDocDao#isExitDocName(java.lang.String)}.
	 */
	@Test
	public void testIsExitDocName() {
		String name = "test";
		//int result = contractDocDao.isExitDocName(name);
	}

	/**
	 * Test method for {@link com.ailk.eaap.op2.conf.doc.dao.ContractDocDao#isResAlissExit(java.lang.String)}.
	 */
	@Test
	public void testIsResAlissExit() {
		String name = "test";
		//int result = contractDocDao.isResAlissExit(name);
	}

}
