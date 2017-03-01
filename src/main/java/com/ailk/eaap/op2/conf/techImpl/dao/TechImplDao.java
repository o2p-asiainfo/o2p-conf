package com.ailk.eaap.op2.conf.techImpl.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.CommProtocal;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.ControlCounterms;
import com.ailk.eaap.op2.bo.CtlCounterms2Tech;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.TechImpAtt;
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NData;
import com.ailk.eaap.op2.bo.i18n.ProvideI18NDatas;
import com.linkage.rainbow.dao.SqlMapDAO;

public class TechImplDao implements ITechImplDao{
	private SqlMapDAO sqlMapDao;

	//技术实现配置-加载组件下拉框可选值
	public List<Component> queryComponentInfo(Map map) {
		return (List<Component>)sqlMapDao.queryForList("component.selectComponentList", map);
	}

	//技术实现配置-加载服务下拉框可选值
	public List<Service> queryServiceList(Map map) {
		return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-monitor-report.queryServiceList", map);
	} 
	
	public Component queryComponent(Component component){
		return (Component)sqlMapDao.queryForObject("component.selectComponent", component);
	}
	
	public Service queryService(Service servcie){
		return (Service)sqlMapDao.queryForObject("service.selectService", servcie);
	}
	
	//技术服务实现配置-总记录数
	public List<Map> queryTechImplCount(Map map) {
		String arrayComponentId = String.valueOf(map.get("componentId"));
		if(null != map.get("componentId") && !"".equals(arrayComponentId)){
			arrayComponentId = arrayComponentId.replace("'", "");
			String [] componentId = arrayComponentId.split(",");
			map.put("arrayComponentId", componentId);
		}
		String arrayServiceId = String.valueOf(map.get("serviceId"));
		if(null != map.get("serviceId") && !"".equals(arrayServiceId)){
			arrayServiceId = arrayServiceId.replace("'", "");
			String [] serviceId = arrayServiceId.split(",");
			map.put("arrayServiceId", serviceId);
		}
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechImplCount", map);
	}
	
	public List<Map> querySvcInfoByCompId(Map<String, String> map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.querySvcInfoByCompId", map);
	}
	
	public List<Map> queryCfgedTechImplCount(Map map){
		String arrayComponentId = String.valueOf(map.get("componentId"));
		if(null != map.get("componentId") && !"".equals(arrayComponentId)){
			arrayComponentId = arrayComponentId.replace("'", "");
			String [] componentId = arrayComponentId.split(",");
			map.put("arrayComponentId", componentId);
		}
		String arrayServiceId = String.valueOf(map.get("serviceId"));
		if(null != map.get("serviceId") && !"".equals(arrayServiceId)){
			arrayServiceId = arrayServiceId.replace("'", "");
			String [] serviceId = arrayServiceId.split(",");
			map.put("arrayServiceId", serviceId);
		}
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryCfgedTechImplCount", map);
	}
	
	public List<Map> queryCfgedTechImplList(Map map){
		String arrayComponentId = String.valueOf(map.get("componentId"));
		if(null != map.get("componentId") && !"".equals(arrayComponentId)){
			arrayComponentId = arrayComponentId.replace("'", "");
			String [] componentId = arrayComponentId.split(",");
			map.put("arrayComponentId", componentId);
		}
		String arrayServiceId = String.valueOf(map.get("serviceId"));
		if(null != map.get("serviceId") && !"".equals(arrayServiceId)){
			arrayServiceId = arrayServiceId.replace("'", "");
			String [] serviceId = arrayServiceId.split(",");
			map.put("arrayServiceId", serviceId);
		}
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryCfgedTechImplList", map);
	}
	//技术服务实现配置-列表
	public List<Map> queryTechImplList(Map map) {
		String arrayComponentId = String.valueOf(map.get("componentId"));
		if(null != map.get("componentId") && !"".equals(arrayComponentId)){
			arrayComponentId = arrayComponentId.replace("'", "");
			String [] componentId = arrayComponentId.split(",");
			map.put("arrayComponentId", componentId);
		}
		String arrayServiceId = String.valueOf(map.get("serviceId"));
		if(null != map.get("serviceId") && !"".equals(arrayServiceId)){
			arrayServiceId = arrayServiceId.replace("'", "");
			String [] serviceId = arrayServiceId.split(",");
			map.put("arrayServiceId", serviceId);
		}
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechImplList", map);
	}
	
