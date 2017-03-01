package test.com.ailk.eaap.op2.conf.util;

import java.util.HashMap;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.Dispatcher;
import org.apache.struts2.views.JspSupportServlet;
import org.junit.Before;
import org.springframework.context.ApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletConfig;
import org.springframework.mock.web.MockServletContext;
import org.springframework.web.context.ContextLoader;

import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.ActionProxyFactory;

/**
 * @ClassName: BaseStrutsTest
 * @Description:
 * @author zhengpeng
 * @date 2015-6-30 下午4:07:34
 * 
 */
public class BaseStrutsTest {

	private static final String CONFIG_LOCATIONS = "classpath:eaap-op2-conf-spring.xml";
	private static ApplicationContext applicationContext;
	private Dispatcher dispatcher;
	protected ActionProxy proxy;
	protected static MockServletContext servletContext;
	protected static MockServletConfig servletConfig;
	protected MockHttpServletRequest request;
	protected MockHttpServletResponse response;

	@SuppressWarnings("unchecked")
	protected <T> T createAction(Class<T> clazz, String namespace, String name)throws Exception {

		proxy = dispatcher.getContainer().getInstance(ActionProxyFactory.class)
				.createActionProxy(namespace, name, null, true, false);

		proxy.getInvocation().getInvocationContext().setParameters(new HashMap());
		proxy.setExecuteResult(true);

		ServletActionContext.setContext(proxy.getInvocation().getInvocationContext());
		ServletActionContext.setRequest(request);
		ServletActionContext.setResponse(response);
		ServletActionContext.setServletContext(servletContext);
		return (T) proxy.getAction();
	}
	
	@Before
	public void setUp() throws Exception {
		request = new MockHttpServletRequest(servletContext, "POST", "");
		response = new MockHttpServletResponse();
		if (applicationContext == null) {
			servletContext = new MockServletContext();
			servletContext.addInitParameter(ContextLoader.CONFIG_LOCATION_PARAM, CONFIG_LOCATIONS);
			applicationContext = (new ContextLoader()).initWebApplicationContext(servletContext);
			new JspSupportServlet().init(new MockServletConfig(servletContext));
		}

		HashMap params = new HashMap();
		dispatcher = new Dispatcher(servletContext, params);
		dispatcher.init();
		Dispatcher.setInstance(dispatcher);
	}
	
	public Object getBean(String bean){
		return applicationContext.getBean(bean);
	}
	
	public MockHttpServletRequest getRequest(){
		return this.request;
	}
	
	public MockHttpServletResponse getResponse(){
		return this.response;
	}

}
