package com.ailk.eaap.op2.conf.messageFlow.service;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.CacheStrategy;
import com.ailk.eaap.op2.bo.MessageFlow;
import com.ailk.eaap.op2.conf.messageFlow.action.TemplateModel;

public interface IMessageFlowSer {
	public List<Map> getMessageFlowList(Map param) ;

	/**
	 * 查询CVS的模板总记录
	 * @param Map
	 * @return
	 */
	public String queryAllTempletCount(Map map);

	/**
	 * 查询CVS模板的列表记录
	 * @param Map
	 * @return
	 */
	public List<Map> getAllTempleteList(Map map);

	/**
	 * 添加模板数据
	 * @param templateModel
	 */
	public void addTemplate(TemplateModel templateModel);

	/**
	 * 查询当前模板Id
	 * @return
	 */
	public String queryTempletId();

	/**
	 * 删除模板记录
	 * @param template_id
	 */
	public void delTemplate(String template_id);

	/**
	 * 查看模板记录
	 * @param template_id
	 * @return
	 */
	public Map getTemplateById(String template_id);

	/**
	 * 修改模板数据
	 * @param templateModel
	 */
	public void updateTemplate(TemplateModel templateModel);

	public List<HashMap> getTechImplMessageById(String serTechImplId);

	public List<HashMap> getAttrSpecList(String serTechImplId, String commCd,String tenantId);

	public int getAllTechImplRecordsById(String serTechImplId1);

	public List<HashMap> getTechImplList(Map param);

	public String queryAllCacheStragyCount(Map tem);

	public List<Map> queryAllCacheStragyList(Map tem);

	public void delCacheStrategyById(String strategy_id);

	public Map getStrategyById(Map map);

	public void save(JSONObject cacheStrategyObj) throws Exception;

	public Map getCacheStrategyById(Map map);

	public List<Map> getCacheStrategyList(String start, String limit, String cacheStrategyName, String tenantId);

	public Object getCacheStrategyListSize(String cacheStrategyName, String tenantId);

	public Map updateCacheStrategy(CacheStrategy cacheStrategy);

	public Map addCacheStrategy(CacheStrategy cacheStrategy);

	public Object checkCacheKeyIsExist(String cacheKey);
}
