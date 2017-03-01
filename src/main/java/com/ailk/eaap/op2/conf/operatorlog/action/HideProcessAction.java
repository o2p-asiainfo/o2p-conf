package com.ailk.eaap.op2.conf.operatorlog.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.conf.operatorlog.service.IOperatorLogService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
/**
 * 模糊规则配置类
 * @author MAWL
 *
 */
public class HideProcessAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private IOperatorLogService operatorLogService;
	private List<Map<String,Object>> type = new ArrayList<Map<String,Object>>();
	private FuzzyModel fuzzyModel;
	private String fuzzyId;
	private String rowIndex;
	private String reqRspFlag;
	
	private int rows;
	private int pageNum;
	private int total;
	private Pagination page=new Pagination();
	private Pagination pagination = new Pagination();
	
	public String showhideProcess(){
		Map<String, Object> fuzzy = new HashMap<String, Object>();
		fuzzy.put("id", "1");
		fuzzy.put("val", getText("eaap.op2.conf.process.typefuzzy"));
		type.add(fuzzy);
		Map<String, Object> encryption = new HashMap<String, Object>();
		encryption.put("id", "2");
		encryption.put("val", getText("eaap.op2.conf.process.typeencryption"));
		type.add(encryption);
		Map<String, Object> fuzzyEncryption = new HashMap<String, Object>();
		fuzzyEncryption.put("id", "3");
		fuzzyEncryption.put("val", getText("eaap.op2.conf.process.fuzzyEncryption"));
		type.add(fuzzyEncryption);
		return SUCCESS;
	}
	
	public String addHideProcess(){
		Map<String, Object> fuzzy = new HashMap<String, Object>();
		fuzzy.put("id", "1");
		fuzzy.put("val", getText("eaap.op2.conf.process.typefuzzy"));
		type.add(fuzzy);
		Map<String, Object> encryption = new HashMap<String, Object>();
		encryption.put("id", "2");
		encryption.put("val", getText("eaap.op2.conf.process.typeencryption"));
		type.add(encryption);
		Map<String, Object> fuzzyEncryption = new HashMap<String, Object>();
		fuzzyEncryption.put("id", "3");
		fuzzyEncryption.put("val", getText("eaap.op2.conf.process.fuzzyEncryption"));
		type.add(fuzzyEncryption);
		return SUCCESS;
	}
	
	public String addhideProcess(){
		String nextPriId = getOperatorLogService().queryNextPriId();
		if(null != nextPriId && !"".equals(nextPriId)){
			fuzzyModel.setFuzzyId(nextPriId);
			if("2".equals(fuzzyModel.getFuzzyType())){
				fuzzyModel.setFuzzyStart("0");
				fuzzyModel.setFuzzyEnd("0");
			}
			getOperatorLogService().addHideRrocess(fuzzyModel);
		}
		return SUCCESS;
	}
	
	public void delHideProcess(){
		PrintWriter out = null;
		try {
			Map map = new HashMap();
			map.put("fuzzyId", fuzzyId);
			this.getOperatorLogService().delHideProcess(map);
			out = getResponse().getWriter();
			getResponse().setContentType("text/html;charset=UTF-8");
			String xx = "ok";
			out.print(xx);
		} catch (IOException e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				String xx = "fail";
				out.print(xx);
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	
	public String updateHideProcess(){
		Map<String, Object> fuzzy = new HashMap<String, Object>();
		fuzzy.put("id", "1");
		fuzzy.put("val", getText("eaap.op2.conf.process.typefuzzy"));
		type.add(fuzzy);
		Map<String, Object> encryption = new HashMap<String, Object>();
		encryption.put("id", "2");
		encryption.put("val", getText("eaap.op2.conf.process.typeencryption"));
		type.add(encryption);
		Map<String, Object> fuzzyEncryption = new HashMap<String, Object>();
		fuzzyEncryption.put("id", "3");
		fuzzyEncryption.put("val", getText("eaap.op2.conf.process.fuzzyEncryption"));
		type.add(fuzzyEncryption);
		return SUCCESS;
	}
	
	public String updateSubmitProcess(){
		getOperatorLogService().updateSubmitProcess(fuzzyModel);
		return SUCCESS;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map showProcessGrid(Map param){
		rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;

		 Map map = new HashMap() ;
		 map.put("fuzzyType", "".equals(getRequest().getParameter("fuzzyType"))?null:getRequest().getParameter("fuzzyType")) ;
		 map.put("fuzzySymbols", "".equals(getRequest().getParameter("fuzzySymbols"))?null:getRequest().getParameter("fuzzySymbols")) ;
		 map.put("fuzzyStart", "".equals(getRequest().getParameter("fuzzyStart"))?null:getRequest().getParameter("fuzzyStart")) ;
		 map.put("fuzzyEnd", "".equals(getRequest().getParameter("fuzzyEnd"))?null:getRequest().getParameter("fuzzyEnd")) ;
	     total=getOperatorLogService().countFuzzyList(map);
	     map.put("startPage", startRow);
	     map.put("endPage", startRow + rows - 1);

	     map.put("startPage_mysql", startRow - 1);
	     map.put("endPage_mysql", rows);
        List<Map> testMsgModList =getOperatorLogService().queryFuzzyList(map) ;
       
		  Map returnMap = new HashMap();
	      returnMap.put("startRow", startRow);
		  returnMap.put("rows", rows); 	
		  returnMap.put("total", total);
		  returnMap.put("dataList", page.convertJson(testMsgModList));
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
	public List<Map<String, Object>> getType() {
		return type;
	}
	public void setType(List<Map<String, Object>> type) {
		this.type = type;
	}

	public FuzzyModel getFuzzyModel() {
		return fuzzyModel;
	}

	public void setFuzzyModel(FuzzyModel fuzzyModel) {
		this.fuzzyModel = fuzzyModel;
	}

	public String getFuzzyId() {
		return fuzzyId;
	}

	public void setFuzzyId(String fuzzyId) {
		this.fuzzyId = fuzzyId;
	}

	public String getRowIndex() {
		return rowIndex;
	}

	public void setRowIndex(String rowIndex) {
		this.rowIndex = rowIndex;
	}

	public String getReqRspFlag() {
		return reqRspFlag;
	}

	public void setReqRspFlag(String reqRspFlag) {
		this.reqRspFlag = reqRspFlag;
	}
}
