package com.ailk.eaap.op2.conf.serviceManager.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.List;
import java.util.HashMap;
import java.util.Properties;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.Api;
import com.ailk.eaap.op2.bo.Area;
import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.ControlCounterms;
import com.ailk.eaap.op2.bo.CtlCounterms2Tech;
import com.ailk.eaap.op2.bo.DirSerList;
import com.ailk.eaap.op2.bo.Func2Service;
import com.ailk.eaap.op2.bo.JsonData;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.ServiceAtt;
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.serviceManager.service.IServiceManagerServ;
import com.ailk.eaap.op2.conf.wsdlImport.service.IWsdlService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.StringUtil;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.conf.util.CommonUtil;

@SuppressWarnings("all")
public class ServiceManagerAction extends BaseAction{
	private Logger log = Logger.getLog(this.getClass());
	private int rows;
	private int page;
	private static final long serialVersionUID = 1L;
	private Service service = new Service();
	private BizFunction bizFun = new BizFunction();
	private Map serviceHashMap = new HashMap();
	private Map contractHashMap = new HashMap();
	private Contract contract = new Contract();
	private Pagination pagination = new Pagination();
	private List<Map> contractList = new ArrayList<Map>();
	private IServiceManagerServ serverManagerService;
	private IServiceManagerServ iServiceManagerServ;
	private List<Map> serviceList = new ArrayList<Map>();
	private List<Map> treeRootList = new ArrayList<Map>();
	private List<Map> treeNodeList = new ArrayList<Map>();
	private List<Map> dirSerList = new ArrayList<Map>();
	private List<Map<String,Object>> resultList = new ArrayList<Map<String,Object>>();
	private List<Map<String,Object>> serviceCategoryResultList = new ArrayList<Map<String,Object>>();
	private List<Map<String,Object>> defaultFlowResultList = new ArrayList<Map<String,Object>>();
	private List<Map<String,Object>> protocolVersionResultList = new ArrayList<Map<String,Object>>();
	private List<Map<String,Object>> commProtocalResultList = new ArrayList<Map<String,Object>>();
	private List<Map> defaultFlowList = new ArrayList<Map>();
	private List<Map> commProtocalList = new ArrayList<Map>();
	private Func2Service func2Service = new Func2Service();
	private DirSerList dirSer = new DirSerList();
	private Api api = new Api();
    private Map DirSeletedTreeMap = new HashMap();
    private Map FuncSeletedTreeMap = new HashMap();
    private Map switchMap = new HashMap();
    private List<DirSerList>  dirSerListOfList  = new ArrayList();
    private List<Func2Service>  func2ServiceList  = new ArrayList();
    private List<Map> techImplList = new ArrayList<Map>();
    private String serviceId="";
    private String serviceName=""; 
    private String serviceCode="";
    private String ServiceMsgFlowId ="";
    private String ServiceMsgFlowName ="";
    private Component component = new Component();
    private TechImpl techImpl = new TechImpl();
    private Org org = new Org();
    private List<Map> ccTypeList = new ArrayList<Map>() ;
	private List<Map> cycleTyleList = new ArrayList<Map>() ;
	private List<Map> cc2cStatelist = new ArrayList<Map>() ;
	private List<Map> cutmsValueTypelist = new ArrayList<Map>() ;
	private CtlCounterms2Tech ctlCounterms2Tech = new CtlCounterms2Tech();
	private ControlCounterms controlCouterms = new ControlCounterms();
	private SerTechImpl serTechImpl = new SerTechImpl();
	private String techImplId ="";
	private String techImplName ="";
	private String code ="";
	private String name ="";
	private String orgId="";
	private String serTechImplId ="";
	private String pageState ="";
	private String attrName="";
	private String objectId="";
	private String endpoint_Spec_Attr_Id="";
	private String newState;
	private String attrSpecCode;
	private String type = "";
	private String serviceAPI;
	private String attr_spec_id;
	Map serHashMap = new HashMap();
	private StringBuffer flowUrl=new StringBuffer();
	private List<Map> loadServiceMessgList =null;
	private String serviceFlag;
	private String pageShowMsg;
	private String serInvokeInsId;
	private String serInvokeInsName;
	private SerInvokeIns serInvokeIns;
	private String msgFlowUrl;
	
