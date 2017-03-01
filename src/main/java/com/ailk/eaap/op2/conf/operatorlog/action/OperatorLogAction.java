package com.ailk.eaap.op2.conf.operatorlog.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;
import oracle.sql.CLOB;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.conf.messageFlow.service.IMessageFlowSer;
import com.ailk.eaap.op2.conf.operatorlog.service.IOperatorLogService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
/**
 * 界面操作日志审计
 * @author MAWL
 *
 */
public class OperatorLogAction extends BaseAction {

	private Logger log = Logger.getLog(this.getClass());
	private static final long serialVersionUID = 1L;
	private IOperatorLogService operatorLogService;
	private List<Map<String,Object>> optType = new ArrayList<Map<String,Object>>();
	private String logId;
	private PageLogModel pageModel;
	
	private int rows;
	private int pageNum;
	private int total;
	private Pagination page=new Pagination();
	private Pagination pagination = new Pagination();
	public String showOperatorLog(){
		Map<String, Object> insert = new HashMap<String, Object>();
		insert.put("id", "I");
		insert.put("val", getText("eaap.op2.conf.logaudit.typeinsert"));
		optType.add(insert);
		Map<String, Object> update = new HashMap<String, Object>();
		update.put("id", "U");
		update.put("val", getText("eaap.op2.conf.logaudit.typeupdate"));
		optType.add(update);
		Map<String, Object> delete = new HashMap<String, Object>();
		delete.put("id", "D");
		delete.put("val", getText("eaap.op2.conf.logaudit.typedelete"));
		optType.add(delete);
		Map<String, Object> query = new HashMap<String, Object>();
		query.put("id", "Q");
		query.put("val", getText("eaap.op2.conf.logaudit.typequery"));
		optType.add(query);
		return SUCCESS;
	}
	public String detailOperatorLog(){
		Map map = new HashMap();
		map.put("logId", logId);
		List<Map> list = getOperatorLogService().getOptLogById(map);
		if(null !=  list && list.size() > 0){
			Map mapValue = list.get(0);
			String logId =String.valueOf(mapValue.get("LOG_ID"));
			String tableName = String.valueOf(mapValue.get("TABLE_NAME"));
			String optType = String.valueOf(mapValue.get("OPT_TYPE"));
			Object sqlLog = mapValue.get("SQL_LOG");
			pageModel = new PageLogModel();
			pageModel.setUserName(String.valueOf(mapValue.get("USER_NAME")));
			pageModel.setUserIp(null != mapValue.get("USER_IP")?String.valueOf(mapValue.get("USER_IP")):"");
			long abc = Long.valueOf(String.valueOf(mapValue.get("CREATE_DATE")));
			pageModel.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(abc)));
			//数据记录则存在多条的情况
			String showDataLog = getShuitAbleDataLog(logId,tableName,list,optType);
			pageModel.setDataLog(showDataLog);
			pageModel.setExecClass(String.valueOf(mapValue.get("EXEC_CLASS")));
			pageModel.setExecMethod(String.valueOf(mapValue.get("EXEC_METHOD")));
			pageModel.setTableName(tableName);
			pageModel.setSqlLog(getStringDataLog(sqlLog));
			pageModel.setOptAction(shuitValule(optType));
		}
		return SUCCESS;
	}
	private String getShuitAbleDataLog(String logId,String tableName, List<Map> list,
			String optType) {
		//由tableName得到表的所有列名
		Map<String,String> mapColName = new LinkedHashMap<String,String>();//表格所有列名的Map集合
		List<Map> allRecordsMap = new ArrayList<Map>();//所有操作记录集合
		String showdata = "";
		String nowdata = this.getText("eaap.op2.conf.logaudit.nowdata");//当前数据
		String oridata = this.getText("eaap.op2.conf.logaudit.originaldata");//原数据
		Map map = new HashMap();
		map.put("tableName", tableName);
		List<Map> listTableName = getOperatorLogService().getAllTableColByName(map);
		for(Map mapTable : listTableName){
			String colName = String.valueOf(mapTable.get("COLUMN_NAME")).toUpperCase();
			mapColName.put(colName, colName);
		}
		//非修改情况下的表记录组装
		if(!"U".equals(optType)){
			for(Map maprec : list){
				Object dataLog = maprec.get("DATA_LOG");
				String otherdataLog = getStringDataLog(dataLog);
				addListRecords(allRecordsMap,otherdataLog,nowdata);
			}
		}else if("U".equals(optType)){//修改情况的数据展现
			for(Map maprec : list){
				String dataKey = null != maprec.get("DATA_KEY")?String.valueOf(maprec.get("DATA_KEY")):"";//主键数据
				Map<String,String> paramMap = new HashMap<String,String>();
				paramMap.put("logId", logId);
				paramMap.put("tableName", tableName);
				paramMap.put("dataKey", dataKey);
				List<Map> listDataLog = getOperatorLogService().getDataLogByMap(paramMap);
				if(null != listDataLog && listDataLog.size()>0){
					Object orgData = listDataLog.get(0).get("DATA_LOG");
					String orgStringData = getStringDataLog(orgData);
					addListRecords(allRecordsMap,orgStringData,oridata);
				}
				Object dataLog = maprec.get("DATA_LOG");//当前数据
				String otherdataLog = getStringDataLog(dataLog);
				addListRecords(allRecordsMap,otherdataLog,nowdata);
			}
		}
		List<Map<String,String>> finalTableList = getFinalTableList(allRecordsMap,mapColName); 
		showdata = getShowHtmlData(mapColName,finalTableList);
		return showdata;
	}
	private List<Map<String, String>> getFinalTableList(List<Map> allRecordsMap,Map<String,String> mapColName) {
		List<Map<String,String>> finalTableList = new ArrayList<Map<String,String>>();//最终表格展现记录
		if(allRecordsMap .size() > 0){
			for(Map recores : allRecordsMap){
				Map<String,String>  finalTableRes = new LinkedHashMap<String,String>();
				finalTableRes.put("mawl_head", String.valueOf(recores.get("mawl_type")));
				for(Map.Entry<String, String> colum : mapColName.entrySet()){
					String key = colum.getKey().toUpperCase();
					String value = null !=recores.get(key)?String.valueOf(recores.get(key)):"";
					finalTableRes.put(key, value);
				}
				finalTableList.add(finalTableRes);
			}
		}
		return finalTableList;
	}
	private void addListRecords(List<Map> allRecordsMap, String otherdataLog,String oridata) {
		if(null != otherdataLog && !"".equals(otherdataLog) && !"null".equals(otherdataLog)){
			JSONObject data = JSONObject.fromObject(otherdataLog);
			Map<String,String> map = new HashMap<String,String>();//实例操作列名Map集合
			map.put("mawl_type", oridata);
			Iterator<String> it = data.keys();
			while(it.hasNext()){
				String key = it.next();
				String value =  data.getString(key);
				map.put(key.toUpperCase(), value);
			}
			allRecordsMap.add(map);
		}
	}
	/**
	 * 表格数据组装
	 * @param mapColName
	 * @param finalTableList
	 * @return
	 */
	private String getShowHtmlData(Map<String, String> mapColName,
			List<Map<String, String>> finalTableList) {
		StringBuffer sb = new StringBuffer("");
		String width = 200*mapColName.size()  +"px";
		sb.append("<table style='overflow:auto;width:+"+width+";'><tr align='center'>");
		sb.append("<td width='200px' style='border:1px solid #A3A7AC;'></td>");
		for(Map.Entry<String, String> entry : mapColName.entrySet()){
			String column = entry.getKey();
			sb.append("<td width='200px' style='border:1px solid #A3A7AC;'><b>"+column+"</b></td>");
		}
		sb.append("</tr>");
        for(Map<String,String> mapTd : finalTableList){
        	sb.append("<tr align='center'>");
			sb.append("<td style='border:1px solid #A3A7AC;'><b>"+mapTd.get("mawl_head")+"</b></td>");
			for(Map.Entry<String, String> entry : mapTd.entrySet()){
				String key = entry.getKey();
				if(!"mawl_head".equals(key)){
					sb.append("<td>"+entry.getValue()+"</td>");
				}
			}
			sb.append("</tr>");
		}
		sb.append("</table>");
		return sb.toString();
	}
	/**
	 * 将clob等数据类型的数据转成String
	 * @param orgData
	 * @return
	 */
	private String getStringDataLog(Object orgData){
		String orgStringData = "";
		if (orgData instanceof CLOB) {
			Reader is = null;
			BufferedReader br = null;
			try {
				is = ((CLOB) orgData).getCharacterStream();
				br = new BufferedReader(is);
				String s = br.readLine();
				StringBuffer sb = new StringBuffer();
				while (s != null) {
					sb.append(s);
					s = br.readLine();
				}
				orgStringData = sb.toString();
			} catch (SQLException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			} catch (IOException e){
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}finally{
				if(null != br){
					try {
						br.close();
					} catch (IOException e) {
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
					}
				}
				if(null != is){
					try {
						is.close();
					} catch (IOException e) {
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
					}
				}
			}
		}else{
			orgStringData = String.valueOf(orgData);
		}
		return orgStringData;
	}
	/**
	 * 操作类型转换
	 * @param optType
	 * @return
	 */
	private String shuitValule(String optType) {
		if(null != optType && !"".equals(optType)){
			if("I".equals(optType)){
				return this.getText("eaap.op2.conf.logaudit.typeinsert");
			}else if("U".equals(optType)){
				return this.getText("eaap.op2.conf.logaudit.typeupdate");
			}else if("D".equals(optType)){
				return this.getText("eaap.op2.conf.logaudit.typedelete");
			}else if("Q".equals(optType)){
				return this.getText("eaap.op2.conf.logaudit.typequery");
			}
		}
		return null;
	}
	/**
	 * 首页表格数据刷新
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	public Map showOptLogGrid(Map param){
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("username", "".equals(getRequest().getParameter("username"))?null:getRequest().getParameter("username")) ;
		 map.put("optType", "".equals(getRequest().getParameter("optType"))?null:getRequest().getParameter("optType")) ;
		 map.put("optTable", "".equals(getRequest().getParameter("optTable"))?null:getRequest().getParameter("optTable")) ;
		 String startTime = getRequest().getParameter("startTime");
		 if(null != startTime && !"".equals(startTime)){
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
			 try {
				long millionSeconds = sdf.parse(startTime).getTime();
				startTime = millionSeconds+"";
			} catch (ParseException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		 }else {
			 startTime = null;
		 }
		 map.put("startTime", startTime);
		 String endTime = getRequest().getParameter("endTime");
		 if(null != endTime && !"".equals(endTime)){
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   
			 try {
				long millionSeconds = sdf.parse(endTime).getTime();
				endTime = millionSeconds+"";
			} catch (ParseException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}
		 }else {
			 endTime = null;
		 }
		 map.put("endTime", endTime);
	     total=getOperatorLogService().countOptLogList(map);
	     map.put("startPage", startRow);
	     map.put("endPage", startRow + rows - 1);

	     map.put("startPage_mysql", startRow - 1);
	     map.put("endPage_mysql", rows);
         List<Map> testMsgModList =getOperatorLogService().queryOptLogList(map) ;
         List<Map> pageList =new ArrayList<Map>();
         for(Map mapList : testMsgModList){
        	Map<String,String> pageMap = new HashMap<String,String>();
        	Iterator it = mapList.keySet().iterator();
        	while(it.hasNext()){
        		String key = String.valueOf(it.next());
        		String value = null != mapList.get(key)?String.valueOf(mapList.get(key)):"";
        		if("CREATE_DATE".equals(key)){
        			long abc = Long.valueOf(value);
        			value = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(abc));
        		}
        		pageMap.put(key, value);
        	}
        	pageList.add(pageMap);
         }
		  Map returnMap = new HashMap();
	      returnMap.put("startRow", startRow);
		  returnMap.put("rows", rows); 	
		  returnMap.put("total", total);
		  returnMap.put("dataList", page.convertJson(pageList));
		  return returnMap ;
	}
	public IOperatorLogService getOperatorLogService() {
		if (operatorLogService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			operatorLogService = (IOperatorLogService) ctx
					.getBean("eaap-op2-conf-operatorlog-OperatorLogService");
		}
		return operatorLogService;
	}
	public void setOperatorLogService(IOperatorLogService operatorLogService) {
		this.operatorLogService = operatorLogService;
	}
	public List<Map<String, Object>> getOptType() {
		return optType;
	}
	public void setOptType(List<Map<String, Object>> optType) {
		this.optType = optType;
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
	public Pagination getPage() {
		return page;
	}
	public void setPage(Pagination page) {
		this.page = page;
	}
	public Pagination getPagination() {
		return pagination;
	}
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public PageLogModel getPageModel() {
		return pageModel;
	}
	public void setPageModel(PageLogModel pageModel) {
		this.pageModel = pageModel;
	}

}
