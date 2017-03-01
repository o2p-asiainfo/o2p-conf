package com.ailk.eaap.op2.conf.serviceManager.service;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.Map;

import com.ailk.eaap.op2.bo.Api;
import com.ailk.eaap.op2.bo.Area;
import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.CommProtocal;
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
import com.ailk.eaap.op2.bo.TechImpl;
import com.ailk.eaap.op2.conf.serviceManager.dao.IServiceManagerDao;

public class ServiceManagerServImpl implements IServiceManagerServ{
     private IServiceManagerDao ServiceManagerDao;

	public IServiceManagerDao getServiceManagerDao() {
		return ServiceManagerDao;
	}

	public void setServiceManagerDao(IServiceManagerDao serviceManagerDao) {
		ServiceManagerDao = serviceManagerDao;
	}
     
	public String queryGridCount(){
		return ServiceManagerDao.queryGridCount();
	}//得到服务表的数据数目
	public List<Map> queryService(Map map){
		return ServiceManagerDao.queryService(map);
	}//查询服务表
	public void insertServiceManager(Service service){
		ServiceManagerDao.insertServiceManager(service);
	}//增加服务管理
	public String selectServiceSeq(){
		return ServiceManagerDao.selectServiceSeq();
	}//查询服务表的序列
	public void updateServiceManager(Service service){
		ServiceManagerDao.updateServiceManager(service);
	}//更新服务表
    public void updateServiceManagerState(Service service){
    	ServiceManagerDao.updateServiceManagerState(service);
    }//更新服务表
    public String queryGridCountChoice(Service service){
    	return  ServiceManagerDao.queryGridCountChoice(service);
    }//得到服务表的数据数目
	public List<Service> queryServiceChoice(Map map){
		return ServiceManagerDao.queryServiceChoice(map);
	}//查询服务表
	public List<Service> selectServiceList(Map map){
		return ServiceManagerDao.selectServiceList(map);
	}
	public List<Service> queryService(Service service){
		return ServiceManagerDao.queryService(service);
	}//查询服务表
	public List<Map> queryAllConstractList(Map map){
		return ServiceManagerDao.queryAllConstractList(map);	
	}
    public List<NodeDesc> queryNodeDesc(Map map){
    	return ServiceManagerDao.queryNodeDesc(map);
    }//查询节点描述表
    public String queryTreeGridCount(Map map){
    	return ServiceManagerDao.queryTreeGridCount(map);
    }
    public List<Map> queryDirectory(Map map){
    	return ServiceManagerDao.queryDirectory(map);
    }//查询所有的目录
    public List<Map> queryDirectoryById(Map map){
    	return ServiceManagerDao.queryDirectoryById(map);
    }//根据父节点ID查询所有的目录
    public List<Map> queryBizFunction(Map map){
    	return ServiceManagerDao.queryBizFunction(map);
    }//查询所有的业务流程
    public List<Map> queryBizFunctionById(Map map){
    	return ServiceManagerDao.queryBizFunctionById(map);
    }//根据父节点ID查询所有的业务流程
    public List<Map> queryDirSerList(Map map){
    	return ServiceManagerDao.queryDirSerList(map);
    }//根据目录和业务流程等等条件查出所有的数据
    public String queryCountDirSerList(Map map){
    	return ServiceManagerDao.queryCountDirSerList(map);
    }
    public List<Service> queryRegesiterSerList(Map map){
    	return ServiceManagerDao.queryRegesiterSerList(map);
    }
    public String queryCountRegesiterSerList(Map map){
    	return ServiceManagerDao.queryCountRegesiterSerList(map);
    }
    public List<Map> queryDefaultFlowList(){
    	return ServiceManagerDao.queryDefaultFlowList();
    }
    public List<Contract> queryContract(Contract contract){
    	return ServiceManagerDao.queryContract(contract);
    }//查询协议表
	public String selectDirSeq(){
		return ServiceManagerDao.selectDirSeq();
	}
    public String selectFuncSeq(){
	    return ServiceManagerDao.selectFuncSeq();
    }
    public String selectApiSeq(){
	    return ServiceManagerDao.selectApiSeq();
    }
    public void insertDirService(DirSerList dirSer){
    	ServiceManagerDao.insertDirService(dirSer);
    }
    public void insertFuncService(Func2Service func2Service){
    	ServiceManagerDao.insertFuncService(func2Service);
    }
    public void insertApiService(Api api){
    	ServiceManagerDao.insertApiService(api);
    }
    public Map queryServiceByServiceId(Service service){
    	return ServiceManagerDao.queryServiceByServiceId(service);
    }
    public List<Map> queryDirIdByServiceId(Service service){
    	return ServiceManagerDao.queryDirIdByServiceId(service);
    }
    public String queryDirNameByDirId(String dirId){
    	Map map = new HashMap();
    	map.put("dirId", dirId);
    	return ServiceManagerDao.queryDirNameByDirId(map);
    }
    public List<Map> queryAllPathByDirId(String[] dirId){
    	return ServiceManagerDao.queryAllPathByDirId(dirId);
    }
    public List<Map> queryFuncIdByServiceId(Service service){
    	return ServiceManagerDao.queryFuncIdByServiceId(service);
    }
    public String queryFuncNameByDirId(String funcId){
    	return ServiceManagerDao.queryFuncNameByDirId(funcId);
    }
    public List<Map> queryAllPathByFuncId(String[] funcId){
    	return ServiceManagerDao.queryAllPathByFuncId(funcId);
    }
    public Api queryApi(Service service){
    	return ServiceManagerDao.queryApi(service);
    }
    public void updateServiceRegister(Service service,List<DirSerList> dirSerListOfList,List<Func2Service> func2ServiceList,String ProvideAPIWay,String UserAuthorization,Api api){
    	if (api == null) {
    		api = new Api();
    	}
    	ServiceManagerDao.updateServiceManager(service);
    	ServiceManagerDao.delDir(service);
    	if(dirSerListOfList.size()>0){
    	for(DirSerList dirSerList:dirSerListOfList){
    		ServiceManagerDao.insertDirService(dirSerList);
    	}
    	}
    	ServiceManagerDao.delFunc(service);
    	if(func2ServiceList.size()>0){
        	for(Func2Service func2Service:func2ServiceList){
        		ServiceManagerDao.insertFuncService(func2Service);
        	}
    	}
    	if("1".equals(ProvideAPIWay)){
		if(ServiceManagerDao.queryApi(service)!=null){
			api.setServiceId(service.getServiceId());
			if(UserAuthorization.equals("1")){				
				api.setIsNeedUserAuth("1");				
			}else{
				api.setIsNeedUserAuth("0");
			}
			ServiceManagerDao.updateApi(api);
		}else{
		api.setApiId(service.getServiceId());//与前台流程一致,API表的API_ID = SERVICID
		api.setServiceId(service.getServiceId());
		if(UserAuthorization.equals("1")){
			api.setIsNeedUserAuth("1");
		}else{
			api.setIsNeedUserAuth("0");
		}
		ServiceManagerDao.insertApiService(api);
		}
	}else{
		ServiceManagerDao.delServiceApi(service);
	}
    	}
    public List<Map> queryCommProtocalListList(){
    	return ServiceManagerDao.queryCommProtocalListList();
    }

