<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="addSubNodeDetailConfigInfoDialogExtend" class="easyui-window" closed="true" title="Add sub node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="addSubNodeNameExtend">Sub node name:</span></td>
						<td class="item-content">
							<input type="text" id="addSubNodeNameValueExtend" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >Sub node type:</td>
						<td class="item-content">
							<select id="addSubNodeNodeTypeExtend"" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">Branch</option>
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Sub node generate type:</td>
						<td class="item-content">
							<select id="addSubNodeContent_TypeValueExtend" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Extend method:</td>
						<td class="item-content">
							<input type="text" id="addSubNodeMethodIdExtend" value="" readonly="true"
								onblur="editAttr('method_id',this.value,$('#addNodeId').val(),$('#addNodeOperId').val(),'NODE_CONTENT_CONFIG');"/><%--
							<input type="button" id="addSubNodeMethodIdExtendBtn" value="选择扩展方式" 
								onclick="addSubNodeExtendChoose()" readonly="true"/>
							--%>
							<a class="button-base button-small" title="Choose" target="_blank" onclick="addSubNodeExtendChoose();">
								<span class="button-text" id="addSubNodeDataSetIdDataBaseBtn">Choose</span> 
							</a>								
						</td>
					</tr>
					<tr>
						<td class="item">Code segment:</td>
						<td class="item-content">
							<textarea id="addSubNodeSegmentRealizeExtend"  name="addSubNodeSegmentRealizeExtend" 
								style="width:100%;" rows="20" readonly="true"></textarea>
						</td>
					</tr>										
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="addSubNodeSaveConfigInfo('5');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#addSubNodeDetailConfigInfoDialogExtend').window('close');">Cancel</a>
			</div>
		</div>
	</div>