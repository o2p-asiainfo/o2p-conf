package com.ailk.eaap.op2.conf.doc.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.ContractDoc;

public interface IContractDocSer {
	public List<Map<String, String>> showContractDocs(Map map);
	public int addContractDoc(ContractDoc contractDoc);
	public void updateContractDoc(ContractDoc contractDoc);
	public void delContracDoc(Map map);
	public int countDocSum(Map map);
	public List<Map> countDoc(Map map);
	public int isExitDocName(Map map);
	public int isResAlissExit(Map map);
}
