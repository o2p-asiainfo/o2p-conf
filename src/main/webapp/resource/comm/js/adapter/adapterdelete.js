	/**
	 * 显示删除节点的操作列表
	 * @param id
	 * @return
	 */		
	function showNodeOperateListDeleteCurrent(id){
		var path=id;
		var pathOther = getPathOtherType(path);
		var deleteNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[@xml_path='"
				+path+"' or @xml_path='"+pathOther+"']");
		//alert("delete :"+"/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[@xml_path='"+path+"']");
		if(deleteNodes!=null){
			if(typeof(deleteNodes)== 'undefined')
				return;
			//alert("deleteNodes.length="+modifyNodes.length);
			for (var j=0;j<deleteNodes.length;j++){
				var deleteNode = deleteNodes[j];
				deleteNodeDetail(deleteNode);
			}
		}		
	}
	
	/**
	 * 删除节点配置详细的信息显示
	 * @param node
	 * @return
	 */	
	function deleteNodeDetail(node){
		var operate_Type = node.attributes.getNamedItem("operate_type").text;
		if(operate_Type=='3'){
			var nodeContentNodes = node.selectNodes("./NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG");
			var node_Name = node.attributes.getNamedItem("node_name").text;
			var node_Id = node.attributes.getNamedItem("node_id").text;
			if(nodeContentNodes!=null){
				for(var k=0;k<nodeContentNodes.length;k++){
					var nodeContentNode = nodeContentNodes[k];
					var node_Oper_Id = nodeContentNode.attributes.getNamedItem("node_oper_id").text;
					var content_Type = nodeContentNode.attributes.getNamedItem("content_type").text;
					var table = document.getElementById("nodeOperateList");
					var value = "";
					newrow=table.insertRow();
					newrow.height=20;
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>Delete node</span>";	
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>"+node_Name+"</span>";					
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'>"+value+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:40%";
					//newcell.innerHTML="<span class='text_font_common'></span>";
					//newcell=newrow.insertCell();
					//newcell.style.cssText="width:10%";
					//newcell.innerHTML="<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(3,"
						//+node_Id+","+node_Oper_Id+")'></span>";
					if(content_Type=='')
						content_Type=null;
					newcell.innerHTML="<a class='button-base button-small' title='Edit config' target='_blank' onclick='detailConfigInfoDelete(3,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'><span class='button-text'>Delete config</span>";	
				}				
			}
		}		
	}
	
	function deleteCurrentNode(){
		//先添加APAPTER_NODE_CONFIG节点，再增加NODE_CONTENT_CONFIG节点
		//先判断选中的节点是否在表中有配置了
		var adapterNodeConfigCollectionNode = xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var node_Id = getNewNodeId();
		var node_Oper_Id = getNewNodeOperId();
		var xml_Path = document.getElementById("curSelectNodePath").innerHTML;//"/"+document.getElementById("modifyCurrentNodeValueFix").value;
		var node_Name = document.getElementById("curSelectNodeText").innerHTML;
		var parent_Node_Id=$("#currentParentNodeId").val();
		var operate_Type="3";
		var node_Type = "";
		var adpaerNodeConfigNode;
		adpaerNodeConfigNode = xmlAdapterConfigDoc.createElement("APAPTER_NODE_CONFIG");
		adpaerNodeConfigNode.setAttribute("state","A");
		adpaerNodeConfigNode.setAttribute("xml_path",xml_Path);
		adpaerNodeConfigNode.setAttribute("parent_node_id",parent_Node_Id);
		adpaerNodeConfigNode.setAttribute("operate_type",operate_Type);
		adpaerNodeConfigNode.setAttribute("sort_order","");
		adpaerNodeConfigNode.setAttribute("namespaceuri","");
		adpaerNodeConfigNode.setAttribute("conditional_relation","");
		adpaerNodeConfigNode.setAttribute("node_name",node_Name);
		adpaerNodeConfigNode.setAttribute("qnameflag","");
		adpaerNodeConfigNode.setAttribute("namespaceprefix","");
		adpaerNodeConfigNode.setAttribute("node_type",node_Type);
		adpaerNodeConfigNode.setAttribute("auto_add_flag","");
		adpaerNodeConfigNode.setAttribute("node_id",node_Id);
		adpaerNodeConfigNode.setAttribute("adapter_id",$("#adapterId").val());
		adpaerNodeConfigNode.setAttribute("limittime","");
		adapterNodeConfigCollectionNode=adapterNodeConfigCollectionNode.appendChild(adpaerNodeConfigNode);
		
		var nodeContentConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_CONTENT_CONFIG_COLLECTION");
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
		nodeContentConfigNode.setAttribute("content_type","");
		
		var nodePathConfigCollectionNode;
		nodePathConfigCollectionNode = xmlAdapterConfigDoc.createElement("NODE_PATH_CONFIG_COLLECTION");
		
		nodeContentConfigNode.appendChild(nodePathConfigCollectionNode);
		nodeContentConfigCollectionNode.appendChild(nodeContentConfigNode);	
		adapterNodeConfigCollectionNode.appendChild(nodeContentConfigCollectionNode);
		//recordJS(xmlAdapterConfigDoc.xml);
		saveProcotolAdapter();		
		
		var currentNodeId = $('#currentNodeId').val();
		var adapterId = $('#adapterId').val();
		targetDoucumentNodeOnClick(currentNodeId,adapterId);		
	}
	
	function detailConfigInfoDelete_DeleteCurrentNode(node_Id,node_Oper_Id){
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
			var currentNodeId = $('#currentNodeId').val();
			var adapterId = $('#adapterId').val();
			targetDoucumentNodeOnClick(currentNodeId,adapterId);			
		}		
	}