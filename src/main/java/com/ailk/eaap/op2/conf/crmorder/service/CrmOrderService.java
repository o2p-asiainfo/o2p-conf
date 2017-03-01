package com.ailk.eaap.op2.conf.crmorder.service;

import java.util.Map;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.crmorder.dao.CrmOrderDao;
import com.ailk.eaap.op2.dao.MainDataDao;
import com.ailk.eaap.op2.dao.MainDataTypeDao;
import com.asiainfo.integration.o2p.web.util.XmlHelper;

/** 
 * @ClassName: CrmOttService 
 * @Description: 
 * @author zhengpeng
 * @date 2014-11-22 下午7:29:05 
 * @version V1.0  
 */
public class CrmOrderService implements ICrmOrderService{
	
	private MainDataDao mainDataSqlDAO;
	private MainDataTypeDao mainDataTypeSqlDAO;
	private CrmOrderDao crmOrderDao;
	
	public void setCrmOrderDao(CrmOrderDao crmOrderDao) {
		this.crmOrderDao = crmOrderDao;
	}


	public void setMainDataTypeSqlDAO(MainDataTypeDao mainDataTypeSqlDAO) {
		this.mainDataTypeSqlDAO = mainDataTypeSqlDAO;
	}


	public void setMainDataSqlDAO(MainDataDao mainDataSqlDAO) {
		this.mainDataSqlDAO = mainDataSqlDAO;
	}
	
	public List<MainData> selectMainData(MainData mainData){
		return mainDataSqlDAO.selectMainData(mainData) ;
	}
	
	public List<MainDataType> selectMainDataType(MainDataType mainDataType){
		return mainDataTypeSqlDAO.selectMainDataType(mainDataType) ;
	}
	
	public List<Map> queryOrderInfoList(Map map){
		List<Map> orderList = crmOrderDao.queryOrderInfoList(map);
		
		for(Map order : orderList){
			this.getOrderState(order);
		}
		
		return orderList;
	}
	
	public void getOrderState(Map order){
		String msg = null;
		Document srcDoc = null;
		String returnType = null;
		String errorCode = null;
		if(null!=order.get("CRMRESULTNAME") && "TAPSTORM".equals(String.valueOf(order.get("MAINSERVERID"))) && 
				"Abnormal".equals(String.valueOf(order.get("ORDERSTATUSNAME")))){
			msg = crmOrderDao.queryCrmOrderState(String.valueOf(order.get("PROCID")));
			if(null==msg){
				return ;
			}
			try {
				srcDoc = DocumentHelper.parseText(msg);
				returnType = srcDoc.selectSingleNode("/ContractRoot/SoCompleteReq/SoReturn/OrderInfo/ReturnType").getText();
				errorCode = srcDoc.selectSingleNode("/ContractRoot/SoCompleteReq/SoReturn/OrderInfo/ErrorCode").getText();
			} catch (DocumentException e) {
				return ;
			}
			
			if("T".equals(returnType) && "3009".equals(errorCode)){
				order.put("ORDERSTATUSNAME", "Finished");
			}
			
		}
	}
	
	public List<Map> queryCrmOrderById(Map map){
		return crmOrderDao.queryCrmOrderById(map);
	}
	
	public List<Map> queryCrmOrderUserById(Map map){
		return crmOrderDao.queryCrmOrderUserById(map);
	}
	
	public List<Map> queryCrmOrderCustomerById(Map map){
		return crmOrderDao.queryCrmOrderCustomerById(map);
	}
	
	public List<Map> queryCrmOrderProductById(Map map){
		return crmOrderDao.queryCrmOrderProductById(map);
	}
	
	public List<Map> queryCrmUserAddressById(Map map){
		return crmOrderDao.queryCrmUserAddressById(map);
	}
	
	public List<Map> queryAttrSpec(Map map){
		return crmOrderDao.queryAttrSpec(map);
	}

}
