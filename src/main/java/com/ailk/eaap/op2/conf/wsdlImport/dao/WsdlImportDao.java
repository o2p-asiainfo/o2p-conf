package com.ailk.eaap.op2.conf.wsdlImport.dao;

import java.util.Map;
import java.util.List;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.WsdlImport;
 
public interface WsdlImportDao { 

	public List<Map> getWsdlImportList(Map map);
	public void insertWsdlImport(WsdlImport wsdlImport);
	public int getSeq(String sequenceName);
	public WsdlImport getWsdlImport(WsdlImport wsdlImport);
	public List<Map<String, Object>> queryDocContractList(DocContract docContract);
}
