package com.ailk.eaap.op2.conf.monitor.action;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.HashMap;

import com.linkage.rainbow.ui.struts.BaseAction;
/**
 * UI级报表做成动态报表时需要的一些公共处理类<br>
 * <p>
 * @version 1.0
 * @author 陈亮 2009-08-12
 *         <hr>
 *         修改记录
 *         <hr>
 *         1、修改人员:陈亮 修改时间:2009-08-12<br>
 *         修改内容:新建
 *         <hr>
 */
public class AgilityReportActionBase extends BaseAction{
	//页面表头参数存放Map
	protected Map<String, Object> paraMap = new HashMap<String, Object>();
	/*************************报表区使用变量************************************/
	//报表生成格式,默认html
	protected String format;
	//所有可选维度
	protected List dimensionality;
	//业务量所有可选指标
	protected List statItemListAll;
	//性能所有可选指标
	protected List performanceStatList;
	
	//选中的行维度
	protected String rowGroups;//选中的行维度ID,多个用,号分隔
	protected String rowGroupsSum;//需要合计的行维度,多个用,号分隔
	protected String rowGroupNames;//交叉表头中的中文行表头
	protected List rowGroupsList;//选中的行维度信息,List内元素为Map,Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
	//选中的列维度
	protected String colGroups;//选中的列维度ID,多个用,号分隔
	protected String colGroupsSum;//需要合计的列维度,多个用,号分隔
	protected String colGroupNames;//交叉表头中的中文列表头
	protected List colGroupsList= new ArrayList();//选中的列维度信息,List内元素为Map,Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");

	//选中的指标
	protected String statItem;//选中的指标ID,多个用,号分隔
	protected String statItemName;//报表页面显示的行列交叉表头显示的中文,如果指标只有一个,则在交叉表头显示,大于一个,则在列表头显示
	protected List statItemList;//选中的指标List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
	
	//各树形维度钻取的路径.
	protected Map agilityReportDrillPath = new HashMap();
	
	//产生动态SQL生成的分组统计数据集
	protected List groupList;
	//清单页面URL
	protected String detailURL;
	/************************报表区使用变量END*************************************/
	
	public AgilityReportActionBase(){
	}
	/**
	 * 根据选中的行、列维度，指标生成动态SQL片段。
	 *
	 */
	protected void createDimeAndStat(){
		//生成的动态SQL片段
		String GROUP_COLS=""; //分组字段,用于放在group by 后面
		String GROUP_COL_NAMES=""; //显示分组字段,用于放在select 后面
		String STAT_ITEMS=""; //统计指标字段,用于放在select 后面
		
		if(rowGroups != null){
			//根据选中的行列维度生成维度信息
			Map rowDimeMap = createDimen(true,rowGroups,rowGroupsSum);
			//选中的行,列维度List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
			rowGroupsList = (List)rowDimeMap.get("groupsList");
			//报表页面显示的行列交叉表头显示的中文
			rowGroupNames = (String)rowDimeMap.get("groupNames");
			GROUP_COLS = (String)rowDimeMap.get("GROUP_COLS");
			GROUP_COL_NAMES = (String)rowDimeMap.get("GROUP_COL_NAMES");
		}
		if(colGroups != null){
			Map colDimeMap = createDimen(false,colGroups,colGroupsSum);
			colGroupsList = (List)colDimeMap.get("groupsList");
			colGroupNames = (String)colDimeMap.get("groupNames");
			GROUP_COLS += (String)colDimeMap.get("GROUP_COLS");
			GROUP_COL_NAMES += (String)colDimeMap.get("GROUP_COL_NAMES");
		}
		//根据选中的指标生成指标信息
		Map statMap = createStat(statItem);
		STAT_ITEMS = (String)statMap.get("STAT_ITEMS");
		//报表页面显示的行列交叉表头显示的中文,如果指标只有一个,则在交叉表头显示,大于一个,则在列表头显示
		statItemName =(String)statMap.get("statItemName");
		if(statItemName == null || statItemName.trim().length()==0 && (colGroupNames != null && colGroupNames.length()>0))
			colGroupNames =",[" + getText("eaap.op2.conf.monitor.report.statisticalTarget") + "," +colGroupNames.substring(2);
		//选中的指标List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
		statItemList = (List)statMap.get("statItemList");
		
		//传入生成的动态SQL片段
		paraMap.put("GROUP_COLS",GROUP_COLS);
		paraMap.put("GROUP_COL_NAMES",GROUP_COL_NAMES);
		paraMap.put("STAT_ITEMS",STAT_ITEMS);
	}

