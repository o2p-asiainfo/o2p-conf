<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="modifyCurrentNodeDetailConfigInfoDialogDataBase" class="easyui-window" closed="true" title="Modify node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="modifyCurrentNodeNameDataBase">Node name:</span></td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeNameValueDataBase" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >Node type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeeNodeTypeDataBase"" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">Branch</option>
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Node generate type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeContent_TypeValueDataBase" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Dataset:</td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeDataSetIdDataBase" value="" readonly="true"
								onblur="editAttr('data_set_id',this.value,$('#modifyCurrentNodeNodeId').val(),$('#modifyCurrentNodeOperId').val(),'NODE_CONTENT_CONFIG');"/>
							<%--
							<input type="button" id="modifyCurrentNodeDataSetIdDataBaseBtn" value="选择记录集" 
								onclick="modifyCurrentNodeDataSetChoose()" readonly="true"/>
							--%>
							<a class="button-base button-small" title="Choose" target="_blank" onclick="modifyCurrentNodeDataSetChoose();">
								<span class="button-text" id="modifyCurrentNodeDataSetIdDataBaseBtn">Choose</span> 
							</a>								
						</td>
					</tr>
					<tr>
						<td class="item">Column name:</td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeCol_NameDataBase" value=""
								onblur="editAttr('col_name',this.value,$('#modifyCurrentNodeNodeId').val(),$('#modifyCurrentNodeOperId').val(),'NODE_CONTENT_CONFIG');"/>
						</td>
					</tr>										
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="modifyCurrentNodeSaveConfigInfo('3');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#modifyCurrentNodeDetailConfigInfoDialogDataBase').window('close');">Cancel</a>
			</div>
		</div>
	</div>