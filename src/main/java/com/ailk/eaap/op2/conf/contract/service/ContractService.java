package com.ailk.eaap.op2.conf.contract.service;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractDefined;
import com.ailk.eaap.op2.bo.ContractDoc;
import com.ailk.eaap.op2.bo.ContractFormat;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.DocContract;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.Template;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.common.EAAPException;
import com.ailk.eaap.op2.conf.contract.dao.IContractDao;
import com.ailk.eaap.op2.conf.operatorlog.action.ContractNodeFuzzy;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.ailk.eaap.op2.bo.Contract2AttrSpec;;

public class ContractService implements IContractService {

	
	private IContractDao contractDao;

	public IContractDao getContractDao() {
		return contractDao;
	}

	public void setContractDao(IContractDao contractDao) {
		this.contractDao = contractDao;
	}

	public List<Map<String, String>> getBaseContractList(Map map)
			throws EAAPException {
		List<Map<String, String>> baseContractList;
		baseContractList = contractDao.getBaseContractList(map);
		return baseContractList;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchContractList(Map map)
			throws EAAPException {
		List<Map<String, Object>> contractList= new ArrayList();
		contractList = contractDao.searchContractList(map);
		return contractList;
	}

	public Integer searchContractListSum(Map map) throws EAAPException {
		Integer num = contractDao.searchContractListSum(map);
		return num;
	}

	public Integer addContract(Contract contract) throws EAAPException {
		Integer id = contractDao.addContract(contract);
		return id;
	}

	public Integer editContract(Contract contract) throws EAAPException {
		return contractDao.editContract(contract);
	}

	public List<Map<String, String>> getContractDoc(Map map) throws EAAPException {
		List<Map<String, String>> docList= new ArrayList<Map<String, String>>();
		docList = contractDao.getContractDoc(map);
		return docList;
	}

	public Contract findContract(Contract contract) throws EAAPException {
		Contract ct = new Contract();
		ct = contractDao.findContract(contract);
		return ct;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectConType(String mdtCd) {
		List<Map<String, Object>> conTypeList = new ArrayList();
		Map mapTemp = new HashMap();  
		mapTemp.put("mdtCd", mdtCd);
		conTypeList = contractDao.selectConType(mapTemp);
		return conTypeList;
	}

	public Integer addContractDefined(ContractDefined contractDefined) {
		Integer versionId = null;
		Integer cFormatId = null;
		//添加协议版本信息
		ContractVersion contractVersion = new ContractVersion();
		contractVersion.setContractId(contractDefined.getContractId().toString());
		contractVersion.setVersion(contractDefined.getVersion());
		contractVersion.setDescriptor(contractDefined.getContractVersionDescriptor());
		contractVersion.setState(EAAPConstants.COMM_STATE_VALID);
		contractVersion.setIsNeedCheck(contractDefined.getIsNeedCheckVersion());
		
		versionId = contractDao.addContractVersion(contractVersion);

		
		if(versionId!= null && versionId>0){
			//添加文档版本
			if(contractDefined.getContractDocId() != null && contractDefined.getContractDocId()>0){
				DocContract doc = new DocContract();
				doc.setContractVersionId(versionId);
				doc.setDescriptor(contractDefined.getDocContractDescriptor());
				doc.setContractDocId(contractDefined.getContractDocId());
				contractDao.addDocContract(doc);
			}
			
			//添加协议格式请求信息
			ContractFormat contractFormat = new ContractFormat();
			contractFormat.setContractVersionId(versionId);
			contractFormat.setConType(contractDefined.getReqConType());
			contractFormat.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
			contractFormat.setXsdHeaderFor(contractDefined.getReqXsdHeaderFor());
			contractFormat.setXsdFormat(contractDefined.getReqXsdFormat());
			contractFormat.setDescriptor(contractDefined.getReqDescriptor());
			contractFormat.setState(EAAPConstants.COMM_STATE_VALID);			
			cFormatId = contractDao.addContractFormat(contractFormat);
			//添加协议格式请求节点信息			
			NodeDesc nodeDesc = new NodeDesc();
			if(cFormatId != null){
					if(contractDefined.getReqNodeDescName()!= null){
						for(int i=0;i<contractDefined.getReqNodeDescName().length;i++){
							nodeDesc.setNodeName(contractDefined.getReqNodeDescName()[i]);
							nodeDesc.setNodePath(contractDefined.getReqNodePath()[i]);
							nodeDesc.setNodeType(contractDefined.getReqNodeType()[i]);
							nodeDesc.setNevlConsType(contractDefined.getReqNevlConsType()[i]);
							nodeDesc.setNevlConsValue(contractDefined.getReqNevlConsValue()[i]);
							nodeDesc.setTcpCtrFId(cFormatId);
							nodeDesc.setState(EAAPConstants.COMM_STATE_VALID);
							nodeDesc.setNodeLengthCons(contractDefined.getReqNodeLengthCons()[i]);
							nodeDesc.setNodeNumberCons(contractDefined.getReqNodeNumberCons()[i]);
							nodeDesc.setNodeTypeCons(contractDefined.getReqNodeTypeCons()[i]);
							nodeDesc.setIsNeedCheck(contractDefined.getReqIsNeedCheck()[i]);
							nodeDesc.setIsNeedSign(contractDefined.getReqIsNeedSign()[i]);
							contractDao.addNodeDesc(nodeDesc);
						}	
					}					
			}
			
			//添加协议格式响应信息
			ContractFormat cf = new ContractFormat();
			cf.setContractVersionId(versionId);
			cf.setConType(contractDefined.getRspConType());
			cf.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
			cf.setXsdHeaderFor(contractDefined.getRspXsdHeaderFor());
			cf.setXsdFormat(contractDefined.getRspXsdFormat());
			cf.setDescriptor(contractDefined.getRspDescriptor());
			cf.setState(EAAPConstants.COMM_STATE_VALID);
			cFormatId = contractDao.addContractFormat(cf);		
			//添加协议格式响应节点信息
			NodeDesc nd = new NodeDesc();
			if(cFormatId != null){
				if(contractDefined.getRspNodeDescName()!= null){
					for(int i=0;i<contractDefined.getRspNodeDescName().length;i++){
						nd.setNodeName(contractDefined.getRspNodeDescName()[i]);
						nd.setNodePath(contractDefined.getRspNodePath()[i]);
						nd.setNodeType(contractDefined.getRspNodeType()[i]);
						nd.setNevlConsType(contractDefined.getRspNevlConsType()[i]);
						nd.setNevlConsValue(contractDefined.getRspNevlConsValue()[i]);
						nd.setTcpCtrFId(cFormatId);
						nd.setState(EAAPConstants.COMM_STATE_VALID);
						nd.setNodeLengthCons(contractDefined.getRspNodeLengthCons()[i]);
						nd.setNodeNumberCons(contractDefined.getRspNodeNumberCons()[i]);
						nd.setNodeTypeCons(contractDefined.getRspNodeTypeCons()[i]);
						nd.setIsNeedCheck(contractDefined.getRspIsNeedCheck()[i]);
						nd.setIsNeedSign(contractDefined.getRspIsNeedSign()[i]);
						contractDao.addNodeDesc(nd);
					}	
				}
			}
		}
		
		return versionId;
	}

	public void editContractDefined(ContractDefined contractDefined) {
		//更新协议版本
		ContractVersion cv = new ContractVersion();
		if(contractDefined.getContractVersionId()!= null){
			cv.setContractVersionId(Integer.valueOf(contractDefined.getContractVersionId()));
			cv.setIsNeedCheck(contractDefined.getIsNeedCheckVersion());
			cv.setDescriptor(contractDefined.getContractVersionDescriptor());
			cv.setVersion(contractDefined.getVersion());
			contractDao.editContractVersion(cv);
		}
		
		//更新协议文档
		DocContract doc = new DocContract();
		if(contractDefined.getContractDocId()!= null){
			doc.setContractDocId(contractDefined.getContractDocId());
			doc.setDocContrId(contractDefined.getDocContrId());
			doc.setDescriptor(contractDefined.getDocContractDescriptor());
			if(doc.getDocContrId()!=null){
				contractDao.editDocContract(doc);
			}
			else{
				if(contractDefined.getContractVersionId()!= null){
					doc.setContractVersionId(contractDefined.getContractVersionId());
					contractDao.addDocContract(doc);
				}	
			}
		}
		
		//更新请求协议格式
		ContractFormat req = new ContractFormat();
		if(contractDefined.getReqContractFormatId()!= null){
			req.setTcpCtrFId(contractDefined.getReqContractFormatId());
			req.setConType(contractDefined.getReqConType());
			req.setXsdHeaderFor(contractDefined.getReqXsdHeaderFor());
			req.setXsdFormat(contractDefined.getReqXsdFormat());
			req.setDescriptor(contractDefined.getReqDescriptor());
			req.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
			contractDao.editContractFormat(req);
		}
		
		//更新请求节点格式
		//先删除再更新，更新也就是重新添加。		
		NodeDesc nodeDesc = new NodeDesc();
		if(contractDefined.getReqNodeDescName()!= null){
			if(contractDefined.getReqContractFormatId()!= null){
				Map mapTemp = new HashMap();  
				mapTemp.put("tcpCtrFId", contractDefined.getReqContractFormatId());
				contractDao.deleteNodeDescInfo(mapTemp);
			}
			for(int i=0;i<contractDefined.getReqNodeDescName().length;i++){
				nodeDesc.setNodeName(contractDefined.getReqNodeDescName()[i]);
				nodeDesc.setNodePath(contractDefined.getReqNodePath()[i]);
				nodeDesc.setNodeType(contractDefined.getReqNodeType()[i]);
				nodeDesc.setNevlConsType(contractDefined.getReqNevlConsType()[i]);
				nodeDesc.setNevlConsValue(contractDefined.getReqNevlConsValue()[i]);
				nodeDesc.setTcpCtrFId(contractDefined.getReqContractFormatId());
				nodeDesc.setState(EAAPConstants.COMM_STATE_VALID);
				nodeDesc.setNodeLengthCons(contractDefined.getReqNodeLengthCons()[i]);
				nodeDesc.setNodeNumberCons(contractDefined.getReqNodeNumberCons()[i]);
				nodeDesc.setNodeTypeCons(contractDefined.getReqNodeTypeCons()[i]);
				nodeDesc.setIsNeedCheck(contractDefined.getReqIsNeedCheck()[i]);
				nodeDesc.setIsNeedSign(contractDefined.getReqIsNeedSign()[i]);
				contractDao.addNodeDesc(nodeDesc);
			}						
	   }
		
		//更新响应协议格式
		ContractFormat rsp = new ContractFormat();
		if(contractDefined.getRspContractFormatId()!= null){
			rsp.setTcpCtrFId(contractDefined.getRspContractFormatId());
			rsp.setConType(contractDefined.getRspConType());
			rsp.setXsdHeaderFor(contractDefined.getRspXsdHeaderFor());
			rsp.setXsdFormat(contractDefined.getRspXsdFormat());
			rsp.setDescriptor(contractDefined.getRspDescriptor());
			rsp.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
			contractDao.editContractFormat(rsp);
		}
		//更新响应节点格式
		//先删除再更新，更新也就是重新添加,如果等于空的话，也是可以添加数据的。
		NodeDesc nd = new NodeDesc();	
		if(contractDefined.getRspNodeDescName()!= null){
			if(contractDefined.getRspContractFormatId() != null){
				Map mapTemp = new HashMap();  
				mapTemp.put("tcpCtrFId", contractDefined.getRspContractFormatId());
				contractDao.deleteNodeDescInfo(mapTemp);
			}			
			for(int i=0;i<contractDefined.getRspNodeDescName().length;i++){
				nd.setNodeName(contractDefined.getRspNodeDescName()[i]);
				nd.setNodePath(contractDefined.getRspNodePath()[i]);
				nd.setNodeType(contractDefined.getRspNodeType()[i]);
				nd.setNevlConsType(contractDefined.getRspNevlConsType()[i]);
				nd.setNevlConsValue(contractDefined.getRspNevlConsValue()[i]);
				nd.setTcpCtrFId(contractDefined.getRspContractFormatId());
				nd.setState(EAAPConstants.COMM_STATE_VALID);
				nd.setNodeLengthCons(contractDefined.getRspNodeLengthCons()[i]);
				nd.setNodeNumberCons(contractDefined.getRspNodeNumberCons()[i]);
				nd.setNodeTypeCons(contractDefined.getRspNodeTypeCons()[i]);
				nd.setIsNeedCheck(contractDefined.getRspIsNeedCheck()[i]);
				nd.setIsNeedSign(contractDefined.getRspIsNeedSign()[i]);
				contractDao.addNodeDesc(nd);
			}	
		}
	}
	
	public void editContractDefinedContext(ContractDefined contractDefined) {
		
		//更新协议文档
		DocContract doc = new DocContract();
		if(contractDefined.getContractDocId()!= null){
			doc.setContractDocId(contractDefined.getContractDocId());
			doc.setDocContrId(contractDefined.getDocContrId());
			doc.setDescriptor(contractDefined.getDocContractDescriptor());
			if(doc.getDocContrId()!=null){
				contractDao.editDocContract(doc);
			}
			else{
				if(contractDefined.getContractVersionId()!= null){
					doc.setContractVersionId(contractDefined.getContractVersionId());
					contractDao.addDocContract(doc);
				}
			}
		}
		
		//更新请求协议格式
		ContractFormat req = new ContractFormat();
		if(contractDefined.getReqContractFormatId()!= null){
			req.setTcpCtrFId(contractDefined.getReqContractFormatId());
			req.setConType(contractDefined.getReqConType());
			req.setXsdHeaderFor(contractDefined.getReqXsdHeaderFor());
			req.setXsdFormat(contractDefined.getReqXsdFormat());
			req.setDescriptor(contractDefined.getReqDescriptor());
			req.setReqRsp(EAAPConstants.CONTRACT_FORMAT_REQ);
			contractDao.editContractFormat(req);
		}

		
		//更新响应协议格式
		ContractFormat rsp = new ContractFormat();
		if(contractDefined.getRspContractFormatId()!= null){
			rsp.setTcpCtrFId(contractDefined.getRspContractFormatId());
			rsp.setConType(contractDefined.getRspConType());
			rsp.setXsdHeaderFor(contractDefined.getRspXsdHeaderFor());
			rsp.setXsdFormat(contractDefined.getRspXsdFormat());
			rsp.setDescriptor(contractDefined.getRspDescriptor());
			rsp.setXsdException(contractDefined.getRspXsdException());
			rsp.setReqRsp(EAAPConstants.CONTRACT_FORMAT_RSP);
			contractDao.editContractFormat(rsp);
			
			Template template = new Template();
			template.setTcpCtrFId(contractDefined.getRspContractFormatId());
			contractDao.deleteTemplate(template);
			if(contractDefined.getTemplateDefMode().equals("0")){
				template.setTemplateHeader(contractDefined.getTemplateHeader());
				template.setTemplateBody(contractDefined.getTemplateBody());
				template.setTemplateType("0");	//0:异常模板
				template.setIsGlobal("1");				//1:接口模板, 0:全局模板
				contractDao.insertTemplate(template);
			}
		}
	}

	public ContractVersion findContractVersion(ContractVersion contractVersion)
			throws EAAPException {
		ContractVersion cv = contractDao.findContractVersion(contractVersion);
		return cv;
	}

	@SuppressWarnings("unchecked")
	public ContractFormat findContractFormat(ContractFormat contractFormat) {
		ContractFormat cf = new ContractFormat();
		Map<String, Comparable> map = new HashMap();
		map.put("versionId", contractFormat.getContractVersionId());
		map.put("reqRsp", contractFormat.getReqRsp());
		 List<Map<String, String>> list = contractDao.findContractFormat(map);
		 for(Map<String, String> items : list){			 
			 cf.setTcpCtrFId(new Integer(items.get("TCPCTRFID")));
			 cf.setConType(items.get("CONTYPE"));
			 cf.setXsdFormat(items.get("XSDFORMAT"));
			 cf.setXsdHeaderFor(items.get("XSDHEADERFOR"));
			 cf.setDescriptor(items.get("DESCRIPTOR"));
			 cf.setXsdException(items.get("XSDEXCEPTION"));
			}
		return cf;
	}

	public DocContract queryDocContract(DocContract docContract) {
		DocContract doc = contractDao.queryDocContract(docContract);
		return doc;
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> queryNodeDesc(String tcpCtrFId) {
		List<Map<String, String>> nodeDescList = null;
		Map map = new HashMap();
		map.put("tcpCtrFId", tcpCtrFId);
		map.put("state", EAAPConstants.COMM_STATE_VALID);
		nodeDescList = contractDao.queryNodeDesc(map);	
		return nodeDescList;
	}
	
	public List<Map> selectContractList(Map map){
		return contractDao.selectContractList(map);
	}

	public ContractDoc returnContractDoc(ContractDoc doc) throws EAAPException{
		return contractDao.returnContractDoc(doc);		
	}

	public List<Map> queryContractList(Map map){
		return contractDao.queryContractList(map);
	}
	
	public Integer searchContractVersionListSum(Map map) throws EAAPException {
		Integer num = contractDao.searchContractVersionListSum(map);
		return num;
	}

	public List<Map> selectContractVersionList(Map map) {
		return contractDao.selectContractVersionList(map);
	}

	public void editContractVersion(ContractVersion contractVersion)
			throws EAAPException {
		if(contractVersion.getContractVersionId()!= null){
			contractDao.editContractVersion(contractVersion);
		}
	}
	public Integer  searchContractAndVersionListSum (Map map)throws EAAPException{
		Integer num = contractDao.searchContractAndVersionListSum(map);
		return num;
	}
	/**
	 * 统计协议与对应协议版本
	 * @param Map
	 * @return
	 */
	public List<Map> selectContractAndVersionList(Map map){
		return contractDao.selectContractAndVersionList(map);
	}
	
	public int isExitCode(Map map){
		return contractDao.isExitCode(map);
	}
	
	public Integer  addContractFormat(ContractFormat contractFormat){
		Integer contractFormatIdInteger = null;
		contractFormatIdInteger = contractDao.addContractFormat(contractFormat);
		return contractFormatIdInteger;
	}
	
	public Integer  addNodeDesc(NodeDesc nodeDesc){
		Integer nodeDescId = contractDao.addNodeDesc(nodeDesc);
		return nodeDescId;
	}
	
	public void  updateNodeDesc(NodeDesc nodeDesc){
		contractDao.updateNodeDesc(nodeDesc);
	}
	
	public List<Map>  chooseNodeDesc(Map map){
		return  contractDao.chooseNodeDesc(map);
	}
	
	public Integer  countChooseNodeDescSum(Map map){
		Integer countNum = contractDao.countChooseNodeDescSum(map);
		return countNum;
	}
	
	public void delNodeDesc(Map map){
		contractDao.delNodeDesc(map);
	}
	
	public boolean isExitMapper(Map map) {
		return contractDao.isExitMapper(map);
	}
	
	/**
	 * 得到请求的JavaField主数类型
	 * @return
	 */
	@Override
	public List<Map<String,String>> getAllJavaFieldReq(Map map) {
		List<Map<String,String>> list = contractDao.getAllJavaFieldReq(map);
		if(null != list && list.size() >0){
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
		List<Map<String,String>> list = contractDao.getAllJavaFieldRsp(map);
		if(null != list && list.size() >0){
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
	public String selectContractFormatById(Map<String,String>  map) {
		return contractDao.selectContractFormatById(map);
	}
	/**
     * 由协议格式ID删除节点ID
     * @param tcp_ctr_f_id
     */
	@Override
	public void delNodeDescById(Map map) {
		contractDao.delNodeMaper(map);
		contractDao.delNodeDescById(map);
	}
	/**
	 * 修改协议格式
	 * @param contractFormat
	 */
	@Override
	public void editContractFormat(ContractFormat contractFormat) {
		contractDao.editContractFormat(contractFormat);
	}


	public JSONArray getContractAttrSpecList(String tcpCtrFId, String mdtCd) {
		JSONArray attrSpecJsonArray = new JSONArray();
		Map tLMap = new HashMap();
		tLMap.put("mdtCd", mdtCd);
		List mdtList = contractDao.queryAttrDefine_MainDataTypeList(tLMap);
		for(int t=0;t<mdtList.size();t++){
            JSONObject tJson = new JSONObject ();
			Map tMap	= (Map)mdtList.get(t);
			String maind_id		= tMap.get("MAIND_ID").toString();
			String cep_name	= tMap.get("CEP_NAME").toString();
			String cep_values	= tMap.get("CEP_VALUES").toString();
			tJson.put("MAIND_ID",maind_id);
			tJson.put("CEP_NAME",cep_name); 
			tJson.put("CEP_VALUES",cep_values); 

			JSONArray mainDataJsonArray = new JSONArray();
			Map dLMap = new HashMap();
			dLMap.put("tcpCtrFId", tcpCtrFId);
			dLMap.put("maindId", maind_id);
			List mdList = contractDao.queryAttrDefine_MainDataList(dLMap);
			for(int n=0;n<mdList.size();n++){
	            JSONObject dJson = new JSONObject ();
				Map dMap	= (Map)mdList.get(n);
				String attr_spec_id			= dMap.get("ATTR_SPEC_ID").toString();
				String attr_spec_name	= dMap.get("ATTR_SPEC_NAME").toString();
				String attr_spec_code		= dMap.get("ATTR_SPEC_CODE").toString();
				String default_value	= CommonUtil.getMapValueToString(dMap, "DEFAULT_VALUE");
				String nullable			= CommonUtil.getMapValueToString(dMap, "NULLABLE");
				String value				= CommonUtil.getMapValueToString(dMap, "VALUE");
				dJson.put("ATTR_SPEC_ID",attr_spec_id);
				dJson.put("ATTR_SPEC_NAME",attr_spec_name);
				dJson.put("ATTR_SPEC_CODE",attr_spec_code);
				dJson.put("DEFAULT_VALUE",default_value);
				dJson.put("NULLABLE",nullable);
				dJson.put("VALUE",value);
				mainDataJsonArray.add(dJson);
			}
			tJson.put("MAIN_DATA",mainDataJsonArray); 
			attrSpecJsonArray.add(tJson);
		}		
		return attrSpecJsonArray;
	}

	public void editContractAttrSpec(String contractAttrSpecStr) {
		JSONArray contractAttrSpecArr = JSONArray.fromObject(contractAttrSpecStr);
		for(int i=0; i<contractAttrSpecArr.size(); i++) {
			JSONObject  contractAttrSpecJson = contractAttrSpecArr.getJSONObject(i);
			String  tcpCtrFId = contractAttrSpecJson.getString("TCP_CTR_F_ID");
			
			JSONArray contractAttrSpecList = contractAttrSpecJson.getJSONArray("CONTRACT_ATTR_SPEC");
			for(int n=0; n<contractAttrSpecList.size(); n++) {
				JSONObject  contractAttrSpec = contractAttrSpecList.getJSONObject(n);
				String  maind_id = contractAttrSpec.getString("MAIND_ID");

				Map<String,String> map=new HashMap<String,String>();
				map.put("tcpCtrFId", tcpCtrFId);
				map.put("maindId", maind_id);
				contractDao.deleteContract2AttrSpec(map);		//删除已有数据
				
				JSONArray specMainDataList = contractAttrSpec.getJSONArray("MAIN_DATA");
				for(int c=0; c<specMainDataList.size();c++) {
					JSONObject  specMainData = specMainDataList.getJSONObject(c);
					String  value 				= specMainData.getString("VALUE");
					String  attrSpecId		= specMainData.getString("ATTR_SPEC_ID");
					Contract2AttrSpec contract2AttrSpec=new Contract2AttrSpec();
					contract2AttrSpec.setTcpCtrFId(Integer.valueOf(tcpCtrFId));
					contract2AttrSpec.setAttrSpecId(Integer.valueOf(attrSpecId));
					contract2AttrSpec.setValue(value);
					contract2AttrSpec.setState("A");
					contractDao.saveContract2AttrSpec(contract2AttrSpec);		//保存数据
				}
			}			
		}
	}
	/**
	 * 基类协议的协议格式ID
	 * @param tcpCtrFId
	 * @return
	 */
	@Override
	public String getBaseTcpFIdById(Map map) {
		return contractDao.getBaseTcpFIdById(map);
	}
	/**
	 * 修改节点信息
	 * @param parentID
	 * @param tcp_ctr_f_id
	 */
	@Override
	public void updateNodeDescById(Integer parentID, String tcp_ctr_f_id) {
		contractDao.updateNodeDescById(parentID,tcp_ctr_f_id);
	}
	/**
	 * 修改节点信息
	 * @param map
	 */
	@Override
	public void updateNodeDescByMap(Map<String, String> map) {
		contractDao.updateNodeDescByMap(map);
	}

	@Override
	public String getNextContractFuzzyId() {
		return contractDao.getNextContractFuzzyId();
	}

	@Override
	public void insertContractFuzzy(ContractNodeFuzzy contractNodeFuzzy) {
		contractDao.insertContractFuzzy(contractNodeFuzzy);
	}

	@Override
	public void updateContractFuzzy(ContractNodeFuzzy contractNodeFuzzy) {
		contractDao.updateContractFuzzy(contractNodeFuzzy);
	}

	@Override
	public void deleteContractFuzzy(ContractNodeFuzzy contractNodeFuzzy) {
		contractDao.deleteContractFuzzy(contractNodeFuzzy);
	}

	@Override
	public String getNodeIdByPath(String nodePath, Integer tcpCtrFId) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("path", nodePath);
		map.put("tcpCtrFId", tcpCtrFId+"");
		return contractDao.getNodeIdByPath(map);
	}

	public Template queryTemplate(Template template) {
		Template retTemplate = contractDao.queryTemplate(template);
		return retTemplate;
	}
}