	//加载指定属性规格列表
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "attr_spec", columnNames = "ATTR_SPEC_NAME", idName = "attrSpecId", propertyNames = "attrSpecName") 
		}
	)
	public List<AttrSpec> queryAtrrSpecList(Map map){
		return (List<AttrSpec>)sqlMapDao.queryForList("atrrSpec.selectAtrrSpecList", map);
	}
	
	//加载通讯协议列表
	@ProvideI18NDatas(values = { 
			@ProvideI18NData(tableName = "comm_protocal", columnNames = "COMM_PRO_NAME,COMM_PRO_DESC", idName = "commProCd", propertyNames = "commProName,commProDesc")
		}
	)
	public List<CommProtocal> queryCommProtocalList(){
		return (List<CommProtocal>)sqlMapDao.queryForList("commProtocal.selectCommProtocal", null);
	}
	
	//根据通信协议类别加载技术实现配置属性
	public List<AttrSpec> loadTechImplAttrList(Map map){
		return (List<AttrSpec>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.loadTechImplAttrList", map);
	}
	
	//删除服务技术实现配置
	public void deleteTechImpl(SerTechImpl serTechImpl){
		sqlMapDao.update("serTechImpl.updateSerTechImpl", serTechImpl);
	}
	
	public List<Map> selectCfgedTechImplAtt(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.selectCfgedTechImplAtt", map);
	}
	public List<ControlCounterms> queryControlCountermsList(){
		
		Map<String, String> map = new HashMap<String, String>();
		return (List<ControlCounterms>)sqlMapDao.queryForList("controlCounterms.selectControlCounterms", map);
	}
	public TechImpl queryTechImpl(TechImpl techImpl){
		return (TechImpl)sqlMapDao.queryForObject("techImpl.selectTechImpl", techImpl);
	}
	public SerTechImpl querySerTechImpl(SerTechImpl serTechImpl){
		return(SerTechImpl)sqlMapDao.queryForObject("serTechImpl.selectSerTechImpl", serTechImpl);
	}
	public TechImpAtt queryTechImpAtt(TechImpAtt techImpAtt){
		return (TechImpAtt)sqlMapDao.queryForObject("techImpAtt.selectTechImplAtt", techImpAtt);
	}
	public CtlCounterms2Tech queryCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech){
		return (CtlCounterms2Tech)sqlMapDao.queryForObject("ctlCounterms2Tech.selectCtlCounterms2Tech", ctlCounterms2Tech);
	}
	public void deleteTechImplAtt(TechImpAtt techImpAtt){
		sqlMapDao.delete("techImpAtt.deleteTechImplAtt", techImpAtt);
	}
	
	public String querySerTechImplSeq(){
		return (String)sqlMapDao.queryForObject("serTechImpl.selectSerTechImplSeq", null);
	}
	public String queryTechImpAttSeq(){
		return (String)sqlMapDao.queryForObject("techImpAtt.selectTechImpAttSeq", null);
	}
	public String queryTechImplSeq(){
		return (String)sqlMapDao.queryForObject("techImpl.selectTechImplSeq", null);
	}
	
	public void insertCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech) {
		sqlMapDao.insert("ctlCounterms2Tech.insertCtlCounterms2Tech", ctlCounterms2Tech);
	}

	public void insertSerTechImpl(SerTechImpl serTechImpl) {
		sqlMapDao.insert("serTechImpl.insertSerTechImpl", serTechImpl);
	}


	public void insertTechImplAtt(TechImpAtt techImplAtt) {
		sqlMapDao.insert("techImpAtt.insertTechImplAtt", techImplAtt);
	}
	
	public void updateSerTechImpl(SerTechImpl serTechImpl){
		sqlMapDao.update("serTechImpl.updateSerTechImpl", serTechImpl);
	}
	public void updateTechImplAtt(TechImpAtt techImplAtt){
		sqlMapDao.update("techImpAtt.updateTechImplAtt", techImplAtt);
	}
	public void updateTechImpl(TechImpl techImpl){
		sqlMapDao.update("techImpl.updateTechImpl", techImpl);
	}
	public void updateCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech){
		sqlMapDao.update("ctlCounterms2Tech.updateCtlCounterms2Tech", ctlCounterms2Tech);
	}
	
	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
	public List<Map> queryServiceSupplierRegister(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechimplGrid", map);
	}
	public String queryServiceSupplierRegisterCount(Map map){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-techimpl.queryTechimplGridCount", map);
	}
    public void insertAttrSpec(AttrSpec attrSpec){
    	sqlMapDao.insert("atrrSpec.insertAttrSpec", attrSpec);
    }
    public void insertTechImplAttr(TechImpAtt techImpAtt){
    	sqlMapDao.insert("techImpAtt.insertTechImplAtt", techImpAtt);
    }
	public void insertTechImplById(TechImpl techImpl) {
		sqlMapDao.insert("eaap-op2-conf-techimpl.insertTechImplById", techImpl);
	}

	public String queryAttrSpecSeq() {
		return (String)sqlMapDao.queryForObject("atrrSpec.selectatrrSpecSeq", null);
	}
	public void insertTechImpl(TechImpl techImpl){
		sqlMapDao.insert("techImpl.insertTechImpl", techImpl);
	}
	public List<Map> queryTechAttrSpecById(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechAttrSpecById", map);
	}
	public String queryAttrByAttrSpecCode(String attrSpecCode){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryAttrByAttrSpecCode", attrSpecCode);
	}
	public void delTechImpAtt(TechImpl techImpl){
		sqlMapDao.delete("eaap-op2-conf-techimpl.delTechImpAtt", techImpl);
	}
	public String queryTechImplAttrSpec(){
		return (String)sqlMapDao.queryForObject("techImpAtt.selectTechImpAttSeq", null);
	}
	public void deleteCtlCounterms2Tech(Map map){
		sqlMapDao.delete("eaap-op2-conf-techimpl.deleteCtlCounterms2Tech", map);
	}
	public List<Map> queryTechImplAttrSpec(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechImplAttrSpecUpdate", map);
	}
	
	public List<Map> queryTechImplAttrSpecAll(){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechImplAttrSpecAll", null);
	}
	public List<Map> queryTechImplUpdate(TechImpl techImpl){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechImplUpdate", techImpl);
	}
	
	public List<Map> queryTechNodeByTechImplId(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechNodeByTechImplId", map);
	}
	public void addRouteNode(Map param) {
		
		sqlMapDao.insert("eaap-op2-conf-techimpl.addRouteNode", param);
	}

	public void delRouteNodeByTechImplId(Map map){
		sqlMapDao.insert("eaap-op2-conf-techimpl.delRouteNodeByTechImplId", map);
	}
}
