package com.ailk.eaap.op2.conf.util;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.common.util.i18n.I18nConvertUtil;
import com.ailk.eaap.op2.bo.i18n.I18nParamObj;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.international.bmo.ObjectLocaleServiceImpl;
import com.linkage.rainbow.util.StringUtil;

/** 
 * @ClassName: I18nAspectForCustom 
 * @Description: 国际化处理类，针对对象
 * @author zhengpeng
 * @date 2015-01-04 下午4:58:31 
 * @version V1.0  
 */
public class I18nAspectForCustom {
	private static Logger log = Logger.getLog(I18nAspectForCustom.class);
	//默认英文
	private static String LANGUAGE = "en";
	private static String COUNTRY = "US";
	private ObjectLocaleServiceImpl transform = null;
	
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
	
	public static I18nAspectForCustom getCustomI18nService() {
		I18nAspectForCustom i18nAspectForCustom = null;
		try{
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(ServletActionContext.getRequest().getSession().getServletContext());
			i18nAspectForCustom = (I18nAspectForCustom)ctx.getBean("i18nAspectForCustom");
		}catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"I18nAspectForCustom:" + e.getMessage(),null));
	    }
		return i18nAspectForCustom;
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
	public void translateI18N(Object result) throws Throwable{
		if(result != null){
			Object resultObj = result;
			if(result instanceof List){
				if(((List) result).size() > 0){
					resultObj = ((List) result).get(0);
				}
			}
			
			//判断该类是否需要国际化
			if(resultObj.getClass().getAnnotation(ProvideI18NDatas.class) != null){
				Map<String,I18nParamObj> paramMap = new HashMap<String,I18nParamObj>();
				ProvideI18NDatas providerI18NDatas = resultObj.getClass().getAnnotation(ProvideI18NDatas.class);
				if(providerI18NDatas.values() != null){
					for(ProvideI18NData i18nData : providerI18NDatas.values()){
						I18nConvertUtil.setParamMap(i18nData, paramMap);
					}
				}
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
