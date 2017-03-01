package com.ailk.eaap.op2.conf.util;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import com.ailk.eaap.op2.common.EAAPConstants;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebConstants;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.util.StringUtil;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.web.client.RestTemplate;


/**
 * @author linf
 *
 */
public class CommonUtil {
	private static Logger log = Logger.getLog(CommonUtil.class);
	public static void waitSleep(long time){
		try {
			Thread.sleep(time);
		} catch (InterruptedException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Execute 'CommonUtil' method  exception",null));
		}
	}
	
	public static Boolean completeTask(Map<String, Object> variables){
		RestTemplate rest = new RestTemplate();
		
		String message = rest.postForObject(WebPropertyUtil.getPropertyValue("work_flow_pro_url")+"/task/completeTask?taskId={taskId}&varJson={varJson}",
	    		null, String.class,variables);
		JSONObject retJson = new JSONObject();
		if(!StringUtils.isEmpty(message)){
			retJson = JSON.parseObject(message);
		}
		return "0000".equals(retJson.getString("code"));
	}
	
	public static Boolean isExitTaskByTaskId(String taskId){
		RestTemplate rest = new RestTemplate();
		String message = rest.getForObject(WebPropertyUtil.getPropertyValue("work_flow_pro_url")+"/task/isExitTask/{taskId}",
	    		String.class,taskId);
		JSONObject retJson = new JSONObject();
		if(!StringUtils.isEmpty(message)){
			retJson = JSON.parseObject(message);
		}
		return "0000".equals(retJson.getString("code"));
	}
	
	/**
	 * 获取配置文件值
	 * @param proCode
	 * @return
	 */
	public static String getValueByProCode(String proCode) {
		Properties p = new Properties();
		InputStream in = null;
		try {
			in = CommonUtil.class.getResourceAsStream("/eaap_common.properties");
			p.load(in);
			if(null != in){
				in.close();
			}
			return (String) p.get(proCode);
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Gets the configuration file value anomaly",null));
			return null;
		}finally{
			if(null != in){
				try {
					in.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Gets the configuration file value anomaly",null));
				}
			}
		}
	}	
	
	/**
	 * 获取配置文件中的中文值
	 * @param proCode
	 * @return
	 */
	public static String getChineseValueByProCode(String proCode) {
		Properties p = new Properties();
		InputStream in = null;
		try {
			in = CommonUtil.class.getResourceAsStream("/eaap_common.properties");
			p.load(in);
			if(null !=  in){
				in.close();
			}
			return new String(((String)p.get(proCode)).getBytes("ISO-8859-1"),"utf-8");
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Gets the configuration file in the Chinese value anomaly",null));
			return null;
		}finally{
			if(null !=  in){
				try {
					in.close();
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Gets the configuration file in the Chinese value anomaly",null));
				}
			}
		}
	}		
	
	/**
	 * 获取堆栈里的异常信息
     * Get the stack trace of the exception. 
     * @param e The exception instance.
     * @return The full stack trace of the exception.
     */
    public static String getExceptionTrace(Throwable e) {
           if (e != null) {
                  StringWriter sw = new StringWriter();
                  PrintWriter pw = new PrintWriter(sw);
                  e.printStackTrace(pw);
                  return sw.toString();
           }
           return "No Exception";
    }	
    
    /**
     * 用于流程中人员包含字符串判断
     * @param pStr
     * @param subStr
     * @param separator
     * @return
     */
    public static boolean isSubStr(String pStr,String subStr,String separator){
    	String[] pStrs=pStr.split(separator);
    	for(int i=0;i<pStrs.length;i++){
    		String eachStr=pStrs[i];
    		if(eachStr.equals(subStr))
    			return true;
    	}
    	return false;
    }
    
    /**
     * 用于流程中包含人员字符串去除前后分隔符
     * 如字符串",123,"转成"123" ,",123,1234,2323," 只取第一个
     * @param srcStr
     * @param separator
     * @return
     */
    public static String dropStringSeparator(String srcStr,String separator){
    	if(srcStr==null)
    		return "";
    	String [] srcStrs=srcStr.split(separator);
    	for(int i=0;i<srcStrs.length;i++){
    		String eachStr=srcStrs[i];
    		if(eachStr!=null&&!eachStr.equals(""))
    			return eachStr;    		
    	}
    	return "";
    }
    
