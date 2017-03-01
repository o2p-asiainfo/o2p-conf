/** 
 * Project Name:o2p-serviceAgent-core 
 * File Name:IFreeMarkerValidateService.java 
 * Package Name:com.ailk.eaap.op2.serviceagent.protocol 
 * Date:2015年9月6日上午10:52:26 
 * Copyright (c) 2015, www.asiainfo.com All Rights Reserved. 
 * 
*/  
  
package com.ailk.eaap.op2.conf.contract.service;
/** 
 * ClassName:IFreeMarkerValidateService <br/> 
 * Function: TODO ADD FUNCTION. <br/> 
 * Reason:   TODO ADD REASON. <br/> 
 * Date:     2015年9月6日 上午10:52:26 <br/> 
 * @author   wuwz 
 * @version   
 * @since    JDK 1.6 
 * @see       
 */
public interface IFreeMarkerValidateService {

	public String validateHeader(String templateStr);
	
	public String validateBody(String templateStr);
}
