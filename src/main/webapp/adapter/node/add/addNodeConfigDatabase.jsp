<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="addSubNodeDetailConfigInfoDialogDataBase" class="easyui-window" closed="true" title="Add sub node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="addSubNodeNameDataBase">Sub node name:</span></td>
						<td class="item-content">
							<input type="text" id="addSubNodeNameValueDataBase" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >Sub node type:</td>
						<td class="item-content">
							<select id="addSubNodeNodeTypeDataBase"" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">Branch</option>
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Sub node generate type:</td>
						<td class="item-content">
							<select id="addSubNodeContent_TypeValueDataBase" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Dataset :</td>
						<td class="item-content">
							<input type="text" id="addSubNodeDataSetIdDataBase" value="" readonly="true"
								onblur="editAttr('data_set_id',this.value,$('#addNodeId').val(),$('#addNodeOperId').val(),'NODE_CONTENT_CONFIG');"/>
							<%--
							<input type="button" id="addSubNodeDataSetIdDataBaseBtn" value="选择记录集" 
								onclick="addSubNodeDataSetChoose()"/>
							--%>
							<a class="button-base button-small" title="Choose" target="_blank" onclick="addSubNodeDataSetChoose();">
								<span class="button-text" id="addSubNodeDataSetIdDataBaseBtn">Choose</span> 
							</a>								
						</td>
					</tr>
					<tr>
						<td class="item">Query SQL:</td>
						<td>
							<textarea id="addSubNodeQuery_SQLDataBase"  name="addSubNodeQuery_SQLDataBase" 
								style="width:100%;" rows="5" readonly="true"></textarea>						
						</td>
					</tr>
					<tr>
						<td class="item">Column name:</td>
						<td class="item-content">
							<input type="text" id="addSubNodeCol_NameDataBase" value=""
								onblur="editAttr('col_name',this.value,$('#addNodeId').val(),$('#addNodeOperId').val(),'NODE_CONTENT_CONFIG');"/>
						</td>
					</tr>										
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton"  onclick="addSubNodeSaveConfigInfo('3');">Save</a>
				<a class="easyui-linkbutton"  onclick="$('#addSubNodeDetailConfigInfoDialogDataBase').window('close');">Cancel</a>
			</div>
		</div>
	</div>