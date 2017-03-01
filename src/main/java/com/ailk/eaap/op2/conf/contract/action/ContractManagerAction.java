package com.ailk.eaap.op2.conf.contract.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import net.sf.json.JSONArray;

import com.ailk.eaap.op2.bo.Contract;

import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.MainData;
import com.ailk.eaap.op2.bo.MainDataType;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.conf.contract.service.IContractManagerServ;
import com.ailk.eaap.op2.conf.serviceManager.service.IServiceManagerServ;
import com.linkage.rainbow.ui.struts.BaseAction;

public class ContractManagerAction extends BaseAction{

	private static final long serialVersionUID = 1L;
	private Contract contract= new Contract();
	private ContractVersion contractVersion = new ContractVersion();
	private DocContract docContract = new DocContract();
	private List<ContractDoc> contractDocList = new ArrayList<ContractDoc>();
	private ContractFormat reqContractFormat = new ContractFormat();
	private ContractFormat rspContractFormat = new ContractFormat();	
	private List<NodeDesc> reqNodeDescList = new ArrayList<NodeDesc>();
	private List<NodeDesc> rspNodeDescList = new ArrayList<NodeDesc>();
	private String reqNodeDescJsonString = "";
	private String rspNodeDescJsonString = "";
	private MainData mainData = new MainData();
	private MainDataType mainDataType = new MainDataType();
	private IContractManagerServ iContractManagerServ;
	public Contract getContract() {
		return contract;
	}
	public void setContract(Contract contract) {
		this.contract = contract;
	}
	public ContractVersion getContractVersion() {
		return contractVersion;
	}
	public void setContractVersion(ContractVersion contractVersion) {
		this.contractVersion = contractVersion;
	}
	public ContractFormat getReqContractFormat() {
		return reqContractFormat;
	}
	public void setReqContractFormat(ContractFormat reqContractFormat) {
		this.reqContractFormat = reqContractFormat;
	}
	public ContractFormat getRspContractFormat() {
		return rspContractFormat;
	}
	public void setRspContractFormat(ContractFormat rspContractFormat) {
		this.rspContractFormat = rspContractFormat;
	}
	public List<NodeDesc> getReqNodeDescList() {
		return reqNodeDescList;
	}
	public void setReqNodeDescList(List<NodeDesc> reqNodeDescList) {
		this.reqNodeDescList = reqNodeDescList;
	}
	public List<NodeDesc> getRspNodeDescList() {
		return rspNodeDescList;
	}
	public void setRspNodeDescList(List<NodeDesc> rspNodeDescList) {
		this.rspNodeDescList = rspNodeDescList;
	}
	public String getReqNodeDescJsonString() {
		return reqNodeDescJsonString;
	}
	public void setReqNodeDescJsonString(String reqNodeDescJsonString) {
		this.reqNodeDescJsonString = reqNodeDescJsonString;
	}
	public String getRspNodeDescJsonString() {
		return rspNodeDescJsonString;
	}
	public void setRspNodeDescJsonString(String rspNodeDescJsonString) {
		this.rspNodeDescJsonString = rspNodeDescJsonString;
	}
	public DocContract getDocContract() {
		return docContract;
	}
	public void setDocContract(DocContract docContract) {
		this.docContract = docContract;
	}
	public MainData getMainData() {
		return mainData;
	}
	public void setMainData(MainData mainData) {
		this.mainData = mainData;
	}
	public MainDataType getMainDataType() {
		return mainDataType;
	}
	public void setMainDataType(MainDataType mainDataType) {
		this.mainDataType = mainDataType;
	}
	public List<ContractDoc> getContractDocList() {
		return contractDocList;
	}
	public void setContractDocList(List<ContractDoc> contractDocList) {
		this.contractDocList = contractDocList;
	}
	
	public IContractManagerServ getiContractManagerServ() {
		if(iContractManagerServ==null){
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			iContractManagerServ = (IContractManagerServ)ctx.getBean("eaap-op2-conf-contract-manager-service") ;
	     }
		return iContractManagerServ;
	}
	public void setiContractManagerServ(IContractManagerServ iContractManagerServ) {
		this.iContractManagerServ = iContractManagerServ;
	}
	public String preAddContract2() {
		setContract();
		setContractDocList();
		return SUCCESS;
	}
	
	public void setContract() {
		contract.setBaseContractId(2);
		contract.setCode("LYL");
		contract.setContractId(20180);
//		contract.setDescriptor("LYL测试用");
//		contract.setName("LYL测试专用");
		contract.setDescriptor("");
		contract.setName("");
		contract.setState("A");
	}
	
	public void setContractDocList() {
		ContractDoc d1=new ContractDoc();
		ContractDoc d2=new ContractDoc();
		ContractDoc d3=new ContractDoc();
//		d1.setDocName("EAAP架构能力开放需求规格说明书V1.0.docx");
//		d2.setDocName("集团CRM第三方门户协议_充值分册V0.33-20121229.docx");
//		d3.setDocName("集团ESS横向接口协议_第三方门户计费查询接口分册V0.3--20120416.docx");
		d1.setDocName("");
		d2.setDocName("");
		d3.setDocName("");
		d1.setContractDocId(1);
		d2.setContractDocId(2);
		d3.setContractDocId(3);
		contractDocList.add(d1);
		contractDocList.add(d2);
		contractDocList.add(d3);
	}
	
	public String addContract2() {
		contractVersion.setContractId("20180");
		int contractVersionId = getiContractManagerServ().addContractVersion(getContractVersion());
		docContract.setContractVersionId(contractVersionId);
		getiContractManagerServ().addDocContract(getDocContract());
		reqContractFormat.setContractVersionId(contractVersionId);
		reqContractFormat.setReqRsp("REQ");
		rspContractFormat.setContractVersionId(contractVersionId);
		rspContractFormat.setReqRsp("RSP");
		int reqCFId = getiContractManagerServ().addContractFormat(getReqContractFormat());
		int rspCFId = getiContractManagerServ().addContractFormat(getRspContractFormat());
		this.setReqNodeDescList(jsonToList(reqNodeDescJsonString,reqCFId));
		this.setRspNodeDescList(jsonToList(rspNodeDescJsonString,rspCFId));
		for(Iterator<NodeDesc> it = reqNodeDescList.iterator();it.hasNext();){
			getiContractManagerServ().addNodeDesc(it.next());
		}
		for(Iterator<NodeDesc> it = rspNodeDescList.iterator();it.hasNext();){
			getiContractManagerServ().addNodeDesc(it.next());
		}
		return SUCCESS;
	}
	
	public List<NodeDesc> jsonToList(String jsonString,int tcpCtrFId){
		List<NodeDesc> nodeDescList = new ArrayList<NodeDesc>();
		JSONArray jsonarray = JSONArray.fromObject(jsonString);
		for(int i=0;i<jsonarray.size();i++){
	         JSONArray jsoncol = JSONArray.fromObject(jsonarray.get(i));
	         NodeDesc nodeDesc = new NodeDesc();
	         nodeDesc.setNodeName(jsoncol.getString(0));
	         nodeDesc.setNodePath(jsoncol.getString(1));
	         nodeDesc.setNodeType(jsoncol.getString(2));
	         nodeDesc.setNevlConsType(jsoncol.getString(3));
	         nodeDesc.setNevlConsValue(jsoncol.getString(4));   
	         nodeDesc.setTcpCtrFId(tcpCtrFId);
	         nodeDescList.add(nodeDesc);
	    }
		return nodeDescList;
	}
	

}
