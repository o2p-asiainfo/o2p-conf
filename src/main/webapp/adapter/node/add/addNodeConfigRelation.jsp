<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="addNodeDetailConfigInfoDialog" class="easyui-window" closed="true" title="新增节点" iconCls="icon-save" style="width:500px;height:320px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<input type="hidden" id="treeOperatorType" value=""/>
				<input type="hidden" id="treeSelectNodeId" value=""/>
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="addSubNodeName">子节点名称:</span></td>
						<td class="item-content">
							<input type="text" id="addSubNodeNameValue" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >子节点类型:</td>
						<td class="item-content">
							<select id="addNodeType" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">树枝节点</option>
								<option value="1">叶子节点</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">子节点生成方式:</td>
						<td class="item-content">
							<select id="addContent_TypeValue" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">固定值:</td>
						<td class="item-content">
							<input type="text" id="addFix_Value" value=""/>
						</td>
					</tr>					
					<tr>
						<td class="item" >值转换策略:</td>
						<td class="item-content">
							<input type="text" id="addCont_Converter_Id" value=""/>
							<input type="button" value="选择" onClick="$('#getValueExprWin').window('open');"/>
						</td>
					</tr>
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="addSubNodeSave();">保 存</a>
				<a class="easyui-linkbutton" onclick="addSubNodeCancel()">取 消</a>
			</div>
		</div>
	</div>