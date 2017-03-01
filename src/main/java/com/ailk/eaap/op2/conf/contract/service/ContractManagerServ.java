package com.ailk.eaap.op2.conf.contract.service;

import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.conf.contract.dao.IContractManagerDao;

public class ContractManagerServ implements IContractManagerServ {
	
	private IContractManagerDao iContractManagerDao;

	public IContractManagerDao getiContractManagerDao() {
		return iContractManagerDao;
	}

	public void setiContractManagerDao(IContractManagerDao iContractManagerDao) {
		this.iContractManagerDao = iContractManagerDao;
	}

	public int addContractVersion(ContractVersion contracVersion) {
		return iContractManagerDao.addContractVersion(contracVersion);
	}

	public int addDocContract(DocContract docContract) {
		return iContractManagerDao.addDocContract(docContract);
	}

	public int addContractFormat(ContractFormat contractFormat) {
		return iContractManagerDao.addContractFormat(contractFormat);
	}

	public int addNodeDesc(NodeDesc nodeDesc) {
		return iContractManagerDao.addNodeDesc(nodeDesc);
	}

}
