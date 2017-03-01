/** 
 * Project Name:o2p-conf-tags 
 * File Name:ExceptionLogServ.java 
 * Package Name:com.ailk.eaap.op2.conf.auditing.service 
 * Date:2016年1月27日下午3:21:21 
 * Copyright (c) 2016, www.asiainfo.com All Rights Reserved. 
 * 
*/  
  
package com.ailk.eaap.op2.conf.auditing.service;  

import com.ailk.eaap.op2.bo.ExceptionLog;
import com.ailk.eaap.op2.dao.ExceptionLogDao;

/** 
 * ClassName:ExceptionLogServ <br/> 
 * Function: TODO ADD FUNCTION. <br/> 
 * Reason:   TODO ADD REASON. <br/> 
 * Date:     2016年1月27日 下午3:21:21 <br/> 
 * @author   wushuzhen 
 * @version   
 * @since    JDK 1.7 
 * @see       
 */
public class ExceptionLogServ implements IExceptionLogServ{
    private ExceptionLogDao exceptionLogDao;
	
	@Override
	public ExceptionLog selectExceptionLogByActId(String activitiId,String objectId) {
		// TODO Auto-generated method stub
		return exceptionLogDao.selectExceptionLogByActId(activitiId,objectId);
	}

	public ExceptionLogDao getExceptionLogDao() {
		return exceptionLogDao;
	}
	public void setExceptionLogDao(ExceptionLogDao exceptionLogDao) {
		this.exceptionLogDao = exceptionLogDao;
	}
}
