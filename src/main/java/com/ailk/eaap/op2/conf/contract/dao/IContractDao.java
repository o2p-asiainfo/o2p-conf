package com.ailk.eaap.op2.conf.contract.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.Contract2AttrSpec;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.Template;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.conf.operatorlog.action.ContractNodeFuzzy;


public interface IContractDao{
	/**
	 * 获取协议基类
	 * @param null
	 * @return
	 */
	public List<Map<String, String>>  getBaseContractList (Map map)throws EAAPException;
	
	/**
	 * 展现协议内容
	 * @param Map
	 * @return
	 */
	public List<Map<String, Object>>  searchContractList (Map map)throws EAAPException;
	
	/**
	 * 统计协议总数
	 * @param Map
	 * @return
	 */
	public Integer  searchContractListSum (Map map)throws EAAPException;
	
	/**
	 * 统计协议版本总数
	 * @param Map
	 * @return
	 */
	public Integer  searchContractVersionListSum (Map map)throws EAAPException;
	
	/**
	 * 修改/删除协议规格
	 * @param Contract
	 * @return
	 */
	public Integer editContract(Contract contract)throws EAAPException;
	
	/**
	 * 添加协议规格
	 * @param Contract
	 * @return Integer
	 */
	public Integer addContract(Contract contract)throws EAAPException;	
	
	/**
	 * 添加文档版本
	 * @param DocContract
	 * @return 
	 */
	public void addDocContract(DocContract doc)throws EAAPException;	
	
	/**
	 * 获取协议文档
	 * @param null
	 * @return List
	 */
	public List<Map<String, String>>  getContractDoc (Map map)throws EAAPException;
	
	/**
	 * 查询协议
	 * @param Contract
	 * @return Contract
	 */
	public Contract findContract (Contract contract)throws EAAPException;
	
	/**
	 * 查询协议版本
	 * @param ContractVersion
	 * @return ContractVersion
	 */
	public ContractVersion findContractVersion (ContractVersion contractVersion)throws EAAPException;
	
	/**
	 * 协议请求格式
	 * @param String
	 * @return List
	 */
	public List<Map<String, Object>>  selectConType(Map map);
	
	/**
	 * 添加协议版本
	 * @param ContractVersion
	 * @return Integer
	 */
	public Integer addContractVersion (ContractVersion contractVersion)throws EAAPException;
	
	/**
	 * 添加协议格式
	 * @param CONTRACT_FORMAT
	 * @return contractId
	 */
	public Integer addContractFormat (ContractFormat contractFormat)throws EAAPException;
	
	/**
	 * 添加节点描述
	 * @param NodeDesc
	 * @return NodeDesc
	 */
	public Integer addNodeDesc (NodeDesc nodeDesc);
	
	/**
	 * 协议格式
	 * @param Map
	 * @return List
	 */
	public List<Map<String, String>> findContractFormat(Map map);
	
	/**
	 * 修改协议格式
	 * @param ContractFormat
	 * @return
	 */
	public Integer editContractFormat(ContractFormat contractFormat);
	
	/**
	 * 修改协议版本
	 * @param ContractVersion
	 * @return Integer
	 */
	public Integer editContractVersion(ContractVersion contractVersion);
	
	/**
	 * 修改文档格式
	 * @param ContractVersion
	 * @return Integer
	 */
	public Integer editDocContract(DocContract docContract);
	
	/**
	 * 查询文档格式
	 * @param DocContract
	 * @return DocContract
	 */
	public DocContract queryDocContract(DocContract docContract);
	
	/**
	 * 查询节点信息
	 * @param DocContract
	 * @return DocContract
	 */
	public List<Map<String, String>> queryNodeDesc(Map map);
	/**
	 * 统计协议信息
	 * @param 
	 * @return 
	 */
	public List<Map> selectContractList(Map map);
	/**
	 * 统计协议版本信息
	 * @param 
	 * @return 
	 */
	public List<Map> selectContractVersionList(Map map);
	
	/**
	 * 删除节点信息
	 * @param Integer
	 * @return 
	 */
	public void deleteNodeDescInfo(Map map);
	
	public ContractDoc returnContractDoc(ContractDoc doc) throws EAAPException;
	public List<Map> queryContractList(Map map);
	/**
	 * 统计协议与对应协议版本总数
	 * @param Map
	 * @return
	 */
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException;
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractAndVersionList(Map map);
	
	
	public int isExitCode(Map map);
	
	public void  updateNodeDesc(NodeDesc nodeDesc);
	
	public List<Map>  chooseNodeDesc(Map map);
	public Integer  countChooseNodeDescSum(Map map);
	public void delNodeDesc(Map map);
	
	/**
	 * 得到请求的JavaField主数类型
	 * @return
	 */
	public List<Map<String,String>> getAllJavaFieldReq(Map map);
	/**
	 * 得到响应的JavaField主数类型
	 * @return
	 */
	public List<Map<String,String>> getAllJavaFieldRsp(Map map);

	/**
	 * 得到协议格式ID
	 * @param contractVersionId
	 * @return
	 */
	public String selectContractFormatById(Map<String,String> map);
    /**
     * 由协议格式ID删除节点ID
     * @param tcp_ctr_f_id
     */
	public void delNodeDescById(Map map);
	
	public void delNodeMaper(Map map);

	public List<Map<String, String>> queryAttrDefine_MainDataTypeList(Map map);
	public List<Map<String, String>> queryAttrDefine_MainDataList(Map map);
	public void deleteContract2AttrSpec(Map map);
	public void saveContract2AttrSpec(Contract2AttrSpec contract2AttrSpec);

	/**
	 * 基类协议的协议格式ID
	 * @param tcpCtrFId
	 * @return
	 */
	public String getBaseTcpFIdById(Map map);
	/**
	 * 修改节点信息
	 * @param parentID
	 * @param tcp_ctr_f_id
	 */
	public void updateNodeDescById(Integer parentID, String tcp_ctr_f_id);
	/**
	 * 修改节点信息
	 * @param map
	 */
	public void updateNodeDescByMap(Map<String, String> map);

	public String getNextContractFuzzyId();

	public void insertContractFuzzy(ContractNodeFuzzy contractNodeFuzzy);

	public void updateContractFuzzy(ContractNodeFuzzy contractNodeFuzzy);

	public void deleteContractFuzzy(ContractNodeFuzzy contractNodeFuzzy);

	public String getNodeIdByPath(Map<String, String> map);

	public Template queryTemplate(Template template);
	public void  insertTemplate(Template template);
	public void  deleteTemplate(Template template);

	public boolean isExitMapper(Map map);
}