    /**
     * 取出放在List里面的map根据传入的key2对应的value2值 (key1,value1,用于唯一确定是否是这条记录)
     * @param key
     * @param srcList
     * @return
     */
    public static Object getMapValue(String key1,String value1,String key2,List srcList){
    	for(int i=0;i<srcList.size();i++){
    		Map map=(Map)srcList.get(i);
    		String mapvalue1=(String)map.get(key1);
    		if(mapvalue1!=null&&mapvalue1.equals(value1)){
    			Object object=map.get(key2);
    			return object;
    		}
    	}
    	return null;
    }
  //将paramMap根据key获取的值转成String并返回
	public static String getMapValueToString (Map paramMap,String key){
		String value ="";
		if (paramMap==null) return value;
		if(paramMap.get(key)!=null){
			if(paramMap.get(key) instanceof String){
				value =(String)paramMap.get(key);
				return value;
			}	
			if(paramMap.get(key) instanceof java.math.BigDecimal){
				value =((java.math.BigDecimal)paramMap.get(key)).toString();
				return value;
			}			
			if(paramMap.get(key) instanceof Boolean){
				value =((Boolean)paramMap.get(key)).toString();
				return value;
			}
			if(paramMap.get(key) instanceof Integer){
				value =paramMap.get(key).toString();
				return value;
			}
			if(paramMap.get(key) instanceof Long){
				value =paramMap.get(key).toString();
				return value;
			}
			if(paramMap.get(key) instanceof Blob){
				Blob blob = (Blob) paramMap.get(key);
				BufferedInputStream bi = null;
				try {
					bi = new BufferedInputStream(blob.getBinaryStream());
					byte [] data= new byte[((Long)blob.length()).intValue()];
					StringBuffer dataBf= new StringBuffer();
		            for (int len = 0; (len = bi.read(data)) != -1;) { 
		            	//value+=new String(data,"utf-8");
		            	dataBf.append(new String(data,"utf-8"));
		            }
		            value += dataBf.toString();
				} catch (SQLException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Execute 'getMapValueToString'  method  exception",null));
				} catch (UnsupportedEncodingException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Execute 'getMapValueToString'  method  exception",null));
				} catch (IOException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Execute 'getMapValueToString'  method  exception",null));
				}finally{
					if(null != bi){
						try {
							bi.close();
						} catch (IOException e) {
							log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
						}
					}
				}
	            
			}
		}else{
			value = "";
		}
		return value;
	}
	
	public static String getStringByObj(Object content){
		if(content != null){
			String ObjStr = String.valueOf(content);
			if(StringUtil.isEmpty(ObjStr) == true){
				return null;
			}else{
				return ObjStr;
			}
		}else{
			return null;
		}
	}
	
	/**
	 * 从session里获取到时间差
	 * @param session
	 * @return
	 */
	public static int getTimeOffsetForSession(HttpSession session){
		int timeOffest = 0;
		if(session != null){
			if(session.getAttribute(EAAPConstants.TIME_OFFSET) != null){
				timeOffest = Integer.valueOf(session.getAttribute(EAAPConstants.TIME_OFFSET).toString());
			//将cookie里timeOffest放入session
			}else{
				Cookie[] cookies = ServletActionContext.getRequest().getCookies();
				if(cookies != null){
					for (Cookie cookie : cookies) {
					    if(EAAPConstants.TIME_OFFSET.equals(cookie.getName())){
					    	timeOffest = CommonUtil.getTimeOffsetForCookie(cookie);
					    	session.setAttribute(EAAPConstants.TIME_OFFSET, String.valueOf(timeOffest));
					    }
					}
				}
			}
		}
		return timeOffest;
	}
	
	/**
	 * 从Cookie获取到时区值
	 * @param cookie
	 * @return
	 */
	public static int getTimeOffsetForCookie(Cookie cookie){
		int timeOffset = 0;
		if(!StringUtil.isEmpty(cookie.getValue())){
			timeOffset = Integer.valueOf(cookie.getValue());
		}
		return timeOffset;
	}
	
	/**
	 *  get processDef by png
	 * @param processKey
	 * @return
	 */
	public static String getProcessDefImg(String processKey){
		StringBuffer messageFlowURL = new StringBuffer();
		messageFlowURL.append(WebPropertyUtil.getPropertyValue("work_flow_pro_url")).append("/processDef/img/").append(processKey);
		return messageFlowURL.toString();
	}


	/**
	 * 从session里获租户ID（TenantId）
	 * @param session
	 * @return
	 */
	public static Integer getTenantId(HttpSession session){
		Integer tenantId =null;
		if(session != null){
			String tenantIdCookieSessionName=WebConstants.O2P_USER_TENANT_ID_KEY;
			if(session.getAttribute(tenantIdCookieSessionName) != null){
				tenantId = Integer.valueOf(session.getAttribute(tenantIdCookieSessionName).toString());
			}
		}
		return tenantId;
	}
	
}
