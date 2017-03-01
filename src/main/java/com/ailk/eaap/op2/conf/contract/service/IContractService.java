package com.ailk.eaap.op2.conf.contract.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractDefined;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.Template;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.conf.operatorlog.action.ContractNodeFuzzy;

import net.sf.json.JSONArray;

public interface IContractService {
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
	 * 修改/删除协议规格
	 * @param Contract
	 * @return
	 */
	public Integer editContract(Contract contract)throws EAAPException;
	
	/**
	 * 添加协议规格
	 * @param Contract
	 * @return String
	 */
	public Integer addContract (Contract contract)throws EAAPException;
	
	/**
	 * 获取协议文档
	 * @param null
	 * @return
	 */
	public List<Map<String, String>>  getContractDoc (Map map)throws EAAPException;
	
	/**
	 * 查询协议
	 * @param null
	 * @return
	 */
	public Contract findContract (Contract contract)throws EAAPException;
	
	/**
	 * 协议格式类型
	 * @param null
	 * @return
	 */
	public List<Map<String, Object>> selectConType(String mdtCd);
	
	/**
	 * 添加协议服务管理
	 * @param null
	 * @return
	 */
	public Integer  addContractDefined(ContractDefined contractDefined);
	/**
	 * 修改协议服务管理
	 * @param null
	 * @return
	 */
	public void  editContractDefined(ContractDefined contractDefined);
	
	public void  editContractDefinedContext(ContractDefined contractDefined);
	/**
	 * 查询协议版本
	 * @param ContractVersion
	 * @return ContractVersion
	 */
	public ContractVersion findContractVersion (ContractVersion contractVersion)throws EAAPException;
	
	/**
	 * 协议格式
	 * @param ContractFormat
	 * @return ContractFormat
	 */
	public ContractFormat findContractFormat(ContractFormat contractFormat);
	
	/**
	 * 查询文档格式
	 * @param DocContract
	 * @return DocContract
	 */
	public DocContract queryDocContract(DocContract docContract);
	/**
	 * 查询节点信息
	 * @param String
	 * @return List
	 */
	public List<Map<String, String>> queryNodeDesc(String tcpCtrFId);
		
	public List<Map> selectContractList(Map map);
	public List<Map> queryContractList(Map map);
	public ContractDoc returnContractDoc(ContractDoc doc)throws EAAPException;
	
	/**
	 * 统计协议版本总数
	 * @param Map
	 * @return
	 */
	public Integer  searchContractVersionListSum (Map map)throws EAAPException;
	/**
	 * 统计协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractVersionList(Map map);
	
	/**
	 * 修改/删除协议版本
	 * @param ContractVersion
	 * @return
	 */
	public void editContractVersion(ContractVersion contractVersion)throws EAAPException;
	/**
	 * 统计协议与对应协议版本数目
	 * @param map
	 * @return
	 * @throws EAAPException
	 */
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException;
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractAndVersionList(Map map);
	
	public int isExitCode(Map map);
	
	/**
	 * 增加协议格式
	 * @param Map
	 * @return
	 */
	public Integer  addContractFormat(ContractFormat contractFormat);
	/**
	 * 增加节点描述
	 * @param Map
	 * @return
	 */
	public Integer  addNodeDesc(NodeDesc nodeDesc);
	/**
	 * 修改节点描述
	 * @param Map
	 * @return
	 */
	public void  updateNodeDesc(NodeDesc nodeDesc);
	/**
	 * 选择父节点列表
	 * @param Map
	 * @return
	 */
	public List<Map>  chooseNodeDesc(Map map);
	public Integer  countChooseNodeDescSum(Map map);
	/**
	 * 删除节点
	 * @param Map
	 * @return
	 */
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
	public String selectContractFormatById(Map<String,String>  map);
    /**
     * 由协议格式ID删除节点ID
     * @param tcp_ctr_f_id
     */
	public void delNodeDescById(Map map);

	/**
	 * 修改协议格式
	 * @param contractFormat
	 */
	public void editContractFormat(ContractFormat contractFormat);
	
	public JSONArray getContractAttrSpecList(String tcpCtrFId, String mdtCd);
	
	public void editContractAttrSpec(String contractAttrSpec);

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

	public String getNodeIdByPath(String nodePath, Integer tcpCtrFId);
	
	public Template queryTemplate(Template template);

	public boolean isExitMapper(Map map);
}
