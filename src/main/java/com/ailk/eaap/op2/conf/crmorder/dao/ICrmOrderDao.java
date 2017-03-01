package com.ailk.eaap.op2.conf.crmorder.dao;

import java.util.Map;
import java.util.List;

/** 
 * @ClassName: ICrmOttDao 
 * @Description: 
 * @author zhengpeng
 * @date 2014-11-22 下午7:30:49 
 * @version V1.0  
 */
public interface ICrmOrderDao {
	
	public List<Map> queryCrmOrderProductById(Map map);
	
	public List<Map> queryOrderInfoList(Map map);
	
	public List<Map> queryCrmOrderById(Map map);
	
	public List<Map> queryCrmOrderUserById(Map map);
	
	public List<Map> queryCrmOrderCustomerById(Map map);
	
	public List<Map> queryCrmUserAddressById(Map map);
	
	public List<Map> queryAttrSpec(Map map);
	
	public String queryCrmOrderState(String procId);
}