	public List<Map> queryServiceSupplierRegister(Map map) {
		return ServiceManagerDao.queryServiceSupplierRegister(map);
	}
	public String queryServiceSupplierRegisterCount(Map map){
		return ServiceManagerDao.queryServiceSupplierRegisterCount(map);
	}
	public List<Map>  queryCC2cInfoListById(Map map){
		return (List<Map>)ServiceManagerDao.queryCC2cInfoListById(map);
		
	}
	public void insertCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech){
		ServiceManagerDao.insertCtlCounterms2Tech(ctlCounterms2Tech);
	}
	public String querySeqSerTechImpl(){
		return ServiceManagerDao.querySeqSerTechImpl();
	}
	public void insertSerTechImpl(SerTechImpl serTechImpl){
		ServiceManagerDao.insertSerTechImpl(serTechImpl);
	}
	public Map queryServiceSupplierRegisterBySerImplId(Map map){
		return ServiceManagerDao.queryServiceSupplierRegisterBySerImplId(map);
	}
	public void updateSerTechImpl(SerTechImpl serTechImpl){
		ServiceManagerDao.updateSerTechImpl(serTechImpl);
	}
	public List<Map> queryTechImplAttrSpec(Map map){
		return ServiceManagerDao.queryTechImplAttrSpec(map);
	}
	public Map queryContractByContractVersionId(String contractVersionId){
		return ServiceManagerDao.queryContractByContractVersionId(contractVersionId);
	}
	public List<Service> compareServiceVersionAndEnName(Service service){
		return ServiceManagerDao.compareServiceVersionAndEnName(service);
	}
	public List<Map> loadServiceMessgList(Map paraMap){
		return ServiceManagerDao.loadServiceMessgList(paraMap);
	}
	public List<Map> queryAllPathByDirId(String dirId){
	    return ServiceManagerDao.queryAllPathByDirId(dirId); 
	 }
	public List<Map> queryAllPathByFuncId(String funcId){
	     return ServiceManagerDao.queryAllPathByFuncId(funcId);
	}
    public List<Service> queryRegesiterSerListExcept(Map map){
    	return ServiceManagerDao.queryRegesiterSerListExcept(map);
    }
    public String queryRegesiterSerListExceptCount(Map map){
    	return ServiceManagerDao.queryRegesiterSerListExceptCount(map);
    }
    public List<Service>  queryServiceList(Service service){
    	return ServiceManagerDao.queryServiceList(service);
    }
    public List<ContractVersion>  queryContractVersionList(ContractVersion contractVersion){
    	return ServiceManagerDao.queryContractVersionList(contractVersion);
    }
	public List<BizFunction> queryBizFun(BizFunction bizFun) {
		return ServiceManagerDao.queryBizFun(bizFun);
	}
	
	public int getSeq(String sequenceName){
		return ServiceManagerDao.getSeq(sequenceName);
	}
	
	public List<SerInvokeIns> querySerInvokeIns(SerInvokeIns serInvokeIns){
		return ServiceManagerDao.querySerInvokeIns(serInvokeIns);
	}
	public Integer insertSerInvokeIns(SerInvokeIns serInvokeIns){
		return ServiceManagerDao.insertSerInvokeIns(serInvokeIns) ;
	}
	/**
	 * 得到attrSpecID
	 * @param string
	 * @return
	 */
	@Override
	public String getAttrSpecID(Map aPIachieve) {
		return ServiceManagerDao.getAttrSpecID(aPIachieve);
	}
	/***
	 * 添加服务属性数据
	 * @param serviceAtt
	 */
	@Override
	public void insertServiceAtt(ServiceAtt serviceAtt) {
		ServiceManagerDao.insertServiceAtt(serviceAtt);
	}

	/**
	 * 得到服务属性值
	 */
	@Override
	public String getSerSpecVal(ServiceAtt serviceAtt) {
		return ServiceManagerDao.getSerSpecVal(serviceAtt);
	}
	/**
	 * 修改服务属性值
	 * @param serviceAtt
	 */
	@Override
	public void updateServiceApi(ServiceAtt serviceAtt) {
		ServiceManagerDao.updateServiceApi(serviceAtt);
	}
	
	//创建透传消息流
	public void createDirectMessageFlow(String serTechImplId){
		ServiceManagerDao.createDirectMessageFlow(serTechImplId);
	}
}
