<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/common/taglibs.jsp"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ page import="java.util.Map,java.util.List" %>
<html>
	<head>
		<title><s:property value="%{getText('eaap.op2.conf.prov.SysName')}" /></title>
		<meta http-equiv="pragma" content="no-cache">
	    <meta http-equiv="cache-control" content="no-cache">
	    
		<link rel="stylesheet" type="text/css" href="${contextPath}/resource/${contextStyleTheme}/css/sys-style.css" />
		<script type="text/javascript" src="${contextPath}/resource/comm/js/jquery.js"></script>
		<style type="text/css"> 
			td {
				FONT: 12px
			}
			.td_style { border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 0px solid #ffffff; border-top: 0px solid #ffffff; } 
			.td_left_style { border-bottom: 1px solid #000000; border-left: 0px solid #000000; border-right: 0px solid #ffffff; border-top: 0px solid #ffffff; }
			.td_bottom_style { border-bottom: 0px solid #000000; border-left: 1px solid #000000; border-right: 0px solid #ffffff; border-top: 0px solid #ffffff; }
			.table_style {border-color: #000000 #000000 #000000 #000000; border-style: solid; border-top-width: 2px; border-right-width: 2px; border-bottom-width: 2px; border-left-width: 2px; } 
		</style>
	</head>

	<body>
		<fieldset>
			<legend>
				[<b><s:property value="%{getText('eaap.op2.conf.monitor.report.chartArea')}"/></b>]
			</legend>
			<s:if test="%{groupList != null}">
				<s:set name="trCrossHeight" value="30"></s:set> 
				<s:if test="%{statItemList.size()>1 && colGroupsList.size()>0}">          
					<s:set name="crossRowspan" value="%{colGroupsList.size+1}"></s:set>  
					<s:set name="crossWidth" value="%{200*rowGroupsList.size}"></s:set> 
					<s:set name="crossHeight" value="%{30*(colGroupsList.size+1)}"></s:set> 
					<s:set name="colGroupColspan" value="%{statItemList.size()}"></s:set> 
				</s:if>
				<s:else>
					<s:set name="crossRowspan" value="%{colGroupsList.size}"></s:set>
					<s:set name="crossWidth" value="%{200*rowGroupsList.size}"></s:set>
					<s:set name="colGroupColspan" value="1"></s:set>
					<s:if test="%{colGroupsList.size()==1 && paraMap.showBias}">
						<s:set name="crossHeight" value="%{30*(colGroupsList.size()+1)}"></s:set> 
						<s:set name="trCrossHeight" value="60"></s:set>
					</s:if>
					<s:else>
						<s:set name="crossHeight" value="%{30*colGroupsList.size}"></s:set> 
					</s:else>
				</s:else>
				
				<s:if test="%{paraMap.scrolling}"><%--is dongjie header--%>	
					<s:set name="tableHeight" value="400"></s:set>
					<s:set name="tableWidth" value="100%"></s:set>
					<s:set name="tableStyle" value=""></s:set>
				</s:if>
				<s:else>
					<s:set name="tableHeight" value=""></s:set>
					<s:set name="tableWidth" value=""></s:set>
					<s:set name="tableStyle" value="%{'table-layout:fixed;border-collapse:collapse;POSITION:absolute'}"></s:set>
				</s:else>
				
			<ui:table id="agilityReport" ds="groupList as list" width="%{tableWidth}"
					cellpadding="0" cellspacing="0"  styleClass="table_style" scrolling="%{paraMap.scrolling}"  height="%{tableHeight}" style="%{tableStyle}">
				<ui:colgroup>
					<s:iterator id="rowGroup" value="rowGroupsList">
						<ui:col areaType="head"  width="200">
						</ui:col>
					</s:iterator>
					<s:iterator id="colGroup" value="colGroupsList">
						<s:iterator id="statItem" value="statItemList" status="statItemStatus">
								<ui:col width="200" ></ui:col>
						</s:iterator>
					</s:iterator>
					
					<s:if test="%{colGroupNames == null || colGroupNames.length()==0}">
						<s:iterator id="statItem" value="statItemList" status="statItemStatus">
								<ui:col width="200" ></ui:col>
						</s:iterator>
					</s:if>
					
					<s:iterator id="colGroup" value="colGroupsList" >
						<s:if test="%{IS_SUM}">
							<s:iterator id="stat" value="statItemList" >
								<ui:col width="200" ></ui:col>
							</s:iterator>
						</s:if>
					</s:iterator>
				</ui:colgroup> 

				<ui:tr height="%{trCrossHeight}" areaType="head" >
					<s:if test="%{colGroupNames.length()>0&& paraMap.showBias}">
						<ui:td nowrap="true" rowspan="%{crossRowspan}" colspan="%{rowGroupsList.size}" width="%{crossWidth}"  height="%{crossHeight}"  style="w" align="left" valign="top"  styleClass="td_left_style" bgcolor="#F4F6F5">
								=bias(${rowGroupNames}${statItemName}${colGroupNames})
						</ui:td>
					</s:if>
					<s:else>
						<s:iterator id="rowGroup" value="rowGroupsList" status="rowGroupStatus">
							<ui:td nowrap="true" rowspan="%{crossRowspan}" height="%{crossHeight}" styleClass="td_left_style" bgcolor="#F4F6F5" align="center">
								${rowGroup.NAME}
							</ui:td>
						</s:iterator>
					</s:else>
					<s:if test="%{colGroupNames.length()>0}">
						<ui:td colspan="${colGroupColspan*(colGroupsList[0].NEXT_SUM_NUMBER+1)}" extDirection="x" nowrap="true" styleClass="td_style" bgcolor="#F4F6F5"  align="center">
							=list.group([${colGroupsList[0].ID},${colGroupsList[0].COL_NAME}],,[2,${colGroupsList[0].ID}_IS_HAVE_NEXT==1,"paraMap.${colGroupsList[0].ID}="+${colGroupsList[0].ID}])
						</ui:td>
						<s:if test="%{colGroupsList[0].IS_SUM}">
							<ui:td nowrap="true" styleClass="td_style" bgcolor="#FCFCD2" align="center" 
									rowspan="%{colGroupsList.size()}" colspan="%{colGroupColspan}">
								<s:property value="%{getText('eaap.op2.conf.monitor.report.heji')}"/>:
							</ui:td>
						</s:if>
					</s:if>
					<s:else>
						<s:iterator id="stat" value="statItemList"  >
							<ui:td  extDirection="x" nowrap="true" styleClass="td_style" bgcolor="#F4F6F5" align="center">
								${stat.NAME}
							</ui:td>
						</s:iterator>
					</s:else>
				</ui:tr>
				
				<s:iterator id="colGroup" value="colGroupsList" status="colGroupStatus" >
					<s:if test="#colGroupStatus.index>0">
						<ui:tr height="30" areaType="head" >
							<ui:td  colspan="${colGroupColspan*(colGroup.NEXT_SUM_NUMBER+1)}" extDirection="x" nowrap="true" styleClass="td_style" bgcolor="#F4F6F5"   align="center">
								=list.group([${colGroup.ID},${colGroup.COL_NAME}],,[2,${colGroup.ID}_IS_HAVE_NEXT==1,"paraMap.${colGroup.ID}="+${colGroup.ID}])
							</ui:td>
						</ui:tr>
						
						<s:if test="%{IS_SUM}"><%--show column total--%>
							<ui:td nowrap="true" styleClass="td_style" bgcolor="#FCFCD2" align="center" 
									rowspan="%{colGroupsList.size()-#colGroupStatus.index}"  colspan="%{colGroupColspan}">
								<s:property value="%{getText('eaap.op2.conf.monitor.report.heji')}"/>:
							</ui:td>
						</s:if>
					</s:if>
				</s:iterator>
				
				<s:if test="%{statItemList.size()>1 && colGroupNames.length()>0}">
					<ui:tr height="30" areaType="head" >
						<s:iterator id="stat" value="statItemList" >
							<ui:td  extDirection="x" nowrap="true" styleClass="td_style" bgcolor="#F4F6F5"  align="center" >
								${stat.NAME}
							</ui:td>
						</s:iterator>
						<s:iterator id="colGroup" value="colGroupsList" status="colGroupStatus" >
							<s:if test="%{IS_SUM}"><%--show total--%>
								<s:iterator id="stat" value="statItemList" >
									<ui:td  extDirection="x" nowrap="true" styleClass="td_style" bgcolor="#FCFCD2"  align="center" >
										${stat.NAME}
									</ui:td>
								</s:iterator>
							</s:if>
						</s:iterator>
					</ui:tr>
					
				</s:if>
				
				<%--show row dim--%>
				<ui:tr height="30">
					<s:iterator id="rowGroup" value="rowGroupsList" status="rowGroupStatus">
						<s:set name="rowGroupTdStyle" value="%{'td_style'}"></s:set>
						<s:if test="#rowGroupStatus.index==0">
							<s:set name="rowGroupTdStyle" value="%{'td_left_style'}"></s:set>
						</s:if>
						
						<ui:td nowrap="true" styleClass="${rowGroupTdStyle}" bgcolor="#F4F6F5" rowspan="${rowGroup.NEXT_SUM_NUMBER+1}">
							=list.group([${rowGroup.ID},${rowGroup.COL_NAME}],,[2,${rowGroup.ID}_IS_HAVE_NEXT==1,"paraMap.${rowGroup.ID}="+${rowGroup.ID}])
						</ui:td>
					</s:iterator>
					
					<s:iterator id="colGroup" value="colGroupsList" status="colGroupStatus" >
						<s:set name="linkURLCol" value="%{#linkURLCol+'+\\'&paraMap.'+ID+'=\\'+list.'+ID}"></s:set>
					</s:iterator>
					
					<%--show tongji zhibiao--%>
					<s:iterator id="stat" value="statItemList" >
						<ui:td styleClass="td_style" align="right" indention="2" dataFormat="%{DATAFORMAT}" defaultContent="0">
							=list.select(${stat.ID})
						</ui:td>
					</s:iterator>
					<%--show column heji xiang tongji zhibiao--%>
					<%
					List colList =(List)request.getAttribute("colGroupsList");
					if(colList != null)
					for(int i=colList.size()-1;i>=0;i--){
						Map colGroupMap = (Map)colList.get(i);
						if(colGroupMap.get("IS_SUM") != null && colGroupMap.get("IS_SUM").toString().equals("true")){
							request.setAttribute("colGroup",colGroupMap);
							request.setAttribute("colGroupStatusIndex",i);
					%>
							<s:iterator id="colGroupLink" value="colGroupsList" status="colGroupStatusLink" >
								<s:if test="%{#colGroupStatusLink.index<#request.colGroupStatusIndex}">
									<s:set name="linkURLSum" value="%{#linkURLSum+'+\\'&paraMap.'+ID+'=\\'+list.'+ID}"></s:set>
								</s:if>
							</s:iterator>
							<s:iterator id="stat" value="statItemList" >
								<ui:td styleClass="td_style" align="right" indention="2" dataFormat="%{DATAFORMAT}"  bgcolor="#FCFCD2" defaultContent="0">
									<s:if test="%{#stat.TOTAL_EXPR != null}">
										=${fn:replace(fn:replace(stat.TOTAL_EXPR,"sum(","list.sum("),"count(","list.count(")}
									</s:if>
									<s:else>
										=list.sum(${stat.ID})
									</s:else>
								</ui:td>
							</s:iterator>
					<%
						}
					}
					%>
				</ui:tr>
				<%--print heji xiang--%>
				<%
				List rowList =(List)request.getAttribute("rowGroupsList");
				for(int i=rowList.size()-1;i>=0;i--){
					Map rowGroupMap = (Map)rowList.get(i);
					if(rowGroupMap.get("IS_SUM") != null && rowGroupMap.get("IS_SUM").toString().equals("true")){
						request.setAttribute("rowGroup",rowGroupMap);
						request.setAttribute("colspan",rowList.size()-i);
						request.setAttribute("rowGroupStatusIndex",i);
						if(i==0){
							request.setAttribute("rowSumStyle","td_left_style");
						} else {
							request.setAttribute("rowSumStyle","td_style");
						}
				%>
						<ui:tr height="30" >
							<ui:td nowrap="true" styleClass="${rowSumStyle}" bgcolor="#FCFCD2" align="center" 
								colspan="${colspan}">
							<s:property value="%{getText('eaap.op2.conf.monitor.report.heji')}"/>:
							</ui:td>
							<s:iterator id="rowGroupLink" value="rowGroupsList" status="rowGroupStatusLink" >
								<s:if test="%{#rowGroupStatusLink.index<#request.rowGroupStatusIndex}">
									
								</s:if>
							</s:iterator>
							<s:iterator id="stat" value="statItemList" >
								<ui:td styleClass="td_style" align="right" indention="2" dataFormat="%{DATAFORMAT}" bgcolor="#FCFCD2" defaultContent="0">
									<s:if test="%{#stat.TOTAL_EXPR != null}">
										=${fn:replace(fn:replace(stat.TOTAL_EXPR,"sum(","list.sum("),"count(","list.count(")}
									</s:if>
									<s:else>
										=list.sum(${stat.ID})
									</s:else>
								</ui:td>
							</s:iterator>
							
							<%
							List colList2 =(List)request.getAttribute("colGroupsList");
							if(colList2 != null)
							for(int j=colList2.size()-1;j>=0;j--){
								Map colGroupMap = (Map)colList2.get(j);
								if(colGroupMap.get("IS_SUM") != null && colGroupMap.get("IS_SUM").toString().equals("true")){
									request.setAttribute("colGroup",colGroupMap);
									request.setAttribute("colGroupStatusIndex",j);
							%>
									<s:iterator id="colGroupLink" value="colGroupsList" status="colGroupStatusLink" >
										<s:if test="%{#colGroupStatusLink.index<#request.colGroupStatusIndex}">
										</s:if>
									</s:iterator>
									<s:iterator id="stat" value="statItemList" >
										<ui:td styleClass="td_style" align="right" indention="2" dataFormat="%{DATAFORMAT}"  bgcolor="#FCFCD2" defaultContent="0">
										<s:if test="%{#stat.TOTAL_EXPR != null}">
										=${fn:replace(fn:replace(stat.TOTAL_EXPR,"sum(","list.sum("),"count(","list.count(")}
										</s:if>
										<s:else>
											=list.sum(${stat.ID})
										</s:else>
										</ui:td>
									</s:iterator>
							<%
								}
							}
							%>
						</ui:tr>
						<%
					}
				}%>
				<ui:noRecord>
				<br>
				<s:property value="%{getText('eaap.op2.conf.monitor.report.nodata')}"/>!
				</ui:noRecord>
			</ui:table>
			<s:if test="%{paraMap.showChart}">
				<s:if test="%{colGroupsList.size()>0}">
					<ui:barFlashChart id="barChart" value="groupList " colNames="${rowGroupsList[0].COL_NAME},${colGroupsList[0].COL_NAME},${statItemList[0].ID}"
						width="" barWidth="20" plotType="3D" depth="10" showDataTitle="true">
					</ui:barFlashChart>
				</s:if>
				<s:else>
					<s:if test="%{rowGroupsList.size()>1}">
						<ui:barFlashChart id="barChart" value="groupList " colNames="${rowGroupsList[0].COL_NAME},${rowGroupsList[1].COL_NAME},${statItemList[0].ID}"
							width="" barWidth="20" plotType="3D" depth="10" showDataTitle="true">
					    </ui:barFlashChart>
					</s:if>
					<s:else>
						<s:set name="chartStatItemTitle" value="%{''}"></s:set>
						<s:set name="chartStatItem" value="%{''}"></s:set>
						<s:set name="chartShowSubTitle" value="false"></s:set>
						<s:iterator id="stat" value="statItemList" >
							<s:set name="chartStatItemTitle" value="%{#chartStatItemTitle+NAME+','}"></s:set>
							<s:set name="chartStatItem" value="%{#chartStatItem+','+ID}"></s:set>
						</s:iterator>
						<s:if test="%{statItemList.size()>1}">
							<s:set name="chartShowSubTitle" value="true"></s:set>
						</s:if>
						${chartStatItemTitle}
						---------------
						${rowGroupsList[0].COL_NAME}
						-------------
						${chartStatItem}
						<ui:barFlashChart id="barChart" value="groupList " rowTitle="${chartStatItemTitle}" colNames="${rowGroupsList[0].COL_NAME}${chartStatItem}"
							width="" barWidth="20" plotType="3D" depth="10"   showDataTitle="true" showSubTitle="${chartShowSubTitle}">
						</ui:barFlashChart>
					</s:else>
				</s:else>
			</s:if>
			<script type="text/javascript">
				var chart_Width = $("#agilityReport_scrollArea").css("width");
				$("#amcolumn").attr("width",""+chart_Width);
			</script>
		</s:if>
		<s:else>
		</s:else>
		</fieldset>
	</body>
</html>
