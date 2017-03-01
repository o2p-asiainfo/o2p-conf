package com.ailk.eaap.op2.conf.util;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.struts2.ServletActionContext;
import org.aspectj.lang.ProceedingJoinPoint;

import com.ailk.eaap.op2.common.EAAPConstants;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.sqllog.util.OperateActContext;
import com.asiainfo.integration.o2p.web.bo.UserRoleInfo;
import com.asiainfo.integration.o2p.web.util.O2pWebCommonUtil;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.struts.BaseAction;

/**
 * @ClassName: TenantAspectForSpring
 * @Description: 租户Spring Dao 拦截器
 * @author zhengpeng
 * @date 2016-4-25 下午2:58:51
 *
 */
public class TenantAspectForSpring{
	
	private static final Logger log = Logger.getLog(TenantAspectForSpring.class);
	public static final String TENANT_ISINTERCEPTOR = "portal_tenant_isInterceptor";
	public static final String TENANT_CODE = "tenantCode";
	public static final String TENANT_ID = "tenantId";
	
	public Object aroundMethod(ProceedingJoinPoint joinPoint) throws Throwable {

		Object[] args = joinPoint.getArgs();
		if(args != null && args.length > 0){
			if("true".equals(WebPropertyUtil.getPropertyValue(TENANT_ISINTERCEPTOR))){
				//多租户工程：
					for(Object argObj: args){
						HttpSession session = ServletActionContext.getRequest().getSession();
						Integer tenantId =CommonUtil.getTenantId(session);		
						log.debug("tenantId:"+tenantId);
						Object USER_TENANT_ID=ServletActionContext.getRequest().getParameter("USER_TENANT_ID");
						log.debug("USER_TENANT_ID:"+USER_TENANT_ID);
						if(USER_TENANT_ID!=null){
							tenantId=Integer.parseInt(String.valueOf(USER_TENANT_ID));
						}
						log.debug("final tenantId:"+tenantId);
						if(argObj != null && tenantId != null){
							this.setTenantToObject(argObj, tenantId); 
						}
					}
			}else{
				//非多租户工程，租户ID设为默认值：
				Integer tenantId = O2pWebCommonUtil.getDefalutTenantId();
				if(args != null && args.length > 0){
					for(Object argObj: args){
						if(argObj != null && tenantId != null){
							this.setTenantToObject(argObj, tenantId); 
						}
					}
				}
			}
		}
		// 执行dao包里的方法
		Object result = joinPoint.proceed();
		return result;
	}
	
	private void setTenantToObject(Object paramObj,Integer tenantId){
		if(paramObj instanceof HashMap){ 
			this.setTenantToMap((HashMap)paramObj, tenantId);
		}else if(paramObj instanceof List){
			this.setTenantToList((List) paramObj, tenantId);
		} else{
			this.setTenantToTenantBean(paramObj, tenantId);
		}
	}
	

	@SuppressWarnings({"unchecked", "rawtypes" })
	private void setTenantToMap(HashMap paramMap,Integer tenantId){
		if(!paramMap.containsKey(TENANT_CODE)){
			paramMap.put(TENANT_ID, tenantId); 
		}
	}
	
	@SuppressWarnings("rawtypes")
	private void setTenantToList(List paramList,Integer tenantId){
		for(Object paramObject : paramList){
			if(paramObject instanceof HashMap){
				this.setTenantToMap((HashMap) paramObject,tenantId);
			}else{
				this.setTenantToTenantBean(paramObject,tenantId);
			}
		}
	}
	
	private void setTenantToTenantBean(Object paramObject,Integer tenantId) {
		Class objectClass = paramObject.getClass();
		Field[] fields = objectClass.getDeclaredFields();
		for (Field field : fields) {
			if(TENANT_ID.equals(field.getName())){
				try {
					PropertyUtils.setSimpleProperty(paramObject, field.getName(), tenantId);
				} catch (Exception e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"TenantAspectForSpring setTenantToObjectContent:" + e.getMessage(),e));
				} 
			}
		}
	}

}
