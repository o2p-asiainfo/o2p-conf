<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="addSubNodeDetailConfigInfoDialogDocument" class="easyui-window" closed="true" title="Add sub node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="addSubNodeNameDocument">Sub node name:</span></td>
						<td class="item-content">
							<input type="text" id="addSubNodeNameValueDocument" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >Sub node type:</td>
						<td class="item-content">
							<select id="addSubNodeNodeTypeDocument" style="width:100%;" value=""
								onchange="selectAddSubNodeNodeTypeDocumentChange(this);">
								<option value=""></option>
								<option value="0">Branch</option> 
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Sub node generate type:</td>
						<td class="item-content">
							<select id="addSubNodeContent_TypeValueDocument" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">
						   	 Source XML path: 
		   					<a class="button-base button-small" title="Add path" target="_blank" onclick="addSubNodeConfigPathNoPathId()">
								<span class="button-text" id="addSubNodeNodeConfigPathBtn">Add path</span>
							</a>
							<%--
							<span class='text_font_common'><input type="button" id="addSubNodeNodeConfigPathBtn" value="添加节点路径" onclick="addSubNodeConfigPathNoPathId()"/></span>
		   					--%>
						
						</td>
						<td class="item-content" >
							<table id="addSubNodeNodeConfigPathTable" width="100%"></table>
						</td>
					</tr>
					<!-- 					
					<tr>
						<td class="item" >值转换策略:</td>
						<td class="item-content">
							<input type="text" id="addCont_Converter_IdDocument" value=""/>
							<input type="button" value="选择" onClick="$('#getValueExprWin').window('open');"/>
						</td>
					</tr>
					-->
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="addSubNodeSaveConfigInfo('2');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#addSubNodeDetailConfigInfoDialogDocument').window('close');">Cancel</a>
			</div>
		</div>
	</div>