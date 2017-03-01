package com.ailk.eaap.op2.conf.messageFlow.service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

import com.ailk.eaap.op2.bo.CacheStrategy;
import com.ailk.eaap.op2.conf.messageFlow.action.TemplateModel;
import com.ailk.eaap.op2.conf.messageFlow.dao.IMessageFlowDao;

public class MessageFlowSerImpl implements IMessageFlowSer{
   private IMessageFlowDao messageFlowDao;

	public List<Map> getMessageFlowList(Map param){
		return messageFlowDao.getMessageFlowList(param);
	}

	public IMessageFlowDao getMessageFlowDao() {
		return messageFlowDao;
	}

	public void setMessageFlowDao(IMessageFlowDao messageFlowDao) {
		this.messageFlowDao = messageFlowDao;
	}

	@Override
	public String queryAllTempletCount(Map map) {
		return messageFlowDao.queryAllTempletCount(map);
	}

	@Override
	public List<Map> getAllTempleteList(Map map) {
		return messageFlowDao.getAllTempleteList(map);
	}
	/**
	 * 添加模板数据
	 * @param templateModel
	 */
	@Override
	public void addTemplate(TemplateModel templateModel) {
		messageFlowDao.addTemplate(templateModel);
	}
	/**
	 * 查询当前模板Id
	 * @return
	 */
	@Override
	public String queryTempletId() {
		return messageFlowDao.queryTempletId();
	}
	/**
	 * 删除模板记录
	 * @param template_id
	 */
	@Override
	public void delTemplate(String template_id) {
		messageFlowDao.delTemplate(template_id);
	}
	/**
	 * 查看模板记录
	 * @param template_id
	 * @return
	 */
	@Override
	public Map getTemplateById(String template_id) {
		return messageFlowDao.getTemplateById(template_id);
	}
	/**
	 * 修改模板数据
	 * @param templateModel
	 */
	@Override
	public void updateTemplate(TemplateModel templateModel) {
		messageFlowDao.updateTemplate(templateModel);
	}

	@Override
	public List<HashMap> getTechImplMessageById(String serTechImplId) {
		return messageFlowDao.getTechImplMessageById(serTechImplId);
	}

	@Override
	public List<HashMap> getAttrSpecList(String serTechImplId, String commCd,String tenantId) {
		return messageFlowDao.getAttrSpecList(serTechImplId,commCd,tenantId);
	}

	@Override
	public int getAllTechImplRecordsById(String serTechImplId) {
		return messageFlowDao.getAllTechImplRecordsById(serTechImplId);
	}

	@Override
	public List<HashMap> getTechImplList(Map param) {
		return messageFlowDao.getTechImplList(param);
	}

	@Override
	public String queryAllCacheStragyCount(Map tem) {
		return messageFlowDao.queryAllCacheStragyCount(tem);
	}

	@Override
	public List<Map> queryAllCacheStragyList(Map tem) {
		return messageFlowDao.queryAllCacheStragyList(tem);
	}

	@Override
	public void delCacheStrategyById(String cacheStrategyId) {
		messageFlowDao.delCacheStrategyById(cacheStrategyId);
	}

	@Override
	public Map getStrategyById(Map map) {
		return messageFlowDao.getStrategyById(map);
	}

	@Override
	public void save(JSONObject cacheStrategyObj) throws Exception {
		// String cacheStrategyId=(String) cacheStrategyObj.get("id");
		// if(StringUtils.isNotBlank(cacheStrategyId)){//update
		// messageFlowDao.addCacheStrategy();
		// }else{ //insert
		//
		// }
		// if(cacheStrategyObj.get)

	}

	@Override
	public Map getCacheStrategyById(Map map) {
		
		return messageFlowDao.getStrategyById(map);
	}

	@Override
	public List<Map> getCacheStrategyList(String start, String limit, String cacheStrategyName,String tenantId) {
		return messageFlowDao.getCacheStrategyList(start, limit, cacheStrategyName,tenantId);
	}

	@Override
	public Object getCacheStrategyListSize(String cacheStrategyName,String tenantId) {
		return messageFlowDao.getCacheStrategyListSize(cacheStrategyName,tenantId);
	}

	@Override
	public Map updateCacheStrategy(CacheStrategy cacheStrategy) {
		
		Map map = new HashMap();
		map.put("strategyId", cacheStrategy.getId().toString());
		map.put("tenantId", cacheStrategy.getTenantId());
		
		Map cacheStrategyDB = messageFlowDao.getStrategyById(map);
		List<Map> cacheObjDB = (List) cacheStrategyDB.get("cacheObjs");

		// 先删除旧的cacheObj
		for (Map cacheObj : cacheObjDB) {
			String cacheObjId = cacheObj.get("ID").toString();
			messageFlowDao.delCacheObj(cacheObjId);
		}
		// 更新cacheStrategy
		messageFlowDao.updateCacheStrategy(cacheStrategy);

		// 插入新的cacheObj
		for (Object cacheObj : cacheStrategy.getCacheObjs()) {
			Map cacheObjMap = (Map) cacheObj;
			Map param=new HashMap();
			param.put("CODE", cacheObjMap.get("CODE"));
			param.put("KEY_RULE", cacheObjMap.get("KEY_RULE"));
			param.put("STATE", "A");
			param.put("VALUE_PATH", cacheObjMap.get("VALUE_PATH"));
			param.put("CACHE_STRATEGY_ID", cacheStrategy.getId());
			messageFlowDao.addCacheObj(param);
		}
		return null;
	}

	@Override
	public Map addCacheStrategy(CacheStrategy cacheStrategy) {
		Object cacheStrategyId= messageFlowDao.addCacheStrategy(cacheStrategy);
		// 插入新的cacheObj
		for (Object cacheObj : cacheStrategy.getCacheObjs()) {
			Map cacheObjMap = (Map) cacheObj;
			Map param=new HashMap();
			param.put("CODE", UUID.randomUUID().toString());
			param.put("KEY_RULE", cacheObjMap.get("KEY_RULE"));
			param.put("STATE", "A");
			param.put("VALUE_PATH", cacheObjMap.get("VALUE_PATH"));
			param.put("CACHE_STRATEGY_ID", cacheStrategyId);
			messageFlowDao.addCacheObj(param);
		}
		return null;
	}

	@Override
	public Object checkCacheKeyIsExist(String cacheKey) {
		return messageFlowDao.checkCacheKeyIsExist(cacheKey);
	}

}
