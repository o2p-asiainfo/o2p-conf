package com.ailk.eaap.op2.conf.contract.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;



import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.Contract2AttrSpec;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.Template;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.ailk.eaap.op2.common.EAAPErrorCodeDef;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.common.EAAPTags;
import com.ailk.eaap.op2.conf.operatorlog.action.ContractNodeFuzzy;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.dao.SqlMapDAO;


public class ContractDao implements IContractDao {
	
	private Logger log = Logger.getLog(this.getClass());
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> getBaseContractList(Map map) throws EAAPException {
		List<Map<String, String>> baseContractList;
		try {
			baseContractList = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getBaseContract",map);
		} catch (Exception e) {
			throw new EAAPException(EAAPTags.SEG_PROVAPP_SIGN, EAAPErrorCodeDef.WRITE_QUEUE_ERR_9012,
				      new Timestamp(System.currentTimeMillis()) + "  Get BASE_CONTRACT_ID to Errors", e);
		}
		return baseContractList;
	}

	@SuppressWarnings("unchecked")
	public Integer searchContractListSum(Map map) throws EAAPException {
		// TODO Auto-generated method stub
		Integer num = 0;
		num = (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.countContractSum",map);
		return num;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchContractList(Map map)
			throws EAAPException {
		// TODO Auto-generated method stub
		List<Map<String, Object>> contractList = new ArrayList();		
		contractList = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.countContract",map);
		return contractList;
	}

	public Integer addContract(Contract contract) throws EAAPException {
		// TODO Auto-generated method stub
		Integer id = null;
		id = (Integer) sqlMapDao.insert("provide.insertContract",contract);
		return id;
	}

	public Integer editContract(Contract contract) {
		// TODO Auto-generated method stub
		sqlMapDao.update("provide.updateContract", contract);
		return contract.getContractId();
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> getContractDoc(Map map) throws EAAPException {
		// TODO Auto-generated method stub
		List<Map<String, String>> docList = new ArrayList();		
		docList = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getContractDoc",map);
		return docList;
	}
	
	public ContractDoc returnContractDoc(ContractDoc doc) throws EAAPException {
		// TODO Auto-generated method stub
		try {
			ContractDoc cDoc = new 	ContractDoc();
			cDoc = (ContractDoc) sqlMapDao.queryForObject("provide.selectContractDoc",doc);
			return cDoc;
		} catch (Exception e) {
			log.error("selectContractDoc", e);
		}
		return null;
	}

	public Contract findContract(Contract contract) throws EAAPException {
		// TODO Auto-generated method stub
		try{
			Contract ct = new Contract();
			ct = (Contract) sqlMapDao.queryForObject("provide.selectContract", contract);
			return ct;
		}catch(Exception e){
			log.error("selectContract", e);
		}
		return null;
		
	}
	
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "main_data", columnNames = "CEP_NAME", idName = "MAINDID", propertyNames = "CEPNAME") 
		}
	)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectConType(Map map) {
		// TODO Auto-generated method stub
		List<Map<String, Object>> conTypeList = new ArrayList();
		try {
			conTypeList = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.selectConType",map);
		} catch (Exception e) {
			log.error("selectConType", e);
		}
		return conTypeList;
	}

	public Integer addContractVersion(ContractVersion contractVersion)
	throws EAAPException {
		// TODO Auto-generated method stub
		Integer contractVersionId = null;
		try {
			contractVersionId = (Integer) sqlMapDao.insert("provide.insertContractVersion",contractVersion);			
		} catch (Exception e) {
			log.error("insertContractVersion", e);
		}
		return contractVersionId;
	}
	
	public Integer addContractFormat(ContractFormat contractFormat)
		throws EAAPException {
			// TODO Auto-generated method stub
			Integer contractFormatId = null;
			try {
				contractFormat.setXsdDemo(contractFormat.getXsdFormat());
				contractFormatId = (Integer) sqlMapDao.insert("provide.insertContractFormat",contractFormat);			
			} catch (Exception e) {
				log.error("insertContractFormat", e);
			}
			return contractFormatId;	
		}

	public Integer addNodeDesc(NodeDesc nodeDesc) {
		// TODO Auto-generated method stub
		Integer nodeDescId = null;
		try {
			nodeDescId = (Integer) sqlMapDao.insert("provide.insertNodeDesc",nodeDesc);			
		} catch (Exception e) {
			log.error("insertNodeDesc", e);
		}
		return nodeDescId;
	}

