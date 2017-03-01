package test.com.ailk.eaap.op2.conf.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * @ClassName: SpringUtil
 * @Description: 
 * @author zhengpeng
 * @date 2015-4-29 上午9:57:26
 *
 */
public class SpringUtil {
	
	private static List<String> locations = null;
	private static ApplicationContext context;
	
//	public static String[] locations = {
//		"classpath*:test-eaap-op2-conf-db-spring.xml",
//		"classpath*:sqlMap-config-conf.xml"
//	};

	static {
		locations = new ArrayList<String>();
		locations.add("classpath:eaap-op2-conf-spring.xml");
		locations.add("classpath:eaap-op2-conf-db-spring.xml");
	}
	
	public static void setApplicationContext(ApplicationContext context){
		context = context;
	}
	
	public static ApplicationContext getApplicationContext(){
		return context;
	}
	
	
	public static List<String> getLocations(){
		return locations;
	}

}
