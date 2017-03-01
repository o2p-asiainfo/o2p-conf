/*
 * @(#)ContractAuditingAction.java        2013-5-17
 *
 * Copyright (c) 2013 asiainfo-linkage
 * All rights reserved.
 *
 */

package com.ailk.eaap.op2.conf.auditing.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.auditing.service.IContractAuditingServ;



public class ContractAuditingAction extends BaseAction{
	private static final long serialVersionUID = 1L;

	public List<Map<String, Object>> getContractList() {
		return contractList;
	}
	public void setContractList(List<Map<String, Object>> contractList) {
		this.contractList = contractList;
	}
	public Contract getContract() {
		return contract;
	}
	public void setContract(Contract contract) {
		this.contract = contract;
	}
	public IContractAuditingServ getContractAuditionServ() {
		if(contractAuditionServ==null){
				WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
				contractAuditionServ = (IContractAuditingServ)ctx.getBean("eaap-op2-conf-auditing-contractServ");   
	     }
		return contractAuditionServ;
	}
	public void setContractAuditionServ(IContractAuditingServ contractAuditionServ) {
		this.contractAuditionServ=contractAuditionServ;
	}

	public Pagination getPage() {
		return page;
	}
	public void setPage(Pagination page) {
		this.page = page;
	}
	
	public List<Map<String, Object>> getContractVandFList() {
		return contractVandFList;
	}
	public void setContractVandFList(List<Map<String, Object>> contractVandFList) {
		this.contractVandFList = contractVandFList;
	}

	public String getContent_Id() {
		return content_Id;
	}
	public void setContent_Id(String content_Id) {
		this.content_Id = content_Id;
	}

	public Map<String, String> getContractStateMap() {
		return contractStateMap;
	}
	public void setContractStateMap(Map<String, String> contractStateMap) {
		this.contractStateMap = contractStateMap;
	}

	public Map<String, String> getBaseContractMap() {
		return baseContractMap;
	}
	public void setBaseContractMap(Map<String, String> baseContractMap) {
		this.baseContractMap = baseContractMap;
	}
	public ContractVersion getContractVersion() {
		return contractVersion;
	}
	public void setContractVersion(ContractVersion contractVersion) {
		this.contractVersion = contractVersion;
	}
	public ContractFormat getContractFormat() {
		return contractFormat;
	}
	public void setContractFormat(ContractFormat contractFormat) {
		this.contractFormat = contractFormat;
	}

	public String getEffDate() {
		return effDate;
	}
	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}
	public String getExpDate() {
		return expDate;
	}
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public Map<String, Object> getConType() {
		return conType;
	}
	public void setConType(Map<String, Object> conType) {
		this.conType = conType;
	}


	private IContractAuditingServ contractAuditionServ;
	private String content_Id ;
	private List<Map<String,Object>> contractList = new ArrayList<Map<String,Object>>();
	private Contract contract= new Contract();
	private ContractVersion contractVersion = new ContractVersion();
	private ContractFormat contractFormat = new ContractFormat();
	private List<Map<String,Object>> contractVandFList = new ArrayList<Map<String,Object>>();
	 private Pagination page=new Pagination();
	 private Map<String,String> contractStateMap = new HashMap<String,String>();
	 private Map<String,String> baseContractMap = new HashMap<String,String>();
	 private String effDate;
	 private String expDate;
	 private Map<String,Object> conType = new HashMap<String,Object>() ;
	
	public String showContractList(){
		contractStateMap.put("A", "A");
		contractStateMap.put("R", "R");
		Map<String,Object> queryConditionMap = new HashMap<String,Object>(); 
		queryConditionMap.put("contractId", contract.getContractId() == null?null:contract.getContractId());
		queryConditionMap.put("baseContractId", contract.getBaseContractId() == null?null:contract.getBaseContractId());
		queryConditionMap.put("name", "".equals(contract.getName())?null:contract.getName());
		queryConditionMap.put("code", "".equals(contract.getCode())?null:contract.getCode());
		if(getSelectPerPage("page")==-1){
			page.setPageRecord(8);
	     	} else {
	     	page.setPageRecord(getSelectPerPage("page"));
	    }
         if(getQueryFlag("page")==-1){ 
        	 page.setTotalRecord(getContractAuditionServ().queryContractListCount(queryConditionMap));
         }else{
             page.setTotalRecord(getQueryFlag("page"));
         }
	     setPageParameters(page,"page");
	     queryConditionMap.put("pro", page.getPageStart());
	     queryConditionMap.put("end", page.getPageEnd());
	     contractList=getContractAuditionServ().queryContractList(queryConditionMap);
		 return SUCCESS;
	}
	public String showContractVersionAndFormatList(){
		contractVandFList=getContractAuditionServ().queryContractAndFormat(Integer.valueOf(content_Id));
		return SUCCESS;
	}
	public String preInsertContractInfo(){
		baseContractMap.put("1", "(XML/XML)CEP");
		baseContractMap.put("2", "(XML/XML)");
		baseContractMap.put("3", "(URLGET-XML/JSON)");
		baseContractMap.put("4", "(URLGET-XML)");
		return SUCCESS;
	}
	public String insertContractInfo(){
		setContent_Id(Integer.toString(getContractAuditionServ().insertContract(contract)));
		return SUCCESS;
	}
	public String preInsertContractVersion(){
		contractVersion.setContractId(content_Id);
		return SUCCESS;
	}
	public String insertContractVersion() throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		contractVersion.setEffDate(sdf.parse(effDate));
		contractVersion.setExpDate(sdf.parse(expDate));
		setContent_Id(Integer.toString(getContractAuditionServ().insertContractVersion(contractVersion)));
		return SUCCESS;
	}
	public String preInsertContractFormat(){
		contractFormat.setContractVersionId(Integer.valueOf(content_Id));
		conType = getMainInfo(EAAPConstants.MAINDATATYPE_SIGN_CONTRACTCON) ;
		return SUCCESS;
	}
	public String insertContractFormat(){
		setContent_Id(Integer.toString(getContractAuditionServ().insertContractFormat(contractFormat)));
		return SUCCESS;
	}
	public Map<String,Object> getMainInfo(String mainTypeSign){
	  	  MainDataType mainDataType = new MainDataType();
	  	  MainData mainData = new MainData();
	  	  Map<String,Object> stateMap = new HashMap<String,Object>() ;
	  	   
	  	  mainDataType.setMdtSign(mainTypeSign) ;
			  mainDataType = getContractAuditionServ().selectMainDataType(mainDataType).get(0) ;
			  mainData.setMdtCd(mainDataType.getMdtCd()) ;
			  List<MainData> mainDataList = getContractAuditionServ().selectMainData(mainData) ;
			 
			  if(mainDataList!=null && mainDataList.size()>0){
				  for(int i=0;i<mainDataList.size();i++){
					  stateMap.put(mainDataList.get(i).getCepCode(),
							          mainDataList.get(i).getCepName()) ;
				  }
			  }
	  	
	  	return  stateMap ;
	  }
	
}
