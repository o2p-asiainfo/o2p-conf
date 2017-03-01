package com.ailk.eaap.op2.conf.authenticate.service;

import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.conf.authenticate.dao.IAuthenticateDao;

public class AuthenticateServImpl implements IAuthenticateServ{

	private IAuthenticateDao authenticateDAO ;
	
	public void setAuthenticateDAO(IAuthenticateDao authenticateDAO) {
		this.authenticateDAO = authenticateDAO;
	}

	public List<Map<String, String>> getComponentList(
			Map<String, String> componentMap) {
		return authenticateDAO.getComponentList(componentMap) ;
	}

	public List<Map<String, String>> getServiceList(
			Map<String, String> serviceMap) {
		return authenticateDAO.getServiceList(serviceMap) ;
	}

	public List<Map<String, Object>> getProofTypeList(
			Map<String, String> proofTypeMap) {
		return authenticateDAO.getProofTypeList(proofTypeMap) ;
	}

	public List<Map<String, String>> queryProofAttr(Map<String, Object> map) {
		return authenticateDAO.queryProofAttr(map) ;
	}

	public String getProofEffectSEQ() {
		return authenticateDAO.getProofEffectSEQ() ;
	}

	public List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap) {
		return authenticateDAO.getSerInvokeInsList(serInvokeInsMap) ;
	}

	public List<Map<String, String>> queryExistsAttr(Map<String, Object> map) {
		return authenticateDAO.queryExistsAttr(map) ;
	}

	public void deleteProofEffect(ProofEffect proofEffect) {
		authenticateDAO.deleteProofEffect(proofEffect) ;
	}

	public String getProofValuesSEQ() {
		return authenticateDAO.getProofValuesSEQ() ;
	}

	public void addAll(List<ProofValues> proofValuesList,
			ProofEffect proofEffect) {
		
		authenticateDAO.addProofEffect(proofEffect) ;
		
		for(ProofValues proofValues : proofValuesList){
			authenticateDAO.addProofValues(proofValues) ;
		}
		
	}

	public List<Map> showProofEffectList(Map<String, Object> map) {
		if ("ALLNUM".equals(map.get("queryType"))) { 
    		return authenticateDAO.queryProofEffectCount(map);
    	}else{
    		return authenticateDAO.showProofEffectList(map);
    	}
	}

	public void addAllData(String[] proofTypeAtrSpecCdValues,
			String[] proofTypePtcdValues, String[] attrValues,
			String serInvokeInsId) {
		
		String flag = "";
		String proofEffectSEQ = "";
		for(int i = 0 ;i < proofTypePtcdValues.length ; i++){
			if(!flag.equals(proofTypePtcdValues[i])){
				ProofEffect proofEffect = new ProofEffect();
				proofEffectSEQ = authenticateDAO.getProofEffectSEQ() ;
				proofEffect.setProofeId(Integer.parseInt(proofEffectSEQ)) ;
				proofEffect.setStatus("Y");
				proofEffect.setSerInvokeInsId(Integer.parseInt(serInvokeInsId)) ;
				proofEffect.setPtCd(Integer.parseInt(proofTypePtcdValues[i])) ;
				authenticateDAO.addProofEffect(proofEffect) ;
			}
			flag = proofTypePtcdValues[i] ;
			ProofValues proofValue = new ProofValues() ; 
			String proofValueId = authenticateDAO.getProofValuesSEQ() ;
			proofValue.setPvId(Integer.parseInt(proofValueId)) ;
			proofValue.setProofeId(Integer.parseInt(proofEffectSEQ)) ;
			proofValue.setPrAtrSpecCd(proofTypeAtrSpecCdValues[i]) ;
			proofValue.setAttrValue(attrValues[i]) ;
			proofValue.setState("A");
			authenticateDAO.addProofValues(proofValue);
		}
		
	}

	public List<Map> getAttrByProofeId(ProofEffect proofEffect) {
		return authenticateDAO.getAttrByProofeId(proofEffect) ;
	}

	public List<Map> queryProofTypeListBySerInvokeInsId(
			Map<String, Object> inmap) {
		return authenticateDAO.queryProofTypeListBySerInvokeInsId(inmap) ;
	}

	public List<Map> queryAttrListByProofId(Map<String, Object> inmap) {
		return authenticateDAO.queryAttrListByProofId(inmap) ;
	}

	public List<Map> queryAttrListByProofIdAll(Map<String, Object> inmap) {
		return authenticateDAO.queryAttrListByProofIdAll(inmap) ;
	}

	public void updateAll(String[] proofValuesIds, String[] attrValues) {
		
		ProofValues proofValue = new ProofValues() ;
		for(int i = 0 ; i < proofValuesIds.length ; i++){
			proofValue.setAttrValue(attrValues[i]);
			proofValue.setPvId(Integer.parseInt(proofValuesIds[i]));
			authenticateDAO.updateProofValues(proofValue);
		}
		
	}

	public void deleteAuthenticate(SerInvokeIns serInvokeIns) {
		authenticateDAO.deleteAuthenticate(serInvokeIns) ;
	}

	public String queryCount(Map map) {
		return authenticateDAO.queryCount(map) ;
	}

}
