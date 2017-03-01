package com.ailk.eaap.op2.conf.authenticate.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;

public class AuthenticateDaoImpl implements IAuthenticateDao {

	private SqlMapDAO sqlMapDao ;
	
	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	
	
	public List<Map<String, String>> getComponentList(
			Map<String, String> componentMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.getComponentList", componentMap);
	}

	public List<Map<String, String>> getServiceList(
			Map<String, String> serviceMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.getServiceList", serviceMap);
	}

	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "proof_type", columnNames = "pt_name,pt_desc", idName = "PT_CD", propertyNames = "PT_NAME,PT_DESC") 
		}
	)
	public List<Map<String, Object>> getProofTypeList(
			Map<String, String> proofTypeMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.getProofTypeList", proofTypeMap);
	}


	public List<Map<String, String>> queryProofAttr(Map<String, Object> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryProofAttr", map);
	}


	public String getProofEffectSEQ() {
		return (String) sqlMapDao.queryForObject("proofEffect.selectProofEffectSeq", null);
	}


	public void addProofEffect(ProofEffect proofEffect) {
		sqlMapDao.update("proofEffect.insertProofEffect", proofEffect) ;
	}


	public List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.getSerInvokeInsList", serInvokeInsMap);
	}


	public List<Map<String, String>> queryExistsAttr(Map<String, Object> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryExistsAttr", map);
	}


	public void deleteProofEffect(ProofEffect proofEffect) {
		sqlMapDao.update("eaap-op2-conf-authenticate.deleteProofEffect", proofEffect);
	}


	public String getProofValuesSEQ() {
		return (String) sqlMapDao.queryForObject("proofValues.selectProofValuesSeq", null);
	}

	public void addProofValues(ProofValues proofValues) {
		sqlMapDao.update("proofValues.insertProofValues", proofValues) ;
	}

	public List<Map> queryProofEffectCount(Map<String, Object> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryProofEffectCount", map);
	}

	public List<Map> showProofEffectList(Map<String, Object> map) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryProofEffectList", map);
	}

	public List<Map> getAttrByProofeId(ProofEffect proofEffect) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryAttrByProofeId", proofEffect);
	}

	public List<Map> queryProofTypeListBySerInvokeInsId(Map<String, Object> inmap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryProofTypeListBySerInvokeInsId", inmap);
	}

	public List<Map> queryAttrListByProofId(Map<String, Object> inmap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryAttrListByProofId", inmap) ;
	}
 
	public List<Map> queryAttrListByProofIdAll(Map<String, Object> inmap) {
		return sqlMapDao.queryForList("eaap-op2-conf-authenticate.queryAttrListByProofIdAll", inmap) ;
	}

	public void updateProofValues(ProofValues proofValue) {
		sqlMapDao.update("proofValues.updateProofValues", proofValue) ;
	}

	public void deleteAuthenticate(SerInvokeIns serInvokeIns) {
		sqlMapDao.update("serInvokeIns.deleteAuthenticate", serInvokeIns) ;
	}

	public String queryCount(Map map) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-authenticate.queryCount", map) ;
	}

}
