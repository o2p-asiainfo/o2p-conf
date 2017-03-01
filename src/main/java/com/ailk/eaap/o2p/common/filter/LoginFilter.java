package com.ailk.eaap.o2p.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.asiainfo.integration.o2p.web.bo.UserRoleInfo;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;

public class LoginFilter implements Filter{

	private static final String PORTAL_LOGIN_URL = "portal_login_url";

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		UserRoleInfo user = (UserRoleInfo)request.getSession().getAttribute(WebConstants.O2P_PORTAL_USER_SESSION_KEY);
		if(user == null) {
			response.setHeader("Cache-Control", "no-store");  
			response.setDateHeader("Expires", 0);  
			response.setHeader("Prama", "no-cache");
			response.sendRedirect(WebPropertyUtil.getPropertyValue(PORTAL_LOGIN_URL));
			return;
		}
		chain.doFilter(request, response);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
