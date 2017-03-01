package com.ailk.eaap.op2.conf.manager.action;
 
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.security.SecurityUtil;
import com.ailk.eaap.o2p.common.util.date.UTCTimeUtil;
import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Area;
import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.Auth;
import com.ailk.eaap.op2.bo.AuthBase;
import com.ailk.eaap.op2.bo.AuthObj;
import com.ailk.eaap.op2.bo.AuthObjAttr;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.CtlCounterms2Comp;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.MessageFlow;
import com.ailk.eaap.op2.bo.OfferProdRel;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.OrgRole;
import com.ailk.eaap.op2.bo.ProdOffer;
import com.ailk.eaap.op2.bo.ProdOfferChannelType;
import com.ailk.eaap.op2.bo.Product;
import com.ailk.eaap.op2.bo.ProductAttr;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.IOrgRegAuditingServ;
import com.ailk.eaap.op2.conf.authenticate.service.IAuthenticateServ;
import com.ailk.eaap.op2.conf.flowcontrol.service.IFlowControlServ;
import com.ailk.eaap.op2.conf.manager.service.IConfManagerServ;
import com.ailk.eaap.op2.conf.proofmanage.service.IProofEffectService;
import com.ailk.eaap.op2.conf.wsdlImport.service.IWsdlService;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.linkage.rainbow.util.StringUtil;