	public ContractVersion findContractVersion(ContractVersion contractVersion)
			throws EAAPException {
		// TODO Auto-generated method stub
		try{
			ContractVersion cv = (ContractVersion) sqlMapDao.queryForObject("provide.selectContractVersion", contractVersion);
			return cv;
		}catch(Exception e){
			log.error("selectContractVersion", e);
		}
		
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> findContractFormat(Map map) {
		// TODO Auto-generated method stub
		try {
			List<Map<String, String>> contractFormatList;
			contractFormatList = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.contractFormatList", map);
			return contractFormatList;
		} catch (Exception e) {
			log.error("contractFormatList", e);
		}
		return null;
		
	}

	public void addDocContract(DocContract doc) throws EAAPException {
		// TODO Auto-generated method stub
		sqlMapDao.insert("provide.insertDocContract", doc);
	}

	public Integer editContractFormat(ContractFormat contractFormat) {
		// TODO Auto-generated method stub
		contractFormat.setXsdDemo(contractFormat.getXsdFormat());
		Integer it = sqlMapDao.update("provide.updateContractFormat", contractFormat);
		return it;
	}

	public Integer editContractVersion(ContractVersion contractVersion) {
		// TODO Auto-generated method stub
		Integer it = sqlMapDao.update("eaap-op2-conf-contract-prov.updateContractVersion", contractVersion);
		return it;
	}

	public Integer editDocContract(DocContract docContract) {
		// TODO Auto-generated method stub
		Integer it = sqlMapDao.update("provide.updateDocContract", docContract);
		return it;
	}

	public DocContract queryDocContract(DocContract docContract) {
		// TODO Auto-generated method stub
		try{
			DocContract doc = (DocContract) sqlMapDao.queryForObject("provide.selectDocContract", docContract);
			return doc;
		}catch(Exception e){
			log.error("selectDocContract", e);
		}
		return null;
		
		
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> queryNodeDesc(Map map) {
		// TODO Auto-generated method stub
		try {
			List<Map<String, String>> nodeDescList = null;
			nodeDescList = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.selectNodeDesc", map);
			return nodeDescList;
		} catch (Exception e) {
			log.error("selectNodeDesc", e);
		}
		return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map> selectContractList(Map map) {
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-contract-prov.countContractSum",map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-contract-prov.countContract", map) ;
		}
		
     }

	public List<Map> queryContractList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-contract-prov.queryContractList",map) ;
	}
	
	public void deleteNodeDescInfo(Map map) {
		// TODO Auto-generated method stub
		sqlMapDao.delete("eaap-op2-conf-contract-prov.deleteNodeDescInfo", map);
	}

