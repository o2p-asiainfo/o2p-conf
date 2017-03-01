package com.ailk.eaap.op2.conf.authenticate.service;

import java.util.List;
import java.util.Map;
import com.ailk.eaap.op2.bo.ProofEffect;
import com.ailk.eaap.op2.bo.ProofValues;
import com.ailk.eaap.op2.bo.SerInvokeIns;

public interface IAuthenticateServ {

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
	 * 查询PROOF_TYPE属性
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
	 * 获取SER_INVOKE_INS服务调用实例
	 * @param serInvokeInsMap
	 * @return
	 */
	List<Map<String, String>> getSerInvokeInsList(
			Map<String, String> serInvokeInsMap);

	/**
	 * 获取已有属性
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
	 * @param proofValuesList
	 * @param proofEffect
	 */
	void addAll(List<ProofValues> proofValuesList, ProofEffect proofEffect);

	/**
	 * 分页
	 * @param map
	 * @return
	 */
	List<Map> showProofEffectList(Map<String, Object> map);

	/**
	 * 增加
	 * @param proofTypeAtrSpecCdValues
	 * @param proofTypePtcdValues
	 * @param attrValues
	 * @param serInvokeInsId
	 */
	void addAllData(String[] proofTypeAtrSpecCdValues,String[] proofTypePtcdValues, String[] attrValues,
			String serInvokeInsId);

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
	 * 根据有效论证标识查询包含的属性(不包含属性值为空的)
	 * @param inmap
	 * @return
	 */
	List<Map> queryAttrListByProofId(Map<String, Object> inmap);

	/**
	 * 根据有效论证标识查询包含的属性(包含属性值为空的)
	 * @param inmap
	 * @return
	 */
	List<Map> queryAttrListByProofIdAll(Map<String, Object> inmap);

	/**
	 * 修改
	 * @param proofValuesIds
	 * @param attrValues
	 */
	void updateAll(String[] proofValuesIds, String[] attrValues);

	void deleteAuthenticate(SerInvokeIns serInvokeIns);

	/**
	 * 查询组件对应服务是否已存在认证
	 * @param serInvokeInsId
	 * @return
	 */
	String queryCount(Map map);
	
}
