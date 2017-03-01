package com.ailk.eaap.op2.conf.messageFlow.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.cache.ICacheFactory;
import com.ailk.eaap.op2.bo.CacheStrategy;
import com.ailk.eaap.op2.bo.MessageFlow;
import com.ailk.eaap.op2.bo.PageModel;
import com.ailk.eaap.op2.conf.messageFlow.service.IMessageFlowSer;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

import net.sf.json.JSONArray;

public class MessageFlowAction extends BaseAction {

		private static final long serialVersionUID = 1L;
		private static final Log log = LogFactory.getLog(MessageFlowAction.class);
		private IMessageFlowSer messageFlowServ;
		private ICacheFactory<String, Object>  cacheFactory;
		private MessageFlow messageFlow = new MessageFlow();
		
		private int rows;
		private int pageNum;
		private int total;
		private Pagination page=new Pagination();
		private Pagination pagination = new Pagination();
		
		private String attrName;
		private String objectId;
		private String endpoint_Spec_Attr_Id;
		private String messageFlowId;
		private String pageState;
		private String newState;
		private String attrSpecCode;
		private List<Map<String,String>> listYN = new ArrayList<Map<String,String>>();
		private List<Map<String,String>> listType = new ArrayList<Map<String,String>>();
		private List<Map<String,String>> listEncode = new ArrayList<Map<String,String>>();
		private TemplateModel templateModel;
		private String template_id;
		private Map map;
		
		//
		private String serTechImplId;// 服务技术实现ID
		private List<HashMap> techImplMessageModel;
		private AttrSpecModel attrSpecModel;
		private List<HashMap> listAttrSpec;
		private String orgName;
		private String comName;
		private String techImplName;
		private String commProName;
		private Map strategyMap=new HashMap();
		
		
	

		public ICacheFactory<String, Object> getCacheFactory() {
			return cacheFactory;
		}

		public void setCacheFactory(ICacheFactory<String, Object> cacheFactory) {
			this.cacheFactory = cacheFactory;
		}

		public Map getStrategyMap() {
			return strategyMap;
		}

		public void setStrategyMap(Map strategyMap) {
			this.strategyMap = strategyMap;
		}

		public String getSerTechImplId() {
			return serTechImplId;
		}

		public void setSerTechImplId(String serTechImplId) {
			this.serTechImplId = serTechImplId;
		}

		public List<HashMap> getTechImplMessageModel() {
			return techImplMessageModel;
		}

		public void setTechImplMessageModel(List<HashMap> techImplMessageModel) {
			this.techImplMessageModel = techImplMessageModel;
		}

		public AttrSpecModel getAttrSpecModel() {
			return attrSpecModel;
		}

		public void setAttrSpecModel(AttrSpecModel attrSpecModel) {
			this.attrSpecModel = attrSpecModel;
		}

		public List<HashMap> getListAttrSpec() {
			return listAttrSpec;
		}

		public void setListAttrSpec(List<HashMap> listAttrSpec) {
			this.listAttrSpec = listAttrSpec;
		}

		public String getOrgName() {
			return orgName;
		}

		public void setOrgName(String orgName) {
			this.orgName = orgName;
		}

		public String getComName() {
			return comName;
		}

		public void setComName(String comName) {
			this.comName = comName;
		}

		public String getTechImplName() {
			return techImplName;
		}

		public void setTechImplName(String techImplName) {
			this.techImplName = techImplName;
		}

		public String getCommProName() {
			return commProName;
		}

		public void setCommProName(String commProName) {
			this.commProName = commProName;
		}

		public String showMessageFlow(){
			
			return SUCCESS;
		}
		
