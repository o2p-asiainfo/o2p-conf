package com.ailk.eaap.op2.conf.proofmanage.dao;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.ailk.eaap.op2.conf.proofmanage.model.ProofType;
import com.linkage.rainbow.dao.SqlMapDAO;

public class ProofEffectDaoImpl implements IProofEffectDao {

	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	/**
	 * 获得所有有效认证类型
	 * @return
	 */
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "proof_type", columnNames = "PT_NAME", idName = "PT_CD", propertyNames = "PT_NAME") 
		}
	)
	@Override
	public List<ProofType> getAllProofType() {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllProofType", null);
	}
	/**
	 * 获得有效验证的列表
	 * @param Map
	 * @return
	 */
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "proof_type", columnNames = "PT_NAME", idName = "PT_CD", propertyNames = "PT_NAME") 
		}
	)
	@Override
	public List<Map> getAllProofInstance(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllProofInstance", map);
	}
	/**
	 * 获得有效验证的记录数
	 * @param Map
	 * @return
	 */
	@Override
	public String queryAllProofInstanceCount(Map map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.queryAllProofInstanceCount", map);
	}
	/**
	 * 得到所有属性规格的记录数
	 * @param Map
	 * @return
	 */
	@Override
	public String queryAllAttrSpecValue(Map map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.queryAllAttrSpecValue", map);
	}
	/**
	 * 得到所有属性规格的值
	 * @param Map
	 * @return
	 */
	@Override
	public List<Map> getAllAttrSpecValule(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllAttrSpecValule", map);
	}
	/**
	 * 得到配置好的属性值记录数
	 * @param Map
	 * @return
	 */
	@Override
	public String queryAllAttrValue(Map map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.queryAllAttrValue", map);
	}
	/**
	 * 得到配置好的属性值列表
	 * @param Map
	 * @return
	 */
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "proof_type", columnNames = "PT_NAME", idName = "PT_CD", propertyNames = "PT_NAME") 
		}
	)
	@Override
	public List<Map> getAllAttrValule(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllAttrValule", map);
	}
	/**
	 * 获得认证类型属性规格记录
	 * @param Map
	 * @return
	 */
	@Override
	public String queryAllPrAttrValue(Map map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.queryAllPrAttrValue", map);
	}
	/**
	 * 获得认证类型属性规格列表
	 * @param Map
	 * @return
	 */
	@Override
	public List<Map> getAllPrAttrValule(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllPrAttrValule", map);
	}
	/**
	 * 添加认证类型属性规格
	 * @param map
	 */
	@Override
	public void addPrAttrSpecValue(Map<String, String> map) {
		sqlMapDao.insert("eaap-op2-conf-proof-manage-sqlmap.addPrAttrSpecValue", map);
	}
	/**
	 * 删除认证类型属性规格配置
	 * @param map
	 */
	@Override
	public void delPrAttrSpecValue(Map<String, String> map) {
		sqlMapDao.delete("eaap-op2-conf-proof-manage-sqlmap.delPrAttrSpecValue", map);
	}
	/**
	 * 获得有效认证当前最新记录ID
	 * @return
	 */
	@Override
	public String getMaxProofId() {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.getMaxProofId", null);
	}
	/**
	 * 添加有效认证记录
	 * @param map
	 */
	@Override
	public void addProofEffect(Map<String, String> map) {
		sqlMapDao.insert("eaap-op2-conf-proof-manage-sqlmap.addProofEffect", map);
		
	}
	/**
	 * 添加认证属性值
	 * @param map
	 */
	@Override
	public void addAttrValues(Map<String, String> map) {
		sqlMapDao.insert("eaap-op2-conf-proof-manage-sqlmap.addAttrValues", map);
	}
	/**
	 * 删除认证属性值
	 * @param map
	 */
	@Override
	public void delProofValues(Map<String, String> map) {
		sqlMapDao.delete("eaap-op2-conf-proof-manage-sqlmap.delProofValues", map);
	}
	/**
	 * 由认证ID删除认证属性值
	 * @param map
	 */
	@Override
	public void delProofValuesBuProofId(Map<String, String> map) {
		sqlMapDao.delete("eaap-op2-conf-proof-manage-sqlmap.delProofValuesBuProofId", map);
	}
	/**
	 * 删除有效验证实例
	 * @param map
	 */
	@Override
	public void delProofEffect(Map<String, String> map) {
		sqlMapDao.delete("eaap-op2-conf-proof-manage-sqlmap.delProofEffect", map);
	}
	/**
	 * 由认证类型得到所有的认证类型属性规格
	 * @param pt_cd
	 * @return
	 */
	@Override
	public List<Map> getAllAttrValueByType(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllAttrValueByType", map);
	}
	/**
	 * 查看有效认证配置
	 * @param map
	 * @return
	 */
	@Override
	public List<Map> getAllAttrValueByMap(Map<String, String> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getAllAttrValueByMap", map);
	}
	/**
	 * 得到页面显示的值
	 * @param paMap
	 * @return
	 */
	@Override
	public String getShowPageValue(Map<String, String> paMap) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.getShowPageValue", paMap);
	}
	/**
	 * 取得有效认证关联表的最大ID
	 * @return
	 */
	@Override
	public String getMidMaxID() {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.getMidMaxID", null);
	}
	/**
	 * 添加有效认证关联表记录
	 * @param paramMap
	 */
	@Override
	public void addProoefMid(Map<String, String> paramMap) {
		sqlMapDao.insert("eaap-op2-conf-proof-manage-sqlmap.addProoefMid", paramMap);
	}
	/**
	 * 获得该调用实例的所有认证
	 * @param serInvokeInsId
	 * @return
	 */
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "proof_type", columnNames = "PT_NAME", idName = "PT_CD", propertyNames = "PT_NAME") 
		}
	)
	@Override
	public List<Map> getSerInvokerProoef(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getSerInvokerProoef", map);
	}
	/**
	 * 删除所有记录
	 * @param serInvokeInsId
	 */
	@Override
	public void deleteAllProoefMidById(Map map) {
		sqlMapDao.delete("eaap-op2-conf-proof-manage-sqlmap.deleteAllProoefMidById", map);
	}
	/**
	 * 由服务调用实例得到webservice的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	@Override
	public List<Map<String, String>> getWebServiceMsg(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getWebServiceMsg", map);
	}
	/**
	 * 由服务调用实例得到webservice的 api调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	@Override
	public List<Map<String, String>> getWebServiceApiMsg(
			Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getWebServiceApiMsg", map);
	}
	/**
	 * 由服务调用实例得到rest的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	@Override
	public List<Map<String, String>> getRestAddress(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getRestAddress", map);
	}
	/**
	 * 由服务调用实例得到http的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	@Override
	public List<Map<String, String>> getHttpAddress(Map map) {
		return sqlMapDao.queryForList("eaap-op2-conf-proof-manage-sqlmap.getHttpAddress", map);
	}
	/**
	 * 修改证属性值
	 * @param paramMap
	 */
	@Override
	public void updateAttrValues(Map<String, String> paramMap) {
		sqlMapDao.update("eaap-op2-conf-proof-manage-sqlmap.updateAttrValues", paramMap);
	}
	/**
	 * 查看记录有没有被用
	 * @param proofe_id
	 * @return
	 */
	@Override
	public int countRecourds(Map map) {
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-proof-manage-sqlmap.countRecourds", map);
	}
}
