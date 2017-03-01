	var xmlTarDoc=null;   //目标文档XML结构对象
	var targetDocumentStructure=null;  //目标文档XML树
	var xmlAdapterConfigDoc=null;  //对应数据库中的协议适配信息
	var projectRootPath="";
	
	function testGenerate(adapterId){
		loadProtocolAdapterConfigInfo(adapterId);
		initTargetDoucumentStructure(adapterId);
		refreshTargetDoucumentStructure(adapterId);
	}
	
	/**
	 * 初始化目标文档树结构
	 * @return
	 */
	function initTargetDoucumentStructure(adapterId){
		targetDocumentStructure = new dhtmlXTreeObject("targetDocumentStructure","100%","100%","0");
		projectRootPath = document.getElementById("projectRootPath").value;
		targetDocumentStructure.setImagePath(projectRootPath+"/resource/comm/images/dhtmlxTree/imgs/books/");
		getTreeStructure(adapterId);
		targetDocumentStructure.loadXMLString(xmlTarDoc.xml);
		complementTargetDoucumentStructure();
		targetDocumentStructure.setOnClickHandler(
				function(id){
					targetDoucumentNodeOnClick(id,adapterId);
				})
	}
	
	/**
	 * 刷新目标文档树结构
	 * @return
	 */
	function refreshTargetDoucumentStructure(adapterId){ 
		if(targetDocumentStructure!=null)
			targetDocumentStructure.destructor();
		targetDocumentStructure = new dhtmlXTreeObject("targetDocumentStructure","100%","100%","0");
		projectRootPath = document.getElementById("projectRootPath").value;
		targetDocumentStructure.setImagePath(projectRootPath+"/resource/comm/images/dhtmlxTree/imgs/books/");
		targetDocumentStructure.loadXMLString(xmlTarDoc.xml);
		targetDocumentStructure.setOnClickHandler(
				function(id){
					targetDoucumentNodeOnClick(id,adapterId);
				})	
	}
	
	/**
	 * 对目标文档树结构进行根据数据库节点配置XML信息进行补充
	 * @return
	 */
	function complementTargetDoucumentStructure(){
		var adapter_Node_ConfigCollectionNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION");
		var tempVar =targetDocumentStructure;
		for(var i=0;i<adapter_Node_ConfigCollectionNodes.length;i++){
			var adapter_Node_ConfigCollectionNode = adapter_Node_ConfigCollectionNodes[i];
			var adapter_Node_ConfigNodes = adapter_Node_ConfigCollectionNode.selectNodes("./APAPTER_NODE_CONFIG");
			for(var j=0;j<adapter_Node_ConfigNodes.length;j++){
				var adapter_Node_ConfigNode = adapter_Node_ConfigNodes[j];
				addAdapter_Node_ConfigNodeToTargetDoucument(adapter_Node_ConfigNode);
			}
		}
	}
	
	/**
	 * 将配置文件中的配置信息补充到目标文档树结构
	 * @param node
	 * @return
	 */
	function addAdapter_Node_ConfigNodeToTargetDoucument(node){
		var xml_Path = node.attributes.getNamedItem("xml_path").text;
		var node_Name = node.attributes.getNamedItem("node_name").text;
		//判断当前节点在不在目标文档树结构中
		xml_Path = addBackslashToPath(xml_Path);
		//var targetTreeNode = targetDocumentStructure._globalIdStorageFind(xml_Path);
		var nodeInTarDoc = xmlTarDoc.selectSingleNode("/tree//item/*[@id='"+xml_Path+"']");
		if(nodeInTarDoc==null){	
			//不在则加入目标文档树中
			//先找到父节点然后加入
			var parentIndex = xml_Path.lastIndexOf("/"+name);
			var xml_ParentPath = xml_Path.substring(0,parentIndex);
			//添加到目标文档XML
			var addNodeParentInTarDoc = xmlTarDoc.selectSingleNode("/tree//item/*[@id='"+xml_ParentPath+"']");
			if(addNodeParentInTarDoc!=null){
				/**
				 * 
				 * 
				 *
				 * 
				 */
				var itemNode;
				itemNode=xmlTarDoc.createElement("item");
				itemNode.setAttribute("text",node_Name);
				itemNode.setAttribute("id",xml_Path);
				itemNode.setAttribute("im0",'leaf.gif');
				itemNode.setAttribute("im1",'leaf.gif');
				itemNode.setAttribute("im2",'leaf.gif');
				addNodeParentInTarDoc = addNodeParentInTarDoc.appendChild(itemNode);				
			}
		}
	}
	
	function itemActionHandlerInsertNewItem(id,adapterId){
		targetDoucumentNodeOnClick(id,adapterId);
	}
	
	/**
	 * 将源报文传到后台解析获取树结构
	 * 或直接从后台获取模板的树结构
	 * @return
	 */
	function  getTreeStructure(adapterId){
		var actionUrl = "/adapter/generateTreeStructure.shtml?adapterId="+adapterId;
		var sRet=ajaxInteractive(actionUrl);
		if (xmlTarDoc==null) 
			xmlTarDoc=new ActiveXObject("Microsoft.XMLDOM");
		xmlTarDoc.async=false;
		xmlTarDoc.loadXML(sRet);
		if (xmlTarDoc.parseError.errorCode!=0) {
			alert("错误信息:Open Model "+xmlTarDoc.parseError.reason);
			alert("XML解析出错!错误信息如下:\n\错误代号:"
					+xmlTarDoc.parseError.errorCode
					+"\n\文件:"+xmlTarDoc.parseError.filePos
					+"\n\行:"+xmlTarDoc.parseError.line
					+"\n\字符:"+xmlTarDoc.parseError.linepos
					+"\n\相关信息:"+xmlTarDoc.parseError.reason
					+"\n\srcText:"+xmlTarDoc.parseError.srcText);			
		 	return;
		}			
	}
	
	/**
	 * 获取协议适配ID的相关数据库配置信息
	 * @param adapterId
	 * @return
	 */
	function loadProtocolAdapterConfigInfo(adapterId){
		var actionUrl = "/adapter/getAdapterConfigInfo.shtml?adapterId="+adapterId;
		var sRet=ajaxInteractive(actionUrl);
		if (xmlAdapterConfigDoc==null){
			xmlAdapterConfigDoc=new ActiveXObject("Microsoft.XMLDOM");
			xmlAdapterConfigDoc.setProperty('SelectionLanguage','XPath');
		}
		xmlAdapterConfigDoc.async=false;
		xmlAdapterConfigDoc.loadXML(sRet);
		if (xmlAdapterConfigDoc.parseError.errorCode!=0) {
			alert("错误信息:Open Model "+xmlAdapterConfigDoc.parseError.reason);
			alert("XML解析出错!错误信息如下:\n\错误代号:"
					+xmlAdapterConfigDoc.parseError.errorCode
					+"\n\文件:"+xmlAdapterConfigDoc.parseError.filePos
					+"\n\行:"+xmlAdapterConfigDoc.parseError.line
					+"\n\字符:"+xmlAdapterConfigDoc.parseError.linepos
					+"\n\相关信息:"+xmlAdapterConfigDoc.parseError.reason
					+"\n\srcText:"+xmlAdapterConfigDoc.parseError.srcText);			
		 	return;
		}		
	}	
	
	/**
	 * 树节点单击事件
	 * @param id
	 * @param adapterId
	 * @return
	 */

	function targetDoucumentNodeOnClick(id,adapterId){
		clearPreNodeInfo();
		showNodeBaseInfo(id);
		showNodeOperatelist(id);
	}
	
	/**
	 * 清除上次点击节点的信息
	 * @return
	 */
	function clearPreNodeInfo(){
		var table = document.getElementById("nodeOperateList");
		for(var i=table.rows.length-1;i>=0;i--)
			table.deleteRow(i);
		
	}
	
	/**
	 * 显示有关当前节点的基本信息
	 * @param id
	 * @return
	 */
	function showNodeBaseInfo(id){
		var curSelectNodeText = document.getElementById("curSelectNodeText");
		var curSelectNodePath = document.getElementById("curSelectNodePath");
		var text = targetDocumentStructure.getItemText(id);
		var parendId = targetDocumentStructure.getParentId(id);
		curSelectNodeText.innerHTML=text;
		curSelectNodePath.innerHTML=id;
		//界面隐藏信息
		//获取当前节点在xmlAdapterConfigDoc配置信息XML中的数据
		var path = id;
		var parentPath= parendId;
		var pathOther = getPathOtherType(path);	
		var parentPathOther = getPathOtherType(parentPath);	
		var adapterNodeConfigNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[contains(@xml_path,'"+path
				+"') or contains(@xml_path,'"+pathOther+"')]");	
		var adapterNodeConfigParentNodes = xmlAdapterConfigDoc.selectNodes("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG[contains(@xml_path,'"+parentPath
				+"') or contains(@xml_path,'"+parentPathOther+"')]");
		if(adapterNodeConfigParentNodes.length>0){
			//父节点在xmlAdapterConfigDoc配置信息XML中有配置信息
			//根据父路径查找的父节点的配置的数据目前只允许有一条
			var adapterNodeConfigParentNode = adapterNodeConfigParentNodes[0];
			var parent_Node_Id = getValueFromNodeConfigXml(adapterNodeConfigParentNode,"node_id");
			$("#currentParentNodeConfigFlag").val("true");
			$("#currentParentNodeId").val(parent_Node_Id);
		}else{
			$("#currentParentNodeConfigFlag").val("false");
			$("#currentParentNodeId").val("");
		}		
		if(adapterNodeConfigNodes.length>0){
			//当前节点在xmlAdapterConfigDoc配置信息XML中有配置信息
			$("#currentNodeConfigFlag").val("true");
		}else{
			$("#currentNodeConfigFlag").val("false");
		}
		
		
	}
	
	/**
	 * 显示有关节点的操作信息
	 * @param id
	 * @return
	 */	
	function showNodeOperatelist(id){
		showNodeOperateListAddSub(id);
		showNodeOperateListModifyCurrent(id);
		showNodeOperateListDeleteCurrent(id);		
	}
	
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
					newcell.innerHTML="<span class='text_font_common'>操作类型：添加子节点</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					newcell.innerHTML="<span class='text_font_common'>子节点："+node_Name+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:20%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'>适配方式："+value+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					//newcell.innerHTML="<input type='button' value='查看配置' onclick='showDetailConfigInfoDialog(1,"+node_Id+","+node_Oper_Id+")'>";
					newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(1,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(1,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";					
				}				
			}
		}
	}
	
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
					newcell.style.cssText="width:10%";
					newcell.innerHTML="<span class='text_font_common'>操作类型：修改当前节点</span>";	
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					newcell.innerHTML="<span class='text_font_common'>修改节点："+node_Name+"</span>";						
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'>适配方式："+value+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(2,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'><input type='button' value='删除配置' onclick='detailConfigInfoDelete(2,"
						+content_Type+","+node_Id+","+node_Oper_Id+")'></span>";					
				}				
			}
		}		
	}
	
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
	
	function deleteNodeDetail(node){
		var operate_Type = node.attributes.getNamedItem("operate_type").text;
		if(operate_Type=='3'){
			var nodeContentNodes = node.selectNodes("./NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG");
			var node_Name = node.attributes.getNamedItem("node_name").text;
			var node_Id = node.attributes.getNamedItem("node_id").text;
			var content_Type = node.attributes.getNamedItem("content_type").text;
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
					newcell.style.cssText="width:10%";
					newcell.innerHTML="<span class='text_font_common'>操作类型：删除当前节点</span>";	
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					newcell.innerHTML="<span class='text_font_common'>删除节点："+node_Name+"</span>";					
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'>适配方式："+value+"</span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'><input type='button' value='修改配置' onclick='detailConfigInfoModify(3,"
						+node_Id+","+node_Oper_Id+")'></span>";
					newcell=newrow.insertCell();
					newcell.style.cssText="width:10%";
					value = getCodeValueByCode("content_type",content_Type);
					newcell.innerHTML="<span class='text_font_common'><input type='button' value='删除配置'></span>";						
				}				
			}
		}		
	}
	
	/**
	 * 通过ajax与后数据交互获取信息
	 * @param action
	 * @param xml
	 * @return
	 */
	function ajaxInteractive(action,xml){  
		var sRet="";
		var oXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP");
		oXMLHTTP.open("post",document.getElementById("projectRootPath").value+action,false);
		try{
			if (xml==null)
				oXMLHTTP.send();
			else
				oXMLHTTP.send(xml);
			sRet=oXMLHTTP.responseText;
			//alert(oXMLHTTP.responseText);
		} 
		catch(e) { 
			alert("Error Ocurr in ajaxInteractive "); 
		}
		return sRet;
	}
	
	/**
	 * 根据不同的类型及传入编码返回指定值
	 * @param type
	 * @param code
	 * @return
	 */
	function getCodeValueByCode(type,code){
		var value="";
		if(type=='content_type'){
			if(code=='1'){
				value="固定值";
			}else if(code=='2'){
				value="源报文";
			}else if(code=='3'){
				value="数据库";
			}else if(code=='4'){
				value="条件约束";
			}else if(code=='5'){
				value="扩展方式";
			}			
		}
		return value;
	}
	
	/**
	 * 对于XML路径查询如果原来路径是以/开始的，则返回另一种不以/开始
	 * 对于XML路径查询如果原来路径不是以/开始的，则返回另一种以/开始
	 * @return
	 */
	function getPathOtherType(path){
		var pathOther = "";
		if(path!=null&& path.length>0){
			var start = path.charAt(0);
			if(start=='/'){
				pathOther = path.substr(1,path.length-1);
			}else{
				pathOther = "/"+path;
			}
		}
		return pathOther;
	}
	
	/**
	 * 根据xml_path进行拆分判断是否是子节点
	 * @param xml_path 当前节点的xml_path
	 * @param xml_path 父节点的path
	 * @return
	 */
	function judgeSubNodeOrNot(xml_path,path){
		if (xml_path==null||xml_path=="")
			return "false";
		if (path==null||path=="")
			return "false";	
		var xml_pathStart = xml_path.charAt(0);
		var pathStart = path.charAt(0);
		if(xml_pathStart!="/")
			xml_path="/"+xml_path;
		if(pathStart!="/")
			path="/"+path;		
		var remainStr = xml_path.substring(path.length, xml_path.length);
		/**
		var remainStrStart = path.charAt(0);
		if(remainStrStart=="/")
			remainStr = remainStr.substring(1, remainStr.length);
		*/
		var remainStrArray=remainStr.split("/");
		if(remainStrArray.length==2){
			return "true";
		}else{
			return "false";
		}
	}
	
	/**
	 * 在路径前面加反斜扛
	 * @param xml_path
	 * @return
	 */
	function addBackslashToPath(xml_path){
		if (xml_path==null||xml_path=="")
			return "";		
		var xml_pathStart = xml_path.charAt(0);
		if(xml_pathStart!="/")
			xml_path="/"+xml_path;
		return xml_path;
	}
	
	/**
	 * 打开添加子节点生成方式
	 * @return
	 */
	function openAddSubNodeConifgMethod(){
		$('#addSubNodeMethodChooseDialog').dialog('open');
	}
	
	/**
	 * 打开修改当节点生成方式
	 * @return
	 */
	function openModifyCurrentNodeConifgMethod(){
		$('#modifyCurrentNodeMethodChooseDialog').dialog('open');
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
	 * 修改当前节点生成方式的选择
	 * @return
	 */
	function  modifyCurrentNodeMethodOK(){
		var methodType = $("input[name='modifyCurrentNodeMethodType']:checked").val(); 
		modifyCurrentNodeOpenConfigInfo(methodType);
		$('#modifyCurrentNodeMethodChooseDialog').dialog('close');		
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
		}
	}
	
	/**
	 * 修改当前节点信息打开
	 * @return
	 */
	function modifyCurrentNodeOpenConfigInfo(methodType){
		alert("methodType="+methodType);
		if(methodType=='1'){
			detailConfigInfo_ModifyCurrentNodeFix();
		}else if(methodType=='2'){
			detailConfigInfo_ModifyCurrentNodeDocument();
		}else if(methodType=='3'){
			detailConfigInfo_ModifyCurrentNodeDataBase();
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
	
	function detailConfigInfo_AddSubNodeDataBase(){
		$('#addSubNodeDetailConfigInfoDialogDataBase').dialog('open');
		content_TypeSelectOption("addSubNodeContent_TypeValueDataBase");
		$('#addSubNodeContent_TypeValueDataBase').val("3");
		$('#addSubNodeContent_TypeValueDataBase').attr("disabled",true);
		$('#addSubNodeContent_TypeValueDataBase').attr("readonly",true);
		
	}
	
	function detailConfigInfo_ModifyCurrentNodeDataBase(){
		$('#modifyCurrentNodeDetailConfigInfoDialogDataBase').dialog('open');
		content_TypeSelectOption("modifyCurrentNodeContent_TypeValueDataBase");
		var node_Name =document.getElementById("curSelectNodeText").innerHTML;
		$('#modifyCurrentNodeNameValueDataBase').val(node_Name);
		//alert("node_Name="+node_Name);
		$('#modifyCurrentNodeNameValueDocument').attr("disabled",true);
		$('#modifyCurrentNodeNameValueDocument').attr("readonly",true);			
		$('#modifyCurrentNodeContent_TypeValueDataBase').val("3");
		$('#modifyCurrentNodeContent_TypeValueDataBase').attr("disabled",true);
		$('#modifyCurrentNodeContent_TypeValueDataBase').attr("readonly",true);		
	}
	
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
	 * 修改具体某个配置
	 * @param type  1 表法添加子节中  2 表示修改当前节点  3表示删除当前节点
	 * @param node
	 * @param nodeContentNode
	 * @return
	 */
	function detailConfigInfoModify(type,content_type,node_Id,node_Oper_Id){
		///1,"+node+","+nodeContentNode+"
		alert("type="+type); 
		if(type=='1'){
			detailConfigInfoModify_AddSubNode(content_type,node_Id,node_Oper_Id);
			$('#currentClickOperate').val('addSubNodeModifyDetailConfig');
		}else if(type=='2'){
			detailConfigInfoModify_ModifyCurrentNode(content_type,node_Id,node_Oper_Id);
			$('#currentClickOperate').val('modifyCurrentNodeModifyDetailConfig');
		}
	}

	
	/**
	 * 修改具体配置之添加子节点信息
	 * @param node_Id
	 * @param node_Oper_Id
	 * @return
	 */
	function detailConfigInfoModify_AddSubNode(content_type,node_Id,node_Oper_Id){
		alert("content_type="+content_type);
		if(content_type=='1'){
			//修改具体配置之添加子节点来源于固定方式
			detailConfigInfoModify_AddSubNodeFix(node_Id,node_Oper_Id);
		}else if (content_type=='2'){
			//修改具体配置之添加子节点来源于源报文方式
			detailConfigInfoModify_AddSubNodeDocument(node_Id,node_Oper_Id);
		}else if (content_type=='3'){
			//修改具体配置之添加子节点来源于数据库方式
			detailConfigInfoModify_AddSubNodeDataBase(node_Id,node_Oper_Id);
		}
	}
	
	function detailConfigInfoModify_ModifyCurrentNode(content_type,node_Id,node_Oper_Id){
		alert("content_type="+content_type);
		if(content_type=='1'){
			//修改具体配置之修改当前节点来源于固定方式
			detailConfigInfoModify_ModifyCurrentNodeFix(node_Id,node_Oper_Id);
		}else if (content_type=='2'){
			//修改具体配置之修改当前节点来源于源报文方式
			detailConfigInfoModify_ModifyCurrentNodeDocument(node_Id,node_Oper_Id);
		}else if (content_type=='3'){
			//修改具体配置之修改当前节点来源于数据库方式
			detailConfigInfoModify_ModifyCurrentNodeDataBase(node_Id,node_Oper_Id);
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
	
	/**
	 * 删除具体某个配置
	 * @param type  1 表法添加子节点  2 表示修改当前节点  3表示删除当前节点
	 * @param node
	 * @param nodeContentNode
	 * @return
	 */	
	function detailConfigInfoDelete(type,content_type,node_Id,node_Oper_Id){
		if(type=='1'){
			detailConfigInfoDelete_AddSubNode(content_type,node_Id,node_Oper_Id);
		}else if(type=='2'){
			detailConfigInfoDelete_ModifyCurrentNode(content_type,node_Id,node_Oper_Id);
		}
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
		}
	}
	
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
		}		
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
	
	/**
	 * 根据节点名去配置XML中取值
	 * @param node
	 * @param attrName
	 * @return
	 */
	function getValueFromNodeConfigXml(node,attrName){
		var attrValue = node.attributes.getNamedItem(attrName).text;
		if(attrValue==null)
			attrValue="";
		return attrValue;
	}
	
	/**
	 * 节点值生成方式下拉选项的值
	 * @return
	 */
	function content_TypeSelectOption(objectId){
		selectOptionAdd(objectId, "固定值", "1");
		selectOptionAdd(objectId, "源报文", "2");
		selectOptionAdd(objectId, "数据库", "3");
		selectOptionAdd(objectId, "条件关联", "4");
		selectOptionAdd(objectId, "扩展方式", "5");
	}	
	
	/**
	 * 动态添加select选项
	 * @param objectId
	 * @param sName
	 * @param sValue
	 * @return
	 */
	function selectOptionAdd(objectId, sName, sValue) {
		var oListbox = document.getElementById(objectId);	    
	    var oOption = document.createElement("option");
	    oOption.appendChild(document.createTextNode(sName));
	    if (arguments.length == 3) {
	        oOption.setAttribute("value", sValue);
	    }
	    oListbox.appendChild(oOption);    
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
		}else if(type=='2'){
			if($('#currentClickOperate').val()=='addSubNode'){
				addSubNodeSaveConfigInfoDocument();
			}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
				//saveProcotolAdapter();
				addSubNodeSaveConfigInfoModify_Document();
			}			
		}else if(type=='3'){
			if($('#currentClickOperate').val()=='addSubNode'){
				addSubNodeSaveConfigInfoDataBase();
			}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}			
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
		}else if(type=='2'){
			if($('#currentClickOperate').val()=='modifyCurrentNode'){
				//addSubNodeSaveConfigInfoDocument();
				modifyCurrentNodeSaveConfigInfoDocument();
			}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
				//saveProcotolAdapter();
				modifyCurrentNodeSaveConfigInfoModify_Document();
			}			
		}else if(type=='3'){
			if($('#currentClickOperate').val()=='modifyCurrentNode'){
				//addSubNodeSaveConfigInfoDataBase();
				modifyCurrentNodeSaveConfigInfoDataBase();
			}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
				saveProcotolAdapter();
			}			
		}
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
	
	/**
	 * 编辑属性时将值保存到对应XML节点中
	 * @param attrName
	 * @param attrVal
	 * @param attrObj
	 * @return
	 */
	function editAttr(attrName,attrVal,node_Id,node_Oper_Id,nodeName,path_Id){
		//addSubNode, modifyCurrentNode,deleteCurrentNode,addSubNodeModifyDetailConfig,modifyCurrentNodeModifyDetailConfig,deleteDetailConfig
		if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'||
				$('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
			var nodeContentConfigNode = 
				xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION"
						+"/APAPTER_NODE_CONFIG/NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG[@node_id="
						+node_Id+" and @node_oper_id="+node_Oper_Id+"]");
			if (nodeContentConfigNode == null) {
				alert("无法从XML文件中找到对应节点");
				return;
			}else{
				if(nodeName=="APAPTER_NODE_CONFIG")
					attrNode=nodeContentConfigNode.parentNode.parentNode.attributes.getNamedItem(attrName);
				if(nodeName=="NODE_CONTENT_CONFIG")
					attrNode=nodeContentConfigNode.attributes.getNamedItem(attrName);
				if(nodeName=="NODE_PATH_CONFIG"){
					var nodePathConfigCollectionNode = nodeContentConfigNode.selectSingleNode("./NODE_PATH_CONFIG_COLLECTION");
					var nodePathConfigNode = nodePathConfigCollectionNode.selectSingleNode("./NODE_PATH_CONFIG[@path_id="+path_Id+"]");
					if(nodePathConfigNode!=null)
						attrNode=nodePathConfigNode.attributes.getNamedItem(attrName);
				}
				//angry
				attrVal=attrVal.replace(/"/gi,'&quot;');
				//attrVal=attrVal.replace(/'/gi,'&apos;');
				attrVal=attrVal.replace(/</gi,'&lt;');
				attrVal=attrVal.replace(/>/gi,'&gt;');
				
				attrVal=attrVal.replace(/&apos;/gi,'`0~!apos;');
				attrVal=attrVal.replace(/&quot;/gi,'`0~!quot;');
				attrVal=attrVal.replace(/&lt;/gi,'`0~!lt;');
				attrVal=attrVal.replace(/&gt;/gi,'`0~!gt;');
				attrVal=attrVal.replace(/&amp;/gi,'`0~!amp;');
				attrVal=attrVal.replace(/&/gi,'&amp;');
				attrVal=attrVal.replace(/`0~!/gi,'&');
				if (attrNode!=null&&attrNode.text!=attrVal) {
					attrNode.text=attrVal;
					alert("attrNode.text="+attrNode.text);
				}			
			}			
		}
	}
	
	/**
	 * 取新的APAPTER_NODE_CONFIG的节点ID
	 * @return
	 */
	function getNewNodeId(){
		var actionUrl = "/adapter/getNewNodeId.shtml?";
		var sRet=ajaxInteractive(actionUrl);
		return sRet;
	}
	
	/**
	 * 取新的APAPTER_NODE_CONFIG的节点ID
	 * @return
	 */
	function getNewNodeOperId(){
		var actionUrl = "/adapter/getNewNodeOperId.shtml?";
		var sRet=ajaxInteractive(actionUrl);
		return sRet;
	}
	
	/**
	 * 取新的NODE_PATH_CONFIG的节点ID
	 * @return
	 */	
	function getNewPathId(){
		var actionUrl = "/adapter/getNewPathId.shtml?";
		var sRet=ajaxInteractive(actionUrl);
		return sRet;
	}	
	
	/**
	 * 保存协议配置数据
	 * @return
	 */
	function saveProcotolAdapter(){
		var actionUrl = "/adapter/saveProcotolAdapter.shtml?";
		var sRet=ajaxInteractive(actionUrl,xmlAdapterConfigDoc.xml);
		var retDoc=new ActiveXObject("Microsoft.XMLDOM");
		retDoc.async=false;
		retDoc.loadXML(sRet);
		if (retDoc.parseError.errorCode!=0) {
			alert("保存过程出现错误！\n"+retDoc.parseError.errorCode+sRet);
			return;
		}
		sRet=retDoc.selectSingleNode("//ERROR").text;
		var adapterId=retDoc.selectSingleNode("//protocolAdapter").text;
		retDoc=null;
		if (sRet=="success") {
			alert("操作成功保存！界面将被重新刷新");
			loadProtocolAdapterConfigInfo(adapterId);
			initTargetDoucumentStructure(adapterId);
			refreshTargetDoucumentStructure(adapterId);
			targetDocumentStructure.openItem(document.getElementById("curSelectNodePath").innerHTML);
		}
		else
			alert("保存失败！");			
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
		newcell.style.cssText="width:80%";
		newcell.colSpan = "3";
		var nodeType = document.getElementById("addSubNodeNodeTypeDocument").value;
		if(nodeType==null||nodeType =='0'){
			newcell.innerHTML = "<input type='text' id ='addSubNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"/>"
			+"<span class='text_font_common'><input type='button' value=\"测试路径\"  "
			+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/></span>";			
		}else {
			newcell.innerHTML = "<input type='text' id ='addSubNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				+$("#addNodeId").val()+","+$("#addNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"/>"
			+"<span class='text_font_common'><input type='button' value=\"删除\"  onclick=\"deleteXpathConfig('addSubNodeNodeConfigPathTableRow_"+
			+path_Id+"','1')\" style=\"width:15%;\"/></span>"
			+"<span class='text_font_common'><input type='button' value=\"测试路径\"  "
			+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/></span>";			
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
	
	function generateModifyCurrentNodeXPathConfigTable(path_Id){
		var xpathTable=document.createElement("TABLE");
		newrow=xpathTable.insertRow();
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:20%";
		newcell.innerHTML="<span class=\"text_font_common\">路径：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:80%";
		newcell.colSpan = "3";
		var nodeType = document.getElementById("modifyCurrentNodeNodeTypeDocument").value;
		if(nodeType==null||nodeType =='0'){
			newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"/>"
			+"<span class='text_font_common'><input type='button' value=\"测试路径\"  "
			+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/></span>";			
		}else {
			newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Xml_Path_"+path_Id+"' value='' onblur=\"editAttr('xml_path',this.value,"
				+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"/>"
			+"<span class='text_font_common'><input type='button' value=\"删除\"  onclick=\"deleteXpathConfig('modifyCurrentNodeNodeConfigPathTableRow_"+
			+path_Id+"','2')\" style=\"width:15%;\"/></span>"
			+"<span class='text_font_common'><input type='button' value=\"测试路径\"  "
			+"onclick=\"testXpath(1,"+path_Id+")\" style=\"width:15%;\"/></span>";			
		}			
		//alert(newcell.innerHTML);
		newrow=xpathTable.insertRow(); 
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Join_Type_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">拼接类型：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML="<select id=\"modifyCurrentNode_Join_Type_"+path_Id+"\" onblur=\"editAttr('join_type',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:60%;\"></select>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Sort_Order_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">拼接顺序：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Sort_Order_"+path_Id+"' value='' onblur=\"editAttr('sort_order',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\" />";	
		newrow=xpathTable.insertRow();
		newrow.height=20;
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Pre_Sep_Chars_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">前缀分隔符：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Pre_Sep_Chars_"+path_Id+"' value='' onblur=\"editAttr('pre_sep_chars',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\"/>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='checkbox' id ='checkModifyCurrentNode_Suf_Sep_Chars_"+path_Id+"' value='' onclick=\"checkBoxModifyCurrentNodePathConfigClick(this.id,"+path_Id+")\"/><span class=\"text_font_common\">后缀分隔符：</span>";
		newcell=newrow.insertCell();
		newcell.style.cssText="width:25%";
		newcell.innerHTML = "<input type='text' id ='modifyCurrentNode_Suf_Sep_Chars_"+path_Id+"' value='' onblur=\"editAttr('suf_sep_chars',this.value,"
			+$("#modifyCurrentNodeNodeId").val()+","+$("#modifyCurrentNodeOperId").val()+",'NODE_PATH_CONFIG',"+path_Id+")\" style=\"width:50%;\" />";	
		return xpathTable.innerHTML;		
	}
	
	function deleteXpathConfig(row_Path_Id,deleteType){
		alert("deleteXpathConfig");
		var index=document.getElementById(row_Path_Id).rowIndex;
		var path_IdStartIndex = "";
		var path_Id="";
		var table;
		if(deleteType=='1'){
			path_IdStartIndex = row_Path_Id.indexOf("addSubNodeNodeConfigPathTableRow_");
			path_Id =row_Path_Id.substring(path_IdStartIndex+"addSubNodeNodeConfigPathTableRow_".length,row_Path_Id.length);
			table = document.getElementById("addSubNodeNodeConfigPathTable");
		}else if(deleteType=='2'){
			path_IdStartIndex = row_Path_Id.indexOf("modifyCurrentNodeNodeConfigPathTableRow_");
			path_Id =row_Path_Id.substring(path_IdStartIndex+"modifyCurrentNodeNodeConfigPathTableRow_".length,row_Path_Id.length);
			table = document.getElementById("modifyCurrentNodeNodeConfigPathTable");
		}
		table.deleteRow(index);		
		//删除xmlAdapterConfigDoc中的节点路径
		var nodePathConfigNode = 
			xmlAdapterConfigDoc.selectSingleNode("/PROTOCOL_ADAPTER/APAPTER_NODE_CONFIG_COLLECTION/APAPTER_NODE_CONFIG/"
					+"NODE_CONTENT_CONFIG_COLLECTION/NODE_CONTENT_CONFIG/NODE_PATH_CONFIG_COLLECTION/NODE_PATH_CONFIG"
					+"[@path_id="+path_Id+"]");
		alert(nodePathConfigNode.xml);
		if(nodePathConfigNode!=null)
			nodePathConfigNode.parentNode.removeChild(nodePathConfigNode);
	}
	
	function textXpath(type,path_Id){
		if(type=='1'){
			var value = document.getElementById("addSubNode_Xml_Path_"+path_Id).value;
		}
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
	
	function addSubNodeDataSetChoose(){
		 $("#dataSetManagerIframe").attr("src",document.getElementById("projectRootPath").value+"/adapter/toDataSetManager.shtml");
		 $('#dataSetManagerWin').window('open');
	}
	
	function modifyCurrentNodeDataSetChoose(){
		 $("#dataSetManagerIframe").attr("src",document.getElementById("projectRootPath").value+"/adapter/toDataSetManager.shtml");
		 $('#dataSetManagerWin').window('open');
	}	
	
	function setDataSetValue(data_Set_Id,query_SQL){
		var dataSetManagerIframe = document.getElementById("dataSetManagerIframe").contentWindow;
		var query_SQL = dataSetManagerIframe.document.getElementById("query_SQL_"+data_Set_Id).value;
		if($('#currentClickOperate').val()=='addSubNode'){
			$('#addSubNodeDataSetIdDataBase').val(data_Set_Id);
		}else if($('#currentClickOperate').val()=='modifyCurrentNode'){
			$('#modifyCurrentNodeDataSetIdDataBase').val(data_Set_Id);
		}else if($('#currentClickOperate').val()=='addSubNodeModifyDetailConfig'){
			$('#addSubNodeDataSetIdDataBase').val(data_Set_Id);
		}else if($('#currentClickOperate').val()=='modifyCurrentNodeModifyDetailConfig'){
			$('#modifyCurrentNodeDataSetIdDataBase').val(data_Set_Id);
		}
		$('#dataSetManagerWin').window('close');
	}

	function alertThis(){
		alert('OK');
	}	
	
	/**
	 * 用于测试记录group的页面内容
	 * @return
	 */
	function recordJS(str){
		var array =new Array(2); 
		array[0]= str;
		//alert(array[0]);
		//writeTxt(array);
	}	