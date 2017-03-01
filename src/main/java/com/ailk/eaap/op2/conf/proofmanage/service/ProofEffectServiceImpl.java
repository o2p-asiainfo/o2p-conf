package com.ailk.eaap.op2.conf.proofmanage.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.conf.proofmanage.dao.IProofEffectDao;
import com.ailk.eaap.op2.conf.proofmanage.model.ProofType;

public class ProofEffectServiceImpl implements IProofEffectService {

	private IProofEffectDao proofeffectDao;

	public IProofEffectDao getProofeffectDao() {
		return proofeffectDao;
	}

	public void setProofeffectDao(IProofEffectDao proofeffectDao) {
		this.proofeffectDao = proofeffectDao;
	}
	/**
	 * 获得所有有效认证类型
	 * @return
	 */
	 
	public List<ProofType> getAllProofType() {
		return proofeffectDao.getAllProofType();
	}
	/**
	 * 获得有效验证的列表
	 * @param Map
	 * @return
	 */
	 
	public List<Map> getAllProofInstance(Map map) {
		return proofeffectDao.getAllProofInstance(map);
	}
	/**
	 * 获得有效验证的记录数
	 * @param Map
	 * @return
	 */
	 
	public String queryAllProofInstanceCount(Map map) {
		return proofeffectDao.queryAllProofInstanceCount(map);
	}
	/**
	 * 得到所有属性规格的记录数
	 * @param Map
	 * @return
	 */
	 
	public String queryAllAttrSpecValue(Map map) {
		return proofeffectDao.queryAllAttrSpecValue(map);
	}
	/**
	 * 得到所有属性规格的值
	 * @param Map
	 * @return
	 */
	 
	public List<Map> getAllAttrSpecValule(Map map) {
		return proofeffectDao.getAllAttrSpecValule(map);
	}

	/**
	 * 得到配置好的属性值记录数
	 * @param Map
	 * @return
	 */
	 
	public String queryAllAttrValue(Map map) {
		return proofeffectDao.queryAllAttrValue(map);
	}
	/**
	 * 得到配置好的属性值列表
	 * @param Map
	 * @return
	 */
	 
	public List<Map> getAllAttrValule(Map map) {
		return proofeffectDao.getAllAttrValule(map);
	}
	/**
	 * 获得认证类型属性规格记录
	 * @param Map
	 * @return
	 */
	 
	public String queryAllPrAttrValue(Map map) {
		return proofeffectDao.queryAllPrAttrValue(map);
	}
	/**
	 * 获得认证类型属性规格列表
	 * @param Map
	 * @return
	 */
	 
	public List<Map> getAllPrAttrValule(Map map) {
		return proofeffectDao.getAllPrAttrValule(map);
	}
	/**
	 * 添加认证类型属性规格
	 * @param map
	 */
	 
	public void addPrAttrSpecValue(Map<String, String> map) {
		proofeffectDao.addPrAttrSpecValue(map);
	}
	/**
	 * 删除认证类型属性规格配置
	 * @param map
	 */
	 
	public void delPrAttrSpecValue(Map<String, String> map) {
		proofeffectDao.delPrAttrSpecValue(map);
	}
	/**
	 * 获得有效认证当前最新记录ID
	 * @return
	 */
	 
	public String getMaxProofId() {
		return proofeffectDao.getMaxProofId();
	}
	/**
	 * 添加有效认证记录
	 * @param map
	 */
	 
	public void addProofEffect(Map<String, String> map) {
		proofeffectDao.addProofEffect(map);
	}
	/**
	 * 添加认证属性值
	 * @param map
	 */
	 
	public void addAttrValues(Map<String, String> map) {
		proofeffectDao.addAttrValues(map);
	}
	/**
	 * 删除认证属性值
	 * @param map
	 */
	 
	public void delProofValues(Map<String, String> map) {
		proofeffectDao.delProofValues(map);
	}
	/**
	 * 由认证ID删除认证属性值
	 * @param map
	 */
	 
	public void delProofValuesBuProofId(Map<String, String> map) {
		proofeffectDao.delProofValuesBuProofId(map);
	}
	/**
	 * 删除有效验证实例
	 * @param map
	 */
	 
	public void delProofEffect(Map<String, String> map) {
		proofeffectDao.delProofEffect(map);
	}
	/**
	 * 由认证类型得到所有的认证类型属性规格
	 * @param pt_cd
	 * @return
	 */
	 
	public List<Map> getAllAttrValueByType(Map map) {
		return proofeffectDao.getAllAttrValueByType( map);
	}
	/**
	 * 查看有效认证配置
	 * @param map
	 * @return
	 */
	 
	public List<Map> getAllAttrValueByMap(Map<String, String> map) {
		return proofeffectDao.getAllAttrValueByMap(map);
	}
	/**
	 * 得到页面显示的值
	 * @param paMap
	 * @return
	 */
	 
	public String getShowPageValue(Map<String, String> paMap) {
		return proofeffectDao.getShowPageValue(paMap);
	}
	/**
	 * 取得有效认证关联表的最大ID
	 * @return
	 */
	 
	public String getMidMaxID() {
		return proofeffectDao.getMidMaxID();
	}
	/**
	 * 添加有效认证关联表记录
	 * @param paramMap
	 */
	 
	public void addProoefMid(Map<String, String> paramMap) {
		proofeffectDao.addProoefMid(paramMap);
	}
	/**
	 * 获得该调用实例的所有认证
	 * @param serInvokeInsId
	 * @return
	 */
	 
	public List<Map> getSerInvokerProoef(Map map) {
		return proofeffectDao.getSerInvokerProoef(map);
	}
	/**
	 * 删除所有记录
	 * @param serInvokeInsId
	 */
	 
	public void deleteAllProoefMidById(Map map) {
		proofeffectDao.deleteAllProoefMidById(map);
	}
	/**
	 * 由服务调用实例得到webservice的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	 
	public List<Map<String, String>> getWebServiceMsg(Map map) {
		return proofeffectDao.getWebServiceMsg(map);
	}
	/**
	 * 由服务调用实例得到webservice api的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	 
	public List<Map<String, String>> getWebServiceApiMsg(
			Map map) {
			return proofeffectDao.getWebServiceApiMsg(map);
	}
	/**
	 * 由服务调用实例得到rest的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	 
	public List<Map<String, String>> getRestAddress(Map map) {
		return proofeffectDao.getRestAddress(map);
	}
	/**
	 * 由服务调用实例得到http的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	 
	public List<Map<String, String>> getHttpAddress(Map map) {
		return proofeffectDao.getHttpAddress(map);
	}
	/**
	 * 修改证属性值
	 * @param paramMap
	 */
	@Override
	public void updateAttrValues(Map<String, String> paramMap) {
		proofeffectDao.updateAttrValues(paramMap);
	}
	/**
	 * 查看记录有没有被用
	 * @param proofe_id
	 * @return
	 */
	@Override
	public int countRecourds(Map map) {
		return proofeffectDao.countRecourds(map);
	}
}
