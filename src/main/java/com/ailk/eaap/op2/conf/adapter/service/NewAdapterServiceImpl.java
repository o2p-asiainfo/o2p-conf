package com.ailk.eaap.op2.conf.adapter.service;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.util.StringUtils;

import com.ailk.eaap.op2.conf.adapter.action.NodeDescMapper;
import com.ailk.eaap.op2.conf.adapter.dao.IAdapterDao;
import com.ailk.eaap.op2.conf.adapter.dao.INewAdapterDao;
import com.ailk.eaap.op2.conf.adapter.util.Expression;
import com.ailk.eaap.op2.conf.adapter.util.ExpressionUtil;
import com.ailk.eaap.op2.serviceagent.auth.bo.JsonObject;
import com.asiainfo.foundation.log.Logger;

public class NewAdapterServiceImpl implements INewAdapterService {

	private INewAdapterDao newAdapterDao;
	private IAdapterDao adapterDao;
	private static final String FUNCTION_LIST_FILE_NAME = "function.define";
	private static final Logger LOG = Logger.getLog(NewAdapterServiceImpl.class);
	@Override
	public int getCountContractListByMap(Map map) {
		return newAdapterDao.getCountContractListByMap(map);
	}

	@Override
	public List<Map> getContractListByMap(Map map) {
		return newAdapterDao.getContractListByMap(map);
	}

	public INewAdapterDao getNewAdapterDao() {
		return newAdapterDao;
	}

	public void setNewAdapterDao(INewAdapterDao newAdapterDao) {
		this.newAdapterDao = newAdapterDao;
	}

	public IAdapterDao getAdapterDao() {
		return adapterDao;
	}

	public void setAdapterDao(IAdapterDao adapterDao) {
		this.adapterDao = adapterDao;
	}

	@Override
	public String getConAdaEndId() {
		return newAdapterDao.getConAdaEndId();
	}

	@Override
	public void addConAdaEnd(Map contractEndpoint) {
		newAdapterDao.addConAdaEnd(contractEndpoint);
	}

	@Override
	public void updateContractRecords(Map<String, String> param) {
		newAdapterDao.updateContractRecords(param);
	}

	@Override
	public void delConAdaEndByMap(Map<String, String> param) {
		newAdapterDao.delConAdaEndByMap(param);
	}

	@Override
	public String isExitOperator(String operator, String pageContractAdapterId) {
		String result = "";
		if("XX".equals(operator)){
			Map map = new HashMap();
			map.put("pageContractAdapterId", pageContractAdapterId);
			String value = newAdapterDao.querySrcById(map);
			if(null != value && !"".equals(value) && !"0".equals(value)){
				result = "EXIT";
			}else{
				result = "NO_DATA";
			}
		}else if("R".equals(operator)){
			Map map = new HashMap();
			map.put("pageContractAdapterId", pageContractAdapterId);
			int value = newAdapterDao.queryActionById(map);
			if(value >0){
				result = "EXIT";
			}else{
				result = "NO_DATA";
			}
		}else{
			result = "NO_DATA";
		}
		return result;
	}

	@Override
	public String isExitLine(Map<String, String> param) {
		String result = "";//返回结果
		String operator = param.get("operator");
		String contractAdapterId = param.get("contractAdapterId");
		String srcNodeDescId = param.get("srcNodeDescId");
		boolean isExitOper = newAdapterDao.isExitOper(param);
		if(isExitOper){
			result = "EXIT";
		}else{
			if("M".equals(operator) || "U".equals(operator) || "Z".equals(operator) || "H".equals(operator) || "RFT".equals(operator)){
				boolean isInFormatList = isInFormatList(srcNodeDescId,contractAdapterId);
				if(isInFormatList){//在列表中,可以往下操作
					result  =  getFinalResult(param);
				}else{//不在列表中,
					result = "NOT_IN_LIST";
				}
			}else{
				result  =  getFinalResult(param);
			}
		}
		return result;
	}
	/**
	 * 得到最终的判断结果
	 * @param param
	 * @return
	 */
	private String getFinalResult(Map<String, String> param) {
		String result = "";
		String contractAdapterId = param.get("contractAdapterId");
		String tarNodeDescId = param.get("tarNodeDescId");
		String srcNodeDescId = param.get("srcNodeDescId");
		String operator = param.get("operator");
		List<Map> list = newAdapterDao.getNodeMapper(contractAdapterId,tarNodeDescId);
		if(null != list && list.size()  > 0){//说明存在
			NodeDescMapper mapper = new NodeDescMapper();
			mapper.setNodeDescMapperId(String.valueOf(list.get(0).get("NODE_DESC_MAPER_ID")));
			mapper.setTarNodeDescId(String.valueOf(list.get(0).get("TAR_NODE_DESC_ID")));
			mapper.setSrcNodeDescId(String.valueOf(list.get(0).get("SRC_NODE_DESC_ID")));
			mapper.setActionTypeCd(String.valueOf(list.get(0).get("ACTION_TYPE_CD")));
			mapper.setContractAdapterId(String.valueOf(list.get(0).get("CONTRACT_ADAPTER_ID")));
			if("M".equals(operator) ||  "U".equals(operator) || "RFT".equals(operator) || "Z".equals(operator) || "H".equals(operator)){
				String innerOper = mapper.getActionTypeCd();
				if("R".equals(innerOper) || "A".equals(innerOper)){
					result = "USED";//已经被使用
				}else{
					if(srcNodeDescId.equals(mapper.getSrcNodeDescId())){
						result = "UPDATE";//更新操作
					}else{
						result = "USED";//已经被使用
					}
				}
			}else{
				String innerOper = mapper.getActionTypeCd();
				if("M".equals(innerOper) || "U".equals(innerOper)){
					result = "USED";//已经被使用
				}else{
					result = "UPDATE";//更新操作
				}
			}
		}else{//说明不存在
			result = "NO_DATA";
		}
		return result;
	}

