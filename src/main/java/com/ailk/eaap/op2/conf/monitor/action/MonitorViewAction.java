package com.ailk.eaap.op2.conf.monitor.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.List;
import java.util.HashMap;
import java.util.TimeZone;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ailk.eaap.o2p.common.util.date.UTCTimeUtil;
import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.PortalPanel;
import com.ailk.eaap.op2.bo.RegStatRecent;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.common.EAAPConstants;
import com.ailk.eaap.op2.conf.monitor.service.IMonitorViewService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.alibaba.fastjson.JSON;
import com.asiainfo.foundation.common.ExceptionCommon;
import com.asiainfo.foundation.exception.BusinessException;
import com.asiainfo.foundation.log.LogModel;
import com.asiainfo.integration.o2p.web.util.WebPropertyUtil;
import com.linkage.rainbow.ui.paginaction.Pagination;
import com.linkage.rainbow.ui.struts.BaseAction;
import com.workflow.application.para.worklists.WorklistsQueryPara;
import com.workflow.application.worklists.dto.Worklists;
import com.workflow.remote.WorkflowRemoteInterface;

public class MonitorViewAction extends BaseAction{
	/**
	 * ��ֵ�淶:
	 * ��ѯ:query+������(queryApiDocument)
	 * ���ӣ�add+������(addApiDocument)
	 * ɾ��delete+������(deleteApiDocument)
	 * �޸ģ�update+������(updateApiDocument)
	 * չʾ:find+������(findApiDocument)
	 */
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MonitorViewAction.class);
	private IMonitorViewService monitorViewService;
	//����������ѡֵ
	private List<Component> selectComponentList = new ArrayList<Component>();
	//���������ѡֵ
	private List<Org> selectOrgList = new ArrayList<Org>();
	private List<Map> componentList = new ArrayList<Map>();
	//��������б�
	private List<Map> componentSvcList = new ArrayList<Map>();
	//ϵͳ�����б�
	private List<Map> svcPerformanceList = new ArrayList<Map>();
	//ҵ�������б�(����ҵ�����̼��)
	private List<Map> singleBizList = new ArrayList<Map>();
	//ҵ���������ѡֵ
	private List<BizFunction> bizFunctionList = new ArrayList<BizFunction>();
	//�����������ѡֵ
	private List<Service> serviceList = new ArrayList<Service>();
	private Component component = new Component();
	private Org org = new Org();
	private BizFunction bizFunction = new BizFunction();
	private Service service = new Service();
	private Pagination page = new Pagination();
	private int rows;
	private int pages;
	//ˢ������
	private List<String> refreshList = new ArrayList<String>();
	//��ͼ�л�
	private List<String> viewSwitchList = new ArrayList<String>();
	private List<Map> refreshSecondMaps = new ArrayList<Map>();
	private List<Map> viewSwitchMaps = new ArrayList<Map>();
	private String localTime;		//客户端当前时间（秒数，由客户端传入）
	private String timeOffset;		//客户端时间与UTC时间的偏移量（分钟数，由客户端操作系统决定，由客户端传入）
	private int totalRecord;			//总的记录数
	private int totalPage;			//总的页数
	private int currentPage;		//当前是第几页
	private int pageRecord=4;		//每页记录数
	private String searchTime;
	
	public MonitorViewAction (){
	}
	/**
	 * 监控首页主视图
	 * @return
	 */
    public String findMonitorViewIndexNew(){
    	String miniute = getText("eaap.op2.conf.monitor.view.miniute");
    	refreshList.add("1"+" "+miniute);
    	refreshList.add("5"+" "+getText("eaap.op2.conf.monitor.view.miniutes"));
    	
    	String bizView = getText("eaap.op2.conf.monitor.view.bizView");
    	String componentView = getText("eaap.op2.conf.monitor.view.componentView");
    	String svcPerformanceView = getText("eaap.op2.conf.monitor.view.svcPerformanceView");
    	viewSwitchList.add(bizView);
    	viewSwitchList.add(componentView);
    	viewSwitchList.add(svcPerformanceView);
    	
    	Map refreshMap1 = new HashMap();
    	refreshMap1.put("ID", "60000");
    	refreshMap1.put("NAME", "1"+" "+miniute);
    	Map refreshMap2 = new HashMap();
    	refreshMap2.put("ID", "300000");
    	refreshMap2.put("NAME", "5"+" "+getText("eaap.op2.conf.monitor.view.miniutes"));
    	
    	refreshSecondMaps.add(refreshMap1);
    	refreshSecondMaps.add(refreshMap2);
    	
    	Map viewMap1 = new HashMap();
    	viewMap1.put("ID", '1');
    	viewMap1.put("NAME", bizView);
    	Map viewMap2 = new HashMap();
    	viewMap2.put("ID", '2');
    	viewMap2.put("NAME", componentView);
    	Map viewMap3 = new HashMap();
    	viewMap3.put("ID", '3');
    	viewMap3.put("NAME", svcPerformanceView);
    	
    	viewSwitchMaps.add(viewMap1);
    	viewSwitchMaps.add(viewMap2);
    	viewSwitchMaps.add(viewMap3);
    	
    	return SUCCESS;
    }

    
    /**
     * 监控首页主视图获取表配置，个性化定制图表
     * @return json
     */
    public String queryModuleViewInfo(){
    	//TODO ��ȡ��ǰ��¼�ߵ�SYS_PERSON_ID
    	PortalPanel portalPanel = new PortalPanel();
    	portalPanel.setSysPersonId(100001);

    	List<PortalPanel> panelList = getMonitorViewService().queryPortalPanelInfo(portalPanel);
    	
    	JSONArray jsonArr = JSONArray.fromObject(panelList);
    	StringBuffer sb = new StringBuffer();
    	sb.append("{\"rows\":").append(jsonArr.toString()).append("}");
		try {
			PrintWriter  write = getResponse().getWriter();
			write.println(sb.toString());
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    /*
     *  监控视图首页,面板拖动修改显示顺序
     */
    public String savePortalPanelCfg(){
    	String panelId = getRequest().getParameter("panelId");
    	//��ȡԱ�����
//    	Map session = ActionContext.getContext().getSession();
//    	Org orgBean =  (Org)session.get("userBean") ;
    	
    	if (StringUtils.isNotBlank(panelId)){
    		if (panelId.indexOf(",") > 0){
    			String [] idStr = panelId.split(",");
    			if (idStr != null && idStr.length > 0) {
    				PortalPanel portalPanel = null;
    				for (int i = 0;i < idStr.length;i++){
    					portalPanel = new PortalPanel();
    					portalPanel.setDisplaySeq(i);
    					portalPanel.setPortalPanelId(Integer.parseInt(idStr[i]));
    					//TODO Ա����Ŵ��ȡ
    					portalPanel.setSysPersonId(100001);
    					getMonitorViewService().updatePortalPanel(portalPanel);
    				}
    			}
    		}
    	}
    	return NONE;
    }
        
    
    public String getSysViewDataLine() throws ParseException{
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");

        JSONObject dataJson = new JSONObject ();
        dataJson.put("chartName","");
        dataJson.put("xAxisName","time");
        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.O2PPerformance"));		//O2P Performance
        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.SPPerformance")); 		//Service Provider Performance
        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitS")); 			//左Y轴单位
        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitS")); 			//右Y轴单位
        
		JSONArray xJsonArray = getXAxisJson();	//X轴
		dataJson.put("xAxis",xJsonArray);

		JSONArray YAJsonArray = new JSONArray();		//Y轴  Total Performance
		JSONArray YBJsonArray = new JSONArray();		//Y轴  O2P Performance
		JSONArray YCJsonArray = new JSONArray();		//Y轴  Service Provider Performance

		//1:Total Performance,   2:O2P Performance,  3:Service Provider Performance

        String nDate = getSerDT();
        Map map = new HashMap();
        map.put("nDate", nDate);
		List<RegStatRecent> avgUsingList = getMonitorViewService().queryLineAvgUsingNum(map);
		if(avgUsingList != null && avgUsingList.size() > 0){
    		for (int i=0;i<avgUsingList.size();i++){
    			RegStatRecent reg = (RegStatRecent)avgUsingList.get(i);
    			Double num = Double.parseDouble(reg.getAvgUsing().toString());
    			YAJsonArray.add((num/1000)+"");
    		}
    	}
		
		List<RegStatRecent> csbList = getMonitorViewService().queryLineCsbNum(map);
		if(csbList != null && csbList.size() > 0){
    		for (int i=0;i<csbList.size();i++){
    			RegStatRecent reg = (RegStatRecent)csbList.get(i);
    			YBJsonArray.add(reg.getAvgUsing()+"");
    		}
    	}

		List<RegStatRecent> avgUsingDstList = getMonitorViewService().queryLineAvgUsingDstNum(map);
		if(avgUsingDstList != null && avgUsingDstList.size() > 0){
    		for (int i=0;i<avgUsingDstList.size();i++){
    			RegStatRecent reg = (RegStatRecent)avgUsingDstList.get(i);
    			Double num = Double.parseDouble(reg.getAvgUsingDst().toString());
    			YCJsonArray.add((num/1000)+"");
    		}
    	}

		dataJson.put("yAxisA",YAJsonArray);
		dataJson.put("yAxisB",YBJsonArray);
		dataJson.put("yAxisC",YCJsonArray);
		retJson.put("data",dataJson);

    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }

    public String getSysViewDataGauge(){
        String nDate = getSerDT();
        Map map = new HashMap();
        map.put("nDate", nDate);
        Double num1 = getMonitorViewService().queryAvgUsingDstNum(map); 	//1:SP Performance(Service Provider Performance)
        Double num2 = getMonitorViewService().queryAvgUsingNum(map); 			//2:Total Performance
        Double num3 = getMonitorViewService().queryCsbNum(map);					//3:O2P Performance
        
        String s1 = String.format("%.2f",num1);		//%. 表示小数点前任意位数，2 表示两位小数，f表示格式后的结果为浮点型
        String s2 = String.format("%.2f",num2);
        String s3 = String.format("%.2f",num3);
        
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");
        
        JSONObject dataJson = new JSONObject ();
        JSONObject gauge1Json = new JSONObject ();
        gauge1Json.put("id","");
        gauge1Json.put("value",s1+"");
        gauge1Json.put("name",getText("eaap.op2.conf.monitor.view.SPPerformance"));		//SP Performance
        dataJson.put("gauge1", gauge1Json);
        
        JSONObject gauge2Json = new JSONObject ();
        gauge2Json.put("id","");
        gauge2Json.put("value",s2+"");
        gauge2Json.put("name",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
        dataJson.put("gauge2", gauge2Json);
        
        JSONObject gauge3Json = new JSONObject ();
        gauge3Json.put("id","");
        gauge3Json.put("value",s3+"");
        gauge3Json.put("name",getText("eaap.op2.conf.monitor.view.O2PPerformance"));	//O2P Performance
        dataJson.put("gauge3", gauge3Json);

		retJson.put("data",dataJson);
    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    
    /**
     * ����ͼX��̶�
     * @param beginDate
     * @param endDate
     * @return
     */
    private static List<Object> getDatesBetweenTwoDate(Date beginDate,Date endDate){
		List<Object> dateList = new ArrayList<Object>();
		//�ѿ�ʼʱ����뼯��
		dateList.add(beginDate);
		Calendar cal = Calendar.getInstance();
		//ʹ�ø�� Date ���ô� Calendar ��ʱ�� 
		cal.setTime(beginDate); 
		for (int i=0;i<60;i++){
			if (endDate.after(cal.getTime())) {
				cal.add(Calendar.MINUTE , 1);
				dateList.add(cal.getTime());
			}
		}
		return dateList;
	}
    
    
    public String showComponentViewIndexNew(){
    	Map map = new HashMap();
        selectComponentList = getMonitorViewService().queryComponentInfo(map);
    	map.put("queryType", "ALLNUM") ;
    	totalRecord = Integer.valueOf(String.valueOf(getMonitorViewService().queryComponentList(map).get(0).get("ALLNUM")));
    	totalPage = ((totalRecord + pageRecord) - 1) / pageRecord;		//pageRecord=4
    	return SUCCESS;
    }
        
	public void getComponentViewIndexList(){
		PrintWriter out =null;
		try {
	    	currentPage =  Integer.valueOf(getRequest().getParameter("currentPage"));
	    	String componentId = getRequest().getParameter("componentId");
	    	Map map = new HashMap();
	    	if (StringUtils.isNotEmpty(componentId) && !"null".equals(componentId)){
	    		String componentStr = componentId.replaceAll(" ", "");
	    		String[] componentArr = componentStr.split(",");
	    		map.put("componentArr", componentArr);
	    	}
	    	map.put("queryType", "ALLNUM") ;
	    	totalRecord = Integer.valueOf(String.valueOf(getMonitorViewService().queryComponentList(map).get(0).get("ALLNUM")));
	    	totalPage = ((totalRecord + pageRecord) - 1) / pageRecord;		//pageRecord=4
	    	map.put("queryType", "") ;
	    	
	        map.put("pro", (currentPage-1)*pageRecord +1);
	        map.put("end", currentPage*pageRecord);
	    	map.put("pro_mysql", (currentPage-1)*pageRecord );
	        map.put("page_record", pageRecord);				//{pro_mysql=8, page_record=4, pro=9, end=12}
	    	componentList = getMonitorViewService().queryComponentList(map);
	    	net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(componentList); 	//转成JSONArray
	    	
	    	JSONObject retJson = new JSONObject();
	    	retJson.put("TotalPage", totalPage);
	    	retJson.put("RecordList", jsonArray);
		
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			out.print(retJson.toString());
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
    
    

    public String showServiceViewIndexNew(){
    	Map map = new HashMap();
        serviceList = getMonitorViewService().queryServiceList(map);
    	map.put("queryType", "ALLNUM") ;
    	totalRecord = Integer.valueOf(String.valueOf(getMonitorViewService().querySvcPerformanceList(map).get(0).get("ALLNUM")));
    	totalPage = ((totalRecord + pageRecord) - 1) / pageRecord;		//pageRecord=4
    	return SUCCESS;
    }
        
	public void getServiceViewIndexNewList(){
		PrintWriter out =null;
		try {
	    	currentPage =  Integer.valueOf(getRequest().getParameter("currentPage"));
	    	String serviceCode = getRequest().getParameter("serviceCode");
	    	Map map = new HashMap();
	    	if (StringUtils.isNotEmpty(serviceCode) && !"null".equals(serviceCode)){
	    		String serviceCodeStr = serviceCode.replaceAll(" ", "");
	    		String[] serviceCodeArr = serviceCodeStr.split(",");
	    		map.put("serviceCodeArr", serviceCodeArr);
	    	}
	    	map.put("queryType", "ALLNUM") ;
	    	totalRecord = Integer.valueOf(String.valueOf(getMonitorViewService().querySvcPerformanceList(map).get(0).get("ALLNUM")));
	    	totalPage = ((totalRecord + pageRecord) - 1) / pageRecord;		//pageRecord=4
	    	map.put("queryType", "") ;
	    	
	        map.put("pro", (currentPage-1)*pageRecord +1);
	        map.put("end", currentPage*pageRecord);
	    	map.put("pro_mysql", (currentPage-1)*pageRecord );
	        map.put("page_record", pageRecord);				//{pro_mysql=8, page_record=4, pro=9, end=12}
	        svcPerformanceList = getMonitorViewService().querySvcPerformanceList(map);
	    	net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(svcPerformanceList); 	//转成JSONArray
	    	
	    	JSONObject retJson = new JSONObject();
	    	retJson.put("TotalPage", totalPage);
	    	retJson.put("RecordList", jsonArray);
		
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			out.print(retJson.toString());
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
    

    public String showSingleBizViewIndexNew(){
    	Map map = new HashMap();
        bizFunctionList = getMonitorViewService().queryBizFunctionList(map);
    	map.put("queryType", "ALLNUM") ;
    	totalRecord = Integer.valueOf(String.valueOf(getMonitorViewService().querySingleBizList(map).get(0).get("ALLNUM")));
    	totalPage = ((totalRecord + pageRecord) - 1) / pageRecord;		//pageRecord=4
    	return SUCCESS;
    }

	public void getSingleBizViewIndexList(){
		PrintWriter out =null;
		try {
	    	currentPage =  Integer.valueOf(getRequest().getParameter("currentPage"));
	    	String bizCode = getRequest().getParameter("bizCode");
	    	Map map = new HashMap();
	    	if (StringUtils.isNotEmpty(bizCode) && !"null".equals(bizCode)){
	    		String bizFuncStr = bizCode.replaceAll(" ", "");
	    		String[] bizFuncArr = bizFuncStr.split(",");
	    		map.put("bizFuncArr", bizFuncArr);
	    	}
	    	
	    	map.put("queryType", "ALLNUM") ;
	    	totalRecord = Integer.valueOf(String.valueOf(getMonitorViewService().querySingleBizList(map).get(0).get("ALLNUM")));
	    	totalPage = ((totalRecord + pageRecord) - 1) / pageRecord;		//pageRecord=4
	    	map.put("queryType", "") ;
	    	
	        map.put("pro", (currentPage-1)*pageRecord +1);
	        map.put("end", currentPage*pageRecord);
	    	map.put("pro_mysql", (currentPage-1)*pageRecord );
	        map.put("page_record", pageRecord);				//{pro_mysql=8, page_record=4, pro=9, end=12}
	        singleBizList = getMonitorViewService().querySingleBizList(map);
	    	net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(singleBizList); 	//转成JSONArray
	    	
	    	JSONObject retJson = new JSONObject();
	    	retJson.put("TotalPage", totalPage);
	    	retJson.put("RecordList", jsonArray);
		
		    getResponse().setContentType("text/html;charset=UTF-8");
		    out = getResponse().getWriter();
			out.print(retJson.toString());
		}  catch (Exception e) {
			try {
				getResponse().setContentType("text/html;charset=UTF-8");
				out = getResponse().getWriter();
				out.print("failure");
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}finally{
			if (out != null) {
				out.flush();
				out.close();
			}
		}
	}
    
    
    public String getSingleBizData() throws ParseException{
		String bizCode = getRequest().getParameter("bizCode");
		String tabType = getRequest().getParameter("tabType");
		
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");

        JSONObject dataJson = new JSONObject ();
        dataJson.put("chartName","");
        dataJson.put("xAxisName","time");
        if(tabType.equals("1")){
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.O2PPerformance"));		//O2P Performance
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.SPPerformance")); 		//Service Provider Performance
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitMs")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitMs")); 			//右Y轴单位
        }else{
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.totalBizErr"));			//Total Business Exception
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.totalSysErr")); 		//Total System Exception
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.totalTrans"));			//Total Business
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 		//右Y轴单位
        }
        
		JSONArray xJsonArray = getXAxisJson();		//X轴
		dataJson.put("xAxis",xJsonArray);

		JSONArray YAJsonArray = new JSONArray();		//Y轴  Business Volume
		JSONArray YBJsonArray = new JSONArray();		//Y轴  Total Business Exceptions
		JSONArray YCJsonArray = new JSONArray();		//Y轴  Total System Exceptions
        Map map = new HashMap();
		map.put("bizCode", bizCode);
		map.put("tabType", tabType);
        String nDate = getSerDT();
        map.put("nDate" , nDate );
		List<RegStatRecent> regList = getMonitorViewService().querySingleBizData(map);
    	if(regList != null && regList.size() > 0){
    		if ("1".equals(tabType)){
				for (int k=0;k<regList.size();k++){
					RegStatRecent reg = (RegStatRecent)regList.get(k);
	    			YAJsonArray.add(reg.getTotalTrans()+"");
	    			YBJsonArray.add(reg.getAvgUsingDst()+"");
	    			YCJsonArray.add(reg.getAvgUsing()+"");
				}
			}else{
				for (int i=0;i<regList.size();i++){
					RegStatRecent reg = (RegStatRecent)regList.get(i);
	    			YAJsonArray.add(reg.getTotalBizErr()+"");
	    			YBJsonArray.add(reg.getTotalSysErr()+"");
	    			YCJsonArray.add(reg.getTotalTrans()+"");		//Total Business
	    		}
			}
    		dataJson.put("yAxisA",YAJsonArray);
    		dataJson.put("yAxisB",YBJsonArray);
    		dataJson.put("yAxisC",YCJsonArray);
    		retJson.put("data",dataJson);
    	}

    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    

    public String getSingleComponetData() throws ParseException{
		String dstCode = getRequest().getParameter("componentId");
		String tabType = getRequest().getParameter("tabType");
		
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");

        JSONObject dataJson = new JSONObject ();
        dataJson.put("chartName","");
        dataJson.put("xAxisName","time");
        if(tabType.equals("1")){
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.O2PPerformance"));		//O2P Performance
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.SPPerformance")); 		//Service Provider Performance
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitMs")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitMs")); 			//右Y轴单位
        }else{
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.totalBizErr"));			//Total Business Exception
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.totalSysErr")); 		//Total System Exception
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.totalTrans"));			//Total Business
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 		//右Y轴单位
        }

		JSONArray xJsonArray = getXAxisJson();		//X轴
		dataJson.put("xAxis",xJsonArray);

		JSONArray YAJsonArray = new JSONArray();		//Y轴  Business Volume
		JSONArray YBJsonArray = new JSONArray();		//Y轴  Total Business Exceptions
		JSONArray YCJsonArray = new JSONArray();		//Y轴  Total System Exceptions
        Map map = new HashMap();
		map.put("dstCode", dstCode);
		map.put("tabType", tabType);
        String nDate = getSerDT();
        map.put("nDate" , nDate );
		List<RegStatRecent> regList = getMonitorViewService().queryComponentData(map);
    	if(regList != null && regList.size() > 0){
    		if ("1".equals(tabType)){
				for (int k=0;k<regList.size();k++){
					RegStatRecent reg = (RegStatRecent)regList.get(k);
	    			YAJsonArray.add(reg.getTotalTrans()+"");
	    			YBJsonArray.add(reg.getAvgUsingDst()+"");
	    			YCJsonArray.add(reg.getAvgUsing()+"");
				}
			}else{
				for (int i=0;i<regList.size();i++){
					RegStatRecent reg = (RegStatRecent)regList.get(i);
	    			YAJsonArray.add(reg.getTotalBizErr()+"");
	    			YBJsonArray.add(reg.getTotalSysErr()+"");
	    			YCJsonArray.add(reg.getTotalTrans()+"");		//Total Business
	    		}
			}
    		dataJson.put("yAxisA",YAJsonArray);
    		dataJson.put("yAxisB",YBJsonArray);
    		dataJson.put("yAxisC",YCJsonArray);
    		retJson.put("data",dataJson);
    	}

    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    public String getSingleServiceData() throws ParseException{
		String serviceCode = getRequest().getParameter("serviceCode");
		String componentId = getRequest().getParameter("componentId");
		String tabType = getRequest().getParameter("tabType");
		
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");

        JSONObject dataJson = new JSONObject ();
        dataJson.put("chartName","");
        dataJson.put("xAxisName","time");
        if(tabType.equals("1")){
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.O2PPerformance"));		//O2P Performance
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.SPPerformance")); 		//Service Provider Performance
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitMs")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitMs")); 			//右Y轴单位
        }else{
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.totalBizErr"));			//Total Business Exception
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.totalSysErr")); 		//Total System Exception
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.totalTrans"));			//Total Business
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 		//右Y轴单位
        }

		JSONArray xJsonArray = getXAxisJson();		//X轴
		dataJson.put("xAxis",xJsonArray); 

		JSONArray YAJsonArray = new JSONArray();		//Y轴  Business Volume
		JSONArray YBJsonArray = new JSONArray();		//Y轴  Total Business Exceptions
		JSONArray YCJsonArray = new JSONArray();		//Y轴  Total System Exceptions
        Map map = new HashMap();
		//map.put("intfCode", serviceCode);
		map.put("dstCode", componentId);
		map.put("tabType", tabType);
        String nDate = getSerDT();
        map.put("nDate" , nDate );
		List<RegStatRecent> regList = getMonitorViewService().querySvcPerformanceData(map);
    	if(regList != null && regList.size() > 0){
    		if ("1".equals(tabType)){
				for (int k=0;k<regList.size();k++){
					RegStatRecent reg = (RegStatRecent)regList.get(k);
	    			YAJsonArray.add(reg.getTotalTrans()+"");
	    			YBJsonArray.add(reg.getAvgUsingDst()+"");
	    			YCJsonArray.add(reg.getAvgUsing()+"");
				}
			}else{
				for (int i=0;i<regList.size();i++){
					RegStatRecent reg = (RegStatRecent)regList.get(i);
	    			YAJsonArray.add(reg.getTotalBizErr()+"");
	    			YBJsonArray.add(reg.getTotalSysErr()+"");
	    			YCJsonArray.add(reg.getTotalTrans()+"");		//Total Business
	    		}
			}
    		dataJson.put("yAxisA",YAJsonArray);
    		dataJson.put("yAxisB",YBJsonArray);
    		dataJson.put("yAxisC",YCJsonArray);
    		retJson.put("data",dataJson);
    	}

    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    

    public String getAllBizViewData() throws ParseException{
		String serviceCode = getRequest().getParameter("serviceCode");
		String componentId = getRequest().getParameter("componentId");
		String tabType = getRequest().getParameter("tabType");
		
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");

        JSONObject dataJson = new JSONObject ();
        dataJson.put("chartName","");
        dataJson.put("xAxisName","time");
        if(tabType.equals("1")){
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.O2PPerformance"));		//O2P Performance
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.SPPerformance")); 		//Service Provider Performance
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitMs")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitMs")); 			//右Y轴单位
        }else{
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.totalBizErr"));			//Total Business Exception
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.totalSysErr")); 		//Total System Exception
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.totalTrans"));			//Total Business
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 		//右Y轴单位
        }
        
		JSONArray xJsonArray = getXAxisJson();		//X轴
		dataJson.put("xAxis",xJsonArray);
        
		JSONArray YAJsonArray = new JSONArray();		//Y轴  Business Volume
		JSONArray YBJsonArray = new JSONArray();		//Y轴  Total Business Exceptions
		JSONArray YCJsonArray = new JSONArray();		//Y轴  Total System Exceptions
        Map map = new HashMap();
		map.put("intfCode", serviceCode);
		map.put("dstCode", componentId);
		map.put("queryType", tabType);
        String nDate = getSerDT();
		map.put("nDate", nDate);
		List<RegStatRecent> regList = getMonitorViewService().queryAllBizInfo(map);
    	if(regList != null && regList.size() > 0){
    		if ("1".equals(tabType)){
				for (int k=0;k<regList.size();k++){
					RegStatRecent reg = (RegStatRecent)regList.get(k);
	    			YAJsonArray.add(reg.getTotalTrans()+"");
	    			YBJsonArray.add(reg.getAvgUsingDst()+"");
	    			YCJsonArray.add(reg.getAvgUsing()+"");
				}
			}else{
				for (int i=0;i<regList.size();i++){
					RegStatRecent reg = (RegStatRecent)regList.get(i);
	    			YAJsonArray.add(reg.getTotalBizErr()+"");
	    			YBJsonArray.add(reg.getTotalSysErr()+"");
	    			YCJsonArray.add(reg.getTotalTrans()+"");		//Total Business
	    		}
			}
    		dataJson.put("yAxisA",YAJsonArray);
    		dataJson.put("yAxisB",YBJsonArray);
    		dataJson.put("yAxisC",YCJsonArray);
    		retJson.put("data",dataJson);
    	}

    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    //取X时间轴数据
    public JSONArray getXAxisJson() throws ParseException{
        Date serDate = new Date();
        int serOff = serDate.getTimezoneOffset();	//服务器时间与标准时间（UTC）时间的偏移量
        
		Date lDate = null;
		if(localTime!=null && !localTime.equals("") && timeOffset!=null && !timeOffset.equals("")){
	        long localMS = new Long(localTime);
			Date utcDate = new Date(localMS);											//将转入的毫秒时间数字窜转成对应的服务器时间格式（注意：相同的毫秒时间数字在不同时区对应不同的时间值，但是在同一时间点的）
			int cOff = Integer.valueOf(timeOffset) - serOff;						//客户端时间与服务器时间的偏移量，（timeOffset转入参数为的客户端时间与标准时间（UTC）时间的偏移量）
			lDate	=	UTCTimeUtil.getLocalDateByUTC(utcDate, cOff);		//将时间还原为客户端时间
		}else{
			lDate=new Date();						//取系统时间
		}
        		
		JSONArray xJsonArray = new JSONArray();		//X轴
		Calendar cal = Calendar.getInstance();   
		cal.setTime(lDate);
		cal.set(Calendar.HOUR_OF_DAY , cal.get(Calendar.HOUR_OF_DAY) - 1 ) ; //把时间设置为当前时间-1小时
		Date beginDate = cal.getTime();
		List<Object> resultList = MonitorViewAction.getDatesBetweenTwoDate(beginDate,lDate);
		if (resultList != null && resultList.size() > 0) {
			for(int i=0; i<resultList.size()-1; i++){
				Date date = (Date)resultList.get(i);
				String miniute = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes() + "" ;
				xJsonArray.add(date.getHours()+":"+miniute);
			}
		}
		return xJsonArray;
    }
    
    //获取服务器端对应时间（将转入的毫秒时间数字窜转成对应的服务器时间格式，注意：相同的毫秒时间数字在不同时区对应不同的时间值，但是属于在同一时间点的）
    public String getSerDT(){
    	String retDT="";
		Date serDate = null;
		if(localTime!=null && !localTime.equals("")){
	        long lMS = new Long(localTime);
	        serDate = new Date(lMS);									//获取服务器端对应时间
		}else{
			serDate	=	UTCTimeUtil.getUTCDate();			//获取服务器的当前时间
		}
		
		//将时间转成yyyy-MM-dd hh:mm:ss格式
        java.text.DateFormat formatDT = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String nDate = formatDT.format(serDate);
        
        //取公共配置文件参数判断是否是UTC时间，是则转成UTC时间，否则为服务器时间：
		String isUTCTime = WebPropertyUtil.getPropertyValue("ctrUTCTime");
		if(isUTCTime.equals("true")){
			//retDT=str2TimeZoneTime(nDate,"GMT",TimeZone.getDefault().getID());	//转成格林威治时间
	        Date serviceDate = new Date();
	        int serOff = serviceDate.getTimezoneOffset();										//服务器时间与标准时间（UTC）时间的偏移量
	        Date utcDate = UTCTimeUtil.getUTCByLocalDate(serDate,serOff);	//获取UTC时间
	        retDT = formatDT.format(utcDate);
		}else{
			retDT =nDate;
		}
		return retDT;
    }
    
    //时区转换
    public static String str2TimeZoneTime(String timeStr,String sourceTimeZoneId,String targetTimeZoneId){
		SimpleDateFormat targetDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		TimeZone targetTimeZone = TimeZone.getTimeZone(targetTimeZoneId);
		targetDf.setTimeZone(targetTimeZone);
		SimpleDateFormat sourceDf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		TimeZone sourceTimeZone = TimeZone.getTimeZone(sourceTimeZoneId);
		sourceDf.setTimeZone(sourceTimeZone);
		try {
			Date date=sourceDf.parse(timeStr);
			return targetDf.format(date);
		} catch (Exception e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
		return "";
	}

    public String getComponentSvcViewData() throws ParseException{
		String intfCode = getRequest().getParameter("componentSvcId");
		String dstCode = getRequest().getParameter("componentId");
		String tabType = getRequest().getParameter("tabType");
		
        JSONObject retJson = new JSONObject ();
        retJson.put("status","0");
        retJson.put("msg","success");

        JSONObject dataJson = new JSONObject ();
        dataJson.put("chartName","");
        dataJson.put("xAxisName","time");
        if(tabType.equals("1")){
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.TotalPerformance"));	//Total Performance
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.O2PPerformance"));		//O2P Performance
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.SPPerformance")); 		//Service Provider Performance
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitMs")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitMs")); 			//右Y轴单位
        }else{
	        dataJson.put("yAxisNameA",getText("eaap.op2.conf.monitor.view.totalBizErr"));			//Total Business Exception
	        dataJson.put("yAxisNameB",getText("eaap.op2.conf.monitor.view.totalSysErr")); 		//Total System Exception
	        dataJson.put("yAxisNameC",getText("eaap.op2.conf.monitor.view.totalTrans"));			//Total Business
	        dataJson.put("yAxisUnitLeft",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 			//左Y轴单位
	        dataJson.put("yAxisUnitRight",getText("eaap.op2.conf.monitor.view.unitTimesMin")); 		//右Y轴单位
        }
        
		JSONArray xJsonArray = getXAxisJson();		//X轴
		dataJson.put("xAxis",xJsonArray);

		JSONArray YAJsonArray = new JSONArray();		//Y轴  Business Volume
		JSONArray YBJsonArray = new JSONArray();		//Y轴  Total Business Exceptions
		JSONArray YCJsonArray = new JSONArray();		//Y轴  Total System Exceptions
        Map map = new HashMap();
		map.put("intfCode", intfCode);
		map.put("dstCode", dstCode);
		map.put("tabType", tabType);
        String nDate = getSerDT();
		map.put("nDate", nDate);
		List<RegStatRecent> regList = getMonitorViewService().queryComponentServiceData(map);
    	if(regList != null && regList.size() > 0){
    		if ("1".equals(tabType)){
				for (int k=0;k<regList.size();k++){
					RegStatRecent reg = (RegStatRecent)regList.get(k);
	    			YAJsonArray.add(reg.getTotalTrans()+"");
	    			YBJsonArray.add(reg.getAvgUsingDst()+"");
	    			YCJsonArray.add(reg.getAvgUsing()+"");
				}
			}else{
				for (int i=0;i<regList.size();i++){
					RegStatRecent reg = (RegStatRecent)regList.get(i);
	    			YAJsonArray.add(reg.getTotalBizErr()+"");
	    			YBJsonArray.add(reg.getTotalSysErr()+"");
	    			YCJsonArray.add(reg.getTotalTrans()+"");		//Total Business
	    		}
			}
    		dataJson.put("yAxisA",YAJsonArray);
    		dataJson.put("yAxisB",YBJsonArray);
    		dataJson.put("yAxisC",YCJsonArray);
    		retJson.put("data",dataJson);
    	}

    	try {
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    
    
    
    
    /**
     * �Զ����������(type[1:��������,2:�����������,3:����ҵ���أ�4���������ܼ��)
     * @return
     */
    public String saveCustomPanelCfg(){
    	String type = getRequest().getParameter("type");
    	PortalPanel portalPanel = new PortalPanel();
    	//TODO ��ȡ��¼�߱��
    	portalPanel.setSysPersonId(100001);
    	//��������Ƿ���ʾ A ��ʾ X ����ʾ
    	portalPanel.setState("A");
    	portalPanel.setAttr("");
    	portalPanel.setPanelType("1");
    	
    	String title = getRequest().getParameter("title");
    	String tipTitle = getRequest().getParameter("tipTitle");
    	portalPanel.setTitle(title);
    	portalPanel.setTips(tipTitle);
    	//��ѯ��ǰ�û��Ƿ������ø����
    	Integer isExist = getMonitorViewService().selectCfgPanelIsExist(portalPanel);
    	//��ѯ��ǰ�û��������������
    	Integer cfgPanelNum = getMonitorViewService().selectCfgPanelNum(portalPanel);
    	String result = "{\"msg\":\"1\"}";
    	
    	if (isExist > 0) { //���û������ø����
    		result = "{\"msg\":\"2\"}";
    	}else if (cfgPanelNum >= 10) { //�Զ��������Ŀ����Ϊ10��
    		result = "{\"msg\":\"0\"}";
    	}else {
    		if ("1".equals(type)){ //��������
        		String componentId = getRequest().getParameter("componentId");
        		//��ȡ����
        		portalPanel.setPortalPanelId(Integer.parseInt(getMonitorViewService().queryPortalPanelSeq()));
        		portalPanel.setDisplaySeq((getMonitorViewService().selectMaxDisplaySeq(portalPanel))+1);
        		portalPanel.setPath("../monitorNew/showComponentChart.jsp?componentId="+componentId);
        		
        		getMonitorViewService().insertPortalPanel(portalPanel);
        	}else if ("2".equals(type)){ //���������
        		String componentId = getRequest().getParameter("componentId");
        		String serviceCode = getRequest().getParameter("serviceCode"); 
        		
        		//��ȡ����
        		portalPanel.setPortalPanelId(Integer.parseInt(getMonitorViewService().queryPortalPanelSeq()));
        		portalPanel.setDisplaySeq((getMonitorViewService().selectMaxDisplaySeq(portalPanel))+1);
        		portalPanel.setPath("../monitorNew/showComponentSvcChart.jsp?svcId='"+serviceCode+"'&componentId="+componentId);
        		
        		getMonitorViewService().insertPortalPanel(portalPanel);
        	}else if ("3".equals(type)){ //����ҵ����
        		String bizCode = getRequest().getParameter("bizCode"); 
        		
        		//��ȡ����
        		portalPanel.setPortalPanelId(Integer.parseInt(getMonitorViewService().queryPortalPanelSeq()));
        		portalPanel.setDisplaySeq((getMonitorViewService().selectMaxDisplaySeq(portalPanel))+1);
        		portalPanel.setPath("../monitorNew/showSingleBizChart.jsp?bizCode='"+bizCode+"'");
        		
        		getMonitorViewService().insertPortalPanel(portalPanel);
        	}else if ("4".equals(type)){
        		String componentId = getRequest().getParameter("componentId");
        		String serviceCode = getRequest().getParameter("serviceCode"); 
        		
        		//��ȡ����
        		portalPanel.setPortalPanelId(Integer.parseInt(getMonitorViewService().queryPortalPanelSeq()));
        		portalPanel.setDisplaySeq((getMonitorViewService().selectMaxDisplaySeq(portalPanel))+1);
        		portalPanel.setPath("../monitorNew/showSvcPerformanceChart.jsp?serviceCode='"+serviceCode+"'&componentId="+componentId);
        		
        		getMonitorViewService().insertPortalPanel(portalPanel);
        	}
    		result = "{\"msg\":\"1\"}";
    	}

    	//���ؽ���ҳ��
		try {
			PrintWriter out = getResponse().getWriter();
			out.println(result);
	    	out.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    public String deletePortalPanel(){
    	String panelId = getRequest().getParameter("panelId");
    	PortalPanel portalPanel = new PortalPanel();
    	//TODO ��ȡ��¼�߱��
    	portalPanel.setSysPersonId(100001);
    	portalPanel.setPortalPanelId(Integer.parseInt(panelId));
    	portalPanel.setState("X");
    	portalPanel.setStateTime(new Date());
    	
    	String result = "{\"msg\":\"1\"}";
    	getMonitorViewService().deletePortalPanel(portalPanel);
    	//���ؽ���ҳ��
		try {
			PrintWriter out = getResponse().getWriter();
			out.println(result);
	    	out.close();
		} catch (IOException e) {
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		}
    	return NONE;
    }
    
    /**�����ͼ��ҳ�������*/
    public Map loadTodoWordGrid(Map para){
		String processName = getRequest().getParameter("processName");
		String eventContent = getRequest().getParameter("eventContent");
		
		Map resultMap = new HashMap();
		rows = page.getRows();
		pages = page.getPage();
		int startRow;
		
		//if (pages == 1) {
			startRow = (pages - 1) * rows + 1;
		//} else {
		//	startRow = (pages - 1) * rows + 1;
		//}
		resultMap.put("startRow", startRow);
		resultMap.put("rows", rows);
		//�ӹ�������ȡ�������
//		WebApplicationContext context = null;
//		if(context == null) {
//			context = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
//		}

		WorklistsQueryPara queryPara=new WorklistsQueryPara();
		queryPara.setReceive_User("123456");
		if(processName!=null && !processName.equals("")){
			queryPara.setProc_Name(processName);		//查询条件
		}
		if(eventContent!=null && !eventContent.equals("")){
			queryPara.setContent(eventContent);			//查询条件
		}
		
		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
		Map workMap = wi.getNeedDealWorkflistsList(queryPara,pages,rows,false);
		
		List resultList = new ArrayList();
		if(workMap.get("dataList")!=null){
			resultList = (List)workMap.get("dataList");
			for (int i=0;i<resultList.size();i++){
				Worklists worklists=(Worklists)resultList.get(i);
				//deal_urlΪ����ִ��url,�������ֶ�ƴ�ӣ�������չʾ
				worklists.setDeal_Url(worklists.getWork_Lists_Id()+";"+worklists.getDeal_Url());
			}
        }
        resultMap.put("total",workMap.get("total"));
		resultMap.put("dataList", workMap.get("dataList"));
		return resultMap;
	}
//    Map workMap=new HashMap();
//	try {
//		String[] configLocations= new String[]{"classpath:eaap-op2-workflowRemote-spring.xml"};
//		ApplicationContext ctx = new ClassPathXmlApplicationContext(configLocations);
//		WorkflowRemoteInterface wi = (WorkflowRemoteInterface)ctx.getBean("workflowRemote");
//		workMap = wi.getNeedDealWorkflistsList(queryPara,pages,rows,false);
//	} catch (Exception e) {
//		log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
//	}
//    retJson.put("recordsTotal",(workMap.get("total")==null?0:workMap.get("total")));
//    retJson.put("recordsFiltered",(workMap.get("total")==null?0:workMap.get("total")));
//    String winN = getText("eaap.op2.conf.monitor.view.taskexec");
//	List resultList = new ArrayList();
//	if(workMap.get("dataList")!=null){
//		resultList = (List)workMap.get("dataList");
//		for (int i=0;i<resultList.size();i++){
//			Worklists worklists=(Worklists)resultList.get(i);
//			JSONArray rowJsonArray = new JSONArray();
//			//rowJsonArray.add(worklists.getWork_Lists_Id()+";"+worklists.getDeal_Url());		//deal_Url
//			rowJsonArray.add("<a href=\"#\" onclick=\"openWindows('"+worklists.getDeal_Url()+"','"+winN+"')\">"+worklists.getWork_Lists_Id()+"</a>");		//deal_Url
//			rowJsonArray.add(worklists.getProc_Name());				//proc_Name
//			rowJsonArray.add(worklists.getContent());					//content
//			rowJsonArray.add(worklists.getSrc_User_Name());		//src_User_Name
//			rowJsonArray.add(worklists.getCreate_Date());			//create_Date
//			dataJsonArray.add(rowJsonArray);
//		}
//    }
    
    @RequestMapping(produces="application/json; charset=utf-8")
    public String getTodoWordGrid(){	
    	JSONArray dataJsonArray = new JSONArray ();
        Map<String,Object> vars = new HashMap<String, Object>();
        JSONObject retJson = new JSONObject();

        int draw	= Integer.valueOf(getRequest().getParameter("draw"));
		retJson.put("draw",draw);
    	try {
			String searchKey	= getRequest().getParameter("search[value]");
			int start		= Integer.valueOf(getRequest().getParameter("start"));
			int length	= Integer.valueOf(getRequest().getParameter("length"));
			vars.put("startRow", String.valueOf(start));
			vars.put("pageSize", String.valueOf(length));
	        vars.put("userId", EAAPConstants.PROCESS_AUTHENTICATED_USER_ID);
			if(searchKey!=null && !searchKey.equals("")){
				vars.put("searchKey", searchKey);
			}else{
				vars.put("searchKey", "");
			}

			HttpSession session = ServletActionContext.getRequest().getSession();
			Integer tenantId = CommonUtil.getTenantId(session);
			vars.put("tenantId", tenantId);
   		   
			com.alibaba.fastjson.JSONObject getJson = getWorkflowList(vars);
			com.alibaba.fastjson.JSONArray jsons = getJson.getJSONArray("dataList");
	        String winN = getText("eaap.op2.conf.monitor.view.taskexec");
	        com.alibaba.fastjson.JSONObject json = null;
	       
			if(jsons!=null){
		        JSONArray rowJsonArray = null;
		        StringBuffer sbURL = null;
		        String workFlowUrl = null;
		        
				for (int i=0;i<jsons.size();i++){
					json = (com.alibaba.fastjson.JSONObject) (jsons.get(i));
					workFlowUrl = json.getString("dealUrl");
					
					if(null != workFlowUrl){
						rowJsonArray = new JSONArray();
						if(workFlowUrl.contains("rtiRuleId")){
							String rtiRuleIdStr=json.getString("contentId");
							Integer rtiRuleId=new Integer(rtiRuleIdStr); 
							String rtiProcessInstanceId=json.getString("processInstanceId");
							String rtiActivityId=json.getString("taskId");
							//App.modal({width:\'container\',remote:App.urls.rtiRuleDetail,data:{rtiRuleId:\'' + full.rtiRuleId + '\'}})
							//resources/components/approval.html
							rowJsonArray.add("<a href=\"#\" onclick=\"App.modal({width:'container',remote:App.urls.approval,data:{rtiRuleId:'" +rtiRuleId+ "',activity_Id:'" +rtiActivityId+ "',content_Id:'" +rtiRuleIdStr+ "',process_Id:'" +rtiProcessInstanceId+ "'}})\">"+json.getString("processName")+"</a>");
							rowJsonArray.add(json.getString("processName")+",content_id:"+rtiRuleIdStr);					//content
							rowJsonArray.add("<div style=\"text-align:center;\">"+json.getString("createTime")+"</div>");			//create_Date
							dataJsonArray.add(rowJsonArray);
						}else{

							if(workFlowUrl.contains(EAAPConstants.FRONT_END_URL)){
								workFlowUrl = workFlowUrl.replace(EAAPConstants.FRONT_END_URL, WebPropertyUtil.getPropertyValue("frontEnd_url"));
							} 
							if(workFlowUrl.contains(EAAPConstants.CONTENT_ID)){
								workFlowUrl = workFlowUrl.replace(EAAPConstants.CONTENT_ID, json.getString("contentId"));
							}
							if(workFlowUrl.contains("?") && !workFlowUrl.endsWith("&")){
								workFlowUrl += "&";
							}
							
							sbURL = new StringBuffer();
							sbURL.append(workFlowUrl).append("content_Id=").append(json.getString("contentId"))
							     .append("&process_Id=").append(json.getString("processInstanceId"))
							     .append("&activity_Id=").append(json.getString("taskId"))
							     .append("&act_Id=").append(json.getString("actId"));
							
							workFlowUrl = sbURL.toString();
						 
							rowJsonArray.add("<a href=\"#\" onclick=\"openWindows('"+workFlowUrl+"','"+winN+"',null,450)\">"+json.getString("processName")+"</a>");		//deal_Url
							rowJsonArray.add(json.getString("processName")+",content_id:"+json.getString("contentId"));					//content
							//rowJsonArray.add(json.getString("taskAssignee"));		//src_User_Name
							rowJsonArray.add("<div style=\"text-align:center;\">"+json.getString("createTime")+"</div>");			//create_Date
							dataJsonArray.add(rowJsonArray);
						}
				  }
				
					
				}
	        }
			
			retJson.put("recordsTotal",getJson.getString("cnt"));
	        retJson.put("recordsFiltered",String.valueOf(dataJsonArray.size()));
			retJson.put("data",dataJsonArray);
		
			PrintWriter  write = getResponse().getWriter();
			write.println(retJson);
			write.close();
		}catch (Exception e) {
			try {
				retJson.put("recordsTotal",0);
		        retJson.put("recordsFiltered",0);
				retJson.put("data",dataJsonArray);
				PrintWriter  write = getResponse().getWriter();
				write.println(retJson);
				write.close();
			} catch (IOException e1) {
				log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e1.getMessage(),null));
			}
			log.error(LogModel.EVENT_APP_EXCPT, new BusinessException(ExceptionCommon.WebExceptionCode,e.getMessage(),null));
		} 
    	return NONE;
    }
    
    private com.alibaba.fastjson.JSONObject getWorkflowList(Map<String,Object> vars){
    	RestTemplate rest = new RestTemplate();
    	String message = rest.postForObject(WebPropertyUtil.getPropertyValue("work_flow_pro_url")+"/task/taskListByUserId?userId={userId}&startRow={startRow}&pageSize={pageSize}&searchKey={searchKey}&tenantId={tenantId}",
	    		null,String.class,vars);
    	
    	com.alibaba.fastjson.JSONObject retJson = new com.alibaba.fastjson.JSONObject();
		if(!StringUtils.isEmpty(message)){
			retJson = JSON.parseObject(message);
		}
    	return retJson;
    }

	public IMonitorViewService getMonitorViewService() {
		if (monitorViewService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			monitorViewService = (IMonitorViewService)ctx.getBean("eaap-op2-conf-monitor-MonitorViewService");
		}
		return monitorViewService;
	}

	public void setMonitorViewService(IMonitorViewService monitorViewService) {
		this.monitorViewService = monitorViewService;
	}
	
	public List<Map> getComponentList() {
		return componentList;
	}
	public void setComponentList(List<Map> componentList) {
		this.componentList = componentList;
	}
	public Pagination getPage() {
		return page;
	}
	public void setPage(Pagination page) {
		this.page = page;
	}
	public List<Map> getComponentSvcList() {
		return componentSvcList;
	}
	public void setComponentSvcList(List<Map> componentSvcList) {
		this.componentSvcList = componentSvcList;
	}
	public List<Component> getSelectComponentList() {
		return selectComponentList;
	}
	public void setSelectComponentList(List<Component> selectComponentList) {
		this.selectComponentList = selectComponentList;
	}
	public Component getComponent() {
		return component;
	}
	public void setComponent(Component component) {
		this.component = component;
	}
	public List<Map> getSvcPerformanceList() {
		return svcPerformanceList;
	}
	public void setSvcPerformanceList(List<Map> svcPerformanceList) {
		this.svcPerformanceList = svcPerformanceList;
	}
	public List<Map> getSingleBizList() {
		return singleBizList;
	}
	public void setSingleBizList(List<Map> singleBizList) {
		this.singleBizList = singleBizList;
	}
	public List<Org> getSelectOrgList() {
		return selectOrgList;
	}
	public void setSelectOrgList(List<Org> selectOrgList) {
		this.selectOrgList = selectOrgList;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	public List<BizFunction> getBizFunctionList() {
		return bizFunctionList;
	}
	public void setBizFunctionList(List<BizFunction> bizFunctionList) {
		this.bizFunctionList = bizFunctionList;
	}
	public BizFunction getBizFunction() {
		return bizFunction;
	}
	public void setBizFunction(BizFunction bizFunction) {
		this.bizFunction = bizFunction;
	}
	public List<Service> getServiceList() {
		return serviceList;
	}
	public void setServiceList(List<Service> serviceList) {
		this.serviceList = serviceList;
	}
	public Service getService() {
		return service;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public List<String> getRefreshList() {
		return refreshList;
	}
	public void setRefreshList(List<String> refreshList) {
		this.refreshList = refreshList;
	}
	public List<String> getViewSwitchList() {
		return viewSwitchList;
	}
	public void setViewSwitchList(List<String> viewSwitchList) {
		this.viewSwitchList = viewSwitchList;
	}
	public List<Map> getRefreshSecondMaps() {
		return refreshSecondMaps;
	}
	public void setRefreshSecondMaps(List<Map> refreshSecondMaps) {
		this.refreshSecondMaps = refreshSecondMaps;
	}
	public List<Map> getViewSwitchMaps() {
		return viewSwitchMaps;
	}
	public void setViewSwitchMaps(List<Map> viewSwitchMaps) {
		this.viewSwitchMaps = viewSwitchMaps;
	}
	
	public String getLocalTime() {
		return localTime;
	}
	public void setLocalTime(String localTime) {
		this.localTime = localTime;
	}
	public String getTimeOffset() {
		return timeOffset;
	}
	public void setTimeOffset(String timeOffset) {
		this.timeOffset = timeOffset;
	}
	
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageRecord() {
		return pageRecord;
	}
	public void setPageRecord(int pageRecord) {
		this.pageRecord = pageRecord;
	}
	public String getSearchTime() {
		return searchTime;
	}
	public void setSearchTime(String searchTime) {
		this.searchTime = searchTime;
	}
	
	
	
}
