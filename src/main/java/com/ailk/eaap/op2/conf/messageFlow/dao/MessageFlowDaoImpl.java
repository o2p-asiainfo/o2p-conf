package com.ailk.eaap.op2.conf.messageFlow.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import java.util.List;

import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.CacheStrategy;
import com.ailk.eaap.op2.bo.MessageFlow;
import com.ailk.eaap.op2.conf.messageFlow.action.TemplateModel;
import com.linkage.rainbow.dao.SqlMapDAO;

public class MessageFlowDaoImpl implements IMessageFlowDao{
		private SqlMapDAO sqlMapDao;
	
		public SqlMapDAO getSqlMapDao() {
			return sqlMapDao;
		}
	
		public void setSqlMapDao(SqlMapDAO sqlMapDao) {
			this.sqlMapDao = sqlMapDao;
		}
    
		public List<Map> getMessageFlowList(Map param) {
			if("ALLNUM".equals(String.valueOf(param.get("queryType")))){
				return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-messageFlow.selectMessageFlowListCount", param) ;
			}else{
				return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-messageFlow.selectMessageFlowList", param) ;
			}
	    }
		/**
		 * 查询CVS的模板总记录
		 * @param Map
		 * @return
		 */
		@Override
		public String queryAllTempletCount(Map map) {
			return (String)sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.queryAllTempletCount", map) ;
		}
		/**
		 * 查询CVS模板的列表记录
		 * @param Map
		 * @return
		 */
		@Override
		public List<Map> getAllTempleteList(Map map) {
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-messageFlow.getAllTempleteList", map) ;
		}
		/**
		 * 添加模板数据
		 * @param templateModel
		 */
		@Override
		public void addTemplate(TemplateModel templateModel) {
			sqlMapDao.insert("eaap-op2-conf-messageFlow.addTemplate", templateModel);
		}
		/**
		 * 查询当前模板Id
		 * @return
		 */
		@Override
		public String queryTempletId() {
			return (String)sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.queryTempletId", null) ;
		}
		/**
		 * 删除模板记录
		 * @param template_id
		 */
		@Override
		public void delTemplate(String template_id) {
			sqlMapDao.delete("eaap-op2-conf-messageFlow.delTemplate", template_id);
		}
		/**
		 * 查看模板记录
		 * @param template_id
		 * @return
		 */
		@Override
		public Map getTemplateById(String template_id) {
			return (Map)sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.getTemplateById", template_id) ;
		}
		/**
		 * 修改模板数据
		 * @param templateModel
		 */
		@Override
		public void updateTemplate(TemplateModel templateModel) {
			sqlMapDao.update("eaap-op2-conf-messageFlow.updateTemplate", templateModel);
		}

		@Override
		public List<HashMap> getTechImplMessageById(String serTechImplId) {
			return sqlMapDao.queryForList("eaap-op2-conf-messageFlow.getTechImplMessageById", serTechImplId);
		}

		@Override
		public List<HashMap> getAttrSpecList(String serTechImplId, String commCd,String tenantId) {
			Map<String,String> map = new HashMap<String,String>();
			map.put("serTechImplId", serTechImplId);
			map.put("commProCd", commCd);
			map.put("tenantId", tenantId);
			return sqlMapDao.queryForList("eaap-op2-conf-messageFlow.getAttrSpecList", map);
		}

		@Override
		public int getAllTechImplRecordsById(String serTechImplId) {
			int num = 0;
			num = (Integer)sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.getAllTechImplRecordsById", serTechImplId);
			return num;
		}

		@Override
		public List<HashMap> getTechImplList(Map param) {
			return sqlMapDao.queryForList("eaap-op2-conf-messageFlow.getTechImplList", param);
		}

		@Override
		public String queryAllCacheStragyCount(Map map) {
			return (String)sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.queryAllCacheStragyCount", map) ;
		}

		@Override
		public List<Map> queryAllCacheStragyList(Map map) {
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-messageFlow.queryAllCacheStragyList", map) ;
		}

