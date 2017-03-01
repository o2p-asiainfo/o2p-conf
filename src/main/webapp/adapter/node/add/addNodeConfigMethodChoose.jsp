<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	  <div id="addSubNodeMethodChooseDialog" class="easyui-window" closed="true" title="Add sub node type" iconCls="icon-save" style="width:500px;height:200px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td>
							<span>Sub node generate type:</span>
						</td>
					</tr>
					<tr>
						<td class="item-content">
							<input type="radio" name="addSubNodeMethodType" value="1">Fix value
							<input type="radio" name="addSubNodeMethodType" value="2">Source XML
							<input type="radio" name="addSubNodeMethodType" value="3">Database
							<input type="radio" name="addSubNodeMethodType" value="4">Conditional
							<input type="radio" name="addSubNodeMethodType" value="5">Extend method
						</td>
					</tr>
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="addSubNodeMethodOK();">Open</a>
			<a class="easyui-linkbutton" onclick="$('#addSubNodeMethodChooseDialog').window('close');">Close</a>
			</div>
		</div>