public class ConfManagerAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	private Logger log = Logger.getLog(this.getClass());
	private String activity_Id ;
	private String content_Id ;
	private String process_Id ;
	private String process_Model_Id ;
    private IConfManagerServ confManagerServ ;
    private IAuthenticateServ authenticateServ ;
    private IFlowControlServ flowcontrolServ ;
    private IOrgRegAuditingServ orgRegAuditingServ ;
    private Map orgInfoMap = new HashMap() ;
    private Map appInfoMap = new HashMap() ;
    private String checkState ;
    private String checkDesc ;
    private List<Map> selectRoleList = new ArrayList<Map>();
    private List<Map> messgeFlowList = new ArrayList<Map>();
    private List<Map> logLevelList = new ArrayList<Map>();

	private List<Map> selectOrgTypeList = new ArrayList<Map>();
    private List<Map> appApiInfoList = new ArrayList<Map>() ;
    private List<Map> selectCardTypeList = new ArrayList<Map>();
    private List<Map> selectMainTypeStateList = new ArrayList<Map>();
    private List<Map> selectSerInvokeInsStateList = new ArrayList<Map>();
	private Org org = new Org() ;
	private OrgRole orgRole = new OrgRole() ;
	private App app = new App() ;
    private Pagination page=new Pagination();
    private Pagination pagination = new Pagination();
    private MessageFlow messageFlow = new MessageFlow() ;
    private List<Map> orgInfoList = new ArrayList<Map>() ;
    private List<Map> orgStateList = new ArrayList<Map>() ;
    private List<Map> proofList = new ArrayList<Map>() ;
    private List<Map> cc2cList = new ArrayList<Map>() ;
    private Map orgStateMap = new HashMap() ;
    private String tmpType ;
    private List<Map> cityList = new ArrayList<Map>() ;
	private List<Map> provinceList = new ArrayList<Map>() ;
	private ProdOffer  prodOffer = new ProdOffer();
	private OfferProdRel offerProdRel = new OfferProdRel();
	private List<Map> provServiceList = new ArrayList<Map>() ;
	private ProdOfferChannelType prodOfferChannelType = new ProdOfferChannelType() ;
	private Map prodChannelMap = new HashMap() ;
	private List<ProdOfferChannelType> prodOfferChannelTypeList = new ArrayList<ProdOfferChannelType>() ;
    private Product   product = new Product() ;
	private ProductAttr productAttr = new ProductAttr() ;
	private List<Map> productAttrList = new ArrayList<Map>() ;
	private List<Product> chooseProdOardList = new ArrayList<Product>() ;
	private List<Map> pricingList = new ArrayList<Map>() ;
	private List<Map> mainDataTypeList = new ArrayList<Map>() ;
	private List<Map> authList = new ArrayList<Map>() ;
	private MainDataType mainDataType = new MainDataType();
	 
	private List<AttrSpec> atrrSpecList = new ArrayList<AttrSpec>() ;
	private MainData mainData = new MainData();
	private CtlCounterms2Comp ctlCounterms2Comp = new CtlCounterms2Comp();
	private List<MainData> mainDataList =new ArrayList<MainData>();
	private String editOrAdd ;
	private List<Map<String,String>> componentList ;
	private String data ;
	private SerInvokeIns serInvokeIns = new SerInvokeIns();
	private Map serInvokeInsMap = new HashMap() ;
	private Map proofTypeMap = new HashMap() ;
	private Map atrrSpecMap = new HashMap() ;
	
	private List<Map> prodOfferStateList = new ArrayList<Map>() ;
    private Map prodOfferStateMap = new HashMap() ;
	    
	private Service service = new Service();
	private Component component = new Component();
	private String [] orgRoles ;
	private String [] orgTypeCodes ;
	private String chooseOrgCode ;
	private String chooseOrgName ;
	private int rows;
	private int pageNum;
	private int total;
	private String [] ptSpecs ;
	private String [] ptCds ;
	private String [] onOffs ;
	private String [] attrValues ;
    private ProofEffect  proofEffect = new ProofEffect();
	private ProofValues  proofValues = new ProofValues();
	
	private Auth  auth = new Auth();
	private AuthObj  authObj = new AuthObj();
	private AuthBase  authBase = new AuthBase();
	private AuthObjAttr authObjAttr = new AuthObjAttr();
	
	private List<Map> ccTypeList = new ArrayList<Map>() ;
	private List<Map> cycleTyleList = new ArrayList<Map>() ;
	private List<Map> cc2cStatelist = new ArrayList<Map>() ;
	
	private List<Map> authObjOpList = new ArrayList<Map>() ;
	private List<Map> authObjTypeList = new ArrayList<Map>() ;
	private List<Map> reqOrRspList = new ArrayList<Map>() ; 
	private List<Map> attrValuesList = new ArrayList<Map>() ; 
	private Map attrValueMapForProof = new HashMap() ;
	private String msgFlowUrl;
	private String reqFrom ;
	private String onOffs1;
	
	private String reqRsp;
	
	private List<Area> cityAreaList = new ArrayList<Area>();
	
	private String pageState;
	private String serInvokeInsName;
	private String serInvokeInsId;
	private String [] arrayState;
	private String[] page_proofe_id;//页面接收有效认证ID
	private IProofEffectService proofeffectService;// spring注入对象业务
	private String pageShowMsg;
	private String msFlowUrl;
	private String isChoosePage;
	private String rowIndex;
	private String reqRspFlag;
	private String showflag;
	private String mdt_cd;

	public String getReqRsp() {
		return reqRsp;
	}

	public void setReqRsp(String reqRsp) {
		this.reqRsp = reqRsp;
	}

	public int getRows() {
		return rows;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
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

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String[] getOrgTypeCodes() {
		return orgTypeCodes;
	}

	public void setOrgTypeCodes(String[] orgTypeCodes) {
		this.orgTypeCodes = Arrays.copyOf(orgTypeCodes, orgTypeCodes.length);
	}

	public List<Map<String, String>> getComponentList() {
		return componentList;
	}

	public void setComponentList(List<Map<String, String>> componentList) {
		this.componentList = componentList;
	}

	public List<Map> getCityList() {
		return cityList;
	}

	public void setCityList(List<Map> cityList) {
		this.cityList = cityList;
	}

	public List<Map> getSelectMainTypeStateList() {
		return selectMainTypeStateList;
	}

	public void setSelectMainTypeStateList(List<Map> selectMainTypeStateList) {
		this.selectMainTypeStateList = selectMainTypeStateList;
	}

	public String getChooseOrgCode() {
		return chooseOrgCode;
	}

	public void setChooseOrgCode(String chooseOrgCode) {
		this.chooseOrgCode = chooseOrgCode;
	}

	public String getChooseOrgName() {
		return chooseOrgName;
	}

	public void setChooseOrgName(String chooseOrgName) {
		this.chooseOrgName = chooseOrgName;
	}

	public List<Map> getSelectOrgTypeList() {
		return selectOrgTypeList;
	}

	public void setSelectOrgTypeList(List<Map> selectOrgTypeList) {
		this.selectOrgTypeList = selectOrgTypeList;
	}

	public List<Map> getSelectRoleList() {
		return selectRoleList;
	}

	public void setSelectRoleList(List<Map> selectRoleList) {
		this.selectRoleList = selectRoleList;
	}

	public List<Map> getProvinceList() {
		return provinceList;
	}

	public void setProvinceList(List<Map> provinceList) {
		this.provinceList = provinceList;
	}

	public Map getOrgStateMap() {
		return orgStateMap;
	}

	public void setOrgStateMap(Map orgStateMap) {
		this.orgStateMap = orgStateMap;
	}

	public List<Map> getSelectCardTypeList() {
		return selectCardTypeList;
	}

	public void setSelectCardTypeList(List<Map> selectCardTypeList) {
		this.selectCardTypeList = selectCardTypeList;
	}

	public List<Map> getProdOfferStateList() {
		return prodOfferStateList;
	}

	public void setProdOfferStateList(List<Map> prodOfferStateList) {
		this.prodOfferStateList = prodOfferStateList;
	}

	public Map getProdOfferStateMap() {
		return prodOfferStateMap;
	}

	public void setProdOfferStateMap(Map prodOfferStateMap) {
		this.prodOfferStateMap = prodOfferStateMap;
	}

	public ConfManagerAction() {
		
	}
	
	public String showPardMixList(){
		 prodOfferStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_PRODGOODSSTATE) ;
		 Iterator iter = prodOfferStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 prodOfferStateList.add(mapTmp) ;
		 }
		
		
		  return SUCCESS ;
	}
	
    public Map getPardMixList(Map para){
		rows = pagination.getRows();
		pageNum = pagination.getPage();
		int startRow;
		   
		 startRow = (pageNum - 1) * rows + 1;
		 Map returnMap = new HashMap();
		 Map map = new HashMap() ;
		 
		 map.put("offerProviderId", "900000004");
		 map.put("prodOfferId", "".equals(getRequest().getParameter("prodOffer.prodOfferId"))?null:getRequest().getParameter("prodOffer.prodOfferId")) ;
		 map.put("statusCd", "".equals(getRequest().getParameter("prodOffer.statusCd"))?null:getRequest().getParameter("prodOffer.statusCd")) ;
		 map.put("cooperationType", "12") ;
		 map.put("prodOfferName", "".equals(getRequest().getParameter("prodOffer.prodOfferName"))?null:getRequest().getParameter("prodOffer.prodOfferName")) ;
		 if(StringUtil.valueOf(getRequest().getParameter("prodOffer.prodOfferName")).equals(getText("eaap.op2.conf.manager.auth.canlike"))){
			 map.put("prodOfferName",null);
		 }
		 
		 map.put("queryType", "ALLNUM") ;
	     total = Integer.valueOf(String.valueOf(getConfManagerServ().queryProdOfferList(map).get(0).get("ALLNUM"))) ;
	 
		 
	     map.put("queryType", "") ;
	        
	         map.put("pro", startRow);
	         map.put("end", startRow+rows-1);
	       
	         List<Map> tmpOrgList=getConfManagerServ().queryProdOfferList(map) ;
	        returnMap.put("startRow", startRow);
			returnMap.put("rows", rows); 	
			returnMap.put("total", total);
			returnMap.put("dataList", page.convertJson(tmpOrgList));
		 return returnMap ;
	}


	public String queryOrgInfo(){
		
		
		Map  map1 = new HashMap();
		map1.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.useriscomp"));
		map1.put("orgTypeCode", "1");
		
		Map  map2 = new HashMap();
		map2.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisperson"));
		map2.put("orgTypeCode", "2");
		
		Map  map3 = new HashMap();
		map3.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisother"));
		map3.put("orgTypeCode", "0");
		
		selectOrgTypeList.add(map1) ;
		selectOrgTypeList.add(map2) ;
		selectOrgTypeList.add(map3) ;
		
		Map  cardMap1 = new HashMap();
		cardMap1.put("cardName", getText("eaap.op2.conf.manager.auth.cardtypeisider"));
		cardMap1.put("cardCode", "1");
		
		Map  cardMap2 = new HashMap();
		cardMap2.put("cardName", getText("eaap.op2.conf.manager.auth.cardtypeiscom"));
		cardMap2.put("cardCode", "2");
		
		selectCardTypeList.add(cardMap1);
		selectCardTypeList.add(cardMap2);
		
		orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		org.setOrgId(Integer.valueOf(content_Id)) ;
		
		
		Map orgTypeNameMap = new HashMap();
		orgTypeNameMap.put("0", getText("eaap.op2.conf.orgregauditing.userisother"));
		orgTypeNameMap.put("1", getText("eaap.op2.conf.orgregauditing.useriscomp"));
		orgTypeNameMap.put("2", getText("eaap.op2.conf.orgregauditing.userisperson"));
		
		Map certTypeNameMap = new HashMap();
		certTypeNameMap.put("1", getText("eaap.op2.conf.manager.auth.cardtypeisider"));
		certTypeNameMap.put("2", getText("eaap.op2.conf.manager.auth.cardtypeiscom"));
		
		for (Map temp:orgInfoList) {
			
			if (temp.get("ORG_TYPE_CODE") != null) {
				temp.put("ORGTYPENAME", orgTypeNameMap.get(temp.get("ORG_TYPE_CODE")));
			}
			if (temp.get("CERT_TYPE_CODE") != null) {
				temp.put("CERTTYPENAME", certTypeNameMap.get(temp.get("CERT_TYPE_CODE")));
			}
		}
		
		StringBuffer buf = new StringBuffer();
		List<Map> tmpOrgList=getConfManagerServ().queryOrgInfo(org) ;
		if(tmpOrgList !=null){
			for (int i = 0; i < tmpOrgList.size(); ++i) {
				Map orgMap = tmpOrgList.get(i);
				buf.append(orgMap.get("ROLE_CODE"));
			}
		}
		String tmpRoleCode = buf.toString();
		
		if(null != tmpOrgList && tmpOrgList.size()>0){
			orgInfoMap = tmpOrgList.get(0) ;
		}
	    orgInfoMap.put("ROLE_CODE", tmpRoleCode) ;

	    //解密：
	    if(orgInfoMap.get("EMAIL")!=null && !orgInfoMap.get("EMAIL").equals("")){
			String emailPlaintext = this.getDecryMsg(orgInfoMap.get("EMAIL").toString());
			orgInfoMap.put("EMAIL",emailPlaintext);			
		}
		if(orgInfoMap.get("CERT_NUMBER")!=null && !orgInfoMap.get("CERT_NUMBER").equals("")){
			String certNumberPlaintext = this.getDecryMsg(orgInfoMap.get("CERT_NUMBER").toString());
			orgInfoMap.put("CERT_NUMBER",certNumberPlaintext);			
		}
		if(orgInfoMap.get("TELEPHONE")!=null && !orgInfoMap.get("TELEPHONE").equals("")){
			String telephonePlaintext = this.getDecryMsg(orgInfoMap.get("TELEPHONE").toString());
			orgInfoMap.put("TELEPHONE",telephonePlaintext);			
		}

	    if("info".equals(tmpType)){
	    	return "successtoinfo" ;
	    }else if("edit".equals(tmpType)){
	    	cityList = getConfManagerServ().queryCityForReg(org) ;
			provinceList = getConfManagerServ().queryProvinceForReg(org) ;
			getRequest().getSession().setAttribute("tempOrgId", content_Id);
			return "successtoedit" ;
	    }else{
	    	return SUCCESS ;
	    }
		
	}
	
	private String getDecryMsg(String msg){
		String decryMsg = SecurityUtil.getInstance().decryMsg(msg);
		if(decryMsg == null){
			decryMsg = msg;
		}
		return decryMsg;
	}
	
	private String getEncryMsg(String msg){
		String encryMsg = SecurityUtil.getInstance().encryMsg(msg);
		if(encryMsg == null){
			encryMsg = msg;
		}
		return encryMsg;
	}
	
	 public String showOrgList(){
		 orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		 Iterator iter = orgStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 orgStateList.add(mapTmp) ;
		 }
		 
		  Map  map1 = new HashMap();
			map1.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.useriscomp"));
			map1.put("orgTypeCode", "1");
			
			Map  map2 = new HashMap();
			map2.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisperson"));
			map2.put("orgTypeCode", "2");
			
			Map  map3 = new HashMap();
			map3.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisother"));
			map3.put("orgTypeCode", "0");
			
			selectOrgTypeList.add(map1) ;
			selectOrgTypeList.add(map2) ;
			selectOrgTypeList.add(map3) ;
			
			
		 
			
			Map  map11 = new HashMap();
			map11.put("roleName", getText("eaap.op2.conf.orgregauditing.devrole"));
			map11.put("roleCode", "1");
			
			Map  map22 = new HashMap();
			map22.put("roleName", getText("eaap.op2.conf.orgregauditing.prorole"));
			map22.put("roleCode", "2");
			
			Map  map33 = new HashMap();
			map33.put("roleName", getText("eaap.op2.conf.orgregauditing.hezuohuoban"));
			map33.put("roleCode", "3");
			
		 
			selectRoleList.add(map11);
			selectRoleList.add(map22);
			selectRoleList.add(map33);
			
			
		 
		 return SUCCESS ;
	 }

	
 
	public Map getOrgList(Map para){
		Map returnMap = new HashMap();
		try{
			rows = pagination.getRows();
			pageNum = pagination.getPage();
			int startRow;
			 
			startRow = (pageNum - 1) * rows + 1;
	
			 String tmpOrgTypeCode ="" ;
			 String tmpState ="" ;
			 Map map = new HashMap() ;
			 
			 orgTypeCodes =getRequest().getParameterValues("orgTypeCodes");
			 if(orgTypeCodes!=null && orgTypeCodes.length>=1){
				 StringBuffer sb = new StringBuffer();
				 for(int i=0; orgTypeCodes.length>i; i++){
					 String orgTypeCode = orgTypeCodes[i];
					 sb.append(orgTypeCode).append(",");
				 }
				 tmpOrgTypeCode = sb.toString();
				 
				 tmpOrgTypeCode = tmpOrgTypeCode.substring(0,tmpOrgTypeCode.length()-1);
			 }
			 
			 arrayState =getRequest().getParameterValues("arrayState");
			 if(arrayState!=null && arrayState.length>=1){
				 String[] tempArrayState ;
				 tempArrayState = arrayState[0].split(",");
				 for(String state:tempArrayState){
					 tmpState+="'" + state+ "'" + ",";
				 }
				 tmpState = tmpState.substring(0,tmpState.length()-1);
			 }
		 
			 map.put("orgUsername", "".equals(getRequest().getParameter("org.orgUsername"))?null:getRequest().getParameter("org.orgUsername")) ;
			 map.put("email", "".equals(getRequest().getParameter("org.email"))?null:getRequest().getParameter("org.email")) ;
			 
			 map.put("name", "".equals(getRequest().getParameter("org.name"))?null:getRequest().getParameter("org.name")) ;
			 if(StringUtil.valueOf(getRequest().getParameter("org.name")).equals(getText("eaap.op2.conf.manager.auth.canlike"))){
				 map.put("name",null);
			 }
			 map.put("telephone", "".equals(getRequest().getParameter("org.telephone"))?null:getRequest().getParameter("org.telephone")) ;
			 map.put("roleCode", "".equals(getRequest().getParameter("orgRole.roleCode"))?null:getRequest().getParameter("orgRole.roleCode")) ;
			 if(!"".equals(tmpState)){
				 map.put("state","("+tmpState+")") ;
			 }else{
				 String isInit = getRequest().getParameter("isInit"); 
				 if(StringUtil.isEmpty(isInit)){
					 map.put("state","('D')") ;
				 }
			 }
			 if(!"".equals(tmpOrgTypeCode)){
				 map.put("orgTypeCode", "("+tmpOrgTypeCode+")") ;
			 }
			 
			 map.put("certNumber", "".equals(getRequest().getParameter("org.certNumber"))?null:getRequest().getParameter("org.certNumber")) ;
			 map.put("orgCode", "".equals(getRequest().getParameter("org.orgCode"))?null:getRequest().getParameter("org.orgCode")) ;
			 map.put("queryType", "ALLNUM") ;
			 List<Map> tmpOrgList1 =	 getConfManagerServ().queryOrgInfoList(map);
		     total = Integer.valueOf(String.valueOf(tmpOrgList1.get(0).get("ALLNUM"))) ;
		     map.put("queryType", "") ;
		     map.put("pro", startRow);
		     map.put("end", startRow+rows-1);
		         
		     map.put("pro_mysql", (pageNum - 1) * rows);
			 map.put("page_record", rows);
		         
			Map orgTypeNameMap = new HashMap();
			orgTypeNameMap.put("0", getText("eaap.op2.conf.orgregauditing.userisother"));
			orgTypeNameMap.put("1", getText("eaap.op2.conf.orgregauditing.useriscomp"));
			orgTypeNameMap.put("2", getText("eaap.op2.conf.orgregauditing.userisperson"));
			
			Map certTypeNameMap = new HashMap();
			certTypeNameMap.put("1", getText("eaap.op2.conf.manager.auth.cardtypeisider"));
			certTypeNameMap.put("2", getText("eaap.op2.conf.manager.auth.cardtypeiscom"));
			     
			List<Map> tmpOrgList=getConfManagerServ().queryOrgInfoList(map) ;
			Org orgbean = new Org();
		    List<Map> roleNumList = getConfManagerServ().queryRoleNum(orgbean) ;
		    
		    orgInfoList= new ArrayList<Map>() ;
			for(int i=0;i<tmpOrgList.size();i++){
				
				String tmpRoleName = "";
				String tmpRoleCode = "";
				int flag = 0;
				
				if(!"".equals(StringUtil.valueOf(map.get("roleCode")))){
					if("1".equals(StringUtil.valueOf(map.get("roleCode")))){
						tmpRoleName+=getText("eaap.op2.conf.orgregauditing.devrole")+",";
						tmpRoleCode+="1,";
					}else if("2".equals(StringUtil.valueOf(map.get("roleCode")))){
						tmpRoleName+=getText("eaap.op2.conf.orgregauditing.prorole")+",";
						tmpRoleCode+="2,";
					}else if("3".equals(StringUtil.valueOf(map.get("roleCode")))){
						tmpRoleName+=getText("eaap.op2.conf.orgregauditing.hezuohuoban")+",";
						tmpRoleCode+="3,";
					}
					
				}else{
					for(int j=0;j<roleNumList.size();j++){
						Object orgOrgId = tmpOrgList.get(i).get("ORG_ID");
						Object roleOrgId = roleNumList.get(j).get("ORG_ID");
						if(orgOrgId != null && roleOrgId != null){
							if(tmpOrgList.get(i).get("ORG_ID").toString().equals(roleNumList.get(j).get("ORG_ID").toString())){
								if("1".equals(roleNumList.get(j).get("ROLE_CODE").toString())){
									tmpRoleName+=getText("eaap.op2.conf.orgregauditing.devrole")+",";
									tmpRoleCode+="1,";
								}else if("2".equals(roleNumList.get(j).get("ROLE_CODE").toString())){
									tmpRoleName+=getText("eaap.op2.conf.orgregauditing.prorole")+",";
									tmpRoleCode+="2,";
								}else if("3".equals(roleNumList.get(j).get("ROLE_CODE").toString())){
									tmpRoleName+=getText("eaap.op2.conf.orgregauditing.hezuohuoban")+",";
									tmpRoleCode+="3,";
								}
								flag++ ;
								Object allNum = tmpOrgList.get(i).get("ALLNUM");
								if(allNum != null && "".equals(String.valueOf(allNum).trim())){
									if(flag==Integer.valueOf(allNum.toString())){
										break;
									}
								}
							}
						}
					}
				}
				
				if (tmpOrgList.get(i).get("ORG_TYPE_CODE") != null) {
					tmpOrgList.get(i).put("ORGTYPENAME", orgTypeNameMap.get(tmpOrgList.get(i).get("ORG_TYPE_CODE")));
				}
				if (tmpOrgList.get(i).get("CERT_TYPE_CODE") != null) {
					tmpOrgList.get(i).put("CERTTYPENAME", certTypeNameMap.get(tmpOrgList.get(i).get("CERT_TYPE_CODE")));
				}

			    //解密：
				if(tmpOrgList.get(i).get("EMAIL")!=null && !tmpOrgList.get(i).get("EMAIL").equals("")){
					try{
						String emailPlaintext = this.getDecryMsg(tmpOrgList.get(i).get("EMAIL").toString());
						tmpOrgList.get(i).put("EMAIL",emailPlaintext);			
					}catch(Exception e){
						log.error(LogModel.EVENT_APP_EXCPT, "\"org.email\" Decrypt Exception");
					}
				}
				if(tmpOrgList.get(i).get("CERT_NUMBER")!=null && !tmpOrgList.get(i).get("CERT_NUMBER").equals("")){
					try{
						String certNumberPlaintext = this.getDecryMsg(tmpOrgList.get(i).get("CERT_NUMBER").toString());
						tmpOrgList.get(i).put("CERT_NUMBER",certNumberPlaintext);					
					}catch(Exception e){
						log.error(LogModel.EVENT_APP_EXCPT, "\"org.cert_number\" Decrypt Exception");
					}
				}
				if(tmpOrgList.get(i).get("TELEPHONE")!=null && !tmpOrgList.get(i).get("TELEPHONE").equals("")){
					try{
						String telephonePlaintext = this.getDecryMsg(tmpOrgList.get(i).get("TELEPHONE").toString());
						tmpOrgList.get(i).put("TELEPHONE",telephonePlaintext);				
					}catch(Exception e){
						log.error(LogModel.EVENT_APP_EXCPT, "\"org.telephone\" Decrypt Exception");
					}	
				}
				
				Map tmpMap = tmpOrgList.get(i);
				tmpMap.put("roleName", "".equals(tmpRoleName)?"":tmpRoleName.substring(0,tmpRoleName.length()-1));
				tmpMap.put("roleCode", "".equals(tmpRoleCode)?"":tmpRoleCode.substring(0,tmpRoleCode.length()-1));				
				orgInfoList.add(tmpMap)	;
				if(!"".equals(StringUtil.valueOf(orgRole.getRoleCode()))){
					if(tmpRoleCode.contains(orgRole.getRoleCode())){
						orgInfoList.add(tmpMap)	;
					}
				 }else{
					orgInfoList.add(tmpMap)	;
				}
			 }
			returnMap.put("startRow", startRow);
			returnMap.put("rows", rows); 	
			returnMap.put("total", total);
			returnMap.put("dataList", page.convertJson(tmpOrgList));
		}catch(Exception e){
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"getOrgList exception",null));
		}
		return returnMap;
	}
	
	
	
	 
	
	public String chooseOrgInfo(){
		  orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		  Iterator iter = orgStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 orgStateList.add(mapTmp) ;
		 }
		    Map  map1 = new HashMap();
			map1.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.useriscomp"));
			map1.put("orgTypeCode", "1");
			
			Map  map2 = new HashMap();
			map2.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisperson"));
			map2.put("orgTypeCode", "2");
			
			Map  map3 = new HashMap();
			map3.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisother"));
			map3.put("orgTypeCode", "0");
			
			selectOrgTypeList.add(map1) ;
			selectOrgTypeList.add(map2) ;
			selectOrgTypeList.add(map3) ;
			
			
		 
			
			Map  map11 = new HashMap();
			map11.put("roleName", getText("eaap.op2.conf.orgregauditing.devrole"));
			map11.put("roleCode", "1");
			
			Map  map22 = new HashMap();
			map22.put("roleName", getText("eaap.op2.conf.orgregauditing.prorole"));
			map22.put("roleCode", "2");
			
			Map  map33 = new HashMap();
			map33.put("roleName", getText("eaap.op2.conf.orgregauditing.hezuohuoban"));
			map33.put("roleCode", "3");
			
		 
			selectRoleList.add(map11);
			selectRoleList.add(map22);
			selectRoleList.add(map33);
			
			
		 return SUCCESS ;
	}
	
	public String preAddOrgInfo(){
		
		Map  map1 = new HashMap();
		map1.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.useriscomp"));
		map1.put("orgTypeCode", "1");
		
		Map  map2 = new HashMap();
		map2.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisperson"));
		map2.put("orgTypeCode", "2");
		
		Map  map3 = new HashMap();
		map3.put("orgTypeName", getText("eaap.op2.conf.orgregauditing.userisother"));
		map3.put("orgTypeCode", "0");
		
		selectOrgTypeList.add(map1) ;
		selectOrgTypeList.add(map2) ;
		selectOrgTypeList.add(map3) ;
		
		Map  cardMap1 = new HashMap();
		cardMap1.put("cardName", getText("eaap.op2.conf.manager.auth.cardtypeisider"));
		cardMap1.put("cardCode", "1");
		
		Map  cardMap2 = new HashMap();
		cardMap2.put("cardName", getText("eaap.op2.conf.manager.auth.cardtypeiscom"));
		cardMap2.put("cardCode", "2");
		
		selectCardTypeList.add(cardMap1);
		selectCardTypeList.add(cardMap2);
		
		
        Org orgBean =  new Org() ;
		cityList = getConfManagerServ().queryCityForReg(orgBean) ;
		provinceList = getConfManagerServ().queryProvinceForReg(orgBean) ;
		getRequest().getSession().setAttribute("tempOrgId", "");
	    return SUCCESS;
		 
	}
	
	
	public String updateOrgInfo(){
		if(!"".equals(StringUtil.valueOf(org.getOrgId()))){
			getRequest().getSession().setAttribute("tempOrgId", "");
			if(!"******".equals(org.getOrgPwd())){
				org.setOrgPwd(StringUtil.Md5(org.getOrgPwd())) ;
			}else{
				org.setOrgPwd(null) ;
			}
			
			//加密
			String emailCiphertext = this.getEncryMsg(org.getEmail());
			org.setEmail(emailCiphertext);
			String certNumberCiphertext = this.getEncryMsg(org.getCertNumber());
			org.setCertNumber(certNumberCiphertext);
			String telephoneCiphertext = this.getEncryMsg(org.getTelephone());
			org.setTelephone(telephoneCiphertext);
			
			getConfManagerServ().checkOrgOnline(org) ;			 
			getConfManagerServ().updateRoleCode(org,orgRoles) ;
		}
		
	     content_Id=String.valueOf(org.getOrgId()) ;
	     tmpType ="info" ;
	     return SUCCESS ;
	}
	
	
	public String updateOrgInfoState(){
		if(!"".equals(StringUtil.valueOf(org.getOrgId()))){
			
			getConfManagerServ().checkOrgOnline(org) ;
		 } 
		 content_Id=String.valueOf(org.getOrgId()) ;
	     tmpType ="info" ;
	     return SUCCESS ;
	}
	
	public void isDeleteByproductOrOffer(){
		try {
			String orgId = this.getRequest().getParameter("orgId");
			Map mapTemp = new HashMap();  
			mapTemp.put("orgId", orgId);
			JSONObject jsonObject = new JSONObject();
			if(!"".equals(orgId)){
				if("0".equals(getConfManagerServ().isDeleteByOffer(mapTemp))){
					if("0".equals(getConfManagerServ().isDeleteByProduct(mapTemp))){
						jsonObject.put("code", "0");
						jsonObject.put("result", "ok.");
					}else{
						jsonObject.put("code", "1");
						jsonObject.put("result", "the organization for containing product that  cannot be deleted.");
					}
				}else{
					jsonObject.put("code", "2");
					jsonObject.put("result", "the organization for containing offer that  cannot be deleted.");
				}
			}else{
				jsonObject.put("code", "4");
				jsonObject.put("result", "system error!the org id is null.");
			}
	        getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Translation exception",null));
		}
	}
	
	public String deleteOrgInfoById(){
		
		return null ;
	}
	public String insertOrgInfo(){
		org.setOrgPwd(StringUtil.Md5(org.getOrgPwd()));
		org.setState(EAAPConstants.COMM_STATE_ONLINE);
		//加密：
		String emailCiphertext = this.getEncryMsg(org.getEmail());
		org.setEmail(emailCiphertext);
		String certNumberCiphertext = this.getEncryMsg(org.getCertNumber());
		org.setCertNumber(certNumberCiphertext);
		String telephoneCiphertext = this.getEncryMsg(org.getTelephone());
		org.setTelephone(telephoneCiphertext);
		getConfManagerServ().addOrg(org, orgRoles);
		return SUCCESS ;
	}
	
	public String  selectSerInvokeInsList() throws IOException{

		//从公共配置文件“eaap_common.properties”中读取消息流地址  laixh 20141123
//		InputStream is = this.getClass().getResourceAsStream("/eaap_common.properties");
//		Properties prop = new Properties();
//		prop.load(is);
//		msFlowUrl=prop.getProperty("MESSAGE_FLOW_URL");
		msFlowUrl = WebPropertyUtil.getPropertyValue("MESSAGE_FLOW_URL");
		
		 Map serInvokeInsStateMap1 = new HashMap();
		 serInvokeInsStateMap1.put("serInvokeInsStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
		 serInvokeInsStateMap1.put("serInvokeInsStateCode", "A");
		 
		 Map serInvokeInsStateMap2 = new HashMap();
		 serInvokeInsStateMap2.put("serInvokeInsStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
		 serInvokeInsStateMap2.put("serInvokeInsStateCode", "R");
		 
		 selectSerInvokeInsStateList.add(serInvokeInsStateMap1);
		 selectSerInvokeInsStateList.add(serInvokeInsStateMap2);
		 
		return SUCCESS ;
	}
	
	
    public Map  getSerInvokeInsList(Map prar){
    	 msgFlowUrl = getMsgFlowUrl();
    	 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;
		 Map returnMap = new HashMap();
		 
         Map map = new HashMap() ;
         map.put("serviceCode", "".equals(getRequest().getParameter("ser.serviceCode"))?null:getRequest().getParameter("ser.serviceCode")) ;
         if(StringUtil.isEmpty(getRequest().getParameter("isInit"))){
        	 map.put("state", "A");
         }else{
        	 map.put("state", "".equals(getRequest().getParameter("serii.state"))?null:getRequest().getParameter("serii.state"));
         }
         
		 if(StringUtil.valueOf(getRequest().getParameter("serii.serInvokeInsName")).equals(getText("eaap.op2.conf.manager.auth.canlike")) 
				 || StringUtil.valueOf(getRequest().getParameter("serii.serInvokeInsName")).equals("")){
			 map.put("serInvokeInsName",null);
		 }else{
			 map.put("serInvokeInsName",StringUtil.valueOf(getRequest().getParameter("serii.serInvokeInsName")).toLowerCase());
		 }
		 		 
		 map.put("componentId", "".equals(getRequest().getParameter("component.componentId"))?null:getRequest().getParameter("component.componentId")) ;
	     map.put("orgId", "".equals(getRequest().getParameter("org.orgId"))?null:getRequest().getParameter("org.orgId")) ;
		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getConfManagerServ().selectSerInvokeInsList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", (pageNum - 1) * rows);
	     map.put("page_record", rows);
		 List<Map> tmpList = new ArrayList<Map>() ;
         tmpList =getConfManagerServ().selectSerInvokeInsList(map);
         if(tmpList != null){
        	 for(Map tmpMap : tmpList){
        		 String serviceStatus = (String) tmpMap.get("SER_STATE");
        		 if(!StringUtil.isEmpty(serviceStatus)){
        			 if("A".equals(serviceStatus)){
        				 tmpMap.put("SER_STATE_NAME", getText("eaap.op2.conf.task.usable")); 
        			 }else if("D".equals(serviceStatus)){
        				 tmpMap.put("SER_STATE_NAME", getText("eaap.op2.conf.task.disable"));  
        			 }
        		 }
        	 }
         } 
		   
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(tmpList));
		
		return returnMap ;
	}

    
    public String preAddSerInvokeIns(){
    	 msgFlowUrl = getMsgFlowUrl();
    	 Map serInvokeInsStateMap1 = new HashMap();
		 serInvokeInsStateMap1.put("serInvokeInsStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
		 serInvokeInsStateMap1.put("serInvokeInsStateCode", "A");
		 
		 Map serInvokeInsStateMap2 = new HashMap();
		 serInvokeInsStateMap2.put("serInvokeInsStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
		 serInvokeInsStateMap2.put("serInvokeInsStateCode", "R");
		 
		 selectSerInvokeInsStateList.add(serInvokeInsStateMap1);
		 selectSerInvokeInsStateList.add(serInvokeInsStateMap2);
		 
		 logLevelList = getConfManagerServ().getLogLevelList();
		 MessageFlow messageFlow = new MessageFlow();
    	   messgeFlowList = getConfManagerServ().selectMessgeFlowList(messageFlow);
		   if("edit".equals(StringUtil.valueOf(editOrAdd))&&!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
			   Map paramap = new HashMap();
    	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
    	         serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
    	      
		   }else{
			   editOrAdd="add" ;
		   }
		   return SUCCESS ;
	 }
    
    public String insertSerInvokeIns(){
    	   int serInvokeInsId =0;
		   if("edit".equals(StringUtil.valueOf(editOrAdd))&&!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
			    getConfManagerServ().updateSerInvokeIns(serInvokeIns) ;
			 
		    }else{
		    	 serInvokeIns.setState("A") ;
		    	 serInvokeInsId  =getConfManagerServ().insertSerInvokeIns(serInvokeIns) ;
		    	 serInvokeIns.setSerInvokeInsId(serInvokeInsId);
			}
		  
		   return SUCCESS ;
	 }
    
    
    public String updateSerInvokeIns(){
 	         if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
 	        	 getConfManagerServ().updateSerInvokeIns(serInvokeIns) ;
 	         }
 	  		 return SUCCESS ;
	 }
    
    public String showProof(){
    	       Map paramap = new HashMap();
    	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
    	       if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
    	    	   serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
    	    	   attrValuesList = getConfManagerServ().quertAttrValuesByProof(null); 
    	    	   String serInvokeInsId = StringUtil.valueOf(serInvokeIns.getSerInvokeInsId());
    	    	   Map map = new HashMap();
    	    	   map.put("serInvokeInsId", serInvokeInsId);
    	    	   proofList = this.getProofeffectService().getSerInvokerProoef(map);
    	       }
    	       return SUCCESS ;
	 }

	public String authExpressConfig(){
		return SUCCESS;
	}
    
    public List<Map> getActionAttrValue(String proofeId,String pt_cd){
    	Map<String,String> paramMap = new HashMap<String,String>();
    	paramMap.put("pt_cd", pt_cd);
    	paramMap.put("prooffId", proofeId);
    	List<Map> result = this.getProofeffectService().getAllAttrValueByMap(paramMap);
    	return result;
    }
    public String insertProof(){
    	int returnProofeId = 0 ;
    	if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
    		String serInvokeInsId = StringUtil.valueOf(serInvokeIns.getSerInvokeInsId());
    		
    		Map map = new HashMap();
	    	map.put("serInvokeInsId", serInvokeInsId);
    		this.getProofeffectService().deleteAllProoefMidById(map);//删除所有记录
    		if(null != page_proofe_id && page_proofe_id.length > 0){
    			for(String proofe_id : page_proofe_id){
    				String maxId = getProofeffectService().getMidMaxID();
    				if(null == maxId || "".equals(maxId)){
    					maxId = "1";
    				}
    				Map<String,String> paramMap = new HashMap<String,String>();
    				paramMap.put("ID", maxId);
    				paramMap.put("proofe_id", proofe_id);
    				paramMap.put("serInvokeInsId", serInvokeInsId);
    				getProofeffectService().addProoefMid(paramMap);
    			}
    		}
        	getConfManagerServ().updateSerInvokeIns(serInvokeIns) ;
    	}
    	
    	if(StringUtil.valueOf(reqFrom).equals("fromMegFlowMgr")){
    		return "successtoshow";
    	}else{
    		return SUCCESS ;
    	}
      
}
    
    
    
    public String showCC2C(){
	       Map paramap = new HashMap();
	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
	       if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
	    	   serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
	       }
	        
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
	       
	       return SUCCESS ;
  }
    
    public Map getCC2CList(Map para){
    	     
    	     serInvokeIns.setSerInvokeInsId(Integer.valueOf(para.get("queryParamsData").toString()));
		   	 rows = pagination.getRows();
			 pageNum = pagination.getPage();
			 int startRow;
			 startRow = (pageNum - 1) * rows + 1;
			 Map returnMap = new HashMap();
			 List<Map> tmpList = new ArrayList<Map>() ;
			 
		     Map map = new HashMap() ;
		     map.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
		     map.put("queryType", "ALLNUM") ;
		     total=Integer.valueOf(String.valueOf(getConfManagerServ().queryCC2cInfoListById(map).get(0).get("ALLNUM"))) ;
		     map.put("queryType", "") ;
		     map.put("pro", startRow);
		     map.put("end", startRow+rows-1);
		     map.put("pro_mysql", (pageNum - 1) * rows);
		     map.put("page_record", rows);
		     tmpList =getConfManagerServ().queryCC2cInfoListById(map) ;
			   
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
			returnMap.put("dataList", page.convertJson(tmpList));
			
			return returnMap ;
    }
    
    
    public String insertCC2C(){
    	if("add".equals(StringUtil.valueOf(editOrAdd))){
    		getConfManagerServ().insertCtlCounterms2Comp(ctlCounterms2Comp);
    	}else if("edit".equals(StringUtil.valueOf(editOrAdd))){
    		getConfManagerServ().updateCtlCounterms2Comp(ctlCounterms2Comp);
    	}else if("del".equals(StringUtil.valueOf(editOrAdd))){
    		getConfManagerServ().delCtlCounterms2Comp(ctlCounterms2Comp);
    	}
    	return SUCCESS ;
    }
	public String showAuthList(){
		   Map paramap = new HashMap();
	       paramap.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
	       if(!"".equals(StringUtil.valueOf(serInvokeIns.getSerInvokeInsId()))){
	    	   serInvokeInsMap = getConfManagerServ().selectSerInvokeIns(paramap).get(0) ;
	       }
	       paramap.put("attrSpecCode", "('sublength','character','range')");
	       atrrSpecList =  getConfManagerServ().selectAtrrSpecListBySpecCode(paramap);
	       for(AttrSpec myTmpAttrSpec:atrrSpecList){
	    	    atrrSpecMap.put(myTmpAttrSpec.getAttrSpecCode(), myTmpAttrSpec.getAttrSpecId());
	       }
	       
	      Map cc2cState1 = new HashMap();
	      cc2cState1.put("stateCode", "A");
	      cc2cState1.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
	      
	      Map cc2cState2 = new HashMap();
	      cc2cState2.put("stateCode", "R");
	      cc2cState2.put("stateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
	      
	      cc2cStatelist.add(cc2cState1);
	      cc2cStatelist.add(cc2cState2);
		
	       
	      Map authObjOp1 = new HashMap();
	      Map authObjOp2 = new HashMap();
	      Map authObjOp3 = new HashMap();
	      Map authObjOp4 = new HashMap();
	      authObjOp1.put("opCode", "A") ;
	      authObjOp1.put("opName", getText("eaap.op2.conf.manager.auth.opnameA")) ;
	      
	      authObjOp2.put("opCode", "B") ;
	      authObjOp2.put("opName", getText("eaap.op2.conf.manager.auth.opnameB")) ;
	      
	      authObjOp3.put("opCode", "C") ;
	      authObjOp3.put("opName", getText("eaap.op2.conf.manager.auth.opnameC")) ;
	      
	      authObjOp4.put("opCode", "D") ;
	      authObjOp4.put("opName", getText("eaap.op2.conf.manager.auth.opnameD")) ;
	      authObjOpList.add(authObjOp1);
	      authObjOpList.add(authObjOp2);
	      authObjOpList.add(authObjOp3);
	      authObjOpList.add(authObjOp4);
	      
	      Map authObjType1 = new HashMap();
	      Map authObjType2 = new HashMap();
	      authObjType1.put("objTypeCode", "A");
	      authObjType1.put("objTypeName", getText("eaap.op2.conf.manager.auth.authobjtypeispath"));
	      
	      authObjType2.put("objTypeCode", "B");
	      authObjType2.put("objTypeName", getText("eaap.op2.conf.manager.auth.authobjtypeievalue"));
	      
	      authObjTypeList.add(authObjType1);
	      authObjTypeList.add(authObjType2);
	      
	      
	      Map reqOrRsp1 = new HashMap();
	      Map reqOrRsp2 = new HashMap();
	      reqOrRsp1.put("rerpCode", "REQ");
	      reqOrRsp1.put("rerpName", getText("eaap.op2.conf.manager.auth.reqorrspisreq"));
	      
	      reqOrRsp2.put("rerpCode", "RSP");
	      reqOrRsp2.put("rerpName", getText("eaap.op2.conf.manager.auth.reqorrspisrsp"));
	      
	      reqOrRspList.add(reqOrRsp1);
	      reqOrRspList.add(reqOrRsp2);
	      
		 return SUCCESS ;
	}
	
    public Map getAuthListById(Map para){
    	 serInvokeIns.setSerInvokeInsId(Integer.valueOf(para.get("queryParamsData").toString()));
	   	 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;
		 Map returnMap = new HashMap();
		 List<Map> tmpList = new ArrayList<Map>() ;
		 
	     Map map = new HashMap() ;
	     map.put("serInvokeInsId", serInvokeIns.getSerInvokeInsId()) ;
	     map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getConfManagerServ().queryAuthListById(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
	     map.put("end", startRow+rows-1);
         map.put("pro_mysql", (pageNum - 1) * rows);
	     map.put("page_record", rows);
	     tmpList =getConfManagerServ().queryAuthListById(map) ;
	     
	     Map reqrspMap = new HashMap() ;
	     reqrspMap.put("REQ", getText("eaap.op2.conf.manager.auth.reqorrspisreq"));
	     reqrspMap.put("RSP", getText("eaap.op2.conf.manager.auth.reqorrspisrsp"));
	     
	     Map authopMap = new HashMap() ;
	     authopMap.put("A", getText("eaap.op2.conf.manager.auth.opnameA"));
	     authopMap.put("B", getText("eaap.op2.conf.manager.auth.opnameB"));
	     authopMap.put("C", getText("eaap.op2.conf.manager.auth.opnameC"));
	     authopMap.put("D", getText("eaap.op2.conf.manager.auth.opnameD"));
	     
	     Map stateMap = new HashMap() ;
	     stateMap.put("A", getText("eaap.op2.conf.manager.auth.valid"));
	     stateMap.put("R", getText("eaap.op2.conf.manager.auth.invalid"));
	     
	     Map authobjtypeMap = new HashMap() ;
	     authobjtypeMap.put("A", getText("eaap.op2.conf.manager.auth.authobjtypeispath"));
	     authobjtypeMap.put("B", getText("eaap.op2.conf.manager.auth.authobjtypeievalue"));
	     
	     List<Map> authObjAttrList = new ArrayList<Map>() ;
	     List<Map> ahthInfoList = new ArrayList<Map>() ;
	     authObjAttrList = getConfManagerServ().queryAuthObjAttrListById(map);
	     
	     for(Map tmpAuthInfoMap:tmpList){ 
	    	 StringBuffer avBuf = new StringBuffer();
	    	 for(Map tmpAuthObjAttrMap:authObjAttrList){
	    		  if(StringUtil.valueOf(tmpAuthInfoMap.get("AUTH_ID")).equals(StringUtil.valueOf(tmpAuthObjAttrMap.get("AUTH_ID")))){
	    			  avBuf.append(StringUtil.valueOf(tmpAuthObjAttrMap.get("ATTR_SPEC_NAME"))).append(":").append(StringUtil.valueOf(tmpAuthObjAttrMap.get("ATTR_VALUE"))).append(",");
	    			  tmpAuthInfoMap.put(StringUtil.valueOf(tmpAuthObjAttrMap.get("ATTR_SPEC_CODE")), StringUtil.valueOf(tmpAuthObjAttrMap.get("ATTR_VALUE"))) ; 
	    		  }
	    	 }
	    	 String attrValue = avBuf.toString();
	    	 
	    	 if (tmpAuthInfoMap.get("REQRSPNAME") != null) {
	    		 tmpAuthInfoMap.put("REQRSPNAME", reqrspMap.get(tmpAuthInfoMap.get("REQRSPNAME")));
	    	 }
	    	 if (tmpAuthInfoMap.get("AUTHOPNAME") != null) {
	    		 tmpAuthInfoMap.put("AUTHOPNAME", authopMap.get(tmpAuthInfoMap.get("AUTHOPNAME")));
	    	 }
	    	 if (tmpAuthInfoMap.get("STATENAME") != null) {
	    		 tmpAuthInfoMap.put("STATENAME", stateMap.get(tmpAuthInfoMap.get("STATENAME")));
	    	 }
	    	 if (tmpAuthInfoMap.get("AUTHOBJTYPENAME") != null) {
	    		 tmpAuthInfoMap.put("AUTHOBJTYPENAME", authobjtypeMap.get(tmpAuthInfoMap.get("AUTHOBJTYPENAME")));
	    	 }
	    	 
	    	 tmpAuthInfoMap.put("ATTR_VALUE", attrValue);
	    	 ahthInfoList.add(tmpAuthInfoMap);
	      }
	     
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(ahthInfoList));
		
		return returnMap ;
      }
    
    
    public String insertAuthInfo(){
    	AuthObjAttr authObjAttr= new AuthObjAttr();
    	String [] myAttrSpecIds =getRequest().getParameterValues("myAttrSpecIds");
    	String range =getRequest().getParameter("range");
    	String character =getRequest().getParameter("character");  
    	String sublength =getRequest().getParameter("sublength"); 
    	String rangeId = null ;	
    	String characterId = null ;	
        String sublengthId= null ;	
    	if(myAttrSpecIds!=null){
    		for(String myAttrSpecId:myAttrSpecIds){
	    		if(myAttrSpecId.split(",")[0].equals("range")){
	    			rangeId=myAttrSpecId.split(",")[1];
	    		}else if(myAttrSpecId.split(",")[0].equals("character")){
	    			characterId=myAttrSpecId.split(",")[1];
	    		}else if(myAttrSpecId.split(",")[0].equals("sublength")){
	    			sublengthId=myAttrSpecId.split(",")[1];
	    		}
	    	}
    	}
    	 
    	int authObjId ;
    	int authId ;
    	if("add".equals(StringUtil.valueOf(editOrAdd))){
    		authObjId=getConfManagerServ().insertAuthObjInfo(authObj);
    		auth.setAuthObjId(authObjId);
    		authId = getConfManagerServ().insertAuthInfo(auth) ;
    		authBase.setAuthId(authId);
    		getConfManagerServ().insertAuthBaseInfo(authBase);
    		getConfManagerServ().insertCtlCounterms2Comp(ctlCounterms2Comp);
    		
    		authObjAttr.setAuthId(authId);
    		authObjAttr.setAttrSpecId(Integer.valueOf(rangeId));
    		authObjAttr.setAttrValue(range);
    		getConfManagerServ().insertAuthObjAttr(authObjAttr);
    		
    		
    		authObjAttr.setAttrSpecId(Integer.valueOf(characterId));
    		authObjAttr.setAttrValue(character);
    		getConfManagerServ().insertAuthObjAttr(authObjAttr);
    		
    		 
    		authObjAttr.setAttrSpecId(Integer.valueOf(sublengthId));
    		authObjAttr.setAttrValue(sublength);
    		getConfManagerServ().insertAuthObjAttr(authObjAttr);
    		
    		
    		
    	}else if("edit".equals(StringUtil.valueOf(editOrAdd))){
    		if(!"".equals(StringUtil.valueOf(auth.getAuthId()))){
    			getConfManagerServ().updateAuthInfo(auth);
    			
    			authObjAttr.setAuthId(auth.getAuthId());
    			if(!"".equals(StringUtil.valueOf(rangeId))){
	    			authObjAttr.setAttrSpecId(Integer.valueOf(rangeId));
	        		authObjAttr.setAttrValue(range);
	        		getConfManagerServ().updateAuthObjAttr(authObjAttr);
    			}
        		
    			if(!"".equals(StringUtil.valueOf(characterId))){
	        		authObjAttr.setAttrSpecId(Integer.valueOf(characterId));
	        		authObjAttr.setAttrValue(character);
	        		getConfManagerServ().updateAuthObjAttr(authObjAttr);
    			}
	            
	            if(!"".equals(StringUtil.valueOf(sublengthId))){	
        		authObjAttr.setAttrSpecId(Integer.valueOf(sublengthId));
        		authObjAttr.setAttrValue(sublength);
        		getConfManagerServ().updateAuthObjAttr(authObjAttr);
	            }
        		
    		}
    		if(!"".equals(StringUtil.valueOf(authObj.getAuthObjId()))){
    			getConfManagerServ().updateAuthObjInfo(authObj);
    		}
    		
    	 }
    	return SUCCESS ;
    }
    
    
	public String showMainDataTypeList(){
		  orgStateMap = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_ORG) ;
		  Iterator iter = orgStateMap.entrySet().iterator();   
		  while(iter.hasNext()) {
			 Map mapTmp = new HashMap() ;
			 Entry entry = (Entry)iter.next();
			  
			 mapTmp.put("key", entry.getKey()) ;
			 mapTmp.put("value", entry.getValue()) ;
			 orgStateList.add(mapTmp) ;
		 }
		  
		  
		 Map mainTypeStateMap1 = new HashMap();
		 mainTypeStateMap1.put("mainTypeStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
		 mainTypeStateMap1.put("mainTypeStateCode", "A");
		 
		 Map mainTypeStateMap2 = new HashMap();
		 mainTypeStateMap2.put("mainTypeStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
		 mainTypeStateMap2.put("mainTypeStateCode", "R");
		 
		 selectMainTypeStateList.add(mainTypeStateMap1);
		 selectMainTypeStateList.add(mainTypeStateMap2);
		 return SUCCESS ;
	  }
	
	
	
	public Map getMdTypeList(Map para){
		
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;
		 Map returnMap = new HashMap();

		 Map map = new HashMap() ;
		 
		 String[] mdStates =getRequest().getParameterValues("mainDataType.state");
		 String tmpState = "";
		 if(mdStates!=null && mdStates.length>=1){
			 String[] tempArrayState ;
			 tempArrayState = mdStates[0].split(",");
			 StringBuffer stateBf = new StringBuffer();
			 for(String state:tempArrayState){
				 //tmpState+="'" + state+ "'" + ",";
				 stateBf.append("'").append(state).append("',");
			 }
			 tmpState = stateBf.toString();
			 tmpState = tmpState.substring(0,tmpState.length()-1);
		 }
		 
		 map.put("mdtSign", "".equals(getRequest().getParameter("mainDataType.mdtSign"))?null:getRequest().getParameter("mainDataType.mdtSign")) ;
		 map.put("mdtName", "".equals(getRequest().getParameter("mainDataType.mdtName"))?null:getRequest().getParameter("mainDataType.mdtName")) ;
		 
	     if(!"".equals(tmpState)){
			 map.put("state","("+tmpState+")") ;
		 }else{
			 String isInit = getRequest().getParameter("isInit"); 
			 if(StringUtil.isEmpty(isInit)){
				 map.put("state","('A')") ;
			 }
		 }
	     
		 map.put("queryType", "ALLNUM") ;
	     total=Integer.valueOf(String.valueOf(getConfManagerServ().queryMainDateTypeList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", startRow - 1);
         map.put("page_record", rows);
	     mainDataTypeList =getConfManagerServ().queryMainDateTypeList(map) ;
		   
	    returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(mainDataTypeList));
			
		 return returnMap ;
	  }
	
	public String updateMainDataType(){
		   getConfManagerServ().updateMainDataType(mainDataType) ;
		   tmpType ="info" ;
		   return SUCCESS ;
	 }
	
	public String preAddMainDataType(){
		   if("edit".equals(StringUtil.valueOf(editOrAdd))&&mainDataType.getMdtCd()!=null){
			   mainDataType.setState(null);
			   mainDataType = getConfManagerServ().selectMainDataType(mainDataType).get(0) ;
			}else{
			   editOrAdd="add" ;
		   }
		   return SUCCESS ;
	 }
	
	public String preAddMainDataByMtCd(){
		       mainDataType.setState(null);
			   mainDataType = getConfManagerServ().selectMainDataType(mainDataType).get(0) ;
			   
			     Map mainTypeStateMap1 = new HashMap();
				 mainTypeStateMap1.put("mainTypeStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateA"));
				 mainTypeStateMap1.put("mainTypeStateCode", "A");
				 
				 Map mainTypeStateMap2 = new HashMap();
				 mainTypeStateMap2.put("mainTypeStateName", getText("eaap.op2.conf.orgregauditing.maindatetypestateR"));
				 mainTypeStateMap2.put("mainTypeStateCode", "R");
				 
				 selectMainTypeStateList.add(mainTypeStateMap1);
				 selectMainTypeStateList.add(mainTypeStateMap2);
				 
				 
			   return SUCCESS ;
	 }
	
	
	public Map getMainDataListByTypeId(Map para){
	    String MdTypeId = para.get("queryParamsData").toString();
		List<Map> tempList = new ArrayList<Map>() ;
		
		 rows = pagination.getRows();
		 pageNum = pagination.getPage();
		 int startRow;
		 startRow = (pageNum - 1) * rows + 1;
		 Map returnMap = new HashMap();
		 Map map = new HashMap() ;
		 map.put("queryType", "ALLNUM") ;
		 map.put("mdtCd", MdTypeId) ;
	     total=Integer.valueOf(String.valueOf(getConfManagerServ().selectMainDataList(map).get(0).get("ALLNUM"))) ;
	     map.put("queryType", "") ;
	     map.put("pro", startRow);
         map.put("end", startRow+rows-1);
         map.put("pro_mysql", startRow - 1);
         map.put("page_record", rows);
         tempList =getConfManagerServ().selectMainDataList(map) ;
		returnMap.put("startRow", startRow);
		returnMap.put("rows", rows); 	
		returnMap.put("total", total);
		returnMap.put("dataList", page.convertJson(tempList));
			
		 return returnMap ;
	  }
	
	public String insertMainDataType(){
		mainDataType.setLastestTime(UTCTimeUtil.getUTCDate());
		    if("edit".equals(StringUtil.valueOf(editOrAdd))&&mainDataType.getMdtCd()!=null){
		    	 getConfManagerServ().updateMainDataType(mainDataType) ;
		    }else{
		    	 mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE);
			     String mdtid = getConfManagerServ().insertMainDataType(mainDataType) ;
			     mainDataType.setMdtCd(mdtid);
			     editOrAdd="edit";
		    }
		    return SUCCESS ;
	 }
	public String preAddMainData(){
		if("edit".equals(StringUtil.valueOf(editOrAdd))&&mainData.getMaindId()!=null){
			mainData.setState(null);
			mainData = getConfManagerServ().selectMainData(mainData).get(0) ;
		}else{
			 editOrAdd="add" ;
		}
		   mainDataType = getConfManagerServ().selectMainDataType(mainDataType).get(0) ;
		   return SUCCESS ;
	 }
	public String insertMainData(){
		
		mainData.setLastestTime(UTCTimeUtil.getUTCDate());
		if("edit".equals(StringUtil.valueOf(editOrAdd))&&mainData.getMaindId()!=null){
			 getConfManagerServ().updateMainData(mainData) ;
		}else{
			//mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE);
	        getConfManagerServ().insertMainData(mainData) ;
	    }
		 mainDataType.setMdtCd(mainData.getMdtCd()) ;
         return SUCCESS ;
     }
	 public String updateMainData(){
		   getConfManagerServ().updateMainData(mainData) ;
		   return SUCCESS ;
	 }
	
	public String queryMainDataListByTypeId(){
		    mainDataType.setState(null);
		    mainData.setMdtCd(mainDataType.getMdtCd()) ;
		    mainDataType = getConfManagerServ().selectMainDataType(mainDataType).get(0) ;
		    mainDataList = getConfManagerServ().selectMainData(mainData) ;
	    	return SUCCESS ;
	 }
	
	
	
	
	
	
	public String queryAuthList1(){
		Map<String,String> componentMap = new HashMap<String, String>() ;
		componentList = this.getAuthenticateServ().getComponentList(componentMap) ;
		return SUCCESS ; 
	}
	
	
	public String queryAuthList(){
		 Map<String,String> componentMap = new HashMap<String, String>() ;
		 componentList = this.getAuthenticateServ().getComponentList(componentMap) ;
		
		 Map map = new HashMap() ;
		 map.put("componentId", "".equals(serInvokeIns.getComponentId())?null:serInvokeIns.getComponentId()) ;
		 map.put("serviceId", serInvokeIns.getServiceId() == null ?null:serInvokeIns.getServiceId()) ; 
		 if(getSelectPerPage("page")==-1){
	         page.setPageRecord(EAAPConstants.EAAP_PAGE_RECORE_10);
	         }else{
	         page.setPageRecord(getSelectPerPage("page"));
	         }
	         //�ж��Ƿ��ǵ�1�β�ѯ
	         if(getQueryFlag("page")==-1){ 
	        	 map.put("queryType", "ALLNUM") ;
	        	 page.setTotalRecord(Integer.valueOf(String.valueOf(getConfManagerServ().queryAuthList(map).get(0).get("ALLNUM")))); //page.setTotalRecord(testFacade.selectMenuInfoCount(para));
	         }else{
	             page.setTotalRecord(getQueryFlag("page"));
	         }
	         map.put("queryType", "") ;
	         //���ò�ѯ����
	         setPageParameters(page,"page");
	         
	        
	         map.put("pro", page.getPageStart());
	         map.put("end", page.getPageEnd());
	         
	         authList =getConfManagerServ().queryAuthList(map) ;
		    
		 return SUCCESS ;
	  }
	
	
	
	/**
	 * ������ID��ȡ��Ӧ�ķ�����Ϣ
	 * @return
	 */
	public String getServiceInfo(){
		Map<String,String> map = new HashMap<String, String>() ;
		map.put("data", data) ;           
		List<Map> serviceList = this.getFlowcontrolServ().getServiceInfo(map) ;
		
		try {
			StringBuilder sb = new StringBuilder("");
			sb.append("{\"serviceList\":"+JSONArray.fromObject(serviceList).toString()+"}") ;
			
			PrintWriter pw = getResponse().getWriter() ;
			pw.write(sb.toString()) ;
			pw.close() ;
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"JSON translation exception",null));
		}
		return NONE ;  
	} 
	
	public boolean verifyOrg(String verifyParam ,String paramValue) {
	    Org orgBean = new Org(); 
	    if("username".equals(verifyParam)){
	    	 orgBean.setOrgUsername(paramValue) ;
	    }else if(verifyParam.startsWith("email")){
	    	 orgBean.setEmail(paramValue) ;
	    } 
	   
		List orgList = getConfManagerServ().selectOrg(orgBean) ;
		return orgList==null||orgList.size()<1?true:false;
	}
	
	public Map getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map stateMap = new HashMap() ;
	  	
	  	  mainDataType.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = getConfManagerServ().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  mainData.setState(EAAPConstants.EAAP_MAIN_DATA_ONLINE) ;
			  List<MainData> mainDataList = getConfManagerServ().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }
	
	
	
	
	
	public void ShowOrgListForLike(){
		try {
			String name =	new String(getRequest().getParameter("productName").getBytes("iso8859-1"),"UTF-8");
			 org.setName(name);
			 List<Org> orgListForLike = new ArrayList<Org>();
			 orgListForLike = getConfManagerServ().selectOrgListForLike(org);
			 JSONArray jsonObject = JSONArray.fromObject(orgListForLike);
	         getResponse().getWriter().println(jsonObject);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,"Translation exception",null));
		}
	}
	
	public List<Area> loadCityAreaList(Map paraMap){
		cityAreaList = getConfManagerServ().loadCityAreaList(paraMap);
		return cityAreaList;
	}
	
	public void loadCityAreaList(){ 
		PrintWriter out = null;
		try {
			String areaId = getRequest().getParameter("areaId");
			List<Area> cityAreaList = new ArrayList<Area>();
		  	Map paraMap = new HashMap() ;
		  	paraMap.put("areaId",areaId);
			cityAreaList = getConfManagerServ().loadCityAreaList(paraMap);
			
			JSONArray json = new JSONArray();  
	        json.addAll(cityAreaList);  
	        json.listIterator(); 
			
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			out.print(json.toString());
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
	 
	public App getApp() {
		return app;
	}

	public void setApp(App app) {
		this.app = app;
	}

	public IConfManagerServ getConfManagerServ() {
		if(confManagerServ==null){
            //ȡ��spring������
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				confManagerServ = (IConfManagerServ)ctx.getBean("eaap-op2-conf-manager-confManagerServ");
	     }
		return confManagerServ;
	}
	
	//验证org的编码是否存在。
	public boolean validatorOrgInfo(String verifyParam ,String paramValue) { 
		if (getRequest().getSession().getAttribute("tempOrgId") != null 
				&& !"".equals(getRequest().getSession().getAttribute("tempOrgId"))) {
			org.setOrgId(Integer.valueOf((String) getRequest().getSession().getAttribute("tempOrgId")));
		}
		org.setOrgCode(paramValue);
		List<Org> orgList = new ArrayList<Org>();
		orgList = getConfManagerServ().validatorOrgInfoExistList(org);
		boolean isvalidator = false;
		if(orgList==null||orgList.size() == 0){
			isvalidator = true;
		}
		return isvalidator;
	}	
	
	/**
	 * 验证主数据是否为固化数据
	 */
	public void checkOperation(){
		Map mapTemp = new HashMap();  
		mapTemp.put("mdt_cd", mdt_cd);
		String type = getConfManagerServ().getTypeById(mapTemp);
		PrintWriter pw = null;
		try{
			if(null != type && !"".equals(type)){
				if("1".equals(type)){
					pw = getResponse().getWriter();
					pw.write("fail");
					pw.flush();
				}else {
					pw = getResponse().getWriter();
					pw.write("ok");
					pw.flush();
				}
			}
		}catch (Exception  e){
			try {
				pw = getResponse().getWriter();
				pw.write("fail");
				pw.flush();
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			
		}finally{
			if(null != pw){
				pw.close();
			}
		}
	}
	public void setConfManagerServ(IConfManagerServ confManagerServ) {
		this.confManagerServ = confManagerServ;
	}
 
	
	public IOrgRegAuditingServ getOrgRegAuditingServ() {
		if(orgRegAuditingServ==null){
            //ȡ��spring������
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				orgRegAuditingServ = (IOrgRegAuditingServ)ctx.getBean("eaap-op2-conf-auditing-orgAndAppServ");
	     }
		return orgRegAuditingServ;
	}
	public void setOrgRegAuditingServ(IOrgRegAuditingServ orgRegAuditingServ) {
		this.orgRegAuditingServ = orgRegAuditingServ;
	}
	
	
	public Map getOrgInfoMap() {
		return orgInfoMap;
	}
	public void setOrgInfoMap(Map orgInfoMap) {
		this.orgInfoMap = orgInfoMap;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}

	public Map getAppInfoMap() {
		return appInfoMap;
	}

	public void setAppInfoMap(Map appInfoMap) {
		this.appInfoMap = appInfoMap;
	}

 
	public List<Map> getAppApiInfoList() {
		return appApiInfoList;
	}

	public void setAppApiInfoList(List<Map> appApiInfoList) {
		this.appApiInfoList = appApiInfoList;
	}

	 

	public String getContent_Id() {
		return content_Id;
	}

	public void setContent_Id(String content_Id) {
		this.content_Id = content_Id;
	}

	public String getCheckState() {
		return checkState;
	}

	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}

	public String getActivity_Id() {
		return activity_Id;
	}

	public void setActivity_Id(String activity_Id) {
		this.activity_Id = activity_Id;
	}

	public String getCheckDesc() {
		return checkDesc;
	}

	public void setCheckDesc(String checkDesc) {
		this.checkDesc = checkDesc;
	}

	public String getProcess_Id() {
		return process_Id;
	}

	public void setProcess_Id(String process_Id) {
		this.process_Id = process_Id;
	}

	public String getProcess_Model_Id() {
		return process_Model_Id;
	}

	public void setProcess_Model_Id(String process_Model_Id) {
		this.process_Model_Id = process_Model_Id;
	}

	public SerInvokeIns getSerInvokeIns() {
		return serInvokeIns;
	}

	public void setSerInvokeIns(SerInvokeIns serInvokeIns) {
		this.serInvokeIns = serInvokeIns;
	}

	public Pagination getPage() {
		return page;
	}

	public void setPage(Pagination page) {
		this.page = page;
	}

	public List<Map> getOrgInfoList() {
		return orgInfoList;
	}

	public void setOrgInfoList(List<Map> orgInfoList) {
		this.orgInfoList = orgInfoList;
	}

	public List<Map> getOrgStateList() {
		return orgStateList;
	}

	public void setOrgStateList(List<Map> orgStateList) {
		this.orgStateList = orgStateList;
	}

	public String getTmpType() {
		return tmpType;
	}

	public void setTmpType(String tmpType) {
		this.tmpType = tmpType;
	}

	public OrgRole getOrgRole() {
		return orgRole;
	}

	public void setOrgRole(OrgRole orgRole) {
		this.orgRole = orgRole;
	}

	public ProdOffer getProdOffer() {
		return prodOffer;
	}

	public void setProdOffer(ProdOffer prodOffer) {
		this.prodOffer = prodOffer;
	}

	public OfferProdRel getOfferProdRel() {
		return offerProdRel;
	}

	public void setOfferProdRel(OfferProdRel offerProdRel) {
		this.offerProdRel = offerProdRel;
	}

	public List<Map> getProvServiceList() {
		return provServiceList;
	}

	public void setProvServiceList(List<Map> provServiceList) {
		this.provServiceList = provServiceList;
	}

	public ProdOfferChannelType getProdOfferChannelType() {
		return prodOfferChannelType;
	}

	public void setProdOfferChannelType(ProdOfferChannelType prodOfferChannelType) {
		this.prodOfferChannelType = prodOfferChannelType;
	}

	public Map getProdChannelMap() {
		return prodChannelMap;
	}

	public void setProdChannelMap(Map prodChannelMap) {
		this.prodChannelMap = prodChannelMap;
	}

	public List<ProdOfferChannelType> getProdOfferChannelTypeList() {
		return prodOfferChannelTypeList;
	}

	public void setProdOfferChannelTypeList(
			List<ProdOfferChannelType> prodOfferChannelTypeList) {
		this.prodOfferChannelTypeList = prodOfferChannelTypeList;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ProductAttr getProductAttr() {
		return productAttr;
	}

	public void setProductAttr(ProductAttr productAttr) {
		this.productAttr = productAttr;
	}

	public List<Map> getProductAttrList() {
		return productAttrList;
	}

	public void setProductAttrList(List<Map> productAttrList) {
		this.productAttrList = productAttrList;
	}

	public List<Product> getChooseProdOardList() {
		return chooseProdOardList;
	}

	public void setChooseProdOardList(List<Product> chooseProdOardList) {
		this.chooseProdOardList = chooseProdOardList;
	}

	public List<Map> getPricingList() {
		return pricingList;
	}

	public void setPricingList(List<Map> pricingList) {
		this.pricingList = pricingList;
	}

	public List<Map> getMainDataTypeList() {
		return mainDataTypeList;
	}

	public void setMainDataTypeList(List<Map> mainDataTypeList) {
		this.mainDataTypeList = mainDataTypeList;
	}

	public MainDataType getMainDataType() {
		return mainDataType;
	}

	public void setMainDataType(MainDataType mainDataType) {
		this.mainDataType = mainDataType;
	}

	public MainData getMainData() {
		return mainData;
	}

	public void setMainData(MainData mainData) {
		this.mainData = mainData;
	}

	public List<MainData> getMainDataList() {
		return mainDataList;
	}

	public void setMainDataList(List<MainData> mainDataList) {
		this.mainDataList = mainDataList;
	}

	public String getEditOrAdd() {
		return editOrAdd;
	}

	public void setEditOrAdd(String editOrAdd) {
		this.editOrAdd = editOrAdd;
	}

	public IAuthenticateServ getAuthenticateServ() {
		if(authenticateServ==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			authenticateServ = (IAuthenticateServ)ctx.getBean("eaap-op2-conf-authenticate-authenticateServ") ;
     }
	return authenticateServ;
}

	public void setAuthenticateServ(IAuthenticateServ authenticateServ) {
		this.authenticateServ = authenticateServ;
	}
	                         
	public IFlowControlServ getFlowcontrolServ() {
		if(flowcontrolServ==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			flowcontrolServ = (IFlowControlServ)ctx.getBean("eaap-op2-conf-flowcontrol-flowcontrolServ") ;
        }
	   return flowcontrolServ;
      }

	public void setFlowcontrolServ(IFlowControlServ flowcontrolServ) {
		this.flowcontrolServ = flowcontrolServ;
	}

	public List<Map> getAuthList() {
		return authList;
	}

	public void setAuthList(List<Map> authList) {
		this.authList = authList;
	}

	public String[] getOrgRoles() {
		return orgRoles;
	}

	public void setOrgRoles(String[] orgRoles) {
		this.orgRoles = Arrays.copyOf(orgRoles, orgRoles.length);
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}

	public List<Map> getSelectSerInvokeInsStateList() {
		return selectSerInvokeInsStateList;
	}

	public void setSelectSerInvokeInsStateList(List<Map> selectSerInvokeInsStateList) {
		this.selectSerInvokeInsStateList = selectSerInvokeInsStateList;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public Component getComponent() {
		return component;
	}

	public void setComponent(Component component) {
		this.component = component;
	}

	public List<Map> getProofList() {
		return proofList;
	}

	public void setProofList(List<Map> proofList) {
		this.proofList = proofList;
	}

	public Map getSerInvokeInsMap() {
		return serInvokeInsMap;
	}

	public void setSerInvokeInsMap(Map serInvokeInsMap) {
		this.serInvokeInsMap = serInvokeInsMap;
	}

	public Map getProofTypeMap() {
		return proofTypeMap;
	}

	public void setProofTypeMap(Map proofTypeMap) {
		this.proofTypeMap = proofTypeMap;
	}

	public String[] getPtSpecs() {
		return ptSpecs;
	}

	public void setPtSpecs(String[] ptSpecs) {
		this.ptSpecs = Arrays.copyOf(ptSpecs, ptSpecs.length);
	}

	public String[] getPtCds() {
		return ptCds;
	}

	public void setPtCds(String[] ptCds) {
		this.ptCds = Arrays.copyOf(ptCds, ptCds.length);
	}

	public String[] getOnOffs() {
		return onOffs;
	}

	public void setOnOffs(String[] onOffs) {
		this.onOffs = Arrays.copyOf(onOffs, onOffs.length);
	}

	public String[] getAttrValues() {
		return attrValues;
	}

	public void setAttrValues(String[] attrValues) {
		this.attrValues = Arrays.copyOf(attrValues, attrValues.length);
	}

	public List<Map> getCc2cList() {
		return cc2cList;
	}

	public void setCc2cList(List<Map> cc2cList) {
		this.cc2cList = cc2cList;
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

	public CtlCounterms2Comp getCtlCounterms2Comp() {
		return ctlCounterms2Comp;
	}

	public void setCtlCounterms2Comp(CtlCounterms2Comp ctlCounterms2Comp) {
		this.ctlCounterms2Comp = ctlCounterms2Comp;
	}

	public List<AttrSpec> getAtrrSpecList() {
		return atrrSpecList;
	}

	public void setAtrrSpecList(List<AttrSpec> atrrSpecList) {
		this.atrrSpecList = atrrSpecList;
	}

	public List<Map> getAuthObjOpList() {
		return authObjOpList;
	}

	public void setAuthObjOpList(List<Map> authObjOpList) {
		this.authObjOpList = authObjOpList;
	}

 

	public List<Map> getAuthObjTypeList() {
		return authObjTypeList;
	}

	public void setAuthObjTypeList(List<Map> authObjTypeList) {
		this.authObjTypeList = authObjTypeList;
	}

	public List<Map> getReqOrRspList() {
		return reqOrRspList;
	}

	public void setReqOrRspList(List<Map> reqOrRspList) {
		this.reqOrRspList = reqOrRspList;
	}

	public Auth getAuth() {
		return auth;
	}

	public void setAuth(Auth auth) {
		this.auth = auth;
	}

	public AuthObj getAuthObj() {
		return authObj;
	}

	public void setAuthObj(AuthObj authObj) {
		this.authObj = authObj;
	}

	public AuthBase getAuthBase() {
		return authBase;
	}

	public void setAuthBase(AuthBase authBase) {
		this.authBase = authBase;
	}

	public AuthObjAttr getAuthObjAttr() {
		return authObjAttr;
	}

	public void setAuthObjAttr(AuthObjAttr authObjAttr) {
		this.authObjAttr = authObjAttr;
	}

	public List<Map> getMessgeFlowList() {
		return messgeFlowList;
	}

	public void setMessgeFlowList(List<Map> messgeFlowList) {
		this.messgeFlowList = messgeFlowList;
	}

	public MessageFlow getMessageFlow() {
		return messageFlow;
	}

	public void setMessageFlow(MessageFlow messageFlow) {
		this.messageFlow = messageFlow;
	}

	public Map getAtrrSpecMap() {
		return atrrSpecMap;
	}

	public void setAtrrSpecMap(Map atrrSpecMap) {
		this.atrrSpecMap = atrrSpecMap;
	}

	public List<Map> getAttrValuesList() {
		return attrValuesList;
	}

	public void setAttrValuesList(List<Map> attrValuesList) {
		this.attrValuesList = attrValuesList;
	}

	public Map getAttrValueMapForProof() {
		return attrValueMapForProof;
	}

	public void setAttrValueMapForProof(Map attrValueMapForProof) {
		this.attrValueMapForProof = attrValueMapForProof;
	}

	public String getMsgFlowUrl() {
		return EAAPConstants.MESSAGE_FLOW_URL;
	}

	public void setMsgFlowUrl(String msgFlowUrl) {
		this.msgFlowUrl = msgFlowUrl;
	}

	public String getReqFrom() {
		return reqFrom;
	}

	public void setReqFrom(String reqFrom) {
		this.reqFrom = reqFrom;
	}

	public List<Area> getCityAreaList() {
		return cityAreaList;
	}

	public void setCityAreaList(List<Area> cityAreaList) {
		this.cityAreaList = cityAreaList;
	}

	public String getOnOffs1() {
		return onOffs1;
	}

	public void setOnOffs1(String onOffs1) {
		this.onOffs1 = onOffs1;
	}

	public String getPageState() {
		return pageState;
	}

	public void setPageState(String pageState) {
		this.pageState = pageState;
	}

	public String getSerInvokeInsName() {
		return serInvokeInsName;
	}

	public void setSerInvokeInsName(String serInvokeInsName) {
		this.serInvokeInsName = serInvokeInsName;
	}

	public String getSerInvokeInsId() {
		return serInvokeInsId;
	}

	public void setSerInvokeInsId(String serInvokeInsId) {
		this.serInvokeInsId = serInvokeInsId;
	}

	public String[] getArrayState() {
		return arrayState;
	}

	public void setArrayState(String[] arrayState) {
		this.arrayState = Arrays.copyOf(arrayState, arrayState.length);
	}

	public String[] getPage_proofe_id() {
		return page_proofe_id;
	}

	public void setPage_proofe_id(String[] page_proofe_id) {
		this.page_proofe_id = Arrays.copyOf(page_proofe_id, page_proofe_id.length);
	}
	public IProofEffectService getProofeffectService() {
		if (proofeffectService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils
					.getWebApplicationContext(this.getSession()
							.getServletContext());
			proofeffectService = (IProofEffectService) ctx
					.getBean("eaap-op2-conf-proofeffect-proofeffectService");
		}
		return proofeffectService;
	}
	public void setProofeffectService(IProofEffectService proofeffectService) {
		this.proofeffectService = proofeffectService;
	}

	public String getPageShowMsg() {
		return pageShowMsg;
	}

	public void setPageShowMsg(String pageShowMsg) {
		this.pageShowMsg = pageShowMsg;
	}

	public String getMsFlowUrl() {
		return msFlowUrl;
	}
	public void setMsFlowUrl(String msFlowUrl) {
		this.msFlowUrl = msFlowUrl;
	}

	public String getIsChoosePage() {
		return isChoosePage;
	}
	public void setIsChoosePage(String isChoosePage) {
		this.isChoosePage = isChoosePage;
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

	public String getShowflag() {
		return showflag;
	}

	public void setShowflag(String showflag) {
		this.showflag = showflag;
	}

	public String getMdt_cd() {
		return mdt_cd;
	}

	public void setMdt_cd(String mdt_cd) {
		this.mdt_cd = mdt_cd;
	}
	
	public List<Map> getLogLevelList() {
		return logLevelList;
	}

	public void setLogLevelList(List<Map> logLevelList) {
		this.logLevelList = logLevelList;
	}

	
}
