package test.com.ailk.eaap.op2.conf.techImpl.service;

import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.techImpl.service.ITechImplService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:eaap-op2-conf-spring.xml")
public class TechImplServiceTest extends AbstractJUnit4SpringContextTests{
	
	@Resource
	private ITechImplService techImplService;

	@Test
	public void testQueryComponentInfo() {
		Map paramMap = new HashMap(); 
		List<Component> list = techImplService.queryComponentInfo(paramMap);
		assertNotNull(list);
	}

	

}
