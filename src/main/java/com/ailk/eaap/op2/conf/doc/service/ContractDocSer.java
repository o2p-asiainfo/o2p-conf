package com.ailk.eaap.op2.conf.doc.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.conf.doc.dao.IContractDocDao;

public class ContractDocSer implements IContractDocSer {
	private IContractDocDao iContractDao;
	public IContractDocDao getiContractDao() {
		return iContractDao;
	}

	public void setiContractDao(IContractDocDao iContractDao) {
		this.iContractDao = iContractDao;
	}

	public List<Map<String, String>> showContractDocs(Map map) {
		return iContractDao.showContractDocs(map);
	}

	public int addContractDoc(ContractDoc contractDoc) {
		return iContractDao.addContractDoc(contractDoc);
	}

	public void updateContractDoc(ContractDoc contractDoc){
		iContractDao.updateContractDoc(contractDoc);
	}
	
	public void delContracDoc(Map map) {
		iContractDao.delContracDoc(map);
	}

	public int countDocSum(Map map) {
		return iContractDao.countDocSum(map);
	}

	public List<Map> countDoc(Map map) {
		return iContractDao.countDoc(map);
	}

	public int isExitDocName(Map map){
		return iContractDao.isExitDocName(map);
	}

	@Override
	public int isResAlissExit(Map map) {
		return iContractDao.isResAlissExit(map);
	}
}