	/**
	 * 根据选择中维度ID,生成行或列维度列表等信息.
	 * @param isRow
	 * @param groups
	 * @param groupsSum
	 */
	protected Map createDimen(boolean isRow,String groups,String groupsSum){
		//页面传过来的选中行维度,列维度如果多个时,号分隔时,逗号后会带一空格,去除.
		groups = groups.replaceAll(", ",",");
		groupsSum = groupsSum!=null?groupsSum.replaceAll(", ",","):"";
		
		//选中的行,列维度List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
		List groupsList = new ArrayList();
		
		//报表页面显示的行列交叉表头显示的中文
		String groupNames="";
		
		//生成的动态SQL片段
		String GROUP_COLS=""; //分组字段,用于放在group by 后面
		String GROUP_COL_NAMES=""; //显示分组字段,用于放在select 后面
		
		String groupsArray[] = groups.split(",");
		int iLength = groupsArray.length;
		for(int i=0;i<iLength;i++){
			//根据维度ID查找维度信息
			Map dime = (Map)findDimen(groupsArray[i]);
			
			//判断是维度是否需要合计
			if((","+groupsSum+",").indexOf(","+dime.get("ID")+",")>-1 ){
				dime.put("IS_SUM",true);
				for(int j=0;j<groupsList.size();j++){
					Integer iNextSumNumber = (Integer)((Map)groupsList.get(j)).get("NEXT_SUM_NUMBER");//统计需要合计的下级维度
					((Map)groupsList.get(j)).put("NEXT_SUM_NUMBER",(iNextSumNumber==null?1:iNextSumNumber+1));
				}
			}else {
			    dime.put("IS_SUM",false);
			}

			
			//交叉表头显示的中文表头信息
			if(isRow)
				groupNames=groupNames+ ( groupNames.length()>0?",":"" )+dime.get("NAME");
			else
				groupNames=","+dime.get("NAME")+groupNames;

			//生成动态SQL片段
			if(dime.get("IS_TREE") != null && (Boolean)dime.get("IS_TREE")){//树形维度
				GROUP_COLS +=","+dime.get("TABLE_ALIAS_NAME")+".COL"+paraMap.get(dime.get("ID")+"_NEXT_LEVEL")
				  			+","+dime.get("TABLE_ALIAS_NAME")+".COL"+paraMap.get(dime.get("ID")+"_NEXT_LEVEL") +"_NAME";
				GROUP_COL_NAMES +=","+dime.get("TABLE_ALIAS_NAME")+".COL"+paraMap.get(dime.get("ID")+"_NEXT_LEVEL") +" "+dime.get("ID")
								  +","+dime.get("TABLE_ALIAS_NAME")+".COL"+paraMap.get(dime.get("ID")+"_NEXT_LEVEL") +"_NAME "+dime.get("COL_NAME")
								  +",(select count(*) from "+dime.get("TABLE_NAME")+" x where x.f_node = "+dime.get("TABLE_ALIAS_NAME")+".COL"+paraMap.get(dime.get("ID")+"_NEXT_LEVEL") +" and rownum=1) "+dime.get("ID")+"_IS_HAVE_NEXT";
			}else {//非树形维度
				Object dateType=paraMap.get("DATE_TYPE"); 
				String colName=","+dime.get("TABLE_ALIAS_NAME")+"." +dime.get("ID")+","+dime.get("TABLE_ALIAS_NAME")+"."+dime.get("COL_NAME");
				if(dateType!=null){
					if ("3".equals(dateType)){
						colName=",left(r.DATE_TRAN_ID,8)";
					}else if ("5".equals(dateType)){
						colName=",left(r.DATE_TRAN_ID,6)";
					}else if ("6".equals(dateType)){
						colName=",left(r.DATE_TRAN_ID,4)";
					}
				}
				//ADD BY CHENWEI 用于多维度时维度表COL_NAME字段名字相同而出现信息显示错误 如：m.put("COL_NAME","NAME AS SERVICE_NAME");
				if (dime.get("COL_NAME").toString().indexOf("AS") == -1){
					if (dime.get("ID")!=null&&"DATE_TRAN_ID".equals(dime.get("ID").toString())){
						GROUP_COLS +=colName;
					}else{
						GROUP_COLS +=","+dime.get("TABLE_ALIAS_NAME")+"." +dime.get("ID")+","+dime.get("TABLE_ALIAS_NAME")+"."+dime.get("COL_NAME");
					}
				}else{
					if (dime.get("ID")!=null&&"DATE_TRAN_ID".equals(dime.get("ID").toString())){
						GROUP_COLS +=colName;
					}else{
						GROUP_COLS +=","+dime.get("TABLE_ALIAS_NAME")+"."+dime.get("ID")+","+dime.get("TABLE_ALIAS_NAME")+"."+dime.get("COL_NAME").toString().substring(0,dime.get("COL_NAME").toString().indexOf("AS"));
					}
				}
				if (dime.get("ID")!=null&&"DATE_TRAN_ID".equals(dime.get("ID").toString())){
					GROUP_COL_NAMES +=colName+" as DATE_TRAN_ID"+colName+" as DATE_TRAN_ID";
				}else{
					GROUP_COL_NAMES +=","+dime.get("TABLE_ALIAS_NAME")+"."+dime.get("ID")+","+dime.get("TABLE_ALIAS_NAME")+"."+dime.get("COL_NAME");
				}
			}
			groupsList.add(dime);
		}
		
		if(isRow&&GROUP_COLS.length()>0)
			GROUP_COLS = GROUP_COLS.substring(1); //去除第一个,号字符
		if(isRow&&GROUP_COL_NAMES.length()>0)
			GROUP_COL_NAMES = GROUP_COL_NAMES.substring(1);
		if(groupNames.length()>0)
			groupNames =groupNames.startsWith(",")? ",["+groupNames.substring(1)+"]":"["+groupNames+"]";
		
		Map resultMap = new HashMap();
		resultMap.put("GROUP_COLS",GROUP_COLS); //分组字段,用于放在group by 后面
		resultMap.put("GROUP_COL_NAMES",GROUP_COL_NAMES);//显示分组字段,用于放在select 后面
		resultMap.put("groupsList",groupsList);//选中的行,列维度List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
		resultMap.put("groupNames",groupNames);//报表页面显示的行列交叉表头显示的中文
		return resultMap;
	}
	
