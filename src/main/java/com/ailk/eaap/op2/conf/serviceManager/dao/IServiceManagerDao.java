package com.ailk.eaap.op2.conf.serviceManager.dao;

import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.Api;
import com.ailk.eaap.op2.bo.Area;
import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Contract;
import com.ailk.eaap.op2.bo.ContractVersion;
import com.ailk.eaap.op2.bo.CtlCounterms2Tech;
import com.ailk.eaap.op2.bo.DirSerList;
import com.ailk.eaap.op2.bo.Func2Service;
import com.ailk.eaap.op2.bo.NodeDesc;
import com.ailk.eaap.op2.bo.SerInvokeIns;
import com.ailk.eaap.op2.bo.SerTechImpl;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.bo.ServiceAtt;

public interface IServiceManagerDao {
    public String queryGridCount();//查询列表的数目
    public List<Map> queryService(Map map);//查询服务表
    public void insertServiceManager(Service service);//增加服务管理
    public String selectServiceSeq();//查询服务表的序列
    public void updateServiceManager(Service service);//更新服务表
    public void updateServiceManagerState(Service service);//更新服务表
    public String queryGridCountChoice(Service service);//得到服务表的数据数目
    public List<Service> queryServiceChoice(Map map);//查询服务表
    public List<Service> selectServiceList(Map map);
	public List<Service> queryService(Service service);//查询服务表
	public List<Map> queryAllConstractList(Map map);
    public List<NodeDesc> queryNodeDesc(Map map);//查询节点描述表
    public String queryTreeGridCount(Map map);
    public List<Map> queryDirectory(Map map);//查询所有的目录
    public List<Map> queryDirectoryById(Map map);//通过父节点查询所有的目录
    public List<Map> queryBizFunction(Map map);//查询所有的业务流程
    public List<Map> queryBizFunctionById(Map map);//根据父节点ID查询所有的业务流程
    public List<Map> queryDirSerList(Map map);//根据目录和业务流程等等条件查出所有的数据
    public String queryCountDirSerList(Map map);//根据目录和业务流程等等条件查出所有的数据的数目
    public List<Service> queryRegesiterSerList(Map map);
    public String queryCountRegesiterSerList(Map map);
    public List<Map> queryDefaultFlowList();
    public List<Contract> queryContract(Contract contract);//查询协议表
	public String selectDirSeq();
    public String selectFuncSeq();
    public String selectApiSeq();
    public void insertDirService(DirSerList dirSer);
    public void insertFuncService(Func2Service func2Service);
    public void insertApiService(Api api);
    public Map queryServiceByServiceId(Service service);
    public List<Map> queryDirIdByServiceId(Service service);
    public String queryDirNameByDirId(Map map);
    public List<Map> queryAllPathByDirId(String[] dirId);
    public List<Map> queryFuncIdByServiceId(Service service);
    public String queryFuncNameByDirId(String funcId);
    public List<Map> queryAllPathByFuncId(String[] funcId);
    public Api queryApi(Service service);
    public void delDir(Service service);
    public void delFunc(Service service);
    public void updateApi(Api api);
    public void delServiceApi(Service service);
    public List<Map> queryCommProtocalListList();
    public List<Map> queryServiceSupplierRegister(Map map);
    public String queryServiceSupplierRegisterCount(Map map);
	public List<Map>  queryCC2cInfoListById(Map map);
	public void insertCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech);
	public String querySeqSerTechImpl();
	public void  insertSerTechImpl(SerTechImpl serTechImpl);
	public Map queryServiceSupplierRegisterBySerImplId(Map map);
	public void updateSerTechImpl(SerTechImpl serTechImpl);
	public List<Map> queryTechImplAttrSpec(Map map);
	public Map queryContractByContractVersionId(String contractVersionId);
	public List<Service> compareServiceVersionAndEnName(Service service);
	public List<Map> loadServiceMessgList(Map paraMap);
	public List<Map> queryAllPathByDirId(String dirId);
	public List<Map> queryAllPathByFuncId(String funcId);
    public List<Service> queryRegesiterSerListExcept(Map map);
    public String queryRegesiterSerListExceptCount(Map map);
    public List<Service>  queryServiceList(Service service);
    public List<ContractVersion> queryContractVersionList(ContractVersion contractVersion);
    public List<BizFunction> queryBizFun(BizFunction bizFun);
    
	public int getSeq(String sequenceName);

    public List<SerInvokeIns> querySerInvokeIns(SerInvokeIns serInvokeIns);
	public Integer insertSerInvokeIns(SerInvokeIns serInvokeIns);
	/**
	 * 得到attrSpecID
	 * @param string
	 * @return
	 */
	public String getAttrSpecID(Map aPIachieve);
	/***
	 * 添加服务属性数据
	 * @param serviceAtt
	 */
	public void insertServiceAtt(ServiceAtt serviceAtt);
	/**
	 * 得到服务属性值
	 * @param serviceAtt
	 * @return
	 */
	public String getSerSpecVal(ServiceAtt serviceAtt);
	/**
	 * 修改服务属性值
	 * @param serviceAtt
	 */
	public void updateServiceApi(ServiceAtt serviceAtt);
	
	//创建透传消息流
	public void createDirectMessageFlow(String serTechImplId);
}
