package com.ailk.eaap.op2.conf.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.ailk.eaap.o2p.common.util.CustomBase64;
import com.ailk.eaap.o2p.sqllog.model.OperateActInfo;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.O2pWebCommonUtil;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.ibatis.sqlmap.engine.execution.SqlLogUtil;
import com.linkage.rainbow.util.StringUtil;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.config.entities.ActionConfig;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * @ClassName: UserNameInterceptor
 * @Description: 
 * @author zhengpeng
 * @date 2015-2-5 上午10:53:22
 *
 */
public class ActInterceptor extends MethodFilterInterceptor{

	private static final long serialVersionUID = 1L;
	public static final String SQLLOG_ISINTERCEPTOR = "sqlLog.isInterceptor";
	private Logger log = Logger.getLog(this.getClass());
	
	

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		String result = "";
		//需要拦截
		if(SqlLogUtil.getSqlLogIsInterceptor()){
			try{
				ActionProxy proxy = invocation.getProxy();
				ActionConfig config = proxy.getConfig();
				if(OperateActContext.getActInfo() == null){
					OperateActInfo operateActInfo = new OperateActInfo();
					String userName = getUserNameForSession(ServletActionContext.getRequest().getSession());
					operateActInfo.setUserName(userName);
					operateActInfo.setTenantId(this.getTenantIdForSession(ServletActionContext.getRequest().getSession()));
					String userIp = this.getRemortIP(ServletActionContext.getRequest());
					operateActInfo.setUserIp(userIp);
					operateActInfo.setExecClass(config.getClassName());
					operateActInfo.setExceMothod(config.getMethodName()); 
					OperateActContext.setActInfo(operateActInfo);
				}
				result = invocation.invoke(); 
			}finally{
				OperateActContext.removeActInfo();
			}
		}else{
			result = invocation.invoke(); 
		}
		return result;
	}
	
	/**
	 * 获取租户ID
	 */
	private Integer getTenantIdForSession(HttpSession session){
		Integer tenantId = O2pWebCommonUtil.getDefalutTenantId();
		if(session.getAttribute(WebConstants.O2P_USER_TENANT_ID_KEY) != null){					
			Object tenantIdObj = session.getAttribute(WebConstants.O2P_USER_TENANT_ID_KEY);
			if(tenantIdObj != null && tenantIdObj != ""){
				tenantId = Integer.valueOf(tenantIdObj.toString());
			}
		}
		return tenantId;
	}

	
	/**
	 * 获取到用户名
	 * @param session
	 * @return
	 */
	private String getUserNameForSession(HttpSession session){
		String userName = "";
		if(session != null){
			if(session.getAttribute(EAAPConstants.O2P_USER_NAME) != null){
				userName = session.getAttribute(EAAPConstants.O2P_USER_NAME).toString();
			//将cookie里用户名放入session
			}else{
				Cookie[] cookies = ServletActionContext.getRequest().getCookies();
				if(cookies != null){
					for (Cookie cookie : cookies) {
					    if(EAAPConstants.O2P_USER_NAME.equals(cookie.getName())){
					    	userName = this.getUserNameForCookie(cookie);
					    	userName = new String(CustomBase64.decode(base64Correct(userName)));
					    	session.setAttribute(EAAPConstants.O2P_USER_NAME, userName);
					    }
					}
				}
			}
		}
		return userName;
	}
	
	/**
	 * 从Cookie获取到用户名
	 * @param cookie
	 * @return
	 */
	private String getUserNameForCookie(Cookie cookie){
		String userName = "";
		if(!StringUtil.isEmpty(cookie.getValue())){
			userName = cookie.getValue();
		}
		return userName;
	}
	
	public String getRemortIP(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)){
	        ip = request.getRemoteAddr();
	    }
	    return ip.equals("0:0:0:0:0:0:0:1")?"127.0.0.1":ip;
	}
	
	public static String base64Correct(String base64str){
		switch(base64str.length()%4) {  
	        case 3:  
	        	base64str+= "==="; break;   
	        case 2:  
	        	base64str+= "=="; break;  
	        case 1:  
	        	base64str+= "="; break;  
	        default:  
	    }
		return base64str;
	}
	

}