	/**
	 * 根据选择中维度ID,生成行或列维度列表等信息.
	 * @param isRow
	 * @param groups
	 * @param groupsSum
	 */
	protected Map  createStat(String statItem){
		statItem = statItem.replaceAll(", ",",");
		String STAT_ITEMS=""; //统计指标字段,用于放在select 后面
		//报表页面显示的行列交叉表头显示的中文,如果指标只有一个,则在交叉表头显示,大于一个,则在列表头显示
		String statItemName = "";
		//选中的指标List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
		List statItemList = new ArrayList();
		
		String groupsArray[] = statItem.split(",");
		int iLength = groupsArray.length;
		for(int i=0;i<iLength;i++){
			//根据指标ID查找指标信息
			Map statItemTmp = (Map)findStat(groupsArray[i]);
			statItemList.add(statItemTmp);
			
			//如果有统计表达式，则自动增加sum()函数
			if(statItemTmp.get("EXPR")!= null && 
					(statItemTmp.get("EXPR").toString().toLowerCase().indexOf("sum(")>-1
							||statItemTmp.get("EXPR").toString().toLowerCase().indexOf("count(")>-1
					)
				){
				STAT_ITEMS +=","+statItemTmp.get("EXPR")+" "+statItemTmp.get("ID");
			}else{
				STAT_ITEMS +=",sum("+(statItemTmp.get("EXPR")!= null?statItemTmp.get("EXPR"):statItemTmp.get("ID"))+") "+statItemTmp.get("ID");
			}
			if(statItemList.size()==1)
				statItemName +=","+statItemTmp.get("NAME");
			else
				statItemName = "";
		}
		if(STAT_ITEMS.length()>0)
			STAT_ITEMS = STAT_ITEMS.substring(1);
		
		Map resultMap = new HashMap();
		resultMap.put("STAT_ITEMS",STAT_ITEMS); //统计指标字段,用于放在select 后面
		resultMap.put("statItemName",statItemName);//报表页面显示的行列交叉表头显示的中文,如果指标只有一个,则在交叉表头显示,大于一个,则在列表头显示
		resultMap.put("statItemList",statItemList);//选中的指标List,List内元素为Map, Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
		return resultMap;
	}