	/**
	 * 判断是否在当前的协议列表中
	 * @param srcNodeDescId
	 * @param contractAdapterId
	 * @return
	 */
	private boolean isInFormatList(String srcNodeDescId,
			String contractAdapterId) {
		List<String> resultList = new ArrayList<String>();
		Map mapt = new HashMap();
		mapt.put("pageContractAdapterId", contractAdapterId);
		String srcAdapterId = newAdapterDao.querySrcById(mapt);
		Map map2 = new HashMap();
		map2.put("contractAdapterId", contractAdapterId);
		List<Map> listEndpointSrcId = newAdapterDao.getEndPointSrcList(map2);
		if(null != srcAdapterId && !"".equals(srcAdapterId)){
			resultList.add(srcAdapterId);
		}
		if(null != listEndpointSrcId && listEndpointSrcId.size() > 0){
			for(Map value : listEndpointSrcId){
				String id = String.valueOf(value.get("CONTRACT_FORMATE_ID"));
				resultList.add(id);
			}
		}
		List<String> finalResult = new ArrayList<String>();
		for(String finalValue: resultList){
			finalResult.add(finalValue);
			Map map = new HashMap();
			map.put("tcpCtrFId", finalValue);
			finalResult.add(adapterDao.getTcpCtrFIdByMap(map));
		}
		Map map = new HashMap();
		map.put("srcNodeDescId", srcNodeDescId);
		String srcFomatId = newAdapterDao.getFormatId(map);
		if(finalResult.contains(srcFomatId)){
			return true;
		}
		return false;
	}

	@Override
	public String getSelectedLeftFormat(String pageContractAdapterId) {
		String result = "";
		List<String> resultList = new ArrayList<String>();
		Map mapt = new HashMap();
		mapt.put("pageContractAdapterId", pageContractAdapterId);
		String srcAdapterId = newAdapterDao.querySrcById(mapt);
		Map map = new HashMap();
		map.put("contractAdapterId", pageContractAdapterId);
		List<Map> listEndpointSrcId = newAdapterDao.getEndPointSrcList(map);
		if(null != srcAdapterId && !"".equals(srcAdapterId)){
			resultList.add(srcAdapterId);
		}
		if(null != listEndpointSrcId && listEndpointSrcId.size() > 0){
			for(Map value : listEndpointSrcId){
				String id = String.valueOf(value.get("CONTRACT_FORMATE_ID"));
				resultList.add(id);
			}
		}
		if(resultList.size()  > 0){
			for(String value : resultList){
				if("".equals(result)){
					result = value;
				}else{
					result = result+","+value;
				}
			}
		}
		return result;
	}

