package com.ailk.eaap.op2.conf.monitor.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.ailk.eaap.op2.bo.BizFunction;
import com.ailk.eaap.op2.bo.Component;
import com.ailk.eaap.op2.bo.Org;
import com.ailk.eaap.op2.bo.Service;
import com.ailk.eaap.op2.conf.monitor.service.IMonitorReportService;
import com.ailk.eaap.op2.conf.util.CommonUtil;
import com.linkage.rainbow.util.DateUtil;
import java.util.GregorianCalendar;

public class MonitorReportAction extends AgilityReportActionBase{

	private static final long serialVersionUID = 0L;
	private IMonitorReportService monitorReportService;
	//机构下拉框可选值
	private List<Org> selectOrgList = new ArrayList<Org>();
	//组件下拉框可选值
	private List<Component> selectComponentList = new ArrayList<Component>();
	//服务下拉框可选值
	private List<Service> serviceList = new ArrayList<Service>();
	//业务下拉框可选值
	private List<BizFunction> bizFunctionList = new ArrayList<BizFunction>();
	//是否显示图标
	private List<String> showChartList = new ArrayList<String>();
	private String btime;
	private String etime;
	
	public MonitorReportAction(){
	}
	
	public void init(){
		//可选维度
		dimensionality = new ArrayList();
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("ID","ORG_CODE");//维度ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.org"));//维度中文名
		m.put("TABLE_NAME","ORG"); //维度表表名
		m.put("TABLE_ALIAS_NAME","o"); //维度表别名
		m.put("COL_NAME","NAME AS ORG_NAME");
		m.put("IS_SUM",true);//本维度是否需要合计
	//	m.put("NEXT_SUM_NUMBER",0);//下级关联维度需要合计的个数
	//	m.put("IS_TREE",true);//是否为树形维度
		dimensionality.add(m);
		
		m = new HashMap();
		m.put("ID","COMPONENT_ID");//维度ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.component"));//维度中文名
		m.put("TABLE_NAME","COMPONENT"); //维度表表名
		m.put("TABLE_ALIAS_NAME","c"); //维度表别名
		m.put("COL_NAME","NAME");
		m.put("IS_SUM",true);//本维度是否需要合计
		dimensionality.add(m);
		
		m = new HashMap();
		m.put("ID","SERVICE_CODE");//维度ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.service"));//维度中文名
		m.put("TABLE_NAME","SERVICE"); //维度表表名
		m.put("TABLE_ALIAS_NAME","s"); //维度表别名
		m.put("COL_NAME","SERVICE_CN_NAME");
		m.put("IS_SUM",true);//本维度是否需要合计
		dimensionality.add(m);
		
		m = new HashMap();
		m.put("ID","DATE_TRAN_ID");//维度ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.date"));//维度中文名
		m.put("TABLE_NAME","REG_STAT_RECENT"); //维度表表名
		m.put("TABLE_ALIAS_NAME","r"); //维度表别名
		m.put("COL_NAME","DATE_TRAN_ID");
		m.put("IS_SUM",true);//本维度是否需要合计
		dimensionality.add(m);
		
		
//		m = new HashMap();
//		m.put("ID","CODE");//维度ID
//		m.put("NAME",getText("eaap.op2.conf.monitor.report.biz"));//维度中文名
//		m.put("TABLE_NAME","BIZ_FUNCTION"); //维度表表名
//		m.put("TABLE_ALIAS_NAME","b"); //维度表别名
//		m.put("COL_NAME","NAME AS SERVICE_NAME");
//		m.put("IS_SUM",true);//本维度是否需要合计
//		dimensionality.add(m);
		
		//可选指标
		statItemListAll = new ArrayList();
		m = new HashMap();
		m.put("ID","TOTAL_TRANS"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.bizTotal"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		statItemListAll.add(m);
		
		m = new HashMap();
		m.put("ID","TOTAL_SYS_ERR"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.sysErrTotal"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		statItemListAll.add(m);
		
		m = new HashMap();
		m.put("ID","TOTAL_BIZ_ERR"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.bizErrTotal"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		statItemListAll.add(m);
		
		m = new HashMap();
		m.put("ID","AVG_USING"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.csb"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		statItemListAll.add(m);
		
		m = new HashMap();
		m.put("ID","AVG_USING_DST"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.supply"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		statItemListAll.add(m);
		
		performanceStatList = new ArrayList();
		m = new HashMap();
		m.put("ID","TOTAL_TRANS"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.bizTotal"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		performanceStatList.add(m);
		
		m = new HashMap();
		m.put("ID","TOTAL_SYS_ERR"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.sysErrTotal"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		performanceStatList.add(m);
		
		m = new HashMap();
		m.put("ID","TOTAL_BIZ_ERR"); //指标ID
		m.put("NAME",getText("eaap.op2.conf.monitor.report.bizErrTotal"));//指标中文名
		m.put("DATAFORMAT","#,##0");//指标数据显示格式，参考EXCEL格式设置
		performanceStatList.add(m);
	}
	
	//渲染报表查询区
	public String showReportIndex(){
		init();
		//1 初始化加载当前用户所有的org(多个)待确定？用户对应角色，角色对应机构，
    	Map<String,Object> map = new HashMap<String,Object>();
    	//TODO
    	//map.put("orgId","100001,600105");
    	selectOrgList = getMonitorReportService().queryOrgList(map);
    	//2 初始化加载 当前用户所有ORG下的全部组件下拉项
        selectComponentList = getMonitorReportService().queryComponentInfo(map);
        //3初始化加载 当前用户所有ORG下的全部服务下拉项
        serviceList = getMonitorReportService().queryServiceList(map);
        //4初始化加载 当前用户所有ORG下的全部业务下拉项
        bizFunctionList = getMonitorReportService().queryBizFunctionList(map);
        
        //5初始化是否显示图表 
        String showStr = getText("eaap.op2.conf.monitor.report.yes");
        String notShowStr = getText("eaap.op2.conf.monitor.report.no");
        showChartList.add(showStr);
        showChartList.add(notShowStr);
        
        /**************行维度,列维度,统计指标默认选中值配置,***********************************/
		rowGroupNames="COMPONENT_ID";
		colGroupNames="SERVICE_CODE";
		statItem="AVG_USING,AVG_USING_DST";

		//设置查询时间默认值（Daily）：
        GregorianCalendar gc=new GregorianCalendar(); 
        gc.setTime(new Date());	
        gc.add(1,-1);	//表示年份减一
        java.text.DateFormat formatDT = new java.text.SimpleDateFormat("yyyy-MM-dd");
		btime	= formatDT.format(gc.getTime());
        etime 	= formatDT.format(new Date());
		return SUCCESS;
	}
	
	//报表显示区
	public String loadReportData(){
		String bt[]= (String[])paraMap.get("beginTime");
		String et[]= (String[])paraMap.get("endTime");
		String tt[]= (String[])paraMap.get("targetType");
		if (StringUtils.isNotBlank(bt[0])){
			paraMap.put("beginTime", DateUtil.regularize(bt[0]));
		}
		if (StringUtils.isNotBlank(et[0])){
			paraMap.put("endTime", DateUtil.regularize(et[0]));
		}
		if (StringUtils.isNotBlank(tt[0])){
			paraMap.put("targetType", tt[0]);
		}
		String dt[]= (String[])paraMap.get("dateType");
		if ("1".equals(dt[0])){
			paraMap.put("DATE_TYPE", "3");  // 3 天
		}else if ("2".equals(dt[0])){
			paraMap.put("DATE_TYPE", "5");  // 5 月
		}else if ("3".equals(dt[0])){
			paraMap.put("DATE_TYPE", "6");  // 6 季度
		}
		init();
		super.createDimeAndStat();
		//生成分组数据.
		groupList = getMonitorReportService().selectReportResult(paraMap);
		return SUCCESS;
	}
	
	public String loadDateDiv(){
		String type=getRequest().getParameter("type");
		getRequest().setAttribute("type", type);
		
		//设置查询时间默认值：
        GregorianCalendar gc=new GregorianCalendar(); 
        gc.setTime(new Date());	
        gc.add(1,-1);	//表示年份减一
		if(type.equals("1")){	//1:Daily 2:Monthly 3:Quarterly
	        java.text.DateFormat formatDT = new java.text.SimpleDateFormat("yyyy-MM-dd");
			btime	= formatDT.format(gc.getTime());
	        etime 	= formatDT.format(new Date());
		}else if(type.equals("2")){
	        java.text.DateFormat formatDT = new java.text.SimpleDateFormat("yyyy-MM");
			btime	= formatDT.format(gc.getTime());
	        etime 	= formatDT.format(new Date());
		}else if(type.equals("3")){
	        java.text.DateFormat formatDT = new java.text.SimpleDateFormat("yyyy");
			btime	= formatDT.format(gc.getTime());
	        etime 	= formatDT.format(new Date());
		}
		return SUCCESS;
	}
	public IMonitorReportService getMonitorReportService() {
		if (monitorReportService == null) {
			WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(this.getSession().getServletContext());
			monitorReportService = (IMonitorReportService)ctx.getBean("eaap-op2-conf-monitor-MonitorReportService");
		}
		return monitorReportService;
	}
	public void setMonitorReportService(IMonitorReportService monitorReportService) {
		this.monitorReportService = monitorReportService;
	}

	public List<Org> getSelectOrgList() {
		return selectOrgList;
	}

	public void setSelectOrgList(List<Org> selectOrgList) {
		this.selectOrgList = selectOrgList;
	}

	public List<Component> getSelectComponentList() {
		return selectComponentList;
	}

	public void setSelectComponentList(List<Component> selectComponentList) {
		this.selectComponentList = selectComponentList;
	}

	public List<Service> getServiceList() {
		return serviceList;
	}

	public void setServiceList(List<Service> serviceList) {
		this.serviceList = serviceList;
	}

	public List<BizFunction> getBizFunctionList() {
		return bizFunctionList;
	}

	public void setBizFunctionList(List<BizFunction> bizFunctionList) {
		this.bizFunctionList = bizFunctionList;
	}
	
	public List<String> getShowChartList() {
		return showChartList;
	}

	public void setShowChartList(List<String> showChartList) {
		this.showChartList = showChartList;
	}

	public String getBtime() {
		return btime;
	}

	public void setBtime(String btime) {
		this.btime = btime;
	}

	public String getEtime() {
		return etime;
	}

	public void setEtime(String etime) {
		this.etime = etime;
	}
	
}
