<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="modifyCurrentNodeDetailConfigInfoDialogFix" class="easyui-window" closed="true" title="Modify node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="modifyCurrentNodeameFix">Node name:</span></td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeValueFix" value="" />
						</td>
					</tr>
					<tr>
						<td class="item" >Node type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeNodeTypeFix" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">Branch</option>
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Node generate type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeContent_TypeValueFix" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Fix value:</td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeFix_ValueFix" value=""
							   onblur="editAttr('fix_value',this.value,$('#modifyCurrentNodeNodeId').val(),$('#modifyCurrentNodeOperId').val(),'NODE_CONTENT_CONFIG');"/>
						</td>
					</tr>
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="modifyCurrentNodeSaveConfigInfo('1');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#modifyCurrentNodeDetailConfigInfoDialogFix').window('close');">Cancel</a>
			</div>
		</div>
	</div>