	@Override
	public String changeToAction(Map<String, String> param) {
		String result = "";
		String contractAdapterId = param.get("contractAdapterId");
		String operator = param.get("operator");
		String srcTcpCtrFId = param.get("srcTcpCtrFId");
		if("XX".equals(operator)){
			boolean isExit = newAdapterDao.isExitSrcTcpCtrFId(param);//判断在协议端点表里是否存在
			if(isExit){
				Map<String,String> map = new HashMap<String,String>();
				map.put("contractAdapterId", contractAdapterId);
				map.put("endpointId", param.get("endpointId"));
				map.put("tcpCrtFId", srcTcpCtrFId);
				newAdapterDao.delConAdaEndByMap(map);//删除协议端点表里的记录
				newAdapterDao.updateContractAdapter(param);//同时修改协议转化表的源协议格式ID
				result = "success";
			}else{
				result = "DATA_EXCEPTION";
			}
		}else if("R".equals(operator)){
			boolean isExit = newAdapterDao.isExitSrcTcpCtrFId(param);//判断在协议端点表里是否存在
			if(isExit){
				param.put("actionType", "R");
				newAdapterDao.updateConAdaEndpoint(param);//存在的话，则改变它的动作为R。
				result = "success";
			}else{
				result = "DATA_EXCEPTION";
			}
		}else{
			boolean isExit = newAdapterDao.isExitInAdapter(param);//判断在协议转化表里是否存在
			if(isExit){
				Map<String,String> mapParam = new HashMap<String,String>();
				mapParam.put("contractAdapterId", contractAdapterId);
				mapParam.put("tcpCrtFId", srcTcpCtrFId);
				newAdapterDao.updateContractRecords(mapParam);//如果存在，则将协议转化表的源协议格式ID清空
				String id = newAdapterDao.getConAdaEndId();
				Map<String,String> bean = new HashMap<String,String>();
				bean.put("conAdaEndId", id);
				bean.put("contractAdapterId", contractAdapterId);
				bean.put("endPointId", param.get("endpointId"));
				bean.put("srcTcpCtrFId", srcTcpCtrFId);
				bean.put("actionType", "T");
				newAdapterDao.addConAdaEnd(bean);//同时协议端点表里添加一条记录
				result = "success";
			}else{//如果不存在，
				boolean isExitOther = newAdapterDao.isExitSrcTcpCtrFId(param);//则判断协议端点表里是否存在，
				if(isExitOther){
					param.put("actionType", "T");
					newAdapterDao.updateConAdaEndpoint(param);//如果存在，则改变它的动作为T。
					result = "success";
				}else{
					result = "DATA_EXCEPTION";
				}
			}
		}
		return result;
	}

	@Override
	public List<Map> getNodeValAdaReq(Map<String, String> param) {
		return newAdapterDao.getNodeValAdaReq(param);
	}

	@Override
	public String addNodeValAdapterRes(Map<String, String> param) {
		String result = "";
		boolean isExit = newAdapterDao.isExitNodeValReq(param);
		if(isExit){//存在,说明是修改动作
			adapterDao.updateNodeValAdapterRes(param);
			result = "success";
		}else{//添加动作
			Map mapTemp = new HashMap() ;  
			String id = adapterDao.queryNodeValAdapterResID(mapTemp)+"";
			param.put("nodeId", id);
			adapterDao.saveNodeValAdapterRes(param);
			result = "success";
		}
		return result;
	}
	
	@Override
	/**
	 * 解析从数据库读取的条件取值表达式到前台
	 */
	public String unAssembleValueExpression(String complexCondition) {
		if(!StringUtils.hasText(complexCondition)) {
			return "";
		}
		JSONObject conditionObj = JSONObject.fromObject(complexCondition);
		JSONObject targetExpressionObj = new JSONObject();
		if(conditionObj.containsKey("globalCondition") && !conditionObj.getString("globalCondition").equals("")) {
			targetExpressionObj.element("globalCondition", ExpressionUtil.getCondFromExpression(conditionObj.getJSONObject("globalCondition"),true));
		}
		targetExpressionObj.element("condition", getCondArrayFromLogicVal(conditionObj));
		targetExpressionObj.element("finalValue", conditionObj.getString("finalAssign"));
		return targetExpressionObj.toString();
	}
	
	private String getCondArrayFromLogicVal(JSONObject conditionObj) {
		JSONArray tarConArray = new JSONArray();
		JSONObject tarConObj = null;
		if(conditionObj.containsKey("logicGetValue")) {
			JSONArray conArray = conditionObj.getJSONArray("logicGetValue");
			for(int i=0; i<conArray.size(); i++) {
				tarConObj = new JSONObject();
				JSONObject conObj = conArray.getJSONObject(i);
				if(conObj.containsKey("condition") && !conObj.getString("condition").equals("")) {
					tarConObj.element("condition", ExpressionUtil.getCondFromExpression(conObj.getJSONObject("condition"),true));
				}
				tarConObj.element("expression", ExpressionUtil.getCondFromExpression(conObj.getJSONObject("assign"), false));
				tarConObj.element("variable", conObj.getJSONObject("assign").getString("variable"));
				tarConArray.add(tarConObj);
			}
		}
		return tarConArray.toString();
	}
	
