	/**
	 * 显示修改节点的操作列表
	 * @param id
	 * @return
	 */	
	function showNodeOperateListModifyCurrent(id){
		var path=id;
		var pathOther = getPathOtherType(path);
		var modifyNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[@xml_path='"
				+path+"' or @xml_path='"+pathOther+"']");
		//alert("modify :"+"/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[@xml_path='"+path+"']");
		if(modifyNodes!=null){
			if(typeof(modifyNodes)== 'undefined')
				return;
			for (var j=0;j<modifyNodes.length;j++){
				var modifyNode = modifyNodes[j];
				modifyNodeDetial(modifyNode);
			}
		}
	}
	
	/**
	 * 修改当前节点配置详细的信息显示
	 * @param node
	 * @return
	 */	
	function modifyNodeDetial(node){
		var operate_Type = node.attributes.getNamedItem("operate_type").text;
		var node_Name = node.attributes.getNamedItem("node_name").text;
		var node_Id = node.attributes.getNamedItem("node_id").text;
		//alert("operate_Type="+operate_Type);
		if(operate_Type=='2'){
			var nodeContentNodes = node.selectNodes("./NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG");
			if(nodeContentNodes!=null){
				for(var k=0;k<nodeContentNodes.length;k++){
					var nodeContentNode = nodeContentNodes[k];
					//alert(nodeContentNode.xml);
					var node_Oper_Id = nodeContentNode.attributes.getNamedItem("node_oper_id").text;
					var content_Type = nodeContentNode.attributes.getNamedItem("content_type").text;
					var table = document.getElementById("nodeOperateList");
					var value = "";
					newrow=table.insertRow();
					newrow.height=20;
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>Modify node</span>";	
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>"+node_Name+"</span>";						
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'>"+value+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:40%";
					//newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(2,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					//newcell=newrow.insertCell();
					//newcell.style.cssText="width:10%";
					//newcell.innerHTML="<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(2,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					///newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(2,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>"
						//+"<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(2,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					newcell.innerHTML="<a class='button-base button-small' title='Edit config' target='_blank' onclick='detailConfigInfoModify(2,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'><span class='button-text'>Edit config</span></a>"
						+"<a class='button-base button-small' title='Delete config' target='_blank' onclick='detailConfigInfoDelete(2,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'><span class='button-text'>Delete config</span></a>"					
				}				
			}
		}		
	}
	
	/**
	 * 打开修改当节点生成方式
	 * @return
	 */
	function openModifyCurrentNodeConifgMethod(){
		$('#modifyCurrentNodeMethodChooseDialog').dialog('open');
	}	
	
	/**
	 * 修改当前节点生成方式的选择
	 * @return
	 */
	function  modifyCurrentNodeMethodOK(){
		var methodType = $("input[name='modifyCurrentNodeMethodType']:checked").val(); 
		modifyCurrentNodeOpenConfigInfo(methodType);
		$('#modifyCurrentNodeMethodChooseDialog').dialog('close');		
	}
	
	/**
	 * 修改当前节点信息打开
	 * @return
	 */
	function modifyCurrentNodeOpenConfigInfo(methodType){
		if(methodType=='1'){
			detailConfigInfo_ModifyCurrentNodeFix();
		}else if(methodType=='2'){
			detailConfigInfo_ModifyCurrentNodeDocument();
		}else if(methodType=='3'){
			detailConfigInfo_ModifyCurrentNodeDataBase();
		}else if(methodType=='5'){
			detailConfigInfo_ModifyCurrentNodeExtend();
		}
	}
	
	/**
	 * 修改当前节点方式之固定值
	 */	
	function detailConfigInfo_ModifyCurrentNodeFix(){
		$('#modifyCurrentNodeDetailConfigInfoDialogFix').dialog('open');
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueFix");
		var node_Name =document.getElementById("curSelectNodeText").innerHTML;
		$('#modifyCurrentNodeValueFix').val(node_Name);
		$('#modifyCurrentNodeContent_TypeValueFix').val("1");
		$("#modifyCurrentNodeNodeTypeFix").val("1");
		$('#modifyCurrentNodeValueFix').attr("disabled",true);
		$('#modifyCurrentNodeValueFix').attr("readonly",true);		
		$('#modifyCurrentNodeContent_TypeValueFix').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueFix').attr("readonly",true);
		$('#modifyCurrentNodeNodeTypeFix').attr("disabled",true);
		$('#modifyCurrentNodeNodeTypeFix').attr("readonly",true);		
	}
	
	/**
	 * 修改当前节点方式之源报文
	 */		
	function detailConfigInfo_ModifyCurrentNodeDocument(){
		$('#modifyCurrentNodeDetailConfigInfoDialogDocument').dialog('open');
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueDocument");
		var node_Name =document.getElementById("curSelectNodeText").innerHTML;
		$('#modifyCurrentNodeNameValueDocument').val(node_Name);		
		$('#modifyCurrentNodeContent_TypeValueDocument').val("2");
		$('#modifyCurrentNodeNameValueDocument').attr("disabled",true);
		$('#modifyCurrentNodeNameValueDocument').attr("readonly",true);		
		$('#modifyCurrentNodeContent_TypeValueDocument').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueDocument').attr("readonly",true);		
	}
	
	/**
	 * 修改当前节点方式之数据库
	 */		
	function detailConfigInfo_ModifyCurrentNodeDataBase(){
		$('#modifyCurrentNodeDetailConfigInfoDialogDataBase').dialog('open');
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueDataBase");
		var node_Name =document.getElementById("curSelectNodeText").innerHTML;
		$('#modifyCurrentNodeNameValueDataBase').val(node_Name);
		//alert("node_Name="+node_Name);
		$('#modifyCurrentNodeNameValueDataBase').attr("disabled",true);
		$('#modifyCurrentNodeNameValueDataBase').attr("readonly",true);			
		$('#modifyCurrentNodeContent_TypeValueDataBase').val("3");
		$('#modifyCurrentNodeContent_TypeValueDataBase').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueDataBase').attr("readonly",true);		
	}
	
	function detailConfigInfo_ModifyCurrentNodeExtend(){
		$('#modifyCurrentNodeDetailConfigInfoDialogExtend').dialog('open');
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueExtend");
		var node_Name =document.getElementById("curSelectNodeText").innerHTML;
		$('#modifyCurrentNodeNameValueExtend').val(node_Name);
		$('#modifyCurrentNodeNameValueExtend').attr("disabled",true);
		$('#modifyCurrentNodeNameValueExtend').attr("readonly",true);			
		$('#modifyCurrentNodeContent_TypeValueExtend').val("5");
		$('#modifyCurrentNodeContent_TypeValueExtend').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueExtend').attr("readonly",true);			
	}
	
	function modifyCurrentNodeConfigPathNoPathId(){
		var path_Id = getNewPathId();
		modifyCurrentNodeConfigPath(path_Id);		
	}
	
	function modifyCurrentNodeConfigPath(path_Id){
		var table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
		newrow=table.insertRow(); 
		newrow.id = "modifyCurrentNodeNodeConfigPathTableRow_"+path_Id;
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:100%";
		newcell.innerHTML = newcell.innerHTML="<table id=\"modifyCurrentNodeXpathTable_"+path_Id+"\" border=\"1\" width=\"100%\">"+generateModifyCurrentNodeXPathConfigTable(path_Id)+"</table>";
		var modifyCurrentNode_Join_TypeId="modifyCurrentNode_Join_Type_"+path_Id;
		document.getElementById(modifyCurrentNode_Join_TypeId).readOnly=true;
		document.getElementById(modifyCurrentNode_Join_TypeId).disabled=true;
		var modifyCurrentNode_Sort_OrderId="modifyCurrentNode_Sort_Order_"+path_Id;
		document.getElementById(modifyCurrentNode_Sort_OrderId).readOnly=true;
		document.getElementById(modifyCurrentNode_Sort_OrderId).disabled=true;	
		var modifyCurrentNode_Pre_Sep_CharsId="modifyCurrentNode_Pre_Sep_Chars_"+path_Id;
		document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).readOnly=true;
		document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).disabled=true;	
		var modifyCurrentNode_Suf_Sep_CharsId="modifyCurrentNode_Suf_Sep_Chars_"+path_Id;
		document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).readOnly=true;
		document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).disabled=true;
		selectOptionAdd(modifyCurrentNode_Join_TypeId, "字符型", "2");
		document.getElementById(modifyCurrentNode_Join_TypeId).Value="2";	
	}
	
	
	/**
	 * 修改具体配置之修改节点信息
	 * @param node_Id
	 * @param node_Oper_Id
	 * @return
	 */	
	function detailConfigInfoModify_ModifyCurrentNode(content_type,node_Id,node_Oper_Id){
		if(content_type=='1'){
			//修改具体配置之修改当前节点来源于固定方式
			detailConfigInfoModify_ModifyCurrentNodeFix(node_Id,node_Oper_Id);
		}else if (content_type=='2'){
			//修改具体配置之修改当前节点来源于源报文方式
			detailConfigInfoModify_ModifyCurrentNodeDocument(node_Id,node_Oper_Id);
		}else if (content_type=='3'){
			//修改具体配置之修改当前节点来源于数据库方式
			detailConfigInfoModify_ModifyCurrentNodeDataBase(node_Id,node_Oper_Id);
		}else if(content_type=='5'){
			//修改具体配置之修改当前节点来源于扩展方式
			detailConfigInfoModify_ModifyCurrentNodeExtend(node_Id,node_Oper_Id);
		}
	}
	
	function detailConfigInfoModify_ModifyCurrentNodeFix(node_Id,node_Oper_Id){
		$('#modifyCurrentNodeDetailConfigInfoDialogFix').dialog('open');
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
		var node_Name = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_name");
		var node_Type = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_type");
		var content_Type = getValueFromNodeConfigXml(nodeContentConfigNode,"content_type");
		var fix_Value = getValueFromNodeConfigXml(nodeContentConfigNode,"fix_value");
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueFix");
		$("#modifyCurrentNodeValueFix").val(node_Name);
		$("#modifyCurrentNodeNodeTypeFix").val(node_Type);
		$("#modifyCurrentNodeContent_TypeValueFix").val(content_Type);
		$("#modifyCurrentNodeFix_ValueFix").val(fix_Value);
		$("#modifyCurrentNodeNodeId").val(node_Id);
		$("#modifyCurrentNodeOperId").val(node_Oper_Id);
		$('#modifyCurrentNodeContent_TypeValueFix').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueFix').attr("readonly",true);
		$('#modifyCurrentNodeNodeTypeFix').attr("disabled",true);
		$('#modifyCurrentNodeNodeTypeFix').attr("readonly",true);
		$('#modifyCurrentNodeValueFix').attr("disabled",true);
		$('#modifyCurrentNodeValueFix').attr("readonly",true);			
	}
	
	function detailConfigInfoModify_ModifyCurrentNodeDocument(node_Id,node_Oper_Id){
		$('#modifyCurrentNodeDetailConfigInfoDialogDocument').dialog('open');
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		var nodePathConfigCollectionNode = nodeContentConfigNode.selectSingleNode("./NODE_PATH_CONFIG_COLLECTION");
		var nodePathConfigNodes = nodePathConfigCollectionNode.childNodes;
		var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
		var node_Name = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_name");
		var node_Type = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_type");
		var content_Type = getValueFromNodeConfigXml(nodeContentConfigNode,"content_type");
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueDocument");
		$("#modifyCurrentNodeNameValueDocument").val(node_Name);
		$("#modifyCurrentNodeNodeTypeDocument").val(node_Type);
		$("#modifyCurrentNodeContent_TypeValueDocument").val(content_Type);
		$("#modifyCurrentNodeNodeId").val(node_Id);
		$("#modifyCurrentNodeOperId").val(node_Oper_Id);
		$('#modifyCurrentNodeContent_TypeValueDocument').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueDocument').attr("readonly",true);
		
		//设置源路径信息显示
		if(nodePathConfigNodes!=null){
			var table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
			for(var i=table.rows.length-1;i>=0;i--)
				table.deleteRow(i);			
			if(node_Type=='0'){
				for(var i=0;i<nodePathConfigNodes.length;i++){
					var nodePathConfigNode = nodePathConfigNodes[i];
					var path_Id = getValueFromNodeConfigXml(nodePathConfigNode,"path_id");
					var suf_Sep_Chars = getValueFromNodeConfigXml(nodePathConfigNode,"suf_sep_chars");
					var xml_From = getValueFromNodeConfigXml(nodePathConfigNode,"xml_from");
					var xml_Path = getValueFromNodeConfigXml(nodePathConfigNode,"xml_path");
					var pre_Sep_Chars = getValueFromNodeConfigXml(nodePathConfigNode,"pre_sep_chars");
					var joint_Type = getValueFromNodeConfigXml(nodePathConfigNode,"joint_type");
					var sort_Order = getValueFromNodeConfigXml(nodePathConfigNode,"sort_order");
					var modifyCurrentNode_Join_TypeId="modifyCurrentNode_Join_Type_"+path_Id;
					var modifyCurrentNode_Sort_OrderId="modifyCurrentNode_Sort_Order_"+path_Id;
					var modifyCurrentNode_Pre_Sep_CharsId="modifyCurrentNode_Pre_Sep_Chars_"+path_Id;
					var modifyCurrentNode_Suf_Sep_CharsId="modifyCurrentNode_Suf_Sep_Chars_"+path_Id;
					modifyCurrentNodeConfigPath(path_Id);
					document.getElementById(modifyCurrentNode_Join_TypeId).value=joint_Type;
					document.getElementById(modifyCurrentNode_Sort_OrderId).value=sort_Order;
					document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).value=pre_Sep_Chars;
					document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).value=suf_Sep_Chars;
				}
			}else if(node_Type=='1'){
				for(var i=0;i<nodePathConfigNodes.length;i++){
					var nodePathConfigNode = nodePathConfigNodes[i];
					var path_Id = getValueFromNodeConfigXml(nodePathConfigNode,"path_id");
					var suf_Sep_Chars = getValueFromNodeConfigXml(nodePathConfigNode,"suf_sep_chars");
					var xml_From = getValueFromNodeConfigXml(nodePathConfigNode,"xml_from");
					var xml_Path = getValueFromNodeConfigXml(nodePathConfigNode,"xml_path");
					var pre_Sep_Chars = getValueFromNodeConfigXml(nodePathConfigNode,"pre_sep_chars");
					var joint_Type = getValueFromNodeConfigXml(nodePathConfigNode,"joint_type");
					var sort_Order = getValueFromNodeConfigXml(nodePathConfigNode,"sort_order");
					var modifyCurrentNode_Xml_PathId="modifyCurrentNode_Xml_Path_"+path_Id;
					var modifyCurrentNode_Join_TypeId="modifyCurrentNode_Join_Type_"+path_Id;
					var modifyCurrentNode_Sort_OrderId="modifyCurrentNode_Sort_Order_"+path_Id;
					var modifyCurrentNode_Pre_Sep_CharsId="modifyCurrentNode_Pre_Sep_Chars_"+path_Id;
					var modifyCurrentNode_Suf_Sep_CharsId="modifyCurrentNode_Suf_Sep_Chars_"+path_Id;
					modifyCurrentNodeConfigPath(path_Id); 
					document.getElementById(modifyCurrentNode_Xml_PathId).value=xml_Path;
					document.getElementById(modifyCurrentNode_Join_TypeId).value=joint_Type;
					document.getElementById(modifyCurrentNode_Sort_OrderId).value=sort_Order;
					document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).value=pre_Sep_Chars;
					document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).value=suf_Sep_Chars;
				}				
			}
		}
	}
	
	function detailConfigInfoModify_ModifyCurrentNodeDataBase(node_Id,node_Oper_Id){
		$('#modifyCurrentNodeDetailConfigInfoDialogDataBase').dialog('open');
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
		var node_Name = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_name");
		var node_Type = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_type");
		var content_Type = getValueFromNodeConfigXml(nodeContentConfigNode,"content_type");
		var data_Set_Id = getValueFromNodeConfigXml(nodeContentConfigNode,"data_set_id");
		var col_Name = getValueFromNodeConfigXml(nodeContentConfigNode,"col_name");
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueDataBase");
		$("#modifyCurrentNodeNameValueDataBase").val(node_Name);
		$("#modifyCurrentNodeNodeTypeDataBase").val(node_Type);
		$("#modifyCurrentNodeContent_TypeValueDataBase").val(content_Type);
		$("#modifyCurrentNodeDataSetIdDataBase").val(data_Set_Id);
		$("#modifyCurrentNodeCol_NameDataBase").val(col_Name);
		$("#modifyCurrentNodeNodeId").val(node_Id);
		$("#modifyCurrentNodeOperId").val(node_Oper_Id);
		$('#modifyCurrentNodeContent_TypeValueDataBase').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueDataBase').attr("readonly",true);
		$('#modifyCurrentNodeNodeTypeDataBase').attr("disabled",true);
		$('#modifyCurrentNodeNodeTypeDataBase').attr("readonly",true);
		$('#modifyCurrentNodeNameValueDataBase').attr("disabled",true);
		$('#modifyCurrentNodeNameValueDataBase').attr("readonly",true);			
	}
	
	function detailConfigInfoModify_ModifyCurrentNodeExtend(node_Id,node_Oper_Id){
		$('#modifyCurrentNodeDetailConfigInfoDialogExtend').dialog('open');
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
		var node_Name = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_name");
		var node_Type = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_type");
		var content_Type = getValueFromNodeConfigXml(nodeContentConfigNode,"content_type");
		var method_Id = getValueFromNodeConfigXml(nodeContentConfigNode,"method_id");
		var col_Name = getValueFromNodeConfigXml(nodeContentConfigNode,"col_name");
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueExtend");
		$("#modifyCurrentNodeNameValueExtend").val(node_Name);
		$("#modifyCurrentNodeNodeTypeExtend").val(node_Type);
		$("#modifyCurrentNodeContent_TypeValueExtend").val(content_Type);
		$("#modifyCurrentNodeMethodIdExtend").val(method_Id);
		$("#modifyCurrentNodeNodeId").val(node_Id);
		$("#modifyCurrentNodeOperId").val(node_Oper_Id);
		$('#modifyCurrentNodeContent_TypeValueExtend').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueExtend').attr("readonly",true);
		$('#modifyCurrentNodeNodeTypeExtend').attr("disabled",true);
		$('#modifyCurrentNodeNodeTypeExtend').attr("readonly",true);
		$('#modifyCurrentNodeNameValueExtend').attr("disabled",true);
		$('#modifyCurrentNodeNameValueExtend').attr("readonly",true);	
		//根据扩展方式ID从后台获取代码片段数据
		var segmentRealize = getSegmentRealize(method_Id);
		$('#modifyCurrentNodeSegmentRealizeExtend').val(segmentRealize); 
	}
	
	/**
	 * 删除具体配置之修改节点信息
	 * @param node_Id
	 * @param node_Oper_Id
	 * @return
	 */		
	function detailConfigInfoDelete_ModifyCurrentNode(content_type,node_Id,node_Oper_Id){
		if(content_type=='1'){
			//删除具体配置之添加子节点来源于固定方式
			detailConfigInfoDelete_ModifyCurrentNodeFix(node_Id,node_Oper_Id);
		}else if(content_type=='2'){	
			//删除具体配置之添加子节点来源于源报文
			detailConfigInfoDelete_ModifyCurrentNodeDocument(node_Id,node_Oper_Id);
		}else if(content_type=='3'){	
			//删除具体配置之添加子节点来源于数据库
			detailConfigInfoDelete_ModifyCurrentNodeDataBase(node_Id,node_Oper_Id);
		}else if(content_type=='5'){
			//删除具体配置之添加子节点来源于数据库
			detailConfigInfoDelete_ModifyCurrentNodeExtend(node_Id,node_Oper_Id);			
		}
		var currentNodeId = $('#currentNodeId').val();
		var adapterId = $('#adapterId').val();
		targetDoucumentNodeOnClick(currentNodeId,adapterId);		
	}
	
	function detailConfigInfoDelete_ModifyCurrentNodeFix(node_Id,node_Oper_Id){
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		if(nodeContentConfigNode!=null){
			var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
			adapterNodeConfigNode.parentNode.removeChild(adapterNodeConfigNode);
			saveProcotolAdapter();
			loadProtocolAdapterConfigInfo($('#adapterId').val());
			initTargetDoucumentStructure($('#adapterId').val());
			refreshTargetDoucumentStructure($('#adapterId').val());
			targetDocumentStructure.openItem(document.getElementById("curSelectNodePath").innerHTML);			
		}		
	}
	
	function detailConfigInfoDelete_ModifyCurrentNodeDocument(node_Id,node_Oper_Id){
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		if(nodeContentConfigNode!=null){
			var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
			adapterNodeConfigNode.parentNode.removeChild(adapterNodeConfigNode);
			saveProcotolAdapter();
			loadProtocolAdapterConfigInfo($('#adapterId').val());
			initTargetDoucumentStructure($('#adapterId').val());
			refreshTargetDoucumentStructure($('#adapterId').val());
			targetDocumentStructure.openItem(document.getElementById("curSelectNodePath").innerHTML);			
		}		
	}
	
	function detailConfigInfoDelete_ModifyCurrentNodeDataBase(node_Id,node_Oper_Id){
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		if(nodeContentConfigNode!=null){
			var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
			adapterNodeConfigNode.parentNode.removeChild(adapterNodeConfigNode);
			saveProcotolAdapter();
			loadProtocolAdapterConfigInfo($('#adapterId').val());
			initTargetDoucumentStructure($('#adapterId').val());
			refreshTargetDoucumentStructure($('#adapterId').val());
			targetDocumentStructure.openItem(document.getElementById("curSelectNodePath").innerHTML);			
		}		
	}
	
	function detailConfigInfoDelete_ModifyCurrentNodeExtend(node_Id,node_Oper_Id){
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		if(nodeContentConfigNode!=null){
			var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
			adapterNodeConfigNode.parentNode.removeChild(adapterNodeConfigNode);
			saveProcotolAdapter();
			loadProtocolAdapterConfigInfo($('#adapterId').val());
			initTargetDoucumentStructure($('#adapterId').val());
			refreshTargetDoucumentStructure($('#adapterId').val());
			targetDocumentStructure.openItem(document.getElementById("curSelectNodePath").innerHTML);			
		}		
	}
	
	/**
	 * 保存修改当前的节点信息
	 * @param type 值生成方式类型 1.固定值 2.源报文 3.数据库
	 * @return
	 */
	function modifyCurrentNodeSaveConfigInfo(type){
		if(type=='1'){
			if($('#currentClickOperate').val()=='modifyCurrentNode'){
				modifyCurrentNodeSaveConfigInfoFix();
			}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}
			$('#modifyCurrentNodeDetailConfigInfoDialogFix').dialog('close');
		}else if(type=='2'){
			if($('#currentClickOperate').val()=='modifyCurrentNode'){
				//addSubNodeSaveConfigInfoDocument();
				modifyCurrentNodeSaveConfigInfoDocument();
			}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
				//saveProcotolAdapter();
				modifyCurrentNodeSaveConfigInfoModify_Document();
			}
			$('#modifyCurrentNodeDetailConfigInfoDialogDocument').dialog('close');
		}else if(type=='3'){
			if($('#currentClickOperate').val()=='modifyCurrentNode'){
				//addSubNodeSaveConfigInfoDataBase();
				modifyCurrentNodeSaveConfigInfoDataBase();
			}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}
			$('#modifyCurrentNodeDetailConfigInfoDialogDataBase').dialog('close');
		}else if(type=='5'){
			if($('#currentClickOperate').val()=='modifyCurrentNode'){
				modifyCurrentNodeSaveConfigInfoExtend();
			}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}			
		}
		var currentNodeId = $('#currentNodeId').val();
		var adapterId = $('#adapterId').val();
		targetDoucumentNodeOnClick(currentNodeId,adapterId);		
	}	
	
	function modifyCurrentNodeSaveConfigInfoFix(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点
		//先判断选中的节点是否在表中有配置了
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML;//"/"+document.getElementById("modifyCurrentNodeValueFix").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="2";
		var node_Type = $("#modifyCurrentNodeNodeTypeFix").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#modifyCurrentNodeValueFix").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#modifyCurrentNodeContent_TypeValueFix").val();
		var fix_Value = $("#modifyCurrentNodeFix_ValueFix").val();
		var nodeContentConfigNode;
		nodeContentConfigNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG");
		nodeContentConfigNode.setAttribute("state","A");
		nodeContentConfigNode.setAttribute("node_oper_id",node_Oper_Id);
		nodeContentConfigNode.setAttribute("par_node_oper_id","");
		nodeContentConfigNode.setAttribute("relation_produce_type","");
		nodeContentConfigNode.setAttribute("isincdata","");
		nodeContentConfigNode.setAttribute("sort_order","");
		nodeContentConfigNode.setAttribute("conditional_relation","");
		nodeContentConfigNode.setAttribute("restriction_ids","");
		nodeContentConfigNode.setAttribute("cont_converter_para","");
		nodeContentConfigNode.setAttribute("relation_condition","");
		nodeContentConfigNode.setAttribute("src_map_type","");
		nodeContentConfigNode.setAttribute("method_id","");
		nodeContentConfigNode.setAttribute("fix_value",fix_Value);
		nodeContentConfigNode.setAttribute("par_data_set_id","");
		nodeContentConfigNode.setAttribute("col_name","");
		nodeContentConfigNode.setAttribute("data_set_id","");
		nodeContentConfigNode.setAttribute("cont_converter_id","");
		nodeContentConfigNode.setAttribute("auto_add_flag","");
		nodeContentConfigNode.setAttribute("node_id",node_Id);
		nodeContentConfigNode.setAttribute("delete_type","");
		nodeContentConfigNode.setAttribute("content_type",$('#modifyCurrentNodeContent_TypeValueFix').val());
		
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		//recordJS(xmlAdapterConfigDoc.xml);
		saveProcotolAdapter();		
	}
	
	function modifyCurrentNodeSaveConfigInfoDocument(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点,再增加
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML;//+"/"+document.getElementById("addSubNodeNameValueDocument").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="2";
		var node_Type = $("#modifyCurrentNodeNodeTypeDocument").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#modifyCurrentNodeNameValueDocument").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#modifyCurrentNodeContent_TypeValueDocument").val();
		var nodeContentConfigNode;
		nodeContentConfigNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG");
		nodeContentConfigNode.setAttribute("state","A");
		nodeContentConfigNode.setAttribute("node_oper_id",node_Oper_Id);
		nodeContentConfigNode.setAttribute("par_node_oper_id","");
		nodeContentConfigNode.setAttribute("relation_produce_type","");
		nodeContentConfigNode.setAttribute("isincdata","");
		nodeContentConfigNode.setAttribute("sort_order","");
		nodeContentConfigNode.setAttribute("conditional_relation","");
		nodeContentConfigNode.setAttribute("restriction_ids","");
		nodeContentConfigNode.setAttribute("cont_converter_para","");
		nodeContentConfigNode.setAttribute("relation_condition","");
		nodeContentConfigNode.setAttribute("src_map_type","");
		nodeContentConfigNode.setAttribute("method_id","");
		nodeContentConfigNode.setAttribute("fix_value","");
		nodeContentConfigNode.setAttribute("par_data_set_id","");
		nodeContentConfigNode.setAttribute("col_name","");
		nodeContentConfigNode.setAttribute("data_set_id","");
		nodeContentConfigNode.setAttribute("cont_converter_id","");
		nodeContentConfigNode.setAttribute("auto_add_flag","");
		nodeContentConfigNode.setAttribute("node_id",node_Id);
		nodeContentConfigNode.setAttribute("delete_type","");
		nodeContentConfigNode.setAttribute("content_type",$('#modifyCurrentNodeContent_TypeValueDocument').val());
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		//获取页面上的源报文路径
		var table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
		for(var i=0;i<table.rows.length;i++){
			var row = table.rows[i];
			var rowId = row.id;
			var path_IdStartIndex = rowId.indexOf("modifyCurrentNodeNodeConfigPathTableRow_");
			var path_Id =rowId.substring(path_IdStartIndex+"modifyCurrentNodeNodeConfigPathTableRow_".length,rowId.length);
			var each_Xml_path = document.getElementById("modifyCurrentNode_Xml_Path_"+path_Id).value;
			var each_Joint_Type = document.getElementById("modifyCurrentNode_Join_Type_"+path_Id).value;
			var each_Sort_Order = document.getElementById("modifyCurrentNode_Sort_Order_"+path_Id).value;
			var each_Pre_Sep_Chars = document.getElementById("modifyCurrentNode_Pre_Sep_Chars_"+path_Id).value;
			var each_Suf_Sep_Chars = document.getElementById("modifyCurrentNode_Suf_Sep_Chars_"+path_Id).value;
			var nodePathConfigNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG");
			nodePathConfigNode.setAttribute("state","A");
			nodePathConfigNode.setAttribute("path_id",path_Id);
			nodePathConfigNode.setAttribute("confirm_path","");
			nodePathConfigNode.setAttribute("suf_sep_chars",each_Suf_Sep_Chars);
			nodePathConfigNode.setAttribute("multi_joint","");
			nodePathConfigNode.setAttribute("xml_from","1");
			nodePathConfigNode.setAttribute("node_oper_id",node_Oper_Id);
			nodePathConfigNode.setAttribute("xml_path",each_Xml_path);
			nodePathConfigNode.setAttribute("pre_sep_chars",each_Pre_Sep_Chars);
			nodePathConfigNode.setAttribute("joint_type",each_Joint_Type);
			nodePathConfigNode.setAttribute("par_path_level","");
			nodePathConfigNode.setAttribute("sort_order",each_Sort_Order);
			nodePathConfigCollectionNode.appendChild(nodePathConfigNode);
		}
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		//recordJS(xmlAdapterConfigDoc.xml);
		saveProcotolAdapter();
	}
	
	function modifyCurrentNodeSaveConfigInfoModify_Document(){
		//先找到NODE_PATH_CONFIG_COLLECTION路径节点,移除旧节点
		var node_Id=$("#modifyCurrentNodeNodeId").val();
		var node_Oper_Id=$("#modifyCurrentNodeOperId").val();
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		var deleteNodePathConfigCollectionNode = nodeContentConfigNode.selectSingleNode("./NODE_PATH_CONFIG_COLLECTION");
		nodeContentConfigNode.removeChild(deleteNodePathConfigCollectionNode);
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		//获取页面上的源报文路径
		var table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
		for(var i=0;i<table.rows.length;i++){
			var row = table.rows[i];
			var rowId = row.id;
			var path_IdStartIndex = rowId.indexOf("modifyCurrentNodeNodeConfigPathTableRow_");
			var path_Id =rowId.substring(path_IdStartIndex+"modifyCurrentNodeNodeConfigPathTableRow_".length,rowId.length);
			var each_Xml_path = document.getElementById("modifyCurrentNode_Xml_Path_"+path_Id).value;
			var each_Joint_Type = document.getElementById("modifyCurrentNode_Join_Type_"+path_Id).value;
			var each_Sort_Order = document.getElementById("modifyCurrentNode_Sort_Order_"+path_Id).value;
			var each_Pre_Sep_Chars = document.getElementById("modifyCurrentNode_Pre_Sep_Chars_"+path_Id).value;
			var each_Suf_Sep_Chars = document.getElementById("modifyCurrentNode_Suf_Sep_Chars_"+path_Id).value;
			var nodePathConfigNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG");
			nodePathConfigNode.setAttribute("state","A");
			nodePathConfigNode.setAttribute("path_id",path_Id);
			nodePathConfigNode.setAttribute("confirm_path","");
			nodePathConfigNode.setAttribute("suf_sep_chars",each_Suf_Sep_Chars);
			nodePathConfigNode.setAttribute("multi_joint","");
			nodePathConfigNode.setAttribute("xml_from","1");
			nodePathConfigNode.setAttribute("node_oper_id",node_Oper_Id);
			nodePathConfigNode.setAttribute("xml_path",each_Xml_path);
			nodePathConfigNode.setAttribute("pre_sep_chars",each_Pre_Sep_Chars);
			nodePathConfigNode.setAttribute("joint_type",each_Joint_Type);
			nodePathConfigNode.setAttribute("par_path_level","");
			nodePathConfigNode.setAttribute("sort_order",each_Sort_Order);
			nodePathConfigCollectionNode.appendChild(nodePathConfigNode);
		}
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		saveProcotolAdapter();
	}
	
	function modifyCurrentNodeSaveConfigInfoDataBase(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点,再增加
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML;//+"/"+document.getElementById("modifyCurrentNodeNameValueDataBase").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="2";
		var node_Type = $("#modifyCurrentNodeNodeTypeDataBase").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#modifyCurrentNodeNameValueDataBase").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#modifyCurrentNodeContent_TypeValueDataBase").val();
		var nodeContentConfigNode;
		nodeContentConfigNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG");
		nodeContentConfigNode.setAttribute("state","A");
		nodeContentConfigNode.setAttribute("node_oper_id",node_Oper_Id);
		nodeContentConfigNode.setAttribute("par_node_oper_id","");
		nodeContentConfigNode.setAttribute("relation_produce_type","");
		nodeContentConfigNode.setAttribute("isincdata","");
		nodeContentConfigNode.setAttribute("sort_order","");
		nodeContentConfigNode.setAttribute("conditional_relation","");
		nodeContentConfigNode.setAttribute("restriction_ids","");
		nodeContentConfigNode.setAttribute("cont_converter_para","");
		nodeContentConfigNode.setAttribute("relation_condition","");
		nodeContentConfigNode.setAttribute("src_map_type","");
		nodeContentConfigNode.setAttribute("method_id","");
		nodeContentConfigNode.setAttribute("fix_value","");
		nodeContentConfigNode.setAttribute("par_data_set_id","");
		nodeContentConfigNode.setAttribute("col_name",$('#modifyCurrentNodeCol_NameDataBase').val());
		nodeContentConfigNode.setAttribute("data_set_id",$('#modifyCurrentNodeDataSetIdDataBase').val());
		nodeContentConfigNode.setAttribute("cont_converter_id","");
		nodeContentConfigNode.setAttribute("auto_add_flag","");
		nodeContentConfigNode.setAttribute("node_id",node_Id);
		nodeContentConfigNode.setAttribute("delete_type","");
		nodeContentConfigNode.setAttribute("content_type",$('#modifyCurrentNodeContent_TypeValueDataBase').val());
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		saveProcotolAdapter();		
	}
	
	function modifyCurrentNodeSaveConfigInfoExtend(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点,再增加
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML;//+"/"+document.getElementById("modifyCurrentNodeNameValueDataBase").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="2";
		var node_Type = $("#modifyCurrentNodeNodeTypeExtend").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#modifyCurrentNodeNameValueExtend").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#modifyCurrentNodeContent_TypeValueExtend").val();
		var nodeContentConfigNode;
		nodeContentConfigNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG");
		nodeContentConfigNode.setAttribute("state","A");
		nodeContentConfigNode.setAttribute("node_oper_id",node_Oper_Id);
		nodeContentConfigNode.setAttribute("par_node_oper_id","");
		nodeContentConfigNode.setAttribute("relation_produce_type","");
		nodeContentConfigNode.setAttribute("isincdata","");
		nodeContentConfigNode.setAttribute("sort_order","");
		nodeContentConfigNode.setAttribute("conditional_relation","");
		nodeContentConfigNode.setAttribute("restriction_ids","");
		nodeContentConfigNode.setAttribute("cont_converter_para","");
		nodeContentConfigNode.setAttribute("relation_condition","");
		nodeContentConfigNode.setAttribute("src_map_type","");
		nodeContentConfigNode.setAttribute("method_id",$('#modifyCurrentNodeMethodIdExtend').val());
		nodeContentConfigNode.setAttribute("fix_value","");
		nodeContentConfigNode.setAttribute("par_data_set_id","");
		nodeContentConfigNode.setAttribute("col_name","");
		nodeContentConfigNode.setAttribute("data_set_id","");
		nodeContentConfigNode.setAttribute("cont_converter_id","");
		nodeContentConfigNode.setAttribute("auto_add_flag","");
		nodeContentConfigNode.setAttribute("node_id",node_Id);
		nodeContentConfigNode.setAttribute("delete_type","");
		nodeContentConfigNode.setAttribute("content_type",$('#modifyCurrentNodeContent_TypeValueExtend').val());
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		saveProcotolAdapter();		
	}
	
	function generateModifyCurrentNodeXPathConfigTable(path_Id){
		var xpathTable=document.createElement("TABLE");
		newrow=xpathTable.insertRow();
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:20%";
		newcell.innerHTML="<span class=\"text_font_common\">路径：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:60%";
		newcell.colSpan = "2";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:100%;\"/>"
		newcell=newrow.insertCell();
		newcell.style.cssText="width:20%";
		var nodeType = document.getElementById("modifyCurrentNodeNodeTypeDocument").value;
		if(nodeType==null||nodeType =='0'){
			//newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				//+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"/>"
			//+"<span class='text_font_common'><input type='button' value=\"测试路径\"  "
			//+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/></span>";
			newcell.innerHTML ='';
		}else {
			//+"<span class='text_font_common'><input type='button' value=\"删除\"  onclick=\"deleteXpathConfig('modifyCurrentNodeNodeConfigPathTableRow_"+
			//+path_Id+"','2')\" style=\"width:15%;\"/></span>"
			//+"<span class='text_font_common'><input type='button' value=\"测试路径\"  "
			//+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/></span>";
			newcell.innerHTML="<a class='button-base button-small' title='Delete' target='_blank'  "
				+"onclick=\"deleteXpathConfig('modifyCurrentNodeNodeConfigPathTableRow_"+
				+path_Id+"','2')\" style=\"width:100%;\"/><span class='button-text'>Delete</span></a>";			
		}			
		//alert(newcell.innerHTML);
		newrow=xpathTable.insertRow(); 
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Join_Type_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">Joint type：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML="<select id=\"modifyCurrentNode_Join_Type_"+path_Id+"\" onblur=\"editAttr('join_type',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"></select>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Sort_Order_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">Joint order：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Sort_Order_"+path_Id+"' value='' onblur=\"editAttr('sort_order',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\" />";	
		newrow=xpathTable.insertRow();
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Pre_Sep_Chars_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">Prefix separator：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Pre_Sep_Chars_"+path_Id+"' value='' onblur=\"editAttr('pre_sep_chars',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\"/>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Suf_Sep_Chars_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">Suffix separator：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Suf_Sep_Chars_"+path_Id+"' value='' onblur=\"editAttr('suf_sep_chars',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\" />";	
		return xpathTable.innerHTML;		
	}
	
	
	function checkBoxModifyCurrentNodePathConfigClick(id,path_Id){
		var modifyCurrentNode_Join_TypeId="modifyCurrentNode_Join_Type_"+path_Id;
		var modifyCurrentNode_Sort_OrderId="modifyCurrentNode_Sort_Order_"+path_Id;
		var modifyCurrentNode_Pre_Sep_CharsId="modifyCurrentNode_Pre_Sep_Chars_"+path_Id;
		var modifyCurrentNode_Suf_Sep_CharsId="modifyCurrentNode_Suf_Sep_Chars_"+path_Id;
		var checkModifyCurrentNode_Join_TypeId="checkModifyCurrentNode_Join_Type_"+path_Id;
		var checkModifyCurrentNode_Sort_OrderId="checkModifyCurrentNode_Sort_Order_"+path_Id;
		var checkModifyCurrentNode_Pre_Sep_CharsId="checkModifyCurrentNode_Pre_Sep_Chars_"+path_Id;
		var checkModifyCurrentNode_Suf_Sep_CharsId="checkModifyCurrentNode_Suf_Sep_Chars_"+path_Id;		
		if(document.getElementById(id).checked==true){
			if(id==checkModifyCurrentNode_Join_TypeId){
				document.getElementById(modifyCurrentNode_Join_TypeId).readOnly=false;
				document.getElementById(modifyCurrentNode_Join_TypeId).disabled=false;				
			}else if(id==checkModifyCurrentNode_Sort_OrderId){
				document.getElementById(modifyCurrentNode_Sort_OrderId).readOnly=false;
				document.getElementById(modifyCurrentNode_Sort_OrderId).disabled=false;					
			}else if(id==checkModifyCurrentNode_Pre_Sep_CharsId){
				document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).readOnly=false;
				document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).disabled=false;				
			}else if(id==checkModifyCurrentNode_Suf_Sep_CharsId){
				document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).readOnly=false;
				document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).disabled=false;		
			}
		}else if(document.getElementById(id).checked==false){		
			if(id==checkModifyCurrentNode_Join_TypeId){
				document.getElementById(modifyCurrentNode_Join_TypeId).readOnly=true;
				document.getElementById(modifyCurrentNode_Join_TypeId).disabled=true;				
			}else if(id==checkModifyCurrentNode_Sort_OrderId){
				document.getElementById(modifyCurrentNode_Sort_OrderId).readOnly=true;
				document.getElementById(modifyCurrentNode_Sort_OrderId).disabled=true;					
			}else if(id==checkModifyCurrentNode_Pre_Sep_CharsId){
				document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).readOnly=true;
				document.getElementById(modifyCurrentNode_Pre_Sep_CharsId).disabled=true;				
			}else if(id==checkModifyCurrentNode_Suf_Sep_CharsId){
				document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).readOnly=true;
				document.getElementById(modifyCurrentNode_Suf_Sep_CharsId).disabled=true;				
			}			
		}	
	}
	
	function selectModifyCurrentNodeNodeTypeDocumentChange(object){
		var value = object.value; 
		var table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
		if(value=='0'){
			//树枝节点
			for(var i=table.rows.length-1;i>=0;i--)
				table.deleteRow(i);	
			document.getElementById("modifyCurrentNodeNodeConfigPathBtn").style.display='none';
			modifyCurrentNodeConfigPathNoPathId();
		}else if(value=='1'){
			//叶子节点
			document.getElementById("modifyCurrentNodeNodeConfigPathBtn").style.display='';
			for(var i=table.rows.length-1;i>=0;i--)
				table.deleteRow(i);			
		}
		editAttr("modifyCurrentNodeNodeTypeDocument",value,$("#modifyCurrentNodeNodeId").val(),$("#modifyCurrentNodeOperId").val());
	}
	
	function modifyCurrentNodeDataSetChoose(){
		 $("#dataSetManagerIframe").attr("src",document.getElementById("projectRootPath").value+"/adapter/toDataSetManager.shtml");
		 $('#dataSetManagerWin').window('open');
	}	
	
	function modifyCurrentNodeExtendChoose(){
		 $("#extendManagerIframe").attr("src",document.getElementById("projectRootPath").value+"/adapter/toExtendManager.shtml");
		 $('#extendManagerWin').window('open');		
	}	