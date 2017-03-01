package com.ailk.eaap.op2.conf.crmorder.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;

/** 
 * @ClassName: CrmOttDao 
 * @Description: 
 * @author zhengpeng
 * @date 2014-11-22 下午7:30:24 
 * @version V1.0  
 */
public class CrmOrderDao implements ICrmOrderDao{
	
	private SqlMapDAO sqlMapDao;

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	public List<Map> queryAttrSpec(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryAttrSpec", map);
	}
	
	public List<Map> queryCrmUserAddressById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmUserAddressById", map);
	}
	
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "actTypeId", propertyNames = "ACTTYPE")
		}
	)
	public List<Map> queryCrmOrderProductById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmOrderProductById", map);
	}
	
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "userTypeId", propertyNames = "USERTYPE")
		}
	)
	public List<Map> queryCrmOrderCustomerById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmOrderCustomerById", map);
	}
	
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "userTypeId", propertyNames = "USERTYPE")
		}
	)
	public List<Map> queryCrmOrderUserById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmOrderUserById", map);
	}
	
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "cepId", propertyNames = "CEPNAME"),
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "tradeTypeCodeId", propertyNames = "TRADETYPECODE"),
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "orderStatusId", propertyNames = "ORDERSTATUS")
		}
	)
	public List<Map> queryCrmOrderById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmOrderById", map);
	}
	
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "cepId", propertyNames = "CEPNAME"),
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "tradeTypeCodeId", propertyNames = "TRADETYPECODE"),
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "orderStatusId", propertyNames = "ORDERSTATUSNAME"),
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "crmResultId", propertyNames = "CRMRESULTNAME")
		}
	)
	public List<Map> queryOrderInfoList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmOrderCount", map);
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-crmorder.queryCrmOrderList", map);
		}
    }
	
	public String queryCrmOrderState(String procId){
		Map msgMap = (Map) sqlMapDao.queryForObject("eaap-op2-conf-crmorder.queryCrmOrderState", procId);
		if(null == msgMap){
			return null;
		}
		return (String) msgMap.get("MSG");
	}

}
