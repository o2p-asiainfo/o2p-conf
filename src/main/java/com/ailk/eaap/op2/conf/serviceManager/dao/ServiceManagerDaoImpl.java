package com.ailk.eaap.op2.conf.serviceManager.dao;

import java.io.PrintWriter;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

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
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.foundation.log.Logger;
import com.linkage.rainbow.dao.SqlMapDAO;

public class ServiceManagerDaoImpl implements IServiceManagerDao{
	private Logger log = Logger.getLog(this.getClass());
	private SqlMapDAO sqlMapDao;

	public SqlMapDAO getSqlMapDao() {
		return sqlMapDao;
	}

	public void setSqlMapDao(SqlMapDAO sqlMapDao) {
		this.sqlMapDao = sqlMapDao;
	}
    
    public String queryGridCount(){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryGridCount", null);
    }
    public List<Map> queryService(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryService", map);
    } 
	public void insertServiceManager(Service service){
		sqlMapDao.insert("eaap-op2-conf-serviceManager.insertServiceManager", service);
	}//增加服务管理
	public String selectServiceSeq(){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.selectServiceSeq", null);
	}//查询服务表的序列
	public void updateServiceManager(Service service){
		sqlMapDao.update("eaap-op2-conf-serviceManager.updateServiceManager", service);
	}//更新服务表
    public void updateServiceManagerState(Service service){
    	sqlMapDao.update("eaap-op2-conf-serviceManager.updateServiceManagerState", service);
    }//更新服务表状态
    public String queryGridCountChoice(Service service){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryGridCountChoice", service);
    }//得到服务表的数据数目
    public List<Service> queryServiceChoice(Map map){
    	return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryServiceChoice", map);
    }//查询服务表有条件下
    public List<Service> selectServiceList(Map map){
    	return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.selectServiceList", map);
    }
    public List<Service> queryService(Service service){
    	return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.showService", service);
    }//查询服务表
	public List<Map> queryAllConstractList(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryAllConstarctList", map); 
	}
    public List<NodeDesc> queryNodeDesc(Map map){
    	return (List<NodeDesc>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryNodeDesc", map);
    }//查询节点描述表
    public String queryTreeGridCount(Map map){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryTreeGridCount", map);
    }
    public List<Map> queryDirectory(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryDirectoryTreeRoot", map);
    }//查询所有的目录
    public List<Map> queryDirectoryById(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryDirectoryNodeById", map);
    }//查询所有的目录
    public List<Map> queryBizFunction(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryBizFunctionTreeRoot", map);
    }//查询所有的业务流程
    public List<Map> queryBizFunctionById(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryBizFunctionNodeById", map);
    }//根据父节点ID查询所有的业务流程
    public List<Map> queryDirSerList(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryDirSerList",map);
    }//根据目录和业务流程等等条件查出所有的数据
    public String queryCountDirSerList(Map map){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryCountDirSerList",map);
    }//根据目录和业务流程等等条件查出所有的数据的数目
    public List<Service> queryRegesiterSerList(Map map){
    	return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryRegesiterSerList",map);
    }
    public String queryCountRegesiterSerList(Map map){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryCountRegesiterSerList",map);
    }
    public List<Map> queryDefaultFlowList(){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryDefaultFlowList",null);
    }
    public List<Contract> queryContract(Contract contract){
    	return (List<Contract>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.showContract", contract);
    }//查询协议表
	public String selectDirSeq(){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.selectDirSeq", null);
	}
    public String selectFuncSeq(){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.selectFuncSeq", null);
    }
    public String selectApiSeq(){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.selectApiSeq", null);
    }
    public void insertDirService(DirSerList dirSer){
    	sqlMapDao.insert("eaap-op2-conf-serviceManager.insertDirService", dirSer);
    }
    public void insertFuncService(Func2Service func2Service){
    	sqlMapDao.insert("eaap-op2-conf-serviceManager.insertFuncService", func2Service);
    }
    public void insertApiService(Api api){
    	sqlMapDao.insert("eaap-op2-conf-serviceManager.insertApiService", api);
    }
    public Map queryServiceByServiceId(Service service){
    	return (Map)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryServiceByServiceId", service);
    }
    public List<Map> queryDirIdByServiceId(Service service){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryDirIdByServiceId", service);
    }
    public String queryDirNameByDirId(Map map){
    	
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryDirNameByDirId", map);
    }
    public List<Map> queryAllPathByDirId(String[] dirId){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryAllPathByDirId", dirId);
    }
    public List<Map> queryFuncIdByServiceId(Service service){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryFuncIdByServiceId", service);
    }
    public String queryFuncNameByDirId(String funcId){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryFuncNameByDirId", funcId);
    }
    public List<Map> queryAllPathByFuncId(String[] funcId){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryAllPathByFuncId", funcId);
    }
    public Api queryApi(Service service){
    	return (Api)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryApi", service);
    }
    public void delDir(Service service){
    	sqlMapDao.delete("eaap-op2-conf-serviceManager.delDir", service);
    }
    public void delFunc(Service service){
    	sqlMapDao.delete("eaap-op2-conf-serviceManager.delFunc", service);
    }
    public void updateApi(Api api){
    	sqlMapDao.update("eaap-op2-conf-serviceManager.updateApi", api);
    }
    public void delServiceApi(Service service){
    	sqlMapDao.delete("eaap-op2-conf-serviceManager.delServiceApi", service);
    }
    public List<Map> queryCommProtocalListList(){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryCommProtocalListList", null);
    }
    public List<Map> queryServiceSupplierRegister(Map map){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryServiceSupplierRegister", map);
    }
    public String queryServiceSupplierRegisterCount(Map map){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryServiceSupplierRegisterCount", map);
    }
	public List<Map>  queryCC2cInfoListById(Map map){
		if("ALLNUM".equals(String.valueOf(map.get("queryType")))){
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryCC2cInfoListByIdCount", map) ;
		}else{
			return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryCC2cInfoListById", map) ;
		}
		
	}	
	public void insertCtlCounterms2Tech(CtlCounterms2Tech ctlCounterms2Tech){
		sqlMapDao.insert("eaap-op2-conf-serviceManager.insertCtlCounterms2Tech", ctlCounterms2Tech);
	}
	public String querySeqSerTechImpl(){
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.querySeqSerTechImpl", null);
	}
	public void insertSerTechImpl(SerTechImpl serTechImpl){
		sqlMapDao.insert("eaap-op2-conf-serviceManager.insertSerTechImpl", serTechImpl);
	}
	public Map queryServiceSupplierRegisterBySerImplId(Map map){
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryServiceSupplierRegisterBySerImplId", map);
	}
	public void updateSerTechImpl(SerTechImpl serTechImpl){
		sqlMapDao.update("serTechImpl.updateSerTechImpl", serTechImpl);
	}
	public List<Map> queryTechImplAttrSpec(Map map){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-techimpl.queryTechImplAttrSpec", map);
	}
	public Map queryContractByContractVersionId(String contractVersionId){
		return (Map)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryContractByContractVersionId", contractVersionId);
	}
	public List<Service> compareServiceVersionAndEnName(Service service){
		return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.compareServiceVersionAndEnName", service); 
	}
	public List<Map> loadServiceMessgList(Map paraMap){
		return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryMessgFlowByServiceId", paraMap);
	}
	public List<Map> queryAllPathByDirId(String dirId){
		 return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryAllPathByDirId", dirId);
	 }
    public List<Map> queryAllPathByFuncId(String funcId){
    	return (List<Map>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryAllPathByFuncId", funcId);
	}
    public List<Service> queryRegesiterSerListExcept(Map map){
    	return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryRegesiterSerListExcept",map);
    }
    public String queryRegesiterSerListExceptCount(Map map){
    	return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.queryRegesiterSerListExceptCount",map);
    }
    public List<Service>  queryServiceList(Service service){
    	return (List<Service>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.showServiceInfo", service);
    }
    public List<ContractVersion>  queryContractVersionList(ContractVersion contractVersion){
    	return (List<ContractVersion>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.showContractVersion",contractVersion);
    }
	public List<BizFunction> queryBizFun(BizFunction bizFun) {
		return (List<BizFunction>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.queryBizFunction",bizFun);
	}
	
	
	public int getSeq(String sequenceName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sequenceName", sequenceName);
		return (Integer)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.getSeq", map);
	}

    public List<SerInvokeIns> querySerInvokeIns(SerInvokeIns serInvokeIns){
    	return (List<SerInvokeIns>)sqlMapDao.queryForList("eaap-op2-conf-serviceManager.querySerInvokeIns", serInvokeIns);
    }

	public Integer insertSerInvokeIns(SerInvokeIns serInvokeIns){
		return (Integer)sqlMapDao.insert("serInvokeIns.insertSerInvokeIns", serInvokeIns) ;
	}
	
	/**
	 * 得到attrSpecID
	 * @param string
	 * @return
	 */
	@Override
	public String getAttrSpecID(Map aPIachieve) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.getAttrSpecID", aPIachieve);
	}
	/***
	 * 添加服务属性数据
	 * @param serviceAtt
	 */
	@Override
	public void insertServiceAtt(ServiceAtt serviceAtt) {
		sqlMapDao.insert("eaap-op2-conf-serviceManager.insertServiceAtt", serviceAtt);
	}
	/**
	 * 得到服务属性值
	 * @param serviceAtt
	 * @return
	 */
	@Override
	public String getSerSpecVal(ServiceAtt serviceAtt) {
		return (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.getSerSpecVal", serviceAtt);
	}

	/**
	 * 修改服务属性值
	 * @param serviceAtt
	 */
	@Override
	public void updateServiceApi(ServiceAtt serviceAtt) {
		sqlMapDao.update("eaap-op2-conf-serviceManager.updateServiceApi", serviceAtt);
	}
	


	//创建一个透传的消息流，并调用服务技术实现:
	public void createDirectMessageFlow(String serTechImplId){
		try {
			String techImplName  = (String)sqlMapDao.queryForObject("eaap-op2-conf-serviceManager.getTechImplName", serTechImplId);  //根据服务技术实现ID获取技术实现名称
			
			Integer messageFlowId		= this.getSeq("SEQ_MESSAGE_FLOW");	//消息流ID
			Integer beginEndpointId 	= this.getSeq("SEQ_ENDPOINT");		//开始端点ID
			Integer callEndpointId 		= this.getSeq("SEQ_ENDPOINT");		//调用端点ID
			Integer endEndpointId		= this.getSeq("SEQ_ENDPOINT");		//结束端点ID

			String bMapCodeVml	= "<span id=\"E"+beginEndpointId+"\" style=\"CURSOR: hand; HEIGHT: 35px; WIDTH: 35px; BACKGROUND: url(../resource/common/images/messageArray/endpointSpec/start.png) no-repeat center 50%; POSITION: absolute; LEFT: 109px; Z-INDEX: 1; TOP: 46px\"/><div id=\"T"+beginEndpointId+"\" style=\"background-color:#CEDEF0;position:absolute;left:230;top:180;width:75;height35;textalign:center;fontsize:9pt;word-break:break-all;overflow:hidden;z-index:0\">Begin</div>";
			String cMapCodeVml		= "<span id=\"E"+callEndpointId+"\" style=\"CURSOR: hand; HEIGHT: 35px; WIDTH: 35px; BACKGROUND: url(../resource/common/images/messageArray/endpointSpec/webservice.png) no-repeat center 50%; POSITION: absolute; LEFT: 302px; Z-INDEX: 1; TOP: 63px\"/><div id=\"T"+callEndpointId+"\" style=\"background-color:#CEDEF0;position:absolute;left:230;top:180;width:75;height35;textalign:center;fontsize:9pt;word-break:break-all;overflow:hidden;z-index:0\">Call</div>";
			String eMapCodeVml	= "<span id=\"E"+endEndpointId+"\" style=\"CURSOR: hand; HEIGHT: 35px; WIDTH: 35px; BACKGROUND: url(../resource/common/images/messageArray/endpointSpec/end.png) no-repeat center 50%; POSITION: absolute; LEFT: 458px; Z-INDEX: 1; TOP: 46px\"/><div id=\"T"+endEndpointId+"\" style=\"background-color:#CEDEF0;position:absolute;left:230;top:180;width:75;height35;textalign:center;fontsize:9pt;word-break:break-all;overflow:hidden;z-index:0\">End</div>";
			
			//创建端点：
			saveEndpoint(beginEndpointId, messageFlowId, 7, bMapCodeVml, "Begin");		// 7：  Begin 开始端点
			saveEndpoint(callEndpointId, messageFlowId, 6, cMapCodeVml, "Call");				// 6：  Call 调用端点
			saveEndpoint(endEndpointId, messageFlowId, 11, eMapCodeVml, "End");			// 11：End 结束端点
						
			//端点属性值：
			Map endpointAttrValueMap=new HashMap();
			endpointAttrValueMap.put("endpoint_Id", callEndpointId);			//调用端点ID
			endpointAttrValueMap.put("endpoint_Spec_Attr_Id", 22);  		 	//22:服务技术实现
			endpointAttrValueMap.put("attr_Value", serTechImplId);				//服务技术实现ID
			this.sqlMapDao.insert("eaap-op2-conf-serviceManager.saveEndpointAttrValue", endpointAttrValueMap);
			
			//创建路由：
			String mapCodeVml_1 = "<v:polyline style=\"z-index:2;position:absolute;cursor:hand\" id=\"E"+beginEndpointId+"-E"+callEndpointId+"\" title=\"line_1\" points=\" 146,62.5,286,63.5\" filled=\"f\" strokecolor=\"blue\" strokeweight=\"1pt\"><v:stroke endarrow=\"classic\"/></v:polyline>";
			String mapCodeVml_2 = "<v:polyline style=\"z-index:2;position:absolute;cursor:hand\" id=\"E"+callEndpointId+"-E"+endEndpointId+"\" title=\"line_1\" points=\" 321,63.5,455,62.5\" filled=\"f\" strokecolor=\"blue\" strokeweight=\"1pt\"><v:stroke endarrow=\"classic\"/></v:polyline>";
			saveServiceRouteConfig(messageFlowId, beginEndpointId, callEndpointId, mapCodeVml_1);	//路径1
			saveServiceRouteConfig(messageFlowId, callEndpointId, endEndpointId, mapCodeVml_2);		//路径2
			
			//保存消息流：
			Map messageMap=new HashMap();
			messageMap.put("message_Flow_Id",messageFlowId);
			messageMap.put("message_Flow_Name",techImplName+"_MsgFlow");
			messageMap.put("first_Endpoint_Id",beginEndpointId);
			messageMap.put("state","A");
			messageMap.put("descriptor", "");
			this.sqlMapDao.insert("eaap-op2-conf-serviceManager.saveMessageFlow", messageMap);
			
			//对应服务的默认消息流更新为新创建的透传消息流:
			Map upMap=new HashMap();
			upMap.put("messageFlowId",messageFlowId);
			upMap.put("serTechImplId",serTechImplId);
			this.sqlMapDao.update("eaap-op2-conf-serviceManager.updateServiceDefaultMsgFlow", upMap);
			
		}  catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
	}
	//创建端点
	public void saveEndpoint(Integer endpointId, Integer messageFlowId, Integer endpointSpecId, String bMapCodeVml, String endpointName){
		Map endpointMap=new HashMap();
		endpointMap.put("endpoint_Id", endpointId);
		endpointMap.put("message_Flow_Id", messageFlowId);
		endpointMap.put("endpoint_Spec_Id", endpointSpecId);  						//7: Begin 开始端点，6：Call 调用端点，11：End 结束端点
		endpointMap.put("in_Data_Type_Id", 1);
		endpointMap.put("out_Data_Type_Id", 1);
		endpointMap.put("endpoint_Name", endpointName);
		endpointMap.put("endpoint_Code", endpointId);
		endpointMap.put("enable_In_Trace", "Y");
		endpointMap.put("enable_Out_Trace", "Y");
		endpointMap.put("enable_In_Log", "Y");
		endpointMap.put("enable_Out_Log", "Y");
		endpointMap.put("state", "A");
		endpointMap.put("endpoint_Desc", "");
		endpointMap.put("map_Code", bMapCodeVml);
		this.sqlMapDao.insert("eaap-op2-conf-serviceManager.saveEndpoint", endpointMap);
	}
	//创建路由
	public void saveServiceRouteConfig(Integer messageFlowId, Integer fromEndpointId, Integer toEndpointId, String mapCodeVml){		
		Integer routeId 			= this.getSeq("SEQ_SERVICE_ROUTE_CONF");		//路由ID
		Integer routePolicyId = this.getSeq("SEQ_ROUTE_POLI");		//路由规则ID

		//路由规则
		Map  paramRoutePolicyMap =  new HashMap();
		paramRoutePolicyMap.put("rule_Strategy_Id", 1);							//1：DIRECT 直接透传
		paramRoutePolicyMap.put("route_Policy_Id", routePolicyId);
		this.sqlMapDao.insert("eaap-op2-conf-serviceManager.addRoutePolicy", paramRoutePolicyMap);
		
		//路由配置
		Map service_Route_ConfigMap=new HashMap();
		service_Route_ConfigMap.put("route_Id",routeId);
		service_Route_ConfigMap.put("route_Policy_Id",routePolicyId);
		service_Route_ConfigMap.put("message_Flow_Id",messageFlowId);
		service_Route_ConfigMap.put("from_Endpoint_Id", fromEndpointId);
		service_Route_ConfigMap.put("to_Endpoint_Id",toEndpointId);
		service_Route_ConfigMap.put("syn_Asyn","SYN");
		service_Route_ConfigMap.put("state","A");
		service_Route_ConfigMap.put("map_Code", mapCodeVml);
		this.sqlMapDao.insert("eaap-op2-conf-serviceManager.saveService_Route_Config", service_Route_ConfigMap);
	}
	
	
}
