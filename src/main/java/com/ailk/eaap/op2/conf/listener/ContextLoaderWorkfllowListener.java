package com.ailk.eaap.op2.conf.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class ContextLoaderWorkfllowListener extends ContextLoaderListener {
	
	public void contextInitialized(ServletContextEvent event) {
		ServletContext servletContext = event.getServletContext();
		ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
	}

	public void contextDestroyed(ServletContextEvent event) {

	}
}
