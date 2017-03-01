package com.ailk.eaap.op2.conf.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.common.util.i18n.I18nConvertUtil;
import com.ailk.eaap.op2.bo.i18n.I18nParamObj;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.international.bmo.ObjectLocaleServiceImpl;
import com.linkage.rainbow.util.StringUtil;

/** 
 * @ClassName: I18NAspectForSpring 
 * @Description: Spring国际化处理的拦截器
 * @author zhengpeng
 * @date 2014-11-3 下午4:58:31 
 * @version V1.0  
 */
public class I18nAspectForSpring {
	
	private Logger log = Logger.getLog(this.getClass());
	//默认英文
	private static String LANGUAGE = "en";
	private static String COUNTRY = "US";
	private ObjectLocaleServiceImpl transform = null;
	
	/**
	 * 初始化方法，获取配置文件中语言设置
	 */
	public void initialize(){
		LANGUAGE = CustomPropertyConfigurer.getProperty(EAAPConstants.LANGUAGE);
		COUNTRY = CustomPropertyConfigurer.getProperty(EAAPConstants.COUNTRY);
		Locale locale = Locale.getDefault();  
		if(StringUtil.isEmpty(LANGUAGE)){
			LANGUAGE = locale.getLanguage();
		}
		if(StringUtil.isEmpty(COUNTRY)){
			COUNTRY = locale.getCountry();
		}
	}
	
	private ObjectLocaleServiceImpl getObjectLocaleServ() {
		if(transform == null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(ServletActionContext.getRequest().getSession().getServletContext());
			transform = (ObjectLocaleServiceImpl)ctx.getBean("eaap-op2-conf-object-locale-objectLocaleService");
	     }
		return transform;
	}
	
	/**
	 * 拦截DAO里需要国际化的方法
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	public Object aroundMethod(ProceedingJoinPoint joinPoint) throws Throwable{
		
		//执行dao包里的方法
		Object result = joinPoint.proceed();
		
		Class<? extends Object> daoClass = joinPoint.getTarget().getClass();
		Method daoMethod = I18nConvertUtil.findMethod(daoClass,joinPoint.getSignature().getName());
		
		log.debug(" I18nAspectForSpring aroundMethod start execute class：{0}; method name:{1};",joinPoint.getTarget(),joinPoint.getSignature().getName());
		//判断该方法是否需要国际化
		if(daoMethod.getAnnotation(ProvideI18NDatas.class) != null){
			Object[] args = joinPoint.getArgs();
			boolean isQryAllNum = I18nConvertUtil.isQryAllNum(args);
			if(!isQryAllNum){
				Map<String,I18nParamObj> paramMap = new HashMap<String,I18nParamObj>();
				ProvideI18NDatas providerI18NDatas = daoMethod.getAnnotation(ProvideI18NDatas.class);
				if(providerI18NDatas.values() != null){
					for(ProvideI18NData i18nData : providerI18NDatas.values()){
						I18nConvertUtil.setParamMap(i18nData, paramMap);
					}
				}
				if(result != null){
					if(result instanceof List){
						this.getI18nValueByList(paramMap, (List<Object>)result);
					}else if(result instanceof Map){
						I18nConvertUtil.getI18nValueByMap(paramMap, (Map<String,Object>)result,LANGUAGE,COUNTRY,this.getObjectLocaleServ());
					}else{
						I18nConvertUtil.getI18nValueByObj(paramMap, result,LANGUAGE,COUNTRY,this.getObjectLocaleServ()); 
					}
				}
			}
		}
		return result;
	}
	
	
	/**
	 * 对结果为List的获取国际化的值
	 * @param paramMap
	 * @param resultList
	 */
	private void getI18nValueByList(Map<String,I18nParamObj> paramMap,List<Object> resultList){
		for(Object result : resultList){
			if(result instanceof Map){
				I18nConvertUtil.getI18nValueByMap(paramMap,(Map)result,LANGUAGE,COUNTRY,this.getObjectLocaleServ());
			}else{
				I18nConvertUtil.getI18nValueByObj(paramMap,result,LANGUAGE,COUNTRY,this.getObjectLocaleServ());
			}
		}
	}

}