	/**
	 * 解析从前台获取到的条件取值表达式存到数据库
	 */
	public String assembleValueExpression(String complexCondition) {
		JSONObject conditionObj = getJsonObject(complexCondition);
		JSONObject targetExpressionObj = new JSONObject();
		int index = 0;
		if(conditionObj.containsKey("globalCondition")) {
			targetExpressionObj.element("globalCondition", getExpressionObj(conditionObj.getString("globalCondition"), index++, true));
		}
		JSONArray array = conditionObj.getJSONArray("condition");
		targetExpressionObj.element("logicGetValue", getConditions(array, index));
		targetExpressionObj.element("finalAssign", conditionObj.getString("finalValue"));
		return targetExpressionObj.toString();
	}
	
	public String assembleReflectValueExpression(String reflectExpression) {
		JSONObject srcExpressObj = getJsonObject(reflectExpression);
		JSONObject targetExpressObj = new JSONObject();
		targetExpressObj.element("sourceNodes", getSourceNodes(srcExpressObj.getString("sourceNodes")));
		targetExpressObj.element("targetNodes", getTargetNodes(srcExpressObj.getJSONArray("tarNodes")));
		return targetExpressObj.toString();
	}
	
	public String unAssembleReflectValueExpression(String relectExpress) {
		JSONObject srcExpressObj = getJsonObject(relectExpress);
		JSONObject targetExpressObj = new JSONObject();
		JSONObject sourceNodes = srcExpressObj.getJSONObject("sourceNodes");
		StringBuilder tarSourceNodes = new StringBuilder("");
		if(sourceNodes.containsKey("subNodes")) {
			JSONArray nodeArray = sourceNodes.getJSONArray("subNodes");
			JSONObject nodeObj = null;
			for(int i=0; i<nodeArray.size(); i++) {
				nodeObj = nodeArray.getJSONObject(i);
				if(nodeObj.containsKey("node")) {
					String nodeStr = nodeObj.getString("node");
					if(i == nodeArray.size()-1) {
						tarSourceNodes.append(nodeStr);
					} else {
						tarSourceNodes.append(nodeStr + ",");
					}
				}
			}
		}
		targetExpressObj.element("sourceNodes", tarSourceNodes.toString());
		JSONObject targetNodes = srcExpressObj.getJSONObject("targetNodes");
		JSONArray tarObjNodes = new JSONArray();
		JSONObject tarObjNode = null;
		if(targetNodes.containsKey("subNodes")) {
			JSONArray nodeArray = targetNodes.getJSONArray("subNodes");
			for(int i=0; i<nodeArray.size(); i++) {
				String exp = ExpressionUtil.getCondFromExpression(nodeArray.getJSONObject(i), false);
				tarObjNode = new JSONObject();
				tarObjNode.element("valueExpress", exp);
				tarObjNode.element("node", nodeArray.getJSONObject(i).get("node"));
				tarObjNodes.add(tarObjNode);
			}
		}
		targetExpressObj.element("tarNodes", tarObjNodes);
		return targetExpressObj.toString();
	}

	private JSONObject getTargetNodes(JSONArray targetNodes) {
		JSONArray subNodes = new JSONArray();
		JSONObject tarNodes = new JSONObject();
		if(targetNodes == null) {
			tarNodes.element("subNodes", subNodes);
			return tarNodes;
		}
		JSONObject subNode;
		for(int i=0; i<targetNodes.size(); i++) {
			subNode = new JSONObject();
			JSONObject tarNode = targetNodes.getJSONObject(i);
			subNode.element("node", tarNode.getString("node"));
			JSONObject express = getExpressionObj(tarNode.getString("valueExpress"), i, false);
			if(express != null) {
				subNode.element("variables", express.getJSONArray("variables"));
				subNode.element("valueExpress", express.getString("express"));
			} else {
				subNode.element("variables", "[]");
				subNode.element("valueExpress", "");
			}
			subNodes.add(subNode);
		}
		tarNodes.element("subNodes", subNodes);
		return tarNodes;
	}

	private JSONObject getSourceNodes(String sourceNodesStr) {
		JSONArray subNodes = new JSONArray();
		JSONObject sourceNodes = new JSONObject();
		if(sourceNodesStr == null) {
			sourceNodes.element("subNodes", subNodes);
			return sourceNodes;
		}
		JSONObject nodeObj = null;
		for(String node: sourceNodesStr.split(",")) {
			nodeObj = new JSONObject();
			nodeObj.element("node", node);
			subNodes.add(nodeObj);
		}
		sourceNodes.element("subNodes", subNodes);
		return sourceNodes;
	}

