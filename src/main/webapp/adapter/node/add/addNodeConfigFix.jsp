<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<div id="addSubNodeDetailConfigInfoDialogFix" class="easyui-window" closed="true" title="Add sub node" iconCls="icon-save" style="width:800px;height:400px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td class="item"><span id="addSubNodeNameFix">Sub node name:</span></td>
						<td class="item-content">
							<input type="text" id="addSubNodeNameValueFix" value="" />
						</td>
					</tr>				
					<tr>
						<td class="item" >Sub node type:</td>
						<td class="item-content">
							<select id="addSubNodeNodeTypeFix" style="width:100%;" value="">
								<option value=""></option>
								<option value="0">Branch</option>
								<option value="1">Leaf</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Sub node generate type:</td>
						<td class="item-content">
							<select id="addSubNodeContent_TypeValueFix" style="width:100%;" value="">
							</select>
						</td>
					</tr>
					<tr>
						<td class="item">Fix value:</td>
						<td class="item-content">
							<input type="text" id="addSubNodeFix_ValueFix" value=""
							   onblur="editAttr('fix_value',this.value,$('#addNodeId').val(),$('#addNodeOperId').val(),'NODE_CONTENT_CONFIG');"/>
						</td>
					</tr>	
					<!-- 				
					<tr>
						<td class="item" >值转换策略:</td>
						<td class="item-content">
							<input type="text" id="addCont_Converter_Id" value=""/>
							<input type="button" value="选择" onClick="$('#getValueExprWin').window('open');"/>
						</td>
					</tr>
					 -->
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="addSubNodeSaveConfigInfo('1');">Save</a>
				<a class="easyui-linkbutton" onclick="$('#addSubNodeDetailConfigInfoDialogFix').window('close');">Cancel</a>
			</div>
		</div>
	</div>