	/**
	 * 通过维度ID,取得维度信息.
	 * Map数据如: m.put("ID","PROD_ID");m.put("NAME","产品类型"); m.put("COL_NAME","PROD_NAME");
	 * @param dimenId
	 * @return
	 */
	protected Map findDimen(String dimenId){
		for(int i=0;i<dimensionality.size();i++){
			Map dimen = (Map)dimensionality.get(i);
			if(dimenId.equals(dimen.get("ID")))
				return dimen;
		}
		return null;
	}
	
	/**
	 * 通过统计指标ID,取得统计指标信息.
	 * Map数据如:m.put("ID","COUNTS"); m.put("NAME","到达数");
	 * @param dimenId
	 * @return
	 */
	protected Map findStat(String statId){
		for(int i=0;i<statItemListAll.size();i++){
			Map stat = (Map)statItemListAll.get(i);
			if(statId.equals(stat.get("ID")))
				return stat;
		}
		return null;
	}
	
	public Map getAgilityReportDrillPath() {
		return agilityReportDrillPath;
	}
	public Map<String, Object> getParaMap() {
		return paraMap;
	}
	public void setParaMap(Map<String, Object> paraMap) {
		this.paraMap = paraMap;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public List getDimensionality() {
		return dimensionality;
	}
	public void setDimensionality(List dimensionality) {
		this.dimensionality = dimensionality;
	}
	public List getStatItemListAll() {
		return statItemListAll;
	}
	public void setStatItemListAll(List statItemListAll) {
		this.statItemListAll = statItemListAll;
	}
	public String getRowGroups() {
		return rowGroups;
	}
	public void setRowGroups(String rowGroups) {
		this.rowGroups = rowGroups;
	}
	public String getRowGroupsSum() {
		return rowGroupsSum;
	}
	public void setRowGroupsSum(String rowGroupsSum) {
		this.rowGroupsSum = rowGroupsSum;
	}
	public String getRowGroupNames() {
		return rowGroupNames;
	}
	public void setRowGroupNames(String rowGroupNames) {
		this.rowGroupNames = rowGroupNames;
	}
	public List getRowGroupsList() {
		return rowGroupsList;
	}
	public void setRowGroupsList(List rowGroupsList) {
		this.rowGroupsList = rowGroupsList;
	}
	public String getColGroups() {
		return colGroups;
	}
	public void setColGroups(String colGroups) {
		this.colGroups = colGroups;
	}
	public String getColGroupsSum() {
		return colGroupsSum;
	}
	public void setColGroupsSum(String colGroupsSum) {
		this.colGroupsSum = colGroupsSum;
	}
	public String getColGroupNames() {
		return colGroupNames;
	}
	public void setColGroupNames(String colGroupNames) {
		this.colGroupNames = colGroupNames;
	}
	public List getColGroupsList() {
		return colGroupsList;
	}
	public void setColGroupsList(List colGroupsList) {
		this.colGroupsList = colGroupsList;
	}
	public String getStatItem() {
		return statItem;
	}
	public void setStatItem(String statItem) {
		this.statItem = statItem;
	}
	public String getStatItemName() {
		return statItemName;
	}
	public void setStatItemName(String statItemName) {
		this.statItemName = statItemName;
	}
	public List getStatItemList() {
		return statItemList;
	}
	public void setStatItemList(List statItemList) {
		this.statItemList = statItemList;
	}
	public List getGroupList() {
		return groupList;
	}
	public void setGroupList(List groupList) {
		this.groupList = groupList;
	}
	public String getDetailURL() {
		return detailURL;
	}
	public void setDetailURL(String detailURL) {
		this.detailURL = detailURL;
	}
	public void setAgilityReportDrillPath(Map agilityReportDrillPath) {
		this.agilityReportDrillPath = agilityReportDrillPath;
	}
	public List getPerformanceStatList() {
		return performanceStatList;
	}
	public void setPerformanceStatList(List performanceStatList) {
		this.performanceStatList = performanceStatList;
	}
}
