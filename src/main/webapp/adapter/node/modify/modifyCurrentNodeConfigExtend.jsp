<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="modifyCurrentNodeDetailConfigInfoDialogExtend" class="easyui-window" closed="true" title="Modify node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="modifyCurrentNodeNameExtend">Node name:</span></td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeNameValueExtend" value=""/>
						</td>
					</tr>				
					<tr>
						<td class="item" >Node type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeNodeTypeExtend"" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">Branch</option>
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Node generate type:</td>
						<td class="item-content">
							<select id="modifyCurrentNodeContent_TypeValueExtend" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Extend method:</td>
						<td class="item-content">
							<input type="text" id="modifyCurrentNodeMethodIdExtend" value="" readonly="true"/>
							<%--
							<input type="button" id="modifyCurrentNodeMethodIdExtendBtn" value="选择扩展方式" 
								onclick="modifyCurrentNodeExtendChoose()" readonly="true"/>
							--%>
							<a class="button-base button-small" title="Choose" target="_blank" onclick="modifyCurrentNodeExtendChoose();">
								<span class="button-text" id="modifyCurrentNodeMethodIdExtendBtn">Choose</span> 
							</a>								
						</td>
					</tr>
					<tr>
						<td class="item">Code Segment:</td>
						<td class="item-content">
							<textarea id="modifyCurrentNodeSegmentRealizeExtend"  name="modifyCurrentNodeSegmentRealizeExtend" 
								style="width:100%;" rows="20" readonly="true"></textarea>
						</td>
					</tr>										
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="modifyCurrentNodeSaveConfigInfo('5');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#modifyCurrentNodeDetailConfigInfoDialogExtend').window('close');">Cancel</a>
			</div>
		</div>
	</div>