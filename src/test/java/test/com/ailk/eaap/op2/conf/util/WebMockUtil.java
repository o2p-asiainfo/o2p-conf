package test.com.ailk.eaap.op2.conf.util;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.mock.web.MockServletConfig;
import org.springframework.mock.web.MockServletContext;

/**
 * @ClassName: WebMockUtil
 * @Description:
 * @author zhengpeng
 * @date 2015-6-30 上午10:40:30
 * 
 */
public class WebMockUtil {

	public static ServletContext getServletContext() {
		return new MockServletContext();
	}
	

	public static ServletConfig getServletConfig() {
		return new MockServletConfig(getServletContext());
	}

	public static HttpServletRequest getHttpServletRequest() {
		MockHttpServletRequest mockRequest = new MockHttpServletRequest(
				getServletContext(), "POST", "");
		mockRequest.setSession(getHttpSession());
		return mockRequest;
	}

	public static HttpServletResponse getHttpServletResponse() {
		return new MockHttpServletResponse();
	}

	public static HttpSession getHttpSession() {
		return new MockHttpSession(getServletContext(), "0");
	}

	private WebMockUtil() {
	}

}
