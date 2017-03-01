/** 
 * Project Name:o2p-conf-tags 
 * File Name:IExceptionLogServ.java 
 * Package Name:com.ailk.eaap.op2.conf.auditing.service 
 * Date:2016年1月27日下午3:22:09 
 * Copyright (c) 2016, www.asiainfo.com All Rights Reserved. 
 * 
*/  
  
package com.ailk.eaap.op2.conf.auditing.service;  

import com.ailk.eaap.op2.bo.ExceptionLog;

/** 
 * ClassName:IExceptionLogServ <br/> 
 * Function: TODO ADD FUNCTION. <br/> 
 * Reason:   TODO ADD REASON. <br/> 
 * Date:     2016年1月27日 下午3:22:09 <br/> 
 * @author   wushuzhen 
 * @version   
 * @since    JDK 1.7 
 * @see       
 */
public interface IExceptionLogServ {
	public ExceptionLog selectExceptionLogByActId(String activitiId,String objectId);
}
