package com.ailk.eaap.op2.conf.crmorder.action;

import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import net.sf.json.JSONObject;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.conf.crmorder.service.CrmOrderService;
import com.ailk.eaap.op2.conf.crmorder.service.ICrmOrderService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.DateUtil;

/** 
 * @ClassName: CrmOttAction 
 * @Description: 
 * @author zhengpeng
 * @date 2014-11-20 下午9:58:00 
 * @version V1.0  
 */
public class CrmOrderAction extends BaseAction{
	

	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private static final String CRM_ORDER_TYPE = "CRM_ORDER_TYPE";
	private static final String CRMORDER_TRADE_TYPE_CODE = "CRMORDER_TRADE_TYPE_CODE";
	private static final String CRMORDER_CUST_TYPE_ID = "CRMORDER_CUST_TYPE_ID";
	private static final String CRMORDER_USER_TYPE_ID = "CRMORDER_USER_TYPE_ID";
	private static final String CRMORDER_PRODUCT_ACT_TYPE = "CRMORDER_PRODUCT_ACT_TYPE";
	private static final String CRM_ORDER_STATUS = "CRM_ORDER_STATUS";
	private static final String CRM_ORDER_RESULT = "CRM_ORDER_RESULT";
	private ICrmOrderService crmOrderService;
	private Pagination page=new Pagination();
	private List<Map> selectOrderTypeList = new ArrayList<Map>();
	private String startAcceptDate = DateUtil.convDateToString(DateUtil.getDateBefore(new Date(), -1),"yyyy-MM-dd");
	private String endAcceptDate = DateUtil.convDateToString(new Date(), "yyyy-MM-dd");
	private int rows;
	private int pageNum;
	private int total;
	

	public void setCrmOrderService(ICrmOrderService crmOrderService) {
		this.crmOrderService = crmOrderService;
	}
	
	public ICrmOrderService getCrmOrderService() {
		if(crmOrderService==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			crmOrderService = (CrmOrderService)ctx.getBean("eaap-op2-conf-crmorder-crmService");
	     }
		return crmOrderService;
	}
	
