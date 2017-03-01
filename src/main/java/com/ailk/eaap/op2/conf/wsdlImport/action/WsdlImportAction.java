package com.ailk.eaap.op2.conf.wsdlImport.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.WsdlImport;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.contract.service.IContractService;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.serviceManager.service.IServiceManagerServ;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.conf.wsdlImport.service.IWsdlImportService;
import com.ailk.eaap.op2.conf.wsdlImport.service.IWsdlService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

public class WsdlImportAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();

	private String WsdlInfo;
	private String editOrAdd ;
	private IWsdlImportService wsdlImportService;
	private List<Map> importObjectTypeList = new ArrayList<Map>();
    private IConfManagerServ confManagerServ ;
	private String pageState ;
	private String saveResult;
	private ContractDoc contractDoc = new ContractDoc();
	private WsdlImport wsdlImport = new WsdlImport();
	private List<Map> selectStateList = new ArrayList<Map>();
    private List<Map<String, Object>> conTypeList;
    private IContractService contractService;  
    private List<Map<String, Object>> nevlConsTypeList;
	private IServiceManagerServ iServiceManagerServ;
	private String wsdlJsonStr;

	private String resourceAlias;
	private String docVersion;
	private String importObjectType;
	private String importFile;
	private String importURL;
	private String fileAttachId;
	private String fileType;
	private String serviceAgentUrl;
	private String importId;
	
	public WsdlImportAction() {
	}
	
	public String wsdlImportList(){
		Map objTypeMap = new HashMap() ;
		objTypeMap = getMainInfo(EAAPConstants.WSDL_IMPORT_OBJECT_TYPE) ;
		Iterator iter = objTypeMap.entrySet().iterator();   
		while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 importObjectTypeList.add(mapTmp) ;
		}
		return SUCCESS;
	}
	
	public Map getWsdlImportList(Map para){
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		startRow = (pageNum - 1) * rows + 1;

		Map map = new HashMap() ;
		map.put("resourceAlias", "".equals(getRequest().getParameter("resourceAlias"))?null:getRequest().getParameter("resourceAlias")) ;
		map.put("importObjectType", "".equals(getRequest().getParameter("importObjectType"))?null:getRequest().getParameter("importObjectType")) ;
		if(para.get("importTimeBegin")!=null && !"".equals(para.get("importTimeBegin").toString())){
			map.put("importTimeBegin",para.get("importTimeBegin").toString()+" 00:00:00");
		}
		if(para.get("importTimeEnd")!=null && !"".equals(para.get("importTimeEnd").toString())){
			map.put("importTimeEnd",para.get("importTimeEnd").toString()+" 23:59:59"); 
		}
		map.put("queryType", "ALLNUM") ;
		total=Integer.valueOf(String.valueOf(getWsdlImportService().getWsdlImportList(map).get(0).get("ALLNUM"))) ;
		map.put("queryType", "") ;
		map.put("pro", startRow);
        map.put("end", startRow+rows-1);
        map.put("pro_mysql", startRow - 1);
        map.put("page_record", rows);
        List<Map> wsdlImportList = getWsdlImportService().getWsdlImportList(map) ;

		Map returnMap = new HashMap();
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(wsdlImportList));

		return returnMap ;
	}

	public String wsdlImport(){
		Map objTypeMap = new HashMap() ;
		objTypeMap = getMainInfo(EAAPConstants.WSDL_IMPORT_OBJECT_TYPE) ;
		Iterator iter = objTypeMap.entrySet().iterator();   
		while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 importObjectTypeList.add(mapTmp) ;
		}
		
		serviceAgentUrl = WebPropertyUtil.getPropertyValue("serviceAgentUrl");	//获取公共配置文件（eaap_common.properties）中配置的服务引擎地址
		//“是否需要校验”下拉框:
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.prov.yes"));
		 serInvokeInsStateMap1.put("code", "Y");			 
		 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.no"));
		 serInvokeInsStateMap2.put("code", "N");
		 selectStateList.add(serInvokeInsStateMap1);
		 selectStateList.add(serInvokeInsStateMap2);
		 //“协议格式类型”下拉框::
		conTypeList = getContractService().selectConType(EAAPConstants.MAINDATACONTYPE);
		//“节点值约束类型”下拉框::
		nevlConsTypeList = getContractService().selectConType(EAAPConstants.NEVLCONSTYPE);
		
		return SUCCESS;
	}


	public void resourceAliasCheck(){ 
		PrintWriter out = null;
		try {
			
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId = CommonUtil.getTenantId(session);
			
			String resourceAlias = getRequest().getParameter("resourceAlias");
			String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
			boolean isHas = ws.hasResourceAliss(resourceAlias,tenantId.toString());
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"isHas\":\""+isHas+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
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
	
	public void resourceAliasCheck_bak(){
		PrintWriter out =null;
		try {
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId = CommonUtil.getTenantId(session);
			String isHas = "false";
			String resourceAlias = getRequest().getParameter("resourceAlias");
			
			String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
			List<Map<String, Object>> cdList = ws.getContractDocVersionList(resourceAlias,tenantId.toString());
			String docVersions = "";
			if(cdList.size()>0){
				isHas = "true";
				for (int i=0 ; i<cdList.size() ; i++){
					Map<String, Object> hashMap = cdList.get(i);
					if(i==0){
						docVersions = hashMap.get("DOC_VERSION").toString();
					}else{
						docVersions = docVersions+",  "+hashMap.get("DOC_VERSION");
					}
				}
			}
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"isHas\":\""+isHas+"\",\"docVersions\":\""+docVersions+"\"}]";
			out.print(ret);
		} catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
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

	public void resourceAliasVersionCheck(){
		PrintWriter out =null;
		try {
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId = CommonUtil.getTenantId(session);
			String resourceAlias = getRequest().getParameter("resourceAlias");
			String docVersion = getRequest().getParameter("docVersion");
			String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
			boolean isHas = ws.hasResourceAlissVersion(resourceAlias, docVersion,tenantId.toString());
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"isHas\":\""+isHas+"\"}]";
			out.print(ret);
		} catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
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
	
	public String wsdlParse(){
		serviceAgentUrl = WebPropertyUtil.getPropertyValue("serviceAgentUrl");	//获取公共配置文件（eaap_common.properties）中配置的服务引擎地址
		//“是否需要校验”下拉框:
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.prov.yes"));
		 serInvokeInsStateMap1.put("code", "Y");			 
		 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.no"));
		 serInvokeInsStateMap2.put("code", "N");
		 selectStateList.add(serInvokeInsStateMap1);
		 selectStateList.add(serInvokeInsStateMap2);
		 
		 //“协议格式类型”下拉框:
		conTypeList = getContractService().selectConType(EAAPConstants.MAINDATACONTYPE);
		//“节点值约束类型”下拉框:
		nevlConsTypeList = getContractService().selectConType(EAAPConstants.NEVLCONSTYPE);
		
		resourceAlias = getRequest().getParameter("resourceAlias");
		docVersion = getRequest().getParameter("docVersion");
		importObjectType = getRequest().getParameter("importObjectType");
		importFile = getRequest().getParameter("importFile");
		importURL = getRequest().getParameter("importURL");
		fileAttachId = getRequest().getParameter("attach_id");
		fileType = getRequest().getParameter("fileType");
				
		//调接口解析：
		String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
		String retInfo="";
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = CommonUtil.getTenantId(session);
		
		if(importObjectType.equals("1")){
			//文件方式
			String wsdlType ="0";  		//0：非压缩文件，1：压缩文件（*.rar、*.zip）
			if(importFile.toLowerCase().indexOf(".rar")>-1 || importFile.toLowerCase().indexOf(".zip")>-1){
				wsdlType="1";	
			}
			retInfo = ws.judgeWsdl(fileAttachId, wsdlType, resourceAlias, docVersion,tenantId.toString());		//附件保存在“FILE_SHARE”表里，fileAttachId为附件ID
		}else{
			//URL方式
			retInfo = ws.parseWsdl(importURL, resourceAlias, docVersion,tenantId.toString());
		}		
		//retInfo = "{\"dataFlow\":{\"wsdlFileShare\":{\"contractDoc\":{\"contractDocId\":434,\"baseConDocId\":\"\",\"docType\":\"1\",\"docName\":\"DEPService?wsdl\",\"resourceAliss\":\"wsdl_import_test_001\",\"docVersion\":\"v1\",\"docCreateTime\":\"2014-09-30 11:03:07\",\"state\":\"A\",\"docPath\":\"\",\"address\":\"http://10.1.249.61:8088/serviceAgentWeb/services/DEPService?wsdl\",\"contracts\":[{\"contract\":{\"contractId\":800001322,\"baseContractId\":\"\",\"name\":\"wsdl_import_test_001.apiexchange\",\"code\":\"wsdl_import_test_001.apiexchange.v1\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"descriptor\":\"\",\"contractVersion\":{\"contractVersionId\":800000347,\"contractId\":800001322,\"version\":\"wsdl_import_test_001.apiexchange.v1\",\"createTime\":\"2014-09-30 11:03:07\",\"isNeedCheck\":\"Y\",\"state\":\"A\",\"effDate\":\"2014-09-30 11:03:07\",\"expDate\":\"3000-01-01 00:00:00\",\"descriptor\":\"\",\"contractFormats\":[{\"contractFormatId\":101723,\"contractVersionId\":800000347,\"reqRsp\":\"REQ\",\"conType\":\"1\",\"xsdHeaderFor\":\"\",\"xsdFormat\":\"\",\"xsdDemo\":\"\",\"state\":\"A\",\"descriptor\":\"\",\"nodeDescs\":[{\"nodeDescId\":31035,\"tcpCtrFId\":101723,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv:Envelope\",\"nodePath\":\"\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedCheck\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31036,\"tcpCtrFId\":101723,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv=http://schemas.xmlsoap.org/soap/envelope/\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31037,\"tcpCtrFId\":101723,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"chin=http://www.chinatelecom.hub.com\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31038,\"tcpCtrFId\":101723,\"parentNodeId\":31035,\"nodeName\":\"soapenv:Header\",\"nodeCode\":\"soapenv:Header\",\"nodePath\":\"/soapenv:Envelope/soapenv:Header\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31039,\"tcpCtrFId\":101723,\"parentNodeId\":31035,\"nodeName\":\"soapenv:Body\",\"nodeCode\":\"soapenv:Body\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31040,\"tcpCtrFId\":101723,\"parentNodeId\":31039,\"nodeName\":\"chin:apiexchange\",\"nodeCode\":\"chin:apiexchange\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:apiexchange\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31041,\"tcpCtrFId\":101723,\"parentNodeId\":31040,\"nodeName\":\"chin:in0\",\"nodeCode\":\"chin:in0\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:apiexchange/chin:in0\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"}]},{\"contractFormatId\":101724,\"contractVersionId\":800000347,\"reqRsp\":\"RSP\",\"conType\":\"1\",\"xsdHeaderFor\":\"\",\"xsdFormat\":\"\",\"xsdDemo\":\"\",\"state\":\"A\",\"descriptor\":\"\",\"nodeDescs\":[{\"nodeDescId\":31042,\"tcpCtrFId\":101724,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv:Envelope\",\"nodePath\":\"\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedCheck\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31043,\"tcpCtrFId\":101724,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv=http://schemas.xmlsoap.org/soap/envelope/\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31044,\"tcpCtrFId\":101724,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"chin=http://www.chinatelecom.hub.com\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31045,\"tcpCtrFId\":101724,\"parentNodeId\":31042,\"nodeName\":\"soapenv:Header\",\"nodeCode\":\"soapenv:Header\",\"nodePath\":\"/soapenv:Envelope/soapenv:Header\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31046,\"tcpCtrFId\":101724,\"parentNodeId\":31042,\"nodeName\":\"soapenv:Body\",\"nodeCode\":\"soapenv:Body\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31047,\"tcpCtrFId\":101724,\"parentNodeId\":31046,\"nodeName\":\"chin:apiexchangeResponse\",\"nodeCode\":\"chin:apiexchangeResponse\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:apiexchangeResponse\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31048,\"tcpCtrFId\":101724,\"parentNodeId\":31047,\"nodeName\":\"chin:out\",\"nodeCode\":\"chin:out\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:apiexchangeResponse/chin:out\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"}]}],\"service\":{\"contractVersionId\":800000347,\"serviceCnName\":\"wsdl_import_test_001.v1.apiexchange\",\"serviceEnName\":\"wsdl_import_test_001.v1.apiexchange\",\"serviceCode\":\"wsdl_import_test_001.apiexchange\",\"serviceType\":\"0\",\"serviceVersion\":\"wsdl_import_test_001.apiexchange.v1\",\"auditFlowId\":\"\",\"createTime\":\"2014-09-30 11:03:07\",\"state\":\"A\",\"serviceDesc\":\"\",\"isPublished\":\"Y\",\"servicePriority\":\"3\",\"serviceTimeout\":300}}}},{\"contract\":{\"contractId\":800001323,\"baseContractId\":\"\",\"name\":\"wsdl_import_test_001.exchange\",\"code\":\"wsdl_import_test_001.exchange.v1\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"descriptor\":\"\",\"contractVersion\":{\"contractVersionId\":800000348,\"contractId\":800001323,\"version\":\"wsdl_import_test_001.exchange.v1\",\"createTime\":\"2014-09-30 11:03:07\",\"isNeedCheck\":\"Y\",\"state\":\"A\",\"effDate\":\"2014-09-30 11:03:07\",\"expDate\":\"3000-01-01 00:00:00\",\"descriptor\":\"\",\"contractFormats\":[{\"contractFormatId\":101725,\"contractVersionId\":800000348,\"reqRsp\":\"REQ\",\"conType\":\"1\",\"xsdHeaderFor\":\"\",\"xsdFormat\":\"\",\"xsdDemo\":\"\",\"state\":\"A\",\"descriptor\":\"\",\"nodeDescs\":[{\"nodeDescId\":31049,\"tcpCtrFId\":101725,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv:Envelope\",\"nodePath\":\"\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedCheck\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31050,\"tcpCtrFId\":101725,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv=http://schemas.xmlsoap.org/soap/envelope/\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31051,\"tcpCtrFId\":101725,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"chin=http://www.chinatelecom.hub.com\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31052,\"tcpCtrFId\":101725,\"parentNodeId\":31049,\"nodeName\":\"soapenv:Header\",\"nodeCode\":\"soapenv:Header\",\"nodePath\":\"/soapenv:Envelope/soapenv:Header\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31053,\"tcpCtrFId\":101725,\"parentNodeId\":31049,\"nodeName\":\"soapenv:Body\",\"nodeCode\":\"soapenv:Body\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31054,\"tcpCtrFId\":101725,\"parentNodeId\":31053,\"nodeName\":\"chin:exchange\",\"nodeCode\":\"chin:exchange\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:exchange\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31055,\"tcpCtrFId\":101725,\"parentNodeId\":31054,\"nodeName\":\"chin:in0\",\"nodeCode\":\"chin:in0\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:exchange/chin:in0\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"}]},{\"contractFormatId\":101726,\"contractVersionId\":800000348,\"reqRsp\":\"RSP\",\"conType\":\"1\",\"xsdHeaderFor\":\"\",\"xsdFormat\":\"\",\"xsdDemo\":\"\",\"state\":\"A\",\"descriptor\":\"\",\"nodeDescs\":[{\"nodeDescId\":31056,\"tcpCtrFId\":101726,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv:Envelope\",\"nodePath\":\"\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedCheck\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31057,\"tcpCtrFId\":101726,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"soapenv=http://schemas.xmlsoap.org/soap/envelope/\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31058,\"tcpCtrFId\":101726,\"parentNodeId\":\"\",\"nodeName\":\"soapenv:Envelope\",\"nodeCode\":\"chin=http://www.chinatelecom.hub.com\",\"nodePath\":\"\",\"nodeType\":\"6\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31059,\"tcpCtrFId\":101726,\"parentNodeId\":31056,\"nodeName\":\"soapenv:Header\",\"nodeCode\":\"soapenv:Header\",\"nodePath\":\"/soapenv:Envelope/soapenv:Header\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31060,\"tcpCtrFId\":101726,\"parentNodeId\":31056,\"nodeName\":\"soapenv:Body\",\"nodeCode\":\"soapenv:Body\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31061,\"tcpCtrFId\":101726,\"parentNodeId\":31060,\"nodeName\":\"chin:exchangeResponse\",\"nodeCode\":\"chin:exchangeResponse\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:exchangeResponse\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"},{\"nodeDescId\":31062,\"tcpCtrFId\":101726,\"parentNodeId\":31061,\"nodeName\":\"chin:out\",\"nodeCode\":\"chin:out\",\"nodePath\":\"/soapenv:Envelope/soapenv:Body/chin:exchangeResponse/chin:out\",\"nodeType\":\"2\",\"nodeLengthCons\":\"\",\"nodeTypeCons\":\"\",\"nodeNumberCons\":\"\",\"nevlConsType\":\"\",\"nevlConsValue\":\"\",\"nevlConsDesc\":\"\",\"isNeedSign\":\"\",\"state\":\"A\",\"createTime\":\"2014-09-30 11:03:07\",\"javaField\":\"\",\"description\":\"\"}]}],\"service\":{\"contractVersionId\":800000348,\"serviceCnName\":\"wsdl_import_test_001.v1.exchange\",\"serviceEnName\":\"wsdl_import_test_001.v1.exchange\",\"serviceCode\":\"wsdl_import_test_001.exchange\",\"serviceType\":\"0\",\"serviceVersion\":\"wsdl_import_test_001.exchange.v1\",\"auditFlowId\":\"\",\"createTime\":\"2014-09-30 11:03:07\",\"state\":\"A\",\"serviceDesc\":\"\",\"isPublished\":\"Y\",\"servicePriority\":\"3\",\"serviceTimeout\":300}}}}],\"xsdContractDocs\":[]}}}}";
		//retInfo = "{\"RespCode\":\"400\",\"RespDesc\":\"data is null\"}";   //反回异常信息
		boolean isJson = isJson(retInfo);
		if(isJson){
			WsdlInfo = "{\"WsdlInfo\":"+retInfo+"}";
		}else{
			WsdlInfo = "{\"WsdlInfo\":{\"RespCode\":\"400\",\"RespDesc\":\""+retInfo+"\"}}";    //反回异常信息
			log.error(LogModel.EVENT_APP_EXCPT,"WSDL Parse Result: "+retInfo);
		}
		log.debug("WSDL Parse Result: "+WsdlInfo);
		return SUCCESS;
	}
	

	public void wsdlToParse(){
		PrintWriter out =null;
		try {
			resourceAlias = getRequest().getParameter("resourceAlias");
//			docVersion = getRequest().getParameter("docVersion");
			importObjectType = getRequest().getParameter("importObjectType");
			importFile = getRequest().getParameter("importFile");
			importURL = getRequest().getParameter("importURL");
			fileAttachId = getRequest().getParameter("fileAttachId");
					
			//调接口解析：
			String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
			String retInfo="";
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId = CommonUtil.getTenantId(session);
			if(importObjectType.equals("1")){
				//文件方式
				fileType="0";  		//0：非压缩文件，1：压缩文件（*.rar、*.zip）
				if(importFile.toLowerCase().indexOf(".rar")>-1 || importFile.toLowerCase().indexOf(".zip")>-1){
					fileType="1";	
				}
				retInfo = ws.judgeWsdl(fileAttachId, fileType, resourceAlias, "",tenantId.toString());		//附件保存在“FILE_SHARE”表里，fileAttachId为附件ID
			}else{
				//URL方式
				retInfo = ws.parseWsdl(importURL, resourceAlias, "",tenantId.toString()); 
			}
			
			boolean isJson = isJson(retInfo);
			if(isJson){
				WsdlInfo = "{\"WsdlInfo\":"+retInfo+"}";
			}else{
				WsdlInfo = "{\"WsdlInfo\":{\"RespCode\":\"400\",\"RespDesc\":\""+retInfo+"\"}}";    //反回异常信息
				log.error(LogModel.EVENT_APP_EXCPT,"WSDL Parse Result: "+retInfo);
			}
			log.debug("WSDL Parse Result: "+WsdlInfo);
	
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			out.print(WsdlInfo);
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
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
	
    public boolean isJson(String json) {
        if (StringUtils.isBlank(json)) {  
            return false;  
        }  
        try {  
        	JSONObject jsonobj = new JSONObject();
        	jsonobj = JSONObject.fromObject(json);
            return true;  
        } catch (Exception e) {
			log.error("bad json: " + json);
            return false;  
        }  
    }


	//根据ContractId获取协议基类信息
	public void getBaseContractInfo(){
		PrintWriter out =null;
		String  msg ="";
		try {
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    
			JSONObject wsdlJson = new JSONObject ();
			String baseContractId = getRequest().getParameter("baseContractId");
		    DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
			if(baseContractId != null && !baseContractId.equals("")){
				Contract contract = new Contract();
				contract.setContractId(Integer.parseInt(baseContractId));
				contract = this.getContractService().findContract(contract);		//协议基本信息
				if(contract !=null){
					wsdlJson.put("contractId", contract.getContractId());	
					wsdlJson.put("name", contract.getName());
					wsdlJson.put("code", contract.getCode());
					wsdlJson.put("state", contract.getState());
					wsdlJson.put("createTime", (contract.getCreateTime()==null?"":format.format(contract.getCreateTime())));
					wsdlJson.put("descriptor", contract.getDescriptor());
				}
				
				Integer contractVersionId =0;
				JSONObject contractVersionJson = new JSONObject ();
				ContractVersion contractVersion = new ContractVersion();
				contractVersion.setContractId(baseContractId);
				contractVersion = getContractService().findContractVersion(contractVersion);			//协议版本信息
				if(contractVersion !=null){
					contractVersionId = contractVersion.getContractVersionId();
					contractVersionJson.put("contractVersionId", contractVersionId);	
					contractVersionJson.put("version", (contractVersion.getVersion()==null?"":contractVersion.getVersion()));	
					contractVersionJson.put("createTime",(contractVersion.getCreateTime()==null?"":contractVersion.getCreateTime()));	
					contractVersionJson.put("isNeedCkeck", (contractVersion.getIsNeedCheck()==null?"":contractVersion.getIsNeedCheck()));	
					contractVersionJson.put("state", (contractVersion.getState()==null?"":contractVersion.getState()));	
					contractVersionJson.put("effDate", (contractVersion.getEffDate()==null?"":format.format(contractVersion.getEffDate())));	
					contractVersionJson.put("expDate", (contractVersion.getExpDate()==null?"":format.format(contractVersion.getExpDate())));	
					contractVersionJson.put("descriptor", (contractVersion.getDescriptor()==null?"":contractVersion.getDescriptor()));	
				}
				if(contractVersionId != 0){
						//请求
						JSONArray contractFormatsJsonArray = new JSONArray();
		                JSONObject reqFormatJson = new JSONObject ();
						ContractFormat contractFormat = new ContractFormat();
						contractFormat.setContractVersionId(contractVersionId);
						contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
						contractFormat = getContractService().findContractFormat(contractFormat);			//协议版本请求定义
						if(contractFormat !=null){
							reqFormatJson.put("contractFormatId", (contractFormat.getTcpCtrFId()==null?"":contractFormat.getTcpCtrFId()));
							reqFormatJson.put("reqRsp", "REQ");
							reqFormatJson.put("conType", (contractFormat.getConType()==null?"":contractFormat.getConType()));
							reqFormatJson.put("xsdHeaderFor", (contractFormat.getXsdHeaderFor()==null?"":contractFormat.getXsdHeaderFor()));
							reqFormatJson.put("xsdFormat", (contractFormat.getXsdFormat()==null?"":contractFormat.getXsdFormat()));
							reqFormatJson.put("xsdDemo", (contractFormat.getXsdDemo()==null?"":contractFormat.getXsdDemo()));
							reqFormatJson.put("state", (contractFormat.getState()==null?"":contractFormat.getState()));
							reqFormatJson.put("descriptor", (contractFormat.getDescriptor()==null?"":contractFormat.getDescriptor()));
							//请求节点描述定义:
							if(contractFormat.getTcpCtrFId()!=null){
									List<Map<String, String>> reqNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());   
									JSONArray reqNodeDescArray = new JSONArray();
					                if(reqNodeDescList!=null && reqNodeDescList.size()>0){
										for(int i=0;i<reqNodeDescList.size();i++){
							                JSONObject nodeDescJson = new JSONObject ();
											nodeDescJson.put("nodeDescId", reqNodeDescList.get(i).get("NODEDESCID"));
											nodeDescJson.put("nodeName", (reqNodeDescList.get(i).get("NODENAME")==null?"":reqNodeDescList.get(i).get("NODENAME")));		//
											nodeDescJson.put("nodeCode", (reqNodeDescList.get(i).get("NODECODE")==null?"":reqNodeDescList.get(i).get("NODECODE")));
											nodeDescJson.put("nodePath", (reqNodeDescList.get(i).get("NODEPATH")==null?"":reqNodeDescList.get(i).get("NODEPATH")));			//
											nodeDescJson.put("nodeType", (reqNodeDescList.get(i).get("NODETYPE")==null?"":reqNodeDescList.get(i).get("NODETYPE")));
											nodeDescJson.put("nodeLengthCons", (reqNodeDescList.get(i).get("NODELENGTHCONS")==null?"":reqNodeDescList.get(i).get("NODELENGTHCONS")));		//
											nodeDescJson.put("nodeTypeCons", (reqNodeDescList.get(i).get("NODETYPECONS")==null?"":reqNodeDescList.get(i).get("NODETYPECONS")));
											nodeDescJson.put("nodeNumberCons", (reqNodeDescList.get(i).get("NODENUMBERCONS")==null?"":reqNodeDescList.get(i).get("NODENUMBERCONS")));
											nodeDescJson.put("nevlConsType", (reqNodeDescList.get(i).get("NEVLCONSTYPE")==null?"":reqNodeDescList.get(i).get("NEVLCONSTYPE")));
											nodeDescJson.put("nevlConsValue", (reqNodeDescList.get(i).get("NEVLCONSVALUE")==null?"":reqNodeDescList.get(i).get("NEVLCONSVALUE")));		//
											nodeDescJson.put("nevlConsDesc", (reqNodeDescList.get(i).get("NEVLCONSDESC")==null?"":reqNodeDescList.get(i).get("NEVLCONSDESC")));
											nodeDescJson.put("isNeedCheck", (reqNodeDescList.get(i).get("ISNEEDCHECK")==null?"":reqNodeDescList.get(i).get("ISNEEDCHECK")));
											nodeDescJson.put("isNeedSign", (reqNodeDescList.get(i).get("ISNEEDSIGN")==null?"":reqNodeDescList.get(i).get("ISNEEDSIGN")));
											nodeDescJson.put("state", (reqNodeDescList.get(i).get("STATE")==null?"":reqNodeDescList.get(i).get("STATE")));
											nodeDescJson.put("createTime", (reqNodeDescList.get(i).get("CREATETIME")==null?"":format.format(reqNodeDescList.get(i).get("CREATETIME"))));
											nodeDescJson.put("javaField",(reqNodeDescList.get(i).get("JAVAFIELD")==null?"":reqNodeDescList.get(i).get("JAVAFIELD")));
											nodeDescJson.put("description", (reqNodeDescList.get(i).get("DESCRIPTION")==null?"":reqNodeDescList.get(i).get("DESCRIPTION")));
											nodeDescJson.put("tcpCtrFId", reqNodeDescList.get(i).get("TCPCTRFID"));
											reqNodeDescArray.add(nodeDescJson);
										}
					      		  	}
									reqFormatJson.put("nodeDescs", reqNodeDescArray);
							}
							contractFormatsJsonArray.add(reqFormatJson);
						}
		
						//响应:
		                JSONObject rspFormatJson = new JSONObject ();
		                contractFormat = new ContractFormat();
						contractFormat.setContractVersionId(contractVersionId);
						contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
						contractFormat = getContractService().findContractFormat(contractFormat);			//协议版本响应定义
						if(contractFormat !=null){
							rspFormatJson.put("contractFormatId", (contractFormat.getTcpCtrFId()==null?"":contractFormat.getTcpCtrFId()));
							rspFormatJson.put("reqRsp", "RSP");
							rspFormatJson.put("conType", (contractFormat.getConType()==null?"":contractFormat.getConType()));
							rspFormatJson.put("xsdHeaderFor", (contractFormat.getXsdHeaderFor()==null?"":contractFormat.getXsdHeaderFor()));
							rspFormatJson.put("xsdFormat", (contractFormat.getXsdFormat()==null?"":contractFormat.getXsdFormat()));		///
							rspFormatJson.put("xsdDemo", (contractFormat.getXsdDemo()==null?"":contractFormat.getXsdDemo()));
							rspFormatJson.put("state", (contractFormat.getState()==null?"":contractFormat.getState()));
							rspFormatJson.put("descriptor", (contractFormat.getDescriptor()==null?"":contractFormat.getDescriptor()));
							
							 //响应节点描述定义:
							if(contractFormat.getTcpCtrFId()!=null){
									List<Map<String, String>> rspNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
									JSONArray rspNodeDescArray = new JSONArray();
					                if(rspNodeDescList!=null && rspNodeDescList.size()>0){
										for(int i=0;i<rspNodeDescList.size();i++){
							                JSONObject nodeDescJson = new JSONObject ();
											nodeDescJson.put("nodeDescId", rspNodeDescList.get(i).get("NODEDESCID"));
											nodeDescJson.put("nodeName", (rspNodeDescList.get(i).get("NODENAME")==null?"":rspNodeDescList.get(i).get("NODENAME")));		//
											nodeDescJson.put("nodeCode", (rspNodeDescList.get(i).get("NODECODE")==null?"":rspNodeDescList.get(i).get("NODECODE")));
											nodeDescJson.put("nodePath", (rspNodeDescList.get(i).get("NODEPATH")==null?"":rspNodeDescList.get(i).get("NODEPATH")));			//
											nodeDescJson.put("nodeType", (rspNodeDescList.get(i).get("NODETYPE")==null?"":rspNodeDescList.get(i).get("NODETYPE")));
											nodeDescJson.put("nodeLengthCons", (rspNodeDescList.get(i).get("NODELENGTHCONS")==null?"":rspNodeDescList.get(i).get("NODELENGTHCONS")));		//
											nodeDescJson.put("nodeTypeCons", (rspNodeDescList.get(i).get("NODETYPECONS")==null?"":rspNodeDescList.get(i).get("NODETYPECONS")));
											nodeDescJson.put("nodeNumberCons", (rspNodeDescList.get(i).get("NODENUMBERCONS")==null?"":rspNodeDescList.get(i).get("NODENUMBERCONS")));
											nodeDescJson.put("nevlConsType", (rspNodeDescList.get(i).get("NEVLCONSTYPE")==null?"":rspNodeDescList.get(i).get("NEVLCONSTYPE")));
											nodeDescJson.put("nevlConsValue", (rspNodeDescList.get(i).get("NEVLCONSVALUE")==null?"":rspNodeDescList.get(i).get("NEVLCONSVALUE")));		//
											nodeDescJson.put("nevlConsDesc", (rspNodeDescList.get(i).get("NEVLCONSDESC")==null?"":rspNodeDescList.get(i).get("NEVLCONSDESC")));
											nodeDescJson.put("isNeedCheck", (rspNodeDescList.get(i).get("ISNEEDCHECK")==null?"":rspNodeDescList.get(i).get("ISNEEDCHECK")));
											nodeDescJson.put("isNeedSign", (rspNodeDescList.get(i).get("ISNEEDSIGN")==null?"":rspNodeDescList.get(i).get("ISNEEDSIGN")));
											nodeDescJson.put("state", (rspNodeDescList.get(i).get("STATE")==null?"":rspNodeDescList.get(i).get("STATE")));
											nodeDescJson.put("createTime", (rspNodeDescList.get(i).get("CREATETIME")==null?"":format.format(rspNodeDescList.get(i).get("CREATETIME"))));
											nodeDescJson.put("javaField",(rspNodeDescList.get(i).get("JAVAFIELD")==null?"":rspNodeDescList.get(i).get("JAVAFIELD")));
											nodeDescJson.put("description", (rspNodeDescList.get(i).get("DESCRIPTION")==null?"":rspNodeDescList.get(i).get("DESCRIPTION")));
											nodeDescJson.put("tcpCtrFId", rspNodeDescList.get(i).get("TCPCTRFID"));
											rspNodeDescArray.add(nodeDescJson);
										}
					      		  	}
									rspFormatJson.put("nodeDescs", rspNodeDescArray);
							}
							contractFormatsJsonArray.add(rspFormatJson);
						}
						
						contractVersionJson.put("contractFormats", contractFormatsJsonArray);	
						wsdlJson.put("contractVersion", contractVersionJson);
				}else{
					msg = "This Protocol Base(contract_id="+baseContractId+")  can not find the corresponding Protocol version information";
				}
			}else{
				msg = "Incoming parameters error (baseContractId="+baseContractId+")";
			}
			
			if(!msg.equals("")){
				//反回异常信息:
				wsdlJson = new JSONObject ();
				wsdlJson.put("ResultCode", "Failure");	
				wsdlJson.put("ResultDesc", msg);
			}
			
			log.debug("Get Base Contract Info Result: "+wsdlJson.toString());
			
//		    String ret="[{\"msg\":\"ok\",\"baseContract\":\""+baseContract+"\"}]";
		    String ret=wsdlJson.toString();
			out.print(ret);
		} catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("{\"ResultCode\":\"Failure\",\"ResultDesc\":\""+e.getMessage()+"\"}");
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
	
	//验证contract对象的code是否存在：
	public void hasContractByCode(){
		PrintWriter out =null;
		try {
			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId = CommonUtil.getTenantId(session);
			
			String contractCode = getRequest().getParameter("contractCode");
			String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
			boolean isHas = ws.hasContractByCode(contractCode,tenantId.toString());		
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"isHas\":\""+isHas+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
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
	
	public String wsdlParseSave(){
		//调接口保存wsdl：
		HttpSession session = ServletActionContext.getRequest().getSession();
		Integer tenantId = CommonUtil.getTenantId(session);
		
		wsdlJsonStr = getRequest().getParameter("wsdlJson");
		String[] configLocations= new String[]{"classpath:eaap-op2-wsdlImportRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		IWsdlService ws = (IWsdlService)ctx.getBean("wsdlServiceRemote");
		String retInfo = ws.save(wsdlJsonStr,tenantId.toString());   	//{"RespCode":"success","RespDesc":"Save success!"}
		
		boolean isJson = isJson(retInfo);
		if(isJson){
			saveResult = retInfo;
		}else{
			saveResult = "{\"RespCode\":\"Failure\",\"RespDesc\":\""+retInfo+"\"}";    //反回异常信息
			log.error(LogModel.EVENT_APP_EXCPT, "WSDL Save Result : "+retInfo);
		}
		
		log.debug("Wsdl Save Result: "+saveResult);
		
		resourceAlias = getRequest().getParameter("resourceAlias2");
		docVersion = getRequest().getParameter("docVersion2");
		importObjectType = getRequest().getParameter("importObjectType2");
		importFile = getRequest().getParameter("importFile2");
		fileAttachId = getRequest().getParameter("fileAttachId2");
		importURL = getRequest().getParameter("importURL2");
		
        JSONObject saveResultJsonObject = JSONObject.fromObject(saveResult); 
        String respDesc = saveResultJsonObject.getString("RespDesc");	

		//wsdl导入日志保存：
        JSONObject wsdlJsonObject = JSONObject.fromObject(wsdlJsonStr); 
        JSONObject dataFlowJson =  wsdlJsonObject.getJSONObject("dataFlow");
        JSONObject wsdlFileShareJson =  dataFlowJson.getJSONObject("wsdlFileShare");
        JSONObject contractDocJson =  wsdlFileShareJson.getJSONObject("contractDoc");
		Integer contractDocId = contractDocJson.getInt("contractDocId");					//协议文档ID
		wsdlImport.setContractDocId(contractDocId);
		wsdlImport.setResourceAlias(resourceAlias);
		wsdlImport.setDocVersion(docVersion);
		wsdlImport.setImportObjectType(importObjectType);
		if(importObjectType.equals("1")){
			//文件方式
			wsdlImport.setImportFile(importFile);
			wsdlImport.setFileAttachId(fileAttachId);
			fileType="0";  		//0：非压缩文件，1：压缩文件（*.rar、*.zip）
			if(importFile.toLowerCase().indexOf(".rar")>-1 || importFile.toLowerCase().indexOf(".zip")>-1){
				fileType="1";	
			}
			wsdlImport.setFileType(fileType);
		}else{
			//URL方式
			wsdlImport.setImportUrl(importURL);
		}
		wsdlImport.setRemark(respDesc);
		getWsdlImportService().insertWsdlImport(wsdlImport);
		
		return SUCCESS;
	}
	
    public String wsdlImportSave(){
		String techImplId = getRequest().getParameter("techImplId");
		wsdlJsonStr = getRequest().getParameter("wsdlJson");
        JSONObject wsdlJsonObject = JSONObject.fromObject(wsdlJsonStr); 
        JSONObject dataFlowJson =  wsdlJsonObject.getJSONObject("dataFlow");
        JSONObject wsdlFileShareJson =  dataFlowJson.getJSONObject("wsdlFileShare");
        JSONObject contractDocJson =  wsdlFileShareJson.getJSONObject("contractDoc");
		JSONArray contractsJson = contractDocJson.getJSONArray("contracts");
		for(int i=0; i<contractsJson.size(); i++) {
			JSONObject  contractJson = contractsJson.getJSONObject(i).getJSONObject("contract");
	        JSONObject contractVersionJson =  contractJson.getJSONObject("contractVersion");
	        JSONObject serviceJson =  contractVersionJson.getJSONObject("service");
			Service service = (Service)JSONObject.toBean(serviceJson, Service.class);
			Integer serviceId = service.getServiceId();
			
	    	String serTechImplId = getServiceManagerServ().querySeqSerTechImpl();

			log.debug("Create Service Technology Implementation: "+"Ser_Tech_Impl_Id="+serTechImplId+", Service_Id="+serviceId+", TechImpl_Id="+techImplId);
			
	    	SerTechImpl serTechImpl = new SerTechImpl();
	    	serTechImpl.setSerTechImplId(Integer.parseInt(serTechImplId));
	    	serTechImpl.setServiceId(serviceId);
	    	serTechImpl.setTechImplId(Integer.parseInt(techImplId));
	    	getServiceManagerServ().insertSerTechImpl(serTechImpl);	//创建服务技术实现
	    	
	    	getServiceManagerServ().createDirectMessageFlow(serTechImplId);	//创建一个透传的消息流
		}
    	return SUCCESS;
    }
		
	public String wsdlImportShow(){
		return SUCCESS;
	}
	
	

	public void getSeq(){
		PrintWriter out =null;
		try {
			String sequenceName = getRequest().getParameter("seqName");
			Integer seqValue = getWsdlImportService().getSeq(sequenceName);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="[{\"msg\":\"ok\",\"seqValue\":\""+seqValue+"\"}]";
			out.print(ret);
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
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
	

	public String wsdlDetail(){
		serviceAgentUrl = WebPropertyUtil.getPropertyValue("serviceAgentUrl");	//获取公共配置文件（eaap_common.properties）中配置的服务引擎地址
		
		//“是否需要校验”下拉框:
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.prov.yes"));
		 serInvokeInsStateMap1.put("code", "Y");			 
		 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.no"));
		 serInvokeInsStateMap2.put("code", "N");
		 selectStateList.add(serInvokeInsStateMap1);
		 selectStateList.add(serInvokeInsStateMap2);
		 
		 //“协议格式类型”下拉框::
		conTypeList = getContractService().selectConType(EAAPConstants.MAINDATACONTYPE);
		
		//“节点值约束类型”下拉框::
		nevlConsTypeList = getContractService().selectConType(EAAPConstants.NEVLCONSTYPE);
		return SUCCESS;
	}
	
	
	public void getWsdlDetail(){
		PrintWriter out =null;
		try {
			String baseContractId ="";		//协议基类ID
			importId = getRequest().getParameter("importId");
			
			JSONObject wsdlJson = new JSONObject ();
			JSONObject dataFlowJson = new JSONObject ();
			JSONObject wsdlFileShareJson = new JSONObject ();
			
			WsdlImport wsdlImport = new WsdlImport();
			wsdlImport.setImportId(Integer.parseInt(importId));
			wsdlImport = this.getWsdlImportService().getWsdlImport(wsdlImport);	
			if(wsdlImport != null){
				ContractDoc contractDoc = new ContractDoc();
				contractDoc.setContractDocId(wsdlImport.getContractDocId());
				contractDoc = this.getContractService().returnContractDoc(contractDoc);	 //协议文档基本信息
			    DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				JSONObject contractDocJson = new JSONObject ();
				if(contractDoc !=null){
					contractDocJson.put("contractDocId", contractDoc.getContractDocId());	
					contractDocJson.put("baseConDocId",(contractDoc.getBaseConDocId()==null?"":contractDoc.getBaseConDocId()));
					contractDocJson.put("resourceAliss",(wsdlImport.getResourceAlias()==null?"":wsdlImport.getResourceAlias()));	//
					contractDocJson.put("docType",(contractDoc.getDocType()==null?"":contractDoc.getDocType()));
					contractDocJson.put("docName",(contractDoc.getDocName()==null?"":contractDoc.getDocName()));
					contractDocJson.put("docCreateTime", (contractDoc.getDocCreateTime()==null?"":format.format(contractDoc.getDocCreateTime())));
					contractDocJson.put("docVersion",(wsdlImport.getDocVersion()==null?"":wsdlImport.getDocVersion()));	//
					contractDocJson.put("state",(contractDoc.getState()==null?"":contractDoc.getState()));
					contractDocJson.put("docPath",(contractDoc.getDocPath()==null?"":contractDoc.getDocPath()));
					contractDocJson.put("lastestTime",(contractDoc.getLastestTime()==null?"":format.format(contractDoc.getLastestTime())));
					
					DocContract docContract = new DocContract();
					docContract.setContractDocId(contractDoc.getContractDocId());
					List<Map<String, Object>> docContractList = getWsdlImportService().queryDocContractList(docContract);  
					JSONArray contractsArray = new JSONArray();
	                if(docContractList!=null){
						for(int i=0;i<docContractList.size();i++){
							Map<String, Object> hashMap = docContractList.get(i);
							String contractVersionId = hashMap.get("CONTRACTVERSIONID").toString();
			                JSONObject contractInfo = getContractInfo(Integer.valueOf(contractVersionId));
			                JSONObject contractJson = new JSONObject ();
			                baseContractId = contractInfo.getString("baseContractId");	//协议基类ID
			                contractJson.put("contract", contractInfo);
							contractsArray.add(contractJson);
						}
	      		  	}
	                contractDocJson.put("contracts", contractsArray);
					wsdlFileShareJson.put("contractDoc", contractDocJson);
				}
			}
			dataFlowJson.put("wsdlFileShare", wsdlFileShareJson);
			if(baseContractId !=null && !"".equals(baseContractId)){
				JSONObject baseContractJson = getBaseContractInfoForDetail(baseContractId);
				dataFlowJson.put("baseContract", baseContractJson);
			}
			wsdlJson.put("dataFlow", dataFlowJson);
			WsdlInfo = "{\"WsdlInfo\":"+wsdlJson.toString()+"}";
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			out.print(WsdlInfo);
		} catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				WsdlInfo = "{\"WsdlInfo\":{\"RespCode\":\"400\",\"RespDesc\":\""+e.getMessage()+"\"}}";
				out.print(WsdlInfo);
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			log.debug("WSDL Detail: "+WsdlInfo);
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
	

	//根据ContractId获取协议基类信息
	public JSONObject getContractInfo(Integer contractVersionId){
		JSONObject contractJson = new JSONObject ();
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  

		//协议版本信息：
		JSONObject contractVersionJson = new JSONObject ();
		ContractVersion contractVersion = new ContractVersion();
		contractVersion.setContractVersionId(contractVersionId);
		contractVersion = getContractService().findContractVersion(contractVersion);			//协议版本信息
		String contractId="";
		if(contractVersion !=null){
			contractId = contractVersion.getContractId();
			contractVersionJson.put("contractVersionId", contractVersionId);	
			contractVersionJson.put("version", (contractVersion.getVersion()==null?"":contractVersion.getVersion()));	
			contractVersionJson.put("createTime",(contractVersion.getCreateTime()==null?"":contractVersion.getCreateTime()));	
			contractVersionJson.put("isNeedCkeck", (contractVersion.getIsNeedCheck()==null?"":contractVersion.getIsNeedCheck()));	
			contractVersionJson.put("state", (contractVersion.getState()==null?"":contractVersion.getState()));	
			contractVersionJson.put("effDate", (contractVersion.getEffDate()==null?"":format.format(contractVersion.getEffDate())));	
			contractVersionJson.put("expDate", (contractVersion.getExpDate()==null?"":format.format(contractVersion.getExpDate())));	
			contractVersionJson.put("descriptor", (contractVersion.getDescriptor()==null?"":contractVersion.getDescriptor()));	
		}
		
		//协议基本信息：
		if(contractId!=null && !contractId.equals("")){
			Contract contract = new Contract();
			contract.setContractId(Integer.parseInt(contractId));
			contract = this.getContractService().findContract(contract);		//协议基本信息
			if(contract !=null){
				contractJson.put("contractId", contract.getContractId());	
				contractJson.put("baseContractId", (contract.getBaseContractId()==null?"":contract.getBaseContractId()));	
				contractJson.put("name", contract.getName());
				contractJson.put("code", contract.getCode());
				contractJson.put("state", contract.getState());
				contractJson.put("createTime", (contract.getCreateTime()==null?"":format.format(contract.getCreateTime())));
				contractJson.put("descriptor", contract.getDescriptor());
			}
		}

		//服务信息
		JSONObject serviceJson = new JSONObject ();
		Map hashMap = new HashMap();
		hashMap.put("contractVersionId", contractVersionId);
		List<Service> serviceList =  getServiceManagerServ().selectServiceList(hashMap);
		if(serviceList!=null && serviceList.size()>0){
			Service service = serviceList.get(0);
			serviceJson.put("serviceId", service.getServiceId());
			serviceJson.put("serviceType", service.getServiceType());
			serviceJson.put("contractVersionId", service.getContractVersionId());
			serviceJson.put("serviceCnName", service.getServiceCnName());
			serviceJson.put("serviceEnName", service.getServiceEnName());
			serviceJson.put("serviceCode", service.getServiceCode());
			serviceJson.put("serviceVersion", service.getServiceVersion());
			serviceJson.put("createDate", (service.getCreateDate()==null?"":format.format(service.getCreateDate())));
			serviceJson.put("state", service.getState());
			serviceJson.put("serviceDesc", service.getServiceCode());
			serviceJson.put("isPublished", service.getIsPublished());
			serviceJson.put("servicePriority", service.getServicePriority());
			serviceJson.put("serviceTimeout", service.getServiceTimeout());
		}
		contractVersionJson.put("service", serviceJson);	
				
		//请求
		JSONArray contractFormatsJsonArray = new JSONArray();
        JSONObject reqFormatJson = new JSONObject ();
		ContractFormat contractFormat = new ContractFormat();
		contractFormat.setContractVersionId(contractVersionId);
		contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
		contractFormat = getContractService().findContractFormat(contractFormat);			//协议版本请求定义
		if(contractFormat !=null){
			reqFormatJson.put("contractFormatId", (contractFormat.getTcpCtrFId()==null?"":contractFormat.getTcpCtrFId()));
			reqFormatJson.put("reqRsp", "REQ");
			reqFormatJson.put("conType", (contractFormat.getConType()==null?"":contractFormat.getConType()));
			reqFormatJson.put("xsdHeaderFor", (contractFormat.getXsdHeaderFor()==null?"":contractFormat.getXsdHeaderFor()));
			reqFormatJson.put("xsdFormat", (contractFormat.getXsdFormat()==null?"":contractFormat.getXsdFormat()));
			reqFormatJson.put("xsdDemo", (contractFormat.getXsdDemo()==null?"":contractFormat.getXsdDemo()));
			reqFormatJson.put("state", (contractFormat.getState()==null?"":contractFormat.getState()));
			reqFormatJson.put("descriptor", (contractFormat.getDescriptor()==null?"":contractFormat.getDescriptor()));
			//请求节点描述定义:
			if(contractFormat.getTcpCtrFId()!=null){
				List<Map<String, String>> reqNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());   
				JSONArray reqNodeDescArray = new JSONArray();
                if(reqNodeDescList!=null && reqNodeDescList.size()>0){
					for(int i=0;i<reqNodeDescList.size();i++){
		                JSONObject nodeDescJson = new JSONObject ();
						nodeDescJson.put("nodeDescId", reqNodeDescList.get(i).get("NODEDESCID"));
						nodeDescJson.put("nodeName", (reqNodeDescList.get(i).get("NODENAME")==null?"":reqNodeDescList.get(i).get("NODENAME")));		//
						nodeDescJson.put("nodeCode", (reqNodeDescList.get(i).get("NODECODE")==null?"":reqNodeDescList.get(i).get("NODECODE")));
						nodeDescJson.put("nodePath", (reqNodeDescList.get(i).get("NODEPATH")==null?"":reqNodeDescList.get(i).get("NODEPATH")));			//
						nodeDescJson.put("nodeType", (reqNodeDescList.get(i).get("NODETYPE")==null?"":reqNodeDescList.get(i).get("NODETYPE")));
						nodeDescJson.put("nodeLengthCons", (reqNodeDescList.get(i).get("NODELENGTHCONS")==null?"":reqNodeDescList.get(i).get("NODELENGTHCONS")));		//
						nodeDescJson.put("nodeTypeCons", (reqNodeDescList.get(i).get("NODETYPECONS")==null?"":reqNodeDescList.get(i).get("NODETYPECONS")));
						nodeDescJson.put("nodeNumberCons", (reqNodeDescList.get(i).get("NODENUMBERCONS")==null?"":reqNodeDescList.get(i).get("NODENUMBERCONS")));
						nodeDescJson.put("nevlConsType", (reqNodeDescList.get(i).get("NEVLCONSTYPE")==null?"":reqNodeDescList.get(i).get("NEVLCONSTYPE")));
						nodeDescJson.put("nevlConsValue", (reqNodeDescList.get(i).get("NEVLCONSVALUE")==null?"":reqNodeDescList.get(i).get("NEVLCONSVALUE")));		//
						nodeDescJson.put("nevlConsDesc", (reqNodeDescList.get(i).get("NEVLCONSDESC")==null?"":reqNodeDescList.get(i).get("NEVLCONSDESC")));
						nodeDescJson.put("isNeedCheck", (reqNodeDescList.get(i).get("ISNEEDCHECK")==null?"":reqNodeDescList.get(i).get("ISNEEDCHECK")));
						nodeDescJson.put("isNeedSign", (reqNodeDescList.get(i).get("ISNEEDSIGN")==null?"":reqNodeDescList.get(i).get("ISNEEDSIGN")));
						nodeDescJson.put("state", (reqNodeDescList.get(i).get("STATE")==null?"":reqNodeDescList.get(i).get("STATE")));
						nodeDescJson.put("createTime", (reqNodeDescList.get(i).get("CREATETIME")==null?"":format.format(reqNodeDescList.get(i).get("CREATETIME"))));
						nodeDescJson.put("javaField",(reqNodeDescList.get(i).get("JAVAFIELD")==null?"":reqNodeDescList.get(i).get("JAVAFIELD")));
						nodeDescJson.put("description", (reqNodeDescList.get(i).get("DESCRIPTION")==null?"":reqNodeDescList.get(i).get("DESCRIPTION")));
						nodeDescJson.put("tcpCtrFId", reqNodeDescList.get(i).get("TCPCTRFID"));
						reqNodeDescArray.add(nodeDescJson);
					}
      		  	}
				reqFormatJson.put("nodeDescs", reqNodeDescArray);
			}
			contractFormatsJsonArray.add(reqFormatJson);
		}

		//响应:
        JSONObject rspFormatJson = new JSONObject ();
        contractFormat = new ContractFormat();
		contractFormat.setContractVersionId(contractVersionId);
		contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
		contractFormat = getContractService().findContractFormat(contractFormat);			//协议版本响应定义
		if(contractFormat !=null){
			rspFormatJson.put("contractFormatId", (contractFormat.getTcpCtrFId()==null?"":contractFormat.getTcpCtrFId()));
			rspFormatJson.put("reqRsp", "RSP");
			rspFormatJson.put("conType", (contractFormat.getConType()==null?"":contractFormat.getConType()));
			rspFormatJson.put("xsdHeaderFor", (contractFormat.getXsdHeaderFor()==null?"":contractFormat.getXsdHeaderFor()));
			rspFormatJson.put("xsdFormat", (contractFormat.getXsdFormat()==null?"":contractFormat.getXsdFormat()));		///
			rspFormatJson.put("xsdDemo", (contractFormat.getXsdDemo()==null?"":contractFormat.getXsdDemo()));
			rspFormatJson.put("state", (contractFormat.getState()==null?"":contractFormat.getState()));
			rspFormatJson.put("descriptor", (contractFormat.getDescriptor()==null?"":contractFormat.getDescriptor()));
			 //响应节点描述定义:
			if(contractFormat.getTcpCtrFId()!=null){
				List<Map<String, String>> rspNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
				JSONArray rspNodeDescArray = new JSONArray();
                if(rspNodeDescList!=null && rspNodeDescList.size()>0){
					for(int i=0;i<rspNodeDescList.size();i++){
		                JSONObject nodeDescJson = new JSONObject ();
						nodeDescJson.put("nodeDescId", rspNodeDescList.get(i).get("NODEDESCID"));
						nodeDescJson.put("nodeName", (rspNodeDescList.get(i).get("NODENAME")==null?"":rspNodeDescList.get(i).get("NODENAME")));		//
						nodeDescJson.put("nodeCode", (rspNodeDescList.get(i).get("NODECODE")==null?"":rspNodeDescList.get(i).get("NODECODE")));
						nodeDescJson.put("nodePath", (rspNodeDescList.get(i).get("NODEPATH")==null?"":rspNodeDescList.get(i).get("NODEPATH")));			//
						nodeDescJson.put("nodeType", (rspNodeDescList.get(i).get("NODETYPE")==null?"":rspNodeDescList.get(i).get("NODETYPE")));
						nodeDescJson.put("nodeLengthCons", (rspNodeDescList.get(i).get("NODELENGTHCONS")==null?"":rspNodeDescList.get(i).get("NODELENGTHCONS")));		//
						nodeDescJson.put("nodeTypeCons", (rspNodeDescList.get(i).get("NODETYPECONS")==null?"":rspNodeDescList.get(i).get("NODETYPECONS")));
						nodeDescJson.put("nodeNumberCons", (rspNodeDescList.get(i).get("NODENUMBERCONS")==null?"":rspNodeDescList.get(i).get("NODENUMBERCONS")));
						nodeDescJson.put("nevlConsType", (rspNodeDescList.get(i).get("NEVLCONSTYPE")==null?"":rspNodeDescList.get(i).get("NEVLCONSTYPE")));
						nodeDescJson.put("nevlConsValue", (rspNodeDescList.get(i).get("NEVLCONSVALUE")==null?"":rspNodeDescList.get(i).get("NEVLCONSVALUE")));		//
						nodeDescJson.put("nevlConsDesc", (rspNodeDescList.get(i).get("NEVLCONSDESC")==null?"":rspNodeDescList.get(i).get("NEVLCONSDESC")));
						nodeDescJson.put("isNeedCheck", (rspNodeDescList.get(i).get("ISNEEDCHECK")==null?"":rspNodeDescList.get(i).get("ISNEEDCHECK")));
						nodeDescJson.put("isNeedSign", (rspNodeDescList.get(i).get("ISNEEDSIGN")==null?"":rspNodeDescList.get(i).get("ISNEEDSIGN")));
						nodeDescJson.put("state", (rspNodeDescList.get(i).get("STATE")==null?"":rspNodeDescList.get(i).get("STATE")));
						nodeDescJson.put("createTime", (rspNodeDescList.get(i).get("CREATETIME")==null?"":format.format(rspNodeDescList.get(i).get("CREATETIME"))));
						nodeDescJson.put("javaField",(rspNodeDescList.get(i).get("JAVAFIELD")==null?"":rspNodeDescList.get(i).get("JAVAFIELD")));
						nodeDescJson.put("description", (rspNodeDescList.get(i).get("DESCRIPTION")==null?"":rspNodeDescList.get(i).get("DESCRIPTION")));
						nodeDescJson.put("tcpCtrFId", rspNodeDescList.get(i).get("TCPCTRFID"));
						rspNodeDescArray.add(nodeDescJson);
					}
      		  	}
				rspFormatJson.put("nodeDescs", rspNodeDescArray);
			}
			contractFormatsJsonArray.add(rspFormatJson);
		}
		
		contractVersionJson.put("contractFormats", contractFormatsJsonArray);	
		contractJson.put("contractVersion", contractVersionJson);

		return contractJson;
	}
	
	//获取协议基类信息
	public JSONObject getBaseContractInfoForDetail(String baseContractId){

			JSONObject baseContractJson = new JSONObject ();
		    DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  

			Contract contract = new Contract();
			contract.setContractId(Integer.parseInt(baseContractId));
			contract = this.getContractService().findContract(contract);		//协议基本信息
			if(contract !=null){
				baseContractJson.put("contractId", contract.getContractId());	
				baseContractJson.put("name", contract.getName());
				baseContractJson.put("code", contract.getCode());
				baseContractJson.put("state", contract.getState());
				baseContractJson.put("createTime", (contract.getCreateTime()==null?"":format.format(contract.getCreateTime())));
				baseContractJson.put("descriptor", contract.getDescriptor());
			}
			
			Integer contractVersionId =0;
			JSONObject contractVersionJson = new JSONObject ();
			ContractVersion contractVersion = new ContractVersion();
			contractVersion.setContractId(baseContractId);
			contractVersion = getContractService().findContractVersion(contractVersion);			//协议版本信息
			if(contractVersion !=null){
				contractVersionId = contractVersion.getContractVersionId();
				contractVersionJson.put("contractVersionId", contractVersionId);	
				contractVersionJson.put("version", (contractVersion.getVersion()==null?"":contractVersion.getVersion()));	
				contractVersionJson.put("createTime",(contractVersion.getCreateTime()==null?"":contractVersion.getCreateTime()));	
				contractVersionJson.put("isNeedCkeck", (contractVersion.getIsNeedCheck()==null?"":contractVersion.getIsNeedCheck()));	
				contractVersionJson.put("state", (contractVersion.getState()==null?"":contractVersion.getState()));	
				contractVersionJson.put("effDate", (contractVersion.getEffDate()==null?"":format.format(contractVersion.getEffDate())));	
				contractVersionJson.put("expDate", (contractVersion.getExpDate()==null?"":format.format(contractVersion.getExpDate())));	
				contractVersionJson.put("descriptor", (contractVersion.getDescriptor()==null?"":contractVersion.getDescriptor()));	
			}
			if(contractVersionId != 0){
					//请求
					JSONArray contractFormatsJsonArray = new JSONArray();
	                JSONObject reqFormatJson = new JSONObject ();
					ContractFormat contractFormat = new ContractFormat();
					contractFormat.setContractVersionId(contractVersionId);
					contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
					contractFormat = getContractService().findContractFormat(contractFormat);			//协议版本请求定义
					if(contractFormat !=null){
						reqFormatJson.put("contractFormatId", (contractFormat.getTcpCtrFId()==null?"":contractFormat.getTcpCtrFId()));
						reqFormatJson.put("reqRsp", "REQ");
						reqFormatJson.put("conType", (contractFormat.getConType()==null?"":contractFormat.getConType()));
						reqFormatJson.put("xsdHeaderFor", (contractFormat.getXsdHeaderFor()==null?"":contractFormat.getXsdHeaderFor()));
						reqFormatJson.put("xsdFormat", (contractFormat.getXsdFormat()==null?"":contractFormat.getXsdFormat()));
						reqFormatJson.put("xsdDemo", (contractFormat.getXsdDemo()==null?"":contractFormat.getXsdDemo()));
						reqFormatJson.put("state", (contractFormat.getState()==null?"":contractFormat.getState()));
						reqFormatJson.put("descriptor", (contractFormat.getDescriptor()==null?"":contractFormat.getDescriptor()));
						//请求节点描述定义:
						if(contractFormat.getTcpCtrFId()!=null){
								List<Map<String, String>> reqNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());   
								JSONArray reqNodeDescArray = new JSONArray();
				                if(reqNodeDescList!=null && reqNodeDescList.size()>0){
									for(int i=0;i<reqNodeDescList.size();i++){
						                JSONObject nodeDescJson = new JSONObject ();
										nodeDescJson.put("nodeDescId", reqNodeDescList.get(i).get("NODEDESCID"));
										nodeDescJson.put("nodeName", (reqNodeDescList.get(i).get("NODENAME")==null?"":reqNodeDescList.get(i).get("NODENAME")));		//
										nodeDescJson.put("nodeCode", (reqNodeDescList.get(i).get("NODECODE")==null?"":reqNodeDescList.get(i).get("NODECODE")));
										nodeDescJson.put("nodePath", (reqNodeDescList.get(i).get("NODEPATH")==null?"":reqNodeDescList.get(i).get("NODEPATH")));			//
										nodeDescJson.put("nodeType", (reqNodeDescList.get(i).get("NODETYPE")==null?"":reqNodeDescList.get(i).get("NODETYPE")));
										nodeDescJson.put("nodeLengthCons", (reqNodeDescList.get(i).get("NODELENGTHCONS")==null?"":reqNodeDescList.get(i).get("NODELENGTHCONS")));		//
										nodeDescJson.put("nodeTypeCons", (reqNodeDescList.get(i).get("NODETYPECONS")==null?"":reqNodeDescList.get(i).get("NODETYPECONS")));
										nodeDescJson.put("nodeNumberCons", (reqNodeDescList.get(i).get("NODENUMBERCONS")==null?"":reqNodeDescList.get(i).get("NODENUMBERCONS")));
										nodeDescJson.put("nevlConsType", (reqNodeDescList.get(i).get("NEVLCONSTYPE")==null?"":reqNodeDescList.get(i).get("NEVLCONSTYPE")));
										nodeDescJson.put("nevlConsValue", (reqNodeDescList.get(i).get("NEVLCONSVALUE")==null?"":reqNodeDescList.get(i).get("NEVLCONSVALUE")));		//
										nodeDescJson.put("nevlConsDesc", (reqNodeDescList.get(i).get("NEVLCONSDESC")==null?"":reqNodeDescList.get(i).get("NEVLCONSDESC")));
										nodeDescJson.put("isNeedCheck", (reqNodeDescList.get(i).get("ISNEEDCHECK")==null?"":reqNodeDescList.get(i).get("ISNEEDCHECK")));
										nodeDescJson.put("isNeedSign", (reqNodeDescList.get(i).get("ISNEEDSIGN")==null?"":reqNodeDescList.get(i).get("ISNEEDSIGN")));
										nodeDescJson.put("state", (reqNodeDescList.get(i).get("STATE")==null?"":reqNodeDescList.get(i).get("STATE")));
										nodeDescJson.put("createTime", (reqNodeDescList.get(i).get("CREATETIME")==null?"":format.format(reqNodeDescList.get(i).get("CREATETIME"))));
										nodeDescJson.put("javaField",(reqNodeDescList.get(i).get("JAVAFIELD")==null?"":reqNodeDescList.get(i).get("JAVAFIELD")));
										nodeDescJson.put("description", (reqNodeDescList.get(i).get("DESCRIPTION")==null?"":reqNodeDescList.get(i).get("DESCRIPTION")));
										nodeDescJson.put("tcpCtrFId", reqNodeDescList.get(i).get("TCPCTRFID"));
										reqNodeDescArray.add(nodeDescJson);
									}
				      		  	}
								reqFormatJson.put("nodeDescs", reqNodeDescArray);
						}
						contractFormatsJsonArray.add(reqFormatJson);
					}
	
					//响应:
	                JSONObject rspFormatJson = new JSONObject ();
	                contractFormat = new ContractFormat();
					contractFormat.setContractVersionId(contractVersionId);
					contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
					contractFormat = getContractService().findContractFormat(contractFormat);			//协议版本响应定义
					if(contractFormat !=null){
						rspFormatJson.put("contractFormatId", (contractFormat.getTcpCtrFId()==null?"":contractFormat.getTcpCtrFId()));
						rspFormatJson.put("reqRsp", "RSP");
						rspFormatJson.put("conType", (contractFormat.getConType()==null?"":contractFormat.getConType()));
						rspFormatJson.put("xsdHeaderFor", (contractFormat.getXsdHeaderFor()==null?"":contractFormat.getXsdHeaderFor()));
						rspFormatJson.put("xsdFormat", (contractFormat.getXsdFormat()==null?"":contractFormat.getXsdFormat()));		///
						rspFormatJson.put("xsdDemo", (contractFormat.getXsdDemo()==null?"":contractFormat.getXsdDemo()));
						rspFormatJson.put("state", (contractFormat.getState()==null?"":contractFormat.getState()));
						rspFormatJson.put("descriptor", (contractFormat.getDescriptor()==null?"":contractFormat.getDescriptor()));
						
						 //响应节点描述定义:
						if(contractFormat.getTcpCtrFId()!=null){
								List<Map<String, String>> rspNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
								JSONArray rspNodeDescArray = new JSONArray();
				                if(rspNodeDescList!=null && rspNodeDescList.size()>0){
									for(int i=0;i<rspNodeDescList.size();i++){
						                JSONObject nodeDescJson = new JSONObject ();
										nodeDescJson.put("nodeDescId", rspNodeDescList.get(i).get("NODEDESCID"));
										nodeDescJson.put("nodeName", (rspNodeDescList.get(i).get("NODENAME")==null?"":rspNodeDescList.get(i).get("NODENAME")));		//
										nodeDescJson.put("nodeCode", (rspNodeDescList.get(i).get("NODECODE")==null?"":rspNodeDescList.get(i).get("NODECODE")));
										nodeDescJson.put("nodePath", (rspNodeDescList.get(i).get("NODEPATH")==null?"":rspNodeDescList.get(i).get("NODEPATH")));			//
										nodeDescJson.put("nodeType", (rspNodeDescList.get(i).get("NODETYPE")==null?"":rspNodeDescList.get(i).get("NODETYPE")));
										nodeDescJson.put("nodeLengthCons", (rspNodeDescList.get(i).get("NODELENGTHCONS")==null?"":rspNodeDescList.get(i).get("NODELENGTHCONS")));		//
										nodeDescJson.put("nodeTypeCons", (rspNodeDescList.get(i).get("NODETYPECONS")==null?"":rspNodeDescList.get(i).get("NODETYPECONS")));
										nodeDescJson.put("nodeNumberCons", (rspNodeDescList.get(i).get("NODENUMBERCONS")==null?"":rspNodeDescList.get(i).get("NODENUMBERCONS")));
										nodeDescJson.put("nevlConsType", (rspNodeDescList.get(i).get("NEVLCONSTYPE")==null?"":rspNodeDescList.get(i).get("NEVLCONSTYPE")));
										nodeDescJson.put("nevlConsValue", (rspNodeDescList.get(i).get("NEVLCONSVALUE")==null?"":rspNodeDescList.get(i).get("NEVLCONSVALUE")));		//
										nodeDescJson.put("nevlConsDesc", (rspNodeDescList.get(i).get("NEVLCONSDESC")==null?"":rspNodeDescList.get(i).get("NEVLCONSDESC")));
										nodeDescJson.put("isNeedCheck", (rspNodeDescList.get(i).get("ISNEEDCHECK")==null?"":rspNodeDescList.get(i).get("ISNEEDCHECK")));
										nodeDescJson.put("isNeedSign", (rspNodeDescList.get(i).get("ISNEEDSIGN")==null?"":rspNodeDescList.get(i).get("ISNEEDSIGN")));
										nodeDescJson.put("state", (rspNodeDescList.get(i).get("STATE")==null?"":rspNodeDescList.get(i).get("STATE")));
										nodeDescJson.put("createTime", (rspNodeDescList.get(i).get("CREATETIME")==null?"":format.format(rspNodeDescList.get(i).get("CREATETIME"))));
										nodeDescJson.put("javaField",(rspNodeDescList.get(i).get("JAVAFIELD")==null?"":rspNodeDescList.get(i).get("JAVAFIELD")));
										nodeDescJson.put("description", (rspNodeDescList.get(i).get("DESCRIPTION")==null?"":rspNodeDescList.get(i).get("DESCRIPTION")));
										nodeDescJson.put("tcpCtrFId", rspNodeDescList.get(i).get("TCPCTRFID"));
										rspNodeDescArray.add(nodeDescJson);
									}
				      		  	}
								rspFormatJson.put("nodeDescs", rspNodeDescArray);
						}
						contractFormatsJsonArray.add(rspFormatJson);
					}
					
					contractVersionJson.put("contractFormats", contractFormatsJsonArray);	
					baseContractJson.put("contractVersion", contractVersionJson);
			}
			return baseContractJson;
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
	public List<Map> getImportObjectTypeList() {
		return importObjectTypeList;
	}
	public void setImportObjectTypeList(List<Map> importObjectTypeList) {
		this.importObjectTypeList = importObjectTypeList;
	}
	
	public String getPageState() {
		return pageState;
	}
	public void setPageState(String pageState) {
		this.pageState = pageState;
	}
	
	public String getResourceAlias() {
		return resourceAlias;
	}
	public void setResourceAlias(String resourceAlias) {
		this.resourceAlias = resourceAlias;
	}
	public String getDocVersion() {
		return docVersion;
	}
	public void setDocVersion(String docVersion) {
		this.docVersion = docVersion;
	}
	public String getImportObjectType() {
		return importObjectType;
	}
	public void setImportObjectType(String importObjectType) {
		this.importObjectType = importObjectType;
	}
	public String getImportFile() {
		return importFile;
	}
	public void setImportFile(String importFile) {
		this.importFile = importFile;
	}
	public String getImportURL() {
		return importURL;
	}
	public void setImportURL(String importURL) {
		this.importURL = importURL;
	}

	public String getFileAttachId() {
		return fileAttachId;
	}
	public void setFileAttachId(String fileAttachId) {
		this.fileAttachId = fileAttachId;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public ContractDoc getContractDoc() {
		return contractDoc;
	}
	public void setContractDoc(ContractDoc contractDoc) {
		this.contractDoc = contractDoc;
	}
	
	public WsdlImport getWsdlImport() {
		return wsdlImport;
	}
	public void setWsdlImport(WsdlImport wsdlImport) {
		this.wsdlImport = wsdlImport;
	}
	
	public String getWsdlInfo() {
		return WsdlInfo;
	}
	public void setWsdlInfo(String wsdlInfo) {
		WsdlInfo = wsdlInfo;
	}
	
	public List<Map> getSelectStateList() {
		return selectStateList;
	}
	public void setSelectStateList(List<Map> selectStateList) {
		this.selectStateList = selectStateList;
	}
		
	public List<Map<String, Object>> getConTypeList() {
		return conTypeList;
	}
	public void setConTypeList(List<Map<String, Object>> conTypeList) {
		this.conTypeList = conTypeList;
	}

	public List<Map<String, Object>> getNevlConsTypeList() {
		return nevlConsTypeList;
	}
	public void setNevlConsTypeList(List<Map<String, Object>> nevlConsTypeList) {
		this.nevlConsTypeList = nevlConsTypeList;
	}
	
	public IServiceManagerServ getiServiceManagerServ() {
		return iServiceManagerServ;
	}
	public void setiServiceManagerServ(IServiceManagerServ iServiceManagerServ) {
		this.iServiceManagerServ = iServiceManagerServ;
	}
	
	public String getSaveResult() {
		return saveResult;
	}
	public void setSaveResult(String saveResult) {
		this.saveResult = saveResult;
	}
	
	public String getWsdlJsonStr() {
		return wsdlJsonStr;
	}
	public void setWsdlJsonStr(String wsdlJsonStr) {
		this.wsdlJsonStr = wsdlJsonStr;
	}
	
	public String getServiceAgentUrl() {
		return serviceAgentUrl;
	}
	public void setServiceAgentUrl(String serviceAgentUrl) {
		this.serviceAgentUrl = serviceAgentUrl;
	}

	public IWsdlImportService getWsdlImportService() {
		if(wsdlImportService==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				wsdlImportService = (IWsdlImportService)ctx.getBean("eaap-op2-conf-wsdlImport-wsdlImportService");
	     }
		return wsdlImportService;
	}
	public void setWsdlImportService(IWsdlImportService wsdlImportService) {
		this.wsdlImportService = wsdlImportService;
	}

	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
            //取得spring上下文
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				// 取得spring bean实例
				//logginService = (ILoginServ)ctx.getBean("eaap-op2-portal-login-LoginServ");
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
			   
	     }
		return confManagerServ;
	}
	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
	}
	

	public IContractService getContractService() {
		if (contractService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			contractService = (IContractService)ctx.getBean("eaap-op2-conf-contract-ContractService");
		}		
		return contractService;
	}
	public void setContractService(IContractService contractService) {
		this.contractService = contractService;
	}
	
	
	public IServiceManagerServ getServiceManagerServ() {
		if(iServiceManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				iServiceManagerServ = (IServiceManagerServ)ctx.getBean("eaap-op2-conf-service-manager-service") ;
	     }
		return iServiceManagerServ;
	}

	public String getImportId() {
		return importId;
	}
	public void setImportId(String importId) {
		this.importId = importId;
	}
	

	
}
