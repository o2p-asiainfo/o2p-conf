package com.ailk.eaap.op2.conf.proofmanage.service;

import java.util.Map;
import java.util.List;

import com.ailk.eaap.op2.conf.proofmanage.model.ProofType;

/**
 * 有效验证管理接口方法
 * @author MAWL
 *
 */
public interface IProofEffectService {

	/**
	 * 获得所有有效认证类型
	 * @return
	 */
	public List<ProofType> getAllProofType();

	/**
	 * 获得有效验证的列表
	 * @param Map
	 * @return
	 */
	public List<Map> getAllProofInstance(Map map);

	/**
	 * 获得有效验证的记录数
	 * @param Map
	 * @return
	 */
	public String queryAllProofInstanceCount(Map map);

	/**
	 * 得到所有属性规格的记录数
	 * @param Map
	 * @return
	 */
	public String queryAllAttrSpecValue(Map map);

	/**
	 * 得到所有属性规格的值
	 * @param Map
	 * @return
	 */
	public List<Map> getAllAttrSpecValule(Map map);

	/**
	 * 得到配置好的属性值记录数
	 * @param Map
	 * @return
	 */
	public String queryAllAttrValue(Map map);

	/**
	 * 得到配置好的属性值列表
	 * @param Map
	 * @return
	 */
	public List<Map> getAllAttrValule(Map map);

	/**
	 * 获得认证类型属性规格记录
	 * @param Map
	 * @return
	 */
	public String queryAllPrAttrValue(Map map);

	/**
	 * 获得认证类型属性规格列表
	 * @param Map
	 * @return
	 */
	public List<Map> getAllPrAttrValule(Map map);

	/**
	 * 添加认证类型属性规格
	 * @param map
	 */
	public void addPrAttrSpecValue(Map<String, String> map);

	/**
	 * 删除认证类型属性规格配置
	 * @param map
	 */
	public void delPrAttrSpecValue(Map<String, String> map);

	/**
	 * 获得有效认证当前最新记录ID
	 * @return
	 */
	public String getMaxProofId();
	/**
	 * 添加有效认证记录
	 * @param map
	 */
	public void addProofEffect(Map<String, String> map);

	/**
	 * 添加认证属性值
	 * @param map
	 */
	public void addAttrValues(Map<String, String> map);

	/**
	 * 删除认证属性值
	 * @param map
	 */
	public void delProofValues(Map<String, String> map);

	/**
	 * 由认证ID删除认证属性值
	 * @param map
	 */
	public void delProofValuesBuProofId(Map<String, String> map);

	/**
	 * 删除有效验证实例
	 * @param map
	 */
	public void delProofEffect(Map<String, String> map);

	/**
	 * 由认证类型得到所有的认证类型属性规格
	 * @param pt_cd
	 * @return
	 */
	public List<Map> getAllAttrValueByType(Map map);

	/**
	 * 查看有效认证配置
	 * @param map
	 * @return
	 */
	public List<Map> getAllAttrValueByMap(Map<String, String> map);

	/**
	 * 得到页面显示的值
	 * @param paMap
	 * @return
	 */
	public String getShowPageValue(Map<String, String> paMap);

	/**
	 * 取得有效认证关联表的最大ID
	 * @return
	 */
	public String getMidMaxID();

	/**
	 * 添加有效认证关联表记录
	 * @param paramMap
	 */
	public void addProoefMid(Map<String, String> paramMap);

	/**
	 * 获得该调用实例的所有认证
	 * @param serInvokeInsId
	 * @return
	 */
	public List<Map> getSerInvokerProoef(Map map);

	/**
	 * 删除所有记录
	 * @param serInvokeInsId
	 */
	public void deleteAllProoefMidById(Map map);

	/**
	 * 由服务调用实例得到webservice的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	public List<Map<String, String>> getWebServiceMsg(Map map);

	/**
	 * 由服务调用实例得到webservice api的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	public List<Map<String, String>> getWebServiceApiMsg(
			Map map);

	/**
	 * 由服务调用实例得到rest的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	public List<Map<String, String>> getRestAddress(Map map);
	/**
	 * 由服务调用实例得到http的调用地址
	 * @param serInvokeInsId
	 * @return
	 */
	public List<Map<String, String>> getHttpAddress(Map map);

	/**
	 * 修改证属性值
	 * @param paramMap
	 */
	public void updateAttrValues(Map<String, String> paramMap);

	/**
	 * 查看记录有没有被用
	 * @param proofe_id
	 * @return
	 */
	public int countRecourds(Map map);

}