	public Map getOrderList(Map para){
		rows = page.getRows();
		pageNum = page.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		Map<String,Object> returnMap = new HashMap<String,Object>();
		
		Map<String,Object> map = new HashMap<String,Object>(); 
		map.put("soType", "".equals(para.get("soType"))?null:para.get("soType"));
		map.put("soNbr", "".equals(para.get("soNbr"))?null:para.get("soNbr"));
		map.put("orderNbr", "".equals(para.get("orderNbr"))?null:para.get("orderNbr"));
		String crmOrderTypeCd = this.getMainDateTypeCd(CRM_ORDER_TYPE);
		String tradeTypeCode = this.getMainDateTypeCd(CRMORDER_TRADE_TYPE_CODE);
		String crmOrderStatus = this.getMainDateTypeCd(CRM_ORDER_STATUS); 
		String crmOrderResult = this.getMainDateTypeCd(CRM_ORDER_RESULT);
		map.put("CRM_ORDER_TYPE", crmOrderTypeCd);
		map.put("CRMORDER_TRADE_TYPE_CODE", tradeTypeCode);
		map.put("CRM_ORDER_STATUS", crmOrderStatus); 
		map.put("CRM_ORDER_RESULT", crmOrderResult); 
		if(para.get("startAcceptDate") == null || "".equals(para.get("startAcceptDate"))){
			map.put("startAcceptDate", startAcceptDate);
		}else{
			map.put("startAcceptDate", para.get("startAcceptDate"));
		}
		if(para.get("endAcceptDate") == null || "".equals(para.get("endAcceptDate"))){
			map.put("endAcceptDate", endAcceptDate);
		}else{
			map.put("endAcceptDate", para.get("endAcceptDate"));
		}
		map.put("queryType", "ALLNUM");
		List<Map> tmpOrderList = this.getCrmOrderService().queryOrderInfoList(map);
		total = Integer.valueOf(String.valueOf(tmpOrderList.get(0).get("ALLNUM")));
		map.put("pro", startRow);
        map.put("end", startRow+rows-1);
         
        map.put("pro_mysql", (pageNum - 1) * rows);
	    map.put("page_record", rows);
	    map.put("queryType", null);
	    tmpOrderList = this.getCrmOrderService().queryOrderInfoList(map);
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(tmpOrderList));
		return returnMap;
	}
	
	public void getOrderInfoById(){
		Map paraMap = new HashMap();
		paraMap.put("orderId", this.getRequest().getParameter("orderId"));
		try{
			Writer wr = getResponse().getWriter();
			Map returnMap = new HashMap();
			Map orderInfo = this.getOrderInfo(paraMap);
			if(orderInfo != null){
				returnMap.put("orderInfo", orderInfo);
				
				List<Map> orderUserList = this.getOrderUserList(paraMap);
				if(orderUserList != null){
					String userIds = this.getUserIds(orderUserList);
					returnMap.put("uIds", userIds);
					//获取地址
					List<Map> userAddressList = this.getUserAddressList(paraMap);
					
					returnMap.put("orderUserList", orderUserList);
					returnMap.put("userAddressList", userAddressList);
				}
				
				List<Map> orderCustomerList = this.getOrderCustomerList(paraMap);
				if(orderCustomerList != null){
					returnMap.put("orderCustomerList", orderCustomerList);
				}
				
				List<Map> orderProductList = this.getOrderProductList(paraMap);
				if(orderProductList != null){
					returnMap.put("orderProductList", orderProductList);
				}
				
				JSONObject jsonObject = JSONObject.fromObject(returnMap);
				wr.write(jsonObject.toString());
				wr.close();
			}
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	
	private List<Map> getUserAddressList(Map paraMap){
		//地址属性
		Map mapTemp = new HashMap();  
		List<Map> attrSpecMapList = this.getCrmOrderService().queryAttrSpec(mapTemp);
		List<Map> userAddressMapList = this.getCrmOrderService().queryCrmUserAddressById(paraMap);
		Map<String,String> allAttrMap = this.getAttrMap(attrSpecMapList);
		
		List<Map> resultMapList = new ArrayList<Map>();
		Map<String,Map> addressMap = new HashMap<String,Map>();
		
		for(Map userAddressMap : userAddressMapList){
			String userId = (String)userAddressMap.get("USERID");
			if(addressMap.containsKey(userId)){
				Map map = addressMap.get(userId);
				String attrID = String.valueOf(userAddressMap.get("ATTRID"));
				//获取属性名
				String attrName = allAttrMap.get(attrID); 
				map.put(attrName.toUpperCase(), userAddressMap.get("ATTRVALUE"));
			}else{
				Map map = new HashMap();
				addressMap.put(userId, map);
				map.put("USERID", userId);
				String attrID = String.valueOf(userAddressMap.get("ATTRID"));
				//获取属性名
				String attrName = allAttrMap.get(attrID); 
				map.put(attrName.toUpperCase(), userAddressMap.get("ATTRVALUE"));
				resultMapList.add(map);
			}
		}
		return resultMapList;
	}
	
	private Map<String,String> getAttrMap(List<Map> userAttrMapList){
		Map<String,String> allAttrMap = new HashMap<String,String>();
		try{
			for(Map attrMap : userAttrMapList){
				String attrId = attrMap.get("ATTRID").toString();
				String attrName = attrMap.get("ATTRNAME") == null?"":attrMap.get("ATTRNAME").toString();
				allAttrMap.put(attrId, attrName);
			}
		}catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return allAttrMap;
	}
	
	private String getUserIds(List<Map> orderCustomerList){
		StringBuffer userIds = new StringBuffer();
		int i = 0;
		for(Map map : orderCustomerList){
			i++;
			userIds.append(map.get("UID"));
			if(i < orderCustomerList.size()-1){
				userIds.append(",");
			}
		}
		return userIds.toString();
	}
	
	
	private List<Map> getOrderProductList(Map paraMap){
		String productActType = this.getMainDateTypeCd(CRMORDER_PRODUCT_ACT_TYPE);
		paraMap.put(CRMORDER_PRODUCT_ACT_TYPE, productActType);
		return this.getCrmOrderService().queryCrmOrderProductById(paraMap); 
	}
	
	private List<Map> getOrderCustomerList(Map paraMap){
		String custTypeId = this.getMainDateTypeCd(CRMORDER_CUST_TYPE_ID);
		paraMap.put(CRMORDER_CUST_TYPE_ID, custTypeId);
		return this.getCrmOrderService().queryCrmOrderCustomerById(paraMap);
	}
	
	private List<Map> getOrderUserList(Map paraMap){
		String userTypeId = this.getMainDateTypeCd(CRMORDER_USER_TYPE_ID);
		paraMap.put(CRMORDER_USER_TYPE_ID, userTypeId);
		return this.getCrmOrderService().queryCrmOrderUserById(paraMap);
	}
	
	private Map getOrderInfo(Map paraMap){
		String crmOrderTypeCd = this.getMainDateTypeCd(CRM_ORDER_TYPE);
		String tradeTypeCode = this.getMainDateTypeCd(CRMORDER_TRADE_TYPE_CODE);
		String crmOrderStatus = this.getMainDateTypeCd(CRM_ORDER_STATUS);
		paraMap.put(CRM_ORDER_TYPE, crmOrderTypeCd);
		paraMap.put(CRMORDER_TRADE_TYPE_CODE, tradeTypeCode);
		paraMap.put(CRM_ORDER_STATUS, crmOrderStatus);
		List<Map> orderList = this.getCrmOrderService().queryCrmOrderById(paraMap);
		Map orderInfo = null;
		if(orderList.size() > 0){
			orderInfo = orderList.get(0);
			this.getCrmOrderService().getOrderState(orderInfo);
		}
		return orderInfo;
	}
	
	private String getMainDateTypeCd(String mdtName){
		MainDataType mainDateType = new MainDataType();
		mainDateType.setMdtName(mdtName);
		List<MainDataType> mainDateTypeList = this.getCrmOrderService().selectMainDataType(mainDateType);
		return mainDateTypeList.get(0).getMdtCd();
	}

	
	public String showCrmOrderList(){
		MainDataType mainDataType = new MainDataType();
		mainDataType.setMdtSign(CRM_ORDER_TYPE) ;
		mainDataType = getCrmOrderService().selectMainDataType(mainDataType).get(0);
		
		MainData mainData = new MainData();
		mainData.setMdtCd(mainDataType.getMdtCd());
		List<MainData> mainDataList = getCrmOrderService().selectMainData(mainData);
		
		if(mainDataList!=null && mainDataList.size()>0){
			  for(int i=0;i<mainDataList.size();i++){
				  Map mainDataMap = new HashMap();
				  mainDataMap.put("cepCode", mainDataList.get(i).getCepCode());
				  mainDataMap.put("cepName", mainDataList.get(i).getCepName());
				  selectOrderTypeList.add(mainDataMap); 
			  }
		  }
		
		return SUCCESS;
	}
	
	
	public List<Map> getSelectOrderTypeList() {
		return selectOrderTypeList;
	}

	public void setSelectOrderTypeList(List<Map> selectOrderTypeList) {
		this.selectOrderTypeList = selectOrderTypeList;
	}
	
	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}
	
	public String getStartAcceptDate() {
		return startAcceptDate;
	}

	public void setStartAcceptDate(String startAcceptDate) {
		this.startAcceptDate = startAcceptDate;
	}

	public String getEndAcceptDate() {
		return endAcceptDate;
	}

	public void setEndAcceptDate(String endAcceptDate) {
		this.endAcceptDate = endAcceptDate;
	}


}
