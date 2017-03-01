package com.ailk.eaap.op2.conf.techImpl.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;
import java.util.List;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.security.SecurityUtil;
import com.ailk.eaap.o2p.common.spring.config.CustomPropertyConfigurer;
import com.ailk.eaap.o2p.security.SecurityType;
import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.CommProtocal;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.ControlCounterms;
import com.ailk.eaap.op2.bo.CtlCounterms2Tech;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.TechImpAtt;
import com.ailk.eaap.op2.bo.TechImpAttrSpec;
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.conf.serviceManager.service.IServiceManagerServ;
import com.ailk.eaap.op2.conf.techImpl.service.ITechImplService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.conf.util.PropertiesUtil;
import com.ailk.eaap.op2.conf.wsdlImport.service.IWsdlService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.StringUtil;

public class TechImplAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private static Logger log = Logger.getLog(TechImplAction.class);
	private int rows;
	private int page;
	private Pagination pagination = new Pagination();
	private ITechImplService techImplService;
	private IServiceManagerServ iServiceManagerServ;
	//锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷选值
	private List<Component> selectComponentList = new ArrayList<Component>();
	//锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟窖≈�
	private List<Service> serviceList = new ArrayList<Service>();
	private Service service = new Service();
	//锟斤拷锟斤拷锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟叫憋拷
	private List<Map> techImplList = new ArrayList<Map>();
	private List<AttrSpec> attrSpecList = new ArrayList<AttrSpec>();
	//通讯协锟斤拷锟斤拷锟斤拷锟叫憋拷
	//锟斤拷锟斤拷实锟斤拷
	//锟斤拷锟皆癸拷锟�
	private AttrSpec attrSpec = new AttrSpec();
	//锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷
	private TechImpAtt techImpAtt = new TechImpAtt();
    //锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷
	SerTechImpl serTechImpl = new SerTechImpl();
	TechImpAttrSpec techImpAttrSpec = new TechImpAttrSpec();
	private ControlCounterms controlCounterms = new ControlCounterms();
	private List<ControlCounterms> ctlCountermsList = new ArrayList<ControlCounterms>();
	private List<Map> commProtocalList = new ArrayList<Map>();
	private List<Map<String,Object>> commProtocalResultList = new ArrayList<Map<String,Object>>();
	private String techImplId="";
	private String techImplName="";
	private Org org = new Org();
	private Component component = new Component();
	private TechImpl techImpl =  new TechImpl();
	private CommProtocal commProtocal = new CommProtocal();
	private String callUrl="";
	private String overtime="";
	private String webserviceMethodName="";
	private String webserviceParamNameSpace="";
	private String webserviceParamName="";
	private String address="";
	private String timeout="";
	private String method="";
	private String inparamnamespace="";
	private String inparamname="";
	private String returnparam="";
	private String webserviceReturnParamName="";	
	private String namespace="";	
	private String ftpUsername ="";
	private String ftpPassword= "";
	private String ftpServerIp= "";
	private String ftpPort="";
	private String sftpUsername="";
	private String sftpPassword= "";
	private String sftpServerIp= "";
	private String sftpPort= "";
	//因为file是存放在临时文件夹的文件,但是要与前台提交的名称file相同
	private File AUTH_FILE_PATH;
	//提交过来的file的名字
	private String AUTH_FILE_PATHFileName;
	//提交过来的file的MIME类型
	private String fileContentType;
	List<Map> tmpList = new ArrayList<Map>() ;
    private List<Map> ccTypeList = new ArrayList<Map>() ;
	private List<Map> cycleTyleList = new ArrayList<Map>() ;
	private List<Map> cc2cStatelist = new ArrayList<Map>() ;
	private List<Map> cutmsValueTypelist = new ArrayList<Map>() ;
	private CtlCounterms2Tech ctlCounterms2Tech = new CtlCounterms2Tech();
	private ControlCounterms controlCouterms = new ControlCounterms();
	Map techAttrSpecHashMap  = new HashMap();
	private String orgName = "";
	private String ComponentName = "";
	private String pageState ="";
	private Map techImplMap = new HashMap();
	private String[] attrValue;//页面传来的动态属性值
	private String[] attrKey;
	
	private List<Map> techNodeList = new ArrayList<Map>();
	private String routeObjs;
	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public CommProtocal getCommProtocal() {
		return commProtocal;
	}

	public void setCommProtocal(CommProtocal commProtocal) {
		this.commProtocal = commProtocal;
	}

	public String getCallUrl() {
		return callUrl;
	}

	public void setCallUrl(String callUrl) {
		this.callUrl = callUrl;
	}

	public String getOvertime() {
		return overtime;
	}

	public void setOvertime(String overtime) {
		this.overtime = overtime;
	}

	public String getWebserviceMethodName() {
		return webserviceMethodName;
	}

	public void setWebserviceMethodName(String webserviceMethodName) {
		this.webserviceMethodName = webserviceMethodName;
	}

	public String getWebserviceParamNameSpace() {
		return webserviceParamNameSpace;
	}

	public void setWebserviceParamNameSpace(String webserviceParamNameSpace) {
		this.webserviceParamNameSpace = webserviceParamNameSpace;
	}

	public String getWebserviceParamName() {
		return webserviceParamName;
	}

	public void setWebserviceParamName(String webserviceParamName) {
		this.webserviceParamName = webserviceParamName;
	}

	public String getWebserviceReturnParamName() {
		return webserviceReturnParamName;
	}

	public void setWebserviceReturnParamName(String webserviceReturnParamName) {
		this.webserviceReturnParamName = webserviceReturnParamName;
	}

	public TechImplAction (){
	}

	//锟斤拷锟斤拷实锟斤拷锟斤拷页
	public String showTechImplIndex(){
		
		  Map cc2cState1 = new HashMap();
	       cc2cState1.put("stateCode", "A");
	       cc2cState1.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
	       
	       Map cc2cState2 = new HashMap();
	       cc2cState2.put("stateCode", "R");
	       cc2cState2.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
	       
	       cc2cStatelist.add(cc2cState1);
	       cc2cStatelist.add(cc2cState2);
	       
		//展示通锟斤拷协锟斤拷
		commProtocalList = getServiceManagerServ().queryCommProtocalListList();
		Map mapTest = new HashMap(); 
		mapTest.put("commProtocalName", "");
		mapTest.put("commProtocalId", "");
		commProtocalResultList.add(mapTest);
		for (Map hashMap : commProtocalList) {
			Map map = new HashMap(); 
			map.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
			map.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
			commProtocalResultList.add(map);
		}
		return SUCCESS;
	}
	
	//锟斤拷锟斤拷实锟斤拷锟斤拷页
	public String chooseTechImpl(){
		//展示通锟斤拷协锟斤拷
		commProtocalList = getServiceManagerServ().queryCommProtocalListList();
		for (Map hashMap : commProtocalList) {
			Map mapTest = new HashMap(); 
			mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
			mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
			commProtocalResultList.add(mapTest);
		}
		return SUCCESS;
	}
		
	//锟斤拷锟斤拷锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷(锟斤拷示锟斤拷锟斤拷锟矫硷拷锟斤拷实锟斤拷)
	public String showTechImpl(){
		//TODO 1 锟斤拷始锟斤拷锟斤拷锟截碉拷前锟矫伙拷锟斤拷锟叫碉拷org(锟斤拷锟�锟斤拷确锟斤拷锟斤拷锟矫伙拷锟斤拷应锟斤拷色锟斤拷锟斤拷色锟斤拷应锟斤拷
    	Map map = new HashMap();
    	map.put("orgId","100001,600105");
    	
    	//2 锟斤拷始锟斤拷锟斤拷锟斤拷 锟斤拷前锟矫伙拷锟斤拷锟斤拷ORG锟铰碉拷全锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟�
    	selectComponentList = getTechImplService().queryComponentInfo(map);
    	//5 锟斤拷锟截匡拷锟狡诧拷锟斤拷
    	ctlCountermsList = getTechImplService().queryControlCountermsList();
		return SUCCESS;
	}
	
	//展示锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷
	public String showTechImplDetail(){
    	//2 锟斤拷锟截匡拷锟狡诧拷锟斤拷
    	ctlCountermsList = getTechImplService().queryControlCountermsList();
    	
    	String idStr = getRequest().getParameter("idStr");
		if (StringUtils.isNotBlank(idStr)){
			String[] str = idStr.split(",");
			//3 锟斤拷锟斤拷锟斤拷拥锟斤拷锟较�
			techImpl.setTechImplId(Integer.parseInt(str[0]));
			techImpl = getTechImplService().queryTechImpl(techImpl);
			
			serTechImpl.setTechImplId(Integer.parseInt(str[0]));
			serTechImpl.setSerTechImplId(Integer.parseInt(str[1]));
			serTechImpl = getTechImplService().querySerTechImpl(serTechImpl);
			
			ctlCounterms2Tech.setTechImplId(Integer.parseInt(str[0]));
			ctlCounterms2Tech = getTechImplService().queryCtlCounterms2Tech(ctlCounterms2Tech);
			
			component.setComponentId(techImpl.getComponentId().trim());
			component = getTechImplService().queryComponent(component);
			
			service.setServiceId(serTechImpl.getServiceId());
			service = getTechImplService().queryService(service);
		}
		return SUCCESS;
	}
	//锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷 锟斤拷锟斤拷锟斤拷
	public String addTechImplInfo(){
		commProtocalList = getServiceManagerServ().queryCommProtocalListList();
		for (Map hashMap : commProtocalList) {
			Map mapTest = new HashMap(); 
			mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
			mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
			commProtocalResultList.add(mapTest);
		}
		getRequest().getSession().setAttribute("TechImpl.techImplId",null);
		
		return SUCCESS;
	}
	
	public void encryptionPassword(){
		PrintWriter out =null;
		try {
			String CiphertextPassword ="";
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			String plaintextPassword = getRequest().getParameter("PlaintextPassword");		//明文
			CiphertextPassword = SecurityUtil.getInstance().encryMsg(plaintextPassword);
			CiphertextPassword = CiphertextPassword.replace("\r", "\\\\r");
			CiphertextPassword = CiphertextPassword.replace("\n", "\\\\n");
		    String ret="{\"ResultCode\":\"Success\",\"ResultDesc\":\"Encryption Password Success!\",\"CiphertextPassword\":\""+CiphertextPassword+"\"}";
			out.print(ret);
		}  catch (Exception e) {
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
	
	//进入upload页面
	public String upload(){
		return SUCCESS;
	}
	
//注意，file并不是指前端jsp上传过来的文件本身，而是文件上传过来存放在临时文件夹下面的文件
public String getFileContentType() {
	return fileContentType;
}
public void setFileContentType(String fileContentType) {
	this.fileContentType = fileContentType;
}


	
		/**
		* Description: 向FTP服务器上传文件
		* @param url FTP服务器hostname
		* @param port FTP服务器端口
		* @param username FTP登录账号
		* @param password FTP登录密码
		* @param path FTP服务器保存目录
		* @param filename 上传到FTP服务器上的文件名
		* @param input 输入流
		* @return 成功返回true，否则返回false
		*/ 
	    public static boolean uploadFile(String url,int port,String username, String password, String path, String filename, InputStream input) { 
	        boolean success = false; 
	        FTPClient ftp = new FTPClient(); 
	        try { 
	            int reply; 
	            ftp.connect(url, port);//连接FTP服务器 
	            //如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器 
	            ftp.login(username, password);//登录 
	            reply = ftp.getReplyCode(); 
	            if (!FTPReply.isPositiveCompletion(reply)) { 
	                ftp.disconnect(); 
	                return success; 
	            } 
	            ftp.changeWorkingDirectory(path); 
	            ftp.storeFile(filename, input);          
	             
	            input.close(); 
	            ftp.logout(); 
	            success = true; 
	        } catch (IOException e) { 
	            //e.printStackTrace();
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
	        } finally { 
	            if (ftp.isConnected()) { 
	                try { 
	                    ftp.disconnect(); 
	                } catch (IOException ioe) { 
	    				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,ioe.getMessage(),null));
	                } 
	            } 
	        } 
	        return success; 
	    }
	
	//锟斤拷锟斤拷锟斤拷锟斤拷锟矫的硷拷锟斤拷实锟斤拷锟斤拷息-锟斤拷询锟斤拷
	public String loadHasCfgIndex(){
    	String componentId = getRequest().getParameter("componentId");
    	techImpl.setComponentId(componentId);
		return SUCCESS;
	}
	
	//锟斤拷锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷息锟斤拷锟斤拷锟斤拷
	public String saveTechImplAndSvc(){
		String type = getRequest().getParameter("type");
		if("add".equals(type)){ //锟斤拷锟斤拷锟斤拷锟斤拷
			//锟斤拷锟斤拷 锟斤拷锟斤拷锟斤拷实锟斤拷锟叫憋拷 SER_TECH_IMPL
			  String serTechImplId = getTechImplService().querySerTechImplSeq();
			  serTechImpl.setSerTechImplId(Integer.parseInt(serTechImplId));
			  serTechImpl.setState("A");
			  getTechImplService().insertSerTechImpl(serTechImpl);
		}else{
			serTechImpl.setLastestTime(new Date());
			getTechImplService().updateSerTechImpl(serTechImpl);
		}
		
		return SUCCESS;
	}
	
	//锟斤拷锟芥技锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷息
	public String saveTechImpl(){
		//1 锟斤拷锟斤拷 锟斤拷锟斤拷实锟街憋拷 TECH_IMPL
		  String techImplId = getTechImplService().queryTechImplSeq();
		  techImpl.setTechImplId(Integer.parseInt(techImplId));
		  techImpl.setUsealbeState("A"); //A 锟斤拷 R锟届常
		  techImpl.setTechImpConPoId(1);
		
		//2 锟斤拷锟斤拷 锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷 TECH_IMP_ATT
		  String[] attrSpecIdStr = getRequest().getParameterValues("attrSpecIdStr");
		  String[] attrSpecValueStr = getRequest().getParameterValues("attrSpecValueStr");
		  List<TechImpAtt> techImpAttList = new ArrayList<TechImpAtt>();
		  TechImpAtt tech_imp_att = null;
		  if (attrSpecValueStr != null && attrSpecIdStr != null) {
			  for (int i = 0 ;i < attrSpecValueStr.length ; i++){
					  tech_imp_att = new TechImpAtt();
					  String techImpAttId = getTechImplService().queryTechImpAttSeq();
					  tech_imp_att.setTechImpAttId(Integer.parseInt(techImpAttId));
					  tech_imp_att.setAttrSpecId(Integer.parseInt(attrSpecIdStr[i]));
					  tech_imp_att.setAttrSpecValue(attrSpecValueStr[i]==null?"":attrSpecValueStr[i]);
					  tech_imp_att.setTechImplId(Integer.parseInt(techImplId));
					  tech_imp_att.setState("A");
					  techImpAttList.add(tech_imp_att);
			  }
		  }
		 
		//3 锟斤拷锟斤拷 锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷 CTL_COUNTERMS_2_TECH
		  ctlCounterms2Tech.setTechImplId(Integer.parseInt(techImplId));
		  ctlCounterms2Tech.setEffectState("A");
		  
		  getTechImplService().insertTechImplCfgInfo(techImpl, techImpAttList, ctlCounterms2Tech);
		return SUCCESS;
	}
	
	
	
	//锟斤拷锟斤拷锟斤拷锟斤拷锟截凤拷锟斤拷
	public String loadServiceByCompId(){
		Map<String,String> map = new HashMap<String,String>();
		String componentId = getRequest().getParameter("componentId");
		map.put("componentId", componentId);
		
		List<Map> serviceLists = this.getTechImplService().querySvcInfoByCompId(map);
		try {
			StringBuilder sb = new StringBuilder("");
			sb.append("{\"serviceList\":"+JSONArray.fromObject(serviceLists).toString()+"}") ;
			
			PrintWriter pw = getResponse().getWriter() ;
			pw.write(sb.toString()) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return NONE;
	}
	// 锟斤拷锟酵拷锟叫拷锟斤拷锟斤拷投锟教拷锟斤拷丶锟斤拷锟绞碉拷锟斤拷锟斤拷锟�
	public String loadTechImplAttr(){
		Map map = new HashMap();
		String commProCd = getRequest().getParameter("commProCd");
		map.put("commProCd", commProCd);
		
		List<AttrSpec> attrSpecList = getTechImplService().loadTechImplAttrList(map);
		JSONArray jsonArr = JSONArray.fromObject(attrSpecList);
		StringBuffer sb = new StringBuffer();
    	sb.append("{\"rows\":").append(jsonArr.toString()).append("}");
		try {
			PrintWriter  write = getResponse().getWriter();
			write.println(sb.toString());
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return NONE;
	}
	// 锟斤拷莘锟斤拷锟斤拷锟绞碉拷锟絠d锟斤拷锟斤拷锟斤拷锟斤拷锟矫的硷拷锟斤拷实锟斤拷锟斤拷锟斤拷
	public String loadCfgedTechImplAttr(){
		Map map = new HashMap();
		String techImplId = getRequest().getParameter("techImplId");
		map.put("techImplId", techImplId);
		
		List<Map> objMapList = getTechImplService().selectCfgedTechImplAtt(map);
		if (objMapList!=null && objMapList.size()>0){ //锟斤拷锟斤拷锟斤拷锟斤拷值为锟斤拷时锟斤拷锟斤拷锟斤拷示null值
			for (int i=0;i<objMapList.size();i++){
				Map objMap = (Map)objMapList.get(i);
				if(objMap.get("ATTR_SPEC_VALUE")==null){
					objMap.put("ATTR_SPEC_VALUE", "");
				}
			}
		}
		JSONArray jsonArr = JSONArray.fromObject(objMapList);
		StringBuffer sb = new StringBuffer();
    	sb.append("{\"rows\":").append(jsonArr.toString()).append("}");
		try {
			PrintWriter  write = getResponse().getWriter();
			write.println(sb.toString());
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return NONE;
	}
	/**
	 * -----------------------------------------------------------------------------------
	 * @return
	 * 锟斤拷锟斤拷实锟街诧拷询锟斤拷展示
	 */
	public Map showServiceSupRegisterGrid(Map para){       //
		rows = pagination.getRows();
		page = pagination.getPage();
		int startRow;
		int total;
		Map hashMap = new HashMap();
		String usealbeState = null;
		if(StringUtil.isEmpty(getRequest().getParameter("isInit"))){
			usealbeState = "A";
		}else{
			usealbeState = "".equals(getRequest().getParameter("usealbeState"))? null:getRequest().getParameter("usealbeState");
		}
		String _componentCode = getRequest().getParameter("componentCode");
		String _componentName = getRequest().getParameter("componentName");
		if (StringUtils.isNotEmpty(_componentCode)
				||StringUtils.isNotEmpty(_componentName)
				||StringUtils.isNotEmpty(getRequest().getParameter("orgId"))
				||StringUtils.isNotEmpty(getRequest().getParameter("commProCd"))
				||StringUtils.isNotEmpty(usealbeState) 
				||StringUtils.isNotEmpty(getRequest().getParameter("techImplName"))) {
			
			String componentCode = null;
			if(null != _componentCode && !"".equals(_componentCode)){
				componentCode = _componentCode;
			}
			String componentName = null;
			if(null != _componentName && !"".equals(_componentName)){
				componentName = _componentName;
			}
			String commProCd = null;
			if(null != getRequest().getParameter("commProCd") && !"".equals(getRequest().getParameter("commProCd"))){
				commProCd = getRequest().getParameter("commProCd");
			}
			String orgId = null;
			if(null != getRequest().getParameter("orgId") && !"".equals(getRequest().getParameter("orgId"))){
				orgId = getRequest().getParameter("orgId");
			}
			
			String techImplName = null;
			if(null != getRequest().getParameter("techImplName") && !"".equals(getRequest().getParameter("techImplName"))){
				techImplName = getRequest().getParameter("techImplName");
			}
			//if (page == 1) {
				startRow = (page - 1) * rows + 1;
			//} else {
			//	startRow = (page - 1) * rows + 1;
			//}
			hashMap.put("startRow", startRow);
			hashMap.put("rows", rows);
			hashMap.put("pro_mysql", startRow - 1);
			hashMap.put("page_record", rows);
			hashMap.put("componentCode", componentCode);
			hashMap.put("orgId", orgId);
			hashMap.put("commProCd", commProCd);	
			hashMap.put("techImplName", techImplName);	
			hashMap.put("componentName", componentName);
			hashMap.put("usealbeState", usealbeState);
			
			techImplList = getTechImplService().queryServiceSupplierRegister(hashMap);
			for(Map techMap:techImplList){
					List<Map> xxHashMap = new ArrayList<Map>();
					xxHashMap = getTechImplService().queryTechAttrSpecById(techMap);
					for(int i=0;i<xxHashMap.size();i++){
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("inparamname")){
						  techMap.put("webserviceParamName",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
						}
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("returnparam")){
					      techMap.put("webserviceReturnParamName",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					    }
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("address")){
						      techMap.put("callUrl",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
						    }
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("timeout")){
						      techMap.put("overtime",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
						    }
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("inparamnamespace")){
						      techMap.put("webserviceParamNameSpace",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
						    }
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("method")){
						      techMap.put("webserviceMethodName",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
						    }
						if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("namespace")){
						      techMap.put("namespace",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
						    }
					}
			}
			hashMap.put("total", Integer.parseInt(getTechImplService().queryServiceSupplierRegisterCount(hashMap)));
			hashMap.put("dataList", pagination.convertJson(techImplList));
			return hashMap;
		} else {
			//if (page == 1) {
				startRow = (page - 1) * rows + 1;
			//} else {
			//	startRow = (page - 1) * rows + 1;
			//}
			hashMap.put("startRow", startRow);
			hashMap.put("rows", rows);
			hashMap.put("pro_mysql", startRow - 1);
			hashMap.put("page_record", rows);
			techImplList = getTechImplService().queryServiceSupplierRegister(hashMap);
			for(Map techMap:techImplList){
				List<Map> xxHashMap = new ArrayList<Map>();
				xxHashMap = getTechImplService().queryTechAttrSpecById(techMap);
				for(int i=0;i<xxHashMap.size();i++){
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("inparamname")){
					  techMap.put("webserviceParamName",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					}
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("returnparam")){
				      techMap.put("webserviceReturnParamName",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
				    }
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("address")){
					      techMap.put("callUrl",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					    }
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("timeout")){
					      techMap.put("overtime",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					    }
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("inparamnamespace")){
					      techMap.put("webserviceParamNameSpace",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					    }
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("method")){
					      techMap.put("webserviceMethodName",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					    }
					if(xxHashMap.get(i).get("ATTR_SPEC_CODE").toString().equals("namespace")){
					      techMap.put("namespace",xxHashMap.get(i).get("ATTR_SPEC_VALUE"));	
					    }
				}
				
				
			}
			hashMap.put("total", Integer.parseInt(getTechImplService().queryServiceSupplierRegisterCount(hashMap)));
			hashMap.put("dataList", pagination.convertJson(techImplList));
			return hashMap;
		}
				
	}
	/**
	 * uploadFile
	 * @return
	 */
	public String uploadFile() {
		String jsonStr ="";//返回数据
		String saveName = "";
		//获取上传的文件
		//上传 到本地临时目录
		if (AUTH_FILE_PATH!=null) {
			InputStream is = null;
			OutputStream os = null;
			try {
				//读取配置文件 保存地址
				String savePath = PropertiesUtil.getValueByProCode("file.savePath");

					 saveName = System.currentTimeMillis()+AUTH_FILE_PATHFileName;
			        is  = new FileInputStream(AUTH_FILE_PATH);
			        os = new FileOutputStream(new File(savePath, saveName));
			        byte[] buffer = new byte[1024];
			        int length = 0;
			        while(-1 != (length = is.read(buffer, 0, buffer.length))){
			            os.write(buffer);
			        }
					if(null != is){
						is.close();
					}
					if(null != os){
						os.close();
					}

				fileFilePath = savePath+""+saveName;
				jsonStr ="[{\"msg\":\"1\",\"data\":\""+fileFilePath+"\"}]";
			} catch (IOException e) {
				//e.printStackTrace();
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}finally{
				if(null != is){
					try {
						is.close();
					} catch (IOException e) {
						log.error(e.getMessage());
					}
				}
				if(null != os){
					try {
						os.close();
					} catch (IOException e) {
						log.error(e.getMessage());
					}
				}
			}
		}else {
			jsonStr ="[{\"msg\":\"0\",\"data\":\"Please choose a file!\"}]";
		}
		
		//返回json数据
		PrintWriter pw;
		try {
			pw = getResponse().getWriter();
			pw.write(jsonStr) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	}
	
	
	private String fileFilePath="";
	public String addTechImplInfoToNext(){
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
	       
	       //新添加保存代码  mawl
	       Map hashMapType = new HashMap();
		   hashMapType.put("commProCd", commProtocal.getCommProCd());
		   tmpList = getServiceManagerServ().queryTechImplAttrSpec(hashMapType);
		   Map<String,String> mapKey = new HashMap<String,String>();
		   for(int i=0;i<tmpList.size();i++){
			   mapKey.put(tmpList.get(i).get("ATTR_SPEC_CODE").toString(), tmpList.get(i).get("ATTR_SPEC_ID").toString());
		   }
		   Map<String,String> mapAttr = new HashMap<String,String>();
		   for(int i=0;i<attrKey.length;i++){
			   mapAttr.put(mapKey.get(attrKey[i])+"_"+i, attrValue[i]);
		   }
		   techImplId= (String)(getRequest().getSession().getAttribute("TechImpl.techImplId"));
		   if(techImplId==null||"".equals(techImplId)){
			   techImplId = getTechImplService().addTechImplMessage(commProtocal,techImpl,mapAttr);//添加技术实现相关记录，返回技术实现ID
			   getRequest().getSession().setAttribute("TechImpl.techImplId",techImplId);
		   }else{
			   techImpl.setTechImplId(Integer.parseInt(techImplId));
			   getTechImplService().updateTechImpl(commProtocal,techImpl,mapAttr);
		   }
		return SUCCESS;
	}
	
	 //上传操作
	    public String fileUploadToTemp() throws IOException{
	    //保存地址
		String savePath = ServletActionContext.getServletContext().getRealPath("/upload/");
		//D:apache/webapps/项目名/upload
		if (AUTH_FILE_PATH!=null) {
			InputStream is = null;
			OutputStream os = null;
			try{
		        is = new FileInputStream(AUTH_FILE_PATH);
		        os = new FileOutputStream(new File(savePath, AUTH_FILE_PATHFileName));
	
		        byte[] buffer = new byte[1024];
		        int length = 0;
		        while(-1 != (length = is.read(buffer, 0, buffer.length))){
		            os.write(buffer);
		        }
		        if(null != os){
		        	os.close();
		        }
		        if(null != is){
		        	is.close();
		        }
			} catch (IOException e) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}finally{
				if(null != is){
					try {
						is.close();
					} catch (IOException e) {
						log.error(e.getMessage());
					}
				}
				if(null != os){
					try {
						os.close();
					} catch (IOException e) {
						log.error(e.getMessage());
					}
				}
			}
		}
       return savePath+"/"+AUTH_FILE_PATHFileName;
	}
	    
	/**
	 * 锟斤拷锟斤拷锟斤拷锟狡诧拷锟斤拷展示
	 * @param para
	 * @return
	 */
	public Map getCC2CList(Map para){
		   	 rows = pagination.getRows();
		   	 page = pagination.getPage();
			 int startRow;
			 int total;
			 startRow = (page - 1) * rows + 1;
			 Map returnMap = new HashMap();
			 
			 
		     Map map = new HashMap() ;
		     map.put("techImplId", getRequest().getParameter("techImplId")) ;
		     map.put("queryType", "ALLNUM") ;
		     total=Integer.valueOf(String.valueOf(getServiceManagerServ().queryCC2cInfoListById(map).get(0).get("ALLNUM"))) ;
		     map.put("queryType", "") ;
		     map.put("pro", startRow);
		     map.put("end", startRow+rows-1);
		     map.put("pro_mysql", startRow - 1);
		     map.put("page_record", rows);
		     
		     tmpList =getServiceManagerServ().queryCC2cInfoListById(map) ;
			   
		     Map cycleType = new HashMap();
		     cycleType.put("1", getText("eaap.op2.conf.manager.auth.cycletype1"));
		     cycleType.put("2", getText("eaap.op2.conf.manager.auth.cycletype2"));
		     cycleType.put("3", getText("eaap.op2.conf.manager.auth.cycletype3"));
		     cycleType.put("4", getText("eaap.op2.conf.manager.auth.cycletype4"));
		     cycleType.put("5", getText("eaap.op2.conf.manager.auth.cycletype5"));
		     cycleType.put("6", getText("eaap.op2.conf.manager.auth.cycletype6"));
		     
		     Map effectState = new HashMap();
		     effectState.put("A", getText("eaap.op2.conf.manager.auth.effective"));
		     effectState.put("R", getText("eaap.op2.conf.manager.auth.effectiveLoss"));
		     
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
     * 锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷锟狡诧拷锟斤拷
     * @return
     */
	public void addServiceSupRegTechCtl(){
	       
	       PrintWriter out =null;
	       String techImplSeq ="";
			try {
				getRequest().setCharacterEncoding("UTF-8");
				 if(StringUtils.isNotEmpty(getRequest().getParameter("techImplIdSeq"))){
					techImplSeq=getRequest().getParameter("techImplIdSeq");
					 ctlCounterms2Tech.setTechImplId(Integer.parseInt(techImplSeq));
					 getServiceManagerServ().insertCtlCounterms2Tech(ctlCounterms2Tech);
				 } else{				 
					 techImplSeq  = getTechImplService().queryTechImplSeq();
					 ctlCounterms2Tech.setTechImplId(Integer.parseInt(techImplSeq));
					 techImpl.setTechImplId(Integer.parseInt(techImplSeq));
					 techImpl.setUsealbeState("A");//设置状态
					 getTechImplService().insertTechImpl(techImpl);
				     getServiceManagerServ().insertCtlCounterms2Tech(ctlCounterms2Tech);		
				 }	
			     getResponse().setContentType("text/html;charset=UTF-8");
			     out = getResponse().getWriter();
			     String xx="[{\"msg\":\"ok\",\"data\":\""+techImplSeq+"\"}]";
			     out.print(xx);
			}  catch (Exception e) {
				if (out != null) {
					out.print("failure");
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
     * 删锟斤拷锟斤拷锟斤拷锟斤拷锟狡诧拷锟斤拷
     * @return
     */
	public void delServiceSupRegTechCtlUpdate(){
	       
	   //锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷
	       PrintWriter out =null;
	       String techImplSeq ="";
			try {
				getRequest().setCharacterEncoding("UTF-8");
				 if(StringUtils.isNotEmpty(getRequest().getParameter("cc_cd"))&&StringUtils.isNotEmpty(getRequest().getParameter("techImplId"))){
				       Map hashMap = new HashMap();
				       hashMap.put("cc_cd", getRequest().getParameter("cc_cd"));
				       hashMap.put("techImplId", getRequest().getParameter("techImplId"));
				       getTechImplService().deleteCtlCounterms2Tech(hashMap);
				 }	
			     getResponse().setContentType("text/html;charset=UTF-8");
			     out = getResponse().getWriter();
			     String xx="[{\"msg\":\"ok\"}]";
			     out.print(xx);
			}  catch (Exception e) {
				if (out != null) {
					out.print("failure");
				}
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
			}finally{
				if (out != null) {
					out.flush();
					out.close();
				}
			}

	}
	/***
	 * 锟斤拷锟接硷拷锟斤拷实锟斤拷
	 * @return
	 */
	public String addTechImpl(){
		String savePath = "";
		//获取页面传递来的参数
		String callUrl =getRequest().getParameter("callUrl");
		String _overtime =getRequest().getParameter("overtime");
		String _webserviceMethodName = getRequest().getParameter("webserviceMethodName");
		String webserviceParamNameSpace = getRequest().getParameter("webserviceParamNameSpace"); 
		String webserviceParamName = getRequest().getParameter("webserviceParamName");
		String webserviceReturnParamName= getRequest().getParameter("webserviceReturnParamName");
		String namespace= getRequest().getParameter("namespace");
		
		//@1判断协议类型，再传入对应的参数
		Map hashMapType = new HashMap();
		hashMapType.put("commProCd", commProtocal.getCommProCd());
    	tmpList = getServiceManagerServ().queryTechImplAttrSpec(hashMapType);
    	Map hashMap = new HashMap();
    	
    	if (tmpList.get(0).get("COMM_PRO_CD").toString().equals("5")) {//ftp
    		String ftpUsername= getRequest().getParameter("ftpUsername");
    		 ftpPassword= getRequest().getParameter("ftpPassword");
    		 ftpServerIp= getRequest().getParameter("ftpServerIp");
    		 ftpPort= getRequest().getParameter("ftpPort");
    		 
    		//@2往HashMap中添加新增的属性,ftp用户名等
    		hashMap.put("ftpUsername", ftpUsername);
    		hashMap.put("ftpPassword", ftpPassword);
    		hashMap.put("ftpServerIp", ftpServerIp);
    		hashMap.put("ftpPort", ftpPort);
		}
    	else if (tmpList.get(0).get("COMM_PRO_CD").toString().equals("4")) {//sftp
    		 sftpUsername= getRequest().getParameter("sftpUsername");
    		 sftpPassword= getRequest().getParameter("sftpPassword");
    		 sftpServerIp= getRequest().getParameter("sftpServerIp");
    		 sftpPort= getRequest().getParameter("sftpPort");
    		
    		hashMap.put("sftpUsername", sftpUsername);
    		hashMap.put("sftpPassword", sftpPassword);
    		hashMap.put("sftpServerIp", sftpServerIp);
    		hashMap.put("sftpPort", sftpPort);
    	}
    		hashMap.put("address", callUrl);
    		hashMap.put("timeout", _overtime);
    		hashMap.put("method", _webserviceMethodName);
    		hashMap.put("inparamnamespace", webserviceParamNameSpace);
    		hashMap.put("inparamname", webserviceParamName);
    		hashMap.put("returnparam", webserviceReturnParamName);
    		hashMap.put("namespace", namespace);
    			
		techImpl.setTechImpConPoId(1);
		getTechImplService().insertTechImplById(org,component,commProtocal,techImpl,hashMap);
		return SUCCESS;
	}
	
	
	

	//上传操作
	public String fileUpload() throws IOException{
			if (AUTH_FILE_PATH!=null) {
		      //上传到ftp服务器上
				 try { 
				        FileInputStream in=new FileInputStream(AUTH_FILE_PATH); 
				        boolean flag = uploadFile(CustomPropertyConfigurer.getProperty("ftp.url"), 21, "test2014", "123123", "/upload/", System.currentTimeMillis()+AUTH_FILE_PATHFileName, in); 
				        in.close();
				    } catch (FileNotFoundException e) { 
				        //e.printStackTrace();
						log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
				    } 
			}		
	        return SUCCESS;
		}
		   
	//锟睫改硷拷锟斤拷实锟斤拷锟斤拷锟斤拷(锟斤拷示)
	public String updateTechImpl(){		
		try {
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
		       
			commProtocalList = getServiceManagerServ().queryCommProtocalListList();
			for (Map hashMap : commProtocalList) {
				Map mapTest = new HashMap(); 
				mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
				mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
				commProtocalResultList.add(mapTest);
			}
			 callUrl =	new String(getRequest().getParameter("callUrl").getBytes("iso8859-1"),"UTF-8");
			 overtime =	new String(getRequest().getParameter("overtime").getBytes("iso8859-1"),"UTF-8");
			 webserviceMethodName =	new String(getRequest().getParameter("webserviceMethodName").getBytes("iso8859-1"),"UTF-8");
			 webserviceParamNameSpace =	new String(getRequest().getParameter("webserviceParamNameSpace").getBytes("iso8859-1"),"UTF-8");
			 webserviceParamName =	new String(getRequest().getParameter("webserviceParamNameSpace").getBytes("iso8859-1"),"UTF-8");
			 webserviceReturnParamName =	new String(getRequest().getParameter("webserviceReturnParamName").getBytes("iso8859-1"),"UTF-8");
			 namespace =	new String(getRequest().getParameter("namespace").getBytes("iso8859-1"),"UTF-8");
			 techImplName =	new String(getRequest().getParameter("techImplName").getBytes("iso8859-1"),"UTF-8");
			 ComponentName = new String(getRequest().getParameter("ComponentName").getBytes("iso8859-1"),"UTF-8");
			 orgName =  new String(getRequest().getParameter("orgName").getBytes("iso8859-1"),"UTF-8");
			 Map hashMap = new HashMap();
			 hashMap.put("techImplId", techImpl.getTechImplId());
		     hashMap.put("commProCd", commProtocal.getCommProCd());
		     tmpList = getTechImplService().queryTechImplAttrSpec(hashMap);
		} catch (UnsupportedEncodingException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
	
	}
	
	public String addTechImplConfig(){
		List<Map> techImplAttList = getTechImplService().queryTechImplAttrSpecAll();
		Map hashMap = new HashMap();
		for (Map map : techImplAttList) {
			if (getRequest().getParameter(String.valueOf(map.get("ATTR_SPEC_CODE"))) != null) {
				hashMap.put(map.get("ATTR_SPEC_CODE"), getRequest().getParameter(String.valueOf(map.get("ATTR_SPEC_CODE"))));
			}
		}
		techImpl.setTechImpConPoId(1);
		techImpl.setUsealbeState("A");
		getTechImplService().insertTechImplById(org,component,commProtocal,techImpl,hashMap);
		return SUCCESS;
	}
	
	public String updateTechImplInfo(){		
		List<Map> techImplLists = getTechImplService().queryTechImplUpdate(techImpl);
		if (techImplLists != null && techImplLists.size() > 0 ) {
			techImplMap = techImplLists.get(0);
		}
		commProtocalList = getServiceManagerServ().queryCommProtocalListList();
		for (Map hashMap : commProtocalList) {
			Map mapTest = new HashMap(); 
			mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
			mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
			commProtocalResultList.add(mapTest);
		}
		 Map hashMap = new HashMap();
		 hashMap.put("techImplId", techImpl.getTechImplId());
		 hashMap.put("commProCd", commProtocal.getCommProCd());
		 tmpList= getTechImplService().queryTechImplAttrSpec(hashMap);
		return SUCCESS;
	}
	
	   public String updateTechImplConfig(){
		   
		   List<Map> techImplAttList = getTechImplService().queryTechImplAttrSpecAll();
			Map hashMap = new HashMap();
			for (Map map : techImplAttList) {
				if (getRequest().getParameter(String.valueOf(map.get("ATTR_SPEC_CODE"))) != null) {
					hashMap.put(map.get("ATTR_SPEC_CODE"), getRequest().getParameter(String.valueOf(map.get("ATTR_SPEC_CODE"))));
				}
			}
		   if (techImpl.getTechImplId() != null) {
			   getTechImplService().updateTechImplById(org,component,commProtocal,techImpl,hashMap);
		   }
		   
		   return SUCCESS;
	   }
	
	
	/**
	 * 锟斤拷锟斤拷实锟街革拷锟斤拷页锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷频锟斤拷锟斤拷锟�
	 * @return
	 */
   public void addServiceSupRegTechCtlUpdate(){
	 //锟斤拷锟斤拷实锟斤拷锟斤拷锟斤拷锟斤拷锟斤拷
	      
       Map hashMap = new HashMap();
       String chooseTechImplId  =   getRequest().getParameter("chooseTechImplId");
       hashMap.put("NAME", ctlCounterms2Tech.getCcCd());
       hashMap.put("CUTMS_VALUE", ctlCounterms2Tech.getCutmsValue());
       hashMap.put("CYCLE_TYPE", ctlCounterms2Tech.getCycleType());
       hashMap.put("CYCLE_VALUE", ctlCounterms2Tech.getCycleValue());
       hashMap.put("EFFECT_STATE", new Date());
       hashMap.put("CONFI_TIME", new Date());
       PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
			 if(StringUtils.isNotEmpty(getRequest().getParameter("chooseTechImplId"))){
				 ctlCounterms2Tech.setTechImplId(Integer.parseInt(chooseTechImplId));
				 getServiceManagerServ().insertCtlCounterms2Tech(ctlCounterms2Tech);
			 }			
		     getResponse().setContentType("text/html;charset=UTF-8");
		     out = getResponse().getWriter();
		     String xx="[{\"msg\":\"ok\",\"data\":\""+chooseTechImplId+"\"}]";
			 out.print(xx);
		}  catch (Exception e) {
			if (out != null) {
				out.print("failure");
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
    * 锟斤拷锟芥技锟斤拷实锟街碉拷锟斤拷锟�
    */
   public String updateTechImplData(){
	   //新添加保存代码  mawl
       Map hashMapType = new HashMap();
	   hashMapType.put("commProCd", commProtocal.getCommProCd());
	   tmpList = getServiceManagerServ().queryTechImplAttrSpec(hashMapType);
	   Map<String,String> mapKey = new HashMap<String,String>();
	   for(int i=0;i<tmpList.size();i++){
		   mapKey.put(tmpList.get(i).get("ATTR_SPEC_CODE").toString(), tmpList.get(i).get("ATTR_SPEC_ID").toString());
	   }
	   Map<String,String> mapAttr = new HashMap<String,String>();
	   for(int i=0;i<attrKey.length;i++){
		   mapAttr.put(mapKey.get(attrKey[i])+"_"+i, attrValue[i]);
	   }

	   if (techImpl.getTechImplId() != null) {
		   getTechImplService().updateTechImpl(commProtocal,techImpl,mapAttr);
	   }
	   
	   return SUCCESS;
   }
   
   /**
    * 删锟斤拷锟斤拷实锟街ｏ拷状态锟斤拷为锟斤拷锟斤拷锟矫ｏ拷
    */
   public void deleteTechImpl(){
   	 PrintWriter out =null;
		try {
			getRequest().setCharacterEncoding("UTF-8");
	    	String deleteIDs = getRequest().getParameter("deleteIDs");
	    	techImpl.setTechImplId(Integer.parseInt(deleteIDs));
	    	techImpl.setUsealbeState("R");
	    	techImpl.setLaestTime(new Date());			
			getTechImplService().updateTechImpl(techImpl);
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
		    String xx="[{\"msg\":\"ok\"}]";
			out.print(xx);
		}  catch (Exception e) {
			if (out != null) {
				out.print("failure");
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
   }
   
   public String gotoTechRoute(){
	   return SUCCESS;
   }
   
   public String editTechRoute(){
	   Map map = new HashMap();
	   map.put("techImplId", techImplId);
	   techNodeList = getTechImplService().queryTechNodeByTechImplId(map);
	   JSONArray atr = pagination.convertJson(techNodeList);
	   Writer wr = null;
	   try {
		   wr = getResponse().getWriter();
			getResponse().setContentType("text/plain;charset=utf-8");
			wr.write(atr.toString());
			wr.close();
		} catch (Exception e) {
			log.error("editTechRoute error：", e);
			
		}finally{
			try{
				if(wr!=null){
					wr.close();
				}
				
			}catch(Exception e){
				
			}
		}
	   
		
	   return null;
   }
   public String addTechImplRoute(){
	   
	   Writer wr = null;
	   	try {
	   			getTechImplService().addRouteNode(techImplId,routeObjs);
			   	wr = getResponse().getWriter();
				getResponse().setContentType("text/plain;charset=utf-8");
				wr.write("200");
				wr.close();
			} catch (Exception e) {
				log.error("editTechRoute error：", e);
				try{
					wr = getResponse().getWriter();
					wr.write("500");
					wr.close();
				}catch(Exception ex){
					
				}
			}finally{
				try{
					if(wr!=null){
						wr.close();
					}
					
				}catch(Exception e){
					
				}
		}
		
	   return null;
   }
   
   /**
    * 获取对应的协议类型ftp,http-get等
    */
    public String getTechAttrSpec(){
    	try {
    		if(null !=  org.getName()){
    			org.setName(new String(org.getName().getBytes("ISO8859-1"),"UTF-8"));
    		}
    		if(null != component.getName()){
    			component.setName(new String(component.getName().getBytes("ISO8859-1"),"UTF-8"));
    		}
    		if(null != techImpl.getTechImplName()){
    			techImpl.setTechImplName(new String(techImpl.getTechImplName().getBytes("ISO8859-1"),"UTF-8"));
    		}
		} catch (UnsupportedEncodingException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		commProtocalList = getServiceManagerServ().queryCommProtocalListList();
		for (Map hashMap : commProtocalList) {
			Map mapTest = new HashMap(); 
			mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
			mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
			commProtocalResultList.add(mapTest);
		}
		
		//@1判断协议类型，再传入对应的参数
		Map hashMapType = new HashMap();
		hashMapType.put("commProCd", commProtocal.getCommProCd());
		List<Map> list = getServiceManagerServ().queryTechImplAttrSpec(hashMapType);
    	 if("11".equals(commProtocal.getCommProCd())){//tmpList
			 for(Map map : list){
				 String attr_spec_name = (String)map.get("ATTR_SPEC_NAME");
				 String ATTR_SPEC_CODE = (String)map.get("ATTR_SPEC_CODE");
				 String ATTR_SPEC_VALUE = (String)map.get("ATTR_SPEC_VALUE");
				 String comm_pro_type = (String)map.get("COMM_PRO_TYPE");

				 Map mapList = new HashMap();
				 mapList.put("ATTR_SPEC_NAME", attr_spec_name);
				 mapList.put("ATTR_SPEC_CODE", ATTR_SPEC_CODE);
				 mapList.put("ATTR_SPEC_VALUE", ATTR_SPEC_VALUE);
				 tmpList.add(mapList);
			 }
		 }else{
			 tmpList = list;
		 }
        return SUCCESS;
    }
    
   
    
    public  String getUpdateTechAttrSpec(){
    	try {
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
		       
			commProtocalList = getServiceManagerServ().queryCommProtocalListList();
			for (Map hashMap : commProtocalList) {
				Map mapTest = new HashMap(); 
				mapTest.put("commProtocalName", hashMap.get("COMM_PRO_NAME"));
				mapTest.put("commProtocalId", hashMap.get("COMM_PRO_CD"));
				commProtocalResultList.add(mapTest);
			}
			 techImplName =	new String(getRequest().getParameter("techImplName").getBytes("iso8859-1"),"UTF-8");
			 ComponentName = new String(getRequest().getParameter("ComponentName").getBytes("iso8859-1"),"UTF-8");
			 orgName =  new String(getRequest().getParameter("orgName").getBytes("iso8859-1"),"UTF-8");
			 Map hashMap = new HashMap();
			 hashMap.put("techImplId", techImpl.getTechImplId());
		     hashMap.put("commProCd", commProtocal.getCommProCd());
		     List<Map> list = getTechImplService().queryTechImplAttrSpec(hashMap);
		     if("11".equals(commProtocal.getCommProCd())){//tmpList
				 for(Map map : list){
					 String attr_spec_name = (String)map.get("ATTR_SPEC_NAME");
					 String ATTR_SPEC_CODE = (String)map.get("ATTR_SPEC_CODE");
					 String ATTR_SPEC_VALUE = (String)map.get("ATTR_SPEC_VALUE");
					 String comm_pro_type = (String)map.get("COMM_PRO_TYPE");

					 Map mapList = new HashMap();
					 mapList.put("ATTR_SPEC_NAME", attr_spec_name);
					 mapList.put("ATTR_SPEC_CODE", ATTR_SPEC_CODE);
					 mapList.put("ATTR_SPEC_VALUE", ATTR_SPEC_VALUE);
					 tmpList.add(mapList);
				 }
			 }else{
				 tmpList = list;
			 }
		} catch (UnsupportedEncodingException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return SUCCESS;
    }
	public ITechImplService getTechImplService() {
		if (techImplService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			techImplService = (ITechImplService)ctx.getBean("eaap-op2-conf-techimpl-TechImplService");
		}
		return techImplService;
	}
   
	public IServiceManagerServ getServiceManagerServ() {
		if(iServiceManagerServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				iServiceManagerServ = (IServiceManagerServ)ctx.getBean("eaap-op2-conf-service-manager-service") ;
	     }
		return iServiceManagerServ;
	}
	public void setTechImplService(ITechImplService techImplService) {
		this.techImplService = techImplService;
	}

	public List<Component> getSelectComponentList() {
		return selectComponentList;
	}

	public void setSelectComponentList(List<Component> selectComponentList) {
		this.selectComponentList = selectComponentList;
	}

	public List<Service> getServiceList() {
		return serviceList;
	}

	public void setServiceList(List<Service> serviceList) {
		this.serviceList = serviceList;
	}
	public Component getComponent() {
		return component;
	}

	public void setComponent(Component component) {
		this.component = component;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public List<Map> getTechImplList() {
		return techImplList;
	}

	public void setTechImplList(List<Map> techImplList) {
		this.techImplList = techImplList;
	}

	public TechImpl getTechImpl() {
		return techImpl;
	}

	public void setTechImpl(TechImpl techImpl) {
		this.techImpl = techImpl;
	}

	public AttrSpec getAttrSpec() {
		return attrSpec;
	}

	public void setAttrSpec(AttrSpec attrSpec) {
		this.attrSpec = attrSpec;
	}

	public List<AttrSpec> getAttrSpecList() {
		return attrSpecList;
	}

	public void setAttrSpecList(List<AttrSpec> attrSpecList) {
		this.attrSpecList = attrSpecList;
	}
	
	public TechImpAtt getTechImpAtt() {
		return techImpAtt;
	}

	public void setTechImpAtt(TechImpAtt techImpAtt) {
		this.techImpAtt = techImpAtt;
	}

	public SerTechImpl getSerTechImpl() {
		return serTechImpl;
	}

	public void setSerTechImpl(SerTechImpl serTechImpl) {
		this.serTechImpl = serTechImpl;
	}

	public TechImpAttrSpec getTechImpAttrSpec() {
		return techImpAttrSpec;
	}

	public void setTechImpAttrSpec(TechImpAttrSpec techImpAttrSpec) {
		this.techImpAttrSpec = techImpAttrSpec;
	}
	public ControlCounterms getControlCounterms() {
		return controlCounterms;
	}

	public void setControlCounterms(ControlCounterms controlCounterms) {
		this.controlCounterms = controlCounterms;
	}
	public List<ControlCounterms> getCtlCountermsList() {
		return ctlCountermsList;
	}

	public void setCtlCountermsList(List<ControlCounterms> ctlCountermsList) {
		this.ctlCountermsList = ctlCountermsList;
	}

	public List<Map> getCommProtocalList() {
		return commProtocalList;
	}

	public void setCommProtocalList(List<Map> commProtocalList) {
		this.commProtocalList = commProtocalList;
	}

	public List<Map<String, Object>> getCommProtocalResultList() {
		return commProtocalResultList;
	}

	public void setCommProtocalResultList(
			List<Map<String, Object>> commProtocalResultList) {
		this.commProtocalResultList = commProtocalResultList;
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

	public List<Map> getTmpList() {
		return tmpList;
	}

	public void setTmpList(List<Map> tmpList) {
		this.tmpList = tmpList;
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

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getComponentName() {
		return ComponentName;
	}

	public void setComponentName(String componentName) {
		ComponentName = componentName;
	}

	public Map getTechAttrSpecHashMap() {
		return techAttrSpecHashMap;
	}

	public void setTechAttrSpecHashMap(Map techAttrSpecHashMap) {
		this.techAttrSpecHashMap = techAttrSpecHashMap;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTimeout() {
		return timeout;
	}

	public void setTimeout(String timeout) {
		this.timeout = timeout;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getInparamnamespace() {
		return inparamnamespace;
	}

	public void setInparamnamespace(String inparamnamespace) {
		this.inparamnamespace = inparamnamespace;
	}

	public String getInparamname() {
		return inparamname;
	}

	public void setInparamname(String inparamname) {
		this.inparamname = inparamname;
	}

	public String getReturnparam() {
		return returnparam;
	}

	public void setReturnparam(String returnparam) {
		this.returnparam = returnparam;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public String getNamespace() {
		return namespace;
	}

	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}

	public Map getTechImplMap() {
		return techImplMap;
	}

	public void setTechImplMap(Map techImplMap) {
		this.techImplMap = techImplMap;
	}

	public String getFtpUsername() {
		return ftpUsername;
	}

	public void setFtpUsername(String ftpUsername) {
		this.ftpUsername = ftpUsername;
	}

	public String getFtpPassword() {
		return ftpPassword;
	}

	public void setFtpPassword(String ftpPassword) {
		this.ftpPassword = ftpPassword;
	}

	public String getFtpServerIp() {
		return ftpServerIp;
	}

	public void setFtpServerIp(String ftpServerIp) {
		this.ftpServerIp = ftpServerIp;
	}

	public String getFtpPort() {
		return ftpPort;
	}

	public void setFtpPort(String ftpPort) {
		this.ftpPort = ftpPort;
	}

	public String getSftpUsername() {
		return sftpUsername;
	}

	public void setSftpUsername(String sftpUsername) {
		this.sftpUsername = sftpUsername;
	}

	public String getSftpPassword() {
		return sftpPassword;
	}

	public void setSftpPassword(String sftpPassword) {
		this.sftpPassword = sftpPassword;
	}

	public String getSftpServerIp() {
		return sftpServerIp;
	}

	public void setSftpServerIp(String sftpServerIp) {
		this.sftpServerIp = sftpServerIp;
	}

	public String getSftpPort() {
		return sftpPort;
	}

	public void setSftpPort(String sftpPort) {
		this.sftpPort = sftpPort;
	}

	public String getFileFilePath() {
		return fileFilePath;
	}

	public void setFileFilePath(String fileFilePath) {
		this.fileFilePath = fileFilePath;
	}

	public File getAUTH_FILE_PATH() {
		return AUTH_FILE_PATH;
	}

	public void setAUTH_FILE_PATH(File aUTH_FILE_PATH) {
		AUTH_FILE_PATH = aUTH_FILE_PATH;
	}

	public String getAUTH_FILE_PATHFileName() {
		return AUTH_FILE_PATHFileName;
	}

	public void setAUTH_FILE_PATHFileName(String aUTH_FILE_PATHFileName) {
		AUTH_FILE_PATHFileName = aUTH_FILE_PATHFileName;
	}

	public String[] getAttrValue() {
		return attrValue;
	}

	public void setAttrValue(String[] attrValue) {
		this.attrValue = Arrays.copyOf(attrValue, attrValue.length);
	}
	
	public String[] getAttrKey() {
		return attrKey;
	}

	public void setAttrKey(String[] attrKey) {
		this.attrKey = Arrays.copyOf(attrKey, attrKey.length);
	}

	public List<Map> getTechNodeList() {
		return techNodeList;
	}

	public void setTechNodeList(List<Map> techNodeList) {
		this.techNodeList = techNodeList;
	}

	public String getRouteObjs() {
		return routeObjs;
	}

	public void setRouteObjs(String routeObjs) {
		this.routeObjs = routeObjs;
	}
}
