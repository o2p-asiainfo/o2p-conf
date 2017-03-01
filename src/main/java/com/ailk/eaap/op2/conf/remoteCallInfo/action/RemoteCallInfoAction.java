package com.ailk.eaap.op2.conf.remoteCallInfo.action;

import java.util.ArrayList;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.RemoteCallInfo;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.remoteCallInfo.service.IRemoteCallInfoService;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

public class RemoteCallInfoAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
	private String editOrAdd ;
	private IRemoteCallInfoService remoteCallInfoService;
    private IConfManagerServ confManagerServ;
	private Boolean isChoosePage= false;
	private RemoteCallInfo remoteCallInfo = new RemoteCallInfo();
	private List<Map> formatTypeList = new ArrayList<Map>();
	private List<Map> objTypeList = new ArrayList<Map>();
	private Map formatTypeMap = new HashMap() ;
	private Map objTypeMap = new HashMap() ;
	private String pageState;
	private String modName;
	private String remoteCallUrlId;
	private String personId;
	private String attrName="";
	private String objectId="";
	private String endpoint_Spec_Attr_Id="";
	private String newState;
	private String attrSpecCode;

	public RemoteCallInfoAction() {
	}
	
   public String remoteCallInfoList(){
		  formatTypeMap = getMainInfo(EAAPConstants.MSG_FORMAT_TYPE) ;
		  Iterator iter = formatTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 formatTypeList.add(mapTmp) ;
		 }
		return SUCCESS;
	}
	
	public Map getRemoteCallInfoList(Map para){
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("remoteCallUrlCode", "".equals(getRequest().getParameter("remoteCallInfo.remoteCallUrlCode"))?null:getRequest().getParameter("remoteCallInfo.remoteCallUrlCode")) ;
		 map.put("remoteCallUrl", "".equals(getRequest().getParameter("remoteCallInfo.remoteCallUrl"))?null:getRequest().getParameter("remoteCallInfo.remoteCallUrl")) ;
		 map.put("remoteCallUrlStatus", "".equals(getRequest().getParameter("remoteCallInfo.remoteCallUrlStatus"))?null:getRequest().getParameter("remoteCallInfo.remoteCallUrlStatus")) ;

		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getRemoteCallInfoService().getRemoteCallInfoList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", startRow - 1);
         map.put("page_record", rows);
         List<Map> remoteCallInfoList =getRemoteCallInfoService().getRemoteCallInfoList(map) ;

		  Map returnMap = new HashMap();
	      returnMap.put("startRow", startRow);
		  returnMap.put("rows", rows); 	
		  returnMap.put("total", total);
		  returnMap.put("dataList", page.convertJson(remoteCallInfoList));

		  return returnMap ;
	}
	
	
	public String editRemoteCallInfo(){
		  formatTypeMap = getMainInfo(EAAPConstants.MSG_FORMAT_TYPE) ;
		  Iterator iter = formatTypeMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 formatTypeList.add(mapTmp) ;
		 }
		 if (remoteCallInfo.getRemoteCallUrlId() !=null && !"".equals(remoteCallInfo.getRemoteCallUrlId().toString())) {
			 remoteCallInfo = getRemoteCallInfoService().getRemoteCallInfo(remoteCallInfo);
		 }
		return SUCCESS;
	}
	

	public String saveRemoteCallInfo(){
		if (remoteCallInfo.getRemoteCallUrlId() != null) {
			getRemoteCallInfoService().updateRemoteCallInfo(remoteCallInfo);
		} else {
			remoteCallInfo.setRemoteCallUrlStatus("A"); 			//A:可用，R:不可用
			getRemoteCallInfoService().insertRemoteCallInfo(remoteCallInfo);
		}
		return SUCCESS;
	}

	public String delRemoteCallInfo(){
		remoteCallInfo.setRemoteCallUrlStatus("R");		//A:可用，R:不可用
		getRemoteCallInfoService().updateRemoteCallInfo(remoteCallInfo);		//假删，修改状态位
		//getRemoteCallInfoService().deleteRemoteCallInfo(remoteCallInfo);		//真删
		return SUCCESS;
	}
	
	public IRemoteCallInfoService getRemoteCallInfoService() {
		if(remoteCallInfoService==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				remoteCallInfoService = (IRemoteCallInfoService)ctx.getBean("eaap-op2-conf-remoteCallInfo-remoteCallInfoService");
	     }
		return remoteCallInfoService;
	}
	public void setRemoteCallInfoService(IRemoteCallInfoService remoteCallInfoService) {
		this.remoteCallInfoService = remoteCallInfoService;
	}

	public Map getMainInfo(String mainTypeSign){
  	      MainDataType mainDataType = new MainDataType();
  	      MainData mainData = new MainData();
  	      Map stateMap = new HashMap() ;
  	      mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
  	      mainDataType.setMdtSign(mainTypeSign) ;
  	      List<MainDataType> mdList = getConfManagerServ().selectMainDataType(mainDataType);
  	      if(mdList!=null && mdList.size()>0){
  	    	  mainDataType = mdList.get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
			  List<MainData> mainDataList = getConfManagerServ().selectMainData(mainData) ;
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(), mainDataList.get(i).getCepName()) ;
				  }
			  }
		  }
		  return  stateMap ;
	  }
	
	public String getPersonId(){
		Cookie[] cookies = getRequest().getCookies();
		Cookie cookie = null;
		String sysPersonId = null;
		if(cookies != null){
			for(int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if("sysPersonId".equals(cookie.getName())){
					sysPersonId = cookie.getValue();
				}
			}
		}
		return sysPersonId;
	}
		
	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
            //取得spring上下文
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				// 取得spring bean实例
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
	     }
		return confManagerServ;
	}
	
	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
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
	public Pagination getPagination() {
		return pagination;
	}
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	public String getEditOrAdd() {
		return editOrAdd;
	}
	public void setEditOrAdd(String editOrAdd) {
		this.editOrAdd = editOrAdd;
	}
	

	public RemoteCallInfo getRemoteCallInfo() {
		return remoteCallInfo;
	}
	public void setRemoteCallInfo(RemoteCallInfo remoteCallInfo) {
		this.remoteCallInfo = remoteCallInfo;
	}

	public Boolean getIsChoosePage() {
		return isChoosePage;
	}
	public void setIsChoosePage(Boolean isChoosePage) {
		this.isChoosePage = isChoosePage;
	}


	public List<Map> getFormatTypeList() {
		return formatTypeList;
	}

	public void setFormatTypeList(List<Map> formatTypeList) {
		this.formatTypeList = formatTypeList;
	}

	public Map getFormatTypeMap() {
		return formatTypeMap;
	}

	public void setFormatTypeMap(Map formatTypeMap) {
		this.formatTypeMap = formatTypeMap;
	}



	public Map getObjTypeMap() {
		return objTypeMap;
	}

	public void setObjTypeMap(Map objTypeMap) {
		this.objTypeMap = objTypeMap;
	}

	public List<Map> getObjTypeList() {
		return objTypeList;
	}

	public void setObjTypeList(List<Map> objTypeList) {
		this.objTypeList = objTypeList;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}

	public String getRemoteCallUrlId() {
		return remoteCallUrlId;
	}

	public void setRemoteCallUrlId(String remoteCallUrlId) {
		this.remoteCallUrlId = remoteCallUrlId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getEndpoint_Spec_Attr_Id() {
		return endpoint_Spec_Attr_Id;
	}
	public void setEndpoint_Spec_Attr_Id(String endpoint_Spec_Attr_Id) {
		this.endpoint_Spec_Attr_Id = endpoint_Spec_Attr_Id;
	}

	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	public String getAttrName() {
		return attrName;
	}
	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}

	public String getNewState() {
		return newState;
	}

	public void setNewState(String newState) {
		this.newState = newState;
	}

	public String getAttrSpecCode() {
		return attrSpecCode;
	}

	public void setAttrSpecCode(String attrSpecCode) {
		this.attrSpecCode = attrSpecCode;
	}


	
}
