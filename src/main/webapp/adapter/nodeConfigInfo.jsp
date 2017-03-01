<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
  <div id="nodeConfigInfo"
			style="width: 100%; height: 100%; background-color: #f5f5f5; border: 1px solid Silver; overflow:auto;">
		<input type="hidden" id="currentParentNodeConfigFlag" value=""/>
		<input type="hidden" id="currentNodeConfigFlag" value=""/>
		<input type="hidden" id="currentParentNodeId" value=""/>
		<input type="hidden" id="currentNodeId" value=""/>
  		<table width="100%">
  			<tr>
  				<td width="20%">
  					&nbsp;&nbsp;<span class="text_font_title"><s:text name='adapterColNodeName'/>:</span>	
  				</td>
  				<td width="80%">
  					<span id="curSelectNodeText"></span>
  				</td> 
  			</tr>
  			<tr>
  				<td>
  					&nbsp;&nbsp;<span class="text_font_title"><s:text name='adapterColNodePath'/>:</span>
  				</td>
  				<td>
  					<span id="curSelectNodePath"></span>
  				</td> 				
  			</tr>   					
  		</table>		
  </div>
  <br/>
  <div>
        <!-- 与界面上的按钮一致  -->
        <!-- addSubNode, modifyCurrentNode,deleteCurrentNode,modifyDetailConfig,deleteDetailConfig  -->
  	    <input type="hidden" id="currentClickOperate" value="">
  		<table width="100%">
  			<tr>
  				<td width="40%" align="left">
					<span class="text_font_title"><s:text name='adapterTagCurNodeList'/>：</span> 					
  				</td>  			
  				<td width="60%" align="right"><%--
					<input type="button" class="button-text" onclick="$('#currentClickOperate').val('addSubNode');openAddSubNodeConifgMethod();" value="添加子节点">
					<input type="button" class="button-text" onclick="$('#currentClickOperate').val('modifyCurrentNode');openModifyCurrentNodeConifgMethod();" value="修改当前节点">
					<input type="button" class="button-text" onclick="$('#currentClickOperate').val('deleteCurrentNode');deleteCurrentNode();" value="删除当前节点">	
					--%>
					<%--<a id="addSubNodeHref" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="$('#currentClickOperate').val('addSubNode');openAddSubNodeConifgMethod();">添加子节点</a>
					<a id="modifyCurrentNodeHref" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="$('#currentClickOperate').val('modifyCurrentNode');openModifyCurrentNodeConifgMethod();" >修改当前节点</a>
					<a id="deleteCurrentNodeHref" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="$('#currentClickOperate').val('deleteCurrentNode');deleteCurrentNode();" >删除当前节点</a>
					--%>
					<ui:button skin="${contextStyleTheme}" text="%{getText('adapterVbtnAddSubNode')}" onclick="$('#currentClickOperate').val('addSubNode');openAddSubNodeConifgMethod();"></ui:button>
					<ui:button skin="${contextStyleTheme}" text="%{getText('adapterVbtnModifyNode')}" onclick="$('#currentClickOperate').val('modifyCurrentNode');openModifyCurrentNodeConifgMethod();"></ui:button>
					<ui:button skin="${contextStyleTheme}" text="%{getText('adapterVbtnDeleteNode')}" onclick="$('#currentClickOperate').val('deleteCurrentNode');deleteCurrentNode();"></ui:button>
  				</td>
  			</tr>
  		</table>   
  </div>
  <div id="nodeOperateInfo" class="div_configinfo" style="width: 100%;">

  		<table id="nodeOperateList" width="100%">
  		</table>
  		<jsp:include page="/adapter/node/add/addNodeConfig.jsp"/>
  		<jsp:include page="/adapter/node/modify/modifyCurrentNodeConfig.jsp"/>
 </div>