		public Map getMessageFlowList(Map para){
			 rows = pagination.getRows();
			 pageNum = pagination.getPage();
			 int startRow;
			 startRow = (pageNum - 1) * rows + 1;

			 Map map = new HashMap() ;
			 map.put("messageFlowName", "".equals(getRequest().getParameter("messageFlowName"))?null:getRequest().getParameter("messageFlowName")) ;

			 map.put("queryType", "ALLNUM") ;
		     total=Integer.valueOf(String.valueOf(getMessageFlowServ().getMessageFlowList(map).get(0).get("ALLNUM"))) ;
		     map.put("queryType", "") ;
		     map.put("pro", startRow);
	         map.put("end", startRow+rows-1);
	         map.put("pro_mysql", startRow - 1);
	         map.put("page_record", rows);
	         List<Map> testMsgModList =getMessageFlowServ().getMessageFlowList(map) ;

			  Map returnMap = new HashMap();
		      returnMap.put("startRow", startRow);
			  returnMap.put("rows", rows); 	
			  returnMap.put("total", total);
			  returnMap.put("dataList", page.convertJson(testMsgModList));

			  return returnMap ;
		}
   /**
    * 跳到CVS模板选择页面
    * @return
    */
	public String gotoCvsFileList(){
		return SUCCESS;
	}
	/**
	 * 得到模板表格数据
	 * @return
	 */
	public Map  getCvsTempleteList(Map para){
		// 分页条件设置
				rows = pagination.getRows();
				pageNum = pagination.getPage();
				int startRow;
				startRow = (pageNum - 1) * rows + 1;

				Map tem = new HashMap();
				tem.put("startPage", startRow);
				tem.put("endPage", startRow + rows - 1);

				tem.put("startPage_mysql", startRow - 1);
				tem.put("endPage_mysql", rows);
				String cvsFileName = getRequest().getParameter("cvsFileName");
				if(StringUtils.isNotEmpty(cvsFileName)){
					tem.put("cvsFileName", cvsFileName);
				}
				String num  =  this.getMessageFlowServ().queryAllTempletCount(tem);
				total = Integer.parseInt(num);
				List<Map>templeteList = this.getMessageFlowServ().getAllTempleteList(tem);

				Map pageMap = new HashMap();// 页面返回集合
				pageMap.put("startRow", startRow);
				pageMap.put("rows", rows);
				pageMap.put("total", total);
				pageMap.put("dataList", pagination.convertJson(templeteList));
				return pageMap;
	}
	/**
	 *跳转到CSV模板添加页面
	 * @return
	 */
	public String gotoAddPage(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Y");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "N");
		listYN.add(n);
		Map<String, String> type1 = new HashMap<String, String>();
		type1.put("key", "1");
		type1.put("value", "FIELD_NAME");
		listType.add(type1);
		Map<String, String> type2 = new HashMap<String, String>();
		type2.put("key", "2");
		type2.put("value", "ALL_COUNT");
		listType.add(type2);
		Map<String, String> encode = new HashMap<String, String>();
		encode.put("key", "ISO-8859-1");
		encode.put("value", "ISO-8859-1");
		listEncode.add(encode);
		return SUCCESS;
	}
	/**
	 * 跳转到修改页面
	 * @return
	 */
	public String updateTemplate(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Y");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "N");
		listYN.add(n);
		Map<String, String> type1 = new HashMap<String, String>();
		type1.put("key", "1");
		type1.put("value", "FIELD_NAME");
		listType.add(type1);
		Map<String, String> type2 = new HashMap<String, String>();
		type2.put("key", "2");
		type2.put("value", "ALL_COUNT");
		listType.add(type2);
		Map<String, String> encode = new HashMap<String, String>();
		encode.put("key", "ISO-8859-1");
		encode.put("value", "ISO-8859-1");
		listEncode.add(encode);
		map = this.getMessageFlowServ().getTemplateById(template_id);
		return SUCCESS;
	}
	/**
	 * 添加提交操作
	 * @return
	 */
	public String addSubmit(){
		String templateId = this.getMessageFlowServ().queryTempletId();
		templateModel.setCsv_template_id(templateId);
		this.getMessageFlowServ().addTemplate(templateModel);
		return SUCCESS;
	}
	/**
	 * 修改提交操作
	 * @return
	 */
	public String updateSubmit(){
		this.getMessageFlowServ().updateTemplate(templateModel);
		return SUCCESS;
	}
	/**
	 * 删除记录
	 */
	@SuppressWarnings("resource")
	public void delTemplate(){
		PrintWriter pw = null;
		try{
			if(null != template_id && !"".equals(template_id)){
				this.getMessageFlowServ().delTemplate(template_id);
				pw = getResponse().getWriter();
				pw.write("ok");
				pw.flush();
			}
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				pw.write("fail");
				pw.flush();
			} catch (IOException e1) {;
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
	}
	
	/**
	 * 查看服务技术实现相关信息
	 * 
	 * @return
	 */
	public String showTechImpl() {
		/*HttpSession session = ServletActionContext.getRequest().getSession();
		String tenantIdCookieSessionName = CommonUtil.getValueByProCode("user_tenant_id");		//从公共配置文件eaap_common.properties取
		String tenantId ="";
		if(session.getAttribute(tenantIdCookieSessionName) != null){					
			tenantId = session.getAttribute(tenantIdCookieSessionName).toString();
		}*/
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		String commCd = null;
		try{
		techImplMessageModel = this.getMessageFlowServ().getTechImplMessageById(serTechImplId);
		if(null != techImplMessageModel && techImplMessageModel.size()>0){
			commCd = techImplMessageModel.get(0).get("COMMPROCD")+"";
			orgName = techImplMessageModel.get(0).get("ORGNAME")+"";
			comName = techImplMessageModel.get(0).get("COMNAME")+"";
			techImplName = techImplMessageModel.get(0).get("TECHIMPLNAME")+"";
			commProName = techImplMessageModel.get(0).get("COMMPRONAME")+"";
		}
		 
		if(null != commCd){
			listAttrSpec = this.getMessageFlowServ().getAttrSpecList(serTechImplId,commCd,tenantId.toString());
		}
		}catch (Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}

	/**
	 * 查看流量控制策略信息
	 * 
	 * @return
	 */
	public Map getCC2CList(Map map) {
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		String serTechImplId1 = map.get("queryParamsData").toString();// 服务技术实现ID
		total = this.getMessageFlowServ().getAllTechImplRecordsById(serTechImplId1);
		
		Map param = new HashMap();
		param.put("startPage", startRow);
		param.put("endPage", startRow + rows - 1);

		param.put("startPage_mysql", startRow - 1);
		param.put("endPage_mysql", rows);
		param.put("serTechImplId", serTechImplId1);
		List<HashMap> tmpList = this.getMessageFlowServ().getTechImplList(param);
		HashMap returnMap = new HashMap();
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows);
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(tmpList));
		return returnMap;
	}
	public IMessageFlowSer getMessageFlowServ() {
		if (messageFlowServ == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			messageFlowServ = (IMessageFlowSer) ctx
					.getBean("eaap-op2-conf-messageFlow-messageFlowServ");
		}
		return messageFlowServ;
	}

