package com.ailk.eaap.op2.conf.techImpl.service;

import java.util.Map;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.record.formula.functions.Or;

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
import com.ailk.eaap.op2.conf.techImpl.action.TechImplAction;

public interface ITechImplService {
	public List<Component> queryComponentInfo(Map map);
	public List<Service> queryServiceList(Map map);
	public List<Map> queryTechImplList(Map map);
	public List<AttrSpec> queryAtrrSpecList(Map map);
	public String querySerTechImplSeq();
	public String queryTechImpAttSeq();
	public String queryTechImplSeq();
	public void insertTechImplCfgInfo(TechImpl techImpl,List<TechImpAtt> techImpAttList,CtlCounterms2Tech ctlCounterms2Tech);
	public void updateTechImplCfgInfo(TechImpl techImpl,SerTechImpl serTechImpl,List<TechImpAtt> techImpAttList,CtlCounterms2Tech ctlCounterms2Tech);
	public void deleteTechImpl(SerTechImpl serTechImpl);
	public TechImpl queryTechImpl(TechImpl techImpl);
	public SerTechImpl querySerTechImpl(SerTechImpl serTechImpl);
	public TechImpAtt queryTechImpAtt(TechImpAtt techImpAtt);
	public CtlCounterms2Tech queryCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech);
	public List<CommProtocal> queryCommProtocalList();
	public List<AttrSpec> loadTechImplAttrList(Map map);
	public List<Map> selectCfgedTechImplAtt(Map map);
	public void deleteTechImplAtt(TechImpAtt techImpAtt);
	public List<Map> queryCfgedTechImplList(Map map);
	public void insertSerTechImpl(SerTechImpl serTechImpl); 
	public void updateSerTechImpl(SerTechImpl serTechImpl);
	public List<ControlCounterms> queryControlCountermsList();
	List<Map> querySvcInfoByCompId(Map<String, String> map);
	public Component queryComponent(Component component);
	public Service queryService(Service servcie);
	public List<Map> queryServiceSupplierRegister(Map map);
	public String queryServiceSupplierRegisterCount(Map map);
	public void insertTechImpl(TechImpl techImpl);
	public void insertTechImplById(Org org,Component component,CommProtocal commProtocal,TechImpl techImpl,Map map);
	public List<Map> queryTechAttrSpecById(Map map);
	public void updateTechImplById(Org org,Component component,CommProtocal commProtocal,TechImpl techImpl,Map map);
	public void deleteCtlCounterms2Tech(Map map);
	public void updateTechImpl(TechImpl techImpl);
	public List<Map> queryTechImplAttrSpec(Map map);
	public List<Map> queryTechImplAttrSpecAll();
	public List<Map> queryTechImplUpdate(TechImpl techImpl);
	/**
	 *  添加技术实现相前记录
	 * @param commProtocal
	 * @param techImpl
	 * @param mapAttr
	 * @return
	 */
	public String addTechImplMessage(CommProtocal commProtocal,
			TechImpl techImpl, Map<String, String> mapAttr);
	public void updateTechImpl(CommProtocal commProtocal, TechImpl techImpl,
			Map<String, String> mapAttr);
	
	public List<Map> queryTechNodeByTechImplId(Map map);
	
	public void addRouteNode(String techImplId,String routeJson);
}