	public Integer searchContractVersionListSum(Map map) throws EAAPException {
		// TODO Auto-generated method stub
		Integer num = 0;
		num = (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.countContractVersionSum",map);
		return num;
	}

	public List<Map> selectContractVersionList(Map map) {
		// TODO Auto-generated method stub
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-contract-prov.countContractVersion", map) ;
	}
	/**
	 * 统计协议与对应协议版本总数
	 * @param Map
	 * @return
	 */
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException{
		Integer num = 0;
		num = (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.countContractAndVersionSum",map);
		return num;
	}
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractAndVersionList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-contract-prov.countContractAndVersion", map) ;
	}
	
	public int isExitCode(Map map){
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.isExitCode",map);
	}
	
	public void  updateNodeDesc(NodeDesc nodeDesc){
		sqlMapDao.update("provide.updateNodeDesc", nodeDesc);
	}
	
	public List<Map>  chooseNodeDesc(Map map){
		return (List<Map>) sqlMapDao.queryForList("eaap-op2-conf-contract-prov.chooseNodeDesc", map) ;
	}
	
	public Integer  countChooseNodeDescSum(Map map){
		return (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.countChooseNodeDescSum",map);
	}
	public void delNodeDesc(Map map){
		sqlMapDao.delete("provide.delNodeDesc", map);
		sqlMapDao.update("eaap-op2-conf-contract-prov.updateParentId", map);
	}
	public boolean isExitMapper(Map map) {
		Integer mapperCount = (Integer) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.isExitMapper", map);
		return mapperCount > 0;
	}
	/**
	 * 得到请求的JavaField主数类型
	 * @return
	 */
	@Override
	public List<Map<String,String>> getAllJavaFieldReq(Map map) {
		List<Map<String,String>> list = (List<Map<String,String>>) sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllJavaFieldReq", map) ;
		if(null != list && list.size() > 0){
			return list;
		}
		return null;
	}
	/**
	 * 得到响应的JavaField主数类型
	 * @return
	 */
	@Override
	public List<Map<String,String>> getAllJavaFieldRsp(Map map) {
		List<Map<String,String>> list = (List<Map<String,String>>) sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllJavaFieldRsp", map) ;
		if(null != list && list.size() > 0){
			return list;
		}
		return null;
	}
	/**
	 * 得到协议格式ID
	 * @param contractVersionId
	 * @return
	 */
	@Override
	public String selectContractFormatById(Map<String,String> map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.selectContractFormatById", map);
	}
	/**
     * 由协议格式ID删除节点ID
     * @param tcp_ctr_f_id
     */
	@Override
	public void delNodeDescById(Map map) {
		sqlMapDao.delete("eaap-op2-conf-contract-prov.delNodeDescById", map);
	}

	public List<Map<String, String>> queryAttrDefine_MainDataTypeList(Map map) {
		try {
			List<Map<String, String>> list = null;
			list = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.queryAttrDefine_MainDataTypeList", map);
			return list;
		} catch (Exception e) {
			log.error("queryAttrDefine_MainDataTypeList", e);
		}
		return null;
	}

	public List<Map<String, String>> queryAttrDefine_MainDataList(Map map) {
		List<Map<String, String>> list = null;
		list = sqlMapDao.queryForList("eaap-op2-conf-contract-prov.queryAttrDefine_MainDataList", map);
		return list;
	}
	
	public void deleteContract2AttrSpec(Map map) {
		sqlMapDao.delete("eaap-op2-conf-contract-prov.deleteContract2AttrSpec", map);
	}

	public void saveContract2AttrSpec(Contract2AttrSpec contract2AttrSpec) throws EAAPException {
		sqlMapDao.insert("eaap-op2-conf-contract-prov.saveContract2AttrSpec", contract2AttrSpec);
	}
	/**
	 * 基类协议的协议格式ID
	 * @param tcpCtrFId
	 * @return
	 */
	@Override
	public String getBaseTcpFIdById(Map mapt) {
		List<Map> map =  (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-contract-prov.getBaseTcpFIdById", mapt);
		if(null != map && map.size() >0){
			return map.get(0).get("TCP_CTR_F_ID").toString();
		}
		return null;
	}
	/**
	 * 修改节点信息
	 * @param parentID
	 * @param tcp_ctr_f_id
	 */
	@Override
	public void updateNodeDescById(Integer parentID, String tcp_ctr_f_id) {
		Map map = new HashMap();
		map.put("nodeDescId", parentID);
		map.put("tcp_ctr_f_id", tcp_ctr_f_id);
		sqlMapDao.update("eaap-op2-conf-contract-prov.updateNodeDescById", map);
	}
	/**
	 * 修改节点信息
	 * @param map
	 */
	@Override
	public void updateNodeDescByMap(Map<String, String> map) {
		sqlMapDao.update("eaap-op2-conf-contract-prov.updateNodeDescByMap", map);
	}

	@Override
	public String getNextContractFuzzyId() {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-operatorlog-manage-sqlmap.getNextContractFuzzyId", null);
	}

	@Override
	public void insertContractFuzzy(ContractNodeFuzzy contractNodeFuzzy) {
		sqlMapDao.insert("eaap-op2-conf-operatorlog-manage-sqlmap.insertContractFuzzy", contractNodeFuzzy);
	}

	@Override
	public void updateContractFuzzy(ContractNodeFuzzy contractNodeFuzzy) {
		sqlMapDao.update("eaap-op2-conf-operatorlog-manage-sqlmap.updateContractFuzzy", contractNodeFuzzy);
	}

	@Override
	public void deleteContractFuzzy(ContractNodeFuzzy contractNodeFuzzy) {
		sqlMapDao.update("eaap-op2-conf-operatorlog-manage-sqlmap.deleteContractFuzzy", contractNodeFuzzy);
	}

	@Override
	public String getNodeIdByPath(Map<String, String> map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.getNodeIdByPath", map);
	}

	public Template queryTemplate(Template template){
		try {
			Template retTemplate= (Template) sqlMapDao.queryForObject("eaap-op2-conf-contract-prov.queryTemplate", template);
			return retTemplate;
		} catch (Exception e) {
			log.error("queryTemplate", e);
		}
		return null;
	}
	public void  insertTemplate(Template template){
		sqlMapDao.insert("eaap-op2-conf-contract-prov.insertTemplate", template);
	}
	public void  deleteTemplate(Template template){
		sqlMapDao.delete("eaap-op2-conf-contract-prov.deleteTemplate", template);
	}

	@Override
	public void delNodeMaper(Map map) {
		// TODO Auto-generated method stub
		sqlMapDao.delete("eaap-op2-conf-contract-prov.delNodeDescMaperById", map);
	}
	
}