		@Override
		public void delCacheStrategyById(String strategy_id) {
			sqlMapDao.delete("eaap-op2-conf-messageFlow.delCacheObj", strategy_id);
			sqlMapDao.delete("eaap-op2-conf-messageFlow.delStrategy", strategy_id);
		}

		@Override
		public Map getStrategyById(Map map) {
			List<Map> listCacheStrategy=sqlMapDao.queryForList("eaap-op2-conf-messageFlow.getStrategyById", map);
			List<Map> listCacheObj=sqlMapDao.queryForList("eaap-op2-conf-messageFlow.getCacheObjById", map);
			if(listCacheStrategy.size()==0){
				return new HashMap();
			}else{
				Map cacheStrategy=listCacheStrategy.get(0);
				cacheStrategy.put("cacheObjs", listCacheObj);
				return cacheStrategy;
			}
		}

		@Override
		public List<Map> getCacheStrategyList( String start, String limit,String cacheStrategyName,String tenantId) {
			Map param=new HashMap();
			if(StringUtils.isBlank(start)){
				start="0";
			}
			if(StringUtils.isBlank(limit)){
				limit="20";
			}
			if(StringUtils.isBlank(cacheStrategyName)){
				cacheStrategyName="";
			}
			
			param.put("start", Integer.parseInt(start));
			param.put("limit", Integer.parseInt(limit));
			param.put("cacheStrategyName",cacheStrategyName);
			if(StringUtils.isNotBlank(tenantId)){
				param.put("tenantId", tenantId);
			}
			List<Map> cacheStrategyList=sqlMapDao.queryForList("eaap-op2-conf-messageFlow.queryAllCacheStragyList", param);
			return cacheStrategyList;
		}

		@Override
		public Object getCacheStrategyListSize(String cacheStrategyName,String tenantId) {
			Map param=new HashMap();
			if(StringUtils.isBlank(cacheStrategyName)){
				cacheStrategyName="";
			}
			param.put("cacheStrategyName", cacheStrategyName);
			if(StringUtils.isNotBlank(tenantId)){
				param.put("tenantId", tenantId);
			}
			return sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.queryAllCacheStragyCount",param);
		}

		@Override
		public void updateCacheStrategy(CacheStrategy cacheStrategy) {
			Map param=new HashMap();
			param.put("id", cacheStrategy.getId());
			param.put("name", cacheStrategy.getName());
			param.put("cacheType", cacheStrategy.getCacheType());
			param.put("forceRefresh", cacheStrategy.getForceRefresh());
			param.put("expireTime", cacheStrategy.getExpireTime());
			param.put("expireTimePath", cacheStrategy.getExpireTimePath());
			sqlMapDao.update("eaap-op2-conf-messageFlow.updateCacheStrategy", param);
		}

		@Override
		public void delCacheObj(String cacheObjId) {
			sqlMapDao.delete("eaap-op2-conf-messageFlow.delCacheObjById", cacheObjId);
		}

		@Override
		public void addCacheObj(Map cacheObjMap) {
			sqlMapDao.insert("eaap-op2-conf-messageFlow.addCacheObj", cacheObjMap);
		}

		@Override
		public Object addCacheStrategy(CacheStrategy cacheStrategy) {
			Map param=new HashMap();
			param.put("name", cacheStrategy.getName());
			param.put("code", cacheStrategy.getCode());
			param.put("cacheType", cacheStrategy.getCacheType());
			param.put("state", "A");
			param.put("forceRefresh", cacheStrategy.getForceRefresh());
			param.put("expireTime", cacheStrategy.getExpireTime());
			param.put("expireTimePath", cacheStrategy.getExpireTimePath());
			
			param.put("tenantId", cacheStrategy.getTenantId());
			return sqlMapDao.insert("eaap-op2-conf-messageFlow.addCacheStrategy", param);
		}

		@Override
		public Object checkCacheKeyIsExist(String cacheKey) {
			Map param=new HashMap();
			param.put("keyRule",cacheKey);
			return sqlMapDao.queryForObject("eaap-op2-conf-messageFlow.checkCacheKeyIsExist", param);
		}

	
}
