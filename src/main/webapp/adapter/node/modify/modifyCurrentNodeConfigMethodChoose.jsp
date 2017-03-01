<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	  <div id="modifyCurrentNodeMethodChooseDialog" class="easyui-window" closed="true" title="Modify node" iconCls="icon-save" style="width:500px;height:200px;padding:5px;background: #fafafa;">
		<div class="easyui-layout" fit="true">
			<div region="center" border="false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<table class="mgr-table" >
					<tr>
						<td>
							<span><s:text name='adapterTagModifyNodeType'/>:</span>
						</td>
					</tr>
					<tr>
						<td class="item-content">
							<input type="radio" name="modifyCurrentNodeMethodType" value="1"><s:text name='adapterNodeTypeFix'/>
							<input type="radio" name="modifyCurrentNodeMethodType" value="2"><s:text name='adapterNodeTypeSrc'/>
							<input type="radio" name="modifyCurrentNodeMethodType" value="3"><s:text name='adapterNodeTypeDB'/>
							<input type="radio" name="modifyCurrentNodeMethodType" value="4"><s:text name='adapterNodeTypeCond'/>
							<input type="radio" name="modifyCurrentNodeMethodType" value="5"><s:text name='adapterNodeTypeExt'/>
						</td>
					</tr>
				</table>			
			</div>
			<div region="south" border="false" style="text-align:right;height:30px;line-height:30px;">
				<a class="easyui-linkbutton" onclick="modifyCurrentNodeMethodOK();"><s:text name='adapterVbtnOpen'/></a>
			<a class="easyui-linkbutton" onclick="$('#modifyCurrentNodeMethodChooseDialog').window('close');"><s:text name='adapterVbtnClose'/>Close</a>
			</div>
		</div>