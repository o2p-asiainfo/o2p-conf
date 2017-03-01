<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="modifyCurrentNodeDetailConfigInfoDialogDocument" class="easyui-window" closed="true" title="Modify node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="modifyCurrentNodeNameDocument">Node name:</span></td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeNameValueDocument" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >Node type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeNodeTypeDocument" style="width:100%;" value=""
								onchange="selectModifyCurrentNodeNodeTypeDocumentChange(this);">
								<option value=""></option>
								<option value="0">Branch</option> 
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Node generate type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeContent_TypeValueDocument" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">
							Source XML path:
		   					<a class="button-base button-small" title="Add path" target="_blank" onclick="modifyCurrentNodeConfigPathNoPathId()">
								<span class="button-text" id="modifyCurrentNodeNodeConfigPathBtn">Add path</span>
							</a><%--							
							<span class='text_font_common'><input type="button" id="modifyCurrentNodeNodeConfigPathBtn" value="修改当前节点路径" onclick="modifyCurrentNodeConfigPathNoPathId()"/></span>
						--%>
						</td>
						<td class="item-content" >
							<table id="modifyCurrentNodeNodeConfigPathTable" width="100%"></table>
						</td>
					</tr>
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="modifyCurrentNodeSaveConfigInfo('2');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#modifyCurrentNodeDetailConfigInfoDialogDocument').window('close');">Cancel</a>
			</div>
		</div>
	</div>