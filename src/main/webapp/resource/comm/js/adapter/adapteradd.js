	/**
	 * 显示增加节点的操作列表
	 * @param id
	 * @return
	 */
	function showNodeOperateListAddSub(id){
		var path = id;
		var pathOther = getPathOtherType(path);
		//alert("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[contains(@xml_path,'"+path
				//+"') or contains(@xml_path,'"+pathOther+"')]"); 		
		var subItemNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[contains(@xml_path,'"+path
				+"') or contains(@xml_path,'"+pathOther+"')]");
		if(subItemNodes!=null){
			if(typeof(subItemNodes)== 'undefined')
				return;
			for (var j=0;j<subItemNodes.length;j++){
				var subItemNode = subItemNodes[j];
				//判断当前节点的xml_path的树的父节点路径是否跟path一样
				var xml_path = subItemNode.attributes.getNamedItem("xml_path").text;
				//alert("subItemNode xml:"+subItemNode.xml); 
				var subNodeFlag = judgeSubNodeOrNot(xml_path,path);
				if(subNodeFlag=="true"){
					addSubNodeDetial(subItemNode);
				}
			}
		}		
	}
	
	/**
	 * 添加子节点配置详细的信息显示
	 * @param node
	 * @return
	 */
	function addSubNodeDetial(node){
		var operate_Type = node.attributes.getNamedItem("operate_type").text;
		var node_Name = node.attributes.getNamedItem("node_name").text;
		var node_Id = node.attributes.getNamedItem("node_id").text;
		//alert("operate_Type="+operate_Type);
		if(operate_Type=='1'){
			var nodeContentNodes = node.selectNodes("./NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG");
			if(nodeContentNodes!=null){
				for(var k=0;k<nodeContentNodes.length;k++){
					var nodeContentNode = nodeContentNodes[k];
					var content_Type = nodeContentNode.attributes.getNamedItem("content_type").text;
					var node_Oper_Id = nodeContentNode.attributes.getNamedItem("node_oper_id").text;
					var table = document.getElementById("nodeOperateList");
					var value = "";
					newrow=table.insertRow();
					newrow.height=20;
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>Add sub node</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>"+node_Name+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'>"+value+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:40%";
					//newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(1,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					//newcell=newrow.insertCell();
					//newcell.style.cssText="width:10%";
					//newcell.innerHTML="<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(1,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					//newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(1,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>"
						//+"<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(1,"
						//+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					newcell.innerHTML="<a class='button-base button-small' title='Edit config' target='_blank' onclick='detailConfigInfoModify(1,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'><span class='button-text'>Edit config</span></a>"
						+"<a class='button-base button-small' title='Delete config' target='_blank' onclick='detailConfigInfoDelete(1,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'><span class='button-text'>Delete config</span></a>"
				}				
			}
		}
	}	
	
	/**
	 * 打开添加子节点生成方式
	 * @return
	 */
	function openAddSubNodeConifgMethod(){
		$('#addSubNodeMethodChooseDialog').dialog('open');
	}
	
	/**
	 * 新增子节点生成方式选择
	 * @return
	 */
	function addSubNodeMethodOK(){
		var methodType = $("input[name='addSubNodeMethodType']:checked").val(); 
		addSubNodeOpenConfigInfo(methodType);
		$('#addSubNodeMethodChooseDialog').dialog('close');
	}
	
	/**
	 * 添加子节点信息打开
	 * @return
	 */
	function addSubNodeOpenConfigInfo(methodType){
		if(methodType=='1'){
			detailConfigInfo_AddSubNodeFix();
		}else if(methodType=='2'){
			detailConfigInfo_AddSubNodeDocument();
		}else if(methodType=='3'){
			detailConfigInfo_AddSubNodeDataBase();
		}else if(methodType=='5'){
			detailConfigInfo_AddSubNodeExtend();
		}
	}
	
	/**
	 * 新增子节点方式之固定值
	 */
	function detailConfigInfo_AddSubNodeFix(){
		$('#addSubNodeDetailConfigInfoDialogFix').dialog('open');
		content_TypeSelectOption("addSubNodeContent_TypeValueFix");
		$('#addSubNodeContent_TypeValueFix').val("1");
		$("#addSubNodeNodeTypeFix").val("1");
		$('#addSubNodeContent_TypeValueFix').attr("disabled",true);
		$('#addSubNodeContent_TypeValueFix').attr("readonly",true);
		$('#addSubNodeNodeTypeFix').attr("disabled",true);
		$('#addSubNodeNodeTypeFix').attr("readonly",true);		
	}
	
	/**
	 * 新增子节点方式之源报文
	 * @return
	 */
	function detailConfigInfo_AddSubNodeDocument(){
		$('#addSubNodeDetailConfigInfoDialogDocument').dialog('open');
		content_TypeSelectOption("addSubNodeContent_TypeValueDocument");
		$('#addSubNodeContent_TypeValueDocument').val("2");
		$('#addSubNodeContent_TypeValueDocument').attr("disabled",true);
		$('#addSubNodeContent_TypeValueDocument').attr("readonly",true);	
	}
	
	/**
	 * 新增子节点方式之数据库
	 */	
	function detailConfigInfo_AddSubNodeDataBase(){
		$('#addSubNodeDetailConfigInfoDialogDataBase').dialog('open');
		content_TypeSelectOption("addSubNodeContent_TypeValueDataBase");
		$('#addSubNodeContent_TypeValueDataBase').val("3");
		$('#addSubNodeContent_TypeValueDataBase').attr("disabled",true);
		$('#addSubNodeContent_TypeValueDataBase').attr("readonly",true);
	}	
	
	/**
	 * 新增子节点方式之扩展方式
	 */	
	function detailConfigInfo_AddSubNodeExtend(){
		$('#addSubNodeDetailConfigInfoDialogExtend').dialog('open');
		content_TypeSelectOption("addSubNodeContent_TypeValueExtend");
		$('#addSubNodeContent_TypeValueExtend').val("5");
		$('#addSubNodeContent_TypeValueExtend').attr("disabled",true);
		$('#addSubNodeContent_TypeValueExtend').attr("readonly",true);		
	}
	
	/**
	 * 
	 * @return
	 */
	function addSubNodeConfigPathNoPathId(){
		var path_Id = getNewPathId();
		addSubNodeConfigPath(path_Id);
	}
	
	function addSubNodeConfigPath(path_Id){
		var table = document.getElementById("addSubNodeNodeConfigPathTable");
		newrow=table.insertRow(); 
		newrow.id = "addSubNodeNodeConfigPathTableRow_"+path_Id;
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:100%";
		newcell.innerHTML = newcell.innerHTML="<table id=\"addSubNodeXpathTable_"+path_Id+"\" border=\"1\" width=\"100%\">"+generateAddSubNodeXPathConfigTable(path_Id)+"</table>";
		var addSubNode_Join_TypeId="addSubNode_Join_Type_"+path_Id;
		document.getElementById(addSubNode_Join_TypeId).readOnly=true;
		document.getElementById(addSubNode_Join_TypeId).disabled=true;
		var addSubNode_Sort_OrderId="addSubNode_Sort_Order_"+path_Id;
		document.getElementById(addSubNode_Sort_OrderId).readOnly=true;
		document.getElementById(addSubNode_Sort_OrderId).disabled=true;	
		var addSubNode_Pre_Sep_CharsId="addSubNode_Pre_Sep_Chars_"+path_Id;
		document.getElementById(addSubNode_Pre_Sep_CharsId).readOnly=true;
		document.getElementById(addSubNode_Pre_Sep_CharsId).disabled=true;	
		var addSubNode_Suf_Sep_CharsId="addSubNode_Suf_Sep_Chars_"+path_Id;
		document.getElementById(addSubNode_Suf_Sep_CharsId).readOnly=true;
		document.getElementById(addSubNode_Suf_Sep_CharsId).disabled=true;
		selectOptionAdd(addSubNode_Join_TypeId, "字符型", "2");
		document.getElementById(addSubNode_Join_TypeId).Value="2";
	}
	
	/**
	 * 修改具体配置之添加子节点信息
	 * @param node_Id
	 * @param node_Oper_Id
	 * @return
	 */
	function detailConfigInfoModify_AddSubNode(content_type,node_Id,node_Oper_Id){
		if(content_type=='1'){
			//修改具体配置之添加子节点来源于固定方式
			detailConfigInfoModify_AddSubNodeFix(node_Id,node_Oper_Id);
		}else if (content_type=='2'){
			//修改具体配置之添加子节点来源于源报文方式
			detailConfigInfoModify_AddSubNodeDocument(node_Id,node_Oper_Id);
		}else if (content_type=='3'){
			//修改具体配置之添加子节点来源于数据库方式
			detailConfigInfoModify_AddSubNodeDataBase(node_Id,node_Oper_Id);
		}else if (content_type=='5'){
			//修改具体配置之添加子节点来源于扩展方式
			detailConfigInfoModify_AddSubNodeExtend(node_Id,node_Oper_Id);
		}
	}
	
	function detailConfigInfoModify_AddSubNodeFix(node_Id,node_Oper_Id){
		$('#addSubNodeDetailConfigInfoDialogFix').dialog('open');
		var nodeContentConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
					+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
					+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
		var adapterNodeConfigNode = nodeContentConfigNode.parentNode.parentNode;
		var node_Name = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_name");
		var node_Type = getValueFromNodeConfigXml(adapterNodeConfigNode,"node_type");
		var content_Type = getValueFromNodeConfigXml(nodeContentConfigNode,"content_type");
		var fix_Value = getValueFromNodeConfigXml(nodeContentConfigNode,"fix_value");
		content_TypeSelectOption("addSubNodeContent_TypeValueFix");
		$("#addSubNodeNameValueFix").val(node_Name);
		$("#addSubNodeNodeTypeFix").val(node_Type);
		$("#addSubNodeContent_TypeValueFix").val(content_Type);
		$("#addSubNodeFix_ValueFix").val(fix_Value);
		$("#addNodeId").val(node_Id);
		$("#addNodeOperId").val(node_Oper_Id);
		$('#addSubNodeContent_TypeValueFix').attr("disabled",true);
		$('#addSubNodeContent_TypeValueFix').attr("readonly",true);
		$('#addSubNodeNodeTypeFix').attr("disabled",true);
		$('#addSubNodeNodeTypeFix').attr("readonly",true);
		$('#addSubNodeNameValueFix').attr("disabled",true);
		$('#addSubNodeNameValueFix').attr("readonly",true);		
	}
	
	function detailConfigInfoModify_AddSubNodeDocument(node_Id,node_Oper_Id){
		$('#addSubNodeDetailConfigInfoDialogDocument').dialog('open');
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
		content_TypeSelectOption("addSubNodeContent_TypeValueDocument");
		$("#addSubNodeNameValueDocument").val(node_Name);
		$("#addSubNodeNodeTypeDocument").val(node_Type);
		$("#addSubNodeContent_TypeValueDocument").val(content_Type);
		$("#addNodeId").val(node_Id);
		$("#addNodeOperId").val(node_Oper_Id);
		$('#addSubNodeContent_TypeValueDocument').attr("disabled",true);
		$('#addSubNodeContent_TypeValueDocument').attr("readonly",true);
		
		//设置源路径信息显示
		if(nodePathConfigNodes!=null){
			var table = document.getElementById("addSubNodeNodeConfigPathTable");
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
					var addSubNode_Join_TypeId="addSubNode_Join_Type_"+path_Id;
					var addSubNode_Sort_OrderId="addSubNode_Sort_Order_"+path_Id;
					var addSubNode_Pre_Sep_CharsId="addSubNode_Pre_Sep_Chars_"+path_Id;
					var addSubNode_Suf_Sep_CharsId="addSubNode_Suf_Sep_Chars_"+path_Id;
					addSubNodeConfigPath(path_Id);
					document.getElementById(addSubNode_Join_TypeId).value=joint_Type;
					document.getElementById(addSubNode_Sort_OrderId).value=sort_Order;
					document.getElementById(addSubNode_Pre_Sep_CharsId).value=pre_Sep_Chars;
					document.getElementById(addSubNode_Suf_Sep_CharsId).value=suf_Sep_Chars;
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
					var addSubNode_Xml_PathId="addSubNode_Xml_Path_"+path_Id;
					var addSubNode_Join_TypeId="addSubNode_Join_Type_"+path_Id;
					var addSubNode_Sort_OrderId="addSubNode_Sort_Order_"+path_Id;
					var addSubNode_Pre_Sep_CharsId="addSubNode_Pre_Sep_Chars_"+path_Id;
					var addSubNode_Suf_Sep_CharsId="addSubNode_Suf_Sep_Chars_"+path_Id;
					addSubNodeConfigPath(path_Id); 
					document.getElementById(addSubNode_Xml_PathId).value=xml_Path;
					document.getElementById(addSubNode_Join_TypeId).value=joint_Type;
					document.getElementById(addSubNode_Sort_OrderId).value=sort_Order;
					document.getElementById(addSubNode_Pre_Sep_CharsId).value=pre_Sep_Chars;
					document.getElementById(addSubNode_Suf_Sep_CharsId).value=suf_Sep_Chars;
				}				
			}
		}
	}
	
	function detailConfigInfoModify_AddSubNodeDataBase(node_Id,node_Oper_Id){
		$('#addSubNodeDetailConfigInfoDialogDataBase').dialog('open');
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
		content_TypeSelectOption("addSubNodeContent_TypeValueDataBase");
		$("#addSubNodeNameValueDataBase").val(node_Name);
		$("#addSubNodeNodeTypeDataBase").val(node_Type);
		$("#addSubNodeContent_TypeValueDataBase").val(content_Type);
		$("#addSubNodeDataSetIdDataBase").val(data_Set_Id);
		$("#addSubNodeCol_NameDataBase").val(col_Name);
		$("#addNodeId").val(node_Id);
		$("#addNodeOperId").val(node_Oper_Id);
		$('#addSubNodeContent_TypeValueDataBase').attr("disabled",true);
		$('#addSubNodeContent_TypeValueDataBase').attr("readonly",true);
		$('#addSubNodeNodeTypeDataBase').attr("disabled",true);
		$('#addSubNodeNodeTypeDataBase').attr("readonly",true);
		$('#addSubNodeNameValueDataBase').attr("disabled",true);
		$('#addSubNodeNameValueDataBase').attr("readonly",true);	
		//根据扩展方式ID从后台获取querySQL
		var querySQL = getQuerySQL(data_Set_Id);
		$('#addSubNodeQuery_SQLDataBase').val(querySQL);		
	}
	
	function detailConfigInfoModify_AddSubNodeExtend(node_Id,node_Oper_Id){
		$('#addSubNodeDetailConfigInfoDialogExtend').dialog('open');
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
		content_TypeSelectOption("addSubNodeContent_TypeValueExtend");
		$("#addSubNodeNameValueExtend").val(node_Name);
		$("#addSubNodeNodeTypeExtend").val(node_Type);
		$("#addSubNodeContent_TypeValueExtend").val(content_Type);
		$("#addSubNodeMethodIdExtend").val(method_Id);
		$("#addNodeId").val(node_Id);
		$("#addNodeOperId").val(node_Oper_Id);
		$('#addSubNodeContent_TypeValueExtend').attr("disabled",true);
		$('#addSubNodeContent_TypeValueExtend').attr("readonly",true);
		$('#addSubNodeNodeTypeExtend').attr("disabled",true);
		$('#addSubNodeNodeTypeExtend').attr("readonly",true);
		$('#addSubNodeNameValueExtend').attr("disabled",true);
		$('#addSubNodeNameValueExtend').attr("readonly",true);	
		//根据扩展方式ID从后台获取代码片段数据
		var segmentRealize = getSegmentRealize(method_Id);
		$('#addSubNodeSegmentRealizeExtend').val(segmentRealize);
	}
	
	/**
	 * 删除具体配置之添加子节点信息
	 * @param node_Id
	 * @param node_Oper_Id
	 * @return
	 */	
	function detailConfigInfoDelete_AddSubNode(content_type,node_Id,node_Oper_Id){
		if(content_type=='1'){
			//删除具体配置之添加子节点来源于固定方式
			detailConfigInfoDelete_AddSubNodeFix(node_Id,node_Oper_Id);
		}else if(content_type=='2'){	
			//删除具体配置之添加子节点来源于源报文
			detailConfigInfoDelete_AddSubNodeDocument(node_Id,node_Oper_Id);
		}else if(content_type=='3'){	
			//删除具体配置之添加子节点来源于数据库
			detailConfigInfoDelete_AddSubNodeDataBase(node_Id,node_Oper_Id);
		}else if(content_type=='5'){
			//删除具体配置之添加子节点来源于扩展方式
			detailConfigInfoDelete_AddSubNodeExtend(node_Id,node_Oper_Id);			
		}
		var currentNodeId = $('#currentNodeId').val();
		var adapterId = $('#adapterId').val();
		targetDoucumentNodeOnClick(currentNodeId,adapterId);		
	}
	
	function detailConfigInfoDelete_AddSubNodeFix(node_Id,node_Oper_Id){
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
	
	function detailConfigInfoDelete_AddSubNodeDocument(node_Id,node_Oper_Id){
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
	
	function detailConfigInfoDelete_AddSubNodeDataBase(node_Id,node_Oper_Id){
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
	
	function detailConfigInfoDelete_AddSubNodeExtend(node_Id,node_Oper_Id){
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
	 * 保存添加的子节点信息
	 * @param type 值生成方式类型 1.固定值 2.源报文 3.数据库
	 * @return
	 */
	function addSubNodeSaveConfigInfo(type){
		if(type=='1'){
			if($('#currentClickOperate').val()=='addSubNode'){
				addSubNodeSaveConfigInfoFix();
			}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}
			$('#addSubNodeDetailConfigInfoDialogFix').dialog('close');
		}else if(type=='2'){
			if($('#currentClickOperate').val()=='addSubNode'){
				addSubNodeSaveConfigInfoDocument();
			}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
				//saveProcotolAdapter();
				addSubNodeSaveConfigInfoModify_Document();
			}
			$('#addSubNodeDetailConfigInfoDialogDocument').dialog('close');
		}else if(type=='3'){
			if($('#currentClickOperate').val()=='addSubNode'){
				addSubNodeSaveConfigInfoDataBase();
			}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}
			$('#addSubNodeDetailConfigInfoDialogDataBase').dialog('close');
		}else if(type=='5'){
			if($('#currentClickOperate').val()=='addSubNode'){
				addSubNodeSaveConfigInfoExtend();
			}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}
			$('#addSubNodeDetailConfigInfoDialogExtend').dialog('close');			
		}
		//重新触发点击currentNodeId事件
		var currentNodeId = $('#currentNodeId').val();
		var adapterId = $('#adapterId').val();
		targetDoucumentNodeOnClick(currentNodeId,adapterId);
	}
	
	/**
	 * 新增子节点时将子节点信息保存到xmlAdapterConfigDoc 配置信息XML中
	 * @param node_Id
	 * @return
	 */
	
	function addSubNodeSaveConfigInfoFix(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML+"/"+document.getElementById("addSubNodeNameValueFix").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="1";
		var node_Type = $("#addSubNodeNodeTypeFix").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#addSubNodeNameValueFix").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#addSubNodeContent_TypeValueFix").val();
		var fix_Value = $("#addFix_Value").val();
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
		nodeContentConfigNode.setAttribute("content_type",$('#addSubNodeContent_TypeValueFix').val());
		
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		//recordJS(xmlAdapterConfigDoc.xml);
		saveProcotolAdapter();
	}
	
	function addSubNodeSaveConfigInfoDocument(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点,再增加
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML+"/"+document.getElementById("addSubNodeNameValueDocument").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="1";
		var node_Type = $("#addSubNodeNodeTypeDocument").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#addSubNodeNameValueDocument").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#addContent_TypeValueDocument").val();
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
		nodeContentConfigNode.setAttribute("content_type",$('#addSubNodeContent_TypeValueDocument').val());
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		//获取页面上的源报文路径
		var table = document.getElementById("addSubNodeNodeConfigPathTable");
		for(var i=0;i<table.rows.length;i++){
			var row = table.rows[i];
			var rowId = row.id;
			var path_IdStartIndex = rowId.indexOf("addSubNodeNodeConfigPathTableRow_");
			var path_Id =rowId.substring(path_IdStartIndex+"addSubNodeNodeConfigPathTableRow_".length,rowId.length);
			var each_Xml_path = document.getElementById("addSubNode_Xml_Path_"+path_Id).value;
			var each_Joint_Type = document.getElementById("addSubNode_Join_Type_"+path_Id).value;
			var each_Sort_Order = document.getElementById("addSubNode_Sort_Order_"+path_Id).value;
			var each_Pre_Sep_Chars = document.getElementById("addSubNode_Pre_Sep_Chars_"+path_Id).value;
			var each_Suf_Sep_Chars = document.getElementById("addSubNode_Suf_Sep_Chars_"+path_Id).value;
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
	
	function addSubNodeSaveConfigInfoModify_Document(){
		//先找到NODE_PATH_CONFIG_COLLECTION路径节点,移除旧节点
		var node_Id=$("#addNodeId").val();
		var node_Oper_Id=$("#addNodeOperId").val();		
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
		var table = document.getElementById("addSubNodeNodeConfigPathTable");
		for(var i=0;i<table.rows.length;i++){
			var row = table.rows[i];
			var rowId = row.id;
			var path_IdStartIndex = rowId.indexOf("addSubNodeNodeConfigPathTableRow_");
			var path_Id =rowId.substring(path_IdStartIndex+"addSubNodeNodeConfigPathTableRow_".length,rowId.length);
			var each_Xml_path = document.getElementById("addSubNode_Xml_Path_"+path_Id).value;
			var each_Joint_Type = document.getElementById("addSubNode_Join_Type_"+path_Id).value;
			var each_Sort_Order = document.getElementById("addSubNode_Sort_Order_"+path_Id).value;
			var each_Pre_Sep_Chars = document.getElementById("addSubNode_Pre_Sep_Chars_"+path_Id).value;
			var each_Suf_Sep_Chars = document.getElementById("addSubNode_Suf_Sep_Chars_"+path_Id).value;
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
	
	function addSubNodeSaveConfigInfoDataBase(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点,再增加
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML+"/"+document.getElementById("addSubNodeNameValueDataBase").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="1";
		var node_Type = $("#addSubNodeNodeTypeDataBase").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#addSubNodeNameValueDataBase").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#addContent_TypeValueDataBase").val();
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
		nodeContentConfigNode.setAttribute("col_name",$('#addSubNodeCol_NameDataBase').val());
		nodeContentConfigNode.setAttribute("data_set_id",$('#addSubNodeDataSetIdDataBase').val());
		nodeContentConfigNode.setAttribute("cont_converter_id","");
		nodeContentConfigNode.setAttribute("auto_add_flag","");
		nodeContentConfigNode.setAttribute("node_id",node_Id);
		nodeContentConfigNode.setAttribute("delete_type","");
		nodeContentConfigNode.setAttribute("content_type",$('#addSubNodeContent_TypeValueDataBase').val());
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		//recordJS(xmlAdapterConfigDoc.xml);
		saveProcotolAdapter();		
	}
	
	function addSubNodeSaveConfigInfoExtend(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点,再增加
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML+"/"+document.getElementById("addSubNodeNameValueExtend").value;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="1";
		var node_Type = $("#addSubNodeNodeTypeExtend").val();
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",$("#addSubNodeNameValueExtend").val());
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
		var content_Type = $("#addContent_TypeValueExtend").val();
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
		nodeContentConfigNode.setAttribute("method_id",$('#addSubNodeMethodIdExtend').val());
		nodeContentConfigNode.setAttribute("fix_value","");
		nodeContentConfigNode.setAttribute("par_data_set_id","");
		nodeContentConfigNode.setAttribute("col_name","");
		nodeContentConfigNode.setAttribute("data_set_id","");
		nodeContentConfigNode.setAttribute("cont_converter_id","");
		nodeContentConfigNode.setAttribute("auto_add_flag","");
		nodeContentConfigNode.setAttribute("node_id",node_Id);
		nodeContentConfigNode.setAttribute("delete_type","");
		nodeContentConfigNode.setAttribute("content_type",$('#addSubNodeContent_TypeValueExtend').val());
		
		//添加NODE_PATH_CONFIG_COLLECTION源报文路径节点
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		//recordJS(xmlAdapterConfigDoc.xml);
		saveProcotolAdapter();		
	}
	
	/**
	 * 动态生成源报文路径表格
	 * @param path_Id
	 * @return
	 */
	function generateAddSubNodeXPathConfigTable(path_Id){
		//addSubNodeConfigPath
		var xpathTable=document.createElement("TABLE");
		newrow=xpathTable.insertRow();
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:20%";
		newcell.innerHTML="<span class=\"text_font_common\">路径：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:60%";
		newcell.colSpan = "2";
		var nodeType = document.getElementById("addSubNodeNodeTypeDocument").value;
		newcell.innerHTML = "<input type='text' id ='addSubNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
			+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:100%;\"/>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:20%";
		if(nodeType==null||nodeType =='0'){
			//newcell.innerHTML = "<input type='text' id ='addSubNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				//+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\"/>"
			//newcell.innerHTML="<a class='button-base button-small' title='测试路径' target='_blank'  "
				//+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:100%;\"/><span class='button-text'>测试路径</span></a>";	
			newcell.innerHTML="";
		}else {
			//newcell.innerHTML = "<input type='text' id ='addSubNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				//+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\"/>"
			newcell.innerHTML="<a class='button-base button-small' title='Delete' target='_blank'  "
				+"onclick=\"deleteXpathConfig('addSubNodeNodeConfigPathTableRow_"+
				+path_Id+"','1')\" style=\"width:100%;\"/><span class='button-text'>Delete</span></a>";
			//+"<a class='button-base button-small' title='测试路径' target='_blank'  "
			//+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/><span class='button-text'>测试路径</span></a>";		
		}			
		//alert(newcell.innerHTML);
		newrow=xpathTable.insertRow(); 
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkAddSubNode_Join_Type_"+path_Id+"' value='' onclick=\"checkBoxAddSunNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">拼接类型：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML="<select id=\"addSubNode_Join_Type_"+path_Id+"\" onblur=\"editAttr('join_type',this.value,"
			+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"></select>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkAddSubNode_Sort_Order_"+path_Id+"' value='' onclick=\"checkBoxAddSunNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">拼接顺序：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='addSubNode_Sort_Order_"+path_Id+"' value='' onblur=\"editAttr('sort_order',this.value,"
			+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\" />";	
		newrow=xpathTable.insertRow();
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkAddSubNode_Pre_Sep_Chars_"+path_Id+"' value='' onclick=\"checkBoxAddSunNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">前缀分隔符：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='addSubNode_Pre_Sep_Chars_"+path_Id+"' value='' onblur=\"editAttr('pre_sep_chars',this.value,"
			+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\"/>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkAddSubNode_Suf_Sep_Chars_"+path_Id+"' value='' onclick=\"checkBoxAddSunNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">后缀分隔符：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='addSubNode_Suf_Sep_Chars_"+path_Id+"' value='' onblur=\"editAttr('suf_sep_chars',this.value,"
			+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\" />";	
		return xpathTable.innerHTML;
	}
	
	/**
	 * 添加子节点来源源报文页面上checkBox选中事件
	 * @param id
	 * @param path_Id
	 * @return
	 */
	function checkBoxAddSunNodePathConfigClick(id,path_Id){
		var addSubNode_Join_TypeId="addSubNode_Join_Type_"+path_Id;
		var addSubNode_Sort_OrderId="addSubNode_Sort_Order_"+path_Id;
		var addSubNode_Pre_Sep_CharsId="addSubNode_Pre_Sep_Chars_"+path_Id;
		var addSubNode_Suf_Sep_CharsId="addSubNode_Suf_Sep_Chars_"+path_Id;
		var checkAddSubNode_Join_TypeId="checkAddSubNode_Join_Type_"+path_Id;
		var checkAddSubNode_Sort_OrderId="checkAddSubNode_Sort_Order_"+path_Id;
		var checkAddSubNode_Pre_Sep_CharsId="checkAddSubNode_Pre_Sep_Chars_"+path_Id;
		var checkAddSubNode_Suf_Sep_CharsId="checkAddSubNode_Suf_Sep_Chars_"+path_Id;		
		if(document.getElementById(id).checked==true){
			if(id==checkAddSubNode_Join_TypeId){
				document.getElementById(addSubNode_Join_TypeId).readOnly=false;
				document.getElementById(addSubNode_Join_TypeId).disabled=false;				
			}else if(id==checkAddSubNode_Sort_OrderId){
				document.getElementById(addSubNode_Sort_OrderId).readOnly=false;
				document.getElementById(addSubNode_Sort_OrderId).disabled=false;					
			}else if(id==checkAddSubNode_Pre_Sep_CharsId){
				document.getElementById(addSubNode_Pre_Sep_CharsId).readOnly=false;
				document.getElementById(addSubNode_Pre_Sep_CharsId).disabled=false;				
			}else if(id==checkAddSubNode_Suf_Sep_CharsId){
				document.getElementById(addSubNode_Suf_Sep_CharsId).readOnly=false;
				document.getElementById(addSubNode_Suf_Sep_CharsId).disabled=false;		
			}
		}else if(document.getElementById(id).checked==false){		
			if(id==checkAddSubNode_Join_TypeId){
				document.getElementById(addSubNode_Join_TypeId).readOnly=true;
				document.getElementById(addSubNode_Join_TypeId).disabled=true;				
			}else if(id==checkAddSubNode_Sort_OrderId){
				document.getElementById(addSubNode_Sort_OrderId).readOnly=true;
				document.getElementById(addSubNode_Sort_OrderId).disabled=true;					
			}else if(id==checkAddSubNode_Pre_Sep_CharsId){
				document.getElementById(addSubNode_Pre_Sep_CharsId).readOnly=true;
				document.getElementById(addSubNode_Pre_Sep_CharsId).disabled=true;				
			}else if(id==checkAddSubNode_Suf_Sep_CharsId){
				document.getElementById(addSubNode_Suf_Sep_CharsId).readOnly=true;
				document.getElementById(addSubNode_Suf_Sep_CharsId).disabled=true;				
			}			
		}	
	}
	
	/**
	 *  添加子节点来源源报文页面上select值改变事件
	 */
	function selectAddSubNodeNodeTypeDocumentChange(object){
		var value = object.value; 
		var table = document.getElementById("addSubNodeNodeConfigPathTable");
		if(value=='0'){
			//树枝节点
			for(var i=table.rows.length-1;i>=0;i--)
				table.deleteRow(i);	
			document.getElementById("addSubNodeNodeConfigPathBtn").style.display='none';
			addSubNodeConfigPathNoPathId();
		}else if(value=='1'){
			//叶子节点
			document.getElementById("addSubNodeNodeConfigPathBtn").style.display='';
			for(var i=table.rows.length-1;i>=0;i--)
				table.deleteRow(i);			
		}
		editAttr("addSubNodeNodeTypeDocument",value,$("#addNodeId").val(),$("#addNodeOperId").val());
	} 
	
	/**
	 * 数据集选择
	 * @return
	 */
	function addSubNodeDataSetChoose(){
		 $("#dataSetManagerIframe").attr("src",document.getElementById("projectRootPath").value+"/adapter/toDataSetManager.shtml");
		 $('#dataSetManagerWin').window('open');
	}
	
	function addSubNodeExtendChoose(){
		 $("#extendManagerIframe").attr("src",document.getElementById("projectRootPath").value+"/adapter/toExtendManager.shtml");
		 $('#extendManagerWin').window('open');		
	}