	private JSONArray getConditions(JSONArray array, int index) {
		if(array == null) {
			return null;
		}
		JSONArray cases = new JSONArray();
		JSONObject condition = null;
		JSONObject assign = null;
		for(int i=0; i<array.size(); i++) {
			JSONObject obj = array.getJSONObject(i);
			condition = new JSONObject();
			assign = new JSONObject();
			if(obj.containsKey("condition")) {
				JSONObject exp = getExpressionObj(obj.getString("condition"), index++, true);
				condition.element("condition", exp);
			}
			JSONObject assignExp = getExpressionObj(obj.getString("expression"), index++, false);
			if(assignExp != null) {
				if(assignExp.containsKey("variables")) {
					assign.element("variables", assignExp.getJSONArray("variables"));
				}
				if(assignExp.containsKey("express")) {
					assign.element("valueExpress", assignExp.getString("express"));
				}
			}
			assign.element("variable", obj.getString("variable"));
			condition.element("assign", assign);
			cases.add(condition);
		}
		return cases;
	}

	private JSONObject getExpressionObj(String condition, int index, boolean isCondition) {
		if(!StringUtils.hasText(condition)) {
			return null;
		}
		Expression exp = ExpressionUtil.assembleExpression(condition, index, isCondition);
		return JSONObject.fromObject(exp);
	}
	
	public JSONObject getJsonObject(String jsonStr) {
		if(jsonStr == null) {
			return null;
		}
		return JSONObject.fromObject(jsonStr);
	}

	@Override
	public int getCountValableMapByMap(Map map) {
		return newAdapterDao.getCountValableMapByMap(map);
	}

	@Override
	public List<Map> getValableMapByMap(Map map) {
		return newAdapterDao.getValableMapByMap(map);
	}

	@Override
	public String getVarMapTypeName(Map<String, String> param) {
		return newAdapterDao.getVarMapTypeName(param);
	}

	@Override
	public void delAdapterEndpoint(Map<String, String> param) {
		newAdapterDao.delAdapterEndpoint(param);
	}

	@Override
	public Map getContractAdapterById(Map<String, String> param) {
		return newAdapterDao.getContractAdapterById(param);
	}

	@Override
	public List<Map> getConAdaEndListById(Map<String, String> param){
		return newAdapterDao.getConAdaEndListById(param);
	}

	@Override
	public String getContractNameById(Map param) {
		return newAdapterDao.getContractNameById(param);
	}

	@Override
	public List<Map> getNodeMapperListById(Map map) {
		return newAdapterDao.getNodeMapperListById(map);
	}

	@Override
	public String getFormatIdById(Map<String, String> param) {
		return newAdapterDao.getFormatId(param);
	}

	@Override
	public List<Map> getContractFormat(Map<String, String> param) {
		return newAdapterDao.getContractFormat(param);
	}

	@Override
	public void updateResult(Map<String, String> param) {
		newAdapterDao.updateResult(param);
		
	}

	@Override
	public String getActionValue(Map<String, String> param) {
		return newAdapterDao.getActionValue(param);
	}

	@Override
	public int countVarMapType(Map map) {
		return newAdapterDao.countVarMapType(map);
	}

	@Override
	public List<Map> queryVarMapType(Map map) {
		return newAdapterDao.queryVarMapType(map);
	}

	@Override
	public void deleteVarMapType(Map<String, String> param) {
		newAdapterDao.deleteVarMapType(param);
	}
	
	@Override
	public List<Map> getRToCLinesDataById(Map<String, String> param) {
		return newAdapterDao.getRToCLinesDataById(param);
	}

	@Override
	public String getFunctionList() {
		InputStream is = null;
		BufferedInputStream bs = null;
		try {
			StringBuilder result = new StringBuilder("");
			is = this.getClass().getClassLoader().getResourceAsStream(FUNCTION_LIST_FILE_NAME);
			if(is != null) {
				byte[] contents = new byte[1024]; 
				int byteRead = 0;
				bs = new BufferedInputStream(is);
				while((byteRead = bs.read(contents)) != -1){  
	                result.append(new String(contents,0,byteRead));
	            }
			}
			return result.toString();
		} catch(IOException e) {
			LOG.error("get function list error", e);
		} finally {
			if(bs != null) {
				try {
					bs.close();
				} catch (IOException e) {
					LOG.error("close stream error", e);
				}
			}
			if(is != null) {
				try {
					is.close();
				} catch (IOException e) {
					LOG.error("close stream error", e);
				}
			}
		}
		return null;
	}
}