	public void setMessageFlowServ(IMessageFlowSer messageFlowServ) {
		this.messageFlowServ = messageFlowServ;
	}

	public MessageFlow getMessageFlow() {
		return messageFlow;
	}

	public void setMessageFlow(MessageFlow messageFlow) {
		this.messageFlow = messageFlow;
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

	public String getAttrName() {
		return attrName;
	}

	public void setAttrName(String attrName) {
		this.attrName = attrName;
	}

	public String getObjectId() {
		return objectId;
	}

	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	public String getEndpoint_Spec_Attr_Id() {
		return endpoint_Spec_Attr_Id;
	}

	public void setEndpoint_Spec_Attr_Id(String endpoint_Spec_Attr_Id) {
		this.endpoint_Spec_Attr_Id = endpoint_Spec_Attr_Id;
	}

	public String getMessageFlowId() {
		return messageFlowId;
	}

	public void setMessageFlowId(String messageFlowId) {
		this.messageFlowId = messageFlowId;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public List<Map<String, String>> getListYN() {
		return listYN;
	}

	public void setListYN(List<Map<String, String>> listYN) {
		this.listYN = listYN;
	}

	public List<Map<String, String>> getListType() {
		return listType;
	}

	public void setListType(List<Map<String, String>> listType) {
		this.listType = listType;
	}

	public List<Map<String, String>> getListEncode() {
		return listEncode;
	}

	public void setListEncode(List<Map<String, String>> listEncode) {
		this.listEncode = listEncode;
	}

	public TemplateModel getTemplateModel() {
		return templateModel;
	}

	public void setTemplateModel(TemplateModel templateModel) {
		this.templateModel = templateModel;
	}

	public String getTemplate_id() {
		return template_id;
	}

	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}

	public Map getMap() {
		return map;
	}

	public void setMap(Map map) {
		this.map = map;
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
		 	
	/**
    * 跳到缓存策略页面
    * @return
    */
	public String gotoCacheStragyList(){
		return SUCCESS;
	}
	public String gotoDetail(){
		return SUCCESS;
	}
	
	
	
	/**
	 * 删除记录
	 */
	@SuppressWarnings("resource")
	public void delStrategy(){
		PrintWriter pw = null;
		try{
			String strategy_id = getRequest().getParameter("strategy_id");
			if(null != strategy_id && !"".equals(strategy_id)){
				this.getMessageFlowServ().delCacheStrategyById(strategy_id);
				pw = getResponse().getWriter();
				pw.write("ok");
				pw.flush();
			}
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				pw.write("fail");
				pw.flush();
			} catch (IOException e1) {;
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
	}
	
	public String gotoAddStrategyPage(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Y");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "N");
		listYN.add(n);
		Map<String, String> type1 = new HashMap<String, String>();
		type1.put("key", "1");
		type1.put("value", "FIELD_NAME");
		listType.add(type1);
		Map<String, String> type2 = new HashMap<String, String>();
		type2.put("key", "2");
		type2.put("value", "ALL_COUNT");
		listType.add(type2);
		Map<String, String> encode = new HashMap<String, String>();
		encode.put("key", "ISO-8859-1");
		encode.put("value", "ISO-8859-1");
		listEncode.add(encode);
		return SUCCESS;
	}
	public String saveCacheStrategy() {
		PrintWriter pw = null;
		try{
			String strategyJson = getRequest().getParameter("strategyJson");
			String newState=getRequest().getParameter("newState");
			if("new".equals(newState)){//新增
//				GsonBuilderUtils gsonBuilderUtils=new GsonBuilderUtils() {
//				};
//				messageFlowServ.addTemplate(templateModel);
			}else{						//修改
				
			}
			if(StringUtils.isNotBlank(strategyJson)){
//				JSONObject cacheStrategyObj = new JSONObject(strategyJson);
//				CacheStrategy cacheStrategy=new CacheStrategy();
//				cacheStrategy.setId((Integer) cacheStrategyObj.get("ID"));
//				cacheStrategy.setCacheType((String) cacheStrategyObj.get("cacheType"));
//				cacheStrategy.setCode(code);
//				messageFlowServ.save(cacheStrategyObj);
			}
			return SUCCESS;
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				pw.write("fail:"+e.getMessage());
				pw.flush();
			} catch (IOException e1) {;
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
		return ERROR;
	}
	
	/**
	 * 跳转到修改页面
	 * @return
	 */
	public String updateStrategyPage(){
		Map<String, String> y = new HashMap<String, String>();
		y.put("key", "Y");
		y.put("value", "Y");
		listYN.add(y);
		Map<String, String> n = new HashMap<String, String>();
		n.put("key", "N");
		n.put("value", "N");
		listYN.add(n);
		Map<String, String> type1 = new HashMap<String, String>();
		type1.put("key", "1");
		type1.put("value", "FIELD_NAME");
		listType.add(type1);
		Map<String, String> type2 = new HashMap<String, String>();
		type2.put("key", "2");
		type2.put("value", "ALL_COUNT");
		listType.add(type2);
		Map<String, String> encode = new HashMap<String, String>();
		encode.put("key", "ISO-8859-1");
		encode.put("value", "ISO-8859-1");
		listEncode.add(encode);
		String strategy_id = getRequest().getParameter("strategy_id");
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		Map map = new HashMap();
		map.put("strategyId", strategy_id);
		map.put("tenantId", tenantId.toString());
		strategyMap = this.getMessageFlowServ().getStrategyById(map);
		return SUCCESS;
	}
	
	
	/**
	 * 得到缓存策略数据
	 * @return
	 */
	public Map  getCacheStragyList(Map para){
		// 分页条件设置
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;
		Map tem = new HashMap();
		tem.put("startPage", startRow);
		tem.put("endPage", startRow + rows - 1);
		tem.put("startPage_mysql", startRow - 1);
		tem.put("endPage_mysql", rows);
		String cacheStrategyName = getRequest().getParameter("cacheStrategyName");
		if(StringUtils.isNotEmpty(cacheStrategyName)){
			tem.put("cacheStrategyName", cacheStrategyName);
		}
		String num  =  this.getMessageFlowServ().queryAllCacheStragyCount(tem);
		total = Integer.parseInt(num);
		List<Map> cacheStragyList = this.getMessageFlowServ().queryAllCacheStragyList(tem);
		Map pageMap = new HashMap();// 页面返回集合
		pageMap.put("startRow", startRow);
		pageMap.put("rows", rows);
		pageMap.put("total", total);
		pageMap.put("dataList", pagination.convertJson(cacheStragyList));
		return pageMap;
	}
	
	public String getCacheStrategyById(){
		String cacheStrategyId= getRequest().getParameter("ID");
		//String tenantId= getRequest().getParameter("TENANT_ID");
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		
		Map map = new HashMap();
		map.put("strategyId", cacheStrategyId);
		map.put("tenantId", tenantId.toString());
		
		Map cacheStrategyMap=this.getMessageFlowServ().getCacheStrategyById(map);
		
		net.sf.json.JSONObject jsonObject=new net.sf.json.JSONObject();
		try {
			Writer wr = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			wr.write(jsonObject.fromObject(cacheStrategyMap).toString());
			wr.close();
		} catch (IOException e) {
			log.error("getCacheStrategyById error：", e);
		}
		return null;
		
	}
	public String getCacheStrategyList(){
		String start =getRequest().getParameter("start");			//第几页
		String limit =getRequest().getParameter("length");			//查询多少条数据
		String cacheStrategyName =getRequest().getParameter("NAME");			//查询多少条数据
		//String tenantId =getRequest().getParameter("TENANT_ID");			//多租户
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId =CommonUtil.getTenantId(session);
		
		PageModel pageModel=new PageModel();
		List<Map> cacheStrategyList=this.getMessageFlowServ().getCacheStrategyList(start,limit,cacheStrategyName,tenantId.toString());
		Object num  =  this.getMessageFlowServ().getCacheStrategyListSize(cacheStrategyName,tenantId.toString());
		pageModel.setData(cacheStrategyList);
		pageModel.setTotalSize(num);
		pageModel.setRecordsFiltered(num);
		net.sf.json.JSONObject jsonObject=new net.sf.json.JSONObject();
		try {
			Writer wr = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			wr.write(jsonObject.fromObject(pageModel).toString());
			wr.close();
		} catch (IOException e) {
			log.error("getCacheStrategyList error：", e);
		}
		return null;
	}
	
	//delCacheStrategyById
	public void delCacheStrategyById(){
		String cacheStrategyId=getRequest().getParameter("ID");	
		this.getMessageFlowServ().delCacheStrategyById(cacheStrategyId);
		PrintWriter pw = null;
		try{
			pw = getResponse().getWriter();
			pw.write("SUCCESS");
			pw.flush();
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				getResponse().setContentType("text/plain;charset=utf-8");
				pw.write("FAIL");
				pw.flush();
			} catch (IOException e1) {
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
	}
	
	//updateCacheStrategy
	public void updateCacheStrategy(){
	
		CacheStrategy cacheStrategy=new CacheStrategy();
		cacheStrategy.setId(Integer.parseInt(getRequest().getParameter("ID")));
		cacheStrategy.setName(getRequest().getParameter("NAME"));
		cacheStrategy.setCacheType(getRequest().getParameter("CACHE_TYPE"));
		cacheStrategy.setForceRefresh(getRequest().getParameter("FORCE_REFRESH"));
		cacheStrategy.setExpireTime(Integer.parseInt(getRequest().getParameter("EXPIRE_TIME")));
		cacheStrategy.setExpireTimePath(getRequest().getParameter("EXPIRE_TIME_PATH"));
		JSONArray jsonArray=new JSONArray();
		JSONArray cacheObjList= jsonArray.fromObject(getRequest().getParameter("cacheObjs"));
		cacheStrategy.setCacheObjs(cacheObjList);
		strategyMap = this.getMessageFlowServ().updateCacheStrategy(cacheStrategy);
	
		PrintWriter pw = null;
		try{
			pw = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			pw.write("SUCCESS");
			pw.flush();
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				getResponse().setContentType("text/plain;charset=utf-8");
				pw.write("FAIL");
				pw.flush();
			} catch (IOException e1) {;
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
	
	}
	public void addCacheStrategy(){
		
		CacheStrategy cacheStrategy=new CacheStrategy();
		cacheStrategy.setName(getRequest().getParameter("NAME"));
		cacheStrategy.setCode(UUID.randomUUID().toString());
		cacheStrategy.setCacheType(getRequest().getParameter("CACHE_TYPE"));
		cacheStrategy.setForceRefresh(getRequest().getParameter("FORCE_REFRESH"));
		cacheStrategy.setExpireTime(Integer.parseInt(getRequest().getParameter("EXPIRE_TIME")));
		cacheStrategy.setExpireTimePath(getRequest().getParameter("EXPIRE_TIME_PATH"));
		if(StringUtils.isNotBlank(getRequest().getParameter("TENANT_ID"))){
			cacheStrategy.setTenantId(Integer.parseInt(getRequest().getParameter("TENANT_ID")));
		}
		JSONArray jsonArray=new JSONArray();
		JSONArray cacheObjList= jsonArray.fromObject(getRequest().getParameter("cacheObjs"));
		cacheStrategy.setCacheObjs(cacheObjList);
		strategyMap = this.getMessageFlowServ().addCacheStrategy(cacheStrategy);
		
		
		PrintWriter pw = null;
		try{
			pw = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			pw.write("SUCCESS");
			pw.flush();
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				getResponse().setContentType("text/plain;charset=utf-8");
				pw.write("FAIL");
				pw.flush();
			} catch (IOException e1) {;
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
		
	}
	public void checkCacheKeyIsExist(){
		String cacheKey=getRequest().getParameter("cacheKey");	
		log.debug("cacheKey:"+cacheKey);
		cacheFactory.getCacheClient().put("xiaoyuan2008", "xiaoyuan2008value");
		cacheFactory.getCacheClient().get("xiaoyuan2008");
//		Object obj=cacheFactory.getCacheClient().get(cacheKey);
		Object count= this.getMessageFlowServ().checkCacheKeyIsExist(cacheKey);
		PrintWriter pw = null;
		try{
			if(count!=null&&Integer.parseInt(count.toString())>0){
				pw = getResponse().getWriter();
				pw.write("EXIST");
				pw.flush();
			}else{
				pw = getResponse().getWriter();
				getResponse().setContentType("text/plain;charset=utf-8");
				pw.write("NOT EXIST");
				pw.flush();
			}
			
		}catch (Exception e){
			try {
				pw = getResponse().getWriter();
				getResponse().setContentType("text/plain;charset=utf-8");
				pw.write("NOT EXIST");
				pw.flush();
			} catch (IOException e1) {
			}
		}finally{
			if(null !=  pw){
				pw.close();
			}
		}
	}
}
