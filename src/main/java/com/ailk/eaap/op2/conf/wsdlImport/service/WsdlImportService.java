package com.ailk.eaap.op2.conf.wsdlImport.service;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.WsdlImport;
import com.ailk.eaap.op2.conf.wsdlImport.dao.WsdlImportDao;

public class WsdlImportService implements IWsdlImportService {
	private WsdlImportDao wsdlImportDao ;
	
	public WsdlImportDao getWsdlImportDao() {
		return wsdlImportDao;
	}
	public void setWsdlImportDao(WsdlImportDao wsdlImportDao) {
		this.wsdlImportDao = wsdlImportDao;
	}

	public List<Map> getWsdlImportList(Map map){
		return wsdlImportDao.getWsdlImportList(map);
	}
	
	public void insertWsdlImport(WsdlImport wsdlImport){
		wsdlImportDao.insertWsdlImport(wsdlImport);
	}
	
	public int getSeq(String sequenceName){
		return wsdlImportDao.getSeq(sequenceName);
	}
	
	public WsdlImport getWsdlImport(WsdlImport wsdlImport){
		return wsdlImportDao.getWsdlImport(wsdlImport);
	}
	
	public List<Map<String, Object>> queryDocContractList(DocContract docContract) {
		return wsdlImportDao.queryDocContractList(docContract);	
	}
	
}
