package com.ailk.eaap.op2.conf.crmorder.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;

/** 
 * @ClassName: ICrmOttService 
 * @Description: 
 * @author zhengpeng
 * @date 2014-11-22 下午7:29:56 
 * @version V1.0  
 */
public interface ICrmOrderService {
	
	public List<MainData> selectMainData(MainData mainData);
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType);
	
	public List<Map> queryOrderInfoList(Map map);
	
	public List<Map> queryCrmOrderById(Map map);
	
	public List<Map> queryCrmOrderUserById(Map map);
	
	public List<Map> queryCrmOrderCustomerById(Map map);
	
	public List<Map> queryCrmOrderProductById(Map map);
	
	public List<Map> queryCrmUserAddressById(Map map);
	
	public List<Map> queryAttrSpec(Map map);
	
	public void getOrderState(Map order);
	
}
