package com.ailk.eaap.op2.conf.contract.dao;

import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;

public interface IContractManagerDao {
	
	public int addContractVersion(ContractVersion contracVersion);
	public int addDocContract(DocContract docContract);
	public int addContractFormat(ContractFormat contractFormat);
	public int addNodeDesc(NodeDesc nodeDesc);

}
