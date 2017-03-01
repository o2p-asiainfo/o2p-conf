package com.ailk.eaap.op2.conf.techImpl.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.AttrSpec;
import com.ailk.eaap.op2.bo.CommProtocal;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.ControlCounterms;
import com.ailk.eaap.op2.bo.CtlCounterms2Tech;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.TechImpAtt;
import com.ailk.eaap.op2.bo.TechImpl;

public interface ITechImplDao {
	public List<Component> queryComponentInfo(Map map);
	public List<Service> queryServiceList(Map map);
	public List<Map> queryTechImplCount(Map map);
	public List<Map> queryTechImplList(Map map);
	public List<Map> queryCfgedTechImplCount(Map map);
	public List<Map> queryCfgedTechImplList(Map map);
	public List<AttrSpec> queryAtrrSpecList(Map map);
	public String querySerTechImplSeq();
	public String queryTechImpAttSeq();
	public String queryTechImplSeq();
	public String queryAttrSpecSeq();
	public void insertSerTechImpl(SerTechImpl serTechImpl);
	public void insertTechImplAtt(TechImpAtt techImplAtt);
	public void insertCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech);
	public void updateSerTechImpl(SerTechImpl serTechImpl);
	public void updateTechImplAtt(TechImpAtt techImplAtt);
	public void updateTechImpl(TechImpl techImpl);
	public void updateCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech);
	public void deleteTechImpl(SerTechImpl serTechImpl);
	public TechImpl queryTechImpl(TechImpl techImpl);
	public SerTechImpl querySerTechImpl(SerTechImpl serTechImpl);
	public TechImpAtt queryTechImpAtt(TechImpAtt techImpAtt);
	public CtlCounterms2Tech queryCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech);
	public List<CommProtocal> queryCommProtocalList();
	public List<AttrSpec> loadTechImplAttrList(Map map);
	public List<Map> selectCfgedTechImplAtt(Map map);
	public void deleteTechImplAtt(TechImpAtt techImpAtt);
	public List<ControlCounterms> queryControlCountermsList();
	List<Map> querySvcInfoByCompId(Map<String, String> map);
	public Component queryComponent(Component component);
	public Service queryService(Service servcie);
	public List<Map> queryServiceSupplierRegister(Map map);
	public String queryServiceSupplierRegisterCount(Map map);
    public void insertAttrSpec(AttrSpec attrSpec);
    public void insertTechImplAttr(TechImpAtt techImpAtt);
	public void insertTechImplById(TechImpl techImpl);
	public void insertTechImpl(TechImpl techImpl);
	public List<Map> queryTechAttrSpecById(Map map);
	public String queryAttrByAttrSpecCode(String attrSpecCode);
	public String queryTechImplAttrSpec();
	public void deleteCtlCounterms2Tech(Map map);
	public List<Map> queryTechImplAttrSpec(Map map);
	public List<Map> queryTechImplAttrSpecAll();
	public List<Map> queryTechImplUpdate(TechImpl techImpl);
	
	public void addRouteNode(Map map);
	public void delRouteNodeByTechImplId(Map map);
}
