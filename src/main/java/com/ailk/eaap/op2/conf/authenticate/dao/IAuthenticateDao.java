package com.ailk.eaap.op2.conf.authenticate.dao;

import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;

public interface IAuthenticateDao {

	/**
	 * 加载组件COMPONENT表数据
	 * @param componentMap
	 * @return
	 */
	List<Map<String, String>> getComponentList(Map<String, String> componentMap);

	/**
	 * 加载服务SERVICE表数据
	 * @param serviceMap
	 * @return
	 */
	List<Map<String, String>> getServiceList(Map<String, String> serviceMap);

	/**
	 * 加载认证类型PROOF_TYPE表数据
	 * @param proofTypeMap
	 * @return
	 */
	List<Map<String, Object>> getProofTypeList(Map<String, String> proofTypeMap);

	/**
	 * 查询属性值
	 * @param map
	 * @return
	 */
	List<Map<String, String>> queryProofAttr(Map<String, Object> map);

	/**
	 * 获取序列
	 * @return
	 */
	String getProofEffectSEQ();

	/**
	 * 增加
	 * @param serInvokeIns
	 */
	void addProofEffect(ProofEffect proofEffect);

	/**
	 * 获取SER_INVOKE_INS服务调用实例
	 * @param serInvokeInsMap
	 * @return
	 */
	List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap);

	/**
	 * 获取已有属性值
	 * @param map
	 * @return
	 */
	List<Map<String, String>> queryExistsAttr(Map<String, Object> map);

	/**
	 * 删除
	 * @param proofEffect
	 */
	void deleteProofEffect(ProofEffect proofEffect);

	/**
	 * 获取PROOF_VALUES表序列
	 * @return
	 */
	String getProofValuesSEQ();

	/**
	 * 新增
	 * @param proofValues
	 */
	void addProofValues(ProofValues proofValues);

	/**
	 * 查询总条数
	 * @param map
	 * @return
	 */
	List<Map> queryProofEffectCount(Map<String, Object> map);

	/**
	 * 每页显示的数据
	 * @param map
	 * @return
	 */
	List<Map> showProofEffectList(Map<String, Object> map);

	/**
	 * 根据PROOFE_ID查出对应的属性信息
	 * @param proofEffect
	 * @return
	 */
	List<Map> getAttrByProofeId(ProofEffect proofEffect);

	/**
	 * 根据服务调用实例ID查 包含的认证类型
	 * @param inmap
	 * @return
	 */
	List<Map> queryProofTypeListBySerInvokeInsId(
			Map<String, Object> inmap);

	/**
	 * 根据有效论证标识查询包含的属性(不包括属性值为空的)
	 * @param inmap
	 * @return
	 */
	List<Map> queryAttrListByProofId(Map<String, Object> inmap);

	/**
	 * 根据有效论证标识查询包含的属性(包括属性值为空的)
	 * @param inmap
	 * @return
	 */
	List<Map> queryAttrListByProofIdAll(Map<String, Object> inmap);

	/**
	 * 修改属性值表
	 * @param proofValue
	 */
	void updateProofValues(ProofValues proofValue);

	void deleteAuthenticate(SerInvokeIns serInvokeIns);

	/**
	 * 查询组件对应服务是否已存在认证
	 * @param serInvokeInsId
	 * @return
	 */
	String queryCount(Map map);


}
