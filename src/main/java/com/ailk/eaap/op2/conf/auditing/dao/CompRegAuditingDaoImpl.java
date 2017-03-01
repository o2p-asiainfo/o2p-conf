package com.ailk.eaap.op2.conf.auditing.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.App;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;
 
public class CompRegAuditingDaoImpl   implements CompRegAuditingDao {
	private SqlMapDAO sqlMapDao;
	public List<Map> queryCompInfo(Component compbean) {
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingcomp.queryCompInfo", compbean) ;
    }
	
	public List<Map> queryCompInfoList(Map map) {
		String arrayComponentTypeId = String.valueOf(map.get("componentTypeId"));
		if(null != map.get("componentTypeId") && !"".equals(arrayComponentTypeId)){
			arrayComponentTypeId = arrayComponentTypeId.replace("(", "").replace(")", "").replace("'", "");
			String[] componentTypeId = arrayComponentTypeId.split(",");
			map.put("arrayComponentTypeId", componentTypeId);
		}
		String arrayState = String.valueOf(map.get("state"));
		if(null != map.get("state") && !"".equals(arrayState)){
			arrayState = arrayState.replace("(", "").replace(")", "").replace("'", "");
			String[] state = arrayState.split(",");
			map.put("arrayState", state);
		}
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingcomp.queryCompInfoListCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingcomp.queryCompInfoList", map) ;
		}
		
    }
	
	 @ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "component_type", columnNames = "name", idName = "component_type_id", propertyNames = "NAME") 
		}
	 )
	 public List<Map> queryCompTypeNCList(Map map) {
		 return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-autitingcomp.queryCompTypeNCList", map) ;
	 }
	
	/** 审批用户注册 **/
	public Integer checkCompOnline (Component compbean){
		return (Integer)sqlMapDao.update("eaap-op2-conf-autitingcomp.updateComponent", compbean) ;
	}
	
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}

	/* (non-Javadoc)
	 * @see com.ailk.eaap.op2.conf.auditing.dao.CompRegAuditingDao#addComp(java.util.Map)
	 */
	public String addComp(Component compbean) {
		return (String)sqlMapDao.insert("component.insertComponent", compbean);
	}
	
	
	/**
	 * 获取应用表序列
	 * @return
	 */ 
	public String selectSeqApp(){
		return (String)sqlMapDao.queryForObject("app.selectSeqApp", null);
	}
	
	
	 /**
     * 注册APP应用
     */
	public Integer saveApp(App appBean){
		return (Integer)sqlMapDao.insert("app.insertApp", appBean) ;
	}

	
	/**
	 * 获取应用信息
	 * @param componentBean
	 * @return
	 */
	public List<App> selectAPP(App appBean){
		List<App> appList = (ArrayList<App>)sqlMapDao.queryForList("app.selectApp", appBean) ;
	    return appList ;
	}
	
	
	/**
	 * 修改APP应用信息
	 * @param appBean
	 * @return
	 */
	public Integer updateApp(App appBean){
		return (Integer)sqlMapDao.update("app.updateApp", appBean) ;
	}
	
	/**
	 * 修改组件信息
	 * @param appBean
	 * @return
	 */
	public void updateComp(Component compbean) {
		sqlMapDao.update("component.updateComponent", compbean);
	}
	
	
	public void delcComp(String compId) {
		sqlMapDao.delete("eaap-op2-conf-autitingcomp.delComponent", compId);
	}

	

	/* (non-Javadoc)
	 * @see com.ailk.eaap.op2.conf.auditing.dao.CompRegAuditingDao#addComp(com.ailk.eaap.op2.bo.Component, com.ailk.eaap.op2.bo.Org)
	 */
	public List<Component> validatorComponentInfoExistList(Component component){
		return (ArrayList<Component>)sqlMapDao.queryForList("component.validatorComponentInfoExistList", component) ;
	}

}
