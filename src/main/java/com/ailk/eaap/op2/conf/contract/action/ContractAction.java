package com.ailk.eaap.op2.conf.contract.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.xml.XMLSerializer;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.tree.DefaultAttribute;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractDefined;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.Template;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.common.O2pDocumentHelper;
import com.ailk.eaap.op2.common.StringUtil;
import com.ailk.eaap.op2.conf.contract.service.IContractService;
import com.ailk.eaap.op2.conf.operatorlog.action.ContractNodeFuzzy;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.ailk.eaap.op2.conf.contract.service.IFreeMarkerValidateService;

public class ContractAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
    private IContractService contractService;  
    private List<Map<String, Object>> findContractList;   
    private List<Map<String, String>> baseContractList;
    private List<Map<String,String>> docList;
    private List<Map<String, Object>> conTypeList;
    private List<Map<String, Object>> nevlConsTypeList;
    private List<Map<String, Object>> nodeNumberConsList;
    private List<Map<String, Object>> nodeTypeConsList;
    
    private List<Map<String,String>> listJavaFieldReq;
    private List<Map<String,String>> listJavaFieldRsp;
    
   
    private String contractNode;
    private Integer contractId;
    private String statu;
    private String base;
    private String selectId;
    private Contract contract;
    private NodeDesc nodeDesc = new NodeDesc();
    private String jsonString;
    private ContractDefined contractDefined;
    private String nodeName;
    private String nodeCode;
    private String nodeDescName;
    private String nodeDescCode;
    private Integer tcpCtrFId;
    private Integer nodeDescId;
    private Integer rowIndex;
    private String reqRspFlag;
    private List<Map<String, String>> reqNodeDescList;
    private List<Map<String, String>> rspNodeDescList;
    private String reqXsdFormat;
    private String req_rsp;
    private static List<String> list = new ArrayList<String>();
    private static Map<String,String> storeMap = new HashMap<String,String>();
    private String formatType;
    private String headerFor;
    private String demo;
    //����ڵ��ʽID
	private Integer reqNodeDescId[];
	//����ڵ��ʽ���
	private String reqNodeDescName[];
	//����ڵ�·��
	private String reqNodePath[];
	//����ڵ�����
	private String reqNodeType[];
	//����ڵ�����Լ��
	private String reqNodeTypeCons[];
	//����ڵ�ֵԼ������
	private String reqNevlConsType[];
	//����ڵ�ֵԼ����ʽ
	private String reqNevlConsValue[];
	//����ڵ㳤��Լ��
	private String reqNodeLengthCons[];
	//����ڵ����Լ��
	private String reqNodeNumberCons[];
	//�Ƿ�����ǩ��
	private String reqIsNeedSign[];
	//�����Ƿ���ҪУ��
	private String reqIsNeedCheck[];
	
	//��Ӧ�ڵ��ʽID
	private Integer rspNodeDescId[];
	//��Ӧ�ڵ��ʽ���
	private String rspNodeDescName[];
	//��Ӧ�ڵ�·��
	private String rspNodePath[];
	//��Ӧ�ڵ�����
	private String rspNodeType[];
	//��Ӧ�ڵ�����Լ��
	private String rspNodeTypeCons[];
	//��Ӧ�ڵ�ֵԼ������
	private String rspNevlConsType[];
	//��Ӧ�ڵ�ֵԼ����ʽ
	private String rspNevlConsValue[];
	//��Ӧ�ڵ㳤��Լ��
	private String rspNodeLengthCons[];
	//��Ӧ�ڵ����Լ��
	private String rspNodeNumberCons[];
	//��Ӧ�Ƿ�����ǩ��
	private String rspIsNeedSign[];
	//��Ӧ�Ƿ���ҪУ��
	private String rspIsNeedCheck[];
	
	private String pageShowMsg;
	

	private String reqFrom;
	
	private String reqRsp;
	
	private Integer contractVersionId;
	
	private String pageState;
	
	private List<Map> isBaseList = new ArrayList<Map>();

	 @SuppressWarnings("unchecked")
	private List<Map> selectStateList = new ArrayList<Map>();
	
	private int rows;
	private int pageNum;
	private int total;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
    private String contractName,contractVersionName,contractVersionID;

    private String baseContractId;
    private String baseContractName;
    private String contractAttrSpec;
    private String chooseContractId;
    private String chooseContractName;
    private Template template;
    private Template globalTemplate;
    
	public Integer getContractId() {
		return contractId;
	}

	public void setContractId(Integer contractId) {
		this.contractId = contractId;
	}

	/**
	 * չʾЭ��ʵ����ҳ
	 * 
	 */
	@SuppressWarnings("unchecked")
	public String showContractAndVersion(){
		try {			
			selectSerInvokeInsList("base");
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}
	
	@SuppressWarnings("unchecked")
	public String showNodeDesc(){
		if (nodeDescId == null) {
			nodeDescId = -1;
		}
		if (tcpCtrFId == null) {
			tcpCtrFId = -1;
		}
		return SUCCESS;
	}
	/**
	 * չʾЭ�����ӦЭ��汾��ҳ
	 * 
	 */
	@SuppressWarnings("unchecked")
	public String showContract(){
		try {			
			selectSerInvokeInsList("base");
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"View protocol anomaly",null));
		}
		return SUCCESS;
	}
	
	/**
	 * �������Э����ҳ
	 * 
	 */
	public String gotoAddContract(){				
		try {
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
			
			Map  map1 = new HashMap();
			map1.put("isBaseName", getText("eaap.op2.conf.compregauditing.isBaseNo"));
			map1.put("isBaseCode", "0");
			
			Map  map2 = new HashMap();
			map2.put("isBaseName", getText("eaap.op2.conf.compregauditing.isBaseYes"));
			map2.put("isBaseCode", "1");
		 
			isBaseList.add(map1);
			isBaseList.add(map2);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Add protocol anomaly",null));
		}	
		return SUCCESS;
	}
	/**
	 * �����޸�Э����ҳ
	 * 
	 */
	public String gotoEditContract(){				
        
		Map  map1 = new HashMap();
		map1.put("isBaseName", getText("eaap.op2.conf.compregauditing.isBaseNo"));
		map1.put("isBaseCode", "0");
		
		Map  map2 = new HashMap();
		map2.put("isBaseName", getText("eaap.op2.conf.compregauditing.isBaseYes"));
		map2.put("isBaseCode", "1");
	 
		isBaseList.add(map1);
		isBaseList.add(map2);
		if(contractId != null){
			//�޸�Э����ҳ
			Contract newContract = new Contract();
			newContract.setContractId(contractId);		
			try {				
				contract = this.getContractService().findContract(newContract);	
				Map mapTemp = new HashMap();  
				baseContractList = this.getContractService().getBaseContractList(mapTemp);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
			}
		}	
		return SUCCESS;
	}
	
	/**
	 * ���Э���ύ
	 * 
	 */
	public String addContract(){	

		try {
			contract.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE);				
			contractId = this.getContractService().addContract(contract);
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Add protocol anomaly",null));
		}	
		return SUCCESS;
	}
	
	public void isExitConCode(){
		String code = getRequest().getParameter("code");
		Map<String,String> retMap = new HashMap<String,String>();
		HttpServletRequest req = this.getRequest();
		JSONObject json = new JSONObject();
		try {
			req.setCharacterEncoding("UTF-8");
			Writer wr = getResponse().getWriter();
			String js = StringUtil.getString(req.getInputStream(),"UTF-8");
			Map mapTemp = new HashMap();  
			mapTemp.put("code", code);
			int cnt = this.getContractService().isExitCode(mapTemp);
			if(cnt==0){
				retMap.put("retCode", "1");
				retMap.put("retMsg", "ok");
			}else{
				retMap.put("retCode", "0");
				retMap.put("retMsg", "err");
			}
			json.putAll(retMap);
			wr.write(json.toString());
			wr.close();
		} catch (IOException e) {
			try {
				req.setCharacterEncoding("UTF-8");
				Writer wr = getResponse().getWriter();
				retMap.put("retCode", "-1");
				retMap.put("retMsg", "occur exception:"+e.getMessage());
				json.putAll(retMap);
				wr.write(json.toString());
				wr.close();
			} catch (Exception e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
		}
	}
	
	public String editContract(){
		if(contract.getContractId() != null){			
			try {
				contractId = this.getContractService().editContract(contract);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
			}
		}
		return SUCCESS;
	}	
	/**
	 * ɾ��Э����ҳ
	 * 
	 */
	public String deleteContract(){
		if(contractId != null ){
			Contract contract = new Contract();
			//״̬ʧЧ
			contract.setState(EAAPConstants.EAAP_MAIN_DATA_GIVEUP);
			contract.setContractId(contractId);
			try {
				this.getContractService().editContract(contract);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete protocol anomaly",null));
			}
		}
		
		return SUCCESS;
	}
	
	/**
	 * ɾ��Э��汾
	 * 
	 */
	public String deleteContractVersion(){
			
		if(contractVersionId != null){
			ContractVersion contractVersion = new ContractVersion();
			//״̬ʧЧ
			contractVersion.setState(EAAPConstants.EAAP_MAIN_DATA_GIVEUP);
			contractVersion.setContractVersionId(contractVersionId);
			try {
				this.getContractService().editContractVersion(contractVersion);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Delete protocol  version anomaly",null));
			}
		}
		
		return SUCCESS;
	}
	/**
	 * ������Ӻ��޸�Э�������ҳ
	 * 
	 */
	public String editContractManager(){
		
		Contract newContract = new Contract();
		ContractDoc doc = new ContractDoc();
		ContractVersion contractVersion = new ContractVersion();
		ContractFormat contractFormat = new ContractFormat();
		contract = new Contract();
		DocContract docContract = new DocContract();	
		contractDefined = new ContractDefined();
		if(contractVersionId != null){
			try {
				contractVersion.setContractVersionId(contractVersionId);
				contractVersion = getContractService().findContractVersion(contractVersion);	
				if(contractVersion != null){
					newContract.setContractId(new Integer(contractVersion.getContractId()));
					contract = this.getContractService().findContract(newContract);								
					contractDefined.setContractVersionId(contractVersionId);
					contractDefined.setVersion(contractVersion.getVersion());
					contractDefined.setContractVersionDescriptor(contractVersion.getDescriptor());
					contractDefined.setIsNeedCheckVersion(contractVersion.getIsNeedCheck());
				if(contractVersion.getContractVersionId()!=null){
					docContract.setContractVersionId(contractVersion.getContractVersionId());
					docContract = getContractService().queryDocContract(docContract);					
					if(docContract != null){
						
						
						
						contractDefined.setDocContrId(docContract.getDocContrId());							
						if(docContract.getContractDocId() != null){
							doc.setContractDocId(docContract.getContractDocId());
							doc = getContractService().returnContractDoc(doc);		
							contractDefined.setDocName(doc.getDocName());
						}
						contractDefined.setContractDocId(docContract.getContractDocId());
						contractDefined.setDocContractDescriptor(docContract.getDescriptor());						
					}			
					//����Э��
					contractFormat.setContractVersionId(contractVersion.getContractVersionId());
					contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
					contractFormat = getContractService().findContractFormat(contractFormat);
					if(contractFormat.getTcpCtrFId()!= null){
						contractDefined.setReqContractFormatId(contractFormat.getTcpCtrFId());
						contractDefined.setReqConType(contractFormat.getConType());
						contractDefined.setReqXsdHeaderFor(contractFormat.getXsdHeaderFor());
						contractDefined.setReqXsdFormat(contractFormat.getXsdFormat());
						contractDefined.setReqDescriptor(contractFormat.getDescriptor());
						reqNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
					}
					//��ӦЭ��
					contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
					contractFormat.setContractVersionId(contractVersion.getContractVersionId());
					contractFormat = getContractService().findContractFormat(contractFormat);
					if(contractFormat.getTcpCtrFId()!= null){
						contractDefined.setRspContractFormatId(contractFormat.getTcpCtrFId());
						contractDefined.setRspConType(contractFormat.getConType());
						contractDefined.setRspXsdHeaderFor(contractFormat.getXsdHeaderFor());
						contractDefined.setRspXsdFormat(contractFormat.getXsdFormat());
						contractDefined.setRspDescriptor(contractFormat.getDescriptor());
						rspNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
						}
					}	
				}
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
			}
			
		}else{
			if(contractId != null){
				try {
					//Э����Ϣ
					newContract.setContractId(contractId);
					contract = this.getContractService().findContract(newContract);
				} catch (EAAPException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
				}
			}	
		}
		contractDefined.setContractId(contract.getContractId());
		contractDefined.setName(contract.getName());
		contractDefined.setCode(contract.getCode());
		contractDefined.setBaseContractId(contract.getBaseContractId());
		contractDefined.setContractDescriptor(contract.getDescriptor());
		conTypeList = getContractService().selectConType(EAAPConstants.MAINDATACONTYPE);
		//��ȡ�������
		try {
		if(contract.getBaseContractId()!=null){
			Integer _baseContractId =contract.getBaseContractId();
			Contract baseContract = new Contract();
			baseContract.setContractId(contract.getBaseContractId());
			contract =  this.getContractService().findContract(baseContract);
			if(contract!=null){
				contractDefined.setBaseContractName(contract.getName());
			}else{
				contractDefined.setBaseContractName("<img src='../resource/comm/images/warningInfo.png' title='Cannot find Protocol Base (BaseContractId="+_baseContractId+")'/>");
			}
		}
			Map map = new HashMap();  
			docList = this.getContractService().getContractDoc(map);
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
		}
		selectSerInvokeInsList("check");
		nevlConsTypeList = getContractService().selectConType(EAAPConstants.NEVLCONSTYPE);;
		nodeNumberConsList = getContractService().selectConType(EAAPConstants.NODENUMBERCONS);
		nodeTypeConsList = getContractService().selectConType(EAAPConstants.NODETYPECONS);
		return SUCCESS;
	}	
	
	//判断界面上输入的协议版本号（Version Number）是否已存在：
	public void hasContractVersion(){
		PrintWriter out =null;
		try {
			String isHas = "false";
			String version = getRequest().getParameter("version");

			ContractVersion contractVersion = new ContractVersion();
			contractVersion.setVersion(version);
			contractVersion = getContractService().findContractVersion(contractVersion);
			if(contractVersion !=null){
				isHas = "true";
			}
			
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
	
	/**
	 * Э�������Ӻ��޸��ύ
	 * 
	 */
	public String addNextContractManager(){
		if (contractDefined != null){
			if(contractDefined.getContractVersionId()!= null){
				//�޸�
				getContractService().editContractDefinedContext(contractDefined);
			}
			if(contractAttrSpec !=null && !contractAttrSpec.equals("")){
				getContractService().editContractAttrSpec(contractAttrSpec);
			}
		}	
		return SUCCESS;
	}
	
	public void templateMock(){ 
		PrintWriter out = null;
		try {
			String templateHeader = getRequest().getParameter("templateHeader");
			String templateBody = getRequest().getParameter("templateBody");
			String[] configLocations= new String[]{"classpath:eaap-op2-templateMockRemote-spring.xml"};
			ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
			IFreeMarkerValidateService ws = (IFreeMarkerValidateService)ctx.getBean("templateMockRemote");
			String validateHeadResult = ""; 
			if(!"".equals(templateHeader)){
				validateHeadResult = ws.validateHeader(templateHeader);		//{"RespCode":"0","RespDesc":"validate header template success"}
			}else{
				validateHeadResult = "{\"RespCode\":\"0\",\"RespDesc\":\"Header enter is empty\"}";
			}
			String validateBodyResult = ws.validateBody(templateBody);				//{"RespCode":"0","RespDesc":"validate body template success"}
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String ret="{\"ResultCode\":\"0\",\"ResultDesc\":\"ok\",\"HeadResult\":"+validateHeadResult+",\"BodyResult\":"+validateBodyResult+"}";
			out.print(ret);
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
			    String retFailure="{\"ResultCode\":\"9\",\"ResultDesc\":\""+e.getMessage()+"\"}";
				out.print(retFailure);
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
	
	public String addContractManager(){
		
		Integer versionId = null;
		if (contractDefined != null){
			contractDefined.setReqNodeDescName(reqNodeDescName);
			contractDefined.setReqNodePath(reqNodePath);
			contractDefined.setReqNodeType(reqNodeType);
			contractDefined.setReqNevlConsType(reqNevlConsType);
			contractDefined.setReqNevlConsValue(reqNevlConsValue);
			contractDefined.setReqIsNeedCheck(reqIsNeedCheck);
			contractDefined.setReqIsNeedSign(reqIsNeedSign);
			contractDefined.setReqNodeLengthCons(reqNodeLengthCons);
			contractDefined.setReqNodeNumberCons(reqNodeNumberCons);
			contractDefined.setReqNodeTypeCons(reqNodeTypeCons);
			
			contractDefined.setRspNodeDescName(rspNodeDescName);
			contractDefined.setRspNodePath(rspNodePath);
			contractDefined.setRspNodeType(rspNodeType);
			contractDefined.setRspNevlConsType(rspNevlConsType);
			contractDefined.setRspNevlConsValue(rspNevlConsValue);
			contractDefined.setRspIsNeedCheck(rspIsNeedCheck);
			contractDefined.setRspIsNeedSign(rspIsNeedSign);
			contractDefined.setRspNodeLengthCons(rspNodeLengthCons);
			contractDefined.setRspNodeNumberCons(rspNodeNumberCons);
			contractDefined.setRspNodeTypeCons(rspNodeTypeCons);
			if(contractDefined.getContractVersionId()!= null){
				//�޸�
				getContractService().editContractDefined(contractDefined);
			}
			else{
				//���
				versionId = getContractService().addContractDefined(contractDefined);				
			}
		}	
		
		gotoNextContractManager(versionId);
		
		return SUCCESS;
	}
	
	public String jumpThisPage(){
		gotoNextContractManager(contractVersionId);
		return SUCCESS;
	}
	public void gotoNextContractManager(Integer versionId){
		
		if (versionId != null) {
			contractVersionId = versionId;
		}
		Contract newContract = new Contract(); 
		ContractDoc doc = new ContractDoc();
		ContractVersion contractVersion = new ContractVersion();
		ContractFormat contractFormat = new ContractFormat();
		contract = new Contract();
		DocContract docContract = new DocContract();	
		contractDefined = new ContractDefined();
		template = new Template();
		if(contractVersionId != null){
			try {
				contractVersion.setContractVersionId(contractVersionId);
				contractVersion = getContractService().findContractVersion(contractVersion);
				if(contractVersion != null){
					newContract.setContractId(new Integer(contractVersion.getContractId()));
					contract = this.getContractService().findContract(newContract);								
					contractDefined.setContractVersionId(contractVersionId);
					contractDefined.setVersion(contractVersion.getVersion());
					contractDefined.setContractVersionDescriptor(contractVersion.getDescriptor());				
					if(contractVersion.getContractVersionId()!=null){
						docContract.setContractVersionId(contractVersionId);
						docContract = getContractService().queryDocContract(docContract);					
						if(docContract != null){
							contractDefined.setDocContrId(docContract.getDocContrId());							
							if(docContract.getContractDocId() != null){
								doc.setContractDocId(docContract.getContractDocId());
								doc = getContractService().returnContractDoc(doc);		
								contractDefined.setDocName(doc.getDocName());
								contractDefined.setDocPath(doc.getDocPath());
							}
							contractDefined.setContractDocId(docContract.getContractDocId());
							contractDefined.setDocContractDescriptor(docContract.getDescriptor());						
						}
						//����Э��
						JSONArray contractAttrJsonArray = new JSONArray(); 
						contractFormat.setContractVersionId(contractVersionId);
						contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
						contractFormat = getContractService().findContractFormat(contractFormat);
						if(contractFormat.getTcpCtrFId()!= null){
							contractDefined.setReqContractFormatId(contractFormat.getTcpCtrFId());
							contractDefined.setReqConType(contractFormat.getConType());
							contractDefined.setReqXsdHeaderFor(contractFormat.getXsdHeaderFor());
							contractDefined.setReqXsdFormat(contractFormat.getXsdFormat());
							contractDefined.setReqDescriptor(contractFormat.getDescriptor());
							reqNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
							reqNodeDescList = escapeReplaces(reqNodeDescList);
	
					        JSONObject reqAttrSpecJson = new JSONObject();
					        reqAttrSpecJson.put("TCP_CTR_F_ID", contractFormat.getTcpCtrFId().toString());
							reqAttrSpecJson.put("REQ_RSP", EAAPConstants.CONTRACT_FORMAT_REQ);
							JSONArray reqAttrSpecJsonArray = getContractService().getContractAttrSpecList(contractFormat.getTcpCtrFId().toString(), EAAPConstants.MAINDATACONTYPE);
							reqAttrSpecJson.put("CONTRACT_ATTR_SPEC", reqAttrSpecJsonArray);
							contractAttrJsonArray.add(reqAttrSpecJson);
						}
						//��ӦЭ��
						contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
						contractFormat.setContractVersionId(contractVersion.getContractVersionId());
						contractFormat = getContractService().findContractFormat(contractFormat);
						if(contractFormat.getTcpCtrFId()!= null){
							contractDefined.setRspContractFormatId(contractFormat.getTcpCtrFId());
							contractDefined.setRspConType(contractFormat.getConType());
							contractDefined.setRspXsdHeaderFor(contractFormat.getXsdHeaderFor());
							contractDefined.setRspXsdFormat(contractFormat.getXsdFormat());
							contractDefined.setRspDescriptor(contractFormat.getDescriptor());
							contractDefined.setRspXsdException(contractFormat.getXsdException());
							rspNodeDescList = getContractService().queryNodeDesc(contractFormat.getTcpCtrFId().toString());
							rspNodeDescList = escapeReplaces(rspNodeDescList);
							
							template.setTcpCtrFId(contractFormat.getTcpCtrFId());
							template = getContractService().queryTemplate(template);
							if(template!=null){
								contractDefined.setTemplateHeader(template.getTemplateHeader());
								contractDefined.setTemplateBody(template.getTemplateBody());
								contractDefined.setTemplateDefMode("0");		//0:Default, 1:Old Mode
							}else{
								contractDefined.setTemplateDefMode("1");
							}
							
					        JSONObject rspAttrSpecJson = new JSONObject();
					        rspAttrSpecJson.put("TCP_CTR_F_ID", contractFormat.getTcpCtrFId().toString());
					        rspAttrSpecJson.put("REQ_RSP", EAAPConstants.CONTRACT_FORMAT_RSP);
							JSONArray rspAttrSpecJsonArray = getContractService().getContractAttrSpecList(contractFormat.getTcpCtrFId().toString(), EAAPConstants.MAINDATACONTYPE);
							rspAttrSpecJson.put("CONTRACT_ATTR_SPEC", rspAttrSpecJsonArray);
							contractAttrJsonArray.add(rspAttrSpecJson);
						}
						contractAttrSpec = contractAttrJsonArray.toString();		//扩展属性配置
						
						//异常响应全局模板：
						globalTemplate = new Template();
						Template temp = new Template();
						temp.setIsGlobal("0");		//0:全局模板，1:接口模板
						globalTemplate = getContractService().queryTemplate(temp);
					}
				}
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
			}
			
		}else{
			if(contractId != null){
				try {
					//Э����Ϣ
					newContract.setContractId(contractId);
					contract = this.getContractService().findContract(newContract);
				} catch (EAAPException e) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
				}
			}	
		}
		contractDefined.setContractId(contract.getContractId());
		contractDefined.setName(contract.getName());
		contractDefined.setCode(contract.getCode());
		contractDefined.setBaseContractId(contract.getBaseContractId());
		contractDefined.setContractDescriptor(contract.getDescriptor());
		conTypeList = getContractService().selectConType(EAAPConstants.MAINDATACONTYPE);
		//��ȡ�������
		try {
		if(contract.getBaseContractId()!=null){
			Integer _baseContractId =contract.getBaseContractId();
			Contract baseContract = new Contract();
			baseContract.setContractId(contract.getBaseContractId());
			contract =  this.getContractService().findContract(baseContract);
			if(contract!=null){
				contractDefined.setBaseContractName(contract.getName());
			}else{
				contractDefined.setBaseContractName("<img src='../resource/comm/images/warningInfo.png' title='Cannot find  Protocol Base (BaseContractId="+_baseContractId+")'/>");
			}
		}
			Map map = new HashMap();  
			docList = this.getContractService().getContractDoc(map);
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Edit protocol anomaly",null));
		}
		selectSerInvokeInsList("check");
		nevlConsTypeList = getContractService().selectConType(EAAPConstants.NEVLCONSTYPE);;
		nodeNumberConsList = getContractService().selectConType(EAAPConstants.NODENUMBERCONS);
		nodeTypeConsList = getContractService().selectConType(EAAPConstants.NODETYPECONS);

		Map mapTemp = new HashMap();  
		listJavaFieldReq = getContractService().getAllJavaFieldReq(mapTemp);
		listJavaFieldRsp = getContractService().getAllJavaFieldRsp(mapTemp);
	}	
	
	public JSONArray escapeReplaces(List reqNodeDescList){
		JSONArray nodeDescJsonArray = new JSONArray();
		 if(reqNodeDescList.size()>0){
			 for(int i=0;i<reqNodeDescList.size();i++){
				 Map node = (Map)reqNodeDescList.get(i); 
			     JSONObject nodeDescJson = new JSONObject();
				 
				 String nodeName	= CommonUtil.getMapValueToString(node, "NODENAME");
				 nodeName = nodeName.replace("\"", "&quot;");
			     nodeDescJson.put("NODENAME", nodeName);
			     
			     nodeDescJson.put("NODECODE", node.get("NODECODE"));
			     nodeDescJson.put("ISNEEDSIGN", node.get("ISNEEDSIGN"));
			     nodeDescJson.put("STATE", node.get("STATE"));
			     nodeDescJson.put("NODEDESCID", node.get("NODEDESCID"));
			     nodeDescJson.put("MDTNAME", node.get("MDTNAME"));
			     nodeDescJson.put("NODETYPECONS", node.get("NODETYPECONS"));
			     
				 String nevlConsValue	= CommonUtil.getMapValueToString(node, "NEVLCONSVALUE");
				 nevlConsValue = nevlConsValue.replace("\"", "&quot;");
			     nodeDescJson.put("NEVLCONSVALUE", nevlConsValue);
			     
			     nodeDescJson.put("DESCRIPTION", node.get("DESCRIPTION"));
			     nodeDescJson.put("PARENTNODEID", node.get("PARENTNODEID"));
			     nodeDescJson.put("NODETYPE", node.get("NODETYPE"));
			     nodeDescJson.put("ISNEEDCHECK", node.get("ISNEEDCHECK"));
			     nodeDescJson.put("PARENTNODENAME", node.get("PARENTNODENAME"));
			     nodeDescJson.put("CREATETIME", node.get("CREATETIME"));
			     nodeDescJson.put("TCPCTRFID", node.get("TCPCTRFID"));
			     nodeDescJson.put("NEVLCONSDESC", node.get("NEVLCONSDESC"));
			     nodeDescJson.put("NODENUMBERCONS", node.get("NODENUMBERCONS"));
			     nodeDescJson.put("NEVLCONSTYPE", node.get("NEVLCONSTYPE"));

				 String nodePath	= CommonUtil.getMapValueToString(node, "NODEPATH");
				 nodePath = nodePath.replace("\"", "&quot;");
			     nodeDescJson.put("NODEPATH", nodePath);
			     
			     nodeDescJson.put("NODELENGTHCONS", node.get("NODELENGTHCONS"));
			     nodeDescJson.put("JAVAFIELD", node.get("JAVAFIELD"));
			     nodeDescJson.put("NODEFUZZYID", node.get("CONTRACT_NODE_FUZZY_ID"));
			     nodeDescJson.put("REQFUZZYID", node.get("FUZZY_ENCRYPTION_ID"));
			     String type = String.valueOf(node.get("FUZZY_ENCRYPTION_TYPE"));
			     String fuzzyType = this.getText("eaap.op2.conf.process.type");
			     String fuzzyAlternative = this.getText("eaap.op2.conf.process.alternativeSymbols");
			     String fuzzyStart = this.getText("eaap.op2.conf.process.startingPosition");
			     String fuzzyEnd  =  this.getText("eaap.op2.conf.process.endPosition");
			     String showValue = "";
			     if("2".equals(type)){
			    	 showValue = fuzzyType+":"+this.getText("eaap.op2.conf.process.typeencryption");
			     }else if("1".equals(type)){
			    	 showValue = fuzzyType+":"+this.getText("eaap.op2.conf.process.typefuzzy")+", "+fuzzyAlternative+":"+String.valueOf(node.get("FUZZY_ALTERNATIVE"))+", "+fuzzyStart+":"+String.valueOf(node.get("FUZZY_START"))+", "+fuzzyEnd+":"+String.valueOf(node.get("FUZZY_END"));
			     }else if("3".equals(type)){
			    	 showValue = fuzzyType+":"+this.getText("eaap.op2.conf.process.fuzzyEncryption")+", "+fuzzyAlternative+":"+String.valueOf(node.get("FUZZY_ALTERNATIVE"))+", "+fuzzyStart+":"+String.valueOf(node.get("FUZZY_START"))+", "+fuzzyEnd+":"+String.valueOf(node.get("FUZZY_END"));
			     }
			     nodeDescJson.put("SHOWVALUE", showValue);
			     nodeDescJsonArray.add(nodeDescJson);
			 }
		 }
		 return nodeDescJsonArray;
	}
	
	
	
	/**
	 * 导入XML数据
	 */
	public void importDate(){
		if(null != contractVersionId && !"".equals(contractVersionId.toString())){
			PrintWriter pw = null;
			Document doc = null;
			try {
				  doc = DocumentHelper.parseText(reqXsdFormat);
				  Map<String,String> map = new HashMap<String,String>();
				  map.put("contractVersionId", contractVersionId+"");
				  map.put("req_rsp", req_rsp);
				  String tcp_ctr_f_id= getContractService().selectContractFormatById(map);
				//删除原节点信息
				  if(null != tcp_ctr_f_id && !"".equals(tcp_ctr_f_id)){
					  
					  Map delmap = new HashMap();
					  delmap.put("tcp_ctr_f_id", tcp_ctr_f_id);
					  getContractService().delNodeDescById(delmap);//原先是直接删除节点信息,现在是只做更新,有的节点不做处理
					  
					  ContractFormat contractFormat = new ContractFormat();
					  contractFormat.setTcpCtrFId(Integer.parseInt(tcp_ctr_f_id));
					  contractFormat.setXsdFormat(reqXsdFormat);
					  contractFormat.setContractVersionId(contractVersionId);
					  contractFormat.setConType(formatType);
					  contractFormat.setXsdHeaderFor(headerFor);
					  contractFormat.setDescriptor(demo);
					  getContractService().editContractFormat(contractFormat);
				  }else{//添加协议格式数据
					  ContractFormat contractFormat = new ContractFormat();
					  contractFormat.setXsdFormat(reqXsdFormat);
					  contractFormat.setContractVersionId(contractVersionId);
					  contractFormat.setConType(formatType);
					  contractFormat.setXsdHeaderFor(headerFor);
					  contractFormat.setDescriptor(demo);
					  if(EAAPConstants.CONTRACT_FORMAT_REQ.equals(req_rsp)){
						  contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
					  }else if(EAAPConstants.CONTRACT_FORMAT_RSP.equals(req_rsp)){
						  contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
					  }
					  contractFormat.setState(EAAPConstants.COMM_STATE_VALID);
					  Integer contractFormatId = getContractService().addContractFormat(contractFormat);
					  tcp_ctr_f_id = contractFormatId+"";
				  }
					// 批量添加节点信息
				  NodeDesc nodeDesc = new NodeDesc();
				  nodeDesc.setTcpCtrFId(Integer.parseInt(tcp_ctr_f_id));
				  nodeDesc.setState(EAAPConstants.COMM_STATE_VALID);
				  nodeDesc.setIsNeedCheck(EAAPConstants.IS_NEED_CHECK_NO);
				  nodeDesc.setIsNeedSign(EAAPConstants.IS_NEED_SIGN_NO);
				  nodeDesc.setNodeTypeCons("1");
				  nodeDesc.setNodeNumberCons("1");
				  parseXml(doc,nodeDesc,0, "");
				  JSONObject pwJson = new JSONObject();
				  pwJson.put("tcpCtrFId", tcp_ctr_f_id);
				  pwJson.put("message", "success");
				//返回信息
				pw = this.getResponse().getWriter();
				pw.write(pwJson.toString());
				pw.flush();
			} catch (DocumentException e) {
				try {
					JSONObject pwJson = new JSONObject();
					pwJson.put("message", "Document structure is incorrect");
					pw = this.getResponse().getWriter();
					pw.write(pwJson.toString());
					pw.flush();
				} catch (IOException e1) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
				}
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			} catch (IOException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}finally{
				if(null != pw){
					pw.close();
				}
			}
		}
	}
	/**
	 * 导入JSON数据
	 * @return
	 */
	public void importJsonDate(){
		if(null != contractVersionId && !"".equals(contractVersionId.toString())){
			PrintWriter pw = null;
			Document doc = null;
			try {
				  XMLSerializer xmlSerializer = new XMLSerializer();
				  JSONObject json2 = JSONObject.fromObject(reqXsdFormat);
				  String xml2 = xmlSerializer.write(json2);
				  doc = DocumentHelper.parseText(xml2);
				  Map<String,String> map = new HashMap<String,String>();
				  map.put("contractVersionId", contractVersionId+"");
				  map.put("req_rsp", req_rsp);
				  String tcp_ctr_f_id= getContractService().selectContractFormatById(map);
				//删除原节点信息
				  if(null != tcp_ctr_f_id && !"".equals(tcp_ctr_f_id)){
					  Map delmap = new HashMap();
					  delmap.put("tcp_ctr_f_id", tcp_ctr_f_id);
					  
					  getContractService().delNodeDescById(delmap);//原先是直接删除节点信息,现在是只做更新,有的节点不做处理
					  ContractFormat contractFormat = new ContractFormat();
					  contractFormat.setTcpCtrFId(Integer.parseInt(tcp_ctr_f_id));
					  contractFormat.setXsdFormat(reqXsdFormat);
					  contractFormat.setContractVersionId(contractVersionId);
					  contractFormat.setConType(formatType);
					  contractFormat.setXsdHeaderFor(headerFor);
					  contractFormat.setDescriptor(demo);
					  getContractService().editContractFormat(contractFormat);
				  }else{//添加协议格式数据
					  ContractFormat contractFormat = new ContractFormat();
					  contractFormat.setXsdFormat(reqXsdFormat);
					  contractFormat.setContractVersionId(contractVersionId);
					  contractFormat.setConType(formatType);
					  contractFormat.setXsdHeaderFor(headerFor);
					  contractFormat.setDescriptor(demo);
					  if(EAAPConstants.CONTRACT_FORMAT_REQ.equals(req_rsp)){
						  contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
					  }else if(EAAPConstants.CONTRACT_FORMAT_RSP.equals(req_rsp)){
						  contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
					  }
					  contractFormat.setState(EAAPConstants.COMM_STATE_VALID);
					  Integer contractFormatId = getContractService().addContractFormat(contractFormat);
					  tcp_ctr_f_id = contractFormatId+"";
				  }
					// 批量添加节点信息
				  NodeDesc nodeDesc = new NodeDesc();
				  nodeDesc.setTcpCtrFId(Integer.parseInt(tcp_ctr_f_id));
				  nodeDesc.setState(EAAPConstants.COMM_STATE_VALID);
				  nodeDesc.setIsNeedCheck(EAAPConstants.IS_NEED_CHECK_NO);
				  nodeDesc.setIsNeedSign(EAAPConstants.IS_NEED_SIGN_NO);
				  nodeDesc.setNodeTypeCons("1");
				  nodeDesc.setNodeNumberCons("1");
				  readXml(doc,nodeDesc,tcp_ctr_f_id);
				  JSONObject pwJson = new JSONObject();
				  pwJson.put("tcpCtrFId", tcp_ctr_f_id);
				  pwJson.put("message", "success");
				//返回信息
				pw = this.getResponse().getWriter();
				pw.write(pwJson.toString());
				pw.flush();
			} catch (DocumentException e) {
				try {
					JSONObject pwJson = new JSONObject();
					pwJson.put("message", "Json structure is incorrect");
					pw = this.getResponse().getWriter();
					pw.write(pwJson.toString());
					pw.flush();
				} catch (IOException e1) {
					log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
				}
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			} catch (IOException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}finally{
				if(null != pw){
					pw.close();
				}
			}
		}
	}
	private void readXml(Document doc, NodeDesc nodeDesc, String tcp_ctr_f_id) {
		Element root = doc.getRootElement();
		nodeDesc.setNodeName(root.getQualifiedName());
		nodeDesc.setNodeCode(root.getQualifiedName());
		nodeDesc.setNodePath(root.getPath()); 
		Integer parentID = 0;
		nodeDesc.setNodeType(EAAPConstants.NODE_TYPE_BODY);
		 String flagId = getContractService().getNodeIdByPath(root.getPath(),nodeDesc.getTcpCtrFId());
		 if(null == flagId){
			 parentID = getContractService().addNodeDesc(nodeDesc);
		 }else{
			 parentID = Integer.parseInt(flagId);
		 }
		list.clear();
		storeMap.clear();
		iteratorJsonXml(root,nodeDesc,parentID);
//		getContractService().updateNodeDescById(parentID,tcp_ctr_f_id);
//		Map paramMap=new HashMap(); 
//		paramMap.put("parentID", parentID);
//		getContractService().delNodeDesc(paramMap);
//		if(null != storeMap && storeMap.size() > 0){
//			for(Map.Entry<String, String> entry : storeMap.entrySet()){
//				String currentNodeId = entry.getKey();
//				String parentNodeId = entry.getValue();
//				Map<String,String>  map = new HashMap<String,String>();
//				map.put("currentNodeId", currentNodeId);
//				map.put("parentNodeId", parentNodeId);
//				map.put("tcp_ctr_f_id", tcp_ctr_f_id);
//				getContractService().updateNodeDescByMap(map);
//		        Map paramMap1=new HashMap(); 
//		        paramMap1.put("parentID", Integer.valueOf(currentNodeId));
//				getContractService().delNodeDesc(Integer.valueOf(currentNodeId));
//			}
//		}
	}
	private void iteratorJsonXml(Element element,NodeDesc nodeDesc,Integer partentId){
		for(Iterator<Element> sonElement = element.elementIterator();sonElement.hasNext();){
			 Element son = sonElement.next();
			 Integer parId = 0;
			 if(!list.contains(son.getPath().replace("/o", "$").replace("/", "."))){
				 list.add(son.getPath().replace("/o", "$").replace("/", "."));
				 nodeDesc.setNodeName(son.getQualifiedName());
				 nodeDesc.setNodeCode(son.getQualifiedName());
				 String nodePath = changeShowValue(son.getPath());
				 nodeDesc.setNodePath(nodePath); 
				 nodeDesc.setNodeType(EAAPConstants.NODE_TYPE_BODY);
				 nodeDesc.setParentNodeId(partentId);
				 String flagId = getContractService().getNodeIdByPath(nodePath,nodeDesc.getTcpCtrFId());
				 if(null == flagId){
					 parId = getContractService().addNodeDesc(nodeDesc);
				 }else{
					 parId = Integer.parseInt(flagId);
				 }
				 if("e".equals(son.getQualifiedName())){
					 storeMap.put(parId+"", partentId+"");
				 }
			 }
			 if(0 != parId){
				 iteratorJsonXml(son,nodeDesc,parId);
			 }
		 }
	}
	private String changeShowValue(String value){
		String[] array = value.split("/");
		//String finalvalue = "$";
		StringBuffer bf = new StringBuffer();
		bf.append("$");
		for(int i=0;i<array.length;i++){
			String nodeValue = array[i];
			if(!"o".equals(nodeValue) && !"e".endsWith(nodeValue)){
				//finalvalue += "."+nodeValue;
				bf.append(".").append(nodeValue);
			}
		}
		String finalvalue = bf.toString();
		return finalvalue;
	}
	private void parseXml(Document doc,NodeDesc nodeDesc,Integer partentId, String cdataPrePath) throws DocumentException{
			Element root = doc.getRootElement();
			nodeDesc.setNodeName(root.getQualifiedName());
			nodeDesc.setNodeCode(root.getQualifiedName());
			nodeDesc.setNodePath(parseXpath(cdataPrePath+root.getPath())); 
			nodeDesc.setNodeType(EAAPConstants.NODE_TYPE_BODY);
			
			if(partentId != 0) {
				
				nodeDesc.setParentNodeId(partentId);
			} 
				
			String flagId = getContractService().getNodeIdByPath(root.getPath(),nodeDesc.getTcpCtrFId());
			if(null == flagId){
				partentId = getContractService().addNodeDesc(nodeDesc);
			}else{
				partentId = Integer.parseInt(flagId);
			}
			 
			list.clear();
			List<DefaultAttribute> listAttribute = root.attributes();
			 if(listAttribute.size()>0){
				 for(Iterator<DefaultAttribute> sonAttr = listAttribute.iterator(); sonAttr.hasNext();){
					 DefaultAttribute attr = sonAttr.next();
					 nodeDesc.setNodeName(attr.getQualifiedName());
					 nodeDesc.setNodeCode(attr.getQualifiedName());
					 nodeDesc.setNodePath(parseXpath(cdataPrePath+attr.getPath())); 
					 nodeDesc.setNodeType("7");
					 nodeDesc.setParentNodeId(partentId);
					 getContractService().addNodeDesc(nodeDesc);
				 }
			 }
			 iteratorXml(root,nodeDesc,partentId,cdataPrePath);
	}
	private void iteratorXml(Element element,NodeDesc nodeDesc,Integer partentId, String cdataPrePath) throws DocumentException{
		for(Iterator<Element> sonElement = element.elementIterator();sonElement.hasNext();){
			 Element son = sonElement.next();
			 Integer parId = 0;
			 if(!list.contains(son.getPath())){
				 list.add(son.getPath());
				 nodeDesc.setNodeName(son.getQualifiedName());
				 nodeDesc.setNodeCode(son.getQualifiedName());
				 //nodeDesc.setNodePath(cdataPrePath+son.getPath()); 
				 nodeDesc.setNodePath(parseXpath(cdataPrePath+son.getPath()));
				 nodeDesc.setNodeType(EAAPConstants.NODE_TYPE_BODY);
				 nodeDesc.setParentNodeId(partentId);
				 String flagId = getContractService().getNodeIdByPath(son.getPath(),nodeDesc.getTcpCtrFId());
				 if(null == flagId){
					 parId = getContractService().addNodeDesc(nodeDesc);
				 }else{
					 parId = Integer.parseInt(flagId);
				 }
				 List<DefaultAttribute> listAttribute = son.attributes();
				 if(listAttribute.size()>0){
					 for(Iterator<DefaultAttribute> sonAttr = listAttribute.iterator(); sonAttr.hasNext();){
						 DefaultAttribute attr = sonAttr.next();
						 nodeDesc.setNodeName(attr.getQualifiedName());
						 nodeDesc.setNodeCode(attr.getQualifiedName());
						 nodeDesc.setNodePath(parseXpath(cdataPrePath+attr.getPath())); 
						 nodeDesc.setNodeType("7");
						 nodeDesc.setParentNodeId(parId);
						 getContractService().addNodeDesc(nodeDesc);
					 }
				 }
				 
				 parseCData(son,nodeDesc,parId, son.getPath());
			 }
			 if(0 != parId){
				 iteratorXml(son,nodeDesc,parId, cdataPrePath);
			 }
		 }
	}
	
	private void parseCData(Element element, NodeDesc nodeDesc, Integer parentId, String cdataPrePath) throws DocumentException {

		String text = element.getText();
		if(!StringUtils.isEmpty(text) && text.contains("<")) {
			
			if(text.trim().startsWith("<![CDATA")) {
				
				text = text.substring(9, text.length()-3);
			}
			Document doc = O2pDocumentHelper.parseText(text.trim());
			
			parseXml(doc,nodeDesc,parentId, cdataPrePath+"<XML_SPLIT>");
		}
	}

	public void saveContract(){
		JSONArray  jsonArray = new JSONArray ();
		ContractNodeFuzzy contractNodeFuzzy = new ContractNodeFuzzy();
		jsonArray = JSONArray.fromObject(jsonString);
		JsonKeyEnum jsonKeyEnum;
		ContractFormat contractFormat = new ContractFormat();
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jsonObj = (JSONObject) jsonArray.get(i);
			Iterator keys=jsonObj.keys();  
	        String key;  
	        String value;  
	        while(keys.hasNext())  
	        {  
	            key=(String)keys.next();  
	            value=(String) jsonObj.get(key);  
		        jsonKeyEnum = JsonKeyEnum.valueOf(key);
		        switch (jsonKeyEnum)
				{
				case nodeName:
					nodeDesc.setNodeName(value);
				  	break;
				case nodeCode:
					nodeDesc.setNodeCode(value);
				  	break;
				case nodeDescId:
					nodeDesc.setNodeDescId("".equals(value)?null:Integer.valueOf(value));
					contractNodeFuzzy.setNodeDescId("".equals(value)?null:value);
				  	break;
				case reqNodeFuzzyId:
					contractNodeFuzzy.setContractFuzzyId("".equals(value)?null:value);
				  	break;
				case reqFuzzyId:
					contractNodeFuzzy.setFuzzyId("".equals(value)?null:value);
				  	break;
				case parentNodeId:
					nodeDesc.setParentNodeId("".equals(value)?null:Integer.valueOf(value));
				  	break;
				case nodePath:
					nodeDesc.setNodePath(value);
				  	break;
				case nodeLengthCons:
					nodeDesc.setNodeLengthCons(value);
				 	break;
				case nodeNumberCons:
					nodeDesc.setNodeNumberCons(value);
				 	break;
				case nodeTypeCons:
					nodeDesc.setNodeTypeCons(value);
				 	break;
				case nodeType:
					nodeDesc.setNodeType(value);
				  	break;
				case isNeedSign:
					nodeDesc.setIsNeedSign(value);
					break;
				case isNeedCheck:
					nodeDesc.setIsNeedCheck(value);
				  	break;
				case nevlConsType:
					nodeDesc.setNevlConsType(value);
				  	break;
				case nevlConsValue:
					nodeDesc.setNevlConsValue(value);
				  	break;
				case javaField:
					nodeDesc.setJavaField(value);
				  	break;
				case descValue:
					nodeDesc.setDescription(value);
					break;
				case tcpCtrFId:
					nodeDesc.setTcpCtrFId("".equals(value)?null:Integer.valueOf(value));
					contractFormat.setTcpCtrFId("".equals(value)?null:Integer.valueOf(value));
					contractNodeFuzzy.setTcpCtrFId("".equals(value)?null:value);
				  	break;
				case contractVersionId:
					contractFormat.setContractVersionId("".equals(value)?null:Integer.valueOf(value));
				  	break;
				case conType:
					contractFormat.setConType(value);
				  	break;
				case xsdHeaderFor:
					contractFormat.setXsdHeaderFor(value);
				  	break;
				case xsdFormat:
					contractFormat.setXsdFormat(value);
				  	break;
				case descriptor:
					contractFormat.setXsdDemo(value);
					contractFormat.setDescriptor(value);
				  	break;
				}
	        }  
		}
			
		if (contractFormat.getTcpCtrFId() == null) {
			//添加协议格式请求信息
			contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
			contractFormat.setState(EAAPConstants.COMM_STATE_VALID);
			Integer contractFormatId = getContractService().addContractFormat(contractFormat);
			contractFormat.setTcpCtrFId(contractFormatId);
			nodeDesc.setTcpCtrFId(contractFormatId);
			contractNodeFuzzy.setTcpCtrFId(contractFormatId+"");
			
		}
		if (nodeDesc.getNodeDescId() == null) {
			nodeDesc.setState(EAAPConstants.COMM_STATE_VALID);
			Integer nodeDescId = getContractService().addNodeDesc(nodeDesc);
			nodeDesc.setNodeDescId(nodeDescId);
			contractNodeFuzzy.setNodeDescId(nodeDescId+"");
		} else {
			nodeDesc.setState(EAAPConstants.COMM_STATE_VALID);
			getContractService().updateNodeDesc(nodeDesc);
		}
		boolean flag = false;
		if(null == contractNodeFuzzy.getContractFuzzyId() &&  null != contractNodeFuzzy.getFuzzyId()){//add
			String contractFuzzyId = getContractService().getNextContractFuzzyId();
			contractNodeFuzzy.setContractFuzzyId(contractFuzzyId);
			getContractService().insertContractFuzzy(contractNodeFuzzy);
		}else if(null != contractNodeFuzzy.getContractFuzzyId() &&  null != contractNodeFuzzy.getFuzzyId()){//update
			getContractService().updateContractFuzzy(contractNodeFuzzy);
		}else if(null != contractNodeFuzzy.getContractFuzzyId() &&  null == contractNodeFuzzy.getFuzzyId()){//delete
			getContractService().deleteContractFuzzy(contractNodeFuzzy);
			flag = true;
		}
		JSONObject pwJson = new JSONObject();
		pwJson.put("tcpCtrFId", nodeDesc.getTcpCtrFId());
		pwJson.put("nodeDescId", nodeDesc.getNodeDescId());
		if(flag){
			pwJson.put("reqNodeFuzzyId", "");
		}else{
			pwJson.put("reqNodeFuzzyId", contractNodeFuzzy.getContractFuzzyId());
		}
		PrintWriter pw = null;
		try {
			pw = getResponse().getWriter();
			pw.write(pwJson.toString()) ;
			pw.flush();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Save protocol anomaly",null));
		}finally{
			if(null != pw){
				pw.close();
			}
		}
	}
	
	public void delContract(){
		JSONObject pwJson = new JSONObject();
		pwJson.put("success", 0);
		if (nodeDescId != null) {
			Map mapTemp = new HashMap();  
			mapTemp.put("nodeDescId", nodeDescId);
			if(!getContractService().isExitMapper(mapTemp)) {
				Map paramMap=new HashMap(); 
				paramMap.put("productId", nodeDescId);
				getContractService().delNodeDesc(paramMap);
			} else {
				pwJson.put("success", 1);
			}
		}
		PrintWriter pw = null;
		try {
			pw = getResponse().getWriter();
			pw.write(pwJson.toString()) ;
			pw.flush();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Save protocol anomaly",null));
		}finally{
			if(null != pw){
				pw.close();
			}
		}
	}
	
    @SuppressWarnings("unchecked")
	public Map  getContractList(Map prar){
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<Map> tmpList = new ArrayList<Map>() ;  		 
         Map map = new HashMap() ;  
           map.put("contractName", "".equals(getRequest().getParameter("contractName"))?null:getRequest().getParameter("contractName")) ;
           map.put("contractNode", "".equals(getRequest().getParameter("contractNode"))?null:getRequest().getParameter("contractNode")) ;
   		   
   		   if(com.linkage.rainbow.util.StringUtil.isEmpty(getRequest().getParameter("isInit"))){
   			   map.put("statu", "A");
   		   }else{
   			   map.put("statu", "".equals(getRequest().getParameter("statu"))?null:getRequest().getParameter("statu"));
   		   }
   		   map.put("base", "".equals(getRequest().getParameter("base"))?null:getRequest().getParameter("base"));
   	       try {
			total= getContractService().searchContractListSum(map);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Get protocol list anomaly",null));
			}         
   	        map.put("queryType", "") ;
   	        map.put("startPage", startRow);
            map.put("endPage", startRow+rows-1);
            
            map.put("startPage_mysql", startRow-1);
            map.put("endPage_mysql", rows);
            tmpList =getContractService().selectContractList(map) ;
   		   
            returnMap.put("startRow", startRow);
            returnMap.put("rows", rows); 	
            returnMap.put("total", total);
            returnMap.put("dataList", page.convertJson(tmpList));  		
   		return returnMap ;
   	}
    //-----------------------------------------------------------------------------------------------------
    public void queryContractList(){
    	try {
    		String name  = getRequest().getParameter("name");
    		String code = getRequest().getParameter("code");
    		Map map = new HashMap();
			if(StringUtils.isNotEmpty(name)){
			   map.put("name", name);			
    		}
			if(StringUtils.isNotEmpty(code)){
				map.put("code", code);
			}
        	List<Map> contractList = new ArrayList<Map>();
        	contractList = getContractService().queryContractList(map);
        	JSONArray jsonObject = JSONArray.fromObject(contractList);
        	getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Query protocol list anomaly",null));
		}
    }
    //-----------------------------------------------------------------------------------------------------
    
    @SuppressWarnings("unchecked")
	public Map  getContractAndVersionList(Map prar){
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<Map> tmpList = new ArrayList<Map>() ;  		 
         Map map = new HashMap() ;  
           map.put("contractName", "".equals(getRequest().getParameter("contractName"))?null:getRequest().getParameter("contractName")) ;
           map.put("contractNode", "".equals(getRequest().getParameter("contractNode"))?null:getRequest().getParameter("contractNode")) ;
   		   map.put("statu", "".equals(getRequest().getParameter("statu"))?null:getRequest().getParameter("statu")) ;
   		   map.put("base", "".equals(getRequest().getParameter("base"))?null:getRequest().getParameter("base"));
   	       try {
			total= getContractService().searchContractAndVersionListSum(map);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Get protocol version anomaly",null));
			}         
   	        map.put("queryType", "") ;
   	        map.put("startPage", startRow);
            map.put("endPage", startRow+rows-1);
            
            map.put("startPage_mysql", startRow-1);
            map.put("endPage_mysql", rows);
            tmpList =getContractService().selectContractAndVersionList(map) ;
   		   
            returnMap.put("startRow", startRow);
            returnMap.put("rows", rows); 	
            returnMap.put("total", total);
            returnMap.put("dataList", page.convertJson(tmpList));  		
   		return returnMap ;
   	}
    
	public Map  getNodeDescList(Map prar){
		String js = "";
		String tcpCtrFIdString = null;
		String nodeDescIdString = null;
		JSONArray dsObjs = new JSONArray();
		if (prar.get("queryParamsData") != null) {
			js = prar.get("queryParamsData").toString();  
			dsObjs = JSONArray.fromObject(js);
		}
		if(dsObjs.size()>0){
			JSONObject obj = (JSONObject) (dsObjs.get(0));
			tcpCtrFIdString = obj.getString("tcpCtrFId");
			nodeDescIdString = obj.getString("nodeDescId");
		}
		
     	 rows = pagination.getRows();
  		 pageNum = pagination.getPage();
  		 int startRow;
  		 startRow = (pageNum - 1) * rows + 1;
  		 Map returnMap = new HashMap();
  		 List<Map> tmpList = new ArrayList<Map>() ;  		 
         Map map = new HashMap() ;  
         map.put("nodeName", "".equals(getRequest().getParameter("nodeDescName"))?null:getRequest().getParameter("nodeDescName")) ;
         map.put("nodeCode", "".equals(getRequest().getParameter("nodeDescCode"))?null:getRequest().getParameter("nodeDescCode")) ;
         if (tcpCtrFIdString==null) {
        	 map.put("tcpCtrFId",  "".equals(getRequest().getParameter("tcpCtrFId"))?null:getRequest().getParameter("tcpCtrFId")) ;
         } else {
        	 map.put("tcpCtrFId", tcpCtrFIdString) ;
         }
         if (nodeDescIdString==null) {
        	 map.put("nodeDescId", "".equals(getRequest().getParameter("nodeDescId"))?null:getRequest().getParameter("nodeDescId")) ;
         } else {
        	 map.put("nodeDescId", nodeDescIdString) ;
         }
         String baseTcpFId = null;
         //基类协议的协议格式ID
         if(null != map.get("tcpCtrFId") && !"".equals(map.get("tcpCtrFId").toString())){
        	 String tcpCtrFId = map.get("tcpCtrFId").toString();
     		Map mapTemp = new HashMap();  
    		mapTemp.put("tcpCtrFId", tcpCtrFId);
        	 baseTcpFId = getContractService().getBaseTcpFIdById(mapTemp);
         }
         if(null != baseTcpFId && !"".equals(baseTcpFId)){
        	 map.put("baseTcpFId", baseTcpFId);
         }
  	     total= getContractService().countChooseNodeDescSum(map);         
  	     map.put("queryType", "") ;
  	     map.put("startPage", startRow);
         map.put("endPage", startRow+rows-1);
           
         map.put("startPage_mysql", startRow-1);
         map.put("endPage_mysql", rows);
         tmpList =getContractService().chooseNodeDesc(map) ;
  		  
         returnMap.put("startRow", startRow);
         returnMap.put("rows", rows); 	
         returnMap.put("total", total);
         returnMap.put("dataList", page.convertJson(tmpList));  		
  		return returnMap ;
  	}
    
    @SuppressWarnings("unchecked")
	public Map  getContractVersionList(Map prar){
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<Map> tmpList = new ArrayList<Map>() ;  		 
         Map map = new HashMap() ;          
         map.put("contractId",  prar.get("queryParamsData").toString()) ;
   	       try {
			total= getContractService().searchContractVersionListSum(map);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Get protocol version anomaly",null));
			}          
   	       map.put("queryType", "") ;
   	       map.put("startPage", startRow);
           map.put("endPage", startRow+rows-1);
           
           map.put("startPage_mysql", startRow-1);
           map.put("endPage_mysql", rows);
        
           tmpList =getContractService().selectContractVersionList(map) ;
           returnMap.put("startRow", startRow);
           returnMap.put("rows", rows); 	
           returnMap.put("total", total);
           returnMap.put("dataList", page.convertJson(tmpList));  		
   		return returnMap ;
   	}   
    
	public String chooseContractBase(){
		try {			
			selectSerInvokeInsList("base");
			Map mapTemp = new HashMap();  
			baseContractList = this.getContractService().getBaseContractList(mapTemp);
		} catch (EAAPException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Choose protocol anomaly",null));
		}
		return SUCCESS;
	}
    @SuppressWarnings("unchecked")
	public Map  getContractBaseList(Map prar){
      	 rows = pagination.getRows();
   		 pageNum = pagination.getPage();
   		 int startRow;
   		 startRow = (pageNum - 1) * rows + 1;
   		 Map returnMap = new HashMap();
   		 List<Map> tmpList = new ArrayList<Map>() ;  		 
         Map map = new HashMap() ;  
           map.put("contractName", "".equals(getRequest().getParameter("contractName"))?null:getRequest().getParameter("contractName")) ;
           map.put("contractNode", "".equals(getRequest().getParameter("contractNode"))?null:getRequest().getParameter("contractNode")) ;
   		   map.put("statu", "".equals(getRequest().getParameter("statu"))?null:getRequest().getParameter("statu")) ;
   		   map.put("base", "".equals(getRequest().getParameter("base"))?null:getRequest().getParameter("base"));
   		   map.put("isBase", "1"); 	//1:协议基类
   	       try {
			total= getContractService().searchContractListSum(map);
			} catch (EAAPException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Get protocol list anomaly",null));
			}         
   	        map.put("queryType", "") ;
   	        map.put("startPage", startRow);
            map.put("endPage", startRow+rows-1);
            
            map.put("startPage_mysql", startRow-1);
            map.put("endPage_mysql", rows);
            tmpList =getContractService().selectContractList(map) ;
   		   
            returnMap.put("startRow", startRow);
            returnMap.put("rows", rows); 	
            returnMap.put("total", total);
            returnMap.put("dataList", page.convertJson(tmpList));  		
   		return returnMap ;
   	}
    
	public enum JsonKeyEnum {
		nodeName,
		nodeCode,
		nodeDescId,
		reqNodeFuzzyId,
		reqFuzzyId,
		parentNodeId,
		nodePath,
		nodeLengthCons,
		nodeNumberCons,
		nodeTypeCons,
		nodeType,
		isNeedSign,
		isNeedCheck,
		nevlConsType,
		nevlConsValue,
		javaField,
		tcpCtrFId,
		contractVersionId,
		conType,
		xsdHeaderFor,
		xsdFormat,
		descriptor,
		descValue;
	}
    
	public List<Map<String, String>> getBaseContractList() {
		return baseContractList;
	}

	public void setBaseContractList(List<Map<String, String>> baseContractList) {
		this.baseContractList = baseContractList;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
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

	public List<Map<String, Object>> getFindContractList() {
		return findContractList;
	}

	public void setFindContractList(List<Map<String, Object>> findContractList) {
		this.findContractList = findContractList;
	}

	public String getContractName() {
		return contractName;
	}

	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	public String getContractNode() {
		return contractNode;
	}

	public void setContractNode(String contractNode) {
		this.contractNode = contractNode;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public String getBase() {
		return base;
	}

	public void setBase(String base) {
		this.base = base;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public String getSelectId() {
		return selectId;
	}

	public void setSelectId(String selectId) {
		this.selectId = selectId;
	}

	public List<Map<String, String>> getDocList() {
		return docList;
	}

	public void setDocList(List<Map<String, String>> docList) {
		this.docList = docList;
	}

	public ContractDefined getContractDefined() {
		return contractDefined;
	}

	public void setContractDefined(ContractDefined contractDefined) {
		this.contractDefined = contractDefined;
	}

	public List<Map<String, Object>> getConTypeList() {
		return conTypeList;
	}

	public void setConTypeList(List<Map<String, Object>> conTypeList) {
		this.conTypeList = conTypeList;
	}

	public Integer[] getReqNodeDescId() {
		return reqNodeDescId;
	}

	public void setReqNodeDescId(Integer[] reqNodeDescId) {
		//this.reqNodeDescId = reqNodeDescId;
		this.reqNodeDescId = Arrays.copyOf(reqNodeDescId, reqNodeDescId.length);
	}

	public String[] getReqNodeDescName() {
		return reqNodeDescName;
	}

	public void setReqNodeDescName(String[] reqNodeDescName) {
		this.reqNodeDescName = Arrays.copyOf(reqNodeDescName, reqNodeDescName.length);
	}

	public String[] getReqNodePath() {
		return reqNodePath;
	}

	public void setReqNodePath(String[] reqNodePath) {
		this.reqNodePath = Arrays.copyOf(reqNodePath, reqNodePath.length);
	}

	public String[] getReqNodeTypeCons() {
		return reqNodeTypeCons;
	}

	public void setReqNodeTypeCons(String[] reqNodeTypeCons) {
		this.reqNodeTypeCons = Arrays.copyOf(reqNodeTypeCons, reqNodeTypeCons.length);
	}

	public String[] getReqNevlConsType() {
		return reqNevlConsType;
	}

	public void setReqNevlConsType(String[] reqNevlConsType) {
		this.reqNevlConsType = Arrays.copyOf(reqNevlConsType, reqNevlConsType.length);
	}

	public String[] getReqNevlConsValue() {
		return reqNevlConsValue;
	}

	public void setReqNevlConsValue(String[] reqNevlConsValue) {
		this.reqNevlConsValue = Arrays.copyOf(reqNevlConsValue, reqNevlConsValue.length);
	}

	public Integer[] getRspNodeDescId() {
		return rspNodeDescId;
	}

	public void setRspNodeDescId(Integer[] rspNodeDescId) {
		this.rspNodeDescId = Arrays.copyOf(rspNodeDescId, rspNodeDescId.length);
	}

	public String[] getRspNodeDescName() {
		return rspNodeDescName;
	}

	public void setRspNodeDescName(String[] rspNodeDescName) {
		this.rspNodeDescName = Arrays.copyOf(rspNodeDescName, rspNodeDescName.length);
	}

	public String[] getRspNodePath() {
		return rspNodePath;
	}

	public void setRspNodePath(String[] rspNodePath) {
		this.rspNodePath = Arrays.copyOf(rspNodePath, rspNodePath.length);
	}

	public String[] getRspNodeTypeCons() {
		return rspNodeTypeCons;
	}

	public void setRspNodeTypeCons(String[] rspNodeTypeCons) {
		this.rspNodeTypeCons = Arrays.copyOf(rspNodeTypeCons, rspNodeTypeCons.length);
	}

	public String[] getRspNevlConsType() {
		return rspNevlConsType;
	}

	public void setRspNevlConsType(String[] rspNevlConsType) {
		this.rspNevlConsType = Arrays.copyOf(rspNevlConsType, rspNevlConsType.length);
	}

	public String[] getRspNevlConsValue() {
		return rspNevlConsValue;
	}

	public void setRspNevlConsValue(String[] rspNevlConsValue) {
		this.rspNevlConsValue =Arrays.copyOf(rspNevlConsValue, rspNevlConsValue.length) ;
	}

	public List<Map<String, Object>> getNevlConsTypeList() {
		return nevlConsTypeList;
	}

	public void setNevlConsTypeList(List<Map<String, Object>> nevlConsTypeList) {
		this.nevlConsTypeList = nevlConsTypeList;
	}

	public List<Map<String, Object>> getNodeNumberConsList() {
		return nodeNumberConsList;
	}

	public void setNodeNumberConsList(List<Map<String, Object>> nodeNumberConsList) {
		this.nodeNumberConsList = nodeNumberConsList;
	}

	public List<Map<String, Object>> getNodeTypeConsList() {
		return nodeTypeConsList;
	}

	public void setNodeTypeConsList(List<Map<String, Object>> nodeTypeConsList) {
		this.nodeTypeConsList = nodeTypeConsList;
	}

	public List<Map<String, String>> getReqNodeDescList() {
		return reqNodeDescList;
	}

	public void setReqNodeDescList(List<Map<String, String>> reqNodeDescList) {
		this.reqNodeDescList = reqNodeDescList;
	}

	public List<Map<String, String>> getRspNodeDescList() {
		return rspNodeDescList;
	}

	public void setRspNodeDescList(List<Map<String, String>> rspNodeDescList) {
		this.rspNodeDescList = rspNodeDescList;
	}

	public String[] getReqNodeType() {
		return reqNodeType;
	}

	public void setReqNodeType(String[] reqNodeType) {
		this.reqNodeType =Arrays.copyOf(reqNodeType, reqNodeType.length) ;
	}

	public String[] getRspNodeType() {
		return rspNodeType;
	}

	public void setRspNodeType(String[] rspNodeType) {
		this.rspNodeType = Arrays.copyOf(rspNodeType, rspNodeType.length) ;
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
	@SuppressWarnings("unchecked")
	public String  selectSerInvokeInsList(String mark){
		Map serInvokeInsStateMap1 = new HashMap();
		Map serInvokeInsStateMap2 = new HashMap();
		if(mark.endsWith("base")){			 
			 serInvokeInsStateMap1.put("name", getText("eaap.op2.portal.prov.effective"));
			 serInvokeInsStateMap1.put("code", "A");			 
			 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.effectiveLoss"));
			 serInvokeInsStateMap2.put("code", "R");
		}
		if(mark.endsWith("check")){
			 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.prov.yes"));
			 serInvokeInsStateMap1.put("code", "Y");			 
			 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.no"));
			 serInvokeInsStateMap2.put("code", "N");
		}
		if(mark.endsWith("audi")){
			 serInvokeInsStateMap1.put("name", getText("eaap.op2.conf.prov.audiOk"));
			 serInvokeInsStateMap1.put("code", "1");			 
			 serInvokeInsStateMap2.put("name", getText("eaap.op2.conf.prov.audiNo"));
			 serInvokeInsStateMap2.put("code", "2");
		}
		 selectStateList.add(serInvokeInsStateMap1);
		 selectStateList.add(serInvokeInsStateMap2);
		 
		return SUCCESS ;
	}

	@SuppressWarnings("unchecked")
	public List<Map> getSelectStateList() {
		return selectStateList;
	}

	@SuppressWarnings("unchecked")
	public void setSelectStateList(List<Map> selectStateList) {
		this.selectStateList = selectStateList;
	}


	public String getReqFrom() {
		return reqFrom;
	}

	public void setReqFrom(String reqFrom) {
		this.reqFrom = reqFrom;
	}

	public String getReqRsp() {
		return reqRsp;
	}

	public void setReqRsp(String reqRsp) {
		this.reqRsp = reqRsp;
	}

	public Integer getContractVersionId() {
		return contractVersionId;
	}

	public void setContractVersionId(Integer contractVersionId) {
		this.contractVersionId = contractVersionId;
	}

	public String[] getReqNodeLengthCons() {
		return reqNodeLengthCons;
	}

	public void setReqNodeLengthCons(String[] reqNodeLengthCons) {
		this.reqNodeLengthCons = Arrays.copyOf(reqNodeLengthCons, reqNodeLengthCons.length) ;
	}

	public String[] getReqNodeNumberCons() {
		return reqNodeNumberCons;
	}

	public void setReqNodeNumberCons(String[] reqNodeNumberCons) {
		this.reqNodeNumberCons = Arrays.copyOf(reqNodeNumberCons, reqNodeNumberCons.length) ;
	}

	public String[] getReqIsNeedSign() {
		return reqIsNeedSign;
	}

	public void setReqIsNeedSign(String[] reqIsNeedSign) {
		this.reqIsNeedSign = Arrays.copyOf(reqIsNeedSign, reqIsNeedSign.length) ;
	}

	public String[] getRspNodeLengthCons() {
		return rspNodeLengthCons;
	}

	public void setRspNodeLengthCons(String[] rspNodeLengthCons) {
		this.rspNodeLengthCons = Arrays.copyOf(rspNodeLengthCons, rspNodeLengthCons.length);
	}

	public String[] getRspNodeNumberCons() {
		return rspNodeNumberCons;
	}

	public void setRspNodeNumberCons(String[] rspNodeNumberCons) {
		this.rspNodeNumberCons = Arrays.copyOf(rspNodeNumberCons, rspNodeNumberCons.length);
	}

	public String[] getRspIsNeedSign() {
		return rspIsNeedSign;
	}

	public void setRspIsNeedSign(String[] rspIsNeedSign) {
		this.rspIsNeedSign = Arrays.copyOf(rspIsNeedSign, rspIsNeedSign.length);
	}

	public String[] getReqIsNeedCheck() {
		return reqIsNeedCheck;
	}

	public void setReqIsNeedCheck(String[] reqIsNeedCheck) {
		this.reqIsNeedCheck = Arrays.copyOf(reqIsNeedCheck, reqIsNeedCheck.length);
	}

	public String[] getRspIsNeedCheck() {
		return rspIsNeedCheck;
	}

	public void setRspIsNeedCheck(String[] rspIsNeedCheck) {
		this.rspIsNeedCheck = Arrays.copyOf(rspIsNeedCheck, rspIsNeedCheck.length);
	}

	public String getContractVersionName() {
		return contractVersionName;
	}

	public void setContractVersionName(String contractVersionName) {
		this.contractVersionName = contractVersionName;
	}

	public String getContractVersionID() {
		return contractVersionID;
	}

	public void setContractVersionID(String contractVersionID) {
		this.contractVersionID = contractVersionID;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public List<Map> getIsBaseList() {
		return isBaseList;
	}

	public void setIsBaseList(List<Map> isBaseList) {
		this.isBaseList = isBaseList;
	}
	public String getPageShowMsg() {
		return pageShowMsg;
	}

	public void setPageShowMsg(String pageShowMsg) {
		this.pageShowMsg = pageShowMsg;
	}
	public String getBaseContractId() {
		return baseContractId;
	}
	public void setBaseContractId(String baseContractId) {
		this.baseContractId = baseContractId;
	}
	public String getBaseContractName() {
		return baseContractName;
	}
	public void setBaseContractName(String baseContractName) {
		this.baseContractName = baseContractName;
	}

	public NodeDesc getNodeDesc() {
		return nodeDesc;
	}

	public void setNodeDesc(NodeDesc nodeDesc) {
		this.nodeDesc = nodeDesc;
	}

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getNodeCode() {
		return nodeCode;
	}

	public void setNodeCode(String nodeCode) {
		this.nodeCode = nodeCode;
	}

	public Integer getTcpCtrFId() {
		return tcpCtrFId;
	}

	public void setTcpCtrFId(Integer tcpCtrFId) {
		this.tcpCtrFId = tcpCtrFId;
	}

	public Integer getNodeDescId() {
		return nodeDescId;
	}

	public void setNodeDescId(Integer nodeDescId) {
		this.nodeDescId = nodeDescId;
	}

	public String getNodeDescName() {
		return nodeDescName;
	}

	public void setNodeDescName(String nodeDescName) {
		this.nodeDescName = nodeDescName;
	}

	public String getNodeDescCode() {
		return nodeDescCode;
	}

	public void setNodeDescCode(String nodeDescCode) {
		this.nodeDescCode = nodeDescCode;
	}

	public Integer getRowIndex() {
		return rowIndex;
	}

	public void setRowIndex(Integer rowIndex) {
		this.rowIndex = rowIndex;
	}

	public String getReqRspFlag() {
		return reqRspFlag;
	}

	public void setReqRspFlag(String reqRspFlag) {
		this.reqRspFlag = reqRspFlag;
	}

	public List<Map<String,String>> getListJavaFieldReq() {
		return listJavaFieldReq;
	}

	public void setListJavaFieldReq(List<Map<String,String>> listJavaFieldReq) {
		this.listJavaFieldReq = listJavaFieldReq;
	}

	public List<Map<String,String>> getListJavaFieldRsp() {
		return listJavaFieldRsp;
	}

	public void setListJavaFieldRsp(List<Map<String,String>> listJavaFieldRsp) {
		this.listJavaFieldRsp = listJavaFieldRsp;
	}

	public String getReqXsdFormat() {
		return reqXsdFormat;
	}

	public void setReqXsdFormat(String reqXsdFormat) {
		this.reqXsdFormat = reqXsdFormat;
	}

	public String getReq_rsp() {
		return req_rsp;
	}

	public void setReq_rsp(String req_rsp) {
		this.req_rsp = req_rsp;
	}

	public String getFormatType() {
		return formatType;
	}

	public void setFormatType(String formatType) {
		this.formatType = formatType;
	}

	public String getHeaderFor() {
		return headerFor;
	}

	public void setHeaderFor(String headerFor) {
		this.headerFor = headerFor;
	}

	public String getDemo() {
		return demo;
	}

	public void setDemo(String demo) {
		this.demo = demo;
	}

	public String getContractAttrSpec() {
		return contractAttrSpec;
	}
	public void setContractAttrSpec(String contractAttrSpec) {
		this.contractAttrSpec = contractAttrSpec;
	}

	public String getChooseContractId() {
		return chooseContractId;
	}

	public void setChooseContractId(String chooseContractId) {
		this.chooseContractId = chooseContractId;
	}

	public String getChooseContractName() {
		return chooseContractName;
	}

	public void setChooseContractName(String chooseContractName) {
		this.chooseContractName = chooseContractName;
	}

	public static Map<String, String> getStoreMap() {
		return storeMap;
	}

	public static void setStoreMap(Map<String, String> storeMap) {
		ContractAction.storeMap = storeMap;
	}

	public Template getTemplate() {
		return template;
	}
	public void setTemplate(Template template) {
		this.template = template;
	}

	public Template getGlobalTemplate() {
		return globalTemplate;
	}
	public void setGlobalTemplate(Template globalTemplate) {
		this.globalTemplate = globalTemplate;
	}
	
	private String parseXpath(String spath){
		String[] npathAay=spath.split("/");
        StringBuilder newPath=new StringBuilder();
        for(String subpath:npathAay){
        	if(subpath!=null&&!"".equals(subpath)){
        		if(subpath.indexOf("<XML_SPLIT>")>-1){//cdata处理
        			if(subpath.indexOf(":")>-1){//带cdata且有命名空间
            			newPath.append("/*[local-name()='").append(subpath.substring(0,subpath.length()-11).split(":")[1]).append("']<XML_SPLIT>");
            		}else{//带cdata且没有命名空间
            			newPath.append("/").append(subpath);
            		}
        		}else{
        			if(subpath.indexOf(":")>-1){//不带cdata且有命名空间
            			newPath.append("/*[local-name()='").append(subpath.split(":")[1]).append("']");
            		}else{//不带cdata且没有命名空间
            			newPath.append("/").append(subpath);
            		}
        		}
        		
        	}
        }
        return newPath.toString();
	}
	
}