	public String showServiceManagerAndDirAndFunc(){
		return SUCCESS;
	}
	public String serviceRegister(){
		return SUCCESS;
	}
	//��ʾ����������Ҫ���
	public String showMainInfo(){
        Map hashMap1 = new HashMap();
        hashMap1.put("name", getText("eaap.op2.conf.server.manager.serviceEnable"));
        hashMap1.put("componentId", "A");
        Map hashMap2 = new HashMap();
        hashMap2.put("name", getText("eaap.op2.conf.server.manager.serviceDisable"));
        hashMap2.put("componentId", "N");
        resultList.add(hashMap1);
        resultList.add(hashMap2);
        msgFlowUrl = WebPropertyUtil.getPropertyValue("MESSAGE_FLOW_URL");
        return SUCCESS;
	}
    /**
     * ��ʾ�����ķ����б�
     */
	public Map showGrid(Map para){
		
		rows = pagination.getRows();
		page = pagination.getPage();
		String xxString= getRequest().getParameter(
		"dirTreeNode");
		int startRow;
		int total;
		String[] dirValue = null;
		String[] funcValue = null;
		String state = null;
		if(StringUtil.isEmpty(getRequest().getParameter("isInit"))){
			state = "A";
		}else{
			state = "".equals(getRequest().getParameter("state"))? null:getRequest().getParameter("state");
		}
		Map hashMap = new HashMap();
		if (StringUtils.isNotEmpty(getRequest().getParameter(
				"contractVersion"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"contractVersionId"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"serviceCnName"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"contractName"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"contractCode"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"serviceCode"))||StringUtils.isNotEmpty(state)
				||StringUtils.isNotEmpty(getRequest().getParameter(
				"Hidcx"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"Hidce"))) {
			if(getRequest().getParameter("Hidcx")!=null){
				dirValue = getRequest().getParameter("Hidcx").split(",");
			}else{
				dirValue = null;					
				}
			if(getRequest().getParameter("Hidce")!=null){
				funcValue = getRequest().getParameter("Hidce").split(",");					
			}else{
				funcValue = null;
				}

			String contractVersionId =  "".equals(getRequest().getParameter("contractVersionId"))? null:getRequest().getParameter("contractVersionId");
			String contractVersion =  "".equals(getRequest().getParameter("contractVersion"))? null:getRequest().getParameter("contractVersion");
			
			String serviceCnName = "".equals(getRequest().getParameter("serviceCnName"))? null:getRequest().getParameter("serviceCnName");
			String serviceCode = "".equals(getRequest().getParameter("serviceCode"))? null:getRequest().getParameter("serviceCode");
			String contractName = "".equals(getRequest().getParameter("contractName"))? null:getRequest().getParameter("contractName");
			String contractCode = "".equals(getRequest().getParameter("contractCode"))? null:getRequest().getParameter("contractCode");
			if (page == 1) {
				startRow = (page - 1) * rows + 1;
			} else {
				startRow = (page - 1) * rows + 1;
			}
			hashMap.put("startRow", startRow);
			hashMap.put("rows", rows);
			hashMap.put("pro_mysql", (page - 1) * rows);
			hashMap.put("page_record", rows);
			hashMap.put("contractVersionId", contractVersionId);
			hashMap.put("contractVersion", contractVersion);
			hashMap.put("state", state);
			hashMap.put("dirValue", dirValue);
			hashMap.put("funcValue", funcValue);
			hashMap.put("serviceCnName", serviceCnName);
			hashMap.put("serviceCode", serviceCode);		
			hashMap.put("contractName", contractName);		
			hashMap.put("contractCode", contractCode);		
			List<Map> serviceList = getServiceManagerServ().queryDirSerList(hashMap);
			hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryCountDirSerList(hashMap)));
			hashMap.put("dataList", pagination.convertJson(serviceList));
			return hashMap;
		} else {
			if (page == 1) {
				
				startRow = (page - 1) * rows + 1;
			} else {
				startRow = (page - 1) * rows + 1;
			}
			hashMap.put("startRow", startRow);
			hashMap.put("rows", rows);
			hashMap.put("pro_mysql", (page - 1) * rows);
			hashMap.put("page_record", rows);
			serviceList = getServiceManagerServ().queryService(hashMap);
			hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryGridCount()));
			hashMap.put("dataList", pagination.convertJson(serviceList));
			return hashMap;
		}
				
	}
	
	
	 /**
     * ��ʾ����ע��ķ����б�
     */
	public Map showServiceGrid(Map para){
		
		rows = pagination.getRows();
		page = pagination.getPage();
		int startRow;
		int total;
		Map hashMap = new HashMap();
		if (StringUtils.isNotEmpty(getRequest().getParameter(
				"dirTreeNode"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"workFlowTreeNode"))) {
			String dirTreeNode =  "".equals(getRequest().getParameter("dirTreeNode")) ? null:getRequest().getParameter("dirTreeNode");
			String workFlowTreeNode =  "".equals(getRequest().getParameter("workFlowTreeNode"))? null:getRequest().getParameter("workFlowTreeNode");
			startRow = (page - 1) * rows + 1;
			hashMap.put("startRow", startRow);
			hashMap.put("rows", rows);
			hashMap.put("pro_mysql", (page - 1) * rows);
			hashMap.put("page_record", rows);
			hashMap.put("dirTreeNode", dirTreeNode);
			hashMap.put("func2SerId", workFlowTreeNode);
			List<Service> serviceList = getServiceManagerServ().queryRegesiterSerList(hashMap);
			hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryCountRegesiterSerList(hashMap)));
			hashMap.put("dataList", pagination.convertJson(serviceList));
			return hashMap;
		} else {
			startRow = (page - 1) * rows + 1;
			hashMap.put("startRow", startRow);
			hashMap.put("rows", rows);
			hashMap.put("pro_mysql", (page - 1) * rows);
			hashMap.put("page_record", rows);
			List<Service> serviceList =  getServiceManagerServ().queryRegesiterSerListExcept(hashMap);
			hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryRegesiterSerListExceptCount(hashMap)));
			hashMap.put("dataList", pagination.convertJson(serviceList));
			return hashMap;
		}
				
	}
	
	public Map showList(Map para){
		
		int rows = Integer.parseInt(getRequest().getParameter("rows"));
		int page = Integer.parseInt(getRequest().getParameter("page"));
		int startRow ;
		Map hashMap = new HashMap();
		if(page==1){
			startRow = (page - 1) * rows+1;	
		}else {
			startRow = (page - 1) * rows+1;
	}			
		hashMap.put("startRow", startRow);
		hashMap.put("rows", rows);
		hashMap.put("pro_mysql", startRow - 1);
		hashMap.put("page_record", rows);
		List<Map> serviceList = serviceList =  getServiceManagerServ().queryService(hashMap);
		String previous = getRequest().getParameter("previous");
		hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryGridCount()));
		hashMap.put("dataList", serviceList);
		return hashMap;
	}
	
	/**
	 * ���ӷ���
	 */
	public void addServiceManager(){
		PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
			getResponse().setContentType("text/html;charset=UTF-8");
			out = getResponse().getWriter();
			String serviceSeqString = getServiceManagerServ().selectServiceSeq();
			service.setServiceId(Integer.parseInt(serviceSeqString));
			service.setCreateDate(new Date());
			service.setLastestDate(new Date());
			service.setIsPublished("1");
			getServiceManagerServ().insertServiceManager(service);
			out.print("ok");
		}  catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Adding service exceptions",null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}

	}
	/**
	 * �޸ķ���
	 */
    public void updateServiceManager(){
    	PrintWriter out =null;
    	try{
        service.setCreateDate(new Date());
		service.setLastestDate(new Date());
		service.setIsPublished("1");
		getServiceManagerServ().updateServiceManager(service);
		out = getResponse().getWriter();
		out.print("ok");
    	}catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Update service exceptions",null));
		}finally{			
			if (out != null) {
				out.flush();
				out.close();
			}
		}
    }
    /**
     * ɾ�����
     */
    public void deleteServiceManager(){
    	 PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	String deleteIDs = getRequest().getParameter("deleteIDs");
	    	service.setState("N");
	    	service.setServiceId(Integer.parseInt(deleteIDs));
	    	getServiceManagerServ().updateServiceManagerState(service);		
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String xx="[{\"msg\":\"ok\"}]";
			out.print(xx);
		}  catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete service exceptions",null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
    }
    /**
     * ��������
     */
    public void searchServiceManager(){
    	try {
    	getRequest().setCharacterEncoding("UTF-8");
 
    	Map ccHashMap = (Map) getRequest().getParameterMap();
    	String stateVal = getRequest().getParameter("stateVal");
    	String contractVersionId = getRequest().getParameter("data");
		int rows = Integer.parseInt(getRequest().getParameter("rows"));
		int page = Integer.parseInt(getRequest().getParameter("page"));
		int startRow ;
		Map hashMap = new HashMap();
		if(page==1){
			startRow = (page - 1) * rows+1;	
		}else {
			startRow = (page - 1) * rows+1;
		}			
		hashMap.put("startRow", startRow);
		hashMap.put("rows", rows);
		hashMap.put("pro_mysql", startRow - 1);
		hashMap.put("page_record", rows);
		hashMap.put("contractVersionId", contractVersionId);
		service.setContractVersionId(contractVersionId);
		List<Service> serviceList =  getServiceManagerServ().queryServiceChoice(hashMap);
		String previous = getRequest().getParameter("previous");
		    getResponse().setContentType("text/html;charset=UTF-8");	
			JsonData jsonData = new JsonData();			
			jsonData.setTotal(Integer.parseInt(getServiceManagerServ().queryGridCountChoice(service)));
			jsonData.setRows(serviceList);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			getResponse().getWriter().println(jsonObject);
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Searching service exceptions",null));
		}
		
    }
    /**
     * �Զ���ȫЭ��汾--��������ҳ��
     */
    public void showServiceManager(){

    	try {
    		String contractVersionId =	new String(getRequest().getParameter("productName").getBytes("iso8859-1"),"UTF-8");
    		service.setContractVersionId(contractVersionId);
        	List<Service> serviceList = getServiceManagerServ().queryService(service);
        	JSONArray jsonObject = JSONArray.fromObject(serviceList);
        	getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"View service exceptions",null));
		}
    	
    }
    /**
     * �Զ���ȫЭ��-��������ҳ��
     */
    public void showProtocol(){

    	try {
    		String protocolName =	new String(getRequest().getParameter("protocol"));
    		contract.setName(protocolName);
        	List<Contract> contractList = getServiceManagerServ().queryContract(contract);
        	JSONArray jsonObject = JSONArray.fromObject(contractList);
        	getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"View protocol exceptions",null));
		}
    	
    }
    /**
     * ������ʾ��ҳģ���ѯ
     */
    public void showServiceName(){
    	try {
    		String serviceCnName =	new String(getRequest().getParameter("serviceCnName"));
    		Service service = new Service();
    		service.setServiceCnName(serviceCnName);
        	List<Service> serviceList = getServiceManagerServ().queryServiceList(service);
        	JSONArray jsonObject = JSONArray.fromObject(serviceList);
        	getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"View service name exceptions",null));
		}
    	
    }
    /**
     * ������ʾ��ҳЭ��汾ģ���ѯ
     */
    public void queryContractVersionList(){
    	try {
    		String version  = new String(getRequest().getParameter("contractVersion"));
    		ContractVersion contractVersion = new ContractVersion();
    		contractVersion.setVersion(version);
        	List<ContractVersion> versionList = new ArrayList<ContractVersion>();
        	versionList = getServiceManagerServ().queryContractVersionList(contractVersion);
        	JSONArray jsonObject = JSONArray.fromObject(versionList);
        	getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Searching protocol version exceptions",null));
		}
    }
    /**
     * ��ʾ���е�Э��汾��Ϣ
     */
    public void showConstractInfor(){
		
		int startRow ;
		Map hashMap = new HashMap();
    	if(page==1){
			startRow = (page - 1) * rows+1;	
		}else {
			startRow = (page - 1) * rows+1;
		}			
		hashMap.put("startRow", startRow);
		hashMap.put("rows", rows);
		List<Map> serviceList = getServiceManagerServ().queryService(hashMap);
		String previous = getRequest().getParameter("previous");
		if ("true".equals(previous)) {
			page = page - 1;
		}
		getResponse().setContentType("text/html;charset=UTF-8");
		try {
			JsonData jsonData = new JsonData();
			jsonData.setTotal(Integer.parseInt(getServiceManagerServ().queryGridCount()));
			jsonData.setRows(serviceList);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			getResponse().getWriter().println(jsonObject);
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"View protocol exceptions",null));
		}
    } 
    /**
     * ��ʾ���α��
     * @throws IOException 
     */
    public void showTreeGrid() throws IOException{
		List<NodeDesc> nodeDescList = new ArrayList<NodeDesc>();
//		WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getRequest().getSession().getServletContext());

		int nodeDescId ;
		if(StringUtils.isNotEmpty(getRequest().getParameter("nodeDescId"))){
			nodeDescId =  Integer.parseInt(getRequest().getParameter("nodeDescId"));
			String ss = "[{\"nodeDescId\":11,\"nodeCode\":\"code1\",\"nodeName\":\"name11\",\"nodePath\":\"address11\",\"_parentId\":20100}]";
			getResponse().getWriter().println(ss);
		}else{
			int rows = Integer.parseInt(getRequest().getParameter("rows"));
			int page = Integer.parseInt(getRequest().getParameter("page"));
		int startRow ;
		Map hashMap = new HashMap();
		if(page==1){
			startRow = (page - 1) * rows+1;	
		}else {
			startRow = (page - 1) * rows+1;
		}			
		hashMap.put("startRow", startRow);
		hashMap.put("rows", rows);
		nodeDescList =  getServiceManagerServ().queryNodeDesc(hashMap);
		String previous = getRequest().getParameter("previous");
		getResponse().setContentType("text/html;charset=UTF-8");
		try {
			JsonData jsonData = new JsonData();
			Map mapTemp = new HashMap(); 
			jsonData.setTotal(Integer.parseInt(getServiceManagerServ().queryTreeGridCount(mapTemp)));
			jsonData.setRows(nodeDescList);
			JSONObject jsonObject = JSONObject.fromObject(jsonData);
			getResponse().getWriter().println(jsonObject);
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"View treeGrid exceptions",null));
		}
		}
    }
    /**
     * ����ӽڵ����
     * @throws IOException 
     */
    public void getChildNode() throws IOException{
    	WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(getRequest().getSession().getServletContext());
    	getRequest().getParameterMap().get("nodeName");
    	String ss = "{\"rows\":[{\"nodeDescId\":11,\"nodeCode\":\"code1\",\"nodeName\":\"name11\",\"nodePath\":\"address11\",\"_parentId\":20100}],\"total\":73}";
		getResponse().getWriter().println(ss); 	
    	
    }
    
    //��ÿ��Թ�ѡ�ķ���Ŀ¼��-��������ҳ��(��������ҳ��)
    public List<Object> getDirectorySeltree(HashMap map){
		List<Object> list = new ArrayList<Object>();
		Boolean fBoolean = true;
		String id = (String) map.get("qweid");
		if("0".equals(id)){
			Map mapTemp = new HashMap(); 
			treeRootList = getServiceManagerServ().queryDirectory(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("qweid", hashMap.get("DIR_ID"));
				mapTest.put("qwepId", 0);
				mapTest.put("qweIsParent", true);
				mapTest.put("qwepName", hashMap.get("DIR_NAME"));
				list.add(mapTest);
			}  
			
		}
		Map mapTemp = new HashMap();  
		mapTemp.put("id", id);
		if(getServiceManagerServ().queryDirectoryById(mapTemp)!=null){
			treeRootList = getServiceManagerServ().queryDirectoryById(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("qweid", hashMap.get("DIR_ID"));
				mapTest.put("qwepId", hashMap.get("FA_DIR_ID"));
				Map mapTemp2 = new HashMap();  
				mapTemp2.put("id", hashMap.get("DIR_ID").toString());
				treeNodeList = getServiceManagerServ().queryDirectoryById(mapTemp2);
				if(treeNodeList.size()<=0){
					fBoolean = false;			
				}
				mapTest.put("qweIsParent", fBoolean);
				mapTest.put("qwepName", hashMap.get("DIR_NAME"));
				list.add(mapTest);
			}  
		}
		
		return list ;
    }
    
  //��ÿ��Թ�ѡ��ҵ��������-��������ҳ��(��������ҳ��)
    public List<Object> getBizFunctionSeltree(HashMap map){
		List<Object> list = new ArrayList<Object>();
		Boolean fBoolean = true;
		String id = (String) map.get("qweeid");
		if("0".equals(id)){
			Map mapTemp = new HashMap(); 
			treeRootList = getServiceManagerServ().queryBizFunction(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("qweeid", hashMap.get("BIZ_FUNCTION_ID"));
				mapTest.put("qweepId", 0);
				mapTest.put("qweeIsParent", true);
				mapTest.put("qweepName", hashMap.get("NAME"));
				list.add(mapTest);
			}  
			
		}
		Map mapTemp = new HashMap();  
		mapTemp.put("id", id);
		if(getServiceManagerServ().queryDirectoryById(mapTemp)!=null){
			treeRootList = getServiceManagerServ().queryBizFunctionById(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("qweeid", hashMap.get("BIZ_FUNCTION_ID"));
				mapTest.put("qweepId", hashMap.get("BIZ_BIZ_FUNCTION_ID"));
				Map mapTemp2 = new HashMap();  
				mapTemp2.put("id", hashMap.get("BIZ_FUNCTION_ID").toString());
				treeNodeList = getServiceManagerServ().queryDirectoryById(mapTemp2);
				if(treeNodeList.size()<=0){
					fBoolean = false;			
				}
				mapTest.put("qweeIsParent", fBoolean);
				mapTest.put("qweepName", hashMap.get("NAME"));
				list.add(mapTest);
			}  
		}
		
		return list ;
    }
    //չʾҵ��������-������ҳҳ��
    public List<Object> showWorkFlowTree(HashMap map){
    	List<Object> list = new ArrayList<Object>();
		Boolean fBoolean = true;
		String id = (String) map.get("nodeWorkFlowId");
		if("0".equals(id)){
			Map mapTemp = new HashMap(); 
			treeRootList = getServiceManagerServ().queryBizFunction(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("nodeWorkFlowId", hashMap.get("BIZ_FUNCTION_ID"));
				mapTest.put("qwepId", 0);
				mapTest.put("qweIsParent", true);
				mapTest.put("qwepName", hashMap.get("NAME"));
				list.add(mapTest);
			}  
			
		}
		Map mapTemp = new HashMap();  
		mapTemp.put("id", id);
		if(getServiceManagerServ().queryDirectoryById(mapTemp)!=null){
			treeRootList = getServiceManagerServ().queryBizFunctionById(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("nodeWorkFlowId", hashMap.get("BIZ_FUNCTION_ID"));
				mapTest.put("qwepId", hashMap.get("BIZ_BIZ_FUNCTION_ID"));
				Map mapTemp2 = new HashMap();  
				mapTemp2.put("id", hashMap.get("BIZ_FUNCTION_ID").toString());
//				treeNodeList = getServiceManagerServ().queryDirectoryById(mapTemp2);
				treeNodeList = getServiceManagerServ().queryBizFunctionById(mapTemp2);
				if(treeNodeList.size()<=0){
					fBoolean = false;			
				}else{
					fBoolean=true;
				}
				mapTest.put("qweIsParent", fBoolean);
				mapTest.put("qwepName", hashMap.get("NAME"));
				list.add(mapTest);
			}  
		}
		
		return list ;
	}
    
    //չʾ����Ŀ¼��-������ҳҳ��
    public List<Object> showServiceDirTree(HashMap map){
    	List<Object> list = new ArrayList<Object>();
		Boolean fBoolean = true;
		String id = (String) map.get("nodeDirId");
		if("0".equals(id)){
			Map mapTemp = new HashMap(); 
			treeRootList = getServiceManagerServ().queryDirectory(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("nodeDirId", hashMap.get("DIR_ID"));
				mapTest.put("qwepId", 0);
				mapTest.put("qweIsParent", true);
				mapTest.put("qwepName", hashMap.get("DIR_NAME"));
				list.add(mapTest);
			}  
			
		}
		Map mapTemp = new HashMap();  
		mapTemp.put("id", id);
		if(getServiceManagerServ().queryDirectoryById(mapTemp)!=null){
			treeRootList = getServiceManagerServ().queryDirectoryById(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("nodeDirId", hashMap.get("DIR_ID"));
				mapTest.put("qwepId", hashMap.get("FA_DIR_ID"));
				Map mapTemp2 = new HashMap();  
				mapTemp2.put("id", hashMap.get("DIR_ID").toString());
				treeNodeList = getServiceManagerServ().queryDirectoryById(mapTemp2);
				if(treeNodeList.size()<=0){
					fBoolean = false;			
				}else{
					fBoolean=true;
				}
				mapTest.put("qweIsParent", fBoolean);
				mapTest.put("qwepName", hashMap.get("DIR_NAME"));
				list.add(mapTest);
			}  
		}
		
		return list ;
	}
    //չʾ��������Ŀ¼����ҵ�����̵ķ���-������ҳҳ��
    public List<Object> showExceptTree(Map map){
    	List<Object> list = new ArrayList<Object>();
		Boolean fBoolean = true;
		String id = (String) map.get("nodeWorkFlowId");
		if("0".equals(id)){
			Map mapTemp = new HashMap(); 
			treeRootList = getServiceManagerServ().queryBizFunction(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("nodeWorkFlowId", hashMap.get("BIZ_FUNCTION_ID"));
				mapTest.put("qwepId", 0);
				mapTest.put("qweIsParent", true);
				mapTest.put("qwepName", hashMap.get("NAME"));
				list.add(mapTest);
			}  
			
		}
		Map mapTemp = new HashMap();  
		mapTemp.put("id", id);
		if(getServiceManagerServ().queryDirectoryById(mapTemp)!=null){
			treeRootList = getServiceManagerServ().queryBizFunctionById(mapTemp);
			for (Map hashMap : treeRootList) {
				Map mapTest = new HashMap(); 
				mapTest.put("nodeWorkFlowId", hashMap.get("BIZ_FUNCTION_ID"));
				mapTest.put("qwepId", hashMap.get("BIZ_BIZ_FUNCTION_ID"));
				Map mapTemp2 = new HashMap();  
				mapTemp2.put("id", hashMap.get("BIZ_FUNCTION_ID").toString());
				treeNodeList = getServiceManagerServ().queryDirectoryById(mapTemp2);
				if(treeNodeList.size()<=0){
					fBoolean = false;			
				}
				mapTest.put("qweIsParent", fBoolean);
				mapTest.put("qwepName", hashMap.get("NAME"));
				list.add(mapTest);
			}  
		}
		
		return list ;
	}
    /**
     * չʾ���ӷ������ҳ��
     * @throws IOException 
     */
	public String serviceAdd() throws IOException{
		type = getRequest().getParameter("type");
		msgFlowUrl = WebPropertyUtil.getPropertyValue("MESSAGE_FLOW_URL");  //从公共配置文件“eaap_common.properties”中读取消息流地址
		flowUrl.append(msgFlowUrl);
        Map hashMap1 = new HashMap();
        hashMap1.put("serviceCategoryName", getText("eaap.op2.conf.server.manager.designService"));
        hashMap1.put("serviceCategoryId", "0");
        Map hashMap2 = new HashMap();
        hashMap2.put("serviceCategoryName", getText("eaap.op2.conf.server.manager.registerService"));
        hashMap2.put("serviceCategoryId", "1");
        serviceCategoryResultList.add(hashMap1);
        serviceCategoryResultList.add(hashMap2);
        defaultFlowList = getServiceManagerServ().queryDefaultFlowList();
		for (Map hashMap : defaultFlowList) {
			Map mapTest = new HashMap(); 
			mapTest.put("defaultFlowName", hashMap.get("MESSAGE_FLOW_NAME"));
			mapTest.put("defaultFlowId", hashMap.get("MESSAGE_FLOW_ID"));
			defaultFlowResultList.add(mapTest);
		}
		getRequest().getSession().setAttribute("tempServiceId", "");
        return SUCCESS;
	}

	/**
	 * չʾЭ��汾������-��������ҳ��
	 * @return
	 */
	public String serviceAddprotocolVersion(){
        Map hashMap1 = new HashMap();
        hashMap1.put("protocolVersionName", getText("eaap.op2.conf.server.manager.designService"));
        hashMap1.put("protocolVersionId", "0");
        Map hashMap2 = new HashMap();
        hashMap2.put("protocolVersionName", getText("eaap.op2.conf.server.manager.registerService"));
        hashMap2.put("protocolVersionId", "1");
		protocolVersionResultList.add(hashMap1);
		protocolVersionResultList.add(hashMap2);
		return SUCCESS;
	} 
	
    /**
     * �������ӵķ������
     * @return
     */
	public String getServiceAddData(){
		//1.���������
		String serviceSeqString = getServiceManagerServ().selectServiceSeq();
		service.setServiceId(Integer.parseInt(serviceSeqString));
		service.setCreateDate(new Date());
		service.setLastestDate(new Date());
		service.setIsPublished("1");
		service.setServiceEnName(service.getServiceCnName());
		service.setState("A");
		service.setServiceType("0");
		api.setApiName(service.getServiceCnName());
		if(service.getContractVersionId() == null && "".equals(service.getContractVersionId().trim())){
			service.setContractVersionId(null);
		}
		getServiceManagerServ().insertServiceManager(service);
		
		
		//添加服务属性关系表
		String serviceAPI = getRequest().getParameter("serviceAPI");
		
		Map aPIachieve = new HashMap();
		aPIachieve.put("aPIachieve", "APIachieve");
		String attr_spec_id = getServiceManagerServ().getAttrSpecID(aPIachieve);
		ServiceAtt serviceAtt = new ServiceAtt();
		serviceAtt.setServiceId(Integer.parseInt(serviceSeqString));
		serviceAtt.setAttrSpecId(Integer.parseInt(attr_spec_id));
		serviceAtt.setState("A");
		serviceAtt.setSerSpecVa(serviceAPI);
		getServiceManagerServ().insertServiceAtt(serviceAtt);
		//portal需要展示的默认值
		ServiceAtt serviceAttValue = new ServiceAtt();
		serviceAttValue.setServiceId(Integer.parseInt(serviceSeqString));
		serviceAttValue.setAttrSpecId(19);
		serviceAttValue.setState("A");
		serviceAttValue.setSerSpecVa("N");
		getServiceManagerServ().insertServiceAtt(serviceAttValue);
		//2.��ҵ�����̺�Ŀ¼���������
		if(StringUtils.isNotEmpty(getRequest().getParameter("Hidcx"))){
			String[] dirValue = getRequest().getParameter("Hidcx").split(",");
			for(int i=0;i<dirValue.length;i++){
				String dirSeqString = getServiceManagerServ().selectDirSeq();
				dirSer.setDirSerListId(Integer.parseInt(dirSeqString));
				dirSer.setDirId(Integer.parseInt(dirValue[i]));
				dirSer.setServiceId(service.getServiceId());			
				getServiceManagerServ().insertDirService(dirSer);
				
			}
		}
		if(StringUtils.isNotEmpty(getRequest().getParameter("Hidce"))){
			String[] funcValue = getRequest().getParameter("Hidce").split(",");
			for(int i=0;i<funcValue.length;i++){
				String funcSeqString = getServiceManagerServ().selectFuncSeq();
				func2Service.setFunc2SerId(Integer.parseInt(funcSeqString));
				func2Service.setBizFunctionId(Integer.parseInt(funcValue[i]));
				func2Service.setServiceId(service.getServiceId());
				getServiceManagerServ().insertFuncService(func2Service);
			}
		}
		
		//3.api�������������� api����
		String ProvideAPIWay = getRequest().getParameter("ProvideAPIWay");
		String UserAuthorization = getRequest().getParameter("UserAuthorization");
		if("1".equals(ProvideAPIWay)){
			String apiSeqString = getServiceManagerServ().selectApiSeq();
			api.setApiId(Integer.parseInt(apiSeqString));
			api.setServiceId(service.getServiceId());
			api.setApiState("D");
			if(UserAuthorization.equals("1")){
				api.setIsNeedUserAuth("1");
			}
			getServiceManagerServ().insertApiService(api);
		}

	    //4.�Ƿ���Ҫ�û���Ȩ ��ǰ��api������
		String type = getRequest().getParameter("type");
		if ("1".equals(type)) {
			return "maininfo";
		}
		return SUCCESS;
	} 
	

	public String showUpdateServiceData() throws IOException{
		//应付reliance安全检查加的判断
		String serviceFlag = getRequest().getParameter("serviceFlag");
		String serviceId = getRequest().getParameter("serviceId");
		
		msgFlowUrl = WebPropertyUtil.getPropertyValue("MESSAGE_FLOW_URL");  //从公共配置文件“eaap_common.properties”中读取消息流地址
		flowUrl.append(msgFlowUrl);	
		
		
		getRequest().getSession().setAttribute("tempServiceId", serviceId);
		
		List<Map> dirIdList = new ArrayList<Map>();
		List<Map> dirPathList = new ArrayList<Map>();
		String dirId ="";
		String dirValue ="";
		List<Map> funcIdList = new ArrayList<Map>();
		List<Map> funcPathList = new ArrayList<Map>();
		String funcId ="";
		String funcValue ="";
		service.setServiceId(Integer.parseInt(serviceId));
		
		//得到服务属性值
		Map aPIachieve = new HashMap();
		aPIachieve.put("aPIachieve", "APIachieve");
		attr_spec_id = getServiceManagerServ().getAttrSpecID(aPIachieve);
		ServiceAtt serviceAtt = new ServiceAtt();
		serviceAtt.setServiceId(Integer.parseInt(serviceId));
		serviceAtt.setAttrSpecId(Integer.parseInt(attr_spec_id));
		serviceAPI = getServiceManagerServ().getSerSpecVal(serviceAtt);
		
		StringBuffer dirPathStringBuffer  = new  StringBuffer();
     	dirIdList = getServiceManagerServ().queryDirIdByServiceId(service);
		for(int i=0;i<dirIdList.size();i++){
		    String dirValueTemp =  getServiceManagerServ().queryDirNameByDirId(dirIdList.get(i).get("DIR_ID").toString());
		    if(i==dirIdList.size()-1){
		    	dirId+=dirIdList.get(i).get("DIR_ID");
		    	dirValue+=dirValueTemp;
		    }else{
		    dirId+=dirIdList.get(i).get("DIR_ID")+",";
		    dirValue+=dirValueTemp+",";	
		    }
		}
		if(dirIdList.size()>0){
		String[] dirPath = new String[dirIdList.size()];
		


			for(int i=0;i<dirIdList.size();i++){
				dirPath[i]=dirIdList.get(i).get("DIR_ID").toString();
				dirPathList = getServiceManagerServ().queryAllPathByDirId(dirPath[i]);
				for(Map hashMap:dirPathList){
					dirPathStringBuffer.append(hashMap.get("DIR_ID"));
					dirPathStringBuffer.append(",");
				}
			
			}	




		}
		DirSeletedTreeMap.put("dirId", dirId); 
		DirSeletedTreeMap.put("dirValue", dirValue); 
		DirSeletedTreeMap.put("dirPath", dirPathStringBuffer); 
		
		
		StringBuffer funcPathStringBuffer  = new  StringBuffer();
     	funcIdList = getServiceManagerServ().queryFuncIdByServiceId(service);
		for(int i=0;i<funcIdList.size();i++){
		    String funcValueTemp =  getServiceManagerServ().queryFuncNameByDirId(funcIdList.get(i).get("BIZ_FUNCTION_ID").toString());
		    if(i==funcIdList.size()-1){
		    	funcId+=funcIdList.get(i).get("BIZ_FUNCTION_ID");
		    	funcValue+=funcValueTemp;
		    }else{
		    funcId+=funcIdList.get(i).get("BIZ_FUNCTION_ID")+",";
		    funcValue+=funcValueTemp+",";	
		    }
		}
		if(funcIdList.size()>0){
		String[] funcPath = new String[funcIdList.size()];
		for(int i=0;i<funcIdList.size();i++){
			funcPath[i]=funcIdList.get(i).get("BIZ_FUNCTION_ID").toString();
			funcPathList = getServiceManagerServ().queryAllPathByFuncId(funcPath[i]);
			for(Map hashMap:funcPathList){
				funcPathStringBuffer.append(hashMap.get("BIZ_FUNCTION_ID"));
				funcPathStringBuffer.append(",");
			}
		}	

		}
		FuncSeletedTreeMap.put("funcId", funcId); 
		FuncSeletedTreeMap.put("funcValue", funcValue); 
		FuncSeletedTreeMap.put("funcPath", funcPathStringBuffer); 
		
		

		serviceHashMap = getServiceManagerServ().queryServiceByServiceId(service);

		if(serviceHashMap!=null&&serviceHashMap.get("CONTRACT_VERSION_ID")!=null){
			contractHashMap = getServiceManagerServ().queryContractByContractVersionId(serviceHashMap.get("CONTRACT_VERSION_ID").toString());
		}
		
	       Map hashMap1 = new HashMap();
	       Map hashMap2 = new HashMap();
	       if(serviceHashMap!=null&&!"".equals(serviceHashMap.get("SERVICE_TYPE"))&&serviceHashMap.get("SERVICE_TYPE")!=null){
	    	   if(serviceHashMap.get("SERVICE_TYPE").equals("1")){
	   			serviceHashMap.put("SERVICE_TYPE", "1");
	   		}else{
	   			serviceHashMap.put("SERVICE_TYPE", "0");
	   		} 
   		       hashMap1.put("serviceTypeName", getText("eaap.op2.conf.server.manager.registerService"));
   		       hashMap1.put("serviceTypeId", "1");
   		       hashMap2.put("serviceTypeName", getText("eaap.op2.conf.server.manager.designService"));
   		       hashMap2.put("serviceTypeId", "0");
   		       serviceCategoryResultList.add(hashMap1);
   		       serviceCategoryResultList.add(hashMap2);
	       }
		
	
//     defaultFlowList = getServiceManagerServ().queryDefaultFlowList();
//		for (Map hashMap : defaultFlowList) {
//			Map mapTest = new HashMap(); 
//			mapTest.put("defaultFlowName", hashMap.get("MESSAGE_FLOW_NAME"));
//			mapTest.put("defaultFlowId", hashMap.get("MESSAGE_FLOW_ID"));
//			defaultFlowResultList.add(mapTest);
//		}	

		  api = getServiceManagerServ().queryApi(service);
		   if(api!=null){
			   switchMap.put("ProvideAPIWay","1");
			   switchMap.put("ProvideAPIWayClassCs", "");
			   switchMap.put("ProvideAPIWayChange", "ON");
			   switchMap.put("ProvideAPIWayState", "ON");		   
			   switchMap.put("ApiDesc", api.getApiDesc()); 
			   switchMap.put("apiMethod", api.getApiMethod());
			   if(StringUtils.isNotEmpty(api.getIsNeedUserAuth())&&api.getIsNeedUserAuth().equals("1")){
				   switchMap.put("UserAuthorization","1");
				   switchMap.put("UserAuthorizationClassCs", "");				
				   switchMap.put("UserAuthorizationChange", "ON");
				   switchMap.put("UserAuthorizationState", "ON");
			   }else{
				   switchMap.put("UserAuthorization","0");
				   switchMap.put("UserAuthorizationClassCs", "off");			   
				   switchMap.put("UserAuthorizationChange", "off");
				   switchMap.put("UserAuthorizationState", "OFF");
			   }
		   }else{
			   switchMap.put("ProvideAPIWay","0");
			   switchMap.put("ProvideAPIWayClassCs", "off");			   
			   switchMap.put("ProvideAPIWayChange", "off");
			   switchMap.put("ProvideAPIWayState", "OFF");
			   switchMap.put("UserAuthorization","0");
			   switchMap.put("UserAuthorizationClassCs", "off");			   
			   switchMap.put("UserAuthorizationChange", "off");
			   switchMap.put("UserAuthorizationState", "OFF");
		   }
		

		
		return SUCCESS;
	}
    /**
     * ���·������
     * @return
     */
	public String UpdateServiceData(){
		getRequest().getSession().setAttribute("tempServiceId", "");
		//���·����	
		service.setCreateDate(new Date());
		service.setLastestDate(new Date());
		service.setIsPublished("1");
		service.setServiceEnName(service.getServiceCnName());
		service.setState("A");
		service.setServiceType("0");
		String api_name = service.getServiceCnName();
		api.setApiName(api_name);
		
		//修改服务属性值
		ServiceAtt serviceAtt = new ServiceAtt();
		serviceAtt.setAttrSpecId(Integer.parseInt(attr_spec_id));
		serviceAtt.setSerSpecVa(serviceAPI);
		serviceAtt.setServiceId(service.getServiceId());
		getServiceManagerServ().updateServiceApi(serviceAtt);
	    //����ҵ���������Ŀ¼ ��ɾ�������		
		String[] dirValue = getRequest().getParameter("ServiceDirSave").split(",");	
		if(StringUtils.isNotEmpty(dirValue[0])){
		for(int i=0;i<dirValue.length;i++){
			String dirSeqString = getServiceManagerServ().selectDirSeq();
			DirSerList dirSer = new DirSerList();
			dirSer.setDirSerListId(Integer.parseInt(dirSeqString));
			dirSer.setDirId(Integer.parseInt(dirValue[i]));
			dirSer.setServiceId(service.getServiceId());	
			dirSerListOfList.add(dirSer);			
		}
		}
		String[] funcValue = getRequest().getParameter("ServiceFuncSave").split(",");
		if(StringUtils.isNotEmpty(funcValue[0])){
		for(int i=0;i<funcValue.length;i++){
			String funcSeqString = getServiceManagerServ().selectFuncSeq();
			Func2Service func2Service = new Func2Service();
			func2Service.setFunc2SerId(Integer.parseInt(funcSeqString));
			func2Service.setBizFunctionId(Integer.parseInt(funcValue[i]));
			func2Service.setServiceId(service.getServiceId());
			func2ServiceList.add(func2Service);			
		}
		}
		//����api��������� 1.api�������˾�ɾ�� 2.����Ȩ�� ������Ϊ0
		String ProvideAPIWay = getRequest().getParameter("ProvideAPIWay");
		String UserAuthorization = getRequest().getParameter("UserAuthorization");
//		if(ProvideAPIWay.equals("1")){
//			if(getServiceManagerServ().queryApi(service)==null){
//				
//			}
//			String apiSeqString = getServiceManagerServ().selectApiSeq();
//			api.setApiId(Integer.parseInt(apiSeqString));
//			api.setServiceId(service.getServiceId());
//			if(UserAuthorization.equals("1")){
//				api.setIsNeedUserAuth("1");
//			}else{
//				api.setIsNeedUserAuth("0");
//			}
//			getServiceManagerServ().insertApiService(api);
//		}else{
//			getServiceManagerServ().delServiceApi(service);
//		}
		
		getServiceManagerServ().updateServiceRegister(service,dirSerListOfList,func2ServiceList,ProvideAPIWay,UserAuthorization,api);
		String type = getRequest().getParameter("type");
		if ("1".equals(type)) {
			return "maininfo";
		}	
		return SUCCESS;
	}
	/**
	 * ����Ӧ��ע��ҳ��չʾ
	 * @return
	 * @throws IOException 
	 */
	public String ServiceSupRegister() throws IOException{
		msgFlowUrl = WebPropertyUtil.getPropertyValue("MESSAGE_FLOW_URL");  //从公共配置文件“eaap_common.properties”中读取消息流地址
		
		commProtocalList = getServiceManagerServ().queryCommProtocalListList();
		for (Map hashMap : commProtocalList) {
			Map mapTest = new HashMap(); 
			mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
			mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
			commProtocalResultList.add(mapTest);
		}
		
        Map hashMap1 = new HashMap();
        hashMap1.put("name", getText("eaap.op2.conf.server.manager.serviceEnable"));
        hashMap1.put("componentId", "D");
        Map hashMap2 = new HashMap();
        hashMap2.put("name", getText("eaap.op2.conf.server.manager.serviceDisable"));
        hashMap2.put("componentId", "N");
        
        resultList.add(hashMap1);
        resultList.add(hashMap2);
		return SUCCESS;
	}

	
	public Map showServiceSupRegisterGrid(Map para){
//		List<Service> serviceList = new ArrayList<Service>();
		rows = pagination.getRows();
		page = pagination.getPage();
		int startRow;
		int total;
		startRow = (page - 1) * rows + 1;
		Map hashMap = new HashMap();
		hashMap.put("rows", rows);
		hashMap.put("startRow", startRow);
		hashMap.put("startRow_mysql", startRow-1);
		String state = null;
		if(StringUtil.isEmpty(getRequest().getParameter("isInit"))){
			state = "D";
		}else{
			state = "".equals(getRequest().getParameter("state"))? null:getRequest().getParameter("state");
		}
		if (StringUtils.isNotEmpty(getRequest().getParameter(
				"serviceId"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"componentId"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"orgId"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"commProCd"))||StringUtils.isNotEmpty(getRequest().getParameter(
				"techImplId"))||StringUtils.isNotEmpty(state)) {
			String serviceId =  "".equals(getRequest().getParameter("serviceId"))? null:getRequest().getParameter("serviceId");
			String componentId = "".equals(getRequest().getParameter("componentId"))? null:getRequest().getParameter("componentId");
			String commProCd = "".equals(getRequest().getParameter("commProCd"))? null:getRequest().getParameter("commProCd");
			String techImplId = "".equals(getRequest().getParameter("techImplId"))? null:getRequest().getParameter("techImplId");
			String orgId = "".equals(getRequest().getParameter("orgId"))? null:getRequest().getParameter("orgId");
						
			hashMap.put("serviceId", serviceId);
			hashMap.put("componentId", componentId);
			hashMap.put("orgId", orgId);
			hashMap.put("commProCd", commProCd);
			hashMap.put("techImplId", techImplId);
			hashMap.put("state", state);		
			techImplList = getServiceManagerServ().queryServiceSupplierRegister(hashMap);
			hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryServiceSupplierRegisterCount(hashMap)));
			hashMap.put("dataList", pagination.convertJson(techImplList));
			return hashMap;
		} else {			
			techImplList = getServiceManagerServ().queryServiceSupplierRegister(hashMap);
			hashMap.put("total", Integer.parseInt(getServiceManagerServ().queryServiceSupplierRegisterCount(hashMap)));
			hashMap.put("dataList", pagination.convertJson(techImplList));
			return hashMap;
		}
				
	}
	/**
	 * ����Ӧ���������תҳ��
	 */
	public String serviceSupplierResgisterAdd(){
		return SUCCESS;
	}
	/**
	 * ����Ӧ���������һ����תҳ��
	 * @return
	 */
	public String serviceSupplierResgisterAddToNext(){
//		  Map paramap = new HashMap();
//	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
//	       if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
//	    	   serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
//	       }
	        
	       Map cc2cState1 = new HashMap();
	       cc2cState1.put("stateCode", "A");
	       cc2cState1.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
	       
	       Map cc2cState2 = new HashMap();
	       cc2cState2.put("stateCode", "R");
	       cc2cState2.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
	       
	       cc2cStatelist.add(cc2cState1);
	       cc2cStatelist.add(cc2cState2);
	       
	       
	       
	       Map ccTpye1 = new HashMap();
	       ccTpye1.put("ccTpyeCode", "1");
	       ccTpye1.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype1"));
	       
	       Map ccTpye2 = new HashMap();
	       ccTpye2.put("ccTpyeCode", "2");
	       ccTpye2.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype2"));
	       
	       Map ccTpye3 = new HashMap();
	       ccTpye3.put("ccTpyeCode", "3");
	       ccTpye3.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype3"));
	       ccTypeList.add(ccTpye1);
	       ccTypeList.add(ccTpye2);
	       ccTypeList.add(ccTpye3);
	       
	       Map cutmsValueType1 = new HashMap();
	       cutmsValueType1.put("cutmsValueTypeCode", "1");
	       cutmsValueType1.put("cutmsValueTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       Map cutmsValueType2 = new HashMap();
	       cutmsValueType2.put("cutmsValueTypeCode", "2");
	       cutmsValueType2.put("cutmsValueTypeName", getText("MB"));
	       cutmsValueTypelist.add(cutmsValueType1);
	       cutmsValueTypelist.add(cutmsValueType2);
	       
	       
	       Map cycleType1 = new HashMap();
	       cycleType1.put("cycleTypeCode", "1");
	       cycleType1.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       
	       Map cycleType2 = new HashMap();
	       cycleType2.put("cycleTypeCode", "2");
	       cycleType2.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype2"));
	       
	       Map cycleType3 = new HashMap();
	       cycleType3.put("cycleTypeCode", "3");
	       cycleType3.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype3"));
	       
	       Map cycleType4 = new HashMap();
	       cycleType4.put("cycleTypeCode", "4");
	       cycleType4.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype4"));
	       
	       Map cycleType5 = new HashMap();
	       cycleType5.put("cycleTypeCode", "5");
	       cycleType5.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype5"));
	       
	       Map cycleType6 = new HashMap();
	       cycleType6.put("cycleTypeCode", "6");
	       cycleType6.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype6"));
	       cycleTyleList.add(cycleType1);
	       cycleTyleList.add(cycleType2);
	       cycleTyleList.add(cycleType3);
	       cycleTyleList.add(cycleType4);
	       cycleTyleList.add(cycleType5);
	       cycleTyleList.add(cycleType6);
		return SUCCESS;
	}
	/**
	 * �������Կ������չʾ
	 * @param para
	 * @return
	 */
	public Map showControlStrategy(Map para){
		rows = pagination.getRows();
		page = pagination.getPage();
		int startRow;
		int total;
		Map hashMap = new HashMap();
		startRow = (page - 1) * rows + 1;
		hashMap.put("startRow", startRow);
		hashMap.put("rows", rows);
		techImplList = getServiceManagerServ().queryServiceSupplierRegister(
				hashMap);
		hashMap.put("total", Integer.parseInt(getServiceManagerServ()
				.queryServiceSupplierRegisterCount(hashMap)));
		hashMap.put("dataList", pagination.convertJson(techImplList));
		return hashMap;
				
	} 
	/**
	 * 
	 * @param para
	 * @return
	 */
    public Map getCC2CList(Map para){
    	 CtlCounterms2Tech ctlCounterms2Tech = new CtlCounterms2Tech();
    	 if(StringUtils.isNotEmpty(para.get("queryParamsData").toString()))
         ctlCounterms2Tech.setTechImplId(Integer.valueOf(para.get("queryParamsData").toString()));
	   	 rows = pagination.getRows();
	   	 page = pagination.getPage();
		 int startRow;
		 int total;
		 startRow = (page - 1) * rows + 1;
		 Map returnMap = new HashMap();
		 List<Map> tmpList = new ArrayList<Map>() ;
		 
	     Map map = new HashMap() ;
	     map.put("techImplId", ctlCounterms2Tech.getTechImplId()) ;
	     map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getServiceManagerServ().queryCC2cInfoListById(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
	     map.put("end", startRow+rows-1);
	     map.put("pro_mysql", startRow - 1);
	     map.put("page_record", rows);
	     tmpList = getServiceManagerServ().queryCC2cInfoListById(map) ;
	     
	     Map cycleType = new HashMap();
	     cycleType.put("1", getText("eaap.op2.conf.manager.auth.cycletype1"));
	     cycleType.put("2", getText("eaap.op2.conf.manager.auth.cycletype2"));
	     cycleType.put("3", getText("eaap.op2.conf.manager.auth.cycletype3"));
	     cycleType.put("4", getText("eaap.op2.conf.manager.auth.cycletype4"));
	     cycleType.put("5", getText("eaap.op2.conf.manager.auth.cycletype5"));
	     cycleType.put("6", getText("eaap.op2.conf.manager.auth.cycletype6"));
	     
	     Map effectState = new HashMap();
	     effectState.put("A", getText("eaap.op2.conf.manager.auth.valid"));
	     effectState.put("R", getText("eaap.op2.conf.manager.auth.invalid"));
	     
	     for (Map temp : tmpList) {
	    	 
	    	 if (temp.get("CYCLE_TYPE") != null) {
	    		 temp.put("CYCLETYPENAME", String.valueOf(temp.get("CYCLE_VALUE")) + cycleType.get(temp.get("CYCLE_TYPE")));
	    	 }
	    	 if (temp.get("EFFECT_STATE") != null) {
	    		 temp.put("STATENAME", effectState.get(temp.get("EFFECT_STATE")));
	    	 }
	     }
		   
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", pagination.convertJson(tmpList));
		
		return returnMap ;
}
    /**
     * �����������Ʋ���
     * @return
     */
	public String addServiceSupRegTechCtl(){
//		  Map paramap = new HashMap();
//	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
//	       if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
//	    	   serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
//	       }
	        
	       Map cc2cState1 = new HashMap();
	       cc2cState1.put("stateCode", "A");
	       cc2cState1.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
	       
	       Map cc2cState2 = new HashMap();
	       cc2cState2.put("stateCode", "R");
	       cc2cState2.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
	       
	       cc2cStatelist.add(cc2cState1);
	       cc2cStatelist.add(cc2cState2);
	       
	       
	       
	       Map ccTpye1 = new HashMap();
	       ccTpye1.put("ccTpyeCode", "1");
	       ccTpye1.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype1"));
	       
	       Map ccTpye2 = new HashMap();
	       ccTpye2.put("ccTpyeCode", "2");
	       ccTpye2.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype2"));
	       
	       Map ccTpye3 = new HashMap();
	       ccTpye3.put("ccTpyeCode", "3");
	       ccTpye3.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype3"));
	       ccTypeList.add(ccTpye1);
	       ccTypeList.add(ccTpye2);
	       ccTypeList.add(ccTpye3);
	       
	       Map cutmsValueType1 = new HashMap();
	       cutmsValueType1.put("cutmsValueTypeCode", "1");
	       cutmsValueType1.put("cutmsValueTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       Map cutmsValueType2 = new HashMap();
	       cutmsValueType2.put("cutmsValueTypeCode", "2");
	       cutmsValueType2.put("cutmsValueTypeName", getText("MB"));
	       cutmsValueTypelist.add(cutmsValueType1);
	       cutmsValueTypelist.add(cutmsValueType2);
	       
	       
	       Map cycleType1 = new HashMap();
	       cycleType1.put("cycleTypeCode", "1");
	       cycleType1.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       
	       Map cycleType2 = new HashMap();
	       cycleType2.put("cycleTypeCode", "2");
	       cycleType2.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype2"));
	       
	       Map cycleType3 = new HashMap();
	       cycleType3.put("cycleTypeCode", "3");
	       cycleType3.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype3"));
	       
	       Map cycleType4 = new HashMap();
	       cycleType4.put("cycleTypeCode", "4");
	       cycleType4.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype4"));
	       
	       Map cycleType5 = new HashMap();
	       cycleType5.put("cycleTypeCode", "5");
	       cycleType5.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype5"));
	       
	       Map cycleType6 = new HashMap();
	       cycleType6.put("cycleTypeCode", "6");
	       cycleType6.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype6"));
	       cycleTyleList.add(cycleType1);
	       cycleTyleList.add(cycleType2);
	       cycleTyleList.add(cycleType3);
	       cycleTyleList.add(cycleType4);
	       cycleTyleList.add(cycleType5);
	       cycleTyleList.add(cycleType6);
	       
	   //����ʵ����������
	       techImpl.setTechImplId(ctlCounterms2Tech.getTechImplId());
		   getServiceManagerServ().insertCtlCounterms2Tech(ctlCounterms2Tech);
		   return SUCCESS;

	}
    public String addServiceSupReg(){
    	
    	String SeqSerTechImpl = getServiceManagerServ().querySeqSerTechImpl();
    	SerTechImpl serTechImpl = new SerTechImpl();
    	serTechImpl.setSerTechImplId(Integer.parseInt(SeqSerTechImpl));
    	serTechImpl.setServiceId(service.getServiceId());
    	serTechImpl.setTechImplId(Integer.parseInt(techImpl.getTechImplId().toString()));
    	
    	getServiceManagerServ().insertSerTechImpl(serTechImpl);
    	
    	return SUCCESS;
    }
    /**
     * չʾ����ע���޸�ҳ��
     * @return
     */
    public String showSupRegUpdate(){
        Map cc2cState1 = new HashMap();
	       cc2cState1.put("stateCode", "A");
	       cc2cState1.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
	       
	       Map cc2cState2 = new HashMap();
	       cc2cState2.put("stateCode", "R");
	       cc2cState2.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
	       
	       cc2cStatelist.add(cc2cState1);
	       cc2cStatelist.add(cc2cState2);
	       
	       
	       
	       Map ccTpye1 = new HashMap();
	       ccTpye1.put("ccTpyeCode", "1");
	       ccTpye1.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype1"));
	       
	       Map ccTpye2 = new HashMap();
	       ccTpye2.put("ccTpyeCode", "2");
	       ccTpye2.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype2"));
	       
	       Map ccTpye3 = new HashMap();
	       ccTpye3.put("ccTpyeCode", "3");
	       ccTpye3.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype3"));
	       ccTypeList.add(ccTpye1);
	       ccTypeList.add(ccTpye2);
	       ccTypeList.add(ccTpye3);
	       
	       Map cutmsValueType1 = new HashMap();
	       cutmsValueType1.put("cutmsValueTypeCode", "1");
	       cutmsValueType1.put("cutmsValueTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       Map cutmsValueType2 = new HashMap();
	       cutmsValueType2.put("cutmsValueTypeCode", "2");
	       cutmsValueType2.put("cutmsValueTypeName", getText("MB"));
	       cutmsValueTypelist.add(cutmsValueType1);
	       cutmsValueTypelist.add(cutmsValueType2);
	       
	       
	       Map cycleType1 = new HashMap();
	       cycleType1.put("cycleTypeCode", "1");
	       cycleType1.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       
	       Map cycleType2 = new HashMap();
	       cycleType2.put("cycleTypeCode", "2");
	       cycleType2.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype2"));
	       
	       Map cycleType3 = new HashMap();
	       cycleType3.put("cycleTypeCode", "3");
	       cycleType3.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype3"));
	       
	       Map cycleType4 = new HashMap();
	       cycleType4.put("cycleTypeCode", "4");
	       cycleType4.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype4"));
	       
	       Map cycleType5 = new HashMap();
	       cycleType5.put("cycleTypeCode", "5");
	       cycleType5.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype5"));
	       
	       Map cycleType6 = new HashMap();
	       cycleType6.put("cycleTypeCode", "6");
	       cycleType6.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype6"));
	       cycleTyleList.add(cycleType1);
	       cycleTyleList.add(cycleType2);
	       cycleTyleList.add(cycleType3);
	       cycleTyleList.add(cycleType4);
	       cycleTyleList.add(cycleType5);
	       cycleTyleList.add(cycleType6);
	       
    	String serTechImplId  = getRequest().getParameter("serTechImplId");
    	
    	serHashMap.put("serTechImplId", serTechImplId);
    	serHashMap = getServiceManagerServ().queryServiceSupplierRegisterBySerImplId(serHashMap);
    	
    	return SUCCESS;
    }
    
	public String addServiceSupRegTechCtlUpdate(){
//		  Map paramap = new HashMap();
//	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
//	       if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
//	    	   serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
//	       }
	        
	       Map cc2cState1 = new HashMap();
	       cc2cState1.put("stateCode", "A");
	       cc2cState1.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
	       
	       Map cc2cState2 = new HashMap();
	       cc2cState2.put("stateCode", "R");
	       cc2cState2.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
	       
	       cc2cStatelist.add(cc2cState1);
	       cc2cStatelist.add(cc2cState2);
	       
	       
	       
	       Map ccTpye1 = new HashMap();
	       ccTpye1.put("ccTpyeCode", "1");
	       ccTpye1.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype1"));
	       
	       Map ccTpye2 = new HashMap();
	       ccTpye2.put("ccTpyeCode", "2");
	       ccTpye2.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype2"));
	       
	       Map ccTpye3 = new HashMap();
	       ccTpye3.put("ccTpyeCode", "3");
	       ccTpye3.put("ccTpyeName", getText("eaap.op2.conf.manager.auth.cctype3"));
	       ccTypeList.add(ccTpye1);
	       ccTypeList.add(ccTpye2);
	       ccTypeList.add(ccTpye3);
	       
	       Map cutmsValueType1 = new HashMap();
	       cutmsValueType1.put("cutmsValueTypeCode", "1");
	       cutmsValueType1.put("cutmsValueTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       Map cutmsValueType2 = new HashMap();
	       cutmsValueType2.put("cutmsValueTypeCode", "2");
	       cutmsValueType2.put("cutmsValueTypeName", getText("MB"));
	       cutmsValueTypelist.add(cutmsValueType1);
	       cutmsValueTypelist.add(cutmsValueType2);
	       
	       
	       Map cycleType1 = new HashMap();
	       cycleType1.put("cycleTypeCode", "1");
	       cycleType1.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype1"));
	       
	       Map cycleType2 = new HashMap();
	       cycleType2.put("cycleTypeCode", "2");
	       cycleType2.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype2"));
	       
	       Map cycleType3 = new HashMap();
	       cycleType3.put("cycleTypeCode", "3");
	       cycleType3.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype3"));
	       
	       Map cycleType4 = new HashMap();
	       cycleType4.put("cycleTypeCode", "4");
	       cycleType4.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype4"));
	       
	       Map cycleType5 = new HashMap();
	       cycleType5.put("cycleTypeCode", "5");
	       cycleType5.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype5"));
	       
	       Map cycleType6 = new HashMap();
	       cycleType6.put("cycleTypeCode", "6");
	       cycleType6.put("cycleTypeName", getText("eaap.op2.conf.manager.auth.cycletype6"));
	       cycleTyleList.add(cycleType1);
	       cycleTyleList.add(cycleType2);
	       cycleTyleList.add(cycleType3);
	       cycleTyleList.add(cycleType4);
	       cycleTyleList.add(cycleType5);
	       cycleTyleList.add(cycleType6);
	       
	   //����ʵ����������
	       techImpl.setTechImplId(ctlCounterms2Tech.getTechImplId());
	       
		   getServiceManagerServ().insertCtlCounterms2Tech(ctlCounterms2Tech);
		   return SUCCESS;

	}
	
    /**
     * ���·���Ӧ��ע��
     * @return
     */
	public String ServiceSupRegUpdate(){
    	serTechImpl.setTechImplId(Integer.parseInt(techImpl.getTechImplId().toString()));
    	serTechImpl.setServiceId(service.getServiceId());
    	getServiceManagerServ().updateSerTechImpl(serTechImpl);
    	return SUCCESS;
	}
	/**
	 * ɾ��ע�����Ӧ��ע�ᣨ״̬��Ϊ�����ã�
	 */
	public void serviceSupplierResgisterDelete(){
		 PrintWriter out =null;
			try {
				getRequest().setCharacterEncoding("UTF-8");
		    	String deleteIDs = getRequest().getParameter("deleteIDs");
		    	serTechImpl.setSerTechImplId(Integer.parseInt(deleteIDs));
		    	serTechImpl.setState("N");
		    	serTechImpl.setLastestTime(new Date());			
		    	getServiceManagerServ().updateSerTechImpl(serTechImpl);
			    getResponse().setContentType("text/html;charset=UTF-8");
			    out = getResponse().getWriter();
			    String xx="[{\"msg\":\"ok\"}]";
				out.print(xx);
			}  catch (Exception e) {
				if (out != null) {
					out.print("failure");
				}
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete service exceptions",null));
			}finally{
				if (out != null) {
					out.flush();
					out.close();
				}
			}
	}
	/**
	 * �жϷ���汾Ψһ
	 */
	public void compareVersion()throws IOException{
		String serviceVersion = getRequest().getParameter("version")==null?"":getRequest().getParameter("version");	
		String serviceEnName = getRequest().getParameter("serviceEnName")==null?"":getRequest().getParameter("serviceEnName");	
		service.setServiceVersion(serviceVersion);
		service.setServiceEnName(serviceEnName);
		List<Service> servicesList = new ArrayList<Service>();
		servicesList = getServiceManagerServ().compareServiceVersionAndEnName(service);
		String result = "";
		if(servicesList!=null&&(StringUtils.isNotEmpty(servicesList.get(0).getServiceEnName())||StringUtils.isNotEmpty(servicesList.get(0).getServiceVersion()))){
		 result ="{\"message\":\"failure\"}";
		 getResponse().getWriter().print(result);
		}else {
		 result ="{\"message\":\"success\"}";
		 getResponse().getWriter().print(result);
		}
	}
	public List<Map> loadServiceMessgList(Map paraMap){
		loadServiceMessgList = getServiceManagerServ().loadServiceMessgList(paraMap);
	    defaultFlowList = getServiceManagerServ().queryDefaultFlowList();
			for (Map hashMap : defaultFlowList) {
				Map mapTest = new HashMap(); 
				mapTest.put("MESSFLOWNAME", hashMap.get("MESSAGE_FLOW_NAME"));
				mapTest.put("MESSFLOWID", hashMap.get("MESSAGE_FLOW_ID"));
				loadServiceMessgList.add(mapTest);
			}
		return loadServiceMessgList;
	}
	
	
	public boolean validatorBizFun(String verifyParam,String paramValue) {
		
		if (getRequest().getSession().getAttribute("bizFunctionId") != null && !"".equals((String) getRequest().getSession().getAttribute("bizFunctionId"))) {
			bizFun.setBizFunctionId(Integer.valueOf((String) getRequest().getSession().getAttribute("bizFunctionId")));
		}		
		if (verifyParam.indexOf("Code") > -1) {
			bizFun.setCode(paramValue);
		}
		List<BizFunction> bizFunsList = new ArrayList<BizFunction>();
		bizFunsList = getServiceManagerServ().queryBizFun(bizFun);
		
		return (bizFunsList==null||bizFunsList.size()<1)?true:false;		
		
	}
	
	
	//验证service的名称和版本是否重名。
	public boolean validatorService(String verifyParam ,String paramValue) {
		service = new Service();
		if (verifyParam.indexOf("Name") > -1) {
			service.setServiceEnName(paramValue);
			service.setServiceVersion(null);
			service.setServiceCode(null);
		} else if (verifyParam.indexOf("Version") > -1) {
			service.setServiceVersion(paramValue);
			service.setServiceEnName(null);
			service.setServiceCode(null);
		} else if (verifyParam.indexOf("Code") > -1) {
			service.setServiceCode(paramValue);
			service.setServiceVersion(null);
			service.setServiceEnName(null);
		}
		List<Service> servicesList = new ArrayList<Service>();
		servicesList = getServiceManagerServ().compareServiceVersionAndEnName(service);
		return servicesList==null||servicesList.size()<1?true:false;
	}
	
	public boolean validatorUpdateService(String verifyParam ,String paramValue) {
		if (getRequest().getSession().getAttribute("tempServiceId") !=null 
				&& !"".equals((String) getRequest().getSession().getAttribute("tempServiceId"))) {
			service.setServiceId(Integer.valueOf((String) getRequest().getSession().getAttribute("tempServiceId")));
		}
		
		if (verifyParam.indexOf("Name") > -1) {
			service.setServiceEnName(paramValue);
			service.setServiceVersion(null);
			service.setServiceCode(null);
		} else if (verifyParam.indexOf("Version") > -1) {
			service.setServiceVersion(paramValue);
			service.setServiceEnName(null);
			service.setServiceCode(null);
		} else if (verifyParam.indexOf("Code") > -1) {
			service.setServiceCode(paramValue);
			service.setServiceVersion(null);
			service.setServiceEnName(null);
		}
		List<Service> servicesList = new ArrayList<Service>();
		servicesList = getServiceManagerServ().compareServiceVersionAndEnName(service);
		
		return servicesList==null||servicesList.size()<1?true:false;
	}
	
	//创建一个透传的消息流，并调用服务技术实现:
	public void createDirectMessageFlow(){
		PrintWriter out =null;
		try {
			String serTechImplId 		= getRequest().getParameter("serTechImplId");
			//String techImplName		= getRequest().getParameter("techImplName");

	    	getServiceManagerServ().createDirectMessageFlow(serTechImplId);
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\"}]";
			out.print(ret);
		}  catch (Exception e) {
			out.print("failure");
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Adding messageflow exceptions",null));
		}finally{
			out.flush();
			out.close();
		}
	}

	//用于OTT工作流选择API：选择服务，根据服务及O2P组件查出对应服务调用实例，若无则创建，返回服务调用实例ID及名称
    public void getSerInvokeInsInfoByServiceId(){
    	 PrintWriter out =null;
		try {
			String serInvokeInsId = "";
			String serInvokeInsName = "";
			String failureInfo = "";
			getRequest().setCharacterEncoding("UTF-8");
	    	String serviceId = getRequest().getParameter("serviceId");

			String componentId = WebPropertyUtil.getPropertyValue("O2P_COMPONENT_ID");  //从公共配置文件“eaap_common.properties”中读取消OTP组件ID
			
			serInvokeIns = new SerInvokeIns();
	    	serInvokeIns.setServiceId(Integer.parseInt(serviceId));
	    	serInvokeIns.setComponentId(componentId);
        	List<SerInvokeIns> serInvokeInsList = getServiceManagerServ().querySerInvokeIns(serInvokeIns);
	    	if(serInvokeInsList!=null && serInvokeInsList.size()>0){
	    		//有数据
	    		serInvokeIns = serInvokeInsList.get(0);
	    		serInvokeInsId = String.valueOf(serInvokeIns.getSerInvokeInsId());
	    		serInvokeInsName = serInvokeIns.getSerInvokeInsName();
	    	}else{
	    		//无则创建服务调用实例
				String messageFlowId = "";
				String serviceName = "";
	    		service.setServiceId(Integer.parseInt(serviceId));
	    		serviceHashMap = getServiceManagerServ().queryServiceByServiceId(service);
	    		if(serviceHashMap!=null && serviceHashMap.get("MESSAGE_FLOW_ID")!=null){
	    			messageFlowId	= serviceHashMap.get("MESSAGE_FLOW_ID").toString();
	    			serviceName		= serviceHashMap.get("SERVICE_EN_NAME").toString();
	    			
		    		serInvokeInsName = serviceName+"_Invoker";
		    		serInvokeIns.setMessageFlowId(Integer.valueOf(messageFlowId));
		    		serInvokeIns.setSerInvokeInsName(serInvokeInsName);
		    		serInvokeIns.setState("A");
			    	serInvokeInsId  =getServiceManagerServ().insertSerInvokeIns(serInvokeIns).toString();
	    		}else{
	    			failureInfo ="This service does not specify a default message flow. (serviceId="+serviceId+")";
	    		}
	    	}
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String retＭsg="";
			if(serInvokeInsId !=null && !serInvokeInsId.equals("")){
				String SIIInfo="{\"SER_INVOKE_INS_ID\":\""+serInvokeInsId+"\",\"SER_INVOKE_INS_NAME\":\""+serInvokeInsName+"\"}";
				retＭsg="[{\"msg\":\"ok\",\"SIIInfo\":"+SIIInfo+"}]";
			}else{
				retＭsg="[{\"msg\":\"failure\",\"FailureInfo\":\""+failureInfo+"\"}]";
			}
			out.print(retＭsg);
		}  catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete service exceptions",null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
    }
    
		
	/**
	 * ��ȡservʵ��
	 * @return
	 */
	public IServiceManagerServ getServiceManagerServ() {
		if(iServiceManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				iServiceManagerServ = (IServiceManagerServ)ctx.getBean("eaap-op2-conf-service-manager-service") ;
	     }
		return iServiceManagerServ;
	}
	public Service getService() {
		return service;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public Pagination getPagination() {
		return pagination;
	}
	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}
	public List<Map> getContractList() {
		return contractList;
	}
	public void setContractList(List<Map> contractList) {
		this.contractList = contractList;
	}
	public IServiceManagerServ getServerManagerService() {
		return serverManagerService;
	}
	public void setServerManagerService(IServiceManagerServ serverManagerService) {
		this.serverManagerService = serverManagerService;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public List<Map<String, Object>> getResultList() {
		return resultList;
	}

	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}
	public List<Map<String, Object>> getServiceCategoryResultList() {
		return serviceCategoryResultList;
	}
	public void setServiceCategoryResultList(
			List<Map<String, Object>> serviceCategoryResultList) {
		this.serviceCategoryResultList = serviceCategoryResultList;
	}
	public List<Map<String, Object>> getDefaultFlowResultList() {
		return defaultFlowResultList;
	}
	public void setDefaultFlowResultList(
			List<Map<String, Object>> defaultFlowResultList) {
		this.defaultFlowResultList = defaultFlowResultList;
	}
	public List<Map> getDefaultFlowList() {
		return defaultFlowList;
	}
	public void setDefaultFlowList(List<Map> defaultFlowList) {
		this.defaultFlowList = defaultFlowList;
	}
	public List<Map<String, Object>> getProtocolVersionResultList() {
		return protocolVersionResultList;
	}
	public void setProtocolVersionResultList(
			List<Map<String, Object>> protocolVersionResultList) {
		this.protocolVersionResultList = protocolVersionResultList;
	}
	public List<Map> getServiceList() {
		return serviceList;
	}
	public void setServiceList(List<Map> serviceList) {
		this.serviceList = serviceList;
	}
	public Map getServiceHashMap() {
		return serviceHashMap;
	}
	public void setServiceHashMap(Map serviceHashMap) {
		this.serviceHashMap = serviceHashMap;
	}
	public Map getDirSeletedTreeMap() {
		return DirSeletedTreeMap;
	}
	public void setDirSeletedTreeMap(Map dirSeletedTreeMap) {
		DirSeletedTreeMap = dirSeletedTreeMap;
	}
	public Map getFuncSeletedTreeMap() {
		return FuncSeletedTreeMap;
	}
	public void setFuncSeletedTreeMap(Map funcSeletedTreeMap) {
		FuncSeletedTreeMap = funcSeletedTreeMap;
	}
	public Map getSwitchMap() {
		return switchMap;
	}
	public void setSwitchMap(Map switchMap) {
		this.switchMap = switchMap;
	}
	public List<Map<String, Object>> getCommProtocalResultList() {
		return commProtocalResultList;
	}
	public void setCommProtocalResultList(
			List<Map<String, Object>> commProtocalResultList) {
		this.commProtocalResultList = commProtocalResultList;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getServiceCode() {
		return serviceCode;
	}
	public void setServiceCode(String serviceCode) {
		this.serviceCode = serviceCode;
	}
	public String getServiceMsgFlowId() {
		return ServiceMsgFlowId;
	}
	public void setServiceMsgFlowId(String serviceMsgFlowId) {
		ServiceMsgFlowId = serviceMsgFlowId;
	}
	public String getServiceMsgFlowName() {
		return ServiceMsgFlowName;
	}
	public void setServiceMsgFlowName(String serviceMsgFlowName) {
		ServiceMsgFlowName = serviceMsgFlowName;
	}
	public Component getComponent() {
		return component;
	}
	public void setComponent(Component component) {
		this.component = component;
	}
	public TechImpl getTechImpl() {
		return techImpl;
	}
	public void setTechImpl(TechImpl techImpl) {
		this.techImpl = techImpl;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	public List<Map> getCcTypeList() {
		return ccTypeList;
	}
	public void setCcTypeList(List<Map> ccTypeList) {
		this.ccTypeList = ccTypeList;
	}
	public List<Map> getCycleTyleList() {
		return cycleTyleList;
	}
	public void setCycleTyleList(List<Map> cycleTyleList) {
		this.cycleTyleList = cycleTyleList;
	}
	public List<Map> getCc2cStatelist() {
		return cc2cStatelist;
	}
	public void setCc2cStatelist(List<Map> cc2cStatelist) {
		this.cc2cStatelist = cc2cStatelist;
	}
	public List<Map> getCutmsValueTypelist() {
		return cutmsValueTypelist;
	}
	public void setCutmsValueTypelist(List<Map> cutmsValueTypelist) {
		this.cutmsValueTypelist = cutmsValueTypelist;
	}
	public CtlCounterms2Tech getCtlCounterms2Tech() {
		return ctlCounterms2Tech;
	}
	public void setCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech) {
		this.ctlCounterms2Tech = ctlCounterms2Tech;
	}
	public ControlCounterms getControlCouterms() {
		return controlCouterms;
	}
	public void setControlCouterms(ControlCounterms controlCouterms) {
		this.controlCouterms = controlCouterms;
	}
	public String getTechImplId() {
		return techImplId;
	}
	public void setTechImplId(String techImplId) {
		this.techImplId = techImplId;
	}
	public String getTechImplName() {
		return techImplName;
	}
	public void setTechImplName(String techImplName) {
		this.techImplName = techImplName;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOrgId() {
		return orgId;
	}
	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}
	public Map getSerHashMap() {
		return serHashMap;
	}
	public void setSerHashMap(Map serHashMap) {
		this.serHashMap = serHashMap;
	}

	public String getSerTechImplId() {
		return serTechImplId;
	}

	public void setSerTechImplId(String serTechImplId) {
		this.serTechImplId = serTechImplId;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
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

	public void setEndpoint_Spec_Attr_Id(String endpointSpecAttrId) {
		endpoint_Spec_Attr_Id = endpointSpecAttrId;
	}

	public SerTechImpl getSerTechImpl() {
		return serTechImpl;
	}

	public void setSerTechImpl(SerTechImpl serTechImpl) {
		this.serTechImpl = serTechImpl;
	}
	public Map getContractHashMap() {
		return contractHashMap;
	}
	public void setContractHashMap(Map contractHashMap) {
		this.contractHashMap = contractHashMap;
	}
	public List<Map> getLoadServiceMessgList() {
		return loadServiceMessgList;
	}
	public void setLoadServiceMessgList(List<Map> loadServiceMessgList) {
		this.loadServiceMessgList = loadServiceMessgList;
	}
	public Api getApi() {
		return api;
	}
	public void setApi(Api api) {
		this.api = api;
	}
	public StringBuffer getFlowUrl() {
		return flowUrl;
	}
	public void setFlowUrl(StringBuffer flowUrl) {
		this.flowUrl = flowUrl;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getServiceFlag() {
		return serviceFlag;
	}
	public void setServiceFlag(String serviceFlag) {
		this.serviceFlag = serviceFlag;
	}
	public String getPageShowMsg() {
		return pageShowMsg;
	}
	public void setPageShowMsg(String pageShowMsg) {
		this.pageShowMsg = pageShowMsg;
	}
	public String getServiceAPI() {
		return serviceAPI;
	}
	public void setServiceAPI(String serviceAPI) {
		this.serviceAPI = serviceAPI;
	}
	public String getAttr_spec_id() {
		return attr_spec_id;
	}
	public void setAttr_spec_id(String attr_spec_id) {
		this.attr_spec_id = attr_spec_id;
	}
	
	public String getSerInvokeInsId() {
		return serInvokeInsId;
	}
	public void setSerInvokeInsId(String serInvokeInsId) {
		this.serInvokeInsId = serInvokeInsId;
	}
	public String getSerInvokeInsName() {
		return serInvokeInsName;
	}
	public void setSerInvokeInsName(String serInvokeInsName) {
		this.serInvokeInsName = serInvokeInsName;
	}
	public SerInvokeIns getSerInvokeIns() {
		return serInvokeIns;
	}
	public void setSerInvokeIns(SerInvokeIns serInvokeIns) {
		this.serInvokeIns = serInvokeIns;
	}
	
	public String getMsgFlowUrl() {
		return msgFlowUrl;
	}
	public void setMsgFlowUrl(String msgFlowUrl) {
		this.msgFlowUrl = msgFlowUrl;
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
