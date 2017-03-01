package com.ailk.eaap.op2.conf.techImpl.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.CommProtocal;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.ControlCounterms;
import com.ailk.eaap.op2.bo.CtlCounterms2Tech;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.TechImpAtt;
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.conf.techImpl.dao.TechImplDao;

public class TechImplService implements ITechImplService{
	private TechImplDao techImplDao;

	public List<Component> queryComponentInfo(Map map) {
		return techImplDao.queryComponentInfo(map);
	}

	public List<Service> queryServiceList(Map map) {
		return techImplDao.queryServiceList(map);
	}
	public void insertSerTechImpl(SerTechImpl serTechImpl){
		 techImplDao.insertSerTechImpl(serTechImpl);
	}
	public List<Map> queryTechImplList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询总数
    		return techImplDao.queryTechImplCount(map);
    	}else{ //查询信息
    		return techImplDao.queryTechImplList(map);
    	}
	}
	public List<ControlCounterms> queryControlCountermsList(){
		return techImplDao.queryControlCountermsList();
	}
	public void deleteTechImpl(SerTechImpl serTechImpl){
		techImplDao.deleteTechImpl(serTechImpl);
	}
	public void updateSerTechImpl(SerTechImpl serTechImpl){
		techImplDao.updateSerTechImpl(serTechImpl);
	}
	public Service queryService(Service servcie){
		return techImplDao.queryService(servcie);
	}
	public List<Map> queryCfgedTechImplList(Map map){
		if ("ALLNUM".equals(map.get("queryType"))) { //查询总数
    		return techImplDao.queryCfgedTechImplCount(map);
    	}else{ //查询信息
    		return techImplDao.queryCfgedTechImplList(map);
    	}
	}
	public List<Map> querySvcInfoByCompId(Map<String, String> map){
		return techImplDao.querySvcInfoByCompId(map);
	}
	public List<AttrSpec> loadTechImplAttrList(Map map){
		return techImplDao.loadTechImplAttrList(map);
	}
	public Component queryComponent(Component component){
		return techImplDao.queryComponent(component);
	}
	public List<Map> selectCfgedTechImplAtt(Map map){
		return techImplDao.selectCfgedTechImplAtt(map);
	}
	public void insertTechImplCfgInfo(TechImpl techImpl,List<TechImpAtt> techImpAttList,CtlCounterms2Tech ctlCounterms2Tech){
		techImplDao.insertTechImpl(techImpl);
		if (techImpAttList != null && techImpAttList.size() > 0){
			for (TechImpAtt techImpAtt : techImpAttList){
				techImplDao.insertTechImplAtt(techImpAtt);
			}
		}
		techImplDao.insertCtlCounterms2Tech(ctlCounterms2Tech);
	}
	
	public void updateTechImplCfgInfo(TechImpl techImpl,SerTechImpl serTechImpl,List<TechImpAtt> techImpAttList,CtlCounterms2Tech ctlCounterms2Tech){
		techImplDao.updateTechImpl(techImpl);
		techImplDao.updateSerTechImpl(serTechImpl);
		if (techImpAttList != null && techImpAttList.size() > 0){
			for (TechImpAtt techImpAtt : techImpAttList){
				techImplDao.insertTechImplAtt(techImpAtt);
			}
		}
		techImplDao.updateCtlCounterms2Tech(ctlCounterms2Tech);
	}
	
	public void deleteTechImplAtt(TechImpAtt techImpAtt){
		techImplDao.deleteTechImplAtt(techImpAtt);
	}
	public List<CommProtocal> queryCommProtocalList(){
		return techImplDao.queryCommProtocalList();
	}
	
	public List<AttrSpec> queryAtrrSpecList(Map map){
		return techImplDao.queryAtrrSpecList(map);
	}
	
	public String querySerTechImplSeq() {
		return techImplDao.querySerTechImplSeq();
	}

	public String queryTechImpAttSeq() {
		return techImplDao.queryTechImpAttSeq();
	}

	public String queryTechImplSeq() {
		return techImplDao.queryTechImplSeq();
	}
	
	public TechImpl queryTechImpl(TechImpl techImpl){
		return techImplDao.queryTechImpl(techImpl);
	}
	
	public SerTechImpl querySerTechImpl(SerTechImpl serTechImpl){
		return techImplDao.querySerTechImpl(serTechImpl);
	}
	
	public TechImpAtt queryTechImpAtt(TechImpAtt techImpAtt){
		return techImplDao.queryTechImpAtt(techImpAtt);
	}
	
	public CtlCounterms2Tech queryCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech){
		return techImplDao.queryCtlCounterms2Tech(ctlCounterms2Tech);
	}
	public TechImplDao getTechImplDao() {
		return techImplDao;
	}

	public void setTechImplDao(TechImplDao techImplDao) {
		this.techImplDao = techImplDao;
	}
	public List<Map> queryServiceSupplierRegister(Map map){
		return techImplDao.queryServiceSupplierRegister(map);
	}
	public String queryServiceSupplierRegisterCount(Map map){
		return techImplDao.queryServiceSupplierRegisterCount(map);
	}
	public void insertTechImpl(TechImpl techImpl){
		techImplDao.insertTechImpl(techImpl);
	}
	
	public void insertTechImplById(Org org,Component component,CommProtocal commProtocal,TechImpl techImpl,Map maps){
		if (techImpl.getTechImplId() == null) {
			String techImplId = techImplDao.queryTechImplSeq();
			techImpl.setTechImplId(Integer.valueOf(techImplId).intValue());
			techImplDao.insertTechImpl(techImpl);
		}

		Iterator iter = maps.entrySet().iterator();
		while (iter.hasNext()) {
     	Map.Entry entry = (Map.Entry) iter.next();
     	TechImpAtt techImpAtt = new TechImpAtt();   	
        techImpAtt.setTechImpAttId(Integer.parseInt(techImplDao.queryTechImplAttrSpec()));
     	techImpAtt.setAttrSpecId(Integer.parseInt(techImplDao.queryAttrByAttrSpecCode(entry.getKey().toString())));
     	techImpAtt.setAttrSpecValue(entry.getValue().toString());
     	techImpAtt.setTechImplId(techImpl.getTechImplId());
     	techImplDao.insertTechImplAtt(techImpAtt);
		}
		techImpl.setComponentId(techImpl.getComponentId());
		if (commProtocal.getCommProCd() != ""  && commProtocal.getCommProCd()  != null) {
			techImpl.setCommProCd(commProtocal.getCommProCd());
		} else {
			techImpl.setCommProCd(null);
		}
		techImplDao.updateTechImpl(techImpl);
	}
	public List<Map> queryTechAttrSpecById(Map map){
		return techImplDao.queryTechAttrSpecById(map);
	}
	public void updateTechImplById(Org org,Component component,CommProtocal commProtocal,TechImpl techImpl,Map maps){
		Iterator iter = maps.entrySet().iterator();		
		techImplDao.delTechImpAtt(techImpl);
		while (iter.hasNext()) {
     	Map.Entry entry = (Map.Entry) iter.next();
     	TechImpAtt techImpAtt = new TechImpAtt();   	
        techImpAtt.setTechImpAttId(Integer.parseInt(techImplDao.queryTechImplAttrSpec()));
     	techImpAtt.setAttrSpecId(Integer.parseInt(techImplDao.queryAttrByAttrSpecCode(entry.getKey().toString())));
     	techImpAtt.setAttrSpecValue((entry.getValue()==null||entry.getValue().equals(""))? null:entry.getValue().toString());
     	techImpAtt.setTechImplId(techImpl.getTechImplId());
     	techImplDao.insertTechImplAtt(techImpAtt);
		}
		techImpl.setComponentId(techImpl.getComponentId());
		techImpl.setCommProCd(commProtocal.getCommProCd());
		techImplDao.updateTechImpl(techImpl);
	}
	public void deleteCtlCounterms2Tech(Map map){
		techImplDao.deleteCtlCounterms2Tech(map);
	}
	public void updateTechImpl(TechImpl techImpl){
		techImplDao.updateTechImpl(techImpl);
	}
	public List<Map> queryTechImplAttrSpec(Map map){
		return techImplDao.queryTechImplAttrSpec(map);
	}
	public List<Map> queryTechImplAttrSpecAll(){
		return techImplDao.queryTechImplAttrSpecAll();
	}
	public List<Map> queryTechImplUpdate(TechImpl techImpl){
		return techImplDao.queryTechImplUpdate(techImpl);
	}
	/**
	 *  添加技术实现相前记录
	 * @param commProtocal
	 * @param techImpl
	 * @param mapAttr
	 * @return
	 */
	@Override
	public String addTechImplMessage(CommProtocal commProtocal,
			TechImpl techImpl, Map<String, String> mapAttr) {
		if (techImpl.getTechImplId() == null) {
			String techImplId = techImplDao.queryTechImplSeq();
			techImpl.setTechImplId(Integer.valueOf(techImplId).intValue());
			techImpl.setCommProCd(commProtocal.getCommProCd());
			techImpl.setTechImpConPoId(1);//默认值
			techImpl.setUsealbeState("A");
			techImplDao.insertTechImpl(techImpl);
		}
		Iterator iter = mapAttr.entrySet().iterator();
		while (iter.hasNext()) {
     	Map.Entry entry = (Map.Entry) iter.next();
     	TechImpAtt techImpAtt = new TechImpAtt();   	
        techImpAtt.setTechImpAttId(Integer.parseInt(techImplDao.queryTechImplAttrSpec()));
        if(null != entry.getKey()){
        	String value = entry.getKey().toString();
        	String attr_spec_id  = value.substring(0,value.indexOf("_"));
        	techImpAtt.setAttrSpecId(Integer.parseInt(attr_spec_id));
        }
     	if(null !=entry.getValue()){
     		techImpAtt.setAttrSpecValue(entry.getValue().toString());
     	}
     	techImpAtt.setTechImplId(techImpl.getTechImplId());
     	techImpAtt.setState("A");
     	techImplDao.insertTechImplAtt(techImpAtt);
		}
		return techImpl.getTechImplId()+"";
	}

	@Override
	public void updateTechImpl(CommProtocal commProtocal, TechImpl techImpl,
			Map<String, String> mapAttr) {
		Iterator iter = mapAttr.entrySet().iterator();		
		techImplDao.delTechImpAtt(techImpl);
		while (iter.hasNext()) {
     	Map.Entry entry = (Map.Entry) iter.next();
    	TechImpAtt techImpAtt = new TechImpAtt();   	
        techImpAtt.setTechImpAttId(Integer.parseInt(techImplDao.queryTechImplAttrSpec()));
        if(null != entry.getKey()){
        	String value = entry.getKey().toString();
        	String attr_spec_id  = value.substring(0,value.indexOf("_"));
        	techImpAtt.setAttrSpecId(Integer.parseInt(attr_spec_id));
        }
     	if(null !=entry.getValue()){
     		techImpAtt.setAttrSpecValue(entry.getValue().toString());
     	}
     	techImpAtt.setTechImplId(techImpl.getTechImplId());
     	techImpAtt.setState("A");
     	techImplDao.insertTechImplAtt(techImpAtt);
		}
		techImpl.setComponentId(techImpl.getComponentId());
		techImpl.setCommProCd(commProtocal.getCommProCd());
		techImplDao.updateTechImpl(techImpl);
		
	}

	@Override
	public List<Map> queryTechNodeByTechImplId(Map map) {
		// TODO Auto-generated method stub
		
		return techImplDao.queryTechNodeByTechImplId(map);
	}
	
	public void addRouteNode(String techImplId,String routeJson){
		JSONArray jsonArray=new JSONArray();
		JSONArray cacheObjList= jsonArray.fromObject(routeJson);
		Map delParam=new HashMap();
		delParam.put("techImplId", techImplId);
		techImplDao.delRouteNodeByTechImplId(delParam);
		for (Object cacheObj : cacheObjList) {
			Map cacheObjMap = (Map) cacheObj;
			Map param=new HashMap();
			param.put("HOST", cacheObjMap.get("NODE_HOST"));
			param.put("IP", cacheObjMap.get("NODE_IP"));
			param.put("PORT", cacheObjMap.get("NODE_PORT"));
			param.put("TECH_ROUTE_EXPR", cacheObjMap.get("TECH_ROUTE_EXPR"));
			param.put("techImplId", techImplId);
			
			techImplDao.addRouteNode(param);
		}
		
